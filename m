From: "d12fk (Code Review)" <gerrit@...515...>
Date: Fri, 7 Mar 2025 02:39:34 +0000
In-Reply-To: <gerrit.1733989644000.Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10@...2715...>
References: <gerrit.1733989644000.Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <9a354d867502c312b8b2f6c1945ba35dc6357a12-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="I2JodpDsQIo="; charset=UTF-8
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

--I2JodpDsQIo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail

to look at the new patch set (#12).


Change subject: dns: apply settings via script on unixoid systems
......................................................................

dns: apply settings via script on unixoid systems

This introduces a new script hook, the dns-script and implements such a
script for a few popular systems (and a default for the not so popular
ones). Like the name suggests this script is soleley for dealing with
modifying how names are resolved when the VPN pushes some --dns
settings.

The default dns script is part of the distribution and is installed with
openvpn. You can change the path the script is located at as a compile
time option, defaults to libexecdir. There's also a new runtime option
--dns-script, which can run a custom script.

Change-Id: Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M .gitignore
M CMakeLists.txt
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
14 files changed, 622 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/38/838/12

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
index b04adce..2696691 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -41,7 +41,8 @@
 option(USE_WERROR "Treat compiler warnings as errors (-Werror)" ON)
 option(FAKE_ANDROID "Target Android but do not use actual cross compile/An=
droid cmake to build for simple compile checks on Linux")

-set(PLUGIN_DIR /usr/local/lib/openvpn/plugins CACHE FILEPATH "Location of =
the plugin directory")
+set(DNS_UPDOWN_PATH "${CMAKE_INSTALL_PREFIX}/libexec/openvpn/dns-updown" C=
ACHE STRING "Default location for the DNS up/down script")
+set(PLUGIN_DIR "${CMAKE_INSTALL_PREFIX}/lib/openvpn/plugins" CACHE FILEPAT=
H "Location of the plugin directory")

 # Create machine readable compile commands
 option(ENABLE_COMPILE_COMMANDS "Generate compile_commands.json and a symli=
nk for clangd to find it" OFF)
@@ -577,6 +578,8 @@

 add_library_deps(openvpn)

+target_compile_options(openvpn PRIVATE -DDNS_UPDOWN_PATH=3D\"${DNS_UPDOWN_=
PATH}\")
+
 if(MINGW)
     target_compile_options(openvpn PRIVATE -municode -UUNICODE)
     target_link_options(openvpn PRIVATE -municode)
diff --git a/configure.ac b/configure.ac
index 9777e36..45d3ac1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -315,37 +315,50 @@
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
+AM_CONDITIONAL([ENABLE_DNS_SCRIPT],[true])
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
+		AM_CONDITIONAL([ENABLE_DNS_SCRIPT],[false])
+		AC_SUBST([DNS_UPDOWN_TYPE], ["resolvconf_file"])
 		have_tap_header=3D"yes"
 		ac_cv_type_struct_in_pktinfo=3Dno
 		;;
@@ -353,6 +366,8 @@
 		AC_DEFINE([TARGET_WIN32], [1], [Are we running WIN32?])
 		AC_DEFINE([ENABLE_DCO], [1], [DCO is always enabled on Windows])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["W"], [Target prefix])
+		AM_CONDITIONAL([ENABLE_DNS_SCRIPT],[false])
+		AC_SUBST([DNS_UPDOWN_TYPE], ["windows"])
 		CPPFLAGS=3D"${CPPFLAGS} -DWIN32_LEAN_AND_MEAN"
 		CPPFLAGS=3D"${CPPFLAGS} -DNTDDI_VERSION=3DNTDDI_VISTA -D_WIN32_WINNT=3D_=
WIN32_WINNT_VISTA"
 		WIN32=3Dyes
@@ -360,10 +375,12 @@
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
@@ -371,10 +388,12 @@
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
@@ -1505,6 +1524,7 @@

 sampledir=3D"\$(docdir)/sample"
 AC_SUBST([plugindir])
+AC_SUBST([scriptdir])
 AC_SUBST([sampledir])

 AC_SUBST([systemdunitdir])
@@ -1541,6 +1561,7 @@
 	Makefile
 	distro/Makefile
 	distro/systemd/Makefile
+	distro/dns-scripts/Makefile
 	doc/Makefile
 	doc/doxygen/Makefile
 	doc/doxygen/openvpn.doxyfile
diff --git a/distro/Makefile.am b/distro/Makefile.am
index 7a588da..b8fb85b 100644
--- a/distro/Makefile.am
+++ b/distro/Makefile.am
@@ -13,3 +13,7 @@
 	$(srcdir)/Makefile.in

 SUBDIRS =3D systemd
+
+if ENABLE_DNS_SCRIPT
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
index 0d1f9ae..a671117 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -8,9 +8,13 @@
 Script Order of Execution
 -------------------------

+#. ``--dns-script``
+
+   Executed after TCP/UDP socket bind and TUN/TAP open, before ``--up``.
+
 #. ``--up``

-   Executed after TCP/UDP socket bind and TUN/TAP open.
+   Executed after TCP/UDP socket bind and TUN/TAP open, after ``--dns-scri=
pt``.

 #. ``--tls-verify``

@@ -38,9 +42,13 @@

    Executed in ``--mode server`` mode on client instance shutdown.

+#. ``--dns-script``
+
+   Executed before TCP/UDP and TUN/TAP close, before ``--down``.
+
 #. ``--down``

-   Executed after TCP/UDP and TUN/TAP close.
+   Executed after TCP/UDP and TUN/TAP close, after ``--dns-script``.

 #. ``--learn-address``

@@ -173,7 +181,7 @@
         client-crresponse cmd

   OpenVPN will write the response of the client into a temporary file.
-  The filename will be passed as an argument to ``cmd``, and the file will=
 be
+  The filename will be passed as an argument to ``cmd``, and the file will
   automatically deleted by OpenVPN after the script returns.

   The response is passed as is from the client. The script needs to check
@@ -235,6 +243,23 @@
   The ``--client-disconnect`` command is not passed any extra arguments
   (only those arguments specified in cmd, if any).

+--dns-script cmd | disable
+  Run command ``cmd``, instead of the default DNS command that comes with
+  openvpn. If ``cmd`` is ``disable`` no command is executed to set ``--dns=
``
+  options. If you write your own command, please make sure to ignore ``--d=
ns``
+  server profiles that cannot be applied. Port, DNSSEC and secure transport
+  settings need to be adhered to. If split DNS is not possible a full redi=
rect
+  can be used as a fallback. If not all of the server addresses or search =
domains
+  can be configured, apply them on the order they are listed in.
+
+  Note that ``--dns-script`` is not supported on Windows. DNS will
+  always be set by the service there.
+
+  Note that DNS-related ``--dhcp-option``s will not be handled by this hoo=
k.
+  If any ``--dns server`` option is present, DNS-related ``--dhcp-option``=
s will
+  be ignored. Otherwise foreign_option environment variables will be passe=
d to
+  ``--up`` and ``--down`` hooks for backward compatibility.
+
 --down cmd
   Run command ``cmd`` after TUN/TAP device close (post ``--user`` UID
   change and/or ``--chroot`` ). ``cmd`` consists of a path to script (or
@@ -661,7 +686,7 @@
     names). Set prior to ``--up`` or ``--down`` script execution.

 :code:`dns_*`
-    The ``--dns`` configuration options will be made available to script
+    The ``--dns`` configuration options will be made available to ``--dns-=
script``
     execution through this set of environment variables. Variables appear
     only if the corresponding option has a value assigned. For the semanti=
cs
     of each individual variable, please refer to the documentation for ``-=
-dns``.
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 37af683..6664aae 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -30,7 +30,8 @@
 	$(OPTIONAL_LZ4_CFLAGS) \
 	$(OPTIONAL_PKCS11_HELPER_CFLAGS) \
 	$(OPTIONAL_INOTIFY_CFLAGS) \
-	-DPLUGIN_LIBDIR=3D\"${plugindir}\"
+	-DPLUGIN_LIBDIR=3D\"${plugindir}\" \
+	-DDNS_UPDOWN_PATH=3D\"${scriptdir}/dns-updown\"

 if WIN32
 # we want unicode entry point but not the macro
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index b6e524f..6a4669f 100644
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
+    clone.script =3D o->script;
+    clone.user_defined_script =3D o->user_defined_script;

     return clone;
 }
@@ -548,6 +551,54 @@
     send_msg_iservice(o->msg_channel, &nrpt, sizeof(nrpt), &ack, "DNS");
 }

+#else /* ifdef _WIN32 */
+
+static void
+script_env_set(bool up, const struct dns_options *o, const struct tuntap *=
tt, struct env_set *es)
+{
+    setenv_str(es, "dev", tt->actual_name);
+    setenv_str(es, "script_type", up ? "dns-up" : "dns-down");
+    setenv_dns_options(o, es);
+}
+
+static int
+do_run_up_down_script(bool up, const struct dns_options *o, const struct t=
untap *tt)
+{
+    struct gc_arena gc =3D gc_new();
+    struct argv argv =3D argv_new();
+    struct env_set *es =3D env_set_create(&gc);
+
+    script_env_set(up, o, tt, es);
+
+    argv_printf(&argv, "%s", o->script);
+    argv_msg(M_INFO, &argv);
+    int res;
+    if (o->user_defined_script)
+    {
+        res =3D openvpn_run_script(&argv, es, S_EXITCODE, "dns script");
+    }
+    else
+    {
+        res =3D openvpn_execve_check(&argv, es, S_EXITCODE, "WARNING: Fail=
ed running dns script");
+    }
+    argv_free(&argv);
+    gc_free(&gc);
+    return res;
+}
+
+static void
+run_up_down_script(bool up, struct options *o, const struct tuntap *tt)
+{
+    if (!o->dns_options.script)
+    {
+        return;
+    }
+
+    int status;
+    status =3D do_run_up_down_script(up, &o->dns_options, tt);
+    msg(M_INFO, "dns script exited with status %d", status);
+}
+
 #endif /* _WIN32 */

 void
@@ -666,5 +717,7 @@

 #ifdef _WIN32
     run_up_down_service(up, o, tt);
+#else
+    run_up_down_script(up, o, tt);
 #endif /* ifdef _WIN32 */
 }
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index f24e30b..38ced79 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -73,6 +73,8 @@
     struct dns_server *servers_prepull;
     struct dns_server *servers;
     struct gc_arena gc;
+    const char *script;
+    bool user_defined_script;
 };

 /**
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 11a19bb..48fefb2 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -528,6 +528,7 @@
     "                  sni <domain> : DNS server name indication\n"
     "--dns search-domains <domain> [domain ...]:\n"
     "                  Add domains to DNS domain search list\n"
+    "--dns-script cmd : Run cmd as user defined dns configuration script\n"
     "--auth-retry t  : How to handle auth failures.  Set t to\n"
     "                  none (default), interact, or nointeract.\n"
     "--static-challenge t e [<scrv1|concat>]: Enable static challenge/resp=
onse protocol using\n"
@@ -919,6 +920,8 @@
 #ifndef ENABLE_DCO
     o->disable_dco =3D true;
 #endif /* ENABLE_DCO */
+
+    o->dns_options.script =3D DNS_UPDOWN_PATH;
 }

 void
@@ -8194,6 +8197,28 @@
         to->ip_win32_defined =3D true;
     }
 #endif /* ifdef _WIN32 */
+    else if (streq(p[0], "dns-script") && p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_SCRIPT);
+        if (!no_more_than_n_args(msglevel, p, 2, NM_QUOTE_HINT))
+        {
+            goto err;
+        }
+        if (streq(p[1], "disable"))
+        {
+            options->dns_options.script =3D NULL;
+        }
+        else
+        {
+            if (options->dns_options.user_defined_script =3D=3D false)
+            {
+                /* Unset the default script to prevent warnings */
+                options->dns_options.script =3D NULL;
+            }
+            set_user_script(options, &options->dns_options.script, p[1], p=
[0], false);
+            options->dns_options.user_defined_script =3D true;
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
Gerrit-PatchSet: 12
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--I2JodpDsQIo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk <strong>uploaded patch set #12</strong> to this change.</p><p><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail">View Change</=
a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">dns: apply settings via script on unixoid systems<br><br>This introduces=
 a new script hook, the dns-script and implements such a<br>script for a fe=
w popular systems (and a default for the not so popular<br>ones). Like the =
name suggests this script is soleley for dealing with<br>modifying how name=
s are resolved when the VPN pushes some --dns<br>settings.<br><br>The defau=
lt dns script is part of the distribution and is installed with<br>openvpn.=
 You can change the path the script is located at as a compile<br>time opti=
on, defaults to libexecdir. There&#39;s also a new runtime option<br>--dns-=
script, which can run a custom script.<br><br>Change-Id: Ifbe4ffb44d3bfcaa5=
0adb38cacb3436fcdc71b10<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&g=
t;<br>---<br>M .gitignore<br>M CMakeLists.txt<br>M configure.ac<br>M distro=
/Makefile.am<br>A distro/dns-scripts/Makefile.am<br>A distro/dns-scripts/ha=
ikuos_file-dns-updown.sh<br>A distro/dns-scripts/openresolv-dns-updown.sh<b=
r>A distro/dns-scripts/resolvconf_file-dns-updown.sh<br>A distro/dns-script=
s/systemd-dns-updown.sh<br>M doc/man-sections/script-options.rst<br>M src/o=
penvpn/Makefile.am<br>M src/openvpn/dns.c<br>M src/openvpn/dns.h<br>M src/o=
penvpn/options.c<br>14 files changed, 622 insertions(+), 8 deletions(-)<br>=
<br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/38/838/=
12</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;"><span>diff --git a/.gitignore b/.gitignore</span><br><span>index db8bb=
73..04523af 100644</span><br><span>--- a/.gitignore</span><br><span>+++ b/.=
gitignore</span><br><span>@@ -49,6 +49,7 @@</span><br><span> /doc/doxygen/l=
atex/</span><br><span> /doc/doxygen/openvpn.doxyfile</span><br><span> distr=
o/systemd/*.service</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
distro/dns-scripts/dns-updown</span><br><span> sample/sample-keys/sample-ca=
/</span><br><span> vendor/cmocka_build</span><br><span> vendor/dist</span><=
br><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index=
 b04adce..2696691 100644</span><br><span>--- a/CMakeLists.txt</span><br><sp=
an>+++ b/CMakeLists.txt</span><br><span>@@ -41,7 +41,8 @@</span><br><span> =
option(USE_WERROR &quot;Treat compiler warnings as errors (-Werror)&quot; O=
N)</span><br><span> option(FAKE_ANDROID &quot;Target Android but do not use=
 actual cross compile/Android cmake to build for simple compile checks on L=
inux&quot;)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-set(PLUGIN_DIR /usr/local/lib/openvpn/plugins CACHE FILEPATH &quot;=
Location of the plugin directory&quot;)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+set(DNS_UPDOWN_PATH &quot;${CMAKE_INSTALL_PREFIX}/libex=
ec/openvpn/dns-updown&quot; CACHE STRING &quot;Default location for the DNS=
 up/down script&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+set(PLUGIN_DIR &quot;${CMAKE_INSTALL_PREFIX}/lib/openvpn/plugins&quot; C=
ACHE FILEPATH &quot;Location of the plugin directory&quot;)</span><br><span=
> </span><br><span> # Create machine readable compile commands</span><br><s=
pan> option(ENABLE_COMPILE_COMMANDS &quot;Generate compile_commands.json an=
d a symlink for clangd to find it&quot; OFF)</span><br><span>@@ -577,6 +578=
,8 @@</span><br><span> </span><br><span> add_library_deps(openvpn)</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+target_com=
pile_options(openvpn PRIVATE -DDNS_UPDOWN_PATH=3D\&quot;${DNS_UPDOWN_PATH}\=
&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> if(MINGW)</span><br><span>     target_compile_options(openvpn PRIVATE=
 -municode -UUNICODE)</span><br><span>     target_link_options(openvpn PRIV=
ATE -municode)</span><br><span>diff --git a/configure.ac b/configure.ac</sp=
an><br><span>index 9777e36..45d3ac1 100644</span><br><span>--- a/configure.=
ac</span><br><span>+++ b/configure.ac</span><br><span>@@ -315,37 +315,50 @@=
</span><br><span> 	plugindir=3D&quot;\${libdir}/openvpn/plugins&quot;</span=
><br><span> fi</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+AC_ARG_VAR([SCRIPTDIR], [Path of script directory @&lt;:@defau=
lt=3DPKGLIBEXECDIR@:&gt;@])</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+if test -n &quot;${SCRIPTDIR}&quot;; then</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+	scriptdir=3D&quot;${SCRIPTDIR}&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	scriptdir=3D&quot;\${pkglibexecdir}&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> AC_DEFINE_UNQUOTE=
D([TARGET_ALIAS], [&quot;${host}&quot;], [A string representing our host])<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-AM_CONDITIONAL([TARGET=
_LINUX], [false])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+AM=
_CONDITIONAL([ENABLE_DNS_SCRIPT],[true])</span><br><span> case &quot;$host&=
quot; in</span><br><span> 	*-*-linux*)</span><br><span> 		AC_DEFINE([TARGET=
_LINUX], [1], [Are we running on Linux?])</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-		AM_CONDITIONAL([TARGET_LINUX], [true])</span><br><spa=
n> 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&quot;L&quot;], [Target prefix])<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+		AC_SUBST([DNS_UPDO=
WN_TYPE], [&quot;systemd&quot;])</span><br><span> 		have_sitnl=3D&quot;yes&=
quot;</span><br><span> 		pkg_config_required=3D&quot;yes&quot;</span><br><s=
pan> 		;;</span><br><span> 	*-*-solaris*)</span><br><span> 		AC_DEFINE([TAR=
GET_SOLARIS], [1], [Are we running on Solaris?])</span><br><span> 		AC_DEFI=
NE_UNQUOTED([TARGET_PREFIX], [&quot;S&quot;], [Target prefix])</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+		AC_SUBST([DNS_UPDOWN_TYPE], [&=
quot;resolvconf_file&quot;])</span><br><span> 		CPPFLAGS=3D&quot;$CPPFLAGS =
-D_XPG4_2&quot;</span><br><span> 		test -x /bin/bash &amp;&amp; SHELL=3D&qu=
ot;/bin/bash&quot;</span><br><span> 		;;</span><br><span> 	*-*-openbsd*)</s=
pan><br><span> 		AC_DEFINE([TARGET_OPENBSD], [1], [Are we running on OpenBS=
D?])</span><br><span> 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&quot;O&quot;]=
, [Target prefix])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
	AC_SUBST([DNS_UPDOWN_TYPE], [&quot;resolvconf_file&quot;])</span><br><span=
> 		;;</span><br><span> 	*-*-freebsd*)</span><br><span> 		AC_DEFINE([TARGET=
_FREEBSD], [1], [Are we running on FreeBSD?])</span><br><span> 		AC_DEFINE_=
UNQUOTED([TARGET_PREFIX], [&quot;F&quot;], [Target prefix])</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+		AC_SUBST([DNS_UPDOWN_TYPE], [&quo=
t;openresolv&quot;])</span><br><span> 		;;</span><br><span> 	*-*-netbsd*)</=
span><br><span> 		AC_DEFINE([TARGET_NETBSD], [1], [Are we running NetBSD?])=
</span><br><span> 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&quot;N&quot;], [T=
arget prefix])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		AC_=
SUBST([DNS_UPDOWN_TYPE], [&quot;openresolv&quot;])</span><br><span> 		;;</s=
pan><br><span> 	*-*-darwin*)</span><br><span> 		AC_DEFINE([TARGET_DARWIN], =
[1], [Are we running on Mac OS X?])</span><br><span> 		AC_DEFINE_UNQUOTED([=
TARGET_PREFIX], [&quot;M&quot;], [Target prefix])</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+		AM_CONDITIONAL([ENABLE_DNS_SCRIPT],[false])=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		AC_SUBST([DNS_UPD=
OWN_TYPE], [&quot;resolvconf_file&quot;])</span><br><span> 		have_tap_heade=
r=3D&quot;yes&quot;</span><br><span> 		ac_cv_type_struct_in_pktinfo=3Dno</s=
pan><br><span> 		;;</span><br><span>@@ -353,6 +366,8 @@</span><br><span> 		=
AC_DEFINE([TARGET_WIN32], [1], [Are we running WIN32?])</span><br><span> 		=
AC_DEFINE([ENABLE_DCO], [1], [DCO is always enabled on Windows])</span><br>=
<span> 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&quot;W&quot;], [Target prefi=
x])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		AM_CONDITIONAL=
([ENABLE_DNS_SCRIPT],[false])</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+		AC_SUBST([DNS_UPDOWN_TYPE], [&quot;windows&quot;])</span><br><s=
pan> 		CPPFLAGS=3D&quot;${CPPFLAGS} -DWIN32_LEAN_AND_MEAN&quot;</span><br><=
span> 		CPPFLAGS=3D&quot;${CPPFLAGS} -DNTDDI_VERSION=3DNTDDI_VISTA -D_WIN32=
_WINNT=3D_WIN32_WINNT_VISTA&quot;</span><br><span> 		WIN32=3Dyes</span><br>=
<span>@@ -360,10 +375,12 @@</span><br><span> 	*-*-dragonfly*)</span><br><sp=
an> 		AC_DEFINE([TARGET_DRAGONFLY], [1], [Are we running on DragonFlyBSD?])=
</span><br><span> 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&quot;D&quot;], [T=
arget prefix])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		AC_=
SUBST([DNS_UPDOWN_TYPE], [&quot;openresolv&quot;])</span><br><span> 		;;</s=
pan><br><span> 	*-aix*)</span><br><span> 		AC_DEFINE([TARGET_AIX], [1], [Ar=
e we running AIX?])</span><br><span> 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], =
[&quot;A&quot;], [Target prefix])</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+		AC_SUBST([DNS_UPDOWN_TYPE], [&quot;resolvconf_file&quot;])<=
/span><br><span> 		ROUTE=3D&quot;/usr/sbin/route&quot;</span><br><span> 		h=
ave_tap_header=3D&quot;yes&quot;</span><br><span> 		ac_cv_header_net_if_h=
=3D&quot;no&quot;	# exists, but breaks things</span><br><span>@@ -371,10 +3=
88,12 @@</span><br><span> 	*-*-haiku*)</span><br><span> 		AC_DEFINE([TARGET=
_HAIKU], [1], [Are we running Haiku?])</span><br><span> 		AC_DEFINE_UNQUOTE=
D([TARGET_PREFIX], [&quot;H&quot;], [Target prefix])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+		AC_SUBST([DNS_UPDOWN_TYPE], [&quot;haik=
uos_file&quot;])</span><br><span> 		LIBS=3D&quot;${LIBS} -lnetwork&quot;</s=
pan><br><span> 		;;</span><br><span> 	*)</span><br><span> 		AC_DEFINE_UNQUO=
TED([TARGET_PREFIX], [&quot;X&quot;], [Target prefix])</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+		AC_SUBST([DNS_UPDOWN_TYPE], [&quot;res=
olvconf_file&quot;])</span><br><span> 		have_tap_header=3D&quot;yes&quot;</=
span><br><span> 		;;</span><br><span> esac</span><br><span>@@ -1505,6 +1524=
,7 @@</span><br><span> </span><br><span> sampledir=3D&quot;\$(docdir)/sampl=
e&quot;</span><br><span> AC_SUBST([plugindir])</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+AC_SUBST([scriptdir])</span><br><span> AC_SUBST(=
[sampledir])</span><br><span> </span><br><span> AC_SUBST([systemdunitdir])<=
/span><br><span>@@ -1541,6 +1561,7 @@</span><br><span> 	Makefile</span><br>=
<span> 	distro/Makefile</span><br><span> 	distro/systemd/Makefile</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+	distro/dns-scripts/Makefile<=
/span><br><span> 	doc/Makefile</span><br><span> 	doc/doxygen/Makefile</span=
><br><span> 	doc/doxygen/openvpn.doxyfile</span><br><span>diff --git a/dist=
ro/Makefile.am b/distro/Makefile.am</span><br><span>index 7a588da..b8fb85b =
100644</span><br><span>--- a/distro/Makefile.am</span><br><span>+++ b/distr=
o/Makefile.am</span><br><span>@@ -13,3 +13,7 @@</span><br><span> 	$(srcdir)=
/Makefile.in</span><br><span> </span><br><span> SUBDIRS =3D systemd</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+if ENABLE_DNS_SCRIPT</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+SUBDIRS +=3D dns-scripts</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+endif</span><br><span>diff --git a/distr=
o/dns-scripts/Makefile.am b/distro/dns-scripts/Makefile.am</span><br><span>=
new file mode 100644</span><br><span>index 0000000..ec7bfde</span><br><span=
>--- /dev/null</span><br><span>+++ b/distro/dns-scripts/Makefile.am</span><=
br><span>@@ -0,0 +1,28 @@</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  OpenVPN -=
- An application to securely tunnel IP networks</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#             over a single UDP port, with supp=
ort for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#             session authentication and key exchange,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#             packet encryption, packe=
t authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#             packet compression.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
 Copyright (C) 2002-2024 OpenVPN Inc &lt;sales@...515...&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+MAINTAINERCLEANFILES =3D \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+	$(srcdir)/Makefile.in</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+EXTRA=
_DIST =3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	systemd=
-dns-updown.sh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	op=
enresolv-dns-updown.sh \</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	haikuos_file-dns-updown.sh \</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+	resolvconf_file-dns-updown.sh</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+script_SCRIPTS =3D \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+	dns-updown</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLEANFILES =3D $(sc=
ript_SCRIPTS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+dns-updown: @DNS_UPDOWN_T=
YPE@...2841...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	cp $=
{srcdir}/@DNS_UPDOWN_TYPE@...2841... $@</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+all: $(script_SCRIPTS)</span><br><span>diff --git a/distro/dns-scripts/hai=
kuos_file-dns-updown.sh b/distro/dns-scripts/haikuos_file-dns-updown.sh</sp=
an><br><span>new file mode 100644</span><br><span>index 0000000..1b03e9c</s=
pan><br><span>--- /dev/null</span><br><span>+++ b/distro/dns-scripts/haikuo=
s_file-dns-updown.sh</span><br><span>@@ -0,0 +1,84 @@</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#!/bin/sh</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+# Simple OpenVPN up/down script for modifying Haiku OS resolv.conf</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+# (C) Copyright 2024 O=
penVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# S=
PDX-License-Identifier: BSD-2-Clause</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 Example env from openvpn (most are not applied):</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#   dev tun0</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#   script-type dns-up</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#   dns_search_domain_1 mycorp.in</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#   dns_search_domain_2 eu.mycorp.com</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_address_1 192.168.=
99.254</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_serve=
r_1_address_2 fd00::99:53</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#   dns_server_1_port_1 53</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#   dns_server_1_port_2 53</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#   dns_server_1_resolve_domain_1 mycorp.in</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_resolve_domain=
_2 eu.mycorp.com</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  =
 dns_server_1_dnssec true</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#   dns_server_1_transport DoH</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#   dns_server_1_sni dns.mycorp.in</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set=
 -e +u</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+conly_standard_server_ports() {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=3D1</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    while true; do</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        eval addr=3D\&quot;\$dn=
s_server_${n}_address_${i}\&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        [ -n &quot;$addr&quot; ] || return 0</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        eval port=3D\&quot;\$dns_server_${n}_port_${i}\=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        [ -z =
&quot;$port&quot; -o &quot;$port&quot; =3D &quot;53&quot; ] || return 1</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        i=3D$(expr $i + 1)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    done</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+onf=3D/=
boot/system/settings/network/resolv.conf</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+test -e &quot;$conf&quot; || exit 1</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+case &quot;${script_type}&quot; in</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+dns-up)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    n=3D1</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    while :; do</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        eval addr=3D\&quot;\$dns_server_${n}_addr=
ess_1\&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 [ -n &quot;$addr&quot; ] || {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            echo &quot;setting DNS failed, no compatible server =
profile&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      exit 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        # Skip server profiles which=
 require DNSSEC,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     # secure transport or use a custom port</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        eval dnssec=3D\&quot;\$dns_server_${n}_dns=
sec\&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e=
val transport=3D\&quot;\$dns_server_${n}_transport\&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        [ -z &quot;$transport&quot; -=
o &quot;$transport&quot; =3D &quot;plain&quot; ] \</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            &amp;&amp; [ -z &quot;$dnssec&qu=
ot; -o &quot;$dnssec&quot; =3D &quot;no&quot; ] \</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            &amp;&amp; only_standard_server_p=
orts &amp;&amp; break</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        n=3D$(exp=
r $n + 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    done</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    eval addr1=3D\&quot;\$dns_server_${n=
}_address_1\&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   eval addr2=3D\&quot;\$dns_server_${n}_address_2\&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    eval addr3=3D\&quot;\$dns_server_=
${n}_address_3\&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    text=3D&quot;### openvpn ${dev} begin ###\n&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    text=3D&quot;${text}nameserver $add=
r1\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    test =
-z &quot;$addr2&quot; || text=3D&quot;${text}nameserver $addr2\n&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    test -z &quot;$addr3=
&quot; || text=3D&quot;${text}nameserver $addr3\n&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    test -z &quot;$dns_search_domain_1&quot; || {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        for i in $(seq 1 6);=
 do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            eval=
 domains=3D\&quot;$domains\$dns_search_domain_${i} \&quot; || break</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        done</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        text=3D&quot;${text}search=
 $domains\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    text=3D&quot=
;${text}### openvpn ${dev} end ###&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    sed -i &quot;1i${text}&quot; &quot;$conf&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ;;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+dns-down)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    sed -i &quot;/### openvpn ${dev} begin ###/,/### openvpn ${d=
ev} end ###/d&quot; &quot;$conf&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    ;;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+esac</span><br><span>diff --git a/distro/dns-scripts/openresolv-dns-up=
down.sh b/distro/dns-scripts/openresolv-dns-updown.sh</span><br><span>new f=
ile mode 100644</span><br><span>index 0000000..1b218f5</span><br><span>--- =
/dev/null</span><br><span>+++ b/distro/dns-scripts/openresolv-dns-updown.sh=
</span><br><span>@@ -0,0 +1,89 @@</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#!/bin/sh</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Simple OpenV=
PN up/down script for openresolv integration</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+# (C) Copyright 2016 Baptiste Daroussin</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#               2024 OpenVPN I=
nc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# SPDX-Lice=
nse-Identifier: BSD-2-Clause</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Example=
 env from openvpn (most are not applied):</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#   dev tun0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  =
 script-type dns-up</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#   dns_search_domain_1 mycorp.in</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#   dns_search_domain_2 eu.mycorp.com</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_address_1 192.168.99.254=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_ad=
dress_2 fd00::99:53</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#   dns_server_1_port_1 53</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#   dns_server_1_port_2 53</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#   dns_server_1_resolve_domain_1 mycorp.in</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_resolve_domain_2 eu.=
mycorp.com</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_s=
erver_1_dnssec true</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#   dns_server_1_transport DoH</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#   dns_server_1_sni dns.mycorp.in</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set -e +u</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+only_standard_server_ports() {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    i=3D1</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    while true; do</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        eval addr=3D\&quot;\$dns_server_=
${n}_address_${i}\&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        [ -n &quot;$addr&quot; ] || return 0</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        eval port=3D\&quot;\$dns_server_${n}_port_${i}\&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        [ -z &quot;$po=
rt&quot; -o &quot;$port&quot; =3D &quot;53&quot; ] || return 1</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        i=3D$(expr $i + 1)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    done</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+: ${script_type:=
=3Ddns-down}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+case &q=
uot;${script_type}&quot; in</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+dns-up)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
n=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while :; d=
o</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        eval addr=
=3D\&quot;\$dns_server_${n}_address_1\&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        [ -n &quot;$addr&quot; ] || {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            echo &quot;setting D=
NS failed, no compatible server profile&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            exit 1</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    # Skip server profiles which require DNSSEC,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        # secure transport or use a custom por=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        eval dnsse=
c=3D\&quot;\$dns_server_${n}_dnssec\&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        eval transport=3D\&quot;\$dns_server_${n}_tr=
ansport\&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   [ -z &quot;$transport&quot; -o &quot;$transport&quot; =3D &quot;plain&qu=
ot; ] \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
&amp;&amp; [ -z &quot;$dnssec&quot; -o &quot;$dnssec&quot; =3D &quot;no&quo=
t; ] \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &=
amp;&amp; only_standard_server_ports &amp;&amp; break</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        n=3D$(expr $n + 1)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    done</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=3D1</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        maxns=3D3</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        while :; do</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            maxns=3D$((maxns -=
 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            [ $=
maxns -gt 0 ] || break</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            eval option=3D\&quot;\$dns_server_${n}_address_${i}\&quot; |=
| break</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
[ &quot;${option}&quot; ] || break</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            i=3D$((i + 1))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            echo &quot;nameserver ${option}&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        done</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        i=3D1</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        maxdom=3D6</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        while :; do</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            maxdom=3D$((maxdom - 1))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            [ $maxdo=
m -gt 0 ] || break</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           eval option=3D\&quot;\$dns_search_domain_${i}\&quot; || break</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            [ &quot;${=
option}&quot; ] || break</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            i=3D$((i + 1))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            echo &quot;search ${option}&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        done</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    } | /sbin/resolvconf -a &quot;${dev}&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+dns-down)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /sbin/resolvconf -d &quot;${dev}&quo=
t; -f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+esac</span><br><span>diff -=
-git a/distro/dns-scripts/resolvconf_file-dns-updown.sh b/distro/dns-script=
s/resolvconf_file-dns-updown.sh</span><br><span>new file mode 100644</span>=
<br><span>index 0000000..c469490</span><br><span>--- /dev/null</span><br><s=
pan>+++ b/distro/dns-scripts/resolvconf_file-dns-updown.sh</span><br><span>=
@@ -0,0 +1,84 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/=
bin/sh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# Simple OpenVPN up/down script=
 for modifying /etc/resolv.conf</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# (C) Copyright 2024 OpenVPN Inc &lt;sales@...515...&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# SPDX-License-Identifier: BSD-2-Clause</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# Example env from openvpn (most are not =
applied):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#   dev tun0</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#   script-type dns-up</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#   dns_search_domain_1 mycorp.i=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_search_dom=
ain_2 eu.mycorp.com</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#   dns_server_1_address_1 192.168.99.254</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#   dns_server_1_address_2 fd00::99:53</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_port_1 53</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_port_2 53<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_res=
olve_domain_1 mycorp.in</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#   dns_server_1_resolve_domain_2 eu.mycorp.com</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_dnssec true</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_transport DoH</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_sni =
dns.mycorp.in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+set -e +u</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+only_standard_server_ports() {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    i=3D1</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    while true; do</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        eval addr=3D\&quot;\$dns_server_${n}_address_${i}\&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        [ -n &quot;$addr&=
quot; ] || return 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        eval port=
=3D\&quot;\$dns_server_${n}_port_${i}\&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        [ -z &quot;$port&quot; -o &quot;$port&quot=
; =3D &quot;53&quot; ] || return 1</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    i=3D$(expr $i + 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    done</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+conf=3D/etc/resolv.conf</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test -e &quot;$conf&quot; || exit 1</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+case &quot;${script_type}=
&quot; in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dns-up)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    n=3D1</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    while :; do</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        eval addr=3D\&quot;\$dns_ser=
ver_${n}_address_1\&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        [ -n &quot;$addr&quot; ] || {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            echo &quot;setting DNS failed, no compa=
tible server profile&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            exit 1</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        # Skip server p=
rofiles which require DNSSEC,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        # secure transport or use a custom port</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        eval dnssec=3D\&quot;\$dns_se=
rver_${n}_dnssec\&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        eval transport=3D\&quot;\$dns_server_${n}_transport\&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        [ -z &quot;$tran=
sport&quot; -o &quot;$transport&quot; =3D &quot;plain&quot; ] \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; [ -z &qu=
ot;$dnssec&quot; -o &quot;$dnssec&quot; =3D &quot;no&quot; ] \</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; only_stan=
dard_server_ports &amp;&amp; break</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    n=3D$(expr $n + 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    done</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    eval addr1=3D\&quot;\$d=
ns_server_${n}_address_1\&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    eval addr2=3D\&quot;\$dns_server_${n}_address_2\&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    eval addr3=3D\&quot;=
\$dns_server_${n}_address_3\&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    text=3D&quot;### openvpn ${dev} begin ###\n&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    text=3D&quot;${text}na=
meserver $addr1\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    test -z &quot;$addr2&quot; || text=3D&quot;${text}nameserver $addr2=
\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    test -z=
 &quot;$addr3&quot; || text=3D&quot;${text}nameserver $addr3\n&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    test -z &quot;$dns_search_domain_1&quot; =
|| {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for i i=
n $(seq 1 6); do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         eval domains=3D\&quot;$domains\$dns_search_domain_${i} \&quot; || =
break</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        done</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        text=3D&quot;=
${text}search $domains\n&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 text=3D&quot;${text}### openvpn ${dev} end ###&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    sed -i &quot;1i${text}&quot; &quot;$conf&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    ;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+dns-down)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    sed -i &quot;/### openvpn ${dev} begin ###/,/##=
# openvpn ${dev} end ###/d&quot; &quot;$conf&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+esac</span><br><span>diff --git a/distro/dns-scripts/syst=
emd-dns-updown.sh b/distro/dns-scripts/systemd-dns-updown.sh</span><br><spa=
n>new file mode 100644</span><br><span>index 0000000..69bbebf</span><br><sp=
an>--- /dev/null</span><br><span>+++ b/distro/dns-scripts/systemd-dns-updow=
n.sh</span><br><span>@@ -0,0 +1,194 @@</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#!/bin/bash</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# dns-u=
pdown - add/remove openvpn provided DNS information</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# Copyright (C) 2024 OpenVPN Inc &lt;sales@...515...&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+# SPDX-License-Identifier: GPL-2.0</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# Add/remove openvpn DNS settings from th=
e env into/from</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# th=
e system. Supported backends in this order:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#   * systemd-resolved</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#   * resolvconf</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Example en=
v from openvpn (not all are always applied):</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#   dev tun0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#   script-type dns-up</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#   dns_search_domain_1 mycorp.in</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#   dns_search_domain_2 eu.mycorp.com</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_address_1 192.168.99.25=
4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_a=
ddress_2 fd00::99:53</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#   dns_server_1_port_1 53</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#   dns_server_1_port_2 53</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#   dns_server_1_resolve_domain_1 mycorp.in</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_resolve_domain_2 eu=
.mycorp.com</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_=
server_1_dnssec true</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#   dns_server_1_transport DoH</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#   dns_server_1_sni dns.mycorp.in</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+function d=
o_resolved_servers {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    local sni=3D&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    local transport_var=3Ddns_server_${n}_transport</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    local sni_var=3Ddns_server_${=
n}_sni</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    [ &quot;$=
{!transport_var}&quot; =3D &quot;DoT&quot; ] &amp;&amp; sni=3D&quot;#${!sni=
_var}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    local i=3D1</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    local addrs=3D&quot;&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while :; do</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        local addr_var=
=3Ddns_server_${n}_address_${i}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        local addr=3D&quot;${!addr_var}&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        [ -n &quot;$addr&quot; ] || b=
reak</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        local port_var=3Ddns_serve=
r_${n}_port_${i}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if [ -n &quot;${!port_var}&quot; ]; then</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            if [[ &quot;$addr&quot; =3D~ : ]]; th=
en</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                a=
ddr=3D&quot;[$addr]&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            addrs+=3D&quot;${addr}:${!port_var}${sni} &quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            addrs+=3D&quot;${addr}${sni}=
 &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fi</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=3D$((i+1))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    done</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    resolvectl dns &quot;$dev&quot; $addrs</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+function do_resolved_domains {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    local list=3D&quot;&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for domain_var in ${!dns_search_domai=
n_*}; do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        lis=
t+=3D&quot;${!domain_var} &quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    done</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    local domain_var=3Ddns_server_${n}_resolve_domain_1</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if [ -z &quot;${!domain_var}&quot=
; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
solvectl default-route &quot;$dev&quot; true</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        list+=3D&quot;~.&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        resolvectl default-route &quot;$dev&quot; =
false</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        local =
i=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        while =
:; do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            do=
main_var=3Ddns_server_${n}_resolve_domain_${i}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            [ -n &quot;${!domain_var}&quot; ] ||=
 break</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            #=
 Add as split domain (~ prefix), if it doesn&#39;t already exist</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            [[ &quot;$list&quo=
t; =3D~ (^| )&quot;${!domain_var}&quot;( |$) ]] \</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                || list+=3D&quot;~${!domain_v=
ar} &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   i=3D$((i+1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    done</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    resolvectl domain &quot;$dev&quot; $l=
ist</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+function do_resolved_dnssec {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    local dnssec_var=3Ddns_server_${n}_dn=
ssec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ &quot;=
${!dnssec_var}&quot; =3D &quot;optional&quot; ]; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        resolvectl dnssec &quot;$dev&quot=
; allow-downgrade</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  elif [ &quot;${!dnssec_var}&quot; =3D &quot;yes&quot; ]; then</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        resolvectl dnssec &quot=
;$dev&quot; true</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        resolv=
ectl dnssec &quot;$dev&quot; false</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    fi</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+function do_resolved_dnsovertls {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    local transport_v=
ar=3Ddns_server_${n}_transport</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if [ &quot;${!transport_var}&quot; =3D &quot;DoT&quot; ]; th=
en</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        resolvect=
l dnsovertls &quot;$dev&quot; true</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        resolvectl dnsovertls &quot;$dev&quot; false</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+function do_r=
esolved {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    [[ &qu=
ot;$(readlink /etc/resolv.conf)&quot; =3D~ systemd ]] || return 1</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    n=3D1</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    while :; do</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        local addr_var=3Ddns_server_${n}_address_1</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        [ -n &quot;${!addr_var}=
&quot; ] || {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      echo &quot;setting DNS failed, no compatible server profile&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            return 1</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        # Skip server profiles which require DNS-ov=
er-HTTPS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        loc=
al transport_var=3Ddns_server_${n}_transport</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        [ -n &quot;${!transport_var}&quot; -a &quo=
t;${!transport_var}&quot; =3D &quot;DoH&quot; ] || break</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        n=3D$((n+1))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    done</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ &q=
uot;$script_type&quot; =3D &quot;dns-up&quot; ]; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        echo &quot;setting DNS using reso=
lvectl&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 do_resolved_servers</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        do_resolved_domains</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        do_resolved_dnssec</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        do_resolved_dnsovertls</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        echo &quot;unsetting DNS using resolvectl&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        resolvectl reve=
rt &quot;$dev&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return 0</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+f=
unction only_standard_server_ports {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    local i=3D1</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    while :; do</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        local addr_var=3Ddns_server_${n}_address_${i}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        [ -n &quot;${!addr_var}&=
quot; ] || return 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        local port_=
var=3Ddns_server_${n}_port_${i}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        [ -z &quot;${!port_var}&quot; -o &quot;${!port_var}&quo=
t; =3D &quot;53&quot; ] || return 1</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     i=3D$((i+1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  done</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+function do_resolvconf {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    [ -x /sbin/resolvconf ] || return 1</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    n=3D1</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    while :; do</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        local server_addr_var=3Ddns_server_${n}_address_1<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        [ -n &quot;$=
{!server_addr_var}&quot; ] || {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            echo &quot;setting DNS failed, no compatible server=
 profile&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       return 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        # Skip server profiles wh=
ich require DNSSEC,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        # secure transport or use a custom port</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        local dnssec_var=3Ddns_server_${n}_dnss=
ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        local tra=
nsport_var=3Ddns_server_${n}_transport</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        [ -z &quot;${!transport_var}&quot; -o &quot;${!t=
ransport_var}&quot; =3D &quot;plain&quot; ] \</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            &amp;&amp; [ -z &quot;${!dnssec_var}&=
quot; -o &quot;${!dnssec_var}&quot; =3D &quot;no&quot; ] \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; only_standard=
_server_ports &amp;&amp; break</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
n=3D$((n+1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    don=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if [ &quot;$script_type&quot; =3D=
 &quot;dns-up&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        echo &quot;setting DNS using resolvconf&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        local domains=3D&quot;&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for doma=
in_var in ${!dns_search_domain_*}; do</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            domains+=3D&quot;${!domain_var} &quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        done</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            local maxns=3D3</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            for addr_var in ${!dn=
s_server_1_address_*}; do</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                [ $((maxns--)) -gt 0 ] || break</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                echo &quot;nameserver ${!=
addr_var}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        done</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     [ -z &quot;$domains&quot; ] || echo &quot;search $domains&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        } | /sbin/resolvco=
nf -a &quot;$dev&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
echo &quot;unsetting DNS using resolvconf&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        /sbin/resolvconf -d &quot;$dev&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return 0</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+do_resolved || do_resol=
vconf</span><br><span>diff --git a/doc/man-sections/script-options.rst b/do=
c/man-sections/script-options.rst</span><br><span>index 0d1f9ae..a671117 10=
0644</span><br><span>--- a/doc/man-sections/script-options.rst</span><br><s=
pan>+++ b/doc/man-sections/script-options.rst</span><br><span>@@ -8,9 +8,13=
 @@</span><br><span> Script Order of Execution</span><br><span> -----------=
--------------</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#. ``--dns-script``</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   Exe=
cuted after TCP/UDP socket bind and TUN/TAP open, before ``--up``.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #. ``--up`=
`</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
 Executed after TCP/UDP socket bind and TUN/TAP open.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+   Executed after TCP/UDP socket bind and=
 TUN/TAP open, after ``--dns-script``.</span><br><span> </span><br><span> #=
. ``--tls-verify``</span><br><span> </span><br><span>@@ -38,9 +42,13 @@</sp=
an><br><span> </span><br><span>    Executed in ``--mode server`` mode on cl=
ient instance shutdown.</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#. ``--dns-script``</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+   Executed before TCP/UDP and TUN/TAP close, before ``--down``.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #. ``--do=
wn``</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-   Executed after TCP/UDP and TUN/TAP close.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+   Executed after TCP/UDP and TUN/TAP close, afte=
r ``--dns-script``.</span><br><span> </span><br><span> #. ``--learn-address=
``</span><br><span> </span><br><span>@@ -173,7 +181,7 @@</span><br><span>  =
       client-crresponse cmd</span><br><span> </span><br><span>   OpenVPN w=
ill write the response of the client into a temporary file.</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  The filename will be passed as an a=
rgument to ``cmd``, and the file will be</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  The filename will be passed as an argument to ``cmd`=
`, and the file will</span><br><span>   automatically deleted by OpenVPN af=
ter the script returns.</span><br><span> </span><br><span>   The response i=
s passed as is from the client. The script needs to check</span><br><span>@=
@ -235,6 +243,23 @@</span><br><span>   The ``--client-disconnect`` command =
is not passed any extra arguments</span><br><span>   (only those arguments =
specified in cmd, if any).</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+--dns-script cmd | disable</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  Run command ``cmd``, instead of the def=
ault DNS command that comes with</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  openvpn. If ``cmd`` is ``disable`` no command is executed to=
 set ``--dns``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  opt=
ions. If you write your own command, please make sure to ignore ``--dns``</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  server profiles tha=
t cannot be applied. Port, DNSSEC and secure transport</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  settings need to be adhered to. If spl=
it DNS is not possible a full redirect</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  can be used as a fallback. If not all of the server ad=
dresses or search domains</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  can be configured, apply them on the order they are listed in.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  Note that ``--dns-script`` is not suppo=
rted on Windows. DNS will</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  always be set by the service there.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  Note that DNS-related ``--dhcp-option``s will not be handled by this=
 hook.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  If any ``--=
dns server`` option is present, DNS-related ``--dhcp-option``s will</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  be ignored. Otherwise for=
eign_option environment variables will be passed to</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  ``--up`` and ``--down`` hooks for backw=
ard compatibility.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> --down cmd</span><br><span>   Run command ``cmd`` after TU=
N/TAP device close (post ``--user`` UID</span><br><span>   change and/or ``=
--chroot`` ). ``cmd`` consists of a path to script (or</span><br><span>@@ -=
661,7 +686,7 @@</span><br><span>     names). Set prior to ``--up`` or ``--d=
own`` script execution.</span><br><span> </span><br><span> :code:`dns_*`</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    The ``--dns`` config=
uration options will be made available to script</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    The ``--dns`` configuration options will b=
e made available to ``--dns-script``</span><br><span>     execution through=
 this set of environment variables. Variables appear</span><br><span>     o=
nly if the corresponding option has a value assigned. For the semantics</sp=
an><br><span>     of each individual variable, please refer to the document=
ation for ``--dns``.</span><br><span>diff --git a/src/openvpn/Makefile.am b=
/src/openvpn/Makefile.am</span><br><span>index 37af683..6664aae 100644</spa=
n><br><span>--- a/src/openvpn/Makefile.am</span><br><span>+++ b/src/openvpn=
/Makefile.am</span><br><span>@@ -30,7 +30,8 @@</span><br><span> 	$(OPTIONAL=
_LZ4_CFLAGS) \</span><br><span> 	$(OPTIONAL_PKCS11_HELPER_CFLAGS) \</span><=
br><span> 	$(OPTIONAL_INOTIFY_CFLAGS) \</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-	-DPLUGIN_LIBDIR=3D\&quot;${plugindir}\&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	-DPLUGIN_LIBDIR=3D\&quot;${plu=
gindir}\&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-D=
DNS_UPDOWN_PATH=3D\&quot;${scriptdir}/dns-updown\&quot;</span><br><span> </=
span><br><span> if WIN32</span><br><span> # we want unicode entry point but=
 not the macro</span><br><span>diff --git a/src/openvpn/dns.c b/src/openvpn=
/dns.c</span><br><span>index b6e524f..6a4669f 100644</span><br><span>--- a/=
src/openvpn/dns.c</span><br><span>+++ b/src/openvpn/dns.c</span><br><span>@=
@ -30,6 +30,7 @@</span><br><span> #include &quot;dns.h&quot;</span><br><spa=
n> #include &quot;socket.h&quot;</span><br><span> #include &quot;options.h&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot=
;run_command.h&quot;</span><br><span> </span><br><span> #ifdef _WIN32</span=
><br><span> #include &quot;win32.h&quot;</span><br><span>@@ -262,6 +263,8 @=
@</span><br><span>     clone.search_domains =3D clone_dns_domains(o-&gt;sea=
rch_domains, gc);</span><br><span>     clone.servers =3D clone_dns_servers(=
o-&gt;servers, gc);</span><br><span>     clone.servers_prepull =3D clone_dn=
s_servers(o-&gt;servers_prepull, gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    clone.script =3D o-&gt;script;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    clone.user_defined_script =3D o-&gt;u=
ser_defined_script;</span><br><span> </span><br><span>     return clone;</s=
pan><br><span> }</span><br><span>@@ -548,6 +551,54 @@</span><br><span>     =
send_msg_iservice(o-&gt;msg_channel, &amp;nrpt, sizeof(nrpt), &amp;ack, &qu=
ot;DNS&quot;);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#else /* ifdef _WIN32 */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+script_env_set(bool up, const struct dns_options *o, const stru=
ct tuntap *tt, struct env_set *es)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 setenv_str(es, &quot;dev&quot;, tt-&gt;actual_name);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    setenv_str(es, &quot;script_type&quot=
;, up ? &quot;dns-up&quot; : &quot;dns-down&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    setenv_dns_options(o, es);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+d=
o_run_up_down_script(bool up, const struct dns_options *o, const struct tun=
tap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc=
_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct a=
rgv argv =3D argv_new();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct env_set *es =3D env_set_create(&amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    script_env_set(up, o, tt, es);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    argv_printf(&amp;argv, &quot;%s&quot;, o-&gt;script);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_msg(M_INFO, &=
amp;argv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int r=
es;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;us=
er_defined_script)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        res =3D=
 openvpn_run_script(&amp;argv, es, S_EXITCODE, &quot;dns script&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        res =3D openvpn_execve_check(&amp;argv, es, S_EXITCODE=
, &quot;WARNING: Failed running dns script&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    argv_free(&amp;argv);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return res;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+run_up_down_script(bool =
up, struct options *o, const struct tuntap *tt)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (!o-&gt;dns_options.script)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    int status;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    status =3D do_run_up_down_=
script(up, &amp;o-&gt;dns_options, tt);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    msg(M_INFO, &quot;dns script exited with status %d&=
quot;, status);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #end=
if /* _WIN32 */</span><br><span> </span><br><span> void</span><br><span>@@ =
-666,5 +717,7 @@</span><br><span> </span><br><span> #ifdef _WIN32</span><br=
><span>     run_up_down_service(up, o, tt);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    run_up_down_script(up, o, tt);</span><br><span> #endif /* ifd=
ef _WIN32 */</span><br><span> }</span><br><span>diff --git a/src/openvpn/dn=
s.h b/src/openvpn/dns.h</span><br><span>index f24e30b..38ced79 100644</span=
><br><span>--- a/src/openvpn/dns.h</span><br><span>+++ b/src/openvpn/dns.h<=
/span><br><span>@@ -73,6 +73,8 @@</span><br><span>     struct dns_server *s=
ervers_prepull;</span><br><span>     struct dns_server *servers;</span><br>=
<span>     struct gc_arena gc;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const char *script;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    bool user_defined_script;</span><br><span> };</span><br>=
<span> </span><br><span> /**</span><br><span>diff --git a/src/openvpn/optio=
ns.c b/src/openvpn/options.c</span><br><span>index 11a19bb..48fefb2 100644<=
/span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openv=
pn/options.c</span><br><span>@@ -528,6 +528,7 @@</span><br><span>     &quot=
;                  sni &lt;domain&gt; : DNS server name indication\n&quot;<=
/span><br><span>     &quot;--dns search-domains &lt;domain&gt; [domain ...]=
:\n&quot;</span><br><span>     &quot;                  Add domains to DNS d=
omain search list\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    &quot;--dns-script cmd : Run cmd as user defined dns configuratio=
n script\n&quot;</span><br><span>     &quot;--auth-retry t  : How to handle=
 auth failures.  Set t to\n&quot;</span><br><span>     &quot;              =
    none (default), interact, or nointeract.\n&quot;</span><br><span>     &=
quot;--static-challenge t e [&lt;scrv1|concat&gt;]: Enable static challenge=
/response protocol using\n&quot;</span><br><span>@@ -919,6 +920,8 @@</span>=
<br><span> #ifndef ENABLE_DCO</span><br><span>     o-&gt;disable_dco =3D tr=
ue;</span><br><span> #endif /* ENABLE_DCO */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    o-&gt;dns_options.script =3D DNS_UPDOWN_PATH;</span><br><span> }<=
/span><br><span> </span><br><span> void</span><br><span>@@ -8194,6 +8197,28=
 @@</span><br><span>         to-&gt;ip_win32_defined =3D true;</span><br><s=
pan>     }</span><br><span> #endif /* ifdef _WIN32 */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;dns-script=
&quot;) &amp;&amp; p[1])</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        V=
ERIFY_PERMISSION(OPT_P_SCRIPT);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (!no_more_than_n_args(msglevel, p, 2, NM_QUOTE_HINT)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            goto err;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (streq(p[1], &quot;disabl=
e&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            options-=
&gt;dns_options.script =3D NULL;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if=
 (options-&gt;dns_options.user_defined_script =3D=3D false)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                /* Unset the default scri=
pt to prevent warnings */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                options-&gt;dns_options.script =3D NULL;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            set_user_script(options, &=
amp;options-&gt;dns_options.script, p[1], p[0], false);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            options-&gt;dns_options.use=
r_defined_script =3D true;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span>     else if (streq(p[0], &quot;dns&quot;) &amp;&amp; p[=
1])</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P=
_DHCPDNS);</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail">change 838</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/838?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifbe4ffb44d3bfcaa50adb38cacb=
3436fcdc71b10 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 838 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--I2JodpDsQIo=--

