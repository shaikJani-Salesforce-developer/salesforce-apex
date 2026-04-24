import { LightningElement } from 'lwc';
import { NavigationMixin } from "lightning/navigation";
import { encodeDefaultFieldValues } from 'lightning/pageReferenceUtils';
export default class NavigationMixIn extends NavigationMixin(LightningElement) {

    //navigate to homepage
    handleHomeClick(){
      this[NavigationMixin.Navigate]({
      type: "standard__namedPage",
      attributes: {
          pageName: 'home',
      },
    });
    }
      handleChatterClick(){
      this[NavigationMixin.Navigate]({
      type: "standard__namedPage",
      attributes: {
          pageName: 'chatter',
      },
    });
    } 
      //navigate to account new page
      handleAccNewClick(){
        this[NavigationMixin.Navigate]({
      type: "standard__objectPage",
      attributes: {
        objectApiName: "Account",
        actionName: "new",
      },
    });
      }
      //navigate to account new page with default filled values
      handleAccNewDeClick(){

      const defaultValues= encodeDefaultFieldValues({
        Name : 'Navigation Mixin',
        Rating : 'Hot',
        Industry : 'Banking'
       })

      this[NavigationMixin.Navigate]({
      type: "standard__objectPage",
      attributes: {
        objectApiName: "Account",
        actionName: "new"
      },
       state:{
        defaultFieldValues :defaultValues
       }
      });
      }

   // navigate to list view 
     handleRecentAccClick(){
     
        this[NavigationMixin.Navigate]({
      type: "standard__objectPage",
      attributes: {
        objectApiName: "Account",
        actionName: "list"
      },
       state:{
           filterName : 'Recent'
       }
      });
     }
     //navigate to file content object
     handleFilesClick(){
        this[NavigationMixin.Navigate]({
      type: "standard__objectPage",
      attributes: {
        objectApiName: "ContentDocument",
        actionName: "home",
      },
    });
     }
     //navigate to account record view mode
     handleAccViewClick(){
        this[NavigationMixin.Navigate]({
      type: "standard__recordPage",
      attributes: {
        recordId : '001dL000025U03WQAS',
        objectApiName: "Account",
        actionName: "view",
      },
    });
     }
     //navigate to account record edit mode 
     handleAccEditClick(){
        this[NavigationMixin.Navigate]({
      type: "standard__recordPage",
      attributes: {
        recordId : '001dL000025U03WQAS',
        objectApiName: "Account",
        actionName: "edit",
      },
    });
     }
     //navigate to tab 
     handleTabClick(){
        this[NavigationMixin.Navigate]({
      type: "standard__navItemPage",
      attributes: {
        apiName: "LWC_Basics",
    
      },
    });
     }
     //navigate to the relationship page of the object
     handleRelationClick(){
        this[NavigationMixin.Navigate]({
      type: "standard__recordRelationshipPage",
      attributes: {
        recordId : '001dL000025U03WQAS',
        objectApiName: "Account",
        relationshipApiName :'Contacts',
        actionName: "view",
      },
    });
     }
     //navigate to external web page
     handleWebsiteClick(){
        this[NavigationMixin.Navigate]({
      type: "standard__webPage",
      attributes: {
        url : 'https://www.salesforce.com/in/?ir=1',
      },
    });
     }
}