import { LightningElement } from 'lwc';
import GetProcessorOptions from '@salesforce/apex/MainPage.GetProcessorOptions';
import GetPowerOptions from '@salesforce/apex/MainPage.GetPowerOptions';
import GetHHDOptions from '@salesforce/apex/MainPage.GetHHDOptions';
import GetSSDOptions from '@salesforce/apex/MainPage.GetSSDOptions';
import GetVideoOptions from '@salesforce/apex/MainPage.GetVideoOptions';
import GetSoundOptions from '@salesforce/apex/MainPage.GetSoundOptions';
import GetSoundTypeOptions from '@salesforce/apex/MainPage.GetSoundTypeOptions';
import getProcess from '@salesforce/apex/MainPage.getProcess';
import getMother from '@salesforce/apex/MainPage.getMother';
import getPower from '@salesforce/apex/MainPage.getPower';
import getHHD from '@salesforce/apex/MainPage.getHHD';
import getSSD from '@salesforce/apex/MainPage.getSSD';
import getRAM from '@salesforce/apex/MainPage.getRAM';
import getVideo from '@salesforce/apex/MainPage.getVideo';
import getSound from '@salesforce/apex/MainPage.getSound';
import getCorpus from '@salesforce/apex/MainPage.getCorpus';

export default class Mainpage extends LightningElement {
    procResult;
    powerResult;
    motherResult;
    hhdResult;
    ssdResult;
    ramResult;
    videoResult;
    soundResult;
    corpusResult;
    priceResult;
    finalResult;

    show = false;
    noresult = false;

    procValue = 'AMD';
    procValues;

    powerValue = 'Active';
    powerValues;

    hhdValue = 'Outer';
    hhdValues;

    ssdValue = 'Inner';
    ssdValues;

    videoValue = 'nVidia';
    videoValues;

    soundValue = 'USB 2.0';
    soundValues;

    soundTypeValue = 'Outer Card';
    soundTypeValues;

    minPrice;
    maxPrice;
    
    err;
    
    connectedCallback(){
        GetProcessorOptions()
        .then(res=>this.procValues = res)
        GetPowerOptions()
        .then(res=>this.powerValues = res)
        GetHHDOptions()
        .then(res=>this.hhdValues = res)
        GetSSDOptions()
        .then(res=>this.ssdValues = res)
        GetVideoOptions()
        .then(res=>this.videoValues = res)
        GetSoundOptions()
        .then(res=>this.soundValues = res)
        GetSoundTypeOptions()
        .then(res=>this.soundTypeValues = res)
    }
    get procOptions(){
        return this.optionHelper(this.procValues);
    }
    get powerOptions(){
        return  this.optionHelper(this.powerValues);
    }
    get hhdOptions(){
        return  this.optionHelper(this.hhdValues);
    }
    get ssdOptions(){
        return this.optionHelper(this.ssdValues);
    }
    get videoOptions(){
        return this.optionHelper(this.videoValues);
    }
    get soundOptions(){
        return this.optionHelper(this.soundValues);
    }
    get soundTypeOptions(){
        return this.optionHelper(this.soundTypeValues);
    }
    optionHelper(options){
        if(options){
            let temp = [];
            for(let val of options){
                temp.push({ label: val, value: val})
            }
            return temp;
        }
    }
    // mother max freq 2500 - 2600 1 result and price 1400 to 1600 and standart 2 result
    async checkQuery(){
        this.procResult = await this.procHandling();
        //console.log('PR ' +JSON.stringify(this.procResult)); //its working with await
        this.powerResult = await this.powerHandling();
        this.motherResult = await this.motherHandling();
        this.hhdResult = await this.hhdHandling();
        this.ssdResult = await this.ssdHandling();
        this.ramResult = await this.ramHandling();
        this.videoResult = await this.videoHandling();
        this.soundResult = await this.soundHandling();
        this.corpusResult = await this.corpusHandling();
        this.finalResult = this.groupingData(this.procResult,this.powerResult,this.motherResult,this.hhdResult,this.ssdResult,this.ramResult,this.videoResult,this.soundResult,this.corpusResult);
        console.log('final');
        console.log(this.finalResult);
        if(this.finalResult.length > 0){
            this.show = true;
            this.noresult = false;
        }
        else{
            this.noresult = true;
        }
        
    }
    handleChange(event){
        console.log('val ' + event.detail.value);
        switch(event.target.name){
            case 'proc':
                this.procValue = event.detail.value;
                break;
            case 'power':
                this.powerValue = event.detail.value;
                break;
            case 'hhd':
                this.hhdValue = event.detail.value;
                break;
            case 'ssd':
                this.ssdValue = event.detail.value;
                break;
            case 'video':
                this.videoValue = event.detail.value;
                break;
            case 'soundtype':
                this.soundTypeValue = event.detail.value;
                break;
            case 'soundint':
                this.soundValue = event.detail.value;
                break;
        }
    }

