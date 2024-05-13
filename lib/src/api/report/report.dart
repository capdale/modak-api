import 'package:modak/src/api/auth/auth.dart';
import 'package:modak/src/api/endpoint.dart';
import 'package:modak/src/api/report/report_dto.dart';

enum ReportUserType { username, abuse }

enum ReportArticleType { abuse, etc }

class ReportAPI {
  AuthAPI auth;
  Endpoint endpoint;
  ReportAPI(this.auth, this.endpoint);

  Future<void> reportUser(ReportUser reportUser) async {
    await auth.post("${endpoint.baseurl}/report/user", (res) => null,
        body: reportUser.toJson());
  }

  Future<void> reportArticle(ReportArticle reportArticle) async {
    await auth.post("${endpoint.baseurl}/report/article", (res) => null,
        body: reportArticle.toJson());
  }

  Future<void> reportBug(ReportBug reportBug) async {
    await auth.post("${endpoint.baseurl}/report/bug", (res) => null,
        body: reportBug.toJson());
  }

  Future<void> reportHelp(ReportHelp reportHelp) async {
    await auth.post("${endpoint.baseurl}/report/help", (res) => null,
        body: reportHelp.toJson());
  }

  Future<void> reportEtc(ReportEtc reportEtc) async {
    await auth.post("${endpoint.baseurl}/report/etc", (res) => null,
        body: reportEtc.toJson());
  }
}
