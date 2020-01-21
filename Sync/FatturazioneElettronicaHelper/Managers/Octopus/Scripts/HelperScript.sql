IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AN_FatturazioneElettronicaHelper]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AN_FatturazioneElettronicaHelper](
	[FKeyAnagrafica] [int] NOT NULL,
	[CodiceDestinatarioSDI] [varchar](9) NOT NULL,
	[PEC] [varchar](50) NOT NULL,
	[Paese] [varchar](50) NOT NULL,
	[Privato] [bit] NOT NULL,
 CONSTRAINT [PK_AN_FatturazioneElettronicaHelper] PRIMARY KEY CLUSTERED 
(
	[FKeyAnagrafica] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_AN_FatturazioneElettronicaHelper_Anagrafica]') AND parent_object_id = OBJECT_ID(N'[dbo].[AN_FatturazioneElettronicaHelper]'))
ALTER TABLE [dbo].[AN_FatturazioneElettronicaHelper]  WITH CHECK ADD  CONSTRAINT [FK_AN_FatturazioneElettronicaHelper_Anagrafica] FOREIGN KEY([FKeyAnagrafica])
REFERENCES [dbo].[Anagrafica] ([ID_Anagrafica])

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_AN_FatturazioneElettronicaHelper_Anagrafica]') AND parent_object_id = OBJECT_ID(N'[dbo].[AN_FatturazioneElettronicaHelper]'))
ALTER TABLE [dbo].[AN_FatturazioneElettronicaHelper] CHECK CONSTRAINT [FK_AN_FatturazioneElettronicaHelper_Anagrafica]


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FE_StatiFattureElettroniche]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FE_StatiFattureElettroniche](
	[FKeyFattura] [int] NOT NULL,
	[IdSDI] [bigint] NULL
) ON [PRIMARY]
END


IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_FE_StatiFattureElettroniche_RicevuteFiscali]') AND parent_object_id = OBJECT_ID(N'[dbo].[FE_StatiFattureElettroniche]'))
ALTER TABLE [dbo].[FE_StatiFattureElettroniche]  WITH CHECK ADD  CONSTRAINT [FK_FE_StatiFattureElettroniche_RicevuteFiscali] FOREIGN KEY([FKeyFattura])
REFERENCES [dbo].[RicevuteFiscali] ([ID_Ricevuta])


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_FE_StatiFattureElettroniche_RicevuteFiscali]') AND parent_object_id = OBJECT_ID(N'[dbo].[FE_StatiFattureElettroniche]'))
ALTER TABLE [dbo].[FE_StatiFattureElettroniche] CHECK CONSTRAINT [FK_FE_StatiFattureElettroniche_RicevuteFiscali]



IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FE_Sorgenti]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FE_Sorgenti](
	[ID_FESorgente] [int] NOT NULL,
	[DescFESorgente] [varchar](50) NOT NULL,
 CONSTRAINT [PK_FE_Sorgenti] PRIMARY KEY CLUSTERED 
(
	[ID_FESorgente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

  EXEC dbo.sp_executesql @statement = N'
  INSERT INTO [dbo].[FE_Sorgenti]
           ([ID_FESorgente]
           ,[DescFESorgente])
     VALUES
           (1
           ,''MG_Movimenti'')

  INSERT INTO [dbo].[FE_Sorgenti]
           ([ID_FESorgente]
           ,[DescFESorgente])
     VALUES
           (2
           ,''MG_Fatture'')

  INSERT INTO [dbo].[FE_Sorgenti]
           ([ID_FESorgente]
           ,[DescFESorgente])
     VALUES
           (3
           ,''RI_RicevuteFiscali'')

		   '
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FE_Invii]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FE_Invii](
	[ID_FEInvio] [int] IDENTITY(1,1) NOT NULL,
	[FKeyFESorgente] [int] NOT NULL,
	[FKeyDocumento] [int] NOT NULL,
	[IDSDI] [bigint] NOT NULL,
	[DataInvio] [datetime] NOT NULL,
	[ProgressivoInvio] [bigint] NOT NULL,
	[XMLFileName] [varchar](50) NOT NULL,
	[XMLFileContent] [image] NOT NULL,
 CONSTRAINT [PK_FE_Invii] PRIMARY KEY CLUSTERED 
(
	[ID_FEInvio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END


IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_FE_Invii_FE_Invii]') AND parent_object_id = OBJECT_ID(N'[dbo].[FE_Invii]'))
ALTER TABLE [dbo].[FE_Invii]  WITH CHECK ADD  CONSTRAINT [FK_FE_Invii_FE_Invii] FOREIGN KEY([ID_FEInvio])
REFERENCES [dbo].[FE_Invii] ([ID_FEInvio])


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_FE_Invii_FE_Invii]') AND parent_object_id = OBJECT_ID(N'[dbo].[FE_Invii]'))
ALTER TABLE [dbo].[FE_Invii] CHECK CONSTRAINT [FK_FE_Invii_FE_Invii]


IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_FE_Invii_FE_Sorgenti]') AND parent_object_id = OBJECT_ID(N'[dbo].[FE_Invii]'))
ALTER TABLE [dbo].[FE_Invii]  WITH CHECK ADD  CONSTRAINT [FK_FE_Invii_FE_Sorgenti] FOREIGN KEY([FKeyFESorgente])
REFERENCES [dbo].[FE_Sorgenti] ([ID_FESorgente])


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_FE_Invii_FE_Sorgenti]') AND parent_object_id = OBJECT_ID(N'[dbo].[FE_Invii]'))
ALTER TABLE [dbo].[FE_Invii] CHECK CONSTRAINT [FK_FE_Invii_FE_Sorgenti]



IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FE_EsitiInvii]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FE_EsitiInvii](
	[ID_EsitoInvio] [int] IDENTITY(1,1) NOT NULL,
	[FKeyFEInvio] [int] NOT NULL,
	[IDSdiEsito] [bigint] NOT NULL,
	[TipoMessaggio] [char](50) NOT NULL,
	[DescTipoMessaggio] [varchar](200) NOT NULL,
	[IDPdV] [varchar](50) NULL,
	[DataPdV] [datetime] NULL,
	[IDRdV] [varchar](50) NULL,
	[DataRdv] [datetime] NULL,
	[CodiceErrore] [varchar](50) NULL,
	[Descrizione] [varchar](max) NOT NULL,
	[EsitoXmlFileName] [varchar](50) NOT NULL,
	[EsitoXmlContent] [image] NULL,
	[StatoArchiviazione] [varchar](200) NOT NULL,
 CONSTRAINT [PK_FE_EsitiInvii] PRIMARY KEY CLUSTERED 
(
	[ID_EsitoInvio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_FE_EsitiInvii_Descrizione]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FE_EsitiInvii] ADD  CONSTRAINT [DF_FE_EsitiInvii_Descrizione]  DEFAULT ('') FOR [Descrizione]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_FE_EsitiInvii_StatoArchiviazione]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FE_EsitiInvii] ADD  CONSTRAINT [DF_FE_EsitiInvii_StatoArchiviazione]  DEFAULT ('') FOR [StatoArchiviazione]
END


IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_FE_EsitiInvii_FE_Invii]') AND parent_object_id = OBJECT_ID(N'[dbo].[FE_EsitiInvii]'))
ALTER TABLE [dbo].[FE_EsitiInvii]  WITH CHECK ADD  CONSTRAINT [FK_FE_EsitiInvii_FE_Invii] FOREIGN KEY([FKeyFEInvio])
REFERENCES [dbo].[FE_Invii] ([ID_FEInvio])


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_FE_EsitiInvii_FE_Invii]') AND parent_object_id = OBJECT_ID(N'[dbo].[FE_EsitiInvii]'))
ALTER TABLE [dbo].[FE_EsitiInvii] CHECK CONSTRAINT [FK_FE_EsitiInvii_FE_Invii]


