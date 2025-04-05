From: "d12fk (Code Review)" <gerrit@...515...>
Date: Sat, 5 Apr 2025 04:11:42 +0000
In-Reply-To: <gerrit.1733989644000.Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10@...2715...>
References: <gerrit.1733989644000.Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <d58d15256249d44bfce9d8c2db3b9171dc2919b6-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mhfmDBFhPbo="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dns: apply settings
 via script on unixoid systems
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mhfmDBFhPbo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, d12fk, plaisthos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail

to look at the new patch set (#20).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


Change subject: dns: apply settings via script on unixoid systems
......................................................................

dns: apply settings via script on unixoid systems

This introduces a new script hook, the dns-updown, and implements such a
command script for a few popular systems (and a default for the not so
popular ones). Like the name suggests this hook is soleley for dealing
with modifying how names are resolved when the VPN pushes some --dns
settings.

The default dns updown command is part of the distribution and is
installed with openvpn. You can change the path the command is located
at as a compile time option, defaults to libexecdir.

You can compile-time disable that the default dns-updown hook is
run by passing --disable-dns-updown-by-default to configure or
ccmake ENABLE_DNS_UPDOWN_BY_DEFAULT to OFF.

There's also a new runtime option --dns-updown, which can run a custom
command, force running the default when disabled or disable execution
of the dns-updown altogether.

Change-Id: Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M .gitignore
M CMakeLists.txt
M config.h.cmake.in
M configure.ac
M distro/Makefile.am
A distro/dns-scripts/Makefile.am
A distro/dns-scripts/haikuos_file-dns-updown.sh
A distro/dns-scripts/openresolv-dns-updown.sh
A distro/dns-scripts/resolvconf_file-dns-updown.sh
A distro/dns-scripts/systemd-dns-updown.sh
M doc/man-sections/script-options.rst
M src/openvpn/Makefile.am
M src/openvpn/dns.c
M src/openvpn/dns.h
M src/openvpn/options.c
15 files changed, 658 insertions(+), 10 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/38/838/20

diff --git a/.gitignore b/.gitignore
index db8bb73..04523af 100644
--- a/.gitignore
+++ b/.gitignore
@@ -49,6 +49,7 @@
 /doc/doxygen/latex/
 /doc/doxygen/openvpn.doxyfile
 distro/systemd/*.service
+distro/dns-scripts/dns-updown
 sample/sample-keys/sample-ca/
 vendor/cmocka_build
 vendor/dist
diff --git a/CMakeLists.txt b/CMakeLists.txt
index b04adce..ef4a0f2 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -41,7 +41,10 @@
 option(USE_WERROR "Treat compiler warnings as errors (-Werror)" ON)
 option(FAKE_ANDROID "Target Android but do not use actual cross compile/An=
droid cmake to build for simple compile checks on Linux")

-set(PLUGIN_DIR /usr/local/lib/openvpn/plugins CACHE FILEPATH "Location of =
the plugin directory")
+option(ENABLE_DNS_UPDOWN_BY_DEFAULT "Run --dns-updown hook by default" ON)
+set(DNS_UPDOWN_PATH "${CMAKE_INSTALL_PREFIX}/libexec/openvpn/dns-updown" C=
ACHE STRING "Default location for the DNS up/down script")
+
+set(PLUGIN_DIR "${CMAKE_INSTALL_PREFIX}/lib/openvpn/plugins" CACHE FILEPAT=
H "Location of the plugin directory")

 # Create machine readable compile commands
 option(ENABLE_COMPILE_COMMANDS "Generate compile_commands.json and a symli=
nk for clangd to find it" OFF)
@@ -577,6 +580,8 @@

 add_library_deps(openvpn)

+target_compile_options(openvpn PRIVATE -DDEFAULT_DNS_UPDOWN=3D\"${DNS_UPDO=
WN_PATH}\")
+
 if(MINGW)
     target_compile_options(openvpn PRIVATE -municode -UUNICODE)
     target_link_options(openvpn PRIVATE -municode)
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 2f7b43d..5164ce3 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -35,6 +35,9 @@
 /* Enable LZO compression library */
 #cmakedefine ENABLE_LZO

+/* Enable dns-updown script hook */
+#cmakedefine ENABLE_DNS_UPDOWN
+
 /* Enable NTLMv2 proxy support */
 #define ENABLE_NTLM 1

diff --git a/configure.ac b/configure.ac
index 9777e36..75367e8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -96,6 +96,13 @@
 )

 AC_ARG_ENABLE(
+	[dns-updown-by-default],
+	[AS_HELP_STRING([--disable-dns-updown-by-default], [disable running --dns=
-updown by default @<:@default=3Dyes@:>@])],
+	,
+	[enable_dns_updown_by_default=3D"yes"]
+)
+
+AC_ARG_ENABLE(
 	[ntlm],
 	[AS_HELP_STRING([--disable-ntlm], [disable NTLMv2 proxy support @<:@defau=
lt=3Dyes@:>@])],
 	,
@@ -315,37 +322,50 @@
 	plugindir=3D"\${libdir}/openvpn/plugins"
 fi

+AC_ARG_VAR([SCRIPTDIR], [Path of script directory @<:@default=3DPKGLIBEXEC=
DIR@:>@])
+if test -n "${SCRIPTDIR}"; then
+	scriptdir=3D"${SCRIPTDIR}"
+else
+	scriptdir=3D"\${pkglibexecdir}"
+fi
+
 AC_DEFINE_UNQUOTED([TARGET_ALIAS], ["${host}"], [A string representing our=
 host])
-AM_CONDITIONAL([TARGET_LINUX], [false])
+AM_CONDITIONAL([ENABLE_DNS_UPDOWN],[true])
 case "$host" in
 	*-*-linux*)
 		AC_DEFINE([TARGET_LINUX], [1], [Are we running on Linux?])
-		AM_CONDITIONAL([TARGET_LINUX], [true])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["L"], [Target prefix])
+		AC_SUBST([DNS_UPDOWN_TYPE], ["systemd"])
 		have_sitnl=3D"yes"
 		pkg_config_required=3D"yes"
 		;;
 	*-*-solaris*)
 		AC_DEFINE([TARGET_SOLARIS], [1], [Are we running on Solaris?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["S"], [Target prefix])
+		AC_SUBST([DNS_UPDOWN_TYPE], ["resolvconf_file"])
 		CPPFLAGS=3D"$CPPFLAGS -D_XPG4_2"
 		test -x /bin/bash && SHELL=3D"/bin/bash"
 		;;
 	*-*-openbsd*)
 		AC_DEFINE([TARGET_OPENBSD], [1], [Are we running on OpenBSD?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["O"], [Target prefix])
+		AC_SUBST([DNS_UPDOWN_TYPE], ["resolvconf_file"])
 		;;
 	*-*-freebsd*)
 		AC_DEFINE([TARGET_FREEBSD], [1], [Are we running on FreeBSD?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["F"], [Target prefix])
+		AC_SUBST([DNS_UPDOWN_TYPE], ["openresolv"])
 		;;
 	*-*-netbsd*)
 		AC_DEFINE([TARGET_NETBSD], [1], [Are we running NetBSD?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["N"], [Target prefix])
+		AC_SUBST([DNS_UPDOWN_TYPE], ["openresolv"])
 		;;
 	*-*-darwin*)
 		AC_DEFINE([TARGET_DARWIN], [1], [Are we running on Mac OS X?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["M"], [Target prefix])
+		AM_CONDITIONAL([ENABLE_DNS_UPDOWN], [false])
+		AC_SUBST([DNS_UPDOWN_TYPE], ["resolvconf_file"])
 		have_tap_header=3D"yes"
 		ac_cv_type_struct_in_pktinfo=3Dno
 		;;
@@ -353,6 +373,8 @@
 		AC_DEFINE([TARGET_WIN32], [1], [Are we running WIN32?])
 		AC_DEFINE([ENABLE_DCO], [1], [DCO is always enabled on Windows])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["W"], [Target prefix])
+		AM_CONDITIONAL([ENABLE_DNS_UPDOWN], [false])
+		AC_SUBST([DNS_UPDOWN_TYPE], ["windows"])
 		CPPFLAGS=3D"${CPPFLAGS} -DWIN32_LEAN_AND_MEAN"
 		CPPFLAGS=3D"${CPPFLAGS} -DNTDDI_VERSION=3DNTDDI_VISTA -D_WIN32_WINNT=3D_=
WIN32_WINNT_VISTA"
 		WIN32=3Dyes
@@ -360,10 +382,12 @@
 	*-*-dragonfly*)
 		AC_DEFINE([TARGET_DRAGONFLY], [1], [Are we running on DragonFlyBSD?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["D"], [Target prefix])
+		AC_SUBST([DNS_UPDOWN_TYPE], ["openresolv"])
 		;;
 	*-aix*)
 		AC_DEFINE([TARGET_AIX], [1], [Are we running AIX?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["A"], [Target prefix])
+		AC_SUBST([DNS_UPDOWN_TYPE], ["resolvconf_file"])
 		ROUTE=3D"/usr/sbin/route"
 		have_tap_header=3D"yes"
 		ac_cv_header_net_if_h=3D"no"	# exists, but breaks things
@@ -371,10 +395,12 @@
 	*-*-haiku*)
 		AC_DEFINE([TARGET_HAIKU], [1], [Are we running Haiku?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["H"], [Target prefix])
+		AC_SUBST([DNS_UPDOWN_TYPE], ["haikuos_file"])
 		LIBS=3D"${LIBS} -lnetwork"
 		;;
 	*)
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["X"], [Target prefix])
+		AC_SUBST([DNS_UPDOWN_TYPE], ["resolvconf_file"])
 		have_tap_header=3D"yes"
 		;;
 esac
@@ -1317,7 +1343,7 @@
 test "${enable_small}" =3D "yes" && AC_DEFINE([ENABLE_SMALL], [1], [Enable=
 smaller executable size])
 test "${enable_fragment}" =3D "yes" && AC_DEFINE([ENABLE_FRAGMENT], [1], [=
Enable internal fragmentation support])
 test "${enable_port_share}" =3D "yes" && AC_DEFINE([ENABLE_PORT_SHARE], [1=
], [Enable TCP Server port sharing])
-
+test "${enable_dns_updown_by_default}" =3D "yes" && AC_DEFINE([ENABLE_DNS_=
UPDOWN_BY_DEFAULT], [1], [Enable dns-updown hook by default])
 test "${enable_ntlm}" =3D "yes" && AC_DEFINE([ENABLE_NTLM], [1], [Enable N=
TLMv2 proxy support])
 test "${enable_crypto_ofb_cfb}" =3D "yes" && AC_DEFINE([ENABLE_OFB_CFB_MOD=
E], [1], [Enable OFB and CFB cipher modes])
 if test "${have_export_keying_material}" =3D "yes"; then
@@ -1505,6 +1531,7 @@

 sampledir=3D"\$(docdir)/sample"
 AC_SUBST([plugindir])
+AC_SUBST([scriptdir])
 AC_SUBST([sampledir])

 AC_SUBST([systemdunitdir])
@@ -1541,6 +1568,7 @@
 	Makefile
 	distro/Makefile
 	distro/systemd/Makefile
+	distro/dns-scripts/Makefile
 	doc/Makefile
 	doc/doxygen/Makefile
 	doc/doxygen/openvpn.doxyfile
