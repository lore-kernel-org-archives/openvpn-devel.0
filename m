From: David Sommerseth <davids@...515...>
Date: Wed, 20 Feb 2019 14:19:06 +0100
Message-Id: <20190220131906.22970-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH] cleanup: Remove RPM openvpn.spec build
 approach
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Linux packaging is quite a comprehensive task these days, with many
Linux distributions and each with their own packaging guidelines.  In
addition OpenVPN is packaged for most important Linux distributions
already.

The OpenVPN developers is not capable of keeping track of how all the
various recommend packaging guidelines evoloves and our RPM build
process is no longer consistent with guidelines from Fedora, RHEL or
SUSE packaging.  We also don't receive any updates improving this
situation.  Most likely due to packaging being handled fairly well by
the Linux distributions directly.

In addition comes systemd into play, which more and more Linux
distributions embraces - and even our own RPM openvpn.spec file didn't
account for that move.

This removes all RPM related packaging files and updates the INSTALL
file with pointers to several popular Linux distributions with
accessible information of the OpenVPN packages they provide.  Linux
distributions is most likely much better at keeping the packaging
up-to-shape much better than we.

Signed-off-by: David Sommerseth <davids@...515...>
---
 .gitignore                     |   1 -
 INSTALL                        |  47 +++---
 configure.ac                   |   2 -
 distro/Makefile.am             |   2 +-
 distro/rpm/Makefile.am         |  18 ---
 distro/rpm/openvpn.init.d.rhel | 244 ------------------------------
 distro/rpm/openvpn.init.d.suse | 264 ---------------------------------
 distro/rpm/openvpn.spec.in     | 248 -------------------------------
 8 files changed, 29 insertions(+), 797 deletions(-)
 delete mode 100644 distro/rpm/Makefile.am
 delete mode 100755 distro/rpm/openvpn.init.d.rhel
 delete mode 100644 distro/rpm/openvpn.init.d.suse
 delete mode 100644 distro/rpm/openvpn.spec.in

diff --git a/.gitignore b/.gitignore
index 25009d81..783ea84b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -53,7 +53,6 @@ doc/openvpn.8.html
 /doc/doxygen/html/
 /doc/doxygen/latex/
 /doc/doxygen/openvpn.doxyfile
