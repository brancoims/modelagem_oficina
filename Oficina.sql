-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `idCliente` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `CPF` VARCHAR(45) NULL,
  `Endereço` VARCHAR(45) NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Veiculo` (
  `idVeiculo` INT NOT NULL,
  `Modelo` VARCHAR(45) NULL,
  `Placa` VARCHAR(45) NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idVeiculo`, `Cliente_idCliente`),
  INDEX `fk_Veiculo_Cliente_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Veiculo_Cliente`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Equipe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Equipe` (
  `idEquipe` INT NOT NULL,
  `Codigo` INT NULL,
  `Nome` VARCHAR(45) NULL,
  `Especialidade` VARCHAR(45) NULL,
  PRIMARY KEY (`idEquipe`),
  UNIQUE INDEX `Codigo_UNIQUE` (`Codigo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Serviços`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Serviços` (
  `idServiços` INT NOT NULL,
  `Mao_de_obra` DECIMAL(10,2) NULL,
  PRIMARY KEY (`idServiços`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Serviços_has_Equipe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Serviços_has_Equipe` (
  `Serviços_idServiços` INT NOT NULL,
  `Equipe_idEquipe` INT NOT NULL,
  PRIMARY KEY (`Serviços_idServiços`, `Equipe_idEquipe`),
  INDEX `fk_Serviços_has_Equipe_Equipe1_idx` (`Equipe_idEquipe` ASC) VISIBLE,
  INDEX `fk_Serviços_has_Equipe_Serviços1_idx` (`Serviços_idServiços` ASC) VISIBLE,
  CONSTRAINT `fk_Serviços_has_Equipe_Serviços1`
    FOREIGN KEY (`Serviços_idServiços`)
    REFERENCES `mydb`.`Serviços` (`idServiços`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Serviços_has_Equipe_Equipe1`
    FOREIGN KEY (`Equipe_idEquipe`)
    REFERENCES `mydb`.`Equipe` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`OS` (
  `idOS` INT NOT NULL,
  `Numero` INT NULL,
  `Data_emissao` DATE NULL,
  `Valor` DECIMAL(10,2) NULL,
  `Status` VARCHAR(45) NULL,
  `Data_conclusao` DATE NULL,
  `Tipo_OS` VARCHAR(45) NULL,
  `Veiculo_idVeiculo` INT NOT NULL,
  `Equipe_idEquipe` INT NOT NULL,
  PRIMARY KEY (`idOS`),
  UNIQUE INDEX `Numero_UNIQUE` (`Numero` ASC) VISIBLE,
  INDEX `fk_OS_Veiculo1_idx` (`Veiculo_idVeiculo` ASC) VISIBLE,
  INDEX `fk_OS_Equipe1_idx` (`Equipe_idEquipe` ASC) VISIBLE,
  CONSTRAINT `fk_OS_Veiculo1`
    FOREIGN KEY (`Veiculo_idVeiculo`)
    REFERENCES `mydb`.`Veiculo` (`idVeiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OS_Equipe1`
    FOREIGN KEY (`Equipe_idEquipe`)
    REFERENCES `mydb`.`Equipe` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OS_has_Serviços`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`OS_has_Serviços` (
  `OS_idOS` INT NOT NULL,
  `Serviços_idServiços` INT NOT NULL,
  `Quantidade` INT NULL,
  `Valor_cobrado` DECIMAL(10,2) NULL,
  PRIMARY KEY (`OS_idOS`, `Serviços_idServiços`),
  INDEX `fk_OS_has_Serviços_Serviços1_idx` (`Serviços_idServiços` ASC) VISIBLE,
  INDEX `fk_OS_has_Serviços_OS1_idx` (`OS_idOS` ASC) VISIBLE,
  CONSTRAINT `fk_OS_has_Serviços_OS1`
    FOREIGN KEY (`OS_idOS`)
    REFERENCES `mydb`.`OS` (`idOS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OS_has_Serviços_Serviços1`
    FOREIGN KEY (`Serviços_idServiços`)
    REFERENCES `mydb`.`Serviços` (`idServiços`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Peças`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Peças` (
  `idPeças` INT NOT NULL,
  `Nome_peça` VARCHAR(45) NULL,
  `Valor_unitario` DECIMAL(10,2) NULL,
  `Quantidade` INT NULL,
  `Valor_cobrado` DECIMAL(10,2) NULL,
  PRIMARY KEY (`idPeças`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Peças_has_OS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Peças_has_OS` (
  `Peças_idPeças` INT NOT NULL,
  `OS_idOS` INT NOT NULL,
  PRIMARY KEY (`Peças_idPeças`, `OS_idOS`),
  INDEX `fk_Peças_has_OS_OS1_idx` (`OS_idOS` ASC) VISIBLE,
  INDEX `fk_Peças_has_OS_Peças1_idx` (`Peças_idPeças` ASC) VISIBLE,
  CONSTRAINT `fk_Peças_has_OS_Peças1`
    FOREIGN KEY (`Peças_idPeças`)
    REFERENCES `mydb`.`Peças` (`idPeças`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Peças_has_OS_OS1`
    FOREIGN KEY (`OS_idOS`)
    REFERENCES `mydb`.`OS` (`idOS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Mecanico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Mecanico` (
  `idMecanico` INT NOT NULL,
  `Codigo` INT NULL,
  `Nome` VARCHAR(45) NULL,
  `Endereço` VARCHAR(45) NULL,
  `Especialidade` VARCHAR(45) NULL,
  `Equipe_idEquipe` INT NOT NULL,
  PRIMARY KEY (`idMecanico`),
  INDEX `fk_Mecanico_Equipe1_idx` (`Equipe_idEquipe` ASC) VISIBLE,
  CONSTRAINT `fk_Mecanico_Equipe1`
    FOREIGN KEY (`Equipe_idEquipe`)
    REFERENCES `mydb`.`Equipe` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
