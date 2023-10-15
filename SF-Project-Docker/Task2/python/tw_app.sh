#!/usr/local/bin/python3.9

import mysql.connector
import datetime
import pandas as pd

def is_empty(df):
    if df.empty:
        print('Empty table')

connection = mysql.connector.connect(host='mysql-host', user = 'twitter_user' , password = 'qazwsx', db='twitter')
cursor = connection.cursor()
print("")
print("Welcome to my Twitter application")
print("In each page there will be guidlines")
print("Please choose the desired option and enter data")
print(',' * 50)

while True:
    print("1-Log in")
    print("2-Sign up")
    option = int(input())

    if option == 1:
        arguments = []
        print('Enter userName')
        userName = input()
        arguments.append(userName)
        print('Enter password')
        password = input()
        arguments.append(password)
        cursor.callproc('login', arguments)
        result = ''
        for i in cursor.stored_results():
            result = i.fetchone()[0]

        if 'Invalid'not in result:
            print(result)
            connection.commit()
            break
        else: 
            print(result)
            input()
            connection.rollback()

    elif option == 2:
        arguments = []
        print('Enter userName(20 character long):')
        userName = input()
        arguments.append(userName)
        print('Enter first name(20 character long):')
        firstname = input()
        arguments.append(firstname)
        print('Enter last name(20 character long):')
        lastname = input()
        arguments.append(lastname)

        flag = False
        print('Enter date of birth(YYYY-MM-DD):')
        while not flag:
            try:
                birthdate = input()
                birthdate = datetime.datetime.strptime(birthdate, '%Y-%m-%d')
                flag = True
            except:
                print('Please enter date of birth in valid format:')

        arguments.append(birthdate)
        print('Enter bio(if you dont want to have bio, enter \"none\"):')
        bio = input()
        if bio == 'none':
            bio = None
        arguments.append(bio)
        print('Enter password(128 character long ):')
        password = input()
        arguments.append(password)
        cursor.callproc('create_account', arguments)
        result = ''
        for i in cursor.stored_results():
            result = i.fetchone()[0]
        if result != 'Sorry, this username is already taken.':
            print(result)
            connection.commit()
        else:

            print(result)
            connection.rollback()
            input()
    else:
        print('INVALID INPUT!')
        
    print('')

print('Welcome to your twitter page')

while True:
    print('0-Quit')
    print('1-Send a new tweet')
    print('2-Get personal tweets')
    print('3-Get personal tweets and replies')
    print('4-Follow')
    print('5-Unfollow')
    print('6-Get a specific user activities')
    print('7-Add a new comment')
    print('8-Get comments of specific tweet')

    option = int(input())

    if option == 0:
        break

    elif option == 1:
        arguments = []
        print('Enter your tweet content(Maximum 256 character long):')
        tweet_content = input()
        arguments.append(tweet_content)
        cursor.callproc('send_tweet', arguments)
        result = ''
        for i in cursor.stored_results():
            result = i.fetchone()[0]
        print(result)
        connection.commit()
        input()

    elif option == 2:
        cursor.callproc('get_own_tweets')
        result = ''
        for i in cursor.stored_results():
            result = i.fetchall()
            df = pd.DataFrame(result)
            is_empty(df)
            print(df.to_markdown())
        input()

    elif option == 3:
        cursor.callproc('get_own_tweets_and_replies')
        result = ''
        for i in cursor.stored_results():
            result = i.fetchall()
            df = pd.DataFrame(result)
            is_empty(df)
            print(df.to_markdown())
        input()

    elif option == 4:
        arguments = []
        print('Enter the username of the person you want to follow:')
        username = input()
        arguments.append(username)
        cursor.callproc('follow', arguments)
        result = ''
        for i in cursor.stored_results():
            result = i.fetchone()[0]
        print(result)
        connection.commit()
        input()

    elif option == 5:
        arguments = []
        print('Enter the username of the person you want to unfollow:')
        username = input()
        arguments.append(username)
        cursor.callproc('stop_follow', arguments)
        result = ''
        for i in cursor.stored_results():
            result = i.fetchone()[0]
        print(result)
        connection.commit()
        input()

    elif option == 6:
        arguments = []
        print('Enter the username of the person whose activities you want to see:')
        username = input()
        arguments.append(username)
        cursor.callproc('get_user_activity', arguments)
        result = ''
        for i in cursor.stored_results():
            result = i.fetchall()
            df = pd.DataFrame(result)
            is_empty(df)
            print(df.to_markdown())
        input()

    elif option == 7:
        arguments = []
        print('Enter the tweet ID you want to comment on:')
        tweet_id = int(input())
        arguments.append(tweet_id)
        print('Enter your comment content:')
        comment_content = input()
        arguments.append(comment_content)

        cursor.callproc('comment', arguments)
        result = ''
        for i in cursor.stored_results():
            result = i.fetchone()[0]
        print(result)
        connection.commit()
        input()
    elif option == 8:
        arguments = []
        print('Enter the tweet ID you want to see it\'s comments:')
        tweet_id = int(input())
        arguments.append(tweet_id)
        cursor.callproc('get_comments_of_tweet', arguments)
        result = ''
        for i in cursor.stored_results():
            result = i.fetchall()
            df = pd.DataFrame(result)
            is_empty(df)
            print(df.to_markdown())
        input()
       
    else:
        print('INVALID INPUT!')

cursor.close()
connection.close()
