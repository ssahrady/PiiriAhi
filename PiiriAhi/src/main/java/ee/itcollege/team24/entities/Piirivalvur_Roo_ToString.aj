// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package ee.itcollege.team24.entities;

import java.lang.String;

privileged aspect Piirivalvur_Roo_ToString {
    
    public String Piirivalvur.toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Eesnimed: ").append(getEesnimed()).append(", ");
        sb.append("Perekonnanimi: ").append(getPerekonnanimi()).append(", ");
        sb.append("Piirivalvur_ID: ").append(getPiirivalvur_ID()).append(", ");
        sb.append("Version: ").append(getVersion());
        return sb.toString();
    }
    
}
