package database

import (
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres"
	// Necessary in order to check for transaction retry error codes.
)

const (
	CONNECTION_RETRIES = 3
)

type Database struct {
	Client *gorm.DB
}

func New(driver, dataSource string) (db *Database, err error) {
	retries := 0
try:
	retries++
	connection, err := gorm.Open(driver, dataSource)
	if err != nil {
		if retries < CONNECTION_RETRIES {
			goto try
		}
		return nil, err
	}
	//defer connection.Close()
	db = &Database{Client: connection}
	return db, nil
}
