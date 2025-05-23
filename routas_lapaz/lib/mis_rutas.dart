import 'package:flutter/material.dart';
import 'package:routas_lapaz/mapa.dart';
import 'package:routas_lapaz/conoce.dart';
import 'package:routas_lapaz/ayuda.dart';
import 'package:routas_lapaz/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
class MisRutas extends StatefulWidget {
  const MisRutas({super.key});

  @override
  State<MisRutas> createState() => _MisRutasState();
}

class _MisRutasState extends State<MisRutas> {
    List<Map<String, dynamic>> _rutasGuardadas = [];
   @override
  void initState() {
    super.initState();
    _cargarRutasGuardadas();
  }

  Future<void> _cargarRutasGuardadas() async {
    final prefs = await SharedPreferences.getInstance();
    final rutasJson = prefs.getStringList('rutas_guardadas') ?? [];

    setState(() {
      _rutasGuardadas = rutasJson
          .map((r) => jsonDecode(r) as Map<String, dynamic>)
          .toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Rutas Guardadas'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: _buildDrawer(context),
      body: _rutasGuardadas.isEmpty
    ? const Center(child: Text('No hay rutas guardadas'))
    : ListView.builder(
        itemCount: _rutasGuardadas.length,
        itemBuilder: (context, index) {
          final ruta = _rutasGuardadas[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(ruta['nombre'] ?? 'Ruta sin nombre'),
              subtitle: Text(
                ruta['fecha'] != null
                    ? DateTime.parse(ruta['fecha']).toLocal().toString()
                    : '',
              ),
              trailing: const Icon(Icons.map),
              onTap: () => _abrirRutaEnMapa(ruta),
            ),
          );
        },
      ),

    );
  }
void _abrirRutaEnMapa(Map<String, dynamic> ruta) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => MapaLaPaz(
        medio: ruta['medio'],
        rutaGuardada: ruta,
      ),
    ),
  );
}

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF3D8B7D),
            ),
            child: Text(
              'Opciones de Rutas',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          _buildMenuItem(
            context,
            icon: Icons.directions_walk,
            title: 'Recorrido a pie',
            isActive: false,
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MapaLaPaz(medio: 'foot'),
                ),
              );
            },
          ),
          _buildMenuItem(
            context,
            icon: Icons.directions_car,
            title: 'Recorrido en auto',
            isActive: false,
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MapaLaPaz(medio: 'car'),
                ),
              );
            },
          ),
          _buildMenuItem(
            context,
            icon: Icons.alt_route,
            title: 'Mis Rutas',
            isActive: true, // Resaltar esta opción cuando estemos aquí
            onTap: () => Navigator.pop(context),
          ),
          _buildMenuItem(
            context,
            icon: Icons.info,
            title: 'Conoce más',
            isActive: false,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ConocePage()),
              );
            },
          ),
          _buildMenuItem(
            context,
            icon: Icons.help,
            title: 'Ayuda',
            isActive: false,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AyudaPage()),
              );
            },
          ),
          _buildMenuItem(
            context,
            icon: Icons.exit_to_app,
            title: 'Salir',
            isActive: false,
            onTap: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    bool isHovered = false;
    
    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isActive
                ? const Color(0xFFDBC557) // Color para pestaña activa
                : isHovered
                    ? const Color(0xFFECBDBF) // Color hover
                    : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              leading: Icon(
                icon,
                color: isActive
                  ? const Color(0xFF17584C) // Color icono activo
                  : isHovered
                      ? const Color(0xFF17584C) // Color icono hover
                      : const Color(0xFF3D8B7D), // Color icono normal
              ),
              title: Text(
                title,
                style: TextStyle(
                  color: isActive
                    ? const Color(0xFF17584C) // Color texto activo
                    : isHovered
                        ? const Color(0xFF17584C) // Color texto hover
                        : Colors.black87, // Color texto normal
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              onTap: onTap,
              hoverColor: Colors.transparent,
            ),
          ),
        );
      },
    );
  }
}