From: David Sommerseth <davids@...515...>
Date: Thu, 18 May 2017 21:20:15 +0200
Message-Id: <20170518192015.28402-1-davids@...515...>
In-Reply-To: <20170518155020.GN97029@...1296...>
References: <20170518155020.GN97029@...1296...>
Subject: [Openvpn-devel] [PATCH] distro: Remove outdated RPM .spec file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Each RPM based distro have their own set of packaging guidelines.  We
don't adhere to any of them and we're bad at keeping this up-to-date.
Rather let distros take care of this job.

Signed-off-by: David Sommerseth <davids@...515...>
---
 distro/rpm/openvpn.spec.in                | 248 ------------------------------
 distro/{rpm => sys-v}/Makefile.am         |   1 -
 distro/{rpm => sys-v}/openvpn.init.d.rhel |   0
 distro/{rpm => sys-v}/openvpn.init.d.suse |   0
 4 files changed, 249 deletions(-)
 delete mode 100644 distro/rpm/openvpn.spec.in
 rename distro/{rpm => sys-v}/Makefile.am (97%)
 rename distro/{rpm => sys-v}/openvpn.init.d.rhel (100%)
 rename distro/{rpm => sys-v}/openvpn.init.d.suse (100%)

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
diff --git a/distro/rpm/Makefile.am b/distro/sys-v/Makefile.am
similarity index 97%
rename from distro/rpm/Makefile.am
rename to distro/sys-v/Makefile.am
index 37ee099a..98a6e2f4 100644
--- a/distro/rpm/Makefile.am
+++ b/distro/sys-v/Makefile.am
@@ -13,6 +13,5 @@ MAINTAINERCLEANFILES = \
 	$(srcdir)/Makefile.in
 
 dist_noinst_DATA = \
-	openvpn.spec \
 	openvpn.init.d.rhel \
 	openvpn.init.d.suse
diff --git a/distro/rpm/openvpn.init.d.rhel b/distro/sys-v/openvpn.init.d.rhel
similarity index 100%
rename from distro/rpm/openvpn.init.d.rhel
rename to distro/sys-v/openvpn.init.d.rhel
diff --git a/distro/rpm/openvpn.init.d.suse b/distro/sys-v/openvpn.init.d.suse
similarity index 100%
rename from distro/rpm/openvpn.init.d.suse
rename to distro/sys-v/openvpn.init.d.suse
-- 
2.11.0


