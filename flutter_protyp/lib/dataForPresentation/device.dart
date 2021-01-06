


import 'package:flutter_protyp/dataForPresentation/service.dart';

class DeviceForPresentation{
  String systeminfo, name, software_rev, ipv4_addr, image, mud_url, mud_signature, documentation;
  List<ServiceForPresentaion> services;
  List<String> allowedDNSRequests;

  DeviceForPresentation(
      this.systeminfo,
      this.name,
      this.software_rev,
      this.ipv4_addr,
      this.image,
      this.mud_url,
      this.mud_signature,
      this.documentation,
      this.services,
      this.allowedDNSRequests);
}