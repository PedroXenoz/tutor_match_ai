import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

/// The five UI states used by this screen.
enum ReportUiState { idle, loading, success, empty, error }

/// A report saved in memory only (SIMULATED - no database yet).
class _Report {
  final String title;
  final String tutorName;
  final String category;
  const _Report(this.title, this.tutorName, this.category);
}

/// Report form (DEMO): lets a student report a problem with a tutor session
/// or the platform. Submission is SIMULATED with Future.delayed; nothing is
/// sent to a server or saved to a database.
class ReportFormScreen extends StatefulWidget {
  const ReportFormScreen({super.key});

  @override
  State<ReportFormScreen> createState() => _ReportFormScreenState();
}

class _ReportFormScreenState extends State<ReportFormScreen> {
  static const _categories = [
    'Tutor no-show',
    'Inappropriate behavior',
    'Wrong subject / content',
    'Billing concern',
    'Website problem',
  ];

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _tutorController = TextEditingController();
  final _descController = TextEditingController();

  String? _category;
  ReportUiState _uiState = ReportUiState.idle;
  bool _showList = false; // true = "My Reports" view
  bool _simulateFailure = false; // demo switch to trigger the Error state
  final List<_Report> _reports = [];

  @override
  void dispose() {
    _titleController.dispose();
    _tutorController.dispose();
    _descController.dispose();
    super.dispose();
  }

  // ---------- validators (field-level) ----------
  String? _requireText(String? v, String label, {int min = 1}) {
    final t = v?.trim() ?? '';
    if (t.isEmpty) return 'Please enter $label.';
    if (t.length < min) return '$label must be at least $min characters.';
    return null;
  }

  // ---------- state transitions ----------
  /// Called by the Submit button: validate first, then send.
  Future<void> _submitReport() async {
    if (!_formKey.currentState!.validate()) return;
    await _send();
  }

  /// The simulated request. Also used by the Retry button.
  Future<void> _send() async {
    setState(() => _uiState = ReportUiState.loading);
    try {
      await Future<void>.delayed(const Duration(seconds: 3)); // SIMULATED
      if (_simulateFailure) throw Exception('Simulated failure');
      if (!mounted) return;
      setState(() {
        _reports.add(_Report(
          _titleController.text.trim(),
          _tutorController.text.trim(),
          _category ?? '',
        ));
        _uiState = ReportUiState.success;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _simulateFailure = false; // so Retry can succeed in the demo
        _uiState = ReportUiState.error;
      });
    }
  }

  void _newReport() {
    _formKey.currentState?.reset();
    _titleController.clear();
    _tutorController.clear();
    _descController.clear();
    setState(() {
      _category = null;
      _showList = false;
      _uiState = ReportUiState.idle;
    });
  }

  void _backToForm() => setState(() {
        _showList = false;
        _uiState = ReportUiState.idle;
      });

  void _openReports() => setState(() {
        _showList = true;
        _uiState = _reports.isEmpty ? ReportUiState.empty : ReportUiState.idle;
      });

  // ---------- build ----------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text('Report an Issue'),
        actions: [
          TextButton.icon(
            onPressed: _showList ? _backToForm : _openReports,
            icon: Icon(_showList ? Icons.edit_note : Icons.list_alt,
                color: Colors.white),
            label: Text(_showList ? 'New Report' : 'My Reports',
                style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: _buildBody(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_showList) {
      return _uiState == ReportUiState.empty ? _buildEmpty() : _buildList();
    }
    switch (_uiState) {
      case ReportUiState.success:
        return _buildSuccess();
      case ReportUiState.error:
        return _buildError();
      case ReportUiState.empty: // only reachable from the list view
      case ReportUiState.idle:
      case ReportUiState.loading:
        return _buildForm();
    }
  }

  // ---------- IDLE + LOADING: the form ----------
  Widget _buildForm() {
    final loading = _uiState == ReportUiState.loading;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Tutor Match AI - Report Form',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDark),
          ),
          const SizedBox(height: 4),
          const Text(
            'Demonstration only - submission is simulated.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textMuted),
          ),
          const SizedBox(height: 20),
          AppTextField(
            label: 'Report title',
            controller: _titleController,
            icon: Icons.title,
            enabled: !loading,
            validator: (v) => _requireText(v, 'a report title', min: 5),
          ),
          const SizedBox(height: 16),
          AppTextField(
            label: 'Tutor name (fictional)',
            controller: _tutorController,
            icon: Icons.person_outline,
            enabled: !loading,
            validator: (v) => _requireText(v, 'the tutor name', min: 2),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _category,
            decoration: InputDecoration(
              labelText: 'Category',
              prefixIcon:
                  const Icon(Icons.category_outlined, color: AppColors.primary),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            items: _categories
                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                .toList(),
            onChanged: loading ? null : (v) => setState(() => _category = v),
            validator: (v) => v == null ? 'Please choose a category.' : null,
          ),
          const SizedBox(height: 16),
          AppTextField(
            label: 'Description',
            controller: _descController,
            icon: Icons.description_outlined,
            maxLines: 4,
            enabled: !loading,
            validator: (v) => _requireText(v, 'a description', min: 10),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            activeColor: AppColors.primary,
            title: const Text('Simulate server failure (demo)'),
            subtitle: const Text('Turn on to demonstrate the Error state.'),
            value: _simulateFailure,
            onChanged:
                loading ? null : (v) => setState(() => _simulateFailure = v),
          ),
          const SizedBox(height: 16),
          // onPressed: null disables the button -> no duplicate submissions.
          AppButton(
            label: loading ? 'Submitting...' : 'Submit Report',
            icon: loading ? null : Icons.send,
            onPressed: loading ? null : _submitReport,
          ),
          if (loading) ...[
            const SizedBox(height: 20),
            const Center(child: CircularProgressIndicator(color: AppColors.primary)),
            const SizedBox(height: 8),
            const Text(
              'Submitting your report... (simulated request)',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textMuted),
            ),
          ],
        ],
      ),
    );
  }

  // ---------- SUCCESS ----------
  Widget _buildSuccess() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(Icons.check_circle, color: AppColors.primary, size: 64),
        const SizedBox(height: 12),
        const Text('Report submitted!',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDark)),
        const SizedBox(height: 8),
        const Text(
          'Your report was accepted by the SIMULATED demo. No real record was '
          'saved to a database or sent to a server.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textMuted),
        ),
        const SizedBox(height: 24),
        AppButton(label: 'View My Reports', icon: Icons.list_alt, onPressed: _openReports),
        const SizedBox(height: 12),
        AppButton(label: 'Submit Another Report', outlined: true, onPressed: _newReport),
      ],
    );
  }

  // ---------- ERROR ----------
  Widget _buildError() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(Icons.error_outline, color: Colors.red, size: 64),
        const SizedBox(height: 12),
        const Text('Submission failed',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red)),
        const SizedBox(height: 8),
        const Text(
          'We could not submit your report (simulated failure). Your '
          'answers are still saved - you can retry or edit them.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textMuted),
        ),
        const SizedBox(height: 24),
        AppButton(label: 'Retry', icon: Icons.refresh, onPressed: _send),
        const SizedBox(height: 12),
        AppButton(label: 'Edit Report', outlined: true, onPressed: _backToForm),
      ],
    );
  }

  // ---------- EMPTY ----------
  Widget _buildEmpty() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(Icons.inbox_outlined, color: AppColors.textMuted, size: 64),
        const SizedBox(height: 12),
        const Text('No reports yet',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark)),
        const SizedBox(height: 8),
        const Text(
          'You have not submitted any reports. When you do, they will appear here.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textMuted),
        ),
        const SizedBox(height: 24),
        AppButton(label: 'Create a Report', icon: Icons.add, onPressed: _backToForm),
      ],
    );
  }

  // ---------- LIST (has records) ----------
  Widget _buildList() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('My Reports (demo, in memory)',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDark)),
        const SizedBox(height: 12),
        for (final r in _reports)
          ListTile(
            leading: const Icon(Icons.flag, color: AppColors.primary),
            title: Text(r.title),
            subtitle: Text('${r.category} - Tutor: ${r.tutorName}'),
          ),
        const SizedBox(height: 16),
        AppButton(label: 'New Report', icon: Icons.add, onPressed: _newReport),
      ],
    );
  }
}