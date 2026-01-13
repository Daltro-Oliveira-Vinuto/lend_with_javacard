package card;

import javacard.framework.*;

public class HelloWorld extends Applet {
    public static void install(byte[] bArray, short bOffset, byte bLength) {
        new HelloWorld().register();
    }
    

    public void process(APDU apdu) {
        if (selectingApplet()) {
            return;
        }
        // Retorna apenas sucesso (9000)
    }
}