-distro/rpm/openvpn.spec
 distro/systemd/*.service
 sample/sample-keys/sample-ca/
 vendor/.build
diff --git a/INSTALL b/INSTALL
index d0c7dfa6..7c6c34e8 100644
--- a/INSTALL
+++ b/INSTALL
@@ -228,32 +228,41 @@ ENVIRONMENT for ./configure:
 
 *************************************************************************
 
-BUILDING ON LINUX 2.6+ FROM RPM
+Linux distribution packaging:
 
-You can build a binary RPM directly from the OpenVPN tarball file:
+Each Linux distribution has their own way of doing packaging and their
+own set of guidelines of how proper packaging should be done.  It
+is therefore recommended to reach out to the Linux distributions you
+want to have OpenVPN packaged for directly.  The OpenVPN project wants
+to focus more on the OpenVPN development and less on the packaging
+and how packaging is done in all various distributions.
 
-	rpmbuild -tb [tarball]
+For more details:
 
-This command will build a binary RPM file and place it in the system
-RPM directory.  You can then install the RPM with the standard RPM
-install command:
+* Arch Linux
+  https://www.archlinux.org/packages/?name=openvpn
 
-	rpm -ivh [binary-rpm]
+* Debian
+  https://packages.debian.org/search?keywords=openvpn&searchon=names
+  https://tracker.debian.org/pkg/openvpn
 
-When you install the binary RPM, it will install
-sample-scripts/openvpn.init, which can be used to
-automatically start or stop one or more OpenVPN tunnels on system
-startup or shutdown, based on OpenVPN .conf files in /etc/openvpn.
-See the comments in openvpn.init for more information.
+* Fedora / Fedora EPEL (Red Hat Enterprise Linux/CentOS/Scientific Linux)
+  https://apps.fedoraproject.org/packages/openvpn/overview/
+  https://src.fedoraproject.org/rpms/openvpn
 
-Installing the RPM will also configure the TUN/TAP device node
-for linux 2.6.
+* Gentoo
+  https://packages.gentoo.org/packages/net-vpn/openvpn
+  https://gitweb.gentoo.org/repo/gentoo.git/tree/net-vpn/openvpn
 
-Note that the current openvpn.spec file, which instructs the rpm tool
-how to build a package, will build OpenVPN with all options enabled,
-including OpenSSL, LZO, and pthread linkage.  Therefore all of
-these packages will need to be present prior to the RPM build, unless
-you edit the openvpn.spec file.
+* openSUSE
+  https://build.opensuse.org/package/show/network:vpn/openvpn
+
+* Ubuntu
+  https://packages.ubuntu.com/search?keywords=openvpn
+
+In addition, the OpenVPN community provides a best-effort APT repository
+for Debian and Ubuntu:
+https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos
 
 *************************************************************************
 
diff --git a/configure.ac b/configure.ac
index 84f12edc..dfb268ca 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1389,8 +1389,6 @@ AC_CONFIG_FILES([
 	build/msvc/Makefile
 	build/msvc/msvc-generate/Makefile
 	distro/Makefile
-	distro/rpm/Makefile
-	distro/rpm/openvpn.spec
 	distro/systemd/Makefile
 	doc/Makefile
 	doc/doxygen/Makefile
diff --git a/distro/Makefile.am b/distro/Makefile.am
index e2098c84..a6795c4d 100644
--- a/distro/Makefile.am
+++ b/distro/Makefile.am
@@ -12,4 +12,4 @@
 MAINTAINERCLEANFILES = \
 	$(srcdir)/Makefile.in
 
-SUBDIRS = rpm systemd
+SUBDIRS = systemd
diff --git a/distro/rpm/Makefile.am b/distro/rpm/Makefile.am
deleted file mode 100644
index d16a5ac7..00000000
--- a/distro/rpm/Makefile.am
+++ /dev/null
@@ -1,18 +0,0 @@
-#
-#  OpenVPN -- An application to securely tunnel IP networks
-#             over a single UDP port, with support for SSL/TLS-based
-#             session authentication and key exchange,
-#             packet encryption, packet authentication, and
-#             packet compression.
-#
-#  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
-#  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
-#
-
-MAINTAINERCLEANFILES = \
-	$(srcdir)/Makefile.in
-
-dist_noinst_DATA = \
-	openvpn.spec \
-	openvpn.init.d.rhel \
-	openvpn.init.d.suse
diff --git a/distro/rpm/openvpn.init.d.rhel b/distro/rpm/openvpn.init.d.rhel
deleted file mode 100755
index 04125ca6..00000000
--- a/distro/rpm/openvpn.init.d.rhel
+++ /dev/null
@@ -1,244 +0,0 @@
-#!/bin/sh
-#
-# openvpn       This shell script takes care of starting and stopping
-#               openvpn on RedHat or other chkconfig-based system.
-#
-# chkconfig: 345 24 76
-#
-# description: OpenVPN is a robust and highly flexible tunneling application \
-#              that uses all of the encryption, authentication, and \
-#              certification features of the OpenSSL library to securely \
-#              tunnel IP networks over a single UDP port.
-#
-
-# Contributed to the OpenVPN project by
-# Douglas Keller <doug@...19...>
-# 2002.05.15
-
-# To install:
-#   copy this file to /etc/rc.d/init.d/openvpn
-#   shell> chkconfig --add openvpn
-#   shell> mkdir /etc/openvpn
-#   make .conf or .sh files in /etc/openvpn (see below)
-
-# To uninstall:
-#   run: chkconfig --del openvpn
-
-# Author's Notes:
-#
-# I have created an /etc/init.d init script and enhanced openvpn.spec to
-# automatically register the init script.  Once the RPM is installed you
-# can start and stop OpenVPN with "service openvpn start" and "service
-# openvpn stop".
-#
-# The init script does the following:
-#
-# - Starts an openvpn process for each .conf file it finds in
-#   /etc/openvpn.
-#
-# - If /etc/openvpn/xxx.sh exists for a xxx.conf file then it executes
-#   it before starting openvpn (useful for doing openvpn --mktun...).
-#
-# - In addition to start/stop you can do:
-#
-#   service openvpn reload - SIGHUP
-#   service openvpn reopen - SIGUSR1
-#   service openvpn status - SIGUSR2
-#
-# Modifications:
-#
-# 2003.05.02
-#   * Changed == to = for sh compliance (Bishop Clark).
-#   * If condrestart|reload|reopen|status, check that we were
-#     actually started (James Yonan).
-#   * Added lock, piddir, and work variables (James Yonan).
-#   * If start is attempted twice, without an intervening stop, or
-#     if start is attempted when previous start was not properly
-#     shut down, then kill any previously started processes, before
-#     commencing new start operation (James Yonan).
-#   * Do a better job of flagging errors on start, and properly
-#     returning success or failure status to caller (James Yonan).
-#
-# 2005.04.04
-#   * Added openvpn-startup and openvpn-shutdown script calls
-#     (James Yonan).
-#
-
-# Location of openvpn binary
-openvpn=""
-openvpn_locations="/usr/sbin/openvpn /usr/local/sbin/openvpn"
-for location in $openvpn_locations
-do
-  if [ -f "$location" ]
-  then
-    openvpn=$location
-  fi
-done
-
-# Lockfile
-lock="/var/lock/subsys/openvpn"
-
-# PID directory
-piddir="/var/run/openvpn"
-
-# Our working directory
-work=/etc/openvpn
-
-# Source function library.
-. /etc/rc.d/init.d/functions
-
-# Source networking configuration.
-. /etc/sysconfig/network
-
-# Check that networking is up.
-if [ "${NETWORKING}" = "no" ]
-then
-  echo "Networking is down"
-  exit 0
-fi
-
-# Check that binary exists
-if ! [ -f  $openvpn ] 
-then
-  echo "openvpn binary not found"
-  exit 0
-fi
-
-# See how we were called.
-case "$1" in
-  start)
-	echo -n $"Starting openvpn: "
-
-	/sbin/modprobe tun >/dev/null 2>&1
-
-	# From a security perspective, I think it makes
-	# sense to remove this, and have users who need
-	# it explicitly enable in their --up scripts or
-	# firewall setups.
-
-	#echo 1 > /proc/sys/net/ipv4/ip_forward
-
-	# Run startup script, if defined
-	if [ -f $work/openvpn-startup ]; then
-	    $work/openvpn-startup
-	fi
-
-	if [ ! -d  $piddir ]; then
-	    mkdir $piddir
-	fi
-
-	if [ -f $lock ]; then
-	    # we were not shut down correctly
-	    for pidf in `/bin/ls $piddir/*.pid 2>/dev/null`; do
-	      if [ -s $pidf ]; then
-		kill `cat $pidf` >/dev/null 2>&1
-	      fi
-	      rm -f $pidf
-	    done
-	    rm -f $lock
-	    sleep 2
-	fi
-
-	rm -f $piddir/*.pid
-	cd $work
-
-	# Start every .conf in $work and run .sh if exists
-	errors=0
-	successes=0
-	for c in `/bin/ls *.conf 2>/dev/null`; do
-	    bn=${c%%.conf}
-	    if [ -f "$bn.sh" ]; then
-		. ./$bn.sh
-	    fi
-	    rm -f $piddir/$bn.pid
-	    $openvpn --daemon --writepid $piddir/$bn.pid --config $c --cd $work
-	    if [ $? = 0 ]; then
-		successes=1
-	    else
-		errors=1
-	    fi
-	done
-
-	if [ $errors = 1 ]; then
-	    failure; echo
-	else
-	    success; echo
-	fi
-
-	if [ $successes = 1 ]; then
-	    touch $lock
-	fi
-	;;
-  stop)
-	echo -n $"Shutting down openvpn: "
-	for pidf in `/bin/ls $piddir/*.pid 2>/dev/null`; do
-	  if [ -s $pidf ]; then
-	    kill `cat $pidf` >/dev/null 2>&1
-	  fi
-	  rm -f $pidf
-	done
-
-	# Run shutdown script, if defined
-	if [ -f $work/openvpn-shutdown ]; then
-	    $work/openvpn-shutdown
-	fi
-
-	success; echo
-	rm -f $lock
-	;;
-  restart)
-	$0 stop
-	sleep 2
-	$0 start
-	;;
-  reload)
-	if [ -f $lock ]; then
-	    for pidf in `/bin/ls $piddir/*.pid 2>/dev/null`; do
-		if [ -s $pidf ]; then
-		    kill -HUP `cat $pidf` >/dev/null 2>&1
-		fi
-	    done
-	else
-	    echo "openvpn: service not started"
-	    exit 1
-	fi
-	;;
-  reopen)
-	if [ -f $lock ]; then
-	    for pidf in `/bin/ls $piddir/*.pid 2>/dev/null`; do
-		if [ -s $pidf ]; then
-		    kill -USR1 `cat $pidf` >/dev/null 2>&1
-		fi
-	    done
-	else
-	    echo "openvpn: service not started"
-	    exit 1
-	fi
-	;;
-  condrestart)
-	if [ -f $lock ]; then
-	    $0 stop
-	    # avoid race
-	    sleep 2
-	    $0 start
-	fi
-	;;
-  status)
-	if [ -f $lock ]; then
-	    for pidf in `/bin/ls $piddir/*.pid 2>/dev/null`; do
-		if [ -s $pidf ]; then
-		    kill -USR2 `cat $pidf` >/dev/null 2>&1
-		fi
-	    done
-	    echo "Status written to /var/log/messages"
-	else
-	    echo "openvpn: service not started"
-	    exit 1
-	fi
-        ;;
-  *)
-	echo "Usage: openvpn {start|stop|restart|condrestart|reload|reopen|status}"
-	exit 1
-	;;
-esac
-exit 0
diff --git a/distro/rpm/openvpn.init.d.suse b/distro/rpm/openvpn.init.d.suse
deleted file mode 100644
index 1b4bcf06..00000000
--- a/distro/rpm/openvpn.init.d.suse
+++ /dev/null
@@ -1,264 +0,0 @@
-#!/bin/sh
-### BEGIN INIT INFO
-# Provides:                     openvpn
-# Required-Start:               $network
-# Required-Stop:                $network
-# Default-Start:                3 5
-# Default-Stop:                 0 1 2 6
-# Short-Description:            This shell script takes care of starting and stopping OpenVPN.
-# Description:                  OpenVPN is a robust and highly flexible tunneling application that uses all of the encryption, authentication, and certification features of the OpenSSL library to securely tunnel IP networks over a single UDP port. 
-### END INIT INFO
-
-# Contributed to the OpenVPN project by
-# Douglas Keller <doug@...19...>
-# 2002.05.15
-
-# Modified for SuSE by
-# Frank Plohmann <openvpn@...2497...>
-# 2003.08.24
-# Please feel free to contact me if you have problems or suggestions
-# using this script.
-
-# To install:
-#   copy this file to /etc/rc.d/init.d/openvpn
-#   use the runlevel editor in Yast to add it to runlevel 3 and/or 5
-#   shell> mkdir /etc/openvpn
-#   make .conf or .sh files in /etc/openvpn (see below)
-
-# To uninstall:
-#   use also Yast and the runlevel editor to uninstall
-
-# Author's Notes:
-#
-# I have created an /etc/init.d init script and enhanced openvpn.spec to
-# automatically register the init script.  Once the RPM is installed you
-# can start and stop OpenVPN with "service openvpn start" and "service
-# openvpn stop".
-#
-# The init script does the following:
-#
-# - Starts an openvpn process for each .conf file it finds in
-#   /etc/openvpn.
-#
-# - If /etc/openvpn/xxx.sh exists for a xxx.conf file then it executes
-#   it before starting openvpn (useful for doing openvpn --mktun...).
-#
-# - In addition to start/stop you can do:
-#
-#   /etc/init.d/openvpn reload - SIGHUP
-#   /etc/init.d/openvpn reopen - SIGUSR1
-#   /etc/init.d/openvpn status - SIGUSR2
-
-# Modifications 2003.05.02
-#   * Changed == to = for sh compliance (Bishop Clark).
-#   * If condrestart|reload|reopen|status, check that we were
-#     actually started (James Yonan).
-#   * Added lock, piddir, and work variables (James Yonan).
-#   * If start is attempted twice, without an intervening stop, or
-#     if start is attempted when previous start was not properly
-#     shut down, then kill any previously started processes, before
-#     commencing new start operation (James Yonan).
-#   * Do a better job of flagging errors on start, and properly
-#     returning success or failure status to caller (James Yonan).
-#
-# Modifications 2003.08.24
-#   * Converted the script for SuSE Linux distribution. 
-#	  Tested with version 8.2 (Frank Plohmann).
-#		- removed "chkconfig" header
-#		- added Yast header
-#		- changed installation notes
-#		- corrected path to openvpn binary
-#		- removes sourcing "functions"
-#		- removed sourcing "network"
-#		- removed network checking. it seemed not to work with SuSE.
-#		- added sourcing "rc.status", comments and "rc_reset" command
-#		- removed "success; echo" and "failure; echo" lines
-#		- added "rc_status" lines at the end of each section
-#		- changed "service" to "/etc/init.d/" in "In addition to start/stop"
-#		  section above.
-#
-# Modifications 2005.04.04
-#   * Added openvpn-startup and openvpn-shutdown script calls (James Yonan).
-#
-
-# Location of openvpn binary
-openvpn="/usr/sbin/openvpn"
-
-# Lockfile
-lock="/var/lock/subsys/openvpn"
-
-# PID directory
-piddir="/var/run/openvpn"
-
-# Our working directory
-work=/etc/openvpn
-
-# Source rc functions
-. /etc/rc.status
-
-# Shell functions sourced from /etc/rc.status:
-#      rc_check         check and set local and overall rc status
-#      rc_status        check and set local and overall rc status
-#      rc_status -v     ditto but be verbose in local rc status
-#      rc_status -v -r  ditto and clear the local rc status
-#      rc_failed        set local and overall rc status to failed
-#      rc_reset         clear local rc status (overall remains)
-#      rc_exit          exit appropriate to overall rc status
-
-#      rc_status        check and set local and overall rc status
-#      rc_status -v     ditto but be verbose in local rc status
-#      rc_status -v -r  ditto and clear the local rc status
-#      rc_failed        set local and overall rc status to failed
-#      rc_reset         clear local rc status (overall remains)
-#      rc_exit          exit appropriate to overall rc status
-
-# First reset status of this service
-rc_reset
-
-[ -f  $openvpn ] || exit 0
-
-# See how we were called.
-case "$1" in
-  start)
-	echo -n $"Starting openvpn: "
-
-	/sbin/modprobe tun >/dev/null 2>&1
-
-	# From a security perspective, I think it makes
-	# sense to remove this, and have users who need
-	# it explicitly enable in their --up scripts or
-	# firewall setups.
-
-	#echo 1 > /proc/sys/net/ipv4/ip_forward
-
-	# Run startup script, if defined
-	if [ -f $work/openvpn-startup ]; then
-	    $work/openvpn-startup
-	fi
-
-	if [ ! -d  $piddir ]; then
-	    mkdir $piddir
-	fi
-
-	if [ -f $lock ]; then
-	    # we were not shut down correctly
-	    for pidf in `/bin/ls $piddir/*.pid 2>/dev/null`; do
-	      if [ -s $pidf ]; then
-		kill `cat $pidf` >/dev/null 2>&1
-	      fi
-	      rm -f $pidf
-	    done
-	    rm -f $lock
-	    sleep 2
-	fi
-
-	rm -f $piddir/*.pid
-	cd $work
-
-	# Start every .conf in $work and run .sh if exists
-	errors=0
-	successes=0
-	for c in `/bin/ls *.conf 2>/dev/null`; do
-	    bn=${c%%.conf}
-	    if [ -f "$bn.sh" ]; then
-		. ./$bn.sh
-	    fi
-	    rm -f $piddir/$bn.pid
-	    $openvpn --daemon --writepid $piddir/$bn.pid --config $c --cd $work
-	    if [ $? = 0 ]; then
-		successes=1
-	    else
-		errors=1
-	    fi
-	done
-
-	if [ $successes = 1 ]; then
-	    touch $lock
-	fi
-
-	rc_status -v
-	;;
-  stop)
-	echo -n $"Shutting down openvpn: "
-	for pidf in `/bin/ls $piddir/*.pid 2>/dev/null`; do
-	  if [ -s $pidf ]; then
-	    kill `cat $pidf` >/dev/null 2>&1
-	  fi
-	  rm -f $pidf
-	done
-
-	# Run shutdown script, if defined
-	if [ -f $work/openvpn-shutdown ]; then
-	    $work/openvpn-shutdown
-	fi
-
-	rm -f $lock
-
-	rc_status -v
-	;;
-  restart)
-	$0 stop
-	sleep 2
-	$0 start
-
-	rc_status
-	;;
-  reload)
-	if [ -f $lock ]; then
-	    for pidf in `/bin/ls $piddir/*.pid 2>/dev/null`; do
-		if [ -s $pidf ]; then
-		    kill -HUP `cat $pidf` >/dev/null 2>&1
-		fi
-	    done
-	else
-	    echo "openvpn: service not started"
-	    exit 1
-	fi
-
-	rc_status -v
-	;;
-  reopen)
-	if [ -f $lock ]; then
-	    for pidf in `/bin/ls $piddir/*.pid 2>/dev/null`; do
-		if [ -s $pidf ]; then
-		    kill -USR1 `cat $pidf` >/dev/null 2>&1
-		fi
-	    done
-	else
-	    echo "openvpn: service not started"
-	    exit 1
-	fi
-
-	rc_status -v
-	;;
-  condrestart)
-	if [ -f $lock ]; then
-	    $0 stop
-	    # avoid race
-	    sleep 2
-	    $0 start
-	fi
-
-	rc_status
-	;;
-  status)
-	if [ -f $lock ]; then
-	    for pidf in `/bin/ls $piddir/*.pid 2>/dev/null`; do
-		if [ -s $pidf ]; then
-		    kill -USR2 `cat $pidf` >/dev/null 2>&1
-		fi
-	    done
-	    echo "Status written to /var/log/messages"
-	else
-	    echo "openvpn: service not started"
-	    exit 1
-	fi
-
-	rc_status -v
-        ;;
-  *)
-	echo "Usage: openvpn {start|stop|restart|condrestart|reload|reopen|status}"
-	exit 1
-esac
-
-exit 0
diff --git a/distro/rpm/openvpn.spec.in b/distro/rpm/openvpn.spec.in
deleted file mode 100644
index 20a8c890..00000000
--- a/distro/rpm/openvpn.spec.in
+++ /dev/null
@@ -1,248 +0,0 @@
-# OpenVPN spec file, used to drive rpmbuild
-
-# OPTIONS
-#
-# Disable LZO
-#   rpmbuild -tb [openvpn.x.tar.gz] --define 'without_lzo 1'
-#
-# Disable PAM plugin
-#   rpmbuild -tb [openvpn.x.tar.gz] --define 'without_pam 1'
-#
-# Allow passwords to be read from files
-#   rpmbuild -tb [openvpn.x.tar.gz] --define 'with_password_save 1'
-
-Summary:	OpenVPN is a robust and highly flexible VPN daemon by James Yonan.
-Name:		@PACKAGE@
-Version:	@VERSION@
-Release:	1
-URL:		http://openvpn.net/
-Source0:	http://prdownloads.sourceforge.net/openvpn/%{name}-%{version}.tar.gz
-
-License:	GPL
-Group:		Applications/Internet
-Vendor:		James Yonan <jim@...41...>
-Packager:	James Yonan <jim@...41...>
-BuildRoot:	%{_tmppath}/%{name}-%(id -un)
-
-#
-# Include dependencies manually
-#
-
-AutoReq: 0
-
-BuildRequires:	openssl-devel >= 0.9.7
-Requires:	openssl       >= 0.9.7
-
-%if "%{_vendor}" == "Mandrakesoft"
-%{!?without_lzo:BuildRequires:	liblzo1-devel >= 1.07}
-%{!?without_lzo:Requires:	liblzo1       >= 1.07}
-%else
-%if "%{_vendor}" == "MandrakeSoft"
-%{!?without_lzo:BuildRequires:	liblzo1-devel >= 1.07}
-%{!?without_lzo:Requires:	liblzo1       >= 1.07}
-%else
-%{!?without_lzo:BuildRequires:	lzo-devel >= 1.07}
-%{!?without_lzo:Requires:	lzo       >= 1.07}
-%endif
-%endif
-
-%{!?without_pam:BuildRequires:	pam-devel}
-%{!?without_pam:Requires:	pam}
-
-%{?with_pkcs11:BuildRequires:	pkcs11-helper-devel}
-%{?with_pkcs11:Requires:	pkcs11-helper}
-
-#
-# Description
-#
-
-%description
-OpenVPN is a robust and highly flexible VPN daemon by James Yonan.
-OpenVPN supports SSL/TLS security,
-ethernet bridging,
-TCP or UDP tunnel transport through proxies or NAT,
-support for dynamic IP addresses and DHCP,
-scalability to hundreds or thousands of users,
-and portability to most major OS platforms.
-
-%package devel
-Summary:	OpenVPN is a robust and highly flexible VPN daemon by James Yonan.
-Group:		Applications/Internet
-Requires:	%{name}
-%description devel
-Development support for OpenVPN.
-
-#
-# Define vendor type
-#
-
-%if "%{_vendor}" == "suse" || "%{_vendor}" == "pc"
-%define VENDOR SuSE
-%else
-%define VENDOR %_vendor
-%endif
-
-#
-# Other definitions
-#
-
-%define debug_package %{nil}
-
-#
-# Build OpenVPN binary
-#
-
-%prep
-%setup -q
-
-%build
-%configure \
-	--disable-dependency-tracking \
-	--docdir="%{_docdir}/%{name}-%{version}" \
-	%{?with_password_save:--enable-password-save} \
-	%{!?without_lzo:--enable-lzo} \
-	%{?with_pkcs11:--enable-pkcs11} \
-	%{?without_pam:--disable-plugin-auth-pam}
-%__make
-
-#
-# Installation section
-#
-
-%install
-[ %{buildroot} != "/" ] && rm -rf %{buildroot}
-%__make install DESTDIR="%{buildroot}"
-
-# Install init script
-%if "%{VENDOR}" == "SuSE"
-%__install -c -d -m 755 "%{buildroot}/etc/init.d"
-%__install -c -m 755 "distro/rpm/%{name}.init.d.suse" "%{buildroot}/etc/init.d/%{name}"
-%else
-%__install -c -d -m 755 "%{buildroot}/etc/rc.d/init.d"
-%__install -c -m 755 distro/rpm/%{name}.init.d.rhel "%{buildroot}/etc/rc.d/init.d/%{name}"
-%endif
-
-# Install /etc/openvpn
-%__install -c -d -m 755 "%{buildroot}/etc/%{name}"
-
-# Install extra %doc stuff
-cp -r AUTHORS ChangeLog NEWS contrib/ sample/ \
-	"%{buildroot}/%{_docdir}/%{name}-%{version}"
-
-#
-# Clean section
-#
-
-%clean
-[ %{buildroot} != "/" ] && rm -rf "%{buildroot}"
-
-#
-# On Linux 2.4, make the device node
-#
-
-%post
-case "`uname -r`" in
-2.4*)
-	/bin/mkdir /dev/net >/dev/null 2>&1
-	/bin/mknod /dev/net/tun c 10 200 >/dev/null 2>&1
-	;;
-esac
-
-#
-# Handle the init script
-#
-
-/sbin/chkconfig --add %{name}
-%if "%{VENDOR}" == "SuSE"
-/etc/init.d/openvpn restart
-%else
-/sbin/service %{name} condrestart
-%endif
-%preun
-if [ "$1" = 0 ]
-then
-	%if "%{VENDOR}" == "SuSE"
-	/etc/init.d/openvpn stop
-	%else
-	/sbin/service %{name} stop
-	%endif
-	/sbin/chkconfig --del %{name}
-fi
-
-#
-# Files section
-#
-# don't use %doc as old rpmbuild removes it[1].
-# [1] http://rpm.org/ticket/836
-
-%files
-%defattr(-,root,root)
-%{_mandir}
-%{_sbindir}/%{name}
-%{_libdir}/%{name}
-%{_docdir}/%{name}-%{version}
-%dir /etc/%{name}
-%if "%{VENDOR}" == "SuSE"
-/etc/init.d/%{name}
-%else
-/etc/rc.d/init.d/%{name}
-%endif
-
-%files devel
-%defattr(-,root,root)
-%{_includedir}/*
-
-%changelog
-* Thu Jul 30 2009 David Sommerseth <dazo@...384...>
-- Removed management/ directory from %doc
-
-* Thu Dec 14 2006 Alon Bar-Lev
-- Added with_pkcs11
-
-* Mon Aug 2 2005 James Yonan
-- Fixed build problem with --define 'without_pam 1'
-
-* Mon Apr 4 2005 James Yonan
-- Moved some files from /usr/share/openvpn to %doc for compatibility
-  with Dag Wieers' RPM repository
-
-* Sat Mar 12 2005 Tom Walsh
-- Added MandrakeSoft liblzo1 require
-
-* Fri Dec 10 2004 James Yonan
-- Added AutoReq: 0 for manual dependencies
-
-* Fri Dec 10 2004 James Yonan
-- Packaged the plugins
-
-* Sun Nov 7 2004 Umberto Nicoletti
-- SuSE support
-
-* Wed Aug 18 2004 Bishop Clark (LC957) <bishop@...7...>
-- restrict what we claim in /etc/ to avoid ownership conflicts
-
-* Sun Feb 23 2003 Matthias Andree <matthias.andree@...68...> 1.3.2.14-1.
-- Have the version number filled in by autoconf.
-
-* Wed Jul 10 2002 James Yonan <jim@...41...> 1.3.1-1
-- Fixed %preun to only remove service on final uninstall
-
-* Mon Jun 17 2002 bishop clark (LC957) <bishop@...7...> 1.2.2-1
-- Added condrestart to openvpn.spec & openvpn.init.
-
-* Wed May 22 2002 James Yonan <jim@...41...> 1.2.0-1
-- Added mknod for Linux 2.4.
-
-* Wed May 15 2002 Doug Keller <dsk@...19...> 1.1.1.16-2
-- Added init scripts
-- Added conf file support
-
-* Mon May 13 2002 bishop clark (LC957) <bishop@...7...> 1.1.1.14-1
-- Added new directories for config examples and such
-
-* Sun May 12 2002 bishop clark (LC957) <bishop@...7...> 1.1.1.13-1
-- Updated buildroot directive and cleanup command
-- added easy-rsa utilities
-
-* Mon Mar 25 2002 bishop clark (LC957) <bishop@...7...> 1.0-1
-- Initial build.
-- 
2.17.1


