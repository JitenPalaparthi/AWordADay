package handler

import (
	"awordaday/database"
	"awordaday/models"
	"encoding/json"
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
)

// InsertWord is to insert a new Word
func InsertWord(d *database.Database) func(c *gin.Context) {
	var err error
	return func(c *gin.Context) {
		if c.Request.Method == "POST" {
			var word models.Word
			word = models.Word{}
			word.Status = "NOT-ACTIVE"
			//word.LastUpdated = time.Now()
			err = json.NewDecoder(c.Request.Body).Decode(&word)
			fmt.Println(word.Word)
			if err != nil {
				c.JSON(http.StatusBadRequest, gin.H{
					"status":  "failed",
					"message": err.Error(),
				})
				c.Abort()
				return
			}

			err = d.InsertWord(&word)
			if err != nil {
				c.JSON(http.StatusBadRequest, gin.H{
					"status":  "failed",
					"message": err.Error(),
				})
				c.Abort()
				return
			}
			//c.BindJSON(&u)
			c.JSON(http.StatusOK, gin.H{
				"status":  "success",
				"message": "Word Successfully Created",
			})
			c.Abort()
			return
		}
	}
}

// InsertSentence is to insert a new Word
func InsertSentence(d *database.Database) func(c *gin.Context) {
	var err error
	return func(c *gin.Context) {
		if c.Request.Method == "POST" {
			var sentence models.Sentence
			sentence = models.Sentence{}
			sentence.Status = "NOT-ACTIVE"
			//word.LastUpdated = time.Now()
			err = json.NewDecoder(c.Request.Body).Decode(&sentence)

			if err != nil {
				c.JSON(http.StatusBadRequest, gin.H{
					"status":  "failed",
					"message": err.Error(),
				})
				c.Abort()
				return
			}

			err = d.InsertSentence(&sentence)
			if err != nil {
				c.JSON(http.StatusBadRequest, gin.H{
					"status":  "failed",
					"message": err.Error(),
				})
				c.Abort()
				return
			}
			//c.BindJSON(&u)
			c.JSON(http.StatusOK, gin.H{
				"status":  "success",
				"message": "Sentence Successfully Created",
			})
			c.Abort()
			return
		}
	}
}

func GetWord(d *database.Database) func(c *gin.Context) {
	return func(c *gin.Context) {
		if c.Request.Method == "GET" {
			word := d.FindMagicWord()
			c.JSON(http.StatusOK, word)
		}
	}
}

// InsertWord is to insert a new Word
func InsertRequestedWord(d *database.Database) func(c *gin.Context) {
	var err error
	return func(c *gin.Context) {
		if c.Request.Method == "POST" {
			var requestWord models.RequestWord
			requestWord = models.RequestWord{}
			requestWord.Status = "NOT-ACTIVE"
			//word.LastUpdated = time.Now()
			err = json.NewDecoder(c.Request.Body).Decode(&requestWord)
			fmt.Println(requestWord.Word)
			if err != nil {
				c.JSON(http.StatusBadRequest, gin.H{
					"status":  "failed",
					"message": err.Error(),
				})
				c.Abort()
				return
			}

			err = d.InsertRequestedWord(&requestWord)
			if err != nil {
				c.JSON(http.StatusBadRequest, gin.H{
					"status":  "failed",
					"message": err.Error(),
				})
				c.Abort()
				return
			}
			//c.BindJSON(&u)
			c.JSON(http.StatusOK, gin.H{
				"status":  "success",
				"message": "Requested word successfully added",
			})
			c.Abort()
			return
		}
	}
}

