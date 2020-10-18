package autocache

import (
	"log"
	"os"
)

type Logger interface {
	Debug(args ...interface{})
	Info(args ...interface{})
	Warn(args ...interface{})
	Error(args ...interface{})
	Panic(args ...interface{})
	Fatal(args ...interface{})
	Debugf(template string, args ...interface{})
	Infof(template string, args ...interface{})
	Warnf(template string, args ...interface{})
	Errorf(template string, args ...interface{})
	Panicf(template string, args ...interface{})
	Fatalf(template string, args ...interface{})
	StdLogger() *log.Logger
}


type logger struct {
	*log.Logger
}

func (l *logger) Debug(args ...interface{}) {
	l.Print(args...)
}

func (l *logger) Info(args ...interface{}) {
	l.Print(args...)
}

func (l *logger) Warn(args ...interface{}) {
	l.Print(args...)
}

func (l *logger) Error(args ...interface{}) {
	l.Print(args...)
}

func (l *logger) Debugf(template string, args ...interface{}) {
	l.Printf(template, args...)
}

func (l *logger) Infof(template string, args ...interface{}) {
	l.Printf(template, args...)
}

func (l *logger) Warnf(template string, args ...interface{}) {
	l.Printf(template, args...)
}

func (l *logger) Errorf(template string, args ...interface{}) {
	l.Printf(template, args...)
}

func (l *logger) StdLogger() *log.Logger {
	return l.Logger
	
}

func NewLogger() Logger {
	return &logger{log.New(os.Stderr, "", log.LstdFlags)}
}