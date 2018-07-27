FROM cidasdpdasartip.cr.usgs.gov:8447/wma/wma-spring-boot-base:latest

ENV artifact_version=0.0.3-SNAPSHOT
ENV serverPort=7503
ENV aquariusServiceEndpoint=http://ts.nwis.usgs.gov
ENV aquariusServiceUser=apinwisra
ENV HEALTHY_RESPONSE_CONTAINS='{"status":{"code":"UP","description":""}'

RUN ./pull-from-artifactory.sh aqcu-maven-centralized gov.usgs.aqcu aqcu-lookups ${artifact_version} app.jar

HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -k "https://127.0.0.1:${serverPort}${serverContextPath}${HEALTH_CHECK_ENDPOINT}" | grep -q ${HEALTHY_RESPONSE_CONTAINS} || exit 1
