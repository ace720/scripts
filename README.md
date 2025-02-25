## Various automation-scripts for Linux

**This repo contain a compilation of various scripts to automate linux chores!**

## Introduction

**In this repo, one can find various helpful scripts written in bash for
automating linux chores like cleaning up unneeded files (generated or created
by the user). Because some of these scripts require scheduling, we will use
systemd timers for scheduling,systemd timers provide a flexible mechanism for
scheduling and managing jobs and services.**

## Scripts in this repo

1.  [Script for empting folder contents.](tempfile.sh)** To keep files organized,
    i have created a temporary directory called temp which stores all files
    that i won't be needing them after working on them, especially some other
    people files that happened to use my computer to accomplish that particular
    task. So instead of manually locating and deleting those files, this script
    helps empting those files without any manual intervention.**
2.  
    [Script for managing installation and other services for Arch Linux.](simpleAppsManager.sh)**
    This script helps people who are scared of command line, but are using
    linux.**
3.  
    [Script for automating package installation from local "directory" packages.](update.sh)**
    This script will try to install/update packages from a
    current-working-directory. To use this you need to navigate to the
    directory where the actuals packages resides, and execute this particular
    script and you are done.**

## Why we use systemd timers

1.  **It is easy to schedule scripts, even starting a specific process as soon as
    the machine boots.**
2.  **Also systemd timers provide a mechanism to run missed jobs which is an
    advantage over cron scheduling unless you are using anacron.**

### 2.0 Systemd timer concept

<<<<<<< HEAD
 1. It is easy to schedule scripts, even starting a specific process as soon as the machine boots.
 2. Also 'systemd' timers provide a mechanism to run missed jobs which is an advantage over cron scheduling unless you are using anacron.
=======
**With systemd timer units scripts (jobs) can be executed based on the time and
date or on events.**
>>>>>>> a80a5acda64bacf53d206a4c24a44551f0ad3aae

### 2.1 Creating systemd timer

    1.  **First we will create a systemd service that tells systemd which 
        application to run. Create the file 
        `/etc/systemd/system/serviceName.service` with the following
        content(replace the description and ExecStart with your value):**

        ```systemd
        **[Unit]**
        **Description="Service description goes here"**


        **[Service]**
        **Environment="HOME=/path/to/your/homeDir"**
        **ExecStart=/path/to/your/script**
        ```
    2.  **Then create another file `/etc/systemd/system/serviceName.timer` with
        the following content:**

        ```systemd
        **[Unit]**
        **Description="Run serviceName.service every Friday at 10:00"**


        **[Timer]**
        **OnCalendar=Fri *-*-* 10:00:***
        **Unit=serviceName.service**


        **[Install]**
        **WantedBy=multi-user.target**
        ```
        **The \[Unit] and \[Service] sections are the minimum sections required
        for a service file to work. systemd service files normally contain an
        \[Install] section that determines one or more targets for a service to
        load. This section is not required in service files for timers, since
        this information is provided with the timer file        .**

    3.  **Verify that the files you created contains no errors. Execute the
        following line (replace the serviceName if you have change the name),
        if the command return no output then the files have passed the
        verification successfully.**

        ```systemd
        **systemd-analyze verify /etc/systemd/system/serviceName.***
        ```
    4.  **Start the timer.**

        ```systemd
        **sudo systemctl start serviceName.timer**
        ```
        **NOTE         This activate the timer for current boot-session only. Also make
        sure you have sudo previledges to start the service.systemd timers can
        also be used as regular user but regular user triggered systemd timers
        can only be active run during an active session. Timer and service
        files must be placed in         `~/.config/systemd/user/        `. Following is an
        example of regular user starting systemd timer:**

        ```systemd
        **systemctl --user start ~/.config/systemd/user/serviceName.timer**
        **systemdctl --user enable ~/.config/systemd/user/serviceName.timer**
        ```
    5.  **Running missed scheduled timers. If a systemd timer was inactive or the
        system was off during the expected execution time, missed events can
        optionally triggered immediately when the timer is activated again. To
        enable this,  add the configuration option `Persistent=true` to the `
        \[Timer]` section:**

        ```systemd
        **OnCalendar=Fri *-*-* 10:00**
        **Persistent=true**
        **Unit=serviceName.service**
        ```
### 2.3 For more information regarding systemd timer

  * 
    [Working with systemd timers](https://documentation.suse.com/smart/systems-management/html/systemd-working-with-timers/index.html#systemd-timer-types-realtime)

## Usage

**To use scripts from this repository, make sure temp directory is available or
after cloning the repo edit the 'tempfile.sh' script and replace the variable
value of `DIR={your-temp-dir}` to your temp directory liking.**

1.  **Clone the repository to your linux-machine.**
2.  **Schedule the jobs using systemd(refer the above section on how to create a
    schedule) or cron.**

## Contributing

**If you do like to contribute to scripts automation, here are some guidelines:**

1.  **Fork the repository.**
2.  **Create a new branch for your changes.**
3.  **Make your changes.**
4.  **Test your changes.**
5.  **Commit your changes.**
6.  **Push changes to your forked repository.**
7.  **Submit a pull request.**

## License

**Scripts is released under the MIT License.**

## Authors and Acknowledgement

**Scripts automation was created by [Mkadam Msabaha](https://github.com/ace720)**

## Contact

**If you have any questions or comments about Scripts automation, please contact 
[Mkadam Msabaha](imkadam@hotmail.my)**

