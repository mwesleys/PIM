-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bomae
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bomae
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bomae` DEFAULT CHARACTER SET utf8 ;
USE `bomae` ;

-- -----------------------------------------------------
-- Table `bomae`.`Status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bomae`.`Status` (
  `idStatus` INT NOT NULL,
  `Descricao` VARCHAR(45) NULL,
  PRIMARY KEY (`idStatus`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bomae`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bomae`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Cpf` VARCHAR(14) NULL,
  `Nome` VARCHAR(45) NULL,
  `Dt_nascimento` DATETIME NULL,
  `RG` VARCHAR(20) NULL,
  `Status_idStatus` INT NOT NULL,
  PRIMARY KEY (`idCliente`, `Status_idStatus`),
  INDEX `fk_Cliente_Status1_idx` (`Status_idStatus` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Status1`
    FOREIGN KEY (`Status_idStatus`)
    REFERENCES `bomae`.`Status` (`idStatus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bomae`.`Endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bomae`.`Endereco` (
  `Rua` VARCHAR(30) NULL,
  `Numero` VARCHAR(20) NULL,
  `Bairro` VARCHAR(45) NULL,
  `Cidade` VARCHAR(45) NULL,
  `Estado` VARCHAR(45) NULL,
  `CEP` VARCHAR(45) NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`Cliente_idCliente`),
  CONSTRAINT `fk_Endereco_Cliente`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `bomae`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bomae`.`Orcamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bomae`.`Orcamento` (
  `idOrcamento` INT NOT NULL,
  `ValorEstimado` DECIMAL(14) NULL,
  `Desconto` DECIMAL(14) NULL,
  `QntdItem` INT NULL,
  `Descricao` VARCHAR(45) NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Status_idStatus` INT NOT NULL,
  `Status_idStatus1` INT NOT NULL,
  PRIMARY KEY (`idOrcamento`, `Cliente_idCliente`, `Status_idStatus`, `Status_idStatus1`),
  INDEX `fk_Orcamento_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_Orcamento_Status1_idx` (`Status_idStatus` ASC) VISIBLE,
  INDEX `fk_Orcamento_Status2_idx` (`Status_idStatus1` ASC) VISIBLE,
  CONSTRAINT `fk_Orcamento_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `bomae`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orcamento_Status1`
    FOREIGN KEY (`Status_idStatus`)
    REFERENCES `bomae`.`Status` (`idStatus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orcamento_Status2`
    FOREIGN KEY (`Status_idStatus1`)
    REFERENCES `bomae`.`Status` (`idStatus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bomae`.`Forma_pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bomae`.`Forma_pagamento` (
  `idForma_pagamento` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NULL,
  `Descricao` VARCHAR(45) NULL,
  PRIMARY KEY (`idForma_pagamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bomae`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bomae`.`Pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `Descricao` VARCHAR(45) NULL,
  `ValorTotal` DECIMAL(14) NULL,
  `QtdParcelas` INT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Orcamento_idOrcamento` INT NOT NULL,
  `Orcamento_Cliente_idCliente` INT NOT NULL,
  `Orcamento_Status_idStatus` INT NOT NULL,
  `Status_idStatus` INT NOT NULL,
  `Forma_pagamento_idForma_pagamento` INT NOT NULL,
  PRIMARY KEY (`idPedido`, `Cliente_idCliente`, `Orcamento_idOrcamento`, `Orcamento_Cliente_idCliente`, `Orcamento_Status_idStatus`, `Status_idStatus`, `Forma_pagamento_idForma_pagamento`),
  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_Pedido_Orcamento1_idx` (`Orcamento_idOrcamento` ASC, `Orcamento_Cliente_idCliente` ASC, `Orcamento_Status_idStatus` ASC) VISIBLE,
  INDEX `fk_Pedido_Status1_idx` (`Status_idStatus` ASC) VISIBLE,
  INDEX `fk_Pedido_Forma_pagamento1_idx` (`Forma_pagamento_idForma_pagamento` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `bomae`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Orcamento1`
    FOREIGN KEY (`Orcamento_idOrcamento` , `Orcamento_Cliente_idCliente` , `Orcamento_Status_idStatus`)
    REFERENCES `bomae`.`Orcamento` (`idOrcamento` , `Cliente_idCliente` , `Status_idStatus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Status1`
    FOREIGN KEY (`Status_idStatus`)
    REFERENCES `bomae`.`Status` (`idStatus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Forma_pagamento1`
    FOREIGN KEY (`Forma_pagamento_idForma_pagamento`)
    REFERENCES `bomae`.`Forma_pagamento` (`idForma_pagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bomae`.`Telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bomae`.`Telefone` (
  `Telefone_movel` VARCHAR(20) NULL,
  `Telefone_fixo` VARCHAR(45) NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`Cliente_idCliente`),
  CONSTRAINT `fk_Telefone_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `bomae`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bomae`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bomae`.`Usuario` (
  `idUsuario` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `Senha` VARCHAR(45) NULL,
  `Dt_Nascimento` DATETIME NULL,
  `Status_idStatus` INT NOT NULL,
  PRIMARY KEY (`idUsuario`, `Status_idStatus`),
  INDEX `fk_Usuario_Status1_idx` (`Status_idStatus` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_Status1`
    FOREIGN KEY (`Status_idStatus`)
    REFERENCES `bomae`.`Status` (`idStatus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bomae`.`Departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bomae`.`Departamento` (
  `idDepartamento` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Descricao` VARCHAR(45) NULL,
  PRIMARY KEY (`idDepartamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bomae`.`Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bomae`.`Estoque` (
  `idProduto` INT NOT NULL,
  `Qtd` VARCHAR(45) NULL,
  `Dt_entrada` DATETIME NULL,
  `Dt_Saida` DATETIME NULL,
  `Descricao_produto` VARCHAR(45) NULL,
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bomae`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bomae`.`Fornecedor` (
  `idFornecedor` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `CNPJ` VARCHAR(45) NULL,
  `IE` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `Telefone` VARCHAR(45) NULL,
  PRIMARY KEY (`idFornecedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bomae`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bomae`.`Produto` (
  `idProduto` INT NOT NULL AUTO_INCREMENT,
  `Descricao` VARCHAR(45) NULL,
  `Valor` DECIMAL(14) NULL,
  `Cor` VARCHAR(45) NULL,
  `Dimensao` VARCHAR(45) NULL,
  `Custo` DECIMAL(14) NULL,
  `Produtocol` VARCHAR(45) NULL,
  `Estoque_idProduto` INT NOT NULL,
  `Status_idStatus` INT NOT NULL,
  `Fornecedor_idFornecedor` INT NOT NULL,
  PRIMARY KEY (`idProduto`, `Estoque_idProduto`, `Status_idStatus`, `Fornecedor_idFornecedor`),
  INDEX `fk_Produto_Estoque1_idx` (`Estoque_idProduto` ASC) VISIBLE,
  INDEX `fk_Produto_Status1_idx` (`Status_idStatus` ASC) VISIBLE,
  INDEX `fk_Produto_Fornecedor1_idx` (`Fornecedor_idFornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_Estoque1`
    FOREIGN KEY (`Estoque_idProduto`)
    REFERENCES `bomae`.`Estoque` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_Status1`
    FOREIGN KEY (`Status_idStatus`)
    REFERENCES `bomae`.`Status` (`idStatus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_Fornecedor1`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `bomae`.`Fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bomae`.`Pedido_Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bomae`.`Pedido_Produto` (
  `Qtd_produto` INT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Pedido_Cliente_idCliente` INT NOT NULL,
  `Pedido_Orcamento_idOrcamento` INT NOT NULL,
  `Pedido_Orcamento_Cliente_idCliente` INT NOT NULL,
  `Pedido_Orcamento_Status_idStatus` INT NOT NULL,
  `Pedido_Status_idStatus` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  PRIMARY KEY (`Pedido_idPedido`, `Pedido_Cliente_idCliente`, `Pedido_Orcamento_idOrcamento`, `Pedido_Orcamento_Cliente_idCliente`, `Pedido_Orcamento_Status_idStatus`, `Pedido_Status_idStatus`, `Produto_idProduto`),
  INDEX `fk_Pedido_Produto_Pedido1_idx` (`Pedido_idPedido` ASC, `Pedido_Cliente_idCliente` ASC, `Pedido_Orcamento_idOrcamento` ASC, `Pedido_Orcamento_Cliente_idCliente` ASC, `Pedido_Orcamento_Status_idStatus` ASC, `Pedido_Status_idStatus` ASC) VISIBLE,
  INDEX `fk_Pedido_Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Produto_Pedido1`
    FOREIGN KEY (`Pedido_idPedido` , `Pedido_Cliente_idCliente` , `Pedido_Orcamento_idOrcamento` , `Pedido_Orcamento_Cliente_idCliente` , `Pedido_Orcamento_Status_idStatus` , `Pedido_Status_idStatus`)
    REFERENCES `bomae`.`Pedido` (`idPedido` , `Cliente_idCliente` , `Orcamento_idOrcamento` , `Orcamento_Cliente_idCliente` , `Orcamento_Status_idStatus` , `Status_idStatus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `bomae`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bomae`.`Orcamento_Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bomae`.`Orcamento_Produto` (
  `idOrcamento_Produto` INT NOT NULL,
  `Qtd_produto` VARCHAR(45) NULL,
  `Orcamento_idOrcamento` INT NOT NULL,
  `Orcamento_Cliente_idCliente` INT NOT NULL,
  `Orcamento_Status_idStatus` INT NOT NULL,
  PRIMARY KEY (`idOrcamento_Produto`, `Orcamento_idOrcamento`, `Orcamento_Cliente_idCliente`, `Orcamento_Status_idStatus`),
  INDEX `fk_Orcamento_Produto_Orcamento1_idx` (`Orcamento_idOrcamento` ASC, `Orcamento_Cliente_idCliente` ASC, `Orcamento_Status_idStatus` ASC) VISIBLE,
  CONSTRAINT `fk_Orcamento_Produto_Orcamento1`
    FOREIGN KEY (`Orcamento_idOrcamento` , `Orcamento_Cliente_idCliente` , `Orcamento_Status_idStatus`)
    REFERENCES `bomae`.`Orcamento` (`idOrcamento` , `Cliente_idCliente` , `Status_idStatus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bomae`.`NFE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bomae`.`NFE` (
  `idNFE` INT NOT NULL,
  `NumNFE` VARCHAR(45) NULL,
  `Dt_emissao` DATETIME NULL,
  `TipoNota` VARCHAR(45) NULL,
  `IPI` DECIMAL(14) NULL,
  `ICMS` DECIMAL(14) NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Pedido_Produto_idPedido_Produto` INT NOT NULL,
  `Pedido_Produto_Pedido_Orcamento_idOrcamento` INT NOT NULL,
  `Pedido_Produto_Pedido_Status_idStatus` INT NOT NULL,
  `Pedido_Produto_Produto_idProduto` INT NOT NULL,
  PRIMARY KEY (`idNFE`, `Cliente_idCliente`, `Pedido_Produto_Pedido_Orcamento_idOrcamento`, `Pedido_Produto_Pedido_Status_idStatus`, `Pedido_Produto_Produto_idProduto`),
  INDEX `fk_NFE_Pedido_Produto1_idx` (`Pedido_Produto_Pedido_Orcamento_idOrcamento` ASC, `Pedido_Produto_Pedido_Status_idStatus` ASC, `Pedido_Produto_Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_NFE_Pedido_Produto1`
    FOREIGN KEY (`Pedido_Produto_Pedido_Orcamento_idOrcamento` , `Pedido_Produto_Pedido_Status_idStatus` , `Pedido_Produto_Produto_idProduto`)
    REFERENCES `bomae`.`Pedido_Produto` (`Pedido_Orcamento_idOrcamento` , `Pedido_Status_idStatus` , `Produto_idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bomae`.`LOG`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bomae`.`LOG` (
  `idLOG` INT NOT NULL,
  `Usuario` VARCHAR(45) NULL,
  `Nome` VARCHAR(45) NULL,
  `Data` DATETIME NULL,
  `Descricao` VARCHAR(45) NULL,
  PRIMARY KEY (`idLOG`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bomae`.`Usuario_departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bomae`.`Usuario_departamento` (
  `Usuario_idUsuario` INT NOT NULL,
  `Usuario_Status_idStatus` INT NOT NULL,
  `Departamento_idDepartamento` INT NOT NULL,
  PRIMARY KEY (`Usuario_idUsuario`, `Usuario_Status_idStatus`, `Departamento_idDepartamento`),
  INDEX `fk_Usuario_departamento_Usuario1_idx` (`Usuario_idUsuario` ASC, `Usuario_Status_idStatus` ASC) VISIBLE,
  INDEX `fk_Usuario_departamento_Departamento1_idx` (`Departamento_idDepartamento` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_departamento_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario` , `Usuario_Status_idStatus`)
    REFERENCES `bomae`.`Usuario` (`idUsuario` , `Status_idStatus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_departamento_Departamento1`
    FOREIGN KEY (`Departamento_idDepartamento`)
    REFERENCES `bomae`.`Departamento` (`idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