    async procHandling(){
        let data = [];
        let temp = this.template.querySelectorAll("lightning-input[data-active='1']");
        temp.forEach(element => {
            data.push(element.value);
        });
        let result = await getProcess({fromCore:parseInt(data[0]), toCore:parseInt(data[1]), fromThread:parseInt(data[2]), toThread:parseInt(data[3]), fromSpeed:parseInt(data[4]), toSpeed:parseInt(data[5]), fromGen:parseInt(data[6]), toGen:parseInt(data[7]), brend:this.procValue});
        return result;

    }
    async motherHandling(){
        let data = [];
        let temp = this.template.querySelectorAll("lightning-input[data-active='2']");
        temp.forEach(element => {
            data.push(element.value);
        });
        let result = await getMother({Soket: data[0], M2: parseInt(data[1]), fromMMF: parseInt(data[2]), toMMF: parseInt(data[3]), Formfactor: data[4]});
        return result;
    }
    async powerHandling(){
        let data = [];
        let temp = this.template.querySelectorAll("lightning-input[data-active='3']");
        temp.forEach(element => {
            data.push(element.value);
        });
        let result = await getPower({fromPower: parseInt(data[0]), toPower: parseInt(data[1]), fromNoise: parseInt(data[2]), toNoise: parseInt(data[3]), fromMaxCon: parseInt(data[4]),  toMaxCon: parseInt(data[5]), Syst: this.powerValue})
        return result;
    }
    async hhdHandling(){
        let data = [];
        let temp = this.template.querySelectorAll("lightning-input[data-active='4']");
        temp.forEach(element => {
            data.push(element.value);
        });
        let result = await getHHD({Type: this.hhdValue, fromCap: parseInt(data[0]), toCap: parseInt(data[1]), fromSpeed: parseInt(data[2]), toSpeed: parseInt(data[3]), fromBuf: parseInt(data[4]), toBuf: parseInt(data[5])})
        return result;
    }
    async ssdHandling(){
        let data = [];
        let temp = this.template.querySelectorAll("lightning-input[data-active='5']");
        temp.forEach(element => {
            data.push(element.value);
        });
        let result = await getSSD({Type: this.ssdValue, fromCap: parseInt(data[0]), toCap: parseInt(data[1]), Inter: data[2]})
        return result;
    }
    async ramHandling(){
        let data = [];
        let temp = this.template.querySelectorAll("lightning-input[data-active='6']");
        temp.forEach(element => {
            data.push(element.value);
        });
        let result = await getRAM({fromCap: parseInt(data[0]), toCap: parseInt(data[1]), fromFreq: parseInt(data[2]), toFreq: parseInt(data[3]), Type: data[4]});
        return result;
    }
    async videoHandling(){
        let data = [];
        let temp = this.template.querySelectorAll("lightning-input[data-active='7']");
        temp.forEach(element => {
            data.push(element.value);
        });
        let result = await getVideo({Brend: this.videoValue, Type: data[0], fromCap: parseInt(data[1]), toCap: parseInt(data[2]), fromBit: parseInt(data[3]), toBit: parseInt(data[4])})
        return result;
    }
    async soundHandling(){
        let data = [];
        let temp = this.template.querySelectorAll("lightning-input[data-active='8']");
        temp.forEach(element => {
            data.push(element.value);
        });
        let result = await getSound({Type: this.soundTypeValue, Con: this.soundValue, fromChan: parseInt(data[0]), toChan: parseInt(data[1])})
        return result;
    }
    async corpusHandling(){
        let data = [];
        let temp = this.template.querySelectorAll("lightning-input[data-active='9']");
        temp.forEach(element => {
            data.push(element.value);
        });
        let result = await getCorpus({Type: data[0], fromNumFans: parseInt(data[1]), toNumFans: parseInt(data[2]), Material: data[3]})
        return result;
    }
    priceHandling(){
        let data = [];
        let temp = this.template.querySelectorAll("lightning-input[data-active='10']");
        temp.forEach(element => {
            data.push(element.value);
        });
        return data;
    }

    groupingData(proc, power, mother, hhd, ssd, ram, video, sound, corpus){
        let data = [];
        let priceArray = this.priceHandling();
        for(let pr of proc){
            for(let pw of power){
                for(let mr of mother){
                    for(let hd of hhd){
                        for(let sd of ssd){
                            for(let rm of ram){
                                for(let vd of video){
                                    for(let snd of sound){
                                        for(let crp of corpus){
                                            let obj = this.assignObject(pr,pw,mr,hd,sd,rm,vd,snd,crp);
                                            let price = this.sumUp(pr,pw,mr,hd,sd,rm,vd,snd,crp);
                                            if(priceArray[0] < price && priceArray[1] > price){
                                                obj.sum = 'Price: ' + price + '$';
                                                data.push(obj);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return data;
    }
    assignObject(pr,pw,mr,hd,sd,rm,vd,snd,crp){
        let obj ={};
        obj.procResult = "/" + pr.Id;
        obj.powerResult = "/" + pw.Id;
        obj.motherResult = "/" + mr.Id;
        obj.hhdResult = "/" + hd.Id;
        obj.ssdResult = "/" + sd.Id;
        obj.ramResult = "/" + rm.Id;
        obj.videoResult = "/" + vd.Id;
        obj.soundResult = "/" + snd.Id;
        obj.corpusResult = "/" + crp.Id;
        obj.procName = pr.Name;
        obj.powerName = pw.Name;
        obj.motherName = mr.Name;
        obj.hhdName = hd.Name;
        obj.ssdName = sd.Name;
        obj.ramName = rm.Name;
        obj.videoName = vd.Name;
        obj.soundName = snd.Name;
        obj.corpusName = crp.Name;
        return obj;
    }
    sumUp(pr,pw,mr,hd,sd,rm,vd,snd,crp){
        let price = pr.kurs__Price__c + pw.kurs__Price__c + mr.kurs__Price__c + hd.kurs__Price__c + sd.kurs__Price__c + rm.kurs__Price__c + vd.kurs__Price__c + snd.kurs__Price__c + crp.kurs__Price__c;
        return price;
    }
}