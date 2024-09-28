import 'package:flutter/material.dart';
import '../models/application.dart';
import '../repositories/application_repository.dart';
import '../widgets/application _modal.dart';
import '../widgets/application_item.dart';

class ApplicationPage extends StatefulWidget {
  @override
  _ApplicationPageState createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  final ApplicationRepository _repository = ApplicationRepository();
  List<Application> _applications = [];
  Application? _selectedApplication;

  @override
  void initState() {
    super.initState();
    _loadApplications();
  }

  Future<void> _loadApplications() async {
    final applications = await _repository.fetchApplications();
    setState(() {
      _applications = applications;
    });
  }

  void _showModal(Application application) {
    setState(() {
      _selectedApplication = application;
    });
  }

  void _closeModal() {
    setState(() {
      _selectedApplication = null;
    });
  }

  void _withdrawApplication() {
    setState(() {
      _applications.removeWhere((app) => app.id == _selectedApplication?.id);
      _selectedApplication = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('지원 현황')),
      body: _applications.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _applications.length,
        itemBuilder: (context, index) {
          return ApplicationItem(
            application: _applications[index],
            onTap: () => _showModal(_applications[index]),
          );
        },
      ),
      floatingActionButton: _selectedApplication != null
          ? ApplicationModal(
        application: _selectedApplication!,
        onWithdraw: _withdrawApplication,
      )
          : null,
    );
  }
}
