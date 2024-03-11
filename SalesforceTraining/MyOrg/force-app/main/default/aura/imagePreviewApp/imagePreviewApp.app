<aura:application>
<aura:attribute name="img64" type="String" default=""/>
<aura:attribute name="imageReference" type="String"/>

<c:imageUpload img64="{!v.img64}" imageReference="{!v.imageReference}"/>
<img src="{!v.imageReference}" alt="" class="image"/>
</aura:application>	
