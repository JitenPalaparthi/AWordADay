package database

import (
	"awordaday/models"
	"errors"
	"fmt"
	"strings"
	"time"
)

//FindWords is to find all words from the database
func (d *Database) FindWords() []models.Word {
	words := []models.Word{}
	if d.Client.Find(&words).Error != nil {
		return nil
	}
	return words
}

// FindWordByWord is to find a Word by a actual word
func (d *Database) FindWordByWord(_word string) *models.Word {
	word := &models.Word{}
	if d.Client.Where("Upper(word)=?", strings.ToUpper(_word)).First(word).Error != nil {
		return nil
	}
	return word
}

// FindMagicWord is to find a Word by a actual word
func (d *Database) FindMagicWord() *models.Word {
	if d.Client != nil {
		word := &models.Word{}
		if d.Client.Preload("Sentences").Order("last_updated DESC").First(word).Error != nil {
			return nil
		}
		fmt.Println(word)
		return word
	}
	return nil
}

//InsertWord is to insert a nee word
func (d *Database) InsertWord(word *models.Word) (err error) {
	fmt.Println(word)
	if d.FindWordByWord(word.Word) == nil {
		word.LastUpdated = time.Now()
		c := d.Client.Create(word)
		if c.Error != nil {
			return c.Error
		}
		return nil
	}
	fmt.Println(word)

	return errors.New("Word already existed")
}

//InsertWord is to insert a nee word
func (d *Database) InsertRequestedWord(requestedWord *models.RequestWord) (err error) {
	//fmt.Println(requestedWord)
	if d.FindWordByWord(requestedWord.Word) == nil {
		requestedWord.LastUpdated = time.Now()
		c := d.Client.Create(requestedWord)
		if c.Error != nil {
			return c.Error
		}
		return nil
	}
	return errors.New("Word already existed")
}

// UpdateWord is to update a word based on values that are by map
func (d *Database) UpdateWord(word *models.Word, values map[string]interface{}) (err error) {
	c := d.Client.Model(word).Updates(values)
	if c.Error != nil {
		return c.Error
	}
	return nil
}

//DeleteWord is to delete a word
func (d *Database) DeleteWord(word *models.Word) (err error) {
	c := d.Client.Delete(word)
	if c.Error != nil {
		return c.Error
	}
	return nil
}
