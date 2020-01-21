CREATE TABLE AN_FatturazioneElettronicaHelper(
	FKeyAnagrafica INTEGER NOT NULL CONSTRAINT PKAN_FatturazioneElettronicaHelper PRIMARY KEY,
	CodiceDestinatarioSDI CHAR NOT NULL,
	PEC CHAR NOT NULL,
	Paese CHAR NOT NULL,
    Privato BIT NOT NULL);

CREATE TABLE FE_StatiFattureElettroniche(
	FKeyFattura INTEGER NOT NULL CONSTRAINT PKFE_StatiFattureElettroniche PRIMARY KEY,
	IdSDI DECIMAL NULL
)


 