public without sharing class MainPage {
    public MainPage() {

    }
    @AuraEnabled
    public static List<String> GetProcessorOptions(){
        List<String> so = new List<String>();
        so.add('none');
        for(Schema.PicklistEntry ple:  Processor__c.Company__c.getDescribe().getPicklistValues()){
            so.add(ple.getValue());
        }
        return so;
    }
    @AuraEnabled
    public static List<String> GetPowerOptions(){
        List<String> so = new List<String>();
        so.add('none');
        for(Schema.PicklistEntry ple:  Power_supply__c.Cooling_system__c.getDescribe().getPicklistValues()){
            so.add(ple.getValue());
        }
        return so;
    }
    @AuraEnabled
    public static List<String> GetHHDOptions(){
        List<String> so = new List<String>();
        so.add('none');
        for(Schema.PicklistEntry ple:  HHD_Disk__c.Type__c.getDescribe().getPicklistValues()){
            so.add(ple.getValue());
        }
        return so;
    }
    @AuraEnabled
    public static List<String> GetSSDOptions(){
        List<String> so = new List<String>();
        so.add('none');
        for(Schema.PicklistEntry ple:  SSD_Disk__c.Type__c.getDescribe().getPicklistValues()){
            so.add(ple.getValue());
        }
        return so;
    }
    @AuraEnabled
    public static List<String> GetVideoOptions(){
        List<String> so = new List<String>();
        so.add('none');
        for(Schema.PicklistEntry ple:  Video_Card__c.Company__c.getDescribe().getPicklistValues()){
            so.add(ple.getValue());
        }
        return so;
    }
    @AuraEnabled
    public static List<String> GetSoundOptions(){
        List<String> so = new List<String>();
        so.add('none');
        for(Schema.PicklistEntry ple:  Sound_Card__c.Connection_interface__c.getDescribe().getPicklistValues()){
            so.add(ple.getValue());
        }
        return so;
    }
    @AuraEnabled
    public static List<String> GetSoundTypeOptions(){
        List<String> so = new List<String>();
        so.add('none');
        for(Schema.PicklistEntry ple:  Sound_Card__c.Type__c.getDescribe().getPicklistValues()){
            so.add(ple.getValue());
        }
        return so;
    }
    @AuraEnabled
    public static List<Processor__c> getProcess(Integer fromCore, Integer toCore, Integer fromThread, Integer toThread, String Soket, Integer fromSpeed, Integer toSpeed, Integer fromGen, Integer toGen, String brend){
        String query = 'Select Id, Name, Price__c From Processor__c Where ';
        String core = ' Number_of_cores__c >: fromCore And Number_of_cores__c <:toCore And ';
        String thread = ' Number_of_threads__c >:fromThread And Number_of_threads__c <:toThread And ';
        String speed = ' Clock_speed__c >: fromSpeed And Clock_speed__c <:toSpeed And ';
        String socket= ' Socket__c =: Soket And ';
        String generation = ' Generation__c >: fromGen And Generation__c <: toGen And ';
        String company = ' Company__c =: brend';
        return Database.query(query + core + thread + speed + socket + generation + company );
    }
    @AuraEnabled
    public static List<Motherboard__c> getMother(String Soket, Integer M2, Integer fromMMF, Integer toMMF, String Formfactor){
        String query = 'Select Id, Name, Price__c From Motherboard__c Where ';
        String socket = 'Socket__c =: Soket And ';
        String m = 'M2__c =: M2 And ';
        String mmf = 'Maximum_Memory_Frequency__c >:fromMMF And Maximum_Memory_Frequency__c <: toMMF And ';
        String form = 'Formfactor__c =: Formfactor';
        return Database.query(query + socket + m + mmf + form); //+ m 
    }
    @AuraEnabled
    public static List<Power_supply__c> getPower(Integer fromPower, Integer toPower, Integer fromNoise, Integer toNoise, Integer fromMaxCon, Integer toMaxCon, String Syst, String Formfactor){
        String query = 'Select Id, Name, Price__c From Power_supply__c Where ';
        String power = 'Power__c >: fromPower And Power__c <: toPower And ';
        String noise = 'Maximum_noise_level__c >:fromNoise And Maximum_noise_level__c <:toNoise And ';
        String conectors = 'Number_of_power_connectors__c >: fromMaxCon And Number_of_power_connectors__c <: toMaxCon And ';
        String type = 'Cooling_system__c =: Syst And ';
        String form = 'Formfactor__c =: Formfactor';
        return Database.query(query + power + noise + conectors + type + form);
    }
    @AuraEnabled
    public static List<HHD_Disk__c> getHHD(String Type, Integer fromCap, Integer toCap, Integer fromSpeed, Integer toSpeed, Integer fromBuf, Integer toBuf){
        String query = 'Select Id, Name, Price__c From HHD_Disk__c Where ';
        String typehhd = 'Type__c =: Type And ';
        String capacity = 'Storage_Capacity__c >: fromCap And Storage_Capacity__c <:toCap And ';
        String speed = 'Spindle_rotation_speed__c >: fromSpeed And Spindle_rotation_speed__c <: toSpeed And ';
        String buf = 'Buffer_capacity__c >: fromBuf And Buffer_capacity__c <: toBuf';
        return Database.query(query + typehhd + capacity + speed + buf);
    }
    @AuraEnabled
    public static List<SSD_Disk__c> getSSD(String Type, Integer fromCap, Integer toCap, String Formfactor, String Inter ){
        String query = 'Select Id, Name, Price__c From SSD_Disk__c Where ';
        String typessd = 'Type__c =: Type And ';
        String capacity = 'Capacity__c >: fromCap And Capacity__c <:toCap And ';
        String form = 'Formfactor__c =: Formfactor And ';
        String interf = 'Connection_interface__c =: Inter';
        return Database.query(query + typessd + capacity + form + interf);
    }
    @AuraEnabled
    public static List<RAM__c> getRAM(Integer fromCap, Integer toCap, Integer fromSlot, Integer toSlot, Integer fromFreq, Integer toFreq, String Type){
        String query = 'Select Id, Name, Price__c From RAM__c Where ';
        String capacity = 'Memory_capacity__c >: fromCap And Memory_capacity__c <:toCap And ';
        String slot = 'Number_of_slats__c >: fromSlot And Number_of_slats__c <: toSlot And ';
        String freq = 'Memory_Clock__c >: fromFreq And Memory_Clock__c <: toFreq And ';
        String typeram = 'Type_of_Memory__c =: Type';
        return Database.query(query + capacity + slot + freq  + typeram); 
    }
    @AuraEnabled
    public static List<Video_Card__c> getVideo(String Brend, String Con, String Inter, String Type, Integer fromCap, Integer toCap, Integer fromBit, Integer toBit){
        String query = 'Select Id, Name, Price__c From Video_Card__c Where ';
        String company = 'Company__c =: Brend And ';
        String conection = 'Connectors__c =: Con And ';
        String intervideo = 'Interface__c =:Inter And ';
        String typevideo = 'Type_of_Memory__c =: Type And ';
        String capacity = 'Memory_capacity__c >: fromCap And Memory_capacity__c <: toCap And ';
        String bit = 'Memory_bus_bit_depth__c >: fromBit And Memory_bus_bit_depth__c <: toBit';
        return Database.query(query + company + conection + intervideo + typevideo + capacity + bit);

    }
    @AuraEnabled
    public static List<Sound_Card__c> getSound(String Type, String Con, Integer fromChan, Integer toChan, String Color){
        String query = 'Select Id, Name, Price__c From Sound_Card__c Where ';
        String typesound = 'Type__c =: Type And ';
        String conn = 'Connection_interface__c =: Con And ';
        String channel = 'Channels__c >: fromChan And Channels__c <: toChan And ';
        String colorsound = 'Color__c =: Color';
        return Database.query(query + typesound + conn + channel + colorsound);
    }
    @AuraEnabled
    public static List<Corpus__c> getCorpus(String Type, Integer fromNumFans, Integer toNumFans, String Material){
        String query = 'Select Id, Name, Price__c From Corpus__c Where ';
        String typec = 'Type__c =: Type And ';
        String numFans = 'Number_of_installed_fans__c >: fromNumFans And Number_of_installed_fans__c <: toNumFans And ';
        String materialc = 'Material__c =: Material';
        return Database.query(query + typec + numFans + materialc);
    }
}
