

function getPersonGeneral(PFK) {
    $.ajax({

        type: 'GET',
        url: '/LookUpPerson/getPersonGeneralCon',
        data: { PersonFK: PFK }, // according to IE data is undefinded error "0x800a1391 - JavaScript runtime error: 'data' is undefined"
        dataType: "json",
        async: false,
        success: function (data) {
            getFieldValue({ id: 'keyField', value: data.keyfield });
            getFieldValue({ id: 'firstname', value: data.FirstName });
            getFieldValue({ id: 'lastname', value: data.LastName });
            getFieldValue({ id: 'gender', value: data.Gender });
            getFieldValue({ id: 'age', value: data.age });
            getFieldValue({ id: 'primaryPhone', value: data.PrimaryPhone });
            getFieldValue({ id: 'secondaryPhone', value: data.SecondaryPhone });
            getFieldValue({ id: 'SSN', value: data.SSN });
            getFieldValue({ id: 'DoB', value: data.DOB });

        },
        error: function () {
            alert("error:" + data.length)
        }
    })
}

function getPersonChurch(PFK) {
    $.ajax({

        type: 'GET',
        url: '/LookUpPerson/getPersonChurch',
        data: { PersonFK: PFK }, // according to IE data is undefinded error "0x800a1391 - JavaScript runtime error: 'data' is undefined"
        dataType: "json",
        async: false,
        success: function (data) {
            getFieldValue({ id: 'keyField', value: data.keyfield });
            getFieldValue({ id: 'Church', value: data.Church });
            getFieldValue({ id: 'Denomination', value: data.Denomination });

        },
        error: function () {
            alert("error:" + data.length)
        }
    })
}

function getPersonHealth(PFK) {
    $.ajax({

        type: 'GET',
        url: '/LookUpPerson/getPersonHealth',
            data: {PersonFK: PFK }, // according to IE data is undefinded error "0x800a1391 - JavaScript runtime error: 'data' is undefined"
            dataType: "json",
            async: false,
            success: function (data) {
                getFieldValue({ id: 'HealthCondition', value: data.HealthCondition });
                getFieldValue({ id: 'ConditionExplanation', value: data.ConditionExplanation });
                getFieldValue({ id: 'HealthTreatment', value: data.HealthTreatment });
                getFieldValue({ id: 'HasAsthma', value: data.HasAsthma });
                getFieldValue({ id: 'HasSinusitis', value: data.HasSinusitis });
                getFieldValue({ id: 'HasBronchitis', value: data.HasBronchitis });
                getFieldValue({ id: 'HasKidneyTrouble', value: data.HasKidneyTrouble });
                getFieldValue({ id: 'HasHeartTrouble', value: data.HasHeartTrouble });
                getFieldValue({ id: 'HasDiabetes', value: data.HasDiabetes });
                getFieldValue({ id: 'HasDizziness', value: data.HasDizziness });
                getFieldValue({ id: 'HasStomachUpset', value: data.HasStomachUpset });
                getFieldValue({ id: 'HasHayFever', value: data.HasHayFever });
                getFieldValue({ id: 'Explanation', value: data.Explanation });
                getFieldValue({ id: 'PastOperationsOrIllnesses', value: data.PastOperationsOrIllnesses });
                getFieldValue({ id: 'CurrentMeds', value: data.CurrentMeds });
                getFieldValue({ id: 'SpecialDietOrNeeds', value: data.SpecialDietOrNeeds });
                getFieldValue({ id: 'HadChickenPox', value: data.HadChickenPox });
                getFieldValue({ id: 'HadMeasles', value: data.HadMeasles });
                getFieldValue({ id: 'HadMumps', value: data.HadMumps });
                getFieldValue({ id: 'HadWhoopingCough', value: data.HadWhoopingCough });
                getFieldValue({ id: 'OtherChildhoodDiseases', value: data.OtherChildhoodDiseases });
                getFieldValue({ id: 'DateOfTetanusShot', value: data.DateOfTetanusShot });
                getFieldValue({ id: 'FamilyDoctor', value: data.FamilyDoctor });
                getFieldValue({ id: 'FamilyDoctorPhone', value: data.FamilyDoctorPhone });
            },
            error: function () {
            alert("error:" + data.length)
            }
       })
}



