all: compile generate_cap

JAVA_BIN :=/usr/lib/jvm/java-8-openjdk-amd64/bin

compile:
	$(JAVA_BIN)/javac -version
	@echo 

	$(JAVA_BIN)/javac -source 1.2 -target 1.2 \
	-cp ~/javacard-sdk-3.0.5/lib/api_classic.jar \
	-d bin \
	src/main/java/card/HelloWorld.java

	@echo "Compilation finished, file *.class created\n"

JC_SDK :=/home/daltro/java_card_kit-2_2_2-rr-bin-linux-do
generate_cap: 
	$(JAVA_BIN)/java -cp \
	$(JC_SDK)/lib/converter.jar:$(JC_SDK)/lib/api.jar \
	com.sun.javacard.converter.Converter \
	-classdir bin \
	-exportpath $(JC_SDK)/api_export_files \
	-applet 0xA0:0x00:0x00:0x00:0x62:0x03:0x01:0x0C:0x01 card.HelloWorld \
	card 0xA0:0x00:0x00:0x00:0x62:0x03:0x01:0x0C 1.0 \
	-noverify

	@echo "*.cap file created with success\n"
	 

java11 :=/opt/java/jdk-11/bin/java
gp := ~/gp_v25.10.20/gp.jar
run_gp :=$(java11) -jar  $(gp)
install_cap:
	$(run_gp) -install bin/card/javacard/card.cap


cap_instance := A00000006203010C01
cap_package := A00000006203010C
delete_cap:
	rm -rf bin/card/*
	$(run_gp) --delete $(cap_instance)
	$(run_gp) --delete $(cap_package)


apdu_1 := 00A4040009A00000006203010C01
apdu_2 := 80010000
send_apdu:
	$(run_gp) -a $(apdu_1) -a $(apdu_2)


list:
	$(run_gp) --list

info:
	$(run_gp) --info