#!/usr/bin/env python
# -*- coding: utf-8 -*-

import configparser
import os
import time
from selenium import webdriver


# Program variables
nsfile_dir = os.getcwd() + os.path.sep + "nsfiles" + os.path.sep
emulab_login_page = "https://www.emulab.net/login.php3"
begin_exp_page = "https://www.emulab.net/beginexp.php"
exp_page_base = "https://www.emulab.net/showexp.php3"


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
    driver.find_element_by_name("exp_nsfile").send_keys(nsfile_dir + config['General']['nsfile'])
    # Submit form
    submit_button = driver.find_element_by_xpath("//*[@id=\"fullcontentbody\"]/form/table/tbody/tr[10]/td/b/input")
    submit_button.click()


def swap_in_exp(driver):
    exp_page = exp_page_base + "?pid={}&eid={}".format(config['General']['project'], config['General']['experiment'])
    # Experiment page
    driver.get(exp_page)
    # Swap control page
    driver.find_element_by_link_text("Swap Experiment In").click()
    # Confirm swap
    driver.find_element_by_name('confirmed').click()


def cancel_swap(driver):
    exp_page = exp_page_base + "?pid={}&eid={}".format(config['General']['project'], config['General']['experiment'])
    # Experiment page
    driver.get(exp_page)
    # Swap control page
    driver.find_element_by_link_text("Cancel Experiment Swapin").click()
    # Confirm swap
    driver.find_element_by_name('confirmed').click()


def swap_out_exp(driver):
    exp_page = exp_page_base + "?pid={}&eid={}".format(config['General']['project'], config['General']['experiment'])
    # Experiment page
    driver.get(exp_page)
    # Swap control page
    driver.find_element_by_link_text("Swap Experiment Out").click()
    # Confirm swap out
    driver.find_element_by_name('confirmed').click()


def main(driver):
    # Log into Emulab
    login(driver)
    # Swap out experiment
    new_experiment(driver)


if __name__ == '__main__':
    # Load configurations
    config = configparser.ConfigParser()
    config.read(os.getcwd() + os.path.sep + "config.ini")

    # Gecko driver needs to be installed for Firefox
    # Place executable in PATH (/usr/bin/)
    # geckodriver releases: https://github.com/mozilla/geckodriver/releases
    new_driver = webdriver.Firefox()

    main(new_driver)
