import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/LAB/all_labs_model.dart';
import 'package:patient/Models/LAB/all_packages_model.dart';
import 'package:patient/Models/LAB/all_test_model.dart';
import 'package:patient/Models/organ_categories_model.dart';
import 'package:patient/API%20repo/api_end_points.dart';
import 'package:patient/Models/organ_test_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LABProfileController {
  late AllPackagesModel allPackages;
  late AllTestModel allTests;
  late AllLabsModel allLabs;
  late OrganCategroiesModel allOrgans;
  late OrganTestModel organTestModel;
  bool packagesLoading = true;
  bool testloading = true;
  bool labloading = true;
  bool organsLoading = true;

  Future<AllPackagesModel> getallPackages() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: AppEndPoints.get_all_packages,
        params: {'user_id': preferences.getString('user_id'), 'token': Token});
    return AllPackagesModel.fromJson(response);
  }

  Future<OrganCategroiesModel> getallOrgans() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: AppEndPoints.get_organs_categories,
        params: {'user_id': preferences.getString('user_id'), 'token': Token});
    return OrganCategroiesModel.fromJson(response);
  }

  Future<AllTestModel> getallTests() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: AppEndPoints.get_all_test,
        params: {'user_id': preferences.getString('user_id'), 'token': Token});
    return AllTestModel.fromJson(response);
  }

  Future<AllLabsModel> getallLabs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response =
        await PostData(PARAM_URL: AppEndPoints.get_all_labs, params: {
      'user_id': preferences.getString('user_id'),
      'token': Token,
      'city': preferences.getString('city')
    });
    return AllLabsModel.fromJson(response);
  }

  Future<OrganTestModel> getTestbyOrgan(String organid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: AppEndPoints.get_organ_test,
        params: {
          'user_id': preferences.getString('user_id'),
          'token': Token,
          'organ_id': organid
        });
    return OrganTestModel.fromJson(response);
  }
}
