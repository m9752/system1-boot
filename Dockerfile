# system1 배포용 docker image 생성
FROM tomcat9-alpine-jre11:1.0

# server 설정
COPY ./server-setting/*.* /usr/local/tomcat/conf/

# 키파일 설정
COPY ./s1-secure/k.md /usr/local/secure/

# war
COPY ./target/system1.war /usr/local/tomcat/webapps

# java option 추가
#

# docker container의 timezone을 서울로 변경
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 8080포트
EXPOSE 8080
