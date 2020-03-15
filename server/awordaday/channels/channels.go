package channels

import (
	"fmt"
	"time"

	nats "github.com/nats-io/nats.go"
)

// Message is a message content, ideally for a channel
type Message struct {
	Data    []byte
	Subject string
}

type Audit struct {
	Data     interface{}
	IP       string
	Device   string
	URLPath  string
	Headers  map[string][]string
	DateTime time.Time
}

var (
	chanMessage chan Message
	NC          *nats.Conn
	ChanAudit   chan Audit
)

// Inidiate the channel at the beginning of the handler usage
func Init(nc *nats.Conn) {
	if chanMessage == nil {
		chanMessage = make(chan Message, 20)
		go ProcessMessage(nc)
	}
}

func InitAudit(session interface{}, database string) {
	if ChanAudit == nil {
		ChanAudit = make(chan Audit, 20)
		go ProcessAudit(session, database)
	}
}

func ProcessMessage(nc *nats.Conn) {
	for msg := range chanMessage {
		if nc != nil {
			nc.Publish(msg.Subject, msg.Data)
			nc.Subscribe("tokenizer", func(m *nats.Msg) {
				fmt.Println("Received a message: %s\n", string(m.Data))
			})
		}
		//glog.Info("Nats Connection has been expired")
	}
}

func ProcessAudit(session interface{}, database string) {
	//for audit := range ChanAudit {
	//if err := session.(*mgo.Session).DB(database).C("audits").Insert(audit); err != nil {
	//	return
	//}
	//}
}
