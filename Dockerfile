FROM cidasdpdasartip.cr.usgs.gov:8447/wma/wma-spring-boot-base:0.0.1

# Pull Artifact
ENV repo_name=aqcu-maven-centralized
ENV artifact_id=aqcu-lookups
ENV artifact_version=0.0.3
RUN ./pull-from-artifactory.sh ${repo_name} gov.usgs.aqcu ${artifact_id} ${artifact_version} app.jar

#Add Launch Script
ADD launch-app.sh launch-app.sh
RUN ["chmod", "+x", "launch-app.sh"]

#Default ENV Values
ENV serverPort=7503
ENV aquariusServiceEndpoint=http://ts.nwis.usgs.gov
ENV aquariusServiceUser=apinwisra
ENV AQUARIUS_SERVICE_PASSWORD_PATH=/aquariusPassword.txt
ENV HEALTHY_RESPONSE_CONTAINS='{"status":{"code":"UP","description":""}'
