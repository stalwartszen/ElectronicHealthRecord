// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract HealthRecord {
    //struct for record of patient
    struct Patients {
        uint256 id;
        address patient;
        string name;
        string email;
        string phone;
        // uint256[] relatives;
        uint256[] consents;
        uint256[] reports;
        uint256[] doctors;
    }

    struct Doctor {
        uint256 id;
        address doctor;
        string name;
        string email;
        string phone;
        uint256[] patients;
    }

    struct Consent {
        uint256 id;
        uint256 patientId;
        uint256 doctorId;
        string description;
        string alttreatments;
        bool dconsent;
        bool pconsent;
        string date;
    }

    // struct Relative {
    //     uint256 id;
    //     address relative;
    //     string name;
    //     string email;
    //     string phone;
    //     uint256[] patients;
    // }

    struct Record {
        uint256 id;
        uint256 patientId;
        string ipfs;
        string description;
        string category;
        string date;
        uint256[] doctors;
    }

    //mapping for patient
    mapping(uint256 => Patients) public patients;

    //mapping for doctor
    mapping(uint256 => Doctor) public doctors;

    //mapping for relative
    // mapping(uint256 => Relative) public relatives;

    //mapping for record
    mapping(uint256 => Record) public records;

    //mapping for patient count
    uint256 public patientCount = 0;

    //mapping for doctor count
    uint256 public doctorCount = 0;

    //mapping for relative count
    uint256 public relativeCount = 0;

    //mapping for record count
    uint256 public recordCount = 0;

    // mapping for consent
    mapping(uint256 => Consent) public consents;

    uint256 public consentCount = 0;

    //function to create patient
    function createPatient(
        address _patient,
        string memory _name,
        string memory _email,
        string memory _phone
    ) public returns (uint256) {
        Patients storage patient = patients[patientCount];

        patient.id = patientCount;
        patient.patient = _patient;
        patient.name = _name;
        patient.email = _email;
        patient.phone = _phone;

        patientCount++;
        return patientCount - 1;
    }

    // function to get all patients instorage
    function getAllPatients() public view returns (Patients[] memory) {
        Patients[] memory _patients = new Patients[](patientCount);
        for (uint256 i = 0; i < patientCount; i++) {
            _patients[i] = patients[i];
        }
        return _patients;
    }

    function getPatientByAddress(
        address _patient
    ) public view returns (Patients memory) {
        for (uint256 i = 0; i < patientCount; i++) {
            if (patients[i].patient == _patient) {
                return patients[i];
            }
        }

        Patients memory patient;
        return patient;
    }

    function getDoctorByAddress(
        address _doctor
    ) public view returns (Doctor memory) {
        for (uint256 i = 0; i < doctorCount; i++) {
            if (doctors[i].doctor == _doctor) {
                return doctors[i];
            }
        }

        Doctor memory doctor;
        return doctor;
    }

    //function to create doctor
    function createDoctor(
        address _doctor,
        string memory _name,
        string memory _email,
        string memory _phone
    ) public returns (uint256) {
        Doctor storage doctor = doctors[doctorCount];

        doctor.id = doctorCount;
        doctor.doctor = _doctor;
        doctor.name = _name;
        doctor.email = _email;
        doctor.phone = _phone;

        doctorCount++;
        return doctorCount - 1;
    }

    // function to get all doctors instorage
    function getAllDoctors() public view returns (Doctor[] memory) {
        Doctor[] memory _doctors = new Doctor[](doctorCount);
        for (uint256 i = 0; i < doctorCount; i++) {
            _doctors[i] = doctors[i];
        }
        return _doctors;
    }

    //function to create relative
    // function createRelative(
    //     address _relative,
    //     string memory _name,
    //     string memory _email,
    //     string memory _phone
    // ) public returns (uint256) {
    //     Relative storage relative = relatives[relativeCount];

    //     relative.id = relativeCount;
    //     relative.relative = _relative;
    //     relative.name = _name;
    //     relative.email = _email;
    //     relative.phone = _phone;

    //     relativeCount++;
    //     return relativeCount - 1;
    // }

    // function to get all relatives instorage
    // function getAllRelatives()
    //     public
    //     view
    //     returns (Relative[] memory)
    // {
    //     Relative[] memory _relatives = new Relative[](relativeCount);
    //     for (uint256 i = 0; i < relativeCount; i++) {
    //         _relatives[i] = relatives[i];
    //     }
    //     return _relatives;
    // }

    //function to create record
    function createRecord(
        uint256 _patientId,
        uint256 _doctorId,
        string memory _ipfs,
        string memory _date,
        string memory _description,
        string memory _category
    ) public returns (uint256) {
        Record storage record = records[recordCount];

        record.id = recordCount;
        record.patientId = _patientId;
        record.doctors.push(_doctorId);
        record.ipfs = _ipfs;
        record.date = _date;
        record.description = _description;
        record.category = _category;

        Patients storage patient = patients[_patientId];
        patient.reports.push(recordCount);

        recordCount++;
        return recordCount - 1;
    }

    // function add relative to patient
    // function addRelativeToPatient(uint256 _patientId, uint256 _relativeId)
    //     public
    //     returns (bool)
    // {
    //     Patients storage patient = patients[_patientId];
    //     patient.relatives.push(_relativeId);

    //     Relative storage relative = relatives[_relativeId];
    //     relative.patients.push(_patientId);

    //     return true;
    // }

    // function to get all relatives of patient
    // function getRelativesOfPatient(uint256 _patientId)
    //     public
    //     view
    //     returns (Relative[] memory)
    // {
    //     Patients storage patient = patients[_patientId];
    //     Relative[] memory _relatives = new Relative[](patient.relatives.length);
    //     for (uint256 i = 0; i < patient.relatives.length; i++) {
    //         _relatives[i] = relatives[patient.relatives[i]];
    //     }
    //     return _relatives;
    // }

    // function to get all reports of patient
    function getReportsOfPatient(
        uint256 _patientId
    ) public view returns (Record[] memory) {
        Patients storage patient = patients[_patientId];
        Record[] memory _records = new Record[](patient.reports.length);
        for (uint256 i = 0; i < patient.reports.length; i++) {
            _records[i] = records[patient.reports[i]];
        }
        return _records;
    }

    // function to get all patients of doctor
    function getPatientsOfDoctor(
        uint256 _doctorId
    ) public view returns (Patients[] memory) {
        Doctor storage doctor = doctors[_doctorId];
        Patients[] memory _patients = new Patients[](doctor.patients.length);
        for (uint256 i = 0; i < doctor.patients.length; i++) {
            _patients[i] = patients[doctor.patients[i]];
        }
        return _patients;
    }

    // function to get report of the patient if you have access to it if doctor
    function getReportOfPatient(
        uint256 _patientId,
        uint256 _doctorId
    ) public view returns (Record[] memory) {
        Patients storage patient = patients[_patientId];
        Record[] memory _records = new Record[](patient.reports.length);

        for (uint256 i = 0; i < patient.reports.length; i++) {
            Record storage record = records[patient.reports[i]];
            for (uint256 j = 0; j < record.doctors.length; j++) {
                if (record.doctors[j] == _doctorId) {
                    _records[i] = record;
                }
            }
        }
        return _records;
    }

    // function to get all doctors of patient
    function getDoctorsOfPatient(
        uint256 _patientId
    ) public view returns (Doctor[] memory) {
        Patients storage patient = patients[_patientId];
        Doctor[] memory _doctors = new Doctor[](patient.doctors.length);
        for (uint256 i = 0; i < patient.doctors.length; i++) {
            _doctors[i] = doctors[patient.doctors[i]];
        }
        return _doctors;
    }

    // function to add doctor to patient
    function addDoctorToPatient(
        uint256 _patientId,
        uint256 _doctorId
    ) public returns (bool) {
        Patients storage patient = patients[_patientId];
        patient.doctors.push(_doctorId);

        Doctor storage doctor = doctors[_doctorId];
        doctor.patients.push(_patientId);

        return true;
    }

    // function to add doctor to record
    function addDoctorToRecord(
        uint256 _recordId,
        uint256 _doctorId
    ) public returns (bool) {
        Record storage record = records[_recordId];
        record.doctors.push(_doctorId);

        return true;
    }

    // function to get all records of doctor
    function getRecordsOfDoctor(
        uint256 _doctorId
    ) public view returns (Record[] memory) {
        Record[] memory _records = new Record[](recordCount);

        for (uint256 i = 0; i < recordCount; i++) {
            Record storage record = records[i];
            for (uint256 j = 0; j < record.doctors.length; j++) {
                if (record.doctors[j] == _doctorId) {
                    _records[i] = record;
                }
            }
        }

        return _records;
    }

    function createConsent(
        uint256 _patientid,
        uint256 _doctorid,
        string memory _description,
        string memory _alttreatments,
        bool _dconsent,
        bool _pconsent,
        string memory _date
    ) public returns (uint256) {
        Consent storage consent = consents[consentCount];

        consent.id = consentCount;
        consent.patientId = _patientid;
        consent.doctorId = _doctorid;
        consent.description = _description;
        consent.alttreatments = _alttreatments;
        consent.dconsent = _dconsent;
        consent.pconsent = _pconsent;
        consent.date = _date;

        consentCount++;
        return consentCount - 1;
    }

    function getAllConsentOfPatient(
        uint256 _patientid
    ) public view returns (Consent[] memory) {
        Consent[] memory _consents = new Consent[](consentCount);

        for (uint256 i = 0; i < consentCount; i++) {
            Consent storage consent = consents[i];
            if (consent.patientId == _patientid) {
                _consents[i] = consent;
            }
        }

        return _consents;
    }

    function getAllConsentOfDoctor(
        uint256 _doctorid
    ) public view returns (Consent[] memory) {
        Consent[] memory _consents = new Consent[](consentCount);

        for (uint256 i = 0; i < consentCount; i++) {
            Consent storage consent = consents[i];
            if (consent.doctorId == _doctorid) {
                _consents[i] = consent;
            }
        }

        return _consents;
    }

    function getConsent(
        uint256 _consentid
    ) public view returns (Consent memory) {
        Consent storage consent = consents[_consentid];
        return consent;
    }

    function getRecord(uint256 _recordid) public view returns (Record memory) {
        Record storage record = records[_recordid];
        return record;
    }

    function getPatient(
        uint256 _patientid
    ) public view returns (Patients memory) {
        Patients storage patient = patients[_patientid];
        return patient;
    }

    function getDoctor(uint256 _doctorid) public view returns (Doctor memory) {
        Doctor storage doctor = doctors[_doctorid];
        return doctor;
    }
}