/*
// UpdateTempalte is to update a beneficiarie tempalte
func (e *Enquiry) UpdateWord() func(c *gin.Context) {
	var err error
	return func(c *gin.Context) {
		if c.Request.Method == "PUT" {
			jsonMap := make(map[string]interface{})
			err = json.NewDecoder(c.Request.Body).Decode(&jsonMap)
			if err != nil {
				c.JSON(http.StatusBadRequest, gin.H{
					"status":  "body seems to be wrong json format",
					"message": err.Error(),
				})
				c.Abort()
				return
			}

			sval, ok := jsonMap["selectors"]
			if !ok {
				c.JSON(http.StatusBadRequest, gin.H{
					"message": "body seems to be wrong json format.selectors json key not found",
					"status":  "failed",
				})
				c.Abort()
				return
			}
			uval, ok := jsonMap["updators"]
			if !ok {
				c.JSON(http.StatusBadRequest, gin.H{
					"status":  "failed",
					"message": "body seems to be wrong json format.updaters json key not found",
				})
				c.Abort()
				return
			}

			err = e.IEnquiry.UpdateEnquiry(sval, uval)
			if err != nil {
				c.JSON(http.StatusBadRequest, gin.H{
					"status":  "failed",
					"message": err.Error(),
				})
				c.Abort()
				return
			}
			//c.BindJSON(&u)
			c.JSON(http.StatusOK, gin.H{
				"status":  "success",
				"message": common.EnquiryUpdateSuccess,
			})
			c.Abort()
			return
		}
	}
}

// DeleteTempalte is to delete an beneficiarie tempalte
func (e *Enquiry) DeleteEnquiry() func(c *gin.Context) {
	var err error
	return func(c *gin.Context) {
		if c.Request.Method == "DELETE" {
			jsonMap := make(map[string]interface{})
			err = json.NewDecoder(c.Request.Body).Decode(&jsonMap)
			if err != nil {
				c.JSON(http.StatusBadRequest, gin.H{
					"status":  "body seems to be wrong json format",
					"message": err.Error(),
				})
				c.Abort()
				return
			}

			sval, ok := jsonMap["selectors"]
			if !ok {
				c.JSON(http.StatusBadRequest, gin.H{
					"message": "body seems to be wrong json format.selectors json key not found",
					"status":  "failed",
				})
				c.Abort()
				return
			}
			err = e.IEnquiry.DeleteEnquiry(sval)
			if err != nil {
				c.JSON(http.StatusBadRequest, gin.H{
					"status":  "failed",
					"message": err.Error(),
				})
				c.Abort()
				return
			}
			//c.BindJSON(&u)
			c.JSON(http.StatusOK, gin.H{
				"status":  "success",
				"message": common.EnquiryDeleteSuccess,
			})
			c.Abort()
			return
		}
	}
}

func (e *Enquiry) GetEnquiry() func(c *gin.Context) {
	return func(c *gin.Context) {
		if c.Request.Method == "GET" {
			email := c.Param("email")
			if email == "" {
				c.JSON(http.StatusBadRequest, gin.H{
					"status":  "failed",
					"message": "email parameter has not been provieded",
				})
				c.Abort()
				return
			}
			enquiry, err := e.IEnquiry.GetEnquiry(&email)
			if err != nil {
				c.JSON(http.StatusBadRequest, gin.H{
					"status":  "failed",
					"message": err.Error(),
				})
				c.Abort()
				return
			}
			///c.BindJSON(&profile)
			c.JSON(http.StatusOK, enquiry)
		}
	}
}

func (e *Enquiry) GetEnquiries() func(c *gin.Context) {
	return func(c *gin.Context) {
		if c.Request.Method == "GET" {
			skip := c.Param("skip")
			limit := c.Param("limit")

			if skip == "" {
				c.JSON(http.StatusBadRequest, gin.H{
					"status":  "failed",
					"message": "skip parameter has not been provieded",
				})
				c.Abort()
				return
			}

			if limit == "" {
				c.JSON(http.StatusBadRequest, gin.H{
					"status":  "failed",
					"message": "limit parameter has not been provieded",
				})
				c.Abort()
				return
			}

			iskip, err := strconv.ParseInt(skip, 10, 32)
			if err != nil {
				c.JSON(http.StatusBadRequest, gin.H{
					"status":  "failed",
					"message": err,
				})
				c.Abort()
				return
			}

			ilimit, err := strconv.ParseInt(limit, 10, 32)
			if err != nil {
				c.JSON(http.StatusBadRequest, gin.H{
					"status":  "failed",
					"message": err,
				})
				c.Abort()
				return
			}
			selector := make(map[string]interface{})
			jsonMap := c.Request.URL.Query()

			for key, val := range jsonMap {
				selector[key] = val[0]
			}

			enquiries, err := e.IEnquiry.GetEnquiries(int32(iskip), int32(ilimit), selector)
			if err != nil {
				c.JSON(http.StatusBadRequest, gin.H{
					"status":  "failed",
					"message": err.Error(),
				})
				c.Abort()
				return
			}
			//c.BindJSON(&profiles)
			c.JSON(http.StatusOK, enquiries)
		}
	}
}
*/
