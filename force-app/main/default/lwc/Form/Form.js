import { LightningElement, track } from "lwc";
import getTowers from "@salesforce/apex/CustomController.getTowers";
import getProject from "@salesforce/apex/CustomController.getProject";
import getSiteVisits from "@salesforce/apex/CustomController.getSiteVisits";

export default class Form extends LightningElement {
    @track selectYourProject = [];
    @track selectOption = [];
    @track selectYourTower = [];
    @track sites = [];
    @track error = null;

    projectId = "";
    towerId = "";
    priceValue = "";
    visitorName = "";
    phone = "";
    date = "";

    connectedCallback() {
        this.loadProjects();
    }

    async loadProjects() {
        try {
            const result = await getProject();
            this.selectYourProject = result.map(p => ({
                label: p.Name,
                value: p.Id
            }));

            const prices = result
                .map(p => p.Price_Range__c)
                .filter(v => v)
                .filter((v, i, a) => a.indexOf(v) === i);

            this.selectOption = prices.map(v => ({
                label: v,
                value: v
            }));

            this.error = null;
        } catch {
            this.error = "Unable to load projects";
        }
    }

    projectChange(e) {
        this.projectId = e.detail.value;
        this.loadTowers();
    }

    async loadTowers() {
        try {
            const result = await getTowers({ projectId: this.projectId });
            this.selectYourTower = result.map(t => ({
                label: t.Name,
                value: t.Name   // Use tower Name because Apex expects TowerName
            }));
            this.error = null;
        } catch {
            this.selectYourTower = [];
            this.error = "Unable to load towers";
        }
    }

    towerChange(e) {
        this.towerId = e.detail.value;
    }

    optionSelected(e) {
        this.priceValue = e.detail.value;
    }

    visitorNameChange(e) {
        this.visitorName = e.target.value;
    }

    phoneChange(e) {
        this.phone = e.target.value;
    }

    dateChange(e) {
        this.date = e.target.value;
    }

    async submitButtonHandler() {
        try {
            const result = await getSiteVisits({
                projectId: this.projectId,
                TowerName: this.towerId
            });

            this.sites = result;
            this.error = null;
        } catch {
            this.error = "Unable to fetch site visits";
        }
    }
}
