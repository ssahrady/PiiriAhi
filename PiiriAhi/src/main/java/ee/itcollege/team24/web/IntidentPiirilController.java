package ee.itcollege.team24.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import ee.itcollege.team24.dao.VahtkonnaIntsidendid_dao;
import ee.itcollege.team24.entities.Intsident;
import ee.itcollege.team24.entities.Piiriloik;
import ee.itcollege.team24.entities.Vahtkond;
import ee.itcollege.team24.entities.VahtkondIntsidendis;

@RequestMapping("/intidentpiiril/**")
@Controller
public class IntidentPiirilController {

    @RequestMapping
    public void get(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) {
    }

    @RequestMapping(method = RequestMethod.POST, value = "{id}")
    public void post(@PathVariable Long id, ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) {
    }

    @RequestMapping
    public String index(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) {
    	modelMap.addAttribute("piiriloiks",Piiriloik.findAllPiiriloiks());
    	modelMap.addAttribute("intsidents",Intsident.findAllIntsidents());
    	modelMap.addAttribute("number",Intsident.countIntsidents());
        return "intidentpiiril/index";
    }
    
    @RequestMapping(method = RequestMethod.GET, params = "loik")
    public String displayArea(@RequestParam(value = "loik", required = false) Long loik, Model uiModel) {
    	uiModel.addAttribute("piiriloiks",Piiriloik.findAllPiiriloiks());
    	
    	List<Vahtkond> koikVahtkonnad = Vahtkond.findAllVahtkonds();
    	List<VahtkondIntsidendis> vahtkonnadIntsidendis = VahtkondIntsidendis.findAllVahtkondIntsidendises();
    	List<VahtkonnaIntsidendid_dao> vahtkonnaIntsidendid = new ArrayList<VahtkonnaIntsidendid_dao>();
    	
    	StringBuilder sb = new StringBuilder("");
    	
    	sb.append(" " + "PreForTsükkel");
    	
    	for (Vahtkond vaht : koikVahtkonnad) {
    		
    		sb.append(" " + "JÄRGMINE Vahkondade tsükkel");
    		
    		VahtkonnaIntsidendid_dao intsiVahtkond = new VahtkonnaIntsidendid_dao();
    		
    		sb.append(" " + "VahkondID: " + vaht.getVahtkond_ID());
    		
    		intsiVahtkond.setVahtkond(vaht);
    	
	    	for (VahtkondIntsidendis v: vahtkonnadIntsidendis) {
	    		
	    		sb.append(" " + "JÄRGMINE =? Vahkond intsidendis ID: " + v.getVahtkond().getVahtkond_ID());
	    		
	    		if (vaht.equals(v.getVahtkond())) {
	    			
	    			sb.append(" " + "PROOVIN LISADA!");
	    			sb.append(" IF KONTROLL" + loik + " ==? " +  v.getIntsident().getPiiriloik().getPiiriloik_ID());
	    			//Lisame ainult vastava piiriloigu intsidendid voi kui -1 siis koik
	    			if (loik == -1 || v.getIntsident().getPiiriloik().getPiiriloik_ID() == loik ) {
	    				intsiVahtkond.addIntsident(v.getIntsident());
	    				sb.append(" " + "LISASIN! INTSI KOOD" + v.getIntsident().getKood());
	    			}
	    			
	    		}
	
	    	}
	    	
	    	// Kuvame ainult siis kui antud vahkonnal on sellel piiriloigul intsidente
	    	sb.append(" " + "DAO obj arv: " + intsiVahtkond.getIntsidentideArv());
	    	if(intsiVahtkond.getIntsidentideArv() > 0) {
	    		sb.append(" Lisasin UUE DAO objekti!");
	    		vahtkonnaIntsidendid.add(intsiVahtkond);
	    	}
    	}	
    	
    	uiModel.addAttribute("debugshit", sb.toString());
    	
    	uiModel.addAttribute("vahtIntsidendid", vahtkonnaIntsidendid);
    	uiModel.addAttribute("piiril", loik);
    	
        return "intidentpiiril/index";
    }

    
}