diff --git a/distro/Makefile.am b/distro/Makefile.am
index 7a588da..26f577b 100644
--- a/distro/Makefile.am
+++ b/distro/Makefile.am
@@ -13,3 +13,7 @@
 	$(srcdir)/Makefile.in

 SUBDIRS =3D systemd
+
+if ENABLE_DNS_UPDOWN
+SUBDIRS +=3D dns-scripts
+endif
diff --git a/distro/dns-scripts/Makefile.am b/distro/dns-scripts/Makefile.am
new file mode 100644
index 0000000..ec7bfde
--- /dev/null
+++ b/distro/dns-scripts/Makefile.am
@@ -0,0 +1,28 @@
+#
+#  OpenVPN -- An application to securely tunnel IP networks
+#             over a single UDP port, with support for SSL/TLS-based
+#             session authentication and key exchange,
+#             packet encryption, packet authentication, and
+#             packet compression.
+#
+#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+#
+
+MAINTAINERCLEANFILES =3D \
+	$(srcdir)/Makefile.in
+
+EXTRA_DIST =3D \
+	systemd-dns-updown.sh \
+	openresolv-dns-updown.sh \
+	haikuos_file-dns-updown.sh \
+	resolvconf_file-dns-updown.sh
+
+script_SCRIPTS =3D \
+	dns-updown
+
+CLEANFILES =3D $(script_SCRIPTS)
+
+dns-updown: @DNS_UPDOWN_TYPE@...2841...
+	cp ${srcdir}/@DNS_UPDOWN_TYPE@...2841... $@
+
+all: $(script_SCRIPTS)
diff --git a/distro/dns-scripts/haikuos_file-dns-updown.sh b/distro/dns-scr=
ipts/haikuos_file-dns-updown.sh
new file mode 100644
index 0000000..1b03e9c
--- /dev/null
+++ b/distro/dns-scripts/haikuos_file-dns-updown.sh
@@ -0,0 +1,84 @@
+#!/bin/sh
+#
+# Simple OpenVPN up/down script for modifying Haiku OS resolv.conf
+# (C) Copyright 2024 OpenVPN Inc <sales@...515...>
+#
+# SPDX-License-Identifier: BSD-2-Clause
+#
+# Example env from openvpn (most are not applied):
+#
+#   dev tun0
+#   script-type dns-up
+#   dns_search_domain_1 mycorp.in
+#   dns_search_domain_2 eu.mycorp.com
+#   dns_server_1_address_1 192.168.99.254
+#   dns_server_1_address_2 fd00::99:53
+#   dns_server_1_port_1 53
+#   dns_server_1_port_2 53
+#   dns_server_1_resolve_domain_1 mycorp.in
+#   dns_server_1_resolve_domain_2 eu.mycorp.com
+#   dns_server_1_dnssec true
+#   dns_server_1_transport DoH
+#   dns_server_1_sni dns.mycorp.in
+#
+
+set -e +u
+
+conly_standard_server_ports() {
+    i=3D1
+    while true; do
+        eval addr=3D\"\$dns_server_${n}_address_${i}\"
+        [ -n "$addr" ] || return 0
+
+        eval port=3D\"\$dns_server_${n}_port_${i}\"
+        [ -z "$port" -o "$port" =3D "53" ] || return 1
+
+        i=3D$(expr $i + 1)
+    done
+}
+
+onf=3D/boot/system/settings/network/resolv.conf
+test -e "$conf" || exit 1
+case "${script_type}" in
+dns-up)
+    n=3D1
+    while :; do
+        eval addr=3D\"\$dns_server_${n}_address_1\"
+        [ -n "$addr" ] || {
+            echo "setting DNS failed, no compatible server profile"
+            exit 1
+        }
+
+        # Skip server profiles which require DNSSEC,
+        # secure transport or use a custom port
+        eval dnssec=3D\"\$dns_server_${n}_dnssec\"
+        eval transport=3D\"\$dns_server_${n}_transport\"
+        [ -z "$transport" -o "$transport" =3D "plain" ] \
+            && [ -z "$dnssec" -o "$dnssec" =3D "no" ] \
+            && only_standard_server_ports && break
+
+        n=3D$(expr $n + 1)
+    done
+
+    eval addr1=3D\"\$dns_server_${n}_address_1\"
+    eval addr2=3D\"\$dns_server_${n}_address_2\"
+    eval addr3=3D\"\$dns_server_${n}_address_3\"
+    text=3D"### openvpn ${dev} begin ###\n"
+    text=3D"${text}nameserver $addr1\n"
+    test -z "$addr2" || text=3D"${text}nameserver $addr2\n"
+    test -z "$addr3" || text=3D"${text}nameserver $addr3\n"
+
+    test -z "$dns_search_domain_1" || {
+        for i in $(seq 1 6); do
+            eval domains=3D\"$domains\$dns_search_domain_${i} \" || break
+        done
+        text=3D"${text}search $domains\n"
+    }
+    text=3D"${text}### openvpn ${dev} end ###"
+
+    sed -i "1i${text}" "$conf"
+    ;;
+dns-down)
+    sed -i "/### openvpn ${dev} begin ###/,/### openvpn ${dev} end ###/d" =
"$conf"
+    ;;
+esac
diff --git a/distro/dns-scripts/openresolv-dns-updown.sh b/distro/dns-scrip=
ts/openresolv-dns-updown.sh
new file mode 100644
index 0000000..1b218f5
--- /dev/null
+++ b/distro/dns-scripts/openresolv-dns-updown.sh
@@ -0,0 +1,89 @@
+#!/bin/sh
+#
+# Simple OpenVPN up/down script for openresolv integration
+# (C) Copyright 2016 Baptiste Daroussin
+#               2024 OpenVPN Inc <sales@...515...>
+#
+# SPDX-License-Identifier: BSD-2-Clause
+#
+# Example env from openvpn (most are not applied):
+#
+#   dev tun0
+#   script-type dns-up
+#   dns_search_domain_1 mycorp.in
+#   dns_search_domain_2 eu.mycorp.com
+#   dns_server_1_address_1 192.168.99.254
+#   dns_server_1_address_2 fd00::99:53
+#   dns_server_1_port_1 53
+#   dns_server_1_port_2 53
+#   dns_server_1_resolve_domain_1 mycorp.in
+#   dns_server_1_resolve_domain_2 eu.mycorp.com
+#   dns_server_1_dnssec true
+#   dns_server_1_transport DoH
+#   dns_server_1_sni dns.mycorp.in
+#
+
+set -e +u
+
+only_standard_server_ports() {
+    i=3D1
+    while true; do
+        eval addr=3D\"\$dns_server_${n}_address_${i}\"
+        [ -n "$addr" ] || return 0
+
+        eval port=3D\"\$dns_server_${n}_port_${i}\"
+        [ -z "$port" -o "$port" =3D "53" ] || return 1
+
+        i=3D$(expr $i + 1)
+    done
+}
+
+: ${script_type:=3Ddns-down}
+case "${script_type}" in
+dns-up)
+    n=3D1
+    while :; do
+        eval addr=3D\"\$dns_server_${n}_address_1\"
+        [ -n "$addr" ] || {
+            echo "setting DNS failed, no compatible server profile"
+            exit 1
+        }
+
+        # Skip server profiles which require DNSSEC,
+        # secure transport or use a custom port
+        eval dnssec=3D\"\$dns_server_${n}_dnssec\"
+        eval transport=3D\"\$dns_server_${n}_transport\"
+        [ -z "$transport" -o "$transport" =3D "plain" ] \
+            && [ -z "$dnssec" -o "$dnssec" =3D "no" ] \
+            && only_standard_server_ports && break
+
+        n=3D$(expr $n + 1)
+    done
+
+    {
+        i=3D1
+        maxns=3D3
+        while :; do
+            maxns=3D$((maxns - 1))
+            [ $maxns -gt 0 ] || break
+            eval option=3D\"\$dns_server_${n}_address_${i}\" || break
+            [ "${option}" ] || break
+            i=3D$((i + 1))
+            echo "nameserver ${option}"
+        done
+        i=3D1
+        maxdom=3D6
+        while :; do
+            maxdom=3D$((maxdom - 1))
+            [ $maxdom -gt 0 ] || break
+            eval option=3D\"\$dns_search_domain_${i}\" || break
+            [ "${option}" ] || break
+            i=3D$((i + 1))
+            echo "search ${option}"
+        done
+    } | /sbin/resolvconf -a "${dev}"
+    ;;
+dns-down)
+    /sbin/resolvconf -d "${dev}" -f
+    ;;
+esac
diff --git a/distro/dns-scripts/resolvconf_file-dns-updown.sh b/distro/dns-=
scripts/resolvconf_file-dns-updown.sh
new file mode 100644
index 0000000..c469490
--- /dev/null
+++ b/distro/dns-scripts/resolvconf_file-dns-updown.sh
@@ -0,0 +1,84 @@
+#!/bin/sh
+#
+# Simple OpenVPN up/down script for modifying /etc/resolv.conf
+# (C) Copyright 2024 OpenVPN Inc <sales@...515...>
+#
+# SPDX-License-Identifier: BSD-2-Clause
+#
+# Example env from openvpn (most are not applied):
+#
+#   dev tun0
+#   script-type dns-up
+#   dns_search_domain_1 mycorp.in
+#   dns_search_domain_2 eu.mycorp.com
+#   dns_server_1_address_1 192.168.99.254
+#   dns_server_1_address_2 fd00::99:53
+#   dns_server_1_port_1 53
+#   dns_server_1_port_2 53
+#   dns_server_1_resolve_domain_1 mycorp.in
+#   dns_server_1_resolve_domain_2 eu.mycorp.com
+#   dns_server_1_dnssec true
+#   dns_server_1_transport DoH
+#   dns_server_1_sni dns.mycorp.in
+#
+
+set -e +u
+
+only_standard_server_ports() {
+    i=3D1
+    while true; do
+        eval addr=3D\"\$dns_server_${n}_address_${i}\"
+        [ -n "$addr" ] || return 0
+
+        eval port=3D\"\$dns_server_${n}_port_${i}\"
+        [ -z "$port" -o "$port" =3D "53" ] || return 1
+
+        i=3D$(expr $i + 1)
+    done
+}
+
+conf=3D/etc/resolv.conf
+test -e "$conf" || exit 1
+case "${script_type}" in
+dns-up)
+    n=3D1
+    while :; do
+        eval addr=3D\"\$dns_server_${n}_address_1\"
+        [ -n "$addr" ] || {
+            echo "setting DNS failed, no compatible server profile"
+            exit 1
+        }
+
+        # Skip server profiles which require DNSSEC,
+        # secure transport or use a custom port
+        eval dnssec=3D\"\$dns_server_${n}_dnssec\"
+        eval transport=3D\"\$dns_server_${n}_transport\"
+        [ -z "$transport" -o "$transport" =3D "plain" ] \
+            && [ -z "$dnssec" -o "$dnssec" =3D "no" ] \
+            && only_standard_server_ports && break
+
+        n=3D$(expr $n + 1)
+    done
+
+    eval addr1=3D\"\$dns_server_${n}_address_1\"
+    eval addr2=3D\"\$dns_server_${n}_address_2\"
+    eval addr3=3D\"\$dns_server_${n}_address_3\"
+    text=3D"### openvpn ${dev} begin ###\n"
+    text=3D"${text}nameserver $addr1\n"
+    test -z "$addr2" || text=3D"${text}nameserver $addr2\n"
+    test -z "$addr3" || text=3D"${text}nameserver $addr3\n"
+
+    test -z "$dns_search_domain_1" || {
+        for i in $(seq 1 6); do
+            eval domains=3D\"$domains\$dns_search_domain_${i} \" || break
+        done
+        text=3D"${text}search $domains\n"
+    }
+    text=3D"${text}### openvpn ${dev} end ###"
+
+    sed -i "1i${text}" "$conf"
+    ;;
+dns-down)
+    sed -i "/### openvpn ${dev} begin ###/,/### openvpn ${dev} end ###/d" =
"$conf"
+    ;;
+esac
diff --git a/distro/dns-scripts/systemd-dns-updown.sh b/distro/dns-scripts/=
systemd-dns-updown.sh
new file mode 100644
index 0000000..69bbebf
--- /dev/null
+++ b/distro/dns-scripts/systemd-dns-updown.sh
@@ -0,0 +1,194 @@
+#!/bin/bash
+#
+# dns-updown - add/remove openvpn provided DNS information
+#
+# Copyright (C) 2024 OpenVPN Inc <sales@...515...>
+#
+# SPDX-License-Identifier: GPL-2.0
+#
+# Add/remove openvpn DNS settings from the env into/from
+# the system. Supported backends in this order:
+#
+#   * systemd-resolved
+#   * resolvconf
+#
+# Example env from openvpn (not all are always applied):
+#
+#   dev tun0
+#   script-type dns-up
+#   dns_search_domain_1 mycorp.in
+#   dns_search_domain_2 eu.mycorp.com
+#   dns_server_1_address_1 192.168.99.254
+#   dns_server_1_address_2 fd00::99:53
+#   dns_server_1_port_1 53
+#   dns_server_1_port_2 53
+#   dns_server_1_resolve_domain_1 mycorp.in
+#   dns_server_1_resolve_domain_2 eu.mycorp.com
+#   dns_server_1_dnssec true
+#   dns_server_1_transport DoH
+#   dns_server_1_sni dns.mycorp.in
+#
+
+function do_resolved_servers {
+    local sni=3D""
+    local transport_var=3Ddns_server_${n}_transport
+    local sni_var=3Ddns_server_${n}_sni
+    [ "${!transport_var}" =3D "DoT" ] && sni=3D"#${!sni_var}"
+
+    local i=3D1
+    local addrs=3D""
+    while :; do
+        local addr_var=3Ddns_server_${n}_address_${i}
+        local addr=3D"${!addr_var}"
+        [ -n "$addr" ] || break
+
+        local port_var=3Ddns_server_${n}_port_${i}
+        if [ -n "${!port_var}" ]; then
+            if [[ "$addr" =3D~ : ]]; then
+                addr=3D"[$addr]"
+            fi
+            addrs+=3D"${addr}:${!port_var}${sni} "
+        else
+            addrs+=3D"${addr}${sni} "
+        fi
+        i=3D$((i+1))
+    done
+
+    resolvectl dns "$dev" $addrs
+}
+
+function do_resolved_domains {
+    local list=3D""
+    for domain_var in ${!dns_search_domain_*}; do
+        list+=3D"${!domain_var} "
+    done
+    local domain_var=3Ddns_server_${n}_resolve_domain_1
+    if [ -z "${!domain_var}" ]; then
+        resolvectl default-route "$dev" true
+        list+=3D"~."
+    else
+        resolvectl default-route "$dev" false
+        local i=3D1
+        while :; do
+            domain_var=3Ddns_server_${n}_resolve_domain_${i}
+            [ -n "${!domain_var}" ] || break
+            # Add as split domain (~ prefix), if it doesn't already exist
+            [[ "$list" =3D~ (^| )"${!domain_var}"( |$) ]] \
+                || list+=3D"~${!domain_var} "
+            i=3D$((i+1))
+        done
+    fi
+
+    resolvectl domain "$dev" $list
+}
+
+function do_resolved_dnssec {
+    local dnssec_var=3Ddns_server_${n}_dnssec
+    if [ "${!dnssec_var}" =3D "optional" ]; then
+        resolvectl dnssec "$dev" allow-downgrade
+    elif [ "${!dnssec_var}" =3D "yes" ]; then
+        resolvectl dnssec "$dev" true
+    else
+        resolvectl dnssec "$dev" false
+    fi
+}
+
+function do_resolved_dnsovertls {
+    local transport_var=3Ddns_server_${n}_transport
+    if [ "${!transport_var}" =3D "DoT" ]; then
+        resolvectl dnsovertls "$dev" true
+    else
+        resolvectl dnsovertls "$dev" false
+    fi
+}
+
+function do_resolved {
+    [[ "$(readlink /etc/resolv.conf)" =3D~ systemd ]] || return 1
+
+    n=3D1
+    while :; do
+        local addr_var=3Ddns_server_${n}_address_1
+        [ -n "${!addr_var}" ] || {
+            echo "setting DNS failed, no compatible server profile"
+            return 1
+        }
+
+        # Skip server profiles which require DNS-over-HTTPS
+        local transport_var=3Ddns_server_${n}_transport
+        [ -n "${!transport_var}" -a "${!transport_var}" =3D "DoH" ] || bre=
ak
+
+        n=3D$((n+1))
+    done
+
+    if [ "$script_type" =3D "dns-up" ]; then
+        echo "setting DNS using resolvectl"
+        do_resolved_servers
+        do_resolved_domains
+        do_resolved_dnssec
+        do_resolved_dnsovertls
+    else
+        echo "unsetting DNS using resolvectl"
+        resolvectl revert "$dev"
+    fi
+
+    return 0
+}
+
+function only_standard_server_ports {
+    local i=3D1
+    while :; do
+        local addr_var=3Ddns_server_${n}_address_${i}
+        [ -n "${!addr_var}" ] || return 0
+
+        local port_var=3Ddns_server_${n}_port_${i}
+        [ -z "${!port_var}" -o "${!port_var}" =3D "53" ] || return 1
+
+        i=3D$((i+1))
+    done
+}
+
+function do_resolvconf {
+    [ -x /sbin/resolvconf ] || return 1
+
+    n=3D1
+    while :; do
+        local server_addr_var=3Ddns_server_${n}_address_1
+        [ -n "${!server_addr_var}" ] || {
+            echo "setting DNS failed, no compatible server profile"
+            return 1
+        }
+
+        # Skip server profiles which require DNSSEC,
+        # secure transport or use a custom port
+        local dnssec_var=3Ddns_server_${n}_dnssec
+        local transport_var=3Ddns_server_${n}_transport
+        [ -z "${!transport_var}" -o "${!transport_var}" =3D "plain" ] \
+            && [ -z "${!dnssec_var}" -o "${!dnssec_var}" =3D "no" ] \
+            && only_standard_server_ports && break
+
+        n=3D$((n+1))
+    done
+
+    if [ "$script_type" =3D "dns-up" ]; then
+        echo "setting DNS using resolvconf"
+        local domains=3D""
+        for domain_var in ${!dns_search_domain_*}; do
+            domains+=3D"${!domain_var} "
+        done
+        {
+            local maxns=3D3
+            for addr_var in ${!dns_server_1_address_*}; do
+                [ $((maxns--)) -gt 0 ] || break
+                echo "nameserver ${!addr_var}"
+            done
+            [ -z "$domains" ] || echo "search $domains"
+        } | /sbin/resolvconf -a "$dev"
+    else
+        echo "unsetting DNS using resolvconf"
+        /sbin/resolvconf -d "$dev"
+    fi
+
+    return 0
+}
+
+do_resolved || do_resolvconf
diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-=
options.rst
index 0d1f9ae..de3842b 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -8,9 +8,13 @@
 Script Order of Execution
 -------------------------