function GetSurveyData() {
    $.ajax({
        type: 'GET',
        url: '/BuildSurvey/GetSurveyData',
        data: { surveyId: surveyId },
        dataType: "json",
        async: false,
        success: function (data) {
            for (var i = 0, l = data.Elements.length; i < l; i++) {
                elements.push({
                    SurveyId: surveyId,
                    ElementId: data.Elements[i].ElementId,
                    VersionId: null,    // Stored Procedure will use current version id for update of all non library elements
                    SectionId: data.Elements[i].SectionId,
                    Name: data.Elements[i].Name,
                    ElementNum: data.Elements[i].ElementNum,
                    IsElementNumDisplayed: data.Elements[i].IsElementNumDisplayed,
                    ElementType: data.Elements[i].ElementType.toString(),
                    QuestionType: data.Elements[i].QuestionType.toString(),
                    QuestionStyle: data.Elements[i].QuestionStyle.toString(),
                    Prompt: data.Elements[i].Prompt,
                    DataType: data.Elements[i].DataType.toString(),
                    IsRequired: data.Elements[i].IsRequired,
                    IsVisible: data.Elements[i].IsVisible,
                    MemoRows: data.Elements[i].MemoRows,
                    ResponseAreaWidth: data.Elements[i].ResponseAreaWidth,
                    ResponseAreaLocation: data.Elements[i].ResponseAreaLocation,
                    ResponseAlignment: data.Elements[i].ResponseAlignment.toString(),
                    ResponseOrientation: data.Elements[i].ResponseOrientation.toString(),
                    ResponseSortOrder: data.Elements[i].ResponseSortOrder.toString(),
                    TotalColumns: data.Elements[i].TotalColumns,
                    Font: data.Elements[i].Font,
                    FontUnit: data.Elements[i].FontUnit,
                    FontColor: data.Elements[i].FontColor,
                    AllocationTotal: data.Elements[i].AllocationTotal,
                    AllocationElementDetailId: data.Elements[i].AllocationElementDetailId,
                    IsAllocationTotalDisplayed: data.Elements[i].IsAllocationTotalDisplayed,
                    TextBoxWidth: data.Elements[i].TextBoxWidth,
                    TextBoxPrefix: data.Elements[i].TextBoxPrefix,
                    TextBoxPostfix: data.Elements[i].TextBoxPostfix,
                    IsTextBoxRequired: data.Elements[i].IsTextBoxRequired,
                    MinValue: data.Elements[i].MinValue,
                    MaxValue: data.Elements[i].MaxValue,
                    StartRangeValue: data.Elements[i].StartRangeValue,
                    EndRangeValue: data.Elements[i].EndRangeValue,
                    UseRange: Boolean(data.Elements[i].UseRange),
                    StepValue: data.Elements[i].StepValue,
                    CountDown: data.Elements[i].CountDown,
                    FileName: data.Elements[i].FileName,
                    URL: data.Elements[i].URL,
                    IsDataRetrievedVisible: data.Elements[i].IsDataRetrievedVisible,
                    ShowSaveButton: data.Elements[i].ShowSaveButton,
                    ShowBackButton: data.Elements[i].ShowBackButton,
                    EmailAddresses: data.Elements[i].EmailAddresses,
                    EmailSubject: data.Elements[i].EmailSubject,
                    EmailBody: data.Elements[i].EmailBody,
                    TotalSeconds: data.Elements[i].TotalSeconds,
                    CssId: data.Elements[i].CssId,
                    MatrixTopicColumnWidth: data.Elements[i].MatrixTopicColumnWidth,
                    MatrixTopicFontUnit: data.Elements[i].MatrixTopicFontUnit,
                    MatrixRepeatRowHeading: data.Elements[i].MatrixRepeatRowHeading,
                    LibraryElementId: data.Elements[i].LibraryElementId,
                    DisplayOrder: data.Elements[i].DisplayOrder,
                    CanDelete: data.Elements[i].CanDelete,
                    RIMsg: data.Elements[i].RIMsg,
                    ResponsesJSON: data.Elements[i].ResponsesJSON,
                    ValidationJSON: data.Elements[i].ValidationJSON
                });
            }
        }
    });
}