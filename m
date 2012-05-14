From: Alon Bar-Lev <alon.barlev@...277...>
Date: Tue, 15 May 2012 01:29:39 +0300
Message-Id: <1337034580-26987-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 1/2] cleanup: spec: make space/tab consistent
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
Cc: Alon Bar-Lev <alon.barlev@...277...>

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 distro/rpm/openvpn.spec.in |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/distro/rpm/openvpn.spec.in b/distro/rpm/openvpn.spec.in
index a6f31bd..de46f59 100644
--- a/distro/rpm/openvpn.spec.in
+++ b/distro/rpm/openvpn.spec.in
@@ -12,8 +12,8 @@
 #   rpmbuild -tb [openvpn.x.tar.gz] --define 'with_password_save 1'
 
 Summary:	OpenVPN is a robust and highly flexible VPN daemon by James Yonan.
-Name:           @PACKAGE@
-Version:        @VERSION@
+Name:		@PACKAGE@
+Version:	@VERSION@
 Release:	1
 URL:		http://openvpn.net/
 Source0:	http://prdownloads.sourceforge.net/openvpn/%{name}-%{version}.tar.gz
@@ -30,27 +30,27 @@ BuildRoot:	%{_tmppath}/%{name}-%(id -un)
 
 AutoReq: 0
 
-BuildRequires: openssl-devel >= 0.9.6
-Requires:      openssl       >= 0.9.6
+BuildRequires:	openssl-devel >= 0.9.6
+Requires:	openssl       >= 0.9.6
 
 %if "%{_vendor}" == "Mandrakesoft"
-%{!?without_lzo:BuildRequires: liblzo1-devel >= 1.07}
-%{!?without_lzo:Requires:      liblzo1       >= 1.07}
+%{!?without_lzo:BuildRequires:	liblzo1-devel >= 1.07}
+%{!?without_lzo:Requires:	liblzo1       >= 1.07}
 %else
 %if "%{_vendor}" == "MandrakeSoft"
-%{!?without_lzo:BuildRequires: liblzo1-devel >= 1.07}
-%{!?without_lzo:Requires:      liblzo1       >= 1.07}
+%{!?without_lzo:BuildRequires:	liblzo1-devel >= 1.07}
+%{!?without_lzo:Requires:	liblzo1       >= 1.07}
 %else
-%{!?without_lzo:BuildRequires: lzo-devel >= 1.07}
-%{!?without_lzo:Requires:      lzo       >= 1.07}
+%{!?without_lzo:BuildRequires:	lzo-devel >= 1.07}
+%{!?without_lzo:Requires:	lzo       >= 1.07}
 %endif
 %endif
 
-%{!?without_pam:BuildRequires: pam-devel}
-%{!?without_pam:Requires:      pam}
+%{!?without_pam:BuildRequires:	pam-devel}
+%{!?without_pam:Requires:	pam}
 
-%{?with_pkcs11:BuildRequires: pkcs11-helper-devel}
-%{?with_pkcs11:Requires:      pkcs11-helper}
+%{?with_pkcs11:BuildRequires:	pkcs11-helper-devel}
+%{?with_pkcs11:Requires:	pkcs11-helper}
 
 #
 # Description
@@ -68,7 +68,7 @@ and portability to most major OS platforms.
 %package devel
 Summary:	OpenVPN is a robust and highly flexible VPN daemon by James Yonan.
 Group:		Applications/Internet
-Requires:      %{name}
+Requires:	%{name}
 %description devel
 Development support for OpenVPN.
 
@@ -134,10 +134,10 @@ popd
 # Install init script
 %if "%{VENDOR}" == "SuSE"
 %__install -c -d -m 755 "%{buildroot}/etc/init.d"
-%__install -c -m 755 "distro/rpm/%{name}.init.d.suse"  "%{buildroot}/etc/init.d/%{name}"
+%__install -c -m 755 "distro/rpm/%{name}.init.d.suse" "%{buildroot}/etc/init.d/%{name}"
 %else
 %__install -c -d -m 755 "%{buildroot}/etc/rc.d/init.d"
-%__install -c -m 755 distro/rpm/%{name}.init.d.rhel  "%{buildroot}/etc/rc.d/init.d/%{name}"
+%__install -c -m 755 distro/rpm/%{name}.init.d.rhel "%{buildroot}/etc/rc.d/init.d/%{name}"
 %endif
 
 # Install /etc/openvpn
-- 
1.7.3.4


