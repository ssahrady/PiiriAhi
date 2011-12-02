// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package ee.itcollege.team24.web;

import ee.itcollege.team24.entities.Intsident;
import ee.itcollege.team24.entities.IsikIntsidendis;
import ee.itcollege.team24.entities.Piiririkkuja;
import java.io.UnsupportedEncodingException;
import java.lang.Integer;
import java.lang.Long;
import java.lang.String;
import java.util.Collection;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect IsikIntsidendisController_Roo_Controller {
    
    @RequestMapping(value = "/{isik_intsidendis_ID}", method = RequestMethod.GET)
    public String IsikIntsidendisController.show(@PathVariable("isik_intsidendis_ID") Long isik_intsidendis_ID, Model uiModel) {
        addDateTimeFormatPatterns(uiModel);
        uiModel.addAttribute("isikintsidendis", IsikIntsidendis.findIsikIntsidendis(isik_intsidendis_ID));
        uiModel.addAttribute("itemId", isik_intsidendis_ID);
        return "isikintsidendises/show";
    }
    
    @RequestMapping(method = RequestMethod.GET)
    public String IsikIntsidendisController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            uiModel.addAttribute("isikintsidendises", IsikIntsidendis.findIsikIntsidendisEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) IsikIntsidendis.countIsikIntsidendises() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("isikintsidendises", IsikIntsidendis.findAllIsikIntsidendises());
        }
        addDateTimeFormatPatterns(uiModel);
        return "isikintsidendises/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public String IsikIntsidendisController.update(@Valid IsikIntsidendis isikIntsidendis, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            uiModel.addAttribute("isikIntsidendis", isikIntsidendis);
            addDateTimeFormatPatterns(uiModel);
            return "isikintsidendises/update";
        }
        uiModel.asMap().clear();
        isikIntsidendis.merge();
        return "redirect:/isikintsidendises/" + encodeUrlPathSegment(isikIntsidendis.getIsik_intsidendis_ID().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{isik_intsidendis_ID}", params = "form", method = RequestMethod.GET)
    public String IsikIntsidendisController.updateForm(@PathVariable("isik_intsidendis_ID") Long isik_intsidendis_ID, Model uiModel) {
        uiModel.addAttribute("isikIntsidendis", IsikIntsidendis.findIsikIntsidendis(isik_intsidendis_ID));
        addDateTimeFormatPatterns(uiModel);
        return "isikintsidendises/update";
    }
    
    @RequestMapping(value = "/{isik_intsidendis_ID}", method = RequestMethod.DELETE)
    public String IsikIntsidendisController.delete(@PathVariable("isik_intsidendis_ID") Long isik_intsidendis_ID, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        IsikIntsidendis.findIsikIntsidendis(isik_intsidendis_ID).remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/isikintsidendises";
    }
    
    @ModelAttribute("intsidents")
    public Collection<Intsident> IsikIntsidendisController.populateIntsidents() {
        return Intsident.findAllIntsidents();
    }
    
    @ModelAttribute("isikintsidendises")
    public Collection<IsikIntsidendis> IsikIntsidendisController.populateIsikIntsidendises() {
        return IsikIntsidendis.findAllIsikIntsidendises();
    }
    
    @ModelAttribute("piiririkkujas")
    public Collection<Piiririkkuja> IsikIntsidendisController.populatePiiririkkujas() {
        return Piiririkkuja.findAllPiiririkkujas();
    }
    
    void IsikIntsidendisController.addDateTimeFormatPatterns(Model uiModel) {
        uiModel.addAttribute("isikIntsidendis_avatud_date_format", "dd.MM.yyyy");
        uiModel.addAttribute("isikIntsidendis_muudetud_date_format", "dd.MM.yyyy");
        uiModel.addAttribute("isikIntsidendis_suletud_date_format", "dd.MM.yyyy");
        uiModel.addAttribute("isikIntsidendis_alates_date_format", "dd.MM.yyyy");
        uiModel.addAttribute("isikIntsidendis_kuni_date_format", "dd.MM.yyyy");
    }
    
    String IsikIntsidendisController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        }
        catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}
