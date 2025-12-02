import { LightningElement, track } from "lwc";
import getTowers from "@salesforce/apex/CustomController.getTowers";
import getproject from "@salesforce/apex/CustomController.getproject";
import getSiteVisits from "@salesforce/apex/CustomController.getSiteVisits";

export default class Form extends LightningElement {

    @track selectYourProject = [];
    @track selectOption = [];
    @track selectYourTower = [];
    @track sites;

    projectId;
    data;
    towerName;
    visitorName;
    phones; 

    connectedCallback() {
        this.controller();
    }

    projectChange(e) {
        this.projectId = e.detail.value;
        this.loadTowers();
    }

    towerChange(e) {
        this.towerName = e.detail.value;
    }

    optionSelected(e) {
        this.data = e.detail.value;
    }

    async controller() {
        const result = await getproject();
        this.selectYourProject = result.map(p => ({
            label: p.Name,
            value: p.Id
        }));

        this.selectOption = result.map(p => ({
            label: p.Price_Range__c,
            value: p.Price_Range__c
        }));
    }

    async loadTowers() {
        const towerresult = await getTowers({ projectId: this.projectId });
        this.selectYourTower = towerresult.map(p => ({
            label: p.Name,
            value: p.Id
        }));
    }

    async submitButtonHandler() {
        try {
            const result = await getSiteVisits({
                projectId: this.projectId,
                towerName: this.towerName
            });
            this.sites = result;
        } catch (error) {
            console.error("Error fetching site visits:", error);
        }
    }
}
