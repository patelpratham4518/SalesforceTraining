<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>opportunity_stage_changed</fullName>
        <description>opportunity stage changed</description>
        <protected>false</protected>
        <recipients>
            <recipient>2100118@gmail.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>patelpratham@mvclouds.sandbox</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Oppurtunity_changed</template>
    </alerts>
    <fieldUpdates>
        <fullName>account_type_change</fullName>
        <field>Type</field>
        <literalValue>New Customer</literalValue>
        <name>account type change</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>account_type_changee</fullName>
        <field>Type</field>
        <literalValue>New Customer</literalValue>
        <name>account type change</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>closedwon</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Closed Won</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>account_type_changee</name>
                <type>FieldUpdate</type>
            </actions>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>stagechange</fullName>
        <actions>
            <name>opportunity_stage_changed</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>AND(ISPICKVAL(PRIORVALUE( StageName ),&quot;Prospecting&quot;),ISPICKVAL(StageName,&apos;Qualification&apos;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