+#. ``--dns-updown``
+
+   Executed after TCP/UDP socket bind and TUN/TAP open, before ``--up``.
+
 #. ``--up``

-   Executed after TCP/UDP socket bind and TUN/TAP open.
+   Executed after TCP/UDP socket bind and TUN/TAP open, after ``--dns-updo=
wn``.

 #. ``--tls-verify``

@@ -38,9 +42,13 @@

    Executed in ``--mode server`` mode on client instance shutdown.

+#. ``--dns-updown``
+
+   Executed before TCP/UDP and TUN/TAP close, before ``--down``.
+
 #. ``--down``

-   Executed after TCP/UDP and TUN/TAP close.
+   Executed after TCP/UDP and TUN/TAP close, after ``--dns-updown``.

 #. ``--learn-address``

@@ -173,7 +181,7 @@
         client-crresponse cmd

   OpenVPN will write the response of the client into a temporary file.
-  The filename will be passed as an argument to ``cmd``, and the file will=
 be
+  The filename will be passed as an argument to ``cmd``, and the file will
   automatically deleted by OpenVPN after the script returns.

   The response is passed as is from the client. The script needs to check
@@ -235,6 +243,31 @@
   The ``--client-disconnect`` command is not passed any extra arguments
   (only those arguments specified in cmd, if any).

+--dns-updown cmd
+  Run command ``cmd``, instead of the default DNS up/down command that com=
es
+  with openvpn. If ``cmd`` is ``disable`` the ``--dns-updown`` command is =
not run.
+
+  If you write your own command, please make sure to ignore ``--dns``
+  server profiles that cannot be applied. Port, DNSSEC and secure transport
+  settings need to be adhered to. If split DNS is not possible a full redi=
rect
+  can be used as a fallback. If not all of the server addresses or search =
domains
+  can be configured, apply them in the order they are listed in.
+
+  Note that ``--dns-updown`` is not supported on all platforms. On Windows=
 DNS
+  will always be set by the service. On Android DNS will be passed via man=
agement
+  interface.
+
+  Note that DNS-related ``--dhcp-option``\ s might be converted so that th=
ey are
+  available to this hook if no ``--dns`` options exist. If any ``--dns ser=
ver``
+  option is present, DNS-related ``--dhcp-option``\ s will always be ignor=
ed.
+  If an ``--up`` script is defined, foreign_option env vars will be genera=
ted
+  from ``--dns`` options and passed to the script. The default ``--dns-upd=
own``
+  command is not run if an ``--up`` script is defined. Both is done for ba=
ckward
+  compatibility. In case you want to run the ``--dns-updown`` command even=
 if
+  there is an ``--up`` defined, you can define a custom command or use ``f=
orce``
+  as ``cmd`` to run the default command. No DNS env vars will be passed to=
 ``--up``
+  in this case.
+
 --down cmd
   Run command ``cmd`` after TUN/TAP device close (post ``--user`` UID
   change and/or ``--chroot`` ). ``cmd`` consists of a path to script (or
@@ -661,7 +694,7 @@
     names). Set prior to ``--up`` or ``--down`` script execution.

 :code:`dns_*`
-    The ``--dns`` configuration options will be made available to script
+    The ``--dns`` configuration options will be made available to ``--dns-=
updown``
     execution through this set of environment variables. Variables appear
     only if the corresponding option has a value assigned. For the semanti=
cs
     of each individual variable, please refer to the documentation for ``-=
-dns``.
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 37af683..2e93ebb 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -30,7 +30,8 @@
 	$(OPTIONAL_LZ4_CFLAGS) \
 	$(OPTIONAL_PKCS11_HELPER_CFLAGS) \
 	$(OPTIONAL_INOTIFY_CFLAGS) \
-	-DPLUGIN_LIBDIR=3D\"${plugindir}\"
+	-DPLUGIN_LIBDIR=3D\"${plugindir}\" \
+	-DDEFAULT_DNS_UPDOWN=3D\"${scriptdir}/dns-updown\"

 if WIN32
 # we want unicode entry point but not the macro
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index b6e524f..4da0747 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -30,6 +30,7 @@
 #include "dns.h"
 #include "socket.h"
 #include "options.h"
+#include "run_command.h"

 #ifdef _WIN32
 #include "win32.h"
@@ -262,6 +263,8 @@
     clone.search_domains =3D clone_dns_domains(o->search_domains, gc);
     clone.servers =3D clone_dns_servers(o->servers, gc);
     clone.servers_prepull =3D clone_dns_servers(o->servers_prepull, gc);
+    clone.updown =3D o->updown;
+    clone.user_set_updown =3D o->user_set_updown;

     return clone;
 }
@@ -548,6 +551,54 @@
     send_msg_iservice(o->msg_channel, &nrpt, sizeof(nrpt), &ack, "DNS");
 }

+#else /* ifdef _WIN32 */
+
+static void
+updown_env_set(bool up, const struct dns_options *o, const struct tuntap *=
tt, struct env_set *es)
+{
+    setenv_str(es, "dev", tt->actual_name);
+    setenv_str(es, "script_type", up ? "dns-up" : "dns-down");
+    setenv_dns_options(o, es);
+}
+
+static int
+do_run_up_down_command(bool up, const struct dns_options *o, const struct =
tuntap *tt)
+{
+    struct gc_arena gc =3D gc_new();
+    struct argv argv =3D argv_new();
+    struct env_set *es =3D env_set_create(&gc);
+
+    updown_env_set(up, o, tt, es);
+
+    argv_printf(&argv, "%s", o->updown);
+    argv_msg(M_INFO, &argv);
+    int res;
+    if (o->user_set_updown)
+    {
+        res =3D openvpn_run_script(&argv, es, S_EXITCODE, "dns updown");
+    }
+    else
+    {
+        res =3D openvpn_execve_check(&argv, es, S_EXITCODE, "WARNING: Fail=
ed running dns updown");
+    }
+    argv_free(&argv);
+    gc_free(&gc);
+    return res;
+}
+
+static void
+run_up_down_command(bool up, struct options *o, const struct tuntap *tt)
+{
+    if (!o->dns_options.updown)
+    {
+        return;
+    }
+
+    int status;
+    status =3D do_run_up_down_command(up, &o->dns_options, tt);
+    msg(M_INFO, "dns %s command exited with status %d", up ? "up" : "down"=
, status);
+}
+
 #endif /* _WIN32 */

 void
@@ -666,5 +717,7 @@

 #ifdef _WIN32
     run_up_down_service(up, o, tt);
+#else
+    run_up_down_command(up, o, tt);
 #endif /* ifdef _WIN32 */
 }
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index f24e30b..c4d19ff 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -73,6 +73,8 @@
     struct dns_server *servers_prepull;
     struct dns_server *servers;
     struct gc_arena gc;
+    const char *updown;
+    bool user_set_updown;
 };

 /**
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 99dd60a..b116740 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -526,10 +526,12 @@
     "                  address <addr[:port]> [addr[:port] ...] : server ad=
dresses 4/6\n"
     "                  resolve-domains <domain> [domain ...] : split domai=
ns\n"
     "                  dnssec <yes|no|optional> : option to use DNSSEC\n"
-    "                  type <DoH|DoT> : query server over HTTPS / TLS\n"
+    "                  transport <DoH|DoT> : query server over HTTPS / TLS=
\n"
     "                  sni <domain> : DNS server name indication\n"
     "--dns search-domains <domain> [domain ...]:\n"
     "                  Add domains to DNS domain search list\n"
+    "--dns-updown cmd|force|disable : Run cmd as user defined dns config c=
ommand,\n"
+    "                  force running the default script or disable running=
 it.\n"
     "--auth-retry t  : How to handle auth failures.  Set t to\n"
     "                  none (default), interact, or nointeract.\n"
     "--static-challenge t e [<scrv1|concat>]: Enable static challenge/resp=
onse protocol using\n"
@@ -921,6 +923,10 @@
 #ifndef ENABLE_DCO
     o->disable_dco =3D true;
 #endif /* ENABLE_DCO */
+
+#ifdef ENABLE_DNS_UPDOWN_BY_DEFAULT
+    o->dns_options.updown =3D DEFAULT_DNS_UPDOWN;
+#endif /* ENABLE_DNS_UPDOWN_BY_DEFAULT */
 }

 void
@@ -8087,6 +8093,39 @@
         to->ip_win32_defined =3D true;
     }
 #endif /* ifdef _WIN32 */
+    else if (streq(p[0], "dns-updown") && p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_SCRIPT);
+        if (!no_more_than_n_args(msglevel, p, 2, NM_QUOTE_HINT))
+        {
+            goto err;
+        }
+        struct dns_options *dns =3D &options->dns_options;
+        if (streq(p[1], "disable"))
+        {
+            dns->updown =3D NULL;
+            dns->user_set_updown =3D false;
+        }
+        else if (streq(p[1], "force"))
+        {
+            /* force dns-updown run, even if a --up script is defined */
+            if (dns->user_set_updown =3D=3D false)
+            {
+                dns->updown =3D DEFAULT_DNS_UPDOWN;
+                dns->user_set_updown =3D true;
+            }
+        }
+        else
+        {
+            if (streq(dns->updown, DEFAULT_DNS_UPDOWN))
+            {
+                /* Unset the default command to prevent warnings */
+                dns->updown =3D NULL;
+            }
+            set_user_script(options, &dns->updown, p[1], p[0], false);
+            dns->user_set_updown =3D true;
+        }
+    }
     else if (streq(p[0], "dns") && p[1])
     {
         VERIFY_PERMISSION(OPT_P_DHCPDNS);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10
Gerrit-Change-Number: 838
Gerrit-PatchSet: 20
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-MessageType: newpatchset

--mhfmDBFhPbo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, d12fk, plaisthos. </p>
<p>d12fk <strong>uploaded patch set #20</strong> to this change.</p><p><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail">View Change</=
a></p><p>The change is no longer submittable: checks~ChecksSubmitRule is un=
satisfied now.</p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">dns: apply settings via script on unixoid systems<br><br>Thi=
s introduces a new script hook, the dns-updown, and implements such a<br>co=
mmand script for a few popular systems (and a default for the not so<br>pop=
ular ones). Like the name suggests this hook is soleley for dealing<br>with=
 modifying how names are resolved when the VPN pushes some --dns<br>setting=
s.<br><br>The default dns updown command is part of the distribution and is=
<br>installed with openvpn. You can change the path the command is located<=
br>at as a compile time option, defaults to libexecdir.<br><br>You can comp=
ile-time disable that the default dns-updown hook is<br>run by passing --di=
sable-dns-updown-by-default to configure or<br>ccmake ENABLE_DNS_UPDOWN_BY_=
DEFAULT to OFF.<br><br>There&#39;s also a new runtime option --dns-updown, =
which can run a custom<br>command, force running the default when disabled =
or disable execution<br>of the dns-updown altogether.<br><br>Change-Id: Ifb=
e4ffb44d3bfcaa50adb38cacb3436fcdc71b10<br>Signed-off-by: Heiko Hund &lt;hei=
ko@...2662...&gt;<br>---<br>M .gitignore<br>M CMakeLists.txt<br>M config.h.=
cmake.in<br>M configure.ac<br>M distro/Makefile.am<br>A distro/dns-scripts/=
Makefile.am<br>A distro/dns-scripts/haikuos_file-dns-updown.sh<br>A distro/=
dns-scripts/openresolv-dns-updown.sh<br>A distro/dns-scripts/resolvconf_fil=
e-dns-updown.sh<br>A distro/dns-scripts/systemd-dns-updown.sh<br>M doc/man-=
sections/script-options.rst<br>M src/openvpn/Makefile.am<br>M src/openvpn/d=
ns.c<br>M src/openvpn/dns.h<br>M src/openvpn/options.c<br>15 files changed,=
 658 insertions(+), 10 deletions(-)<br><br></pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn=
.net:29418/openvpn refs/changes/38/838/20</pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/.gitignore b=
/.gitignore</span><br><span>index db8bb73..04523af 100644</span><br><span>-=
-- a/.gitignore</span><br><span>+++ b/.gitignore</span><br><span>@@ -49,6 +=
49,7 @@</span><br><span> /doc/doxygen/latex/</span><br><span> /doc/doxygen/=
openvpn.doxyfile</span><br><span> distro/systemd/*.service</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+distro/dns-scripts/dns-updown</span>=
<br><span> sample/sample-keys/sample-ca/</span><br><span> vendor/cmocka_bui=
ld</span><br><span> vendor/dist</span><br><span>diff --git a/CMakeLists.txt=
 b/CMakeLists.txt</span><br><span>index b04adce..ef4a0f2 100644</span><br><=
span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br><s=
pan>@@ -41,7 +41,10 @@</span><br><span> option(USE_WERROR &quot;Treat compi=
ler warnings as errors (-Werror)&quot; ON)</span><br><span> option(FAKE_AND=
ROID &quot;Target Android but do not use actual cross compile/Android cmake=
 to build for simple compile checks on Linux&quot;)</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-set(PLUGIN_DIR /usr/local/l=
ib/openvpn/plugins CACHE FILEPATH &quot;Location of the plugin directory&qu=
ot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+option(ENABLE_D=
NS_UPDOWN_BY_DEFAULT &quot;Run --dns-updown hook by default&quot; ON)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+set(DNS_UPDOWN_PATH &quot=
;${CMAKE_INSTALL_PREFIX}/libexec/openvpn/dns-updown&quot; CACHE STRING &quo=
t;Default location for the DNS up/down script&quot;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+set(PLUGIN_DIR &quot;${CMAKE_INSTALL_PREFIX}/lib/openvpn/plu=
gins&quot; CACHE FILEPATH &quot;Location of the plugin directory&quot;)</sp=
an><br><span> </span><br><span> # Create machine readable compile commands<=
/span><br><span> option(ENABLE_COMPILE_COMMANDS &quot;Generate compile_comm=
ands.json and a symlink for clangd to find it&quot; OFF)</span><br><span>@@=
 -577,6 +580,8 @@</span><br><span> </span><br><span> add_library_deps(openv=
pn)</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+target_compile_options(openvpn PRIVATE -DDEFAULT_DNS_UPDOWN=3D\&quot;${DN=
S_UPDOWN_PATH}\&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> if(MINGW)</span><br><span>     target_compile_options(=
openvpn PRIVATE -municode -UUNICODE)</span><br><span>     target_link_optio=
ns(openvpn PRIVATE -municode)</span><br><span>diff --git a/config.h.cmake.i=
n b/config.h.cmake.in</span><br><span>index 2f7b43d..5164ce3 100644</span><=
br><span>--- a/config.h.cmake.in</span><br><span>+++ b/config.h.cmake.in</s=
pan><br><span>@@ -35,6 +35,9 @@</span><br><span> /* Enable LZO compression =
library */</span><br><span> #cmakedefine ENABLE_LZO</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Enable dns-updown scri=
pt hook */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedef=
ine ENABLE_DNS_UPDOWN</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> /* Enable NTLMv2 proxy support */</span><br><span> #def=
ine ENABLE_NTLM 1</span><br><span> </span><br><span>diff --git a/configure.=
ac b/configure.ac</span><br><span>index 9777e36..75367e8 100644</span><br><=
span>--- a/configure.ac</span><br><span>+++ b/configure.ac</span><br><span>=
@@ -96,6 +96,13 @@</span><br><span> )</span><br><span> </span><br><span> AC=
_ARG_ENABLE(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	[dns-u=
pdown-by-default],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
[AS_HELP_STRING([--disable-dns-updown-by-default], [disable running --dns-u=
pdown by default @&lt;:@default=3Dyes@:&gt;@])],</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	[enable_dns_updown_by_default=3D&quot;yes&quot;]</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+AC_ARG_ENABLE(</span><br><span> 	[ntlm],</span><br><span> 	[AS_HELP_ST=
RING([--disable-ntlm], [disable NTLMv2 proxy support @&lt;:@default=3Dyes@:=
&gt;@])],</span><br><span> 	,</span><br><span>@@ -315,37 +322,50 @@</span><=
br><span> 	plugindir=3D&quot;\${libdir}/openvpn/plugins&quot;</span><br><sp=
an> fi</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+AC_ARG_VAR([SCRIPTDIR], [Path of script directory @&lt;:@default=3DPKG=
LIBEXECDIR@:&gt;@])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
if test -n &quot;${SCRIPTDIR}&quot;; then</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	scriptdir=3D&quot;${SCRIPTDIR}&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+else</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	scriptdir=3D&quot;\${pkglibexecdir}&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> AC_DEFINE_UNQUOTED([TARGET=
_ALIAS], [&quot;${host}&quot;], [A string representing our host])</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-AM_CONDITIONAL([TARGET_LINUX], =
[false])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+AM_CONDITIO=
NAL([ENABLE_DNS_UPDOWN],[true])</span><br><span> case &quot;$host&quot; in<=
/span><br><span> 	*-*-linux*)</span><br><span> 		AC_DEFINE([TARGET_LINUX], =
[1], [Are we running on Linux?])</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-		AM_CONDITIONAL([TARGET_LINUX], [true])</span><br><span> 		AC_D=
EFINE_UNQUOTED([TARGET_PREFIX], [&quot;L&quot;], [Target prefix])</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+		AC_SUBST([DNS_UPDOWN_TYPE],=
 [&quot;systemd&quot;])</span><br><span> 		have_sitnl=3D&quot;yes&quot;</sp=
an><br><span> 		pkg_config_required=3D&quot;yes&quot;</span><br><span> 		;;=
</span><br><span> 	*-*-solaris*)</span><br><span> 		AC_DEFINE([TARGET_SOLAR=
IS], [1], [Are we running on Solaris?])</span><br><span> 		AC_DEFINE_UNQUOT=
ED([TARGET_PREFIX], [&quot;S&quot;], [Target prefix])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+		AC_SUBST([DNS_UPDOWN_TYPE], [&quot;reso=
lvconf_file&quot;])</span><br><span> 		CPPFLAGS=3D&quot;$CPPFLAGS -D_XPG4_2=
&quot;</span><br><span> 		test -x /bin/bash &amp;&amp; SHELL=3D&quot;/bin/b=
ash&quot;</span><br><span> 		;;</span><br><span> 	*-*-openbsd*)</span><br><=
span> 		AC_DEFINE([TARGET_OPENBSD], [1], [Are we running on OpenBSD?])</spa=
n><br><span> 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&quot;O&quot;], [Target=
 prefix])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		AC_SUBST=
([DNS_UPDOWN_TYPE], [&quot;resolvconf_file&quot;])</span><br><span> 		;;</s=
pan><br><span> 	*-*-freebsd*)</span><br><span> 		AC_DEFINE([TARGET_FREEBSD]=
, [1], [Are we running on FreeBSD?])</span><br><span> 		AC_DEFINE_UNQUOTED(=
[TARGET_PREFIX], [&quot;F&quot;], [Target prefix])</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+		AC_SUBST([DNS_UPDOWN_TYPE], [&quot;openres=
olv&quot;])</span><br><span> 		;;</span><br><span> 	*-*-netbsd*)</span><br>=
<span> 		AC_DEFINE([TARGET_NETBSD], [1], [Are we running NetBSD?])</span><b=
r><span> 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&quot;N&quot;], [Target pre=
fix])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		AC_SUBST([DN=
S_UPDOWN_TYPE], [&quot;openresolv&quot;])</span><br><span> 		;;</span><br><=
span> 	*-*-darwin*)</span><br><span> 		AC_DEFINE([TARGET_DARWIN], [1], [Are=
 we running on Mac OS X?])</span><br><span> 		AC_DEFINE_UNQUOTED([TARGET_PR=
EFIX], [&quot;M&quot;], [Target prefix])</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+		AM_CONDITIONAL([ENABLE_DNS_UPDOWN], [false])</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+		AC_SUBST([DNS_UPDOWN_TYPE=
], [&quot;resolvconf_file&quot;])</span><br><span> 		have_tap_header=3D&quo=
t;yes&quot;</span><br><span> 		ac_cv_type_struct_in_pktinfo=3Dno</span><br>=
<span> 		;;</span><br><span>@@ -353,6 +373,8 @@</span><br><span> 		AC_DEFIN=
E([TARGET_WIN32], [1], [Are we running WIN32?])</span><br><span> 		AC_DEFIN=
E([ENABLE_DCO], [1], [DCO is always enabled on Windows])</span><br><span> 	=
	AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&quot;W&quot;], [Target prefix])</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+		AM_CONDITIONAL([ENABLE=
_DNS_UPDOWN], [false])</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+		AC_SUBST([DNS_UPDOWN_TYPE], [&quot;windows&quot;])</span><br><span> 		=
CPPFLAGS=3D&quot;${CPPFLAGS} -DWIN32_LEAN_AND_MEAN&quot;</span><br><span> 	=
	CPPFLAGS=3D&quot;${CPPFLAGS} -DNTDDI_VERSION=3DNTDDI_VISTA -D_WIN32_WINNT=
=3D_WIN32_WINNT_VISTA&quot;</span><br><span> 		WIN32=3Dyes</span><br><span>=
@@ -360,10 +382,12 @@</span><br><span> 	*-*-dragonfly*)</span><br><span> 		=
AC_DEFINE([TARGET_DRAGONFLY], [1], [Are we running on DragonFlyBSD?])</span=
><br><span> 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&quot;D&quot;], [Target =
prefix])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		AC_SUBST(=
[DNS_UPDOWN_TYPE], [&quot;openresolv&quot;])</span><br><span> 		;;</span><b=
r><span> 	*-aix*)</span><br><span> 		AC_DEFINE([TARGET_AIX], [1], [Are we r=
unning AIX?])</span><br><span> 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&quot=
;A&quot;], [Target prefix])</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+		AC_SUBST([DNS_UPDOWN_TYPE], [&quot;resolvconf_file&quot;])</span>=
<br><span> 		ROUTE=3D&quot;/usr/sbin/route&quot;</span><br><span> 		have_ta=
p_header=3D&quot;yes&quot;</span><br><span> 		ac_cv_header_net_if_h=3D&quot=
;no&quot;	# exists, but breaks things</span><br><span>@@ -371,10 +395,12 @@=
</span><br><span> 	*-*-haiku*)</span><br><span> 		AC_DEFINE([TARGET_HAIKU],=
 [1], [Are we running Haiku?])</span><br><span> 		AC_DEFINE_UNQUOTED([TARGE=
T_PREFIX], [&quot;H&quot;], [Target prefix])</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+		AC_SUBST([DNS_UPDOWN_TYPE], [&quot;haikuos_file&=
quot;])</span><br><span> 		LIBS=3D&quot;${LIBS} -lnetwork&quot;</span><br><=
span> 		;;</span><br><span> 	*)</span><br><span> 		AC_DEFINE_UNQUOTED([TARG=
ET_PREFIX], [&quot;X&quot;], [Target prefix])</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+		AC_SUBST([DNS_UPDOWN_TYPE], [&quot;resolvconf_f=
ile&quot;])</span><br><span> 		have_tap_header=3D&quot;yes&quot;</span><br>=
<span> 		;;</span><br><span> esac</span><br><span>@@ -1317,7 +1343,7 @@</sp=
an><br><span> test &quot;${enable_small}&quot; =3D &quot;yes&quot; &amp;&am=
p; AC_DEFINE([ENABLE_SMALL], [1], [Enable smaller executable size])</span><=
br><span> test &quot;${enable_fragment}&quot; =3D &quot;yes&quot; &amp;&amp=
; AC_DEFINE([ENABLE_FRAGMENT], [1], [Enable internal fragmentation support]=
)</span><br><span> test &quot;${enable_port_share}&quot; =3D &quot;yes&quot=
; &amp;&amp; AC_DEFINE([ENABLE_PORT_SHARE], [1], [Enable TCP Server port sh=
aring])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+test &quot;${enable_dns_updown_by=
_default}&quot; =3D &quot;yes&quot; &amp;&amp; AC_DEFINE([ENABLE_DNS_UPDOWN=
_BY_DEFAULT], [1], [Enable dns-updown hook by default])</span><br><span> te=
st &quot;${enable_ntlm}&quot; =3D &quot;yes&quot; &amp;&amp; AC_DEFINE([ENA=
BLE_NTLM], [1], [Enable NTLMv2 proxy support])</span><br><span> test &quot;=
${enable_crypto_ofb_cfb}&quot; =3D &quot;yes&quot; &amp;&amp; AC_DEFINE([EN=
ABLE_OFB_CFB_MODE], [1], [Enable OFB and CFB cipher modes])</span><br><span=
> if test &quot;${have_export_keying_material}&quot; =3D &quot;yes&quot;; t=
hen</span><br><span>@@ -1505,6 +1531,7 @@</span><br><span> </span><br><span=
> sampledir=3D&quot;\$(docdir)/sample&quot;</span><br><span> AC_SUBST([plug=
indir])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+AC_SUBST([sc=
riptdir])</span><br><span> AC_SUBST([sampledir])</span><br><span> </span><b=
r><span> AC_SUBST([systemdunitdir])</span><br><span>@@ -1541,6 +1568,7 @@</=
span><br><span> 	Makefile</span><br><span> 	distro/Makefile</span><br><span=
> 	distro/systemd/Makefile</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	distro/dns-scripts/Makefile</span><br><span> 	doc/Makefile</span><b=
r><span> 	doc/doxygen/Makefile</span><br><span> 	doc/doxygen/openvpn.doxyfi=
le</span><br><span>diff --git a/distro/Makefile.am b/distro/Makefile.am</sp=
an><br><span>index 7a588da..26f577b 100644</span><br><span>--- a/distro/Mak=
efile.am</span><br><span>+++ b/distro/Makefile.am</span><br><span>@@ -13,3 =
+13,7 @@</span><br><span> 	$(srcdir)/Makefile.in</span><br><span> </span><b=
r><span> SUBDIRS =3D systemd</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if ENABLE_=
DNS_UPDOWN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SUBDIRS +=
=3D dns-scripts</span><br><span style=3D"color: hsl(120, 100%, 40%);">+endi=
f</span><br><span>diff --git a/distro/dns-scripts/Makefile.am b/distro/dns-=
scripts/Makefile.am</span><br><span>new file mode 100644</span><br><span>in=
dex 0000000..ec7bfde</span><br><span>--- /dev/null</span><br><span>+++ b/di=
stro/dns-scripts/Makefile.am</span><br><span>@@ -0,0 +1,28 @@</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#  OpenVPN -- An application to securely tunnel IP =
networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#          =
   over a single UDP port, with support for SSL/TLS-based</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#             session authentication =
and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
            packet encryption, packet authentication, and</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#             packet compression.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#  Copyright (C) 2002-2024 OpenVPN Inc &l=
t;sales@...515...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+MAINTAINERCLEANFILES =3D \</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+	$(srcdir)/Makefile.in</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+EXTRA_DIST =3D \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	systemd-dns-updown.sh \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	openresolv-dns-updown.sh \</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+	haikuos_file-dns-updown.sh \</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+	resolvconf_file-dns-up=
down.sh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+script_SCRIPTS =3D \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+	dns-updown</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+CLEANFILES =3D $(script_SCRIPTS)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+dns-updown: @DNS_UPDOWN_TYPE@...2841...</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	cp ${srcdir}/@DNS_UPDOWN_TYPE@...2841...=
 $@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+all: $(script_SCRIPTS)</span><br><s=
pan>diff --git a/distro/dns-scripts/haikuos_file-dns-updown.sh b/distro/dns=
-scripts/haikuos_file-dns-updown.sh</span><br><span>new file mode 100644</s=
pan><br><span>index 0000000..1b03e9c</span><br><span>--- /dev/null</span><b=
r><span>+++ b/distro/dns-scripts/haikuos_file-dns-updown.sh</span><br><span=
>@@ -0,0 +1,84 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#!=
/bin/sh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# Simple OpenVPN up/down scrip=
t for modifying Haiku OS resolv.conf</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# (C) Copyright 2024 OpenVPN Inc &lt;sales@...515...&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+# SPDX-License-Identifier: BSD-2-Clause=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+# Example env from openvpn (most are =
not applied):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dev tun0</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#   script-type dns-up</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_search_domain_1 myco=
rp.in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_search=
_domain_2 eu.mycorp.com</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#   dns_server_1_address_1 192.168.99.254</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#   dns_server_1_address_2 fd00::99:53</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_port_1 53</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_port_2=
 53</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1=
_resolve_domain_1 mycorp.in</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#   dns_server_1_resolve_domain_2 eu.mycorp.com</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_dnssec true</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_transport DoH=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_sn=
i dns.mycorp.in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+set -e +u</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+conly_standard_server_ports() {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    i=3D1</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    while true; do</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        eval addr=3D\&quot;\$dns_server_${n}_address_${i}\&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        [ -n &quot;$addr=
&quot; ] || return 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        eval port=
=3D\&quot;\$dns_server_${n}_port_${i}\&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        [ -z &quot;$port&quot; -o &quot;$port&quot=
; =3D &quot;53&quot; ] || return 1</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    i=3D$(expr $i + 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    done</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+onf=3D/boot/system/settings/network/resolv.co=
nf</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test -e &quot;$co=
nf&quot; || exit 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+c=
ase &quot;${script_type}&quot; in</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+dns-up)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    n=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    whil=
e :; do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        eval=
 addr=3D\&quot;\$dns_server_${n}_address_1\&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        [ -n &quot;$addr&quot; ] || {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            echo &quot;sett=
ing DNS failed, no compatible server profile&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            exit 1</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        # Skip server profiles which require DNSSEC,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        # secure transport or use a custo=
m port</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        eval =
dnssec=3D\&quot;\$dns_server_${n}_dnssec\&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        eval transport=3D\&quot;\$dns_server_${=
n}_transport\&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        [ -z &quot;$transport&quot; -o &quot;$transport&quot; =3D &quot;pla=
in&quot; ] \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     &amp;&amp; [ -z &quot;$dnssec&quot; -o &quot;$dnssec&quot; =3D &quot;n=
o&quot; ] \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    &amp;&amp; only_standard_server_ports &amp;&amp; break</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        n=3D$(expr $n + 1)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    done</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 eval addr1=3D\&quot;\$dns_server_${n}_address_1\&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    eval addr2=3D\&quot;\$dns_server_${=
n}_address_2\&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    eval addr3=3D\&quot;\$dns_server_${n}_address_3\&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    text=3D&quot;### openvpn ${dev} =
begin ###\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  text=3D&quot;${text}nameserver $addr1\n&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    test -z &quot;$addr2&quot; || text=3D&quot;=
${text}nameserver $addr2\n&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    test -z &quot;$addr3&quot; || text=3D&quot;${text}nameserv=
er $addr3\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    test -z &quot;$dn=
s_search_domain_1&quot; || {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        for i in $(seq 1 6); do</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            eval domains=3D\&quot;$domains\$dns_search=
_domain_${i} \&quot; || break</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        done</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        text=3D&quot;${text}search $domains\n&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    text=3D&quot;${text}### openvpn ${dev} end ###&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    sed -i &quot;1i${text}&quot; &qu=
ot;$conf&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dns-down)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    sed -i &quot;/### openvp=
n ${dev} begin ###/,/### openvpn ${dev} end ###/d&quot; &quot;$conf&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+esac</span><br><span>diff --git a/=
distro/dns-scripts/openresolv-dns-updown.sh b/distro/dns-scripts/openresolv=
-dns-updown.sh</span><br><span>new file mode 100644</span><br><span>index 0=
000000..1b218f5</span><br><span>--- /dev/null</span><br><span>+++ b/distro/=
dns-scripts/openresolv-dns-updown.sh</span><br><span>@@ -0,0 +1,89 @@</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/bin/sh</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+# Simple OpenVPN up/down script for openresolv integr=
ation</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# (C) Copyrigh=
t 2016 Baptiste Daroussin</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#               2024 OpenVPN Inc &lt;sales@...515...&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+# SPDX-License-Identifier: BSD-2-Clause</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+# Example env from openvpn (most are not applied=
):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#   dev tun0</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#   script-type dns-up</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#   dns_search_domain_1 mycorp.in</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_search_domain_2 =
eu.mycorp.com</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dn=
s_server_1_address_1 192.168.99.254</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#   dns_server_1_address_2 fd00::99:53</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_port_1 53</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_port_2 53</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_resolve_d=
omain_1 mycorp.in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
  dns_server_1_resolve_domain_2 eu.mycorp.com</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#   dns_server_1_dnssec true</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_transport DoH</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_sni dns.myco=
rp.in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+set -e +u</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+only_=
standard_server_ports() {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    i=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
while true; do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   eval addr=3D\&quot;\$dns_server_${n}_address_${i}\&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        [ -n &quot;$addr&quot; ] ||=
 return 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        eval port=3D\&quot;\$=
dns_server_${n}_port_${i}\&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        [ -z &quot;$port&quot; -o &quot;$port&quot; =3D &quot;=
53&quot; ] || return 1</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=3D$(ex=
pr $i + 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    done<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+: ${script_type:=3Ddns-down}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+case &quot;${script_type}&quot; in</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+dns-up)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    n=3D1</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    while :; do</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        eval addr=3D\&quot;\$dns_server_${n}_address_1\&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        [ -n &quo=
t;$addr&quot; ] || {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            echo &quot;setting DNS failed, no compatible server profile&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            exit=
 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        # Skip server profiles which require D=
NSSEC,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # sec=
ure transport or use a custom port</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        eval dnssec=3D\&quot;\$dns_server_${n}_dnssec\&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        eval transp=
ort=3D\&quot;\$dns_server_${n}_transport\&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        [ -z &quot;$transport&quot; -o &quot;$t=
ransport&quot; =3D &quot;plain&quot; ] \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            &amp;&amp; [ -z &quot;$dnssec&quot; -o &qu=
ot;$dnssec&quot; =3D &quot;no&quot; ] \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            &amp;&amp; only_standard_server_ports &amp;=
&amp; break</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        n=3D$(expr $n + 1)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    done</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        i=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        maxns=3D3</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        while :; do</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            maxns=3D$((maxns - 1))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            [ $maxns -gt 0 ] || break</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            eval option=3D\&quot;\$dns_=
server_${n}_address_${i}\&quot; || break</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            [ &quot;${option}&quot; ] || break</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            i=3D$((i + 1))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            echo &qu=
ot;nameserver ${option}&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        done</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        i=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     maxdom=3D6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    while :; do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        maxdom=3D$((maxdom - 1))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            [ $maxdom -gt 0 ] || break</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            eval option=3D\&quot;\$dns_se=
arch_domain_${i}\&quot; || break</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            [ &quot;${option}&quot; ] || break</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            i=3D$((i + 1))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            echo &quot;searc=
h ${option}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      done</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    } | /=
sbin/resolvconf -a &quot;${dev}&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    ;;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+dns-down)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
sbin/resolvconf -d &quot;${dev}&quot; -f</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    ;;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+esac</span><br><span>diff --git a/distro/dns-scripts/resolvconf_fil=
e-dns-updown.sh b/distro/dns-scripts/resolvconf_file-dns-updown.sh</span><b=
r><span>new file mode 100644</span><br><span>index 0000000..c469490</span><=
br><span>--- /dev/null</span><br><span>+++ b/distro/dns-scripts/resolvconf_=
file-dns-updown.sh</span><br><span>@@ -0,0 +1,84 @@</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#!/bin/sh</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+# Simple OpenVPN up/down script for modifying /etc/resolv.conf</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+# (C) Copyright 2024 OpenV=
PN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# SPDX-=
License-Identifier: BSD-2-Clause</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Exa=
mple env from openvpn (most are not applied):</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#   dev tun0</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#   script-type dns-up</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#   dns_search_domain_1 mycorp.in</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#   dns_search_domain_2 eu.mycorp.com</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_address_1 192.168.99.2=
54</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_=
address_2 fd00::99:53</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#   dns_server_1_port_1 53</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#   dns_server_1_port_2 53</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#   dns_server_1_resolve_domain_1 mycorp.in</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_resolve_domain_2 e=
u.mycorp.com</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns=
_server_1_dnssec true</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#   dns_server_1_transport DoH</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#   dns_server_1_sni dns.mycorp.in</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set -e +u=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+only_standard_server_ports() {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    i=3D1</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    while true; do</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        eval addr=3D\&quot;\$dns_serve=
r_${n}_address_${i}\&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        [ -n &quot;$addr&quot; ] || return 0</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        eval port=3D\&quot;\$dns_server_${n}_port_${i}\&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        [ -z &quot=
;$port&quot; -o &quot;$port&quot; =3D &quot;53&quot; ] || return 1</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        i=3D$(expr $i + 1)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    done</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+conf=3D/etc/r=
esolv.conf</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test -e &=
quot;$conf&quot; || exit 1</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+case &quot;${script_type}&quot; in</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+dns-up)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    n=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    while :; do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    eval addr=3D\&quot;\$dns_server_${n}_address_1\&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        [ -n &quot;$addr&quot; ] || {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            echo &q=
uot;setting DNS failed, no compatible server profile&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            exit 1</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        # Skip server profiles which require DNSSEC,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        # secure transport or use=
 a custom port</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   eval dnssec=3D\&quot;\$dns_server_${n}_dnssec\&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        eval transport=3D\&quot;\$dns_s=
erver_${n}_transport\&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        [ -z &quot;$transport&quot; -o &quot;$transport&quot; =3D &=
quot;plain&quot; ] \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            &amp;&amp; [ -z &quot;$dnssec&quot; -o &quot;$dnssec&quot; =3D=
 &quot;no&quot; ] \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            &amp;&amp; only_standard_server_ports &amp;&amp; break</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        n=3D$(expr $n + 1)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    done</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    eval addr1=3D\&quot;\$dns_server_${n}_address_1\&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    eval addr2=3D\&quot;\$dns_s=
erver_${n}_address_2\&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    eval addr3=3D\&quot;\$dns_server_${n}_address_3\&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    text=3D&quot;### openvpn=
 ${dev} begin ###\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    text=3D&quot;${text}nameserver $addr1\n&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    test -z &quot;$addr2&quot; || text=
=3D&quot;${text}nameserver $addr2\n&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    test -z &quot;$addr3&quot; || text=3D&quot;${text=
}nameserver $addr3\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    test -z =
&quot;$dns_search_domain_1&quot; || {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        for i in $(seq 1 6); do</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            eval domains=3D\&quot;$domains\$d=
ns_search_domain_${i} \&quot; || break</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        done</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        text=3D&quot;${text}search $domains\n&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    text=3D&quot;${text}### openvpn ${dev} en=
d ###&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    sed -i &quot;1i${text}&=
quot; &quot;$conf&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dns-down)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sed -i &quot;/#=
## openvpn ${dev} begin ###/,/### openvpn ${dev} end ###/d&quot; &quot;$con=
f&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+esac</span><br><span>diff=
 --git a/distro/dns-scripts/systemd-dns-updown.sh b/distro/dns-scripts/syst=
emd-dns-updown.sh</span><br><span>new file mode 100644</span><br><span>inde=
x 0000000..69bbebf</span><br><span>--- /dev/null</span><br><span>+++ b/dist=
ro/dns-scripts/systemd-dns-updown.sh</span><br><span>@@ -0,0 +1,194 @@</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/bin/bash</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+# dns-updown - add/remove openvpn provided DNS inf=
ormation</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# Copyright (C) 2024 OpenVPN =
Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# SPDX-Lic=
ense-Identifier: GPL-2.0</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Add/remove =
openvpn DNS settings from the env into/from</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+# the system. Supported backends in this order:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#   * systemd-resolved</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#   * resolvconf</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# Example env from openvpn (not all are always applied):</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#   dev tun0</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#   script-type dns-up</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#   dns_search_domain_1 mycorp.in</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#   dns_search_domain_2 eu.myc=
orp.com</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_serv=
er_1_address_1 192.168.99.254</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#   dns_server_1_address_2 fd00::99:53</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#   dns_server_1_port_1 53</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_port_2 53</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_resolve_domain_=
1 mycorp.in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_=
server_1_resolve_domain_2 eu.mycorp.com</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#   dns_server_1_dnssec true</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#   dns_server_1_transport DoH</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_sni dns.mycorp.in<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+function do_resolved_servers {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    local sni=3D&quot;&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    local transport_var=3Ddns_server_=
${n}_transport</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    l=
ocal sni_var=3Ddns_server_${n}_sni</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    [ &quot;${!transport_var}&quot; =3D &quot;DoT&quot; ] &a=
mp;&amp; sni=3D&quot;#${!sni_var}&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    local i=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 local addrs=3D&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    while :; do</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        local addr_var=3Ddns_server_${n}_address_${i}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        local addr=3D&quot;${!addr_va=
r}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        [ -=
n &quot;$addr&quot; ] || break</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
local port_var=3Ddns_server_${n}_port_${i}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if [ -n &quot;${!port_var}&quot; ]; then</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            if [[ &quot=
;$addr&quot; =3D~ : ]]; then</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                addr=3D&quot;[$addr]&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            fi</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            addrs+=3D&quot;${addr}:${!port_var=
}${sni} &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
addrs+=3D&quot;${addr}${sni} &quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        fi</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        i=3D$((i+1))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    done</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    resolvectl dns &qu=
ot;$dev&quot; $addrs</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+function do_resolved_domains {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    local list=3D&quot;&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for domain_=
var in ${!dns_search_domain_*}; do</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        list+=3D&quot;${!domain_var} &quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    done</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    local domain_var=3Ddns_server_${n}_resolve_=
domain_1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ -z=
 &quot;${!domain_var}&quot; ]; then</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        resolvectl default-route &quot;$dev&quot; true</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        list+=3D&quot;~.=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        resolvectl defau=
lt-route &quot;$dev&quot; false</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        local i=3D1</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        while :; do</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            domain_var=3Ddns_server_${n}_resolve_domain_${i}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            [ -n &quot=
;${!domain_var}&quot; ] || break</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            # Add as split domain (~ prefix), if it doesn&#39;=
t already exist</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        [[ &quot;$list&quot; =3D~ (^| )&quot;${!domain_var}&quot;( |$) ]] \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                || =
list+=3D&quot;~${!domain_var} &quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            i=3D$((i+1))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        done</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    fi</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    resolvectl do=
main &quot;$dev&quot; $list</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+function do_resolved_dnssec {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    local dnssec_va=
r=3Ddns_server_${n}_dnssec</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if [ &quot;${!dnssec_var}&quot; =3D &quot;optional&quot; ]; then=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        resolvectl =
dnssec &quot;$dev&quot; allow-downgrade</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    elif [ &quot;${!dnssec_var}&quot; =3D &quot;yes&quo=
t; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
esolvectl dnssec &quot;$dev&quot; true</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        resolvectl dnssec &quot;$dev&quot; false</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+function do_r=
esolved_dnsovertls {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    local transport_var=3Ddns_server_${n}_transport</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if [ &quot;${!transport_var}&quot; =
=3D &quot;DoT&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        resolvectl dnsovertls &quot;$dev&quot; true</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        resolvectl dnsovertls &quot;$dev&quot;=
 false</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+function do_resolved {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    [[ &quot;$(readlink /etc/resolv.conf)&quot; =3D~ systemd=
 ]] || return 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    n=3D1</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    while :; do</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        local addr_var=3Ddns_server_$=
{n}_address_1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  [ -n &quot;${!addr_var}&quot; ] || {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            echo &quot;setting DNS failed, no compatible=
 server profile&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            return 1</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        # Skip server prof=
iles which require DNS-over-HTTPS</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        local transport_var=3Ddns_server_${n}_transport</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        [ -n &quot;${!tra=
nsport_var}&quot; -a &quot;${!transport_var}&quot; =3D &quot;DoH&quot; ] ||=
 break</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        n=3D$((n+1))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    done</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if [ &quot;$script_type&quot; =3D &quot;dns-up&quot; ]; =
then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        echo &q=
uot;setting DNS using resolvectl&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        do_resolved_servers</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        do_resolved_domains</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        do_resolved_dnssec</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        do_resolved_dnsovertls</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        echo &quot;unsetting DNS =
using resolvectl&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        resolvectl revert &quot;$dev&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    fi</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+function only_standard_server_ports {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    local i=3D1</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    while :; do</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        local addr_var=3Ddns_server_${n}=
_address_${i}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  [ -n &quot;${!addr_var}&quot; ] || return 0</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        local port_var=3Ddns_server_${n}_port_${i}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        [ -z &quot;${!port_var}&quot;=
 -o &quot;${!port_var}&quot; =3D &quot;53&quot; ] || return 1</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        i=3D$((i+1))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    done</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+function do_resolvconf {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    [ -x /sbin/reso=
lvconf ] || return 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    n=3D1</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    while :; do</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        local server_addr_var=3D=
dns_server_${n}_address_1</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        [ -n &quot;${!server_addr_var}&quot; ] || {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            echo &quot;setting DNS fa=
iled, no compatible server profile&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            return 1</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 # Skip server profiles which require DNSSEC,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        # secure transport or use a custom port</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        local dnssec_=
var=3Ddns_server_${n}_dnssec</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        local transport_var=3Ddns_server_${n}_transport</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        [ -z &quot;${!transpor=
t_var}&quot; -o &quot;${!transport_var}&quot; =3D &quot;plain&quot; ] \</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; =
[ -z &quot;${!dnssec_var}&quot; -o &quot;${!dnssec_var}&quot; =3D &quot;no&=
quot; ] \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  &amp;&amp; only_standard_server_ports &amp;&amp; break</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        n=3D$((n+1))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    done</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ &q=
uot;$script_type&quot; =3D &quot;dns-up&quot; ]; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        echo &quot;setting DNS using reso=
lvconf&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 local domains=3D&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        for domain_var in ${!dns_search_domain_*}; do</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            domains+=3D&quot;${=
!domain_var} &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        done</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            local=
 maxns=3D3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   for addr_var in ${!dns_server_1_address_*}; do</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                [ $((maxns--)) -gt 0 ] || bre=
ak</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                e=
cho &quot;nameserver ${!addr_var}&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            done</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            [ -z &quot;$domains&quot; ] || echo &quot;sear=
ch $domains&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      } | /sbin/resolvconf -a &quot;$dev&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        echo &quot;unsetting DNS using resolvconf&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        /sbin/resolvcon=
f -d &quot;$dev&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return 0</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+do_resolved || do_resolvconf</span><br><span>diff --git a/doc/man-sections=
/script-options.rst b/doc/man-sections/script-options.rst</span><br><span>i=
ndex 0d1f9ae..de3842b 100644</span><br><span>--- a/doc/man-sections/script-=
options.rst</span><br><span>+++ b/doc/man-sections/script-options.rst</span=
><br><span>@@ -8,9 +8,13 @@</span><br><span> Script Order of Execution</spa=
n><br><span> -------------------------</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#. ``--dns-updown``</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+   Executed after TCP/UDP socket bind and TUN/TAP open, b=
efore ``--up``.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> #. ``--up``</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-   Executed after TCP/UDP socket bind and TUN/TAP ope=
n.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   Executed after=
 TCP/UDP socket bind and TUN/TAP open, after ``--dns-updown``.</span><br><s=
pan> </span><br><span> #. ``--tls-verify``</span><br><span> </span><br><spa=
n>@@ -38,9 +42,13 @@</span><br><span> </span><br><span>    Executed in ``--=
mode server`` mode on client instance shutdown.</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#. ``--dns-updown``</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+   Executed before TCP/UDP and TUN/TAP close, be=
fore ``--down``.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> #. ``--down``</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-   Executed after TCP/UDP and TUN/TAP close.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+   Executed after TCP/UDP=
 and TUN/TAP close, after ``--dns-updown``.</span><br><span> </span><br><sp=
an> #. ``--learn-address``</span><br><span> </span><br><span>@@ -173,7 +181=
,7 @@</span><br><span>         client-crresponse cmd</span><br><span> </spa=
n><br><span>   OpenVPN will write the response of the client into a tempora=
ry file.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  The filenam=
e will be passed as an argument to ``cmd``, and the file will be</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  The filename will be passed =
as an argument to ``cmd``, and the file will</span><br><span>   automatical=
ly deleted by OpenVPN after the script returns.</span><br><span> </span><br=
><span>   The response is passed as is from the client. The script needs to=
 check</span><br><span>@@ -235,6 +243,31 @@</span><br><span>   The ``--clie=
nt-disconnect`` command is not passed any extra arguments</span><br><span> =
  (only those arguments specified in cmd, if any).</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+--dns-updown cmd</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  Run command ``cmd``, instea=
d of the default DNS up/down command that comes</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  with openvpn. If ``cmd`` is ``disable`` the `=
`--dns-updown`` command is not run.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  I=
f you write your own command, please make sure to ignore ``--dns``</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  server profiles that canno=
t be applied. Port, DNSSEC and secure transport</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  settings need to be adhered to. If split DNS =
is not possible a full redirect</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  can be used as a fallback. If not all of the server addresses=
 or search domains</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 can be configured, apply them in the order they are listed in.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  Note that ``--dns-updown`` is not supported on a=
ll platforms. On Windows DNS</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  will always be set by the service. On Android DNS will be passed=
 via management</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  in=
terface.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  Note that DNS-related ``--dh=
cp-option``\ s might be converted so that they are</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  available to this hook if no ``--dns`` opt=
ions exist. If any ``--dns server``</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  option is present, DNS-related ``--dhcp-option``\ s will =
always be ignored.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 If an ``--up`` script is defined, foreign_option env vars will be generate=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  from ``--dns`` o=
ptions and passed to the script. The default ``--dns-updown``</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  command is not run if an ``--up=
`` script is defined. Both is done for backward</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  compatibility. In case you want to run the ``=
--dns-updown`` command even if</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  there is an ``--up`` defined, you can define a custom command =
or use ``force``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  a=
s ``cmd`` to run the default command. No DNS env vars will be passed to ``-=
-up``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  in this case=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
--down cmd</span><br><span>   Run command ``cmd`` after TUN/TAP device clos=
e (post ``--user`` UID</span><br><span>   change and/or ``--chroot`` ). ``c=
md`` consists of a path to script (or</span><br><span>@@ -661,7 +694,7 @@</=
span><br><span>     names). Set prior to ``--up`` or ``--down`` script exec=
ution.</span><br><span> </span><br><span> :code:`dns_*`</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    The ``--dns`` configuration options w=
ill be made available to script</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    The ``--dns`` configuration options will be made available =
to ``--dns-updown``</span><br><span>     execution through this set of envi=
ronment variables. Variables appear</span><br><span>     only if the corres=
ponding option has a value assigned. For the semantics</span><br><span>    =
 of each individual variable, please refer to the documentation for ``--dns=
``.</span><br><span>diff --git a/src/openvpn/Makefile.am b/src/openvpn/Make=
file.am</span><br><span>index 37af683..2e93ebb 100644</span><br><span>--- a=
/src/openvpn/Makefile.am</span><br><span>+++ b/src/openvpn/Makefile.am</spa=
n><br><span>@@ -30,7 +30,8 @@</span><br><span> 	$(OPTIONAL_LZ4_CFLAGS) \</s=
pan><br><span> 	$(OPTIONAL_PKCS11_HELPER_CFLAGS) \</span><br><span> 	$(OPTI=
ONAL_INOTIFY_CFLAGS) \</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	-DPLUGIN_LIBDIR=3D\&quot;${plugindir}\&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+	-DPLUGIN_LIBDIR=3D\&quot;${plugindir}\&quot; \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-DDEFAULT_DNS_UPDOW=
N=3D\&quot;${scriptdir}/dns-updown\&quot;</span><br><span> </span><br><span=
> if WIN32</span><br><span> # we want unicode entry point but not the macro=
</span><br><span>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><=
br><span>index b6e524f..4da0747 100644</span><br><span>--- a/src/openvpn/dn=
s.c</span><br><span>+++ b/src/openvpn/dns.c</span><br><span>@@ -30,6 +30,7 =
@@</span><br><span> #include &quot;dns.h&quot;</span><br><span> #include &q=
uot;socket.h&quot;</span><br><span> #include &quot;options.h&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;run_command.h=
&quot;</span><br><span> </span><br><span> #ifdef _WIN32</span><br><span> #i=
nclude &quot;win32.h&quot;</span><br><span>@@ -262,6 +263,8 @@</span><br><s=
pan>     clone.search_domains =3D clone_dns_domains(o-&gt;search_domains, g=
c);</span><br><span>     clone.servers =3D clone_dns_servers(o-&gt;servers,=
 gc);</span><br><span>     clone.servers_prepull =3D clone_dns_servers(o-&g=
t;servers_prepull, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    clone.updown =3D o-&gt;updown;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    clone.user_set_updown =3D o-&gt;user_set_updown;</sp=
an><br><span> </span><br><span>     return clone;</span><br><span> }</span>=
<br><span>@@ -548,6 +551,54 @@</span><br><span>     send_msg_iservice(o-&gt=
;msg_channel, &amp;nrpt, sizeof(nrpt), &amp;ack, &quot;DNS&quot;);</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#else /* ifdef _WIN32 */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+updown_env_se=
t(bool up, const struct dns_options *o, const struct tuntap *tt, struct env=
_set *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    setenv_str(es, &quot;dev=
&quot;, tt-&gt;actual_name);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    setenv_str(es, &quot;script_type&quot;, up ? &quot;dns-up&quot=
; : &quot;dns-down&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    setenv_dns_options(o, es);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+do_run_up_down_command(bool =
up, const struct dns_options *o, const struct tuntap *tt)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct argv argv =3D argv_new();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct env_set *e=
s =3D env_set_create(&amp;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    updo=
wn_env_set(up, o, tt, es);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_pri=
ntf(&amp;argv, &quot;%s&quot;, o-&gt;updown);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    argv_msg(M_INFO, &amp;argv);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    int res;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;user_set_updown)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        res =3D openvpn_run_script(&amp;argv=
, es, S_EXITCODE, &quot;dns updown&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        res =3D =
openvpn_execve_check(&amp;argv, es, S_EXITCODE, &quot;WARNING: Failed runni=
ng dns updown&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_fre=
e(&amp;argv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc=
_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return res;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+run_up_down_command(bool up, struct options *o, const=
 struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!o-&gt;dns=
_options.updown)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    int status;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    status =3D do_run_up_down_command(up, &amp;o-&gt;dns_o=
ptions, tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg=
(M_INFO, &quot;dns %s command exited with status %d&quot;, up ? &quot;up&qu=
ot; : &quot;down&quot;, status);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> #endif /* _WIN32 */</span><br><span> </span><br><span> void</s=
pan><br><span>@@ -666,5 +717,7 @@</span><br><span> </span><br><span> #ifdef=
 _WIN32</span><br><span>     run_up_down_service(up, o, tt);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    run_up_down_command(up, o, tt);</span><br><s=
pan> #endif /* ifdef _WIN32 */</span><br><span> }</span><br><span>diff --gi=
t a/src/openvpn/dns.h b/src/openvpn/dns.h</span><br><span>index f24e30b..c4=
d19ff 100644</span><br><span>--- a/src/openvpn/dns.h</span><br><span>+++ b/=
src/openvpn/dns.h</span><br><span>@@ -73,6 +73,8 @@</span><br><span>     st=
ruct dns_server *servers_prepull;</span><br><span>     struct dns_server *s=
ervers;</span><br><span>     struct gc_arena gc;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const char *updown;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool user_set_updown;</span><br><span=
> };</span><br><span> </span><br><span> /**</span><br><span>diff --git a/sr=
c/openvpn/options.c b/src/openvpn/options.c</span><br><span>index 99dd60a..=
b116740 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>=
+++ b/src/openvpn/options.c</span><br><span>@@ -526,10 +526,12 @@</span><br=
><span>     &quot;                  address &lt;addr[:port]&gt; [addr[:port=
] ...] : server addresses 4/6\n&quot;</span><br><span>     &quot;          =
        resolve-domains &lt;domain&gt; [domain ...] : split domains\n&quot;=
</span><br><span>     &quot;                  dnssec &lt;yes|no|optional&gt=
; : option to use DNSSEC\n&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    &quot;                  type &lt;DoH|DoT&gt; : query server =
over HTTPS / TLS\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    &quot;                  transport &lt;DoH|DoT&gt; : query server o=
ver HTTPS / TLS\n&quot;</span><br><span>     &quot;                  sni &l=
t;domain&gt; : DNS server name indication\n&quot;</span><br><span>     &quo=
t;--dns search-domains &lt;domain&gt; [domain ...]:\n&quot;</span><br><span=
>     &quot;                  Add domains to DNS domain search list\n&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--dns-upd=
own cmd|force|disable : Run cmd as user defined dns config command,\n&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;         =
         force running the default script or disable running it.\n&quot;</s=
pan><br><span>     &quot;--auth-retry t  : How to handle auth failures.  Se=
t t to\n&quot;</span><br><span>     &quot;                  none (default),=
 interact, or nointeract.\n&quot;</span><br><span>     &quot;--static-chall=
enge t e [&lt;scrv1|concat&gt;]: Enable static challenge/response protocol =
using\n&quot;</span><br><span>@@ -921,6 +923,10 @@</span><br><span> #ifndef=
 ENABLE_DCO</span><br><span>     o-&gt;disable_dco =3D true;</span><br><spa=
n> #endif /* ENABLE_DCO */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABL=
E_DNS_UPDOWN_BY_DEFAULT</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    o-&gt;dns_options.updown =3D DEFAULT_DNS_UPDOWN;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif /* ENABLE_DNS_UPDOWN_BY_DEFAULT=
 */</span><br><span> }</span><br><span> </span><br><span> void</span><br><s=
pan>@@ -8087,6 +8093,39 @@</span><br><span>         to-&gt;ip_win32_defined=
 =3D true;</span><br><span>     }</span><br><span> #endif /* ifdef _WIN32 *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq=
(p[0], &quot;dns-updown&quot;) &amp;&amp; p[1])</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        VERIFY_PERMISSION(OPT_P_SCRIPT);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (!no_more_than_n_args(msgleve=
l, p, 2, NM_QUOTE_HINT))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struc=
t dns_options *dns =3D &amp;options-&gt;dns_options;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (streq(p[1], &quot;disable&quo=
t;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            dns-&gt;updow=
n =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    dns-&gt;user_set_updown =3D false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        else if (streq(p[1], &quot;force&quot;))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            /* force dns-updown run, even if a =
--up script is defined */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            if (dns-&gt;user_set_updown =3D=3D false)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                dns-&gt;updown =3D DEFAUL=
T_DNS_UPDOWN;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          dns-&gt;user_set_updown =3D true;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   if (streq(dns-&gt;updown, DEFAULT_DNS_UPDOWN))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                /* Unset the default command to pre=
vent warnings */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             dns-&gt;updown =3D NULL;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            set_user_script(options, &amp;dns-&gt;updown, p[1],=
 p[0], false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       dns-&gt;user_set_updown =3D true;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span>     else if (streq(p[0], &quot;dns&quot;)=
 &amp;&amp; p[1])</span><br><span>     {</span><br><span>         VERIFY_PE=
RMISSION(OPT_P_DHCPDNS);</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail">change 8=
38</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifbe4ffb44d3bfcaa50adb38cacb=
3436fcdc71b10 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 838 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 20 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--mhfmDBFhPbo=--

