From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:28:05 +0200
Message-Id: <1330547285-18481-5-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330547285-18481-1-git-send-email-alon.barlev@...277...>
References: <1330547285-18481-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [easy-rsa 4/4] packaging: rpm: initial add
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
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 Makefile.am                 |    2 +
 configure.ac                |    3 ++
 distro/Makefile.am          |   15 +++++++++
 distro/rpm/Makefile.am      |   15 +++++++++
 distro/rpm/easy-rsa.spec.in |   68 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 103 insertions(+), 0 deletions(-)
 create mode 100644 distro/Makefile.am
 create mode 100644 distro/rpm/Makefile.am
 create mode 100644 distro/rpm/easy-rsa.spec.in

diff --git a/Makefile.am b/Makefile.am
index 743da35..156a3c0 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -35,6 +35,8 @@ MAINTAINERCLEANFILES = \
 
 EXTRA_DIST = doc easy-rsa
 
+SUBDIRS = distro
+
 dist_doc_DATA = \
 	COPYRIGHT.GPL \
 	COPYING
diff --git a/configure.ac b/configure.ac
index 1e52ece..61703a2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -48,5 +48,8 @@ AC_SUBST([easyrsadir])
 AC_CONFIG_FILES([
 	Makefile
 	doc/Makefile
+	distro/Makefile
+	distro/rpm/Makefile
+	distro/rpm/easy-rsa.spec
 ])
 AC_OUTPUT
diff --git a/distro/Makefile.am b/distro/Makefile.am
new file mode 100644
index 0000000..f26dc5a
--- /dev/null
+++ b/distro/Makefile.am
@@ -0,0 +1,15 @@
+#
+#  Easy-RSA -- This is a small RSA key management package, based on the openssl
+#              command line tool, that can be found in the easy-rsa subdirectory
+#              of the OpenVPN distribution.  While this tool is primary concerned
+#              with key management for the SSL VPN application space, it can also
+#              be used for building web certificates.
+#
+#  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
+#
+
+MAINTAINERCLEANFILES = \
+	$(srcdir)/Makefile.in
+
+SUBDIRS = rpm
diff --git a/distro/rpm/Makefile.am b/distro/rpm/Makefile.am
new file mode 100644
index 0000000..49fe48c
--- /dev/null
+++ b/distro/rpm/Makefile.am
@@ -0,0 +1,15 @@
+#
+#  Easy-RSA -- This is a small RSA key management package, based on the openssl
+#              command line tool, that can be found in the easy-rsa subdirectory
+#              of the OpenVPN distribution.  While this tool is primary concerned
+#              with key management for the SSL VPN application space, it can also
+#              be used for building web certificates.
+#
+#  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
+#
+
+MAINTAINERCLEANFILES = \
+	$(srcdir)/Makefile.in
+
+dist_noinst_DATA = easy-rsa.spec
diff --git a/distro/rpm/easy-rsa.spec.in b/distro/rpm/easy-rsa.spec.in
new file mode 100644
index 0000000..f0d9bfa
--- /dev/null
+++ b/distro/rpm/easy-rsa.spec.in
@@ -0,0 +1,68 @@
+#
+#  Easy-RSA -- This is a small RSA key management package, based on the openssl
+#              command line tool, that can be found in the easy-rsa subdirectory
+#              of the OpenVPN distribution.  While this tool is primary concerned
+#              with key management for the SSL VPN application space, it can also
+#              be used for building web certificates.
+#
+#  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License version 2
+#  as published by the Free Software Foundation.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#  GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program (see the file COPYING included with this
+#  distribution); if not, write to the Free Software Foundation, Inc.,
+#  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+#
+
+Summary:	Easy-RSA
+Name:		easy-rsa
+Version:	@PACKAGE_VERSION@
+Release:	1
+License:	GPL-2
+Group:		Security/Cryptography
+Source:		%{name}-%{version}.tar.gz
+Packager:	OpenVPN Technologies, Inc. <sales@...515...>
+Vendor:		OpenVPN Technologies, Inc.
+URL:		http://openvpn.net
+BuildRoot:	%{_tmppath}/%{name}-buildroot
+BuildArch:	noarch
+Requires:	openssl
+%description
+This is a small RSA key management package, based on the openssl
+command line tool, that can be found in the easy-rsa subdirectory
+of the OpenVPN distribution.  While this tool is primary concerned
+with key management for the SSL VPN application space, it can also
+be used for building web certificates.
+
+%prep
+%setup -q
+
+%build
+%configure -q -docdir="%{_docdir}/%{name}-%{version}"
+%{__make}
+
+%install
+rm -rf "${RPM_BUILD_ROOT}"
+%{__make} install DESTDIR="${RPM_BUILD_ROOT}"
+
+%clean
+rm -rf "${RPM_BUILD_ROOT}"
+
+%files
+
+%defattr(-,root,root)
+%{_datadir}/easy-rsa
+%{_docdir}
+ 
+%changelog
+* Fri Feb 24 2012 Alon Bar-Lev <alon.barlev@...277...>
+- Created initial spec file
-- 
1.7.3.4


