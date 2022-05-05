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
    public static List<Processor__c> getProcess(Integer fromCore, Integer toCore, Integer fromThread, Integer toThread, Integer fromSpeed, Integer toSpeed, Integer fromGen, Integer toGen, String brend){
        String query = 'Select Id, Name, kurs__Price__c From kurs__Processor__c Where ';
        String core = ' kurs__Number_of_cores__c >: fromCore And kurs__Number_of_cores__c <:toCore And ';
        String thread = ' kurs__Number_of_threads__c >:fromThread And kurs__Number_of_threads__c <:toThread And ';
        String speed = ' kurs__Clock_speed__c >:fromSpeed And kurs__Clock_speed__c <:toSpeed And ';
        String generation = ' kurs__Generation__c >: fromGen And kurs__Generation__c <: toGen And ';
        String company = ' kurs__Company__c =: brend';
        return Database.query(query + core + thread + speed + generation + company );
    }
    @AuraEnabled
    public static List<Motherboard__c> getMother(String Soket, Integer M2, Integer fromMMF, Integer toMMF, String Formfactor){
        String query = 'Select Id, Name, kurs__Price__c From kurs__Motherboard__c Where ';
        String socket = 'kurs__Socket__c =: Soket And ';
        String m = 'kurs__M2__c =: M2 And ';
        String mmf = 'kurs__Maximum_Memory_Frequency__c >:fromMMF And kurs__Maximum_Memory_Frequency__c <: toMMF And ';
        String form = 'kurs__Formfactor__c =: Formfactor';
        return Database.query(query + socket + m + mmf + form);
    }
    @AuraEnabled
    public static List<Power_supply__c> getPower(Integer fromPower, Integer toPower, Integer fromNoise, Integer toNoise, Integer fromMaxCon, Integer toMaxCon, String Syst){
        String query = 'Select Id, Name, kurs__Price__c From kurs__Power_supply__c Where ';
        String power = 'kurs__Power__c >: fromPower And kurs__Power__c <: toPower And ';
        String noise = 'kurs__Maximum_noise_level__c >:fromNoise And kurs__Maximum_noise_level__c <:toNoise And ';
        String conectors = 'kurs__Number_of_power_connectors__c >: fromMaxCon And kurs__Number_of_power_connectors__c <: toMaxCon And ';
        String type = 'kurs__Cooling_system__c =: Syst ';
        return Database.query(query + power + noise + conectors + type);
    }
    @AuraEnabled
    public static List<HHD_Disk__c> getHHD(String Type, Integer fromCap, Integer toCap, Integer fromSpeed, Integer toSpeed, Integer fromBuf, Integer toBuf){
        String query = 'Select Id, Name, kurs__Price__c From kurs__HHD_Disk__c Where ';
        String typehhd = 'kurs__Type__c =: Type And ';
        String capacity = 'kurs__Storage_Capacity__c >: fromCap And kurs__Storage_Capacity__c <:toCap And ';
        String speed = 'kurs__Spindle_rotation_speed__c >: fromSpeed And kurs__Spindle_rotation_speed__c <: toSpeed And ';
        String buf = 'kurs__Buffer_capacity__c >: fromBuf And kurs__Buffer_capacity__c <: toBuf';
        return Database.query(query + typehhd + capacity + speed + buf);
    }
    @AuraEnabled
    public static List<SSD_Disk__c> getSSD(String Type, Integer fromCap, Integer toCap, String Formfactor, String Inter ){
        String query = 'Select Id, Name, kurs__Price__c From kurs__SSD_Disk__c Where ';
        String typessd = 'kurs__Type__c =: Type And ';
        String capacity = 'kurs__Capacity__c >: fromCap And kurs__Capacity__c <:toCap And ';
        String interf = 'kurs__Connection_interface__c =: Inter';
        return Database.query(query + typessd + capacity + interf);
    }
    @AuraEnabled
    public static List<RAM__c> getRAM(Integer fromCap, Integer toCap, Integer fromSlot, Integer toSlot, Integer fromFreq, Integer toFreq, String Type){
        String query = 'Select Id, Name, kurs__Price__c From kurs__RAM__c Where ';
        String capacity = 'kurs__Memory_capacity__c >: fromCap And kurs__Memory_capacity__c <:toCap And ';
        String freq = 'kurs__Memory_Clock__c >: fromFreq And kurs__Memory_Clock__c <: toFreq And ';
        String typeram = 'kurs__Type_of_Memory__c =: Type';
        return Database.query(query + capacity + freq  + typeram); 
    }
    @AuraEnabled
    public static List<Video_Card__c> getVideo(String Brend, String Type, Integer fromCap, Integer toCap, Integer fromBit, Integer toBit){
        String query = 'Select Id, Name, kurs__Price__c From kurs__Video_Card__c Where ';
        String company = 'kurs__Company__c =: Brend And ';
        String typevideo = 'kurs__Type_of_Memory__c =: Type And ';
        String capacity = 'kurs__Memory_capacity__c >: fromCap And kurs__Memory_capacity__c <: toCap And ';
        String bit = 'kurs__Memory_bus_bit_depth__c >: fromBit And kurs__Memory_bus_bit_depth__c <: toBit';
        return Database.query(query + company + typevideo + capacity + bit);

    }
    @AuraEnabled
    public static List<Sound_Card__c> getSound(String Type, String Con, Integer fromChan, Integer toChan, String Color){
        String query = 'Select Id, Name, kurs__Price__c From kurs__Sound_Card__c Where ';
        String typesound = 'kurs__Type__c =: Type And ';
        String conn = 'kurs__Connection_interface__c =: Con And ';
        String channel = 'kurs__Channels__c >: fromChan And kurs__Channels__c <: toChan ';
        return Database.query(query + typesound + conn + channel);
    }
    @AuraEnabled
    public static List<Corpus__c> getCorpus(String Type, Integer fromNumFans, Integer toNumFans, String Material){
        String query = 'Select Id, Name, kurs__Price__c From kurs__Corpus__c Where ';
        String typec = 'kurs__Type__c =: Type And ';
        String numFans = 'kurs__Number_of_installed_fans__c >: fromNumFans And kurs__Number_of_installed_fans__c <: toNumFans And ';
        String materialc = 'kurs__Material__c =: Material';
        return Database.query(query + typec + numFans + materialc);
    }
}