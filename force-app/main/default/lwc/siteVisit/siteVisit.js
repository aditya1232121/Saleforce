import { LightningElement, track } from 'lwc';
import getProject from '@salesforce/apex/SiteController.getProject';
import getTower from '@salesforce/apex/SiteController.getTower';
import getSites from '@salesforce/apex/SiteController.getSites';



export default class SiteVisit extends LightningElement {

@track projectOptions = [] ;
@track towerOptions = [] ; 
@track sites ;

projectId = '' ;
towerName = '' ;


connectedCallback() {
    this.Controller();   // automatic chala ne ke liye
}

async Controller ()
{
    const projectresult = await getProject() ;

    this.projectOptions =  projectresult.map(p => ({
        label : p.Name ,   // seen by user
        value : p.Id  // value stored
    
    }))  ;


    const towerresult = await getTower() ;
    this.towerOptions =  towerresult.map(p => ({
label : p.Name , 
value : p.Id
    })) ;
}

handleProjectChange(event)
{
    this.projectId = event.detail.value ;
}

handleTowerChange(event) {

    this.towerName = event.detail.value ; 
}



async fetchSiteVisits() {
try {
    const result = await getSites ({
        projectId : this.projectId ,
        towerName : this.towerName
    })
    this.sites = result ;
}
catch (err) {
     console.error('Error fetching site visits:', error);
}
}
}