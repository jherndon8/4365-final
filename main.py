#!/usr/bin/env python
# -*- coding: utf-8 -*-

import configparser
import os
import time
from selenium import webdriver

# Load configurations
config = configparser.ConfigParser()
config.read(os.getcwd() + os.path.sep + "config.ini")

# Program variables
nsfile_dir = os.getcwd() + os.path.sep + "nsfiles" + os.path.sep
emulab_login_page = "https://www.emulab.net/login.php3"
begin_exp_page = "https://www.emulab.net/beginexp.php"


# Gecko driver needs to be installed for Firefox
# Place executable in PATH (/usr/bin/)
# geckodriver releases: https://github.com/mozilla/geckodriver/releases
driver = webdriver.Firefox()


# Check Login
def login(driver):
    driver.get(emulab_login_page)
    driver.find_element_by_name("uid").send_keys(config['General']['username'])
    driver.find_element_by_name("password").send_keys(config['General']['password'])
    driver.find_element_by_name('login').click()


def new_experiment(driver):
    # Begin a Testbed Experiment
    driver.get(begin_exp_page)
    # Experiment name
    driver.find_element_by_name('formfields[exp_id]').send_keys(config['General']['experiment'])
    # Experiment description
    driver.find_element_by_name('formfields[exp_description]').send_keys(config['General']['description'])
    # NSFile submission
    driver.find_element_by_name("exp_nsfile").send_keys(nsfile_dir + "sample.NSFile")
    # Submit form
    submit_button = driver.find_element_by_xpath("//*[@id=\"fullcontentbody\"]/form/table/tbody/tr[10]/td/b/input")
    submit_button.click()


# Log into Emulab
login(driver)
# Start new experiment
new_experiment(driver)

time.sleep(3)
