CREATE TABLE IF NOT EXISTS `mydb`.`Paziente` (
  `idPaziente` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Cognome` VARCHAR(45) NOT NULL,
  `Data_Nascita` DATE NOT NULL,
  `Luogo_Nascita` VARCHAR(45) NOT NULL,
  `Sesso` CHAR(1) NOT NULL,
  `Codice_Fiscale` VARCHAR(16) NOT NULL,
  `Telefono` VARCHAR(10) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Indirizzo` VARCHAR(45) NOT NULL,
  `Citta` VARCHAR(45) NOT NULL,
  `CAP` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`idPaziente`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE,
  UNIQUE INDEX `Codice_Fiscale_UNIQUE` (`Codice_Fiscale` ASC) VISIBLE)
ENGINE = InnoDB

CREATE TABLE IF NOT EXISTS `mydb`.`Prenotazione` (
  `idPrenotazione` INT NOT NULL,
  `Data` DATE NOT NULL,
  `Data_Visita` DATE NOT NULL,
  `Motivo` VARCHAR(45) NOT NULL,
  `Stato` VARCHAR(45) NOT NULL,
  `Paziente_idPaziente` INT NOT NULL,
  `Visita_idVisita` INT NOT NULL,
  PRIMARY KEY (`idPrenotazione`),
  INDEX `fk_Prenotazione_Paziente1_idx` (`Paziente_idPaziente` ASC) VISIBLE,
  INDEX `fk_Prenotazione_Visita1_idx` (`Visita_idVisita` ASC) VISIBLE,
  CONSTRAINT `fk_Prenotazione_Paziente1`
    FOREIGN KEY (`Paziente_idPaziente`)
    REFERENCES `mydb`.`Paziente` (`idPaziente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prenotazione_Visita1`
    FOREIGN KEY (`Visita_idVisita`)
    REFERENCES `mydb`.`Visita` (`idVisita`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB

CREATE TABLE IF NOT EXISTS `mydb`.`Visita` (
  `idVisita` INT NOT NULL,
  `Data` DATE NOT NULL,
  `Motivo` VARCHAR(255) NULL,
  `Note_Mediche` TEXT NULL,
  `Paziente_idPaziente` INT NOT NULL,
  `Medico_idMedico` INT NOT NULL,
  PRIMARY KEY (`idVisita`),
  INDEX `fk_Visita_Paziente1_idx` (`Paziente_idPaziente` ASC) VISIBLE,
  INDEX `fk_Visita_Medico1_idx` (`Medico_idMedico` ASC) VISIBLE,
  CONSTRAINT `fk_Visita_Paziente1`
    FOREIGN KEY (`Paziente_idPaziente`)
    REFERENCES `mydb`.`Paziente` (`idPaziente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Visita_Medico1`
    FOREIGN KEY (`Medico_idMedico`)
    REFERENCES `mydb`.`Medico` (`idMedico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB

CREATE TABLE IF NOT EXISTS `mydb`.`Medico` (
  `idMedico` INT NOT NULL,
  `Nome` VARCHAR(50) NOT NULL,
  `Cognome` VARCHAR(50) NOT NULL,
  `Telefono` VARCHAR(10) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idMedico`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE)
ENGINE = InnoDB

CREATE TABLE IF NOT EXISTS `mydb`.`Medico_has_Specializzazione` (
  `Medico_idMedico` INT NOT NULL,
  `Specializzazione_idSpecializzazione` INT NOT NULL,
  PRIMARY KEY (`Medico_idMedico`, `Specializzazione_idSpecializzazione`),
  INDEX `fk_Medico_has_Specializzazione_Specializzazione1_idx` (`Specializzazione_idSpecializzazione` ASC) VISIBLE,
  INDEX `fk_Medico_has_Specializzazione_Medico1_idx` (`Medico_idMedico` ASC) VISIBLE,
  CONSTRAINT `fk_Medico_has_Specializzazione_Medico1`
    FOREIGN KEY (`Medico_idMedico`)
    REFERENCES `mydb`.`Medico` (`idMedico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Medico_has_Specializzazione_Specializzazione1`
    FOREIGN KEY (`Specializzazione_idSpecializzazione`)
    REFERENCES `mydb`.`Specializzazione` (`idSpecializzazione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB

CREATE TABLE IF NOT EXISTS `mydb`.`Specializzazione` (
  `idSpecializzazione` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idSpecializzazione`))
ENGINE = InnoDB

CREATE TABLE IF NOT EXISTS `mydb`.`Visita_has_Diagnosi` (
  `Visita_idVisita` INT NOT NULL,
  `Diagnosi_idDiagnosi` INT NOT NULL,
  PRIMARY KEY (`Visita_idVisita`, `Diagnosi_idDiagnosi`),
  INDEX `fk_Visita_has_Diagnosi_Diagnosi1_idx` (`Diagnosi_idDiagnosi` ASC) VISIBLE,
  INDEX `fk_Visita_has_Diagnosi_Visita1_idx` (`Visita_idVisita` ASC) VISIBLE,
  CONSTRAINT `fk_Visita_has_Diagnosi_Visita1`
    FOREIGN KEY (`Visita_idVisita`)
    REFERENCES `mydb`.`Visita` (`idVisita`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Visita_has_Diagnosi_Diagnosi1`
    FOREIGN KEY (`Diagnosi_idDiagnosi`)
    REFERENCES `mydb`.`Diagnosi` (`idDiagnosi`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB

CREATE TABLE IF NOT EXISTS `mydb`.`Diagnosi` (
  `idDiagnosi` INT NOT NULL,
  `Descrizione` TEXT NULL,
  `Data` DATE NULL,
  PRIMARY KEY (`idDiagnosi`))
ENGINE = InnoDB

CREATE TABLE IF NOT EXISTS `mydb`.`Trattamento` (
  `idTrattamento` INT NOT NULL,
  `Tipo` VARCHAR(100) NULL,
  `Descrizione` TEXT NULL,
  `Data_Inizio` DATE NULL,
  `Data_Fine` DATE NULL,
  `Diagnosi_idDiagnosi` INT NOT NULL,
  PRIMARY KEY (`idTrattamento`),
  INDEX `fk_Trattamento_Diagnosi1_idx` (`Diagnosi_idDiagnosi` ASC) VISIBLE,
  CONSTRAINT `fk_Trattamento_Diagnosi1`
    FOREIGN KEY (`Diagnosi_idDiagnosi`)
    REFERENCES `mydb`.`Diagnosi` (`idDiagnosi`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB

CREATE TABLE IF NOT EXISTS `mydb`.`Trattamento_has_Farmaco` (
  `Trattamento_idTrattamento` INT NOT NULL,
  `Farmaco_idFarmaco` INT NOT NULL,
  PRIMARY KEY (`Trattamento_idTrattamento`, `Farmaco_idFarmaco`),
  INDEX `fk_Trattamento_has_Farmaco_Farmaco1_idx` (`Farmaco_idFarmaco` ASC) VISIBLE,
  INDEX `fk_Trattamento_has_Farmaco_Trattamento1_idx` (`Trattamento_idTrattamento` ASC) VISIBLE,
  CONSTRAINT `fk_Trattamento_has_Farmaco_Trattamento1`
    FOREIGN KEY (`Trattamento_idTrattamento`)
    REFERENCES `mydb`.`Trattamento` (`idTrattamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Trattamento_has_Farmaco_Farmaco1`
    FOREIGN KEY (`Farmaco_idFarmaco`)
    REFERENCES `mydb`.`Farmaco` (`idFarmaco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB

CREATE TABLE IF NOT EXISTS `mydb`.`Farmaco` (
  `idFarmaco` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Dosaggio` VARCHAR(45) NOT NULL,
  `Modalita` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idFarmaco`))
ENGINE = InnoDB

CREATE TABLE IF NOT EXISTS `mydb`.`Fattura` (
  `idFattura` INT NOT NULL,
  `Importo` DECIMAL(10,2) NOT NULL,
  `Data_Emissione` DATE NOT NULL,
  `Paziente_idPaziente` INT NOT NULL,
  `Visita_idVisita` INT NOT NULL,
  PRIMARY KEY (`idFattura`),
  INDEX `fk_Fattura_Paziente1_idx` (`Paziente_idPaziente` ASC) VISIBLE,
  INDEX `fk_Fattura_Visita1_idx` (`Visita_idVisita` ASC) VISIBLE,
  CONSTRAINT `fk_Fattura_Paziente1`
    FOREIGN KEY (`Paziente_idPaziente`)
    REFERENCES `mydb`.`Paziente` (`idPaziente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fattura_Visita1`
    FOREIGN KEY (`Visita_idVisita`)
    REFERENCES `mydb`.`Visita` (`idVisita`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB

