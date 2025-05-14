From: Gert Doering <gert@...1296...>
Date: Wed, 14 May 2025 15:53:27 +0200
Message-ID: <20250514135334.14377-1-gert@...1296...>
In-Reply-To: <gerrit.1733989644000.Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10@...2715...>
References: <gerrit.1733989644000.Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v25] dns: apply settings via script on
 unixoid systems
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

From: Heiko Hund <heiko@...2662...>

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
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/838
This mail reflects revision 25 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
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
index ae818c3..40bffd4 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -41,7 +41,10 @@
 option(USE_WERROR "Treat compiler warnings as errors (-Werror)" ON)
 option(FAKE_ANDROID "Target Android but do not use actual cross compile/Android cmake to build for simple compile checks on Linux")
 
-set(PLUGIN_DIR /usr/local/lib/openvpn/plugins CACHE FILEPATH "Location of the plugin directory")
+option(ENABLE_DNS_UPDOWN_BY_DEFAULT "Run --dns-updown hook by default" ON)
+set(DNS_UPDOWN_PATH "${CMAKE_INSTALL_PREFIX}/libexec/openvpn/dns-updown" CACHE STRING "Default location for the DNS up/down script")
+
+set(PLUGIN_DIR "${CMAKE_INSTALL_PREFIX}/lib/openvpn/plugins" CACHE FILEPATH "Location of the plugin directory")
 
 # Create machine readable compile commands
 option(ENABLE_COMPILE_COMMANDS "Generate compile_commands.json and a symlink for clangd to find it" OFF)
@@ -601,6 +604,8 @@
 
 add_library_deps(openvpn)
 
+target_compile_options(openvpn PRIVATE -DDEFAULT_DNS_UPDOWN=\"${DNS_UPDOWN_PATH}\")
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
+	[AS_HELP_STRING([--disable-dns-updown-by-default], [disable running --dns-updown by default @<:@default=yes@:>@])],
+	,
+	[enable_dns_updown_by_default="yes"]
+)
+
+AC_ARG_ENABLE(
 	[ntlm],
 	[AS_HELP_STRING([--disable-ntlm], [disable NTLMv2 proxy support @<:@default=yes@:>@])],
 	,
@@ -315,37 +322,50 @@
 	plugindir="\${libdir}/openvpn/plugins"
 fi
 
+AC_ARG_VAR([SCRIPTDIR], [Path of script directory @<:@default=PKGLIBEXECDIR@:>@])
+if test -n "${SCRIPTDIR}"; then
+	scriptdir="${SCRIPTDIR}"
+else
+	scriptdir="\${pkglibexecdir}"
+fi
+
 AC_DEFINE_UNQUOTED([TARGET_ALIAS], ["${host}"], [A string representing our host])
-AM_CONDITIONAL([TARGET_LINUX], [false])
+AM_CONDITIONAL([ENABLE_DNS_UPDOWN],[true])
 case "$host" in
 	*-*-linux*)
 		AC_DEFINE([TARGET_LINUX], [1], [Are we running on Linux?])
-		AM_CONDITIONAL([TARGET_LINUX], [true])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["L"], [Target prefix])
+		AC_SUBST([DNS_UPDOWN_TYPE], ["systemd"])
 		have_sitnl="yes"
 		pkg_config_required="yes"
 		;;
 	*-*-solaris*)
 		AC_DEFINE([TARGET_SOLARIS], [1], [Are we running on Solaris?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["S"], [Target prefix])
+		AC_SUBST([DNS_UPDOWN_TYPE], ["resolvconf_file"])
 		CPPFLAGS="$CPPFLAGS -D_XPG4_2"
 		test -x /bin/bash && SHELL="/bin/bash"
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
 		have_tap_header="yes"
 		ac_cv_type_struct_in_pktinfo=no
 		;;
@@ -353,6 +373,8 @@
 		AC_DEFINE([TARGET_WIN32], [1], [Are we running WIN32?])
 		AC_DEFINE([ENABLE_DCO], [1], [DCO is always enabled on Windows])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["W"], [Target prefix])
+		AM_CONDITIONAL([ENABLE_DNS_UPDOWN], [false])
+		AC_SUBST([DNS_UPDOWN_TYPE], ["windows"])
 		CPPFLAGS="${CPPFLAGS} -DWIN32_LEAN_AND_MEAN"
 		CPPFLAGS="${CPPFLAGS} -DNTDDI_VERSION=NTDDI_VISTA -D_WIN32_WINNT=_WIN32_WINNT_VISTA"
 		WIN32=yes
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
 		ROUTE="/usr/sbin/route"
 		have_tap_header="yes"
 		ac_cv_header_net_if_h="no"	# exists, but breaks things
@@ -371,10 +395,12 @@
 	*-*-haiku*)
 		AC_DEFINE([TARGET_HAIKU], [1], [Are we running Haiku?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["H"], [Target prefix])
+		AC_SUBST([DNS_UPDOWN_TYPE], ["haikuos_file"])
 		LIBS="${LIBS} -lnetwork"
 		;;
 	*)
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["X"], [Target prefix])
+		AC_SUBST([DNS_UPDOWN_TYPE], ["resolvconf_file"])
 		have_tap_header="yes"
 		;;
 esac
@@ -1317,7 +1343,7 @@
 test "${enable_small}" = "yes" && AC_DEFINE([ENABLE_SMALL], [1], [Enable smaller executable size])
 test "${enable_fragment}" = "yes" && AC_DEFINE([ENABLE_FRAGMENT], [1], [Enable internal fragmentation support])
 test "${enable_port_share}" = "yes" && AC_DEFINE([ENABLE_PORT_SHARE], [1], [Enable TCP Server port sharing])
-
+test "${enable_dns_updown_by_default}" = "yes" && AC_DEFINE([ENABLE_DNS_UPDOWN_BY_DEFAULT], [1], [Enable dns-updown hook by default])
 test "${enable_ntlm}" = "yes" && AC_DEFINE([ENABLE_NTLM], [1], [Enable NTLMv2 proxy support])
 test "${enable_crypto_ofb_cfb}" = "yes" && AC_DEFINE([ENABLE_OFB_CFB_MODE], [1], [Enable OFB and CFB cipher modes])
 if test "${have_export_keying_material}" = "yes"; then
@@ -1505,6 +1531,7 @@
 
 sampledir="\$(docdir)/sample"
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
 
 SUBDIRS = systemd
+
+if ENABLE_DNS_UPDOWN
+SUBDIRS += dns-scripts
+endif
diff --git a/distro/dns-scripts/Makefile.am b/distro/dns-scripts/Makefile.am
new file mode 100644
index 0000000..fc2db08
--- /dev/null
+++ b/distro/dns-scripts/Makefile.am
@@ -0,0 +1,29 @@
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
+MAINTAINERCLEANFILES = \
+	$(srcdir)/Makefile.in
+
+EXTRA_DIST = \
+	systemd-dns-updown.sh \
+	openresolv-dns-updown.sh \
+	haikuos_file-dns-updown.sh \
+	resolvconf_file-dns-updown.sh
+
+script_SCRIPTS = \
+	dns-updown
+
+CLEANFILES = $(script_SCRIPTS)
+
+dns-updown: @DNS_UPDOWN_TYPE@...2841...
+	cp ${srcdir}/@DNS_UPDOWN_TYPE@...2841... $@
+	chmod +x $@
+
+all: $(script_SCRIPTS)
diff --git a/distro/dns-scripts/haikuos_file-dns-updown.sh b/distro/dns-scripts/haikuos_file-dns-updown.sh
new file mode 100644
index 0000000..748804e
--- /dev/null
+++ b/distro/dns-scripts/haikuos_file-dns-updown.sh
@@ -0,0 +1,85 @@
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
+#   script_type dns-up
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
+    i=1
+    while true; do
+        eval addr=\"\$dns_server_${n}_address_${i}\"
+        [ -n "$addr" ] || return 0
+
+        eval port=\"\$dns_server_${n}_port_${i}\"
+        [ -z "$port" -o "$port" = "53" ] || return 1
+
+        i=$(expr $i + 1)
+    done
+}
+
+onf=/boot/system/settings/network/resolv.conf
+test -e "$conf" || exit 1
+case "${script_type}" in
+dns-up)
+    n=1
+    while :; do
+        eval addr=\"\$dns_server_${n}_address_1\"
+        [ -n "$addr" ] || {
+            echo "setting DNS failed, no compatible server profile"
+            exit 1
+        }
+
+        # Skip server profiles which require DNSSEC,
+        # secure transport or use a custom port
+        eval dnssec=\"\$dns_server_${n}_dnssec\"
+        eval transport=\"\$dns_server_${n}_transport\"
+        [ -z "$transport" -o "$transport" = "plain" ] \
+            && [ -z "$dnssec" -o "$dnssec" = "no" ] \
+            && only_standard_server_ports && break
+
+        n=$(expr $n + 1)
+    done
+
+    eval addr1=\"\$dns_server_${n}_address_1\"
+    eval addr2=\"\$dns_server_${n}_address_2\"
+    eval addr3=\"\$dns_server_${n}_address_3\"
+    text="### openvpn ${dev} begin ###\n"
+    text="${text}nameserver $addr1\n"
+    test -z "$addr2" || text="${text}nameserver $addr2\n"
+    test -z "$addr3" || text="${text}nameserver $addr3\n"
+
+    test -z "$dns_search_domain_1" || {
+        for i in $(seq 1 6); do
+            eval domains=\"$domains\$dns_search_domain_${i} \" || break
+        done
+        text="${text}search $domains\n"
+    }
+    text="${text}### openvpn ${dev} end ###"
+    text="${text}\n$(cat ${conf})"
+
+    echo "${text}" > "${conf}"
+    ;;
+dns-down)
+    sed -i'' -e "/### openvpn ${dev} begin ###/,/### openvpn ${dev} end ###/d" "$conf"
+    ;;
+esac
diff --git a/distro/dns-scripts/openresolv-dns-updown.sh b/distro/dns-scripts/openresolv-dns-updown.sh
new file mode 100644
index 0000000..e50398c
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
+#   script_type dns-up
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
+    i=1
+    while true; do
+        eval addr=\"\$dns_server_${n}_address_${i}\"
+        [ -n "$addr" ] || return 0
+
+        eval port=\"\$dns_server_${n}_port_${i}\"
+        [ -z "$port" -o "$port" = "53" ] || return 1
+
+        i=$(expr $i + 1)
+    done
+}
+
+: ${script_type:=dns-down}
+case "${script_type}" in
+dns-up)
+    n=1
+    while :; do
+        eval addr=\"\$dns_server_${n}_address_1\"
+        [ -n "$addr" ] || {
+            echo "setting DNS failed, no compatible server profile"
+            exit 1
+        }
+
+        # Skip server profiles which require DNSSEC,
+        # secure transport or use a custom port
+        eval dnssec=\"\$dns_server_${n}_dnssec\"
+        eval transport=\"\$dns_server_${n}_transport\"
+        [ -z "$transport" -o "$transport" = "plain" ] \
+            && [ -z "$dnssec" -o "$dnssec" = "no" ] \
+            && only_standard_server_ports && break
+
+        n=$(expr $n + 1)
+    done
+
+    {
+        i=1
+        maxns=3
+        while :; do
+            maxns=$((maxns - 1))
+            [ $maxns -gt 0 ] || break
+            eval option=\"\$dns_server_${n}_address_${i}\" || break
+            [ "${option}" ] || break
+            i=$((i + 1))
+            echo "nameserver ${option}"
+        done
+        i=1
+        maxdom=6
+        while :; do
+            maxdom=$((maxdom - 1))
+            [ $maxdom -gt 0 ] || break
+            eval option=\"\$dns_search_domain_${i}\" || break
+            [ "${option}" ] || break
+            i=$((i + 1))
+            echo "search ${option}"
+        done
+    } | /sbin/resolvconf -a "${dev}"
+    ;;
+dns-down)
+    /sbin/resolvconf -d "${dev}" -f
+    ;;
+esac
diff --git a/distro/dns-scripts/resolvconf_file-dns-updown.sh b/distro/dns-scripts/resolvconf_file-dns-updown.sh
new file mode 100644
index 0000000..567b402
--- /dev/null
+++ b/distro/dns-scripts/resolvconf_file-dns-updown.sh
@@ -0,0 +1,85 @@
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
+#   script_type dns-up
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
+    i=1
+    while true; do
+        eval addr=\"\$dns_server_${n}_address_${i}\"
+        [ -n "$addr" ] || return 0
+
+        eval port=\"\$dns_server_${n}_port_${i}\"
+        [ -z "$port" -o "$port" = "53" ] || return 1
+
+        i=$(expr $i + 1)
+    done
+}
+
+conf=/etc/resolv.conf
+test -e "$conf" || exit 1
+case "${script_type}" in
+dns-up)
+    n=1
+    while :; do
+        eval addr=\"\$dns_server_${n}_address_1\"
+        [ -n "$addr" ] || {
+            echo "setting DNS failed, no compatible server profile"
+            exit 1
+        }
+
+        # Skip server profiles which require DNSSEC,
+        # secure transport or use a custom port
+        eval dnssec=\"\$dns_server_${n}_dnssec\"
+        eval transport=\"\$dns_server_${n}_transport\"
+        [ -z "$transport" -o "$transport" = "plain" ] \
+            && [ -z "$dnssec" -o "$dnssec" = "no" ] \
+            && only_standard_server_ports && break
+
+        n=$(expr $n + 1)
+    done
+
+    eval addr1=\"\$dns_server_${n}_address_1\"
+    eval addr2=\"\$dns_server_${n}_address_2\"
+    eval addr3=\"\$dns_server_${n}_address_3\"
+    text="### openvpn ${dev} begin ###\n"
+    text="${text}nameserver $addr1\n"
+    test -z "$addr2" || text="${text}nameserver $addr2\n"
+    test -z "$addr3" || text="${text}nameserver $addr3\n"
+
+    test -z "$dns_search_domain_1" || {
+        for i in $(seq 1 6); do
+            eval domains=\"$domains\$dns_search_domain_${i} \" || break
+        done
+        text="${text}search $domains\n"
+    }
+    text="${text}### openvpn ${dev} end ###"
+    text="${text}\n$(cat ${conf})"
+
+    echo "${text}" > "${conf}"
+    ;;
+dns-down)
+    sed -i'' -e "/### openvpn ${dev} begin ###/,/### openvpn ${dev} end ###/d" "$conf"
+    ;;
+esac
diff --git a/distro/dns-scripts/systemd-dns-updown.sh b/distro/dns-scripts/systemd-dns-updown.sh
new file mode 100644
index 0000000..ecadd29
--- /dev/null
+++ b/distro/dns-scripts/systemd-dns-updown.sh
@@ -0,0 +1,240 @@
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
+#   * /etc/resolv.conf file
+#
+# Example env from openvpn (not all are always applied):
+#
+#   dev tun0
+#   script_type dns-up
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
+    local sni=""
+    local transport_var=dns_server_${n}_transport
+    local sni_var=dns_server_${n}_sni
+    [ "${!transport_var}" = "DoT" ] && sni="#${!sni_var}"
+
+    local i=1
+    local addrs=""
+    while :; do
+        local addr_var=dns_server_${n}_address_${i}
+        local addr="${!addr_var}"
+        [ -n "$addr" ] || break
+
+        local port_var=dns_server_${n}_port_${i}
+        if [ -n "${!port_var}" ]; then
+            if [[ "$addr" =~ : ]]; then
+                addr="[$addr]"
+            fi
+            addrs+="${addr}:${!port_var}${sni} "
+        else
+            addrs+="${addr}${sni} "
+        fi
+        i=$((i+1))
+    done
+
+    resolvectl dns "$dev" $addrs
+}
+
+function do_resolved_domains {
+    local list=""
+    for domain_var in ${!dns_search_domain_*}; do
+        list+="${!domain_var} "
+    done
+    local domain_var=dns_server_${n}_resolve_domain_1
+    if [ -z "${!domain_var}" ]; then
+        resolvectl default-route "$dev" true
+        list+="~."
+    else
+        resolvectl default-route "$dev" false
+        local i=1
+        while :; do
+            domain_var=dns_server_${n}_resolve_domain_${i}
+            [ -n "${!domain_var}" ] || break
+            # Add as split domain (~ prefix), if it doesn't already exist
+            [[ "$list" =~ (^| )"${!domain_var}"( |$) ]] \
+                || list+="~${!domain_var} "
+            i=$((i+1))
+        done
+    fi
+
+    resolvectl domain "$dev" $list
+}
+
+function do_resolved_dnssec {
+    local dnssec_var=dns_server_${n}_dnssec
+    if [ "${!dnssec_var}" = "optional" ]; then
+        resolvectl dnssec "$dev" allow-downgrade
+    elif [ "${!dnssec_var}" = "yes" ]; then
+        resolvectl dnssec "$dev" true
+    else
+        resolvectl dnssec "$dev" false
+    fi
+}
+
+function do_resolved_dnsovertls {
+    local transport_var=dns_server_${n}_transport
+    if [ "${!transport_var}" = "DoT" ]; then
+        resolvectl dnsovertls "$dev" true
+    else
+        resolvectl dnsovertls "$dev" false
+    fi
+}
+
+function do_resolved {
+    [[ "$(readlink /etc/resolv.conf)" =~ systemd ]] || return 1
+
+    n=1
+    while :; do
+        local addr_var=dns_server_${n}_address_1
+        [ -n "${!addr_var}" ] || {
+            echo "setting DNS failed, no compatible server profile"
+            return 1
+        }
+
+        # Skip server profiles which require DNS-over-HTTPS
+        local transport_var=dns_server_${n}_transport
+        [ -n "${!transport_var}" -a "${!transport_var}" = "DoH" ] || break
+
+        n=$((n+1))
+    done
+
+    if [ "$script_type" = "dns-up" ]; then
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
+    local i=1
+    while :; do
+        local addr_var=dns_server_${n}_address_${i}
+        [ -n "${!addr_var}" ] || return 0
+
+        local port_var=dns_server_${n}_port_${i}
+        [ -z "${!port_var}" -o "${!port_var}" = "53" ] || return 1
+
+        i=$((i+1))
+    done
+}
+
+function resolv_conf_compat_profile {
+    local n=1
+    while :; do
+        local server_addr_var=dns_server_${n}_address_1
+        [ -n "${!server_addr_var}" ] || {
+            echo "setting DNS failed, no compatible server profile"
+            exit 1
+        }
+
+        # Skip server profiles which require DNSSEC,
+        # secure transport or use a custom port
+        local dnssec_var=dns_server_${n}_dnssec
+        local transport_var=dns_server_${n}_transport
+        [ -z "${!transport_var}" -o "${!transport_var}" = "plain" ] \
+            && [ -z "${!dnssec_var}" -o "${!dnssec_var}" = "no" ] \
+            && only_standard_server_ports && break
+
+        n=$((n+1))
+    done
+    return $n
+}
+
+function do_resolvconf {
+    [ -x /sbin/resolvconf ] || return 1
+
+    resolv_conf_compat_profile
+    local n=$?
+
+    if [ "$script_type" = "dns-up" ]; then
+        echo "setting DNS using resolvconf"
+        local domains=""
+        for domain_var in ${!dns_search_domain_*}; do
+            domains+="${!domain_var} "
+        done
+        {
+            local maxns=3
+            local server_var=dns_server_${n}_address_*
+            for addr_var in ${!server_var}; do
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
+function do_resolv_conf_file {
+    conf=/etc/resolv.conf
+    test -e "$conf" || exit 1
+
+    resolv_conf_compat_profile
+    local n=$?
+
+    if [ "$script_type" = "dns-up" ]; then
+        echo "setting DNS using resolv.conf file"
+
+        local addr1_var=dns_server_${n}_address_1
+        local addr2_var=dns_server_${n}_address_2
+        local addr3_var=dns_server_${n}_address_3
+        text="### openvpn ${dev} begin ###\n"
+        text="${text}nameserver ${!addr1_var}\n"
+        test -z "${!addr2_var}" || text="${text}nameserver ${!addr2_var}\n"
+        test -z "${!addr3_var}" || text="${text}nameserver ${!addr3_var}\n"
+
+        test -z "$dns_search_domain_1" || {
+            for i in $(seq 1 6); do
+                eval domains=\"$domains\$dns_search_domain_${i} \" || break
+            done
+            text="${text}search $domains\n"
+        }
+        text="${text}### openvpn ${dev} end ###"
+
+        sed -i "1i${text}" "$conf"
+    else
+        echo "unsetting DNS using resolv.conf file"
+        sed -i "/### openvpn ${dev} begin ###/,/### openvpn ${dev} end ###/d" "$conf"
+    fi
+
+    return 0
+}
+
+do_resolved || do_resolvconf || do_resolv_conf_file || {
+    echo "setting DNS failed, no method succeeded"
+    exit 1
+}
diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
index e48710b..bd5ecd4 100644
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
+   Executed after TCP/UDP socket bind and TUN/TAP open, after ``--dns-updown``.
 
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
 
@@ -171,7 +179,7 @@
         client-crresponse cmd
 
   OpenVPN will write the response of the client into a temporary file.
-  The filename will be passed as an argument to ``cmd``, and the file will be
+  The filename will be passed as an argument to ``cmd``, and the file will
   automatically deleted by OpenVPN after the script returns.
 
   The response is passed as is from the client. The script needs to check
@@ -233,6 +241,31 @@
   The ``--client-disconnect`` command is not passed any extra arguments
   (only those arguments specified in cmd, if any).
 
+--dns-updown cmd
+  Run command ``cmd``, instead of the default DNS up/down command that comes
+  with openvpn. If ``cmd`` is ``disable`` the ``--dns-updown`` command is not run.
+
+  If you write your own command, please make sure to ignore ``--dns``
+  server profiles that cannot be applied. Port, DNSSEC and secure transport
+  settings need to be adhered to. If split DNS is not possible a full redirect
+  can be used as a fallback. If not all of the server addresses or search domains
+  can be configured, apply them in the order they are listed in.
+
+  Note that ``--dns-updown`` is not supported on all platforms. On Windows DNS
+  will always be set by the service. On Android DNS will be passed via management
+  interface.
+
+  Note that DNS-related ``--dhcp-option``\ s might be converted so that they are
+  available to this hook if no ``--dns`` options exist. If any ``--dns server``
+  option is present, DNS-related ``--dhcp-option``\ s will always be ignored.
+  If an ``--up`` script is defined, foreign_option env vars will be generated
+  from ``--dns`` options and passed to the script. The default ``--dns-updown``
+  command is not run if an ``--up`` script is defined. Both is done for backward
+  compatibility. In case you want to run the ``--dns-updown`` command even if
+  there is an ``--up`` defined, you can define a custom command or use ``force``
+  as ``cmd`` to run the default command. No DNS env vars will be passed to ``--up``
+  in this case.
+
 --down cmd
   Run command ``cmd`` after TUN/TAP device close (post ``--user`` UID
   change and/or ``--chroot`` ). ``cmd`` consists of a path to script (or
@@ -659,7 +692,7 @@
     names). Set prior to ``--up`` or ``--down`` script execution.
 
 :code:`dns_*`
-    The ``--dns`` configuration options will be made available to script
+    The ``--dns`` configuration options will be made available to ``--dns-updown``
     execution through this set of environment variables. Variables appear
     only if the corresponding option has a value assigned. For the semantics
     of each individual variable, please refer to the documentation for ``--dns``.
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 37af683..2e93ebb 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -30,7 +30,8 @@
 	$(OPTIONAL_LZ4_CFLAGS) \
 	$(OPTIONAL_PKCS11_HELPER_CFLAGS) \
 	$(OPTIONAL_INOTIFY_CFLAGS) \
-	-DPLUGIN_LIBDIR=\"${plugindir}\"
+	-DPLUGIN_LIBDIR=\"${plugindir}\" \
+	-DDEFAULT_DNS_UPDOWN=\"${scriptdir}/dns-updown\"
 
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
     clone.search_domains = clone_dns_domains(o->search_domains, gc);
     clone.servers = clone_dns_servers(o->servers, gc);
     clone.servers_prepull = clone_dns_servers(o->servers_prepull, gc);
+    clone.updown = o->updown;
+    clone.user_set_updown = o->user_set_updown;
 
     return clone;
 }
@@ -548,6 +551,54 @@
     send_msg_iservice(o->msg_channel, &nrpt, sizeof(nrpt), &ack, "DNS");
 }
 
+#else /* ifdef _WIN32 */
+
+static void
+updown_env_set(bool up, const struct dns_options *o, const struct tuntap *tt, struct env_set *es)
+{
+    setenv_str(es, "dev", tt->actual_name);
+    setenv_str(es, "script_type", up ? "dns-up" : "dns-down");
+    setenv_dns_options(o, es);
+}
+
+static int
+do_run_up_down_command(bool up, const struct dns_options *o, const struct tuntap *tt)
+{
+    struct gc_arena gc = gc_new();
+    struct argv argv = argv_new();
+    struct env_set *es = env_set_create(&gc);
+
+    updown_env_set(up, o, tt, es);
+
+    argv_printf(&argv, "%s", o->updown);
+    argv_msg(M_INFO, &argv);
+    int res;
+    if (o->user_set_updown)
+    {
+        res = openvpn_run_script(&argv, es, S_EXITCODE, "dns updown");
+    }
+    else
+    {
+        res = openvpn_execve_check(&argv, es, S_EXITCODE, "WARNING: Failed running dns updown");
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
+    status = do_run_up_down_command(up, &o->dns_options, tt);
+    msg(M_INFO, "dns %s command exited with status %d", up ? "up" : "down", status);
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
index 02970a7..1d1daea 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -526,10 +526,12 @@
     "                  address <addr[:port]> [addr[:port] ...] : server addresses 4/6\n"
     "                  resolve-domains <domain> [domain ...] : split domains\n"
     "                  dnssec <yes|no|optional> : option to use DNSSEC\n"
-    "                  type <DoH|DoT> : query server over HTTPS / TLS\n"
+    "                  transport <DoH|DoT> : query server over HTTPS / TLS\n"
     "                  sni <domain> : DNS server name indication\n"
     "--dns search-domains <domain> [domain ...]:\n"
     "                  Add domains to DNS domain search list\n"
+    "--dns-updown cmd|force|disable : Run cmd as user defined dns config command,\n"
+    "                  force running the default script or disable running it.\n"
     "--auth-retry t  : How to handle auth failures.  Set t to\n"
     "                  none (default), interact, or nointeract.\n"
     "--static-challenge t e [<scrv1|concat>]: Enable static challenge/response protocol using\n"
@@ -922,6 +924,10 @@
 #ifndef ENABLE_DCO
     o->disable_dco = true;
 #endif /* ENABLE_DCO */
+
+#ifdef ENABLE_DNS_UPDOWN_BY_DEFAULT
+    o->dns_options.updown = DEFAULT_DNS_UPDOWN;
+#endif /* ENABLE_DNS_UPDOWN_BY_DEFAULT */
 }
 
 void
@@ -8088,6 +8094,39 @@
         to->ip_win32_defined = true;
     }
 #endif /* ifdef _WIN32 */
+    else if (streq(p[0], "dns-updown") && p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_SCRIPT);
+        if (!no_more_than_n_args(msglevel, p, 2, NM_QUOTE_HINT))
+        {
+            goto err;
+        }
+        struct dns_options *dns = &options->dns_options;
+        if (streq(p[1], "disable"))
+        {
+            dns->updown = NULL;
+            dns->user_set_updown = false;
+        }
+        else if (streq(p[1], "force"))
+        {
+            /* force dns-updown run, even if a --up script is defined */
+            if (dns->user_set_updown == false)
+            {
+                dns->updown = DEFAULT_DNS_UPDOWN;
+                dns->user_set_updown = true;
+            }
+        }
+        else
+        {
+            if (streq(dns->updown, DEFAULT_DNS_UPDOWN))
+            {
+                /* Unset the default command to prevent warnings */
+                dns->updown = NULL;
+            }
+            set_user_script(options, &dns->updown, p[1], p[0], false);
+            dns->user_set_updown = true;
+        }
+    }
     else if (streq(p[0], "dns") && p[1])
     {
         VERIFY_PERMISSION(OPT_P_DHCPDNS);

