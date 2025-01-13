From: "d12fk (Code Review)" <gerrit@...515...>
Date: Mon, 13 Jan 2025 13:12:16 +0000
In-Reply-To: <gerrit.1733989644000.Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10@...2715...>
References: <gerrit.1733989644000.Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2cda47ed3a0c8bdff869444f70905266c1db5be6-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7ES6BDdvk0o="; charset=UTF-8
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

--7ES6BDdvk0o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail

to look at the new patch set (#7).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


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
M src/openvpn/Makefile.am
M src/openvpn/dns.c
M src/openvpn/dns.h
M src/openvpn/options.c
13 files changed, 400 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/38/838/7

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
index 9ffcc89..5a0a7e3 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -40,7 +40,8 @@
 option(ENABLE_PKCS11 "BUILD with pkcs11-helper" ON)
 option(USE_WERROR "Treat compiler warnings as errors (-Werror)" ON)

-set(PLUGIN_DIR /usr/local/lib/openvpn/plugins CACHE FILEPATH "Location of =
the plugin directory")
+set(DNS_UPDOWN_PATH "${CMAKE_INSTALL_PREFIX}/libexec/openvpn/dns-updown" C=
ACHE STRING "Default location for the DNS up/down script")
+set(PLUGIN_DIR "${CMAKE_INSTALL_PREFIX}/lib/openvpn/plugins" CACHE FILEPAT=
H "Location of the plugin directory")

 # Create machine readable compile commands
 option(ENABLE_COMPILE_COMMANDS "Generate compile_commands.json and a symli=
nk for clangd to find it" OFF)
@@ -567,6 +568,8 @@

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
index 0000000..a4448bd
--- /dev/null
+++ b/distro/dns-scripts/haikuos_file-dns-updown.sh
@@ -0,0 +1,51 @@
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
+conf=3D/boot/system/settings/network/resolv.conf
+test -e "$conf" || exit 1
+case "${script_type}" in
+dns-up)
+    text=3D"### openvpn ${dev} begin ###\n"
+    text=3D"${text}nameserver $dns_server_1_address_1\n"
+    test -z "$dns_server_1_address_2" ||
+        text=3D"${text}nameserver $dns_server_1_address_2\n"
+    test -z "$dns_server_1_address_3" ||
+        text=3D"${text}nameserver $dns_server_1_address_3\n"
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
index 0000000..d2ee1d7
--- /dev/null
+++ b/distro/dns-scripts/openresolv-dns-updown.sh
@@ -0,0 +1,56 @@
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
+: ${script_type:=3Ddns-down}
+case "${script_type}" in
+dns-up)
+    {
+        i=3D1
+        maxns=3D3
+        while :; do
+            maxns=3D$((maxns - 1))
+            [ $maxns -gt 0 ] || break
+            eval option=3D\"\$dns_server_1_address_${i}\" || break
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
index 0000000..a1a4a65
--- /dev/null
+++ b/distro/dns-scripts/resolvconf_file-dns-updown.sh
@@ -0,0 +1,51 @@
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
+conf=3D/etc/resolv.conf
+test -e "$conf" || exit 1
+case "${script_type}" in
+dns-up)
+    text=3D"### openvpn ${dev} begin ###\n"
+    text=3D"${text}nameserver $dns_server_1_address_1\n"
+    test -z "$dns_server_1_address_2" ||
+        text=3D"${text}nameserver $dns_server_1_address_2\n"
+    test -z "$dns_server_1_address_3" ||
+        text=3D"${text}nameserver $dns_server_1_address_3\n"
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
index 0000000..5be04c3
--- /dev/null
+++ b/distro/dns-scripts/systemd-dns-updown.sh
@@ -0,0 +1,128 @@
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
+    [ "$dns_server_1_transport" =3D "DoT" ] && sni=3D"#$dns_server_1_sni"
+
+    local addrs=3D""
+    for addr_var in ${!dns_server_1_address_*}; do
+        local port_var=3D"${addr_var/address/port}"
+        local addr=3D"${!addr_var}"
+        if [ -n "${!port_var}" ]; then
+            if [[ "$addr" =3D~ : ]]; then
+                addr=3D"[$addr]"
+            fi
+            addrs+=3D"${addr}:${!port_var}${sni} "
+        else
+            addrs+=3D"${addr}${sni} "
+        fi
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
+    if [ -z "${!dns_server_1_resolve_domain_*}" ]; then
+        resolvectl default-route "$dev" true
+        list+=3D"~."
+    else
+        resolvectl default-route "$dev" false
+        for domain_var in ${!dns_server_1_resolve_domain_*}; do
+            [[ "$list" =3D~ (^| )"${!domain_var}"( |$) ]] && continue
+            list+=3D"~${!domain_var} "
+        done
+    fi
+
+    resolvectl domain "$dev" $list
+}
+
+function do_resolved_dnssec {
+    if [ "$dns_server_1_dnssec" =3D "optional" ]; then
+        resolvectl dnssec "$dev" allow-downgrade
+    elif [ "$dns_server_1_dnssec" =3D "yes" ]; then
+        resolvectl dnssec "$dev" true
+    else
+        resolvectl dnssec "$dev" false
+    fi
+}
+
+function do_resolved_dnsovertls {
+    if [ "$dns_server_1_transport" =3D "DoT" ]; then
+        resolvectl dnsovertls "$dev" true
+    else
+        resolvectl dnsovertls "$dev" false
+    fi
+}
+
+function do_resolved {
+    [[ "$(readlink /etc/resolv.conf)" =3D~ systemd ]] || return 1
+
+    if [ "$script_type" =3D "dns-up" ]; then
+        do_resolved_servers
+        do_resolved_domains
+        do_resolved_dnssec
+        do_resolved_dnsovertls
+    else
+        resolvectl revert "$dev"
+    fi
+
+    return 0
+}
+
+function do_resolvconf {
+    [ -x /sbin/resolvconf ] || return 1
+
+    if [ "$script_type" =3D "dns-up" ]; then
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
+        /sbin/resolvconf -d "$dev"
+    fi
+
+    return 0
+}
+
+do_resolved || do_resolvconf
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index d6d6592..1d7066c 100644
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
index 12f88ab..96e1234 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -30,6 +30,7 @@
 #include "dns.h"
 #include "socket.h"
 #include "options.h"
+#include "run_command.h"

 #ifdef _WIN32
 #include "win32.h"
@@ -262,6 +263,7 @@
     clone.search_domains =3D clone_dns_domains(o->search_domains, gc);
     clone.servers =3D clone_dns_servers(o->servers, gc);
     clone.servers_prepull =3D clone_dns_servers(o->servers_prepull, gc);
+    clone.script =3D o->script;

     return clone;
 }
@@ -519,6 +521,42 @@
     send_msg_iservice(o->msg_channel, &nrpt, sizeof(nrpt), &ack, "DNS");
 }
=20
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
+    int res =3D openvpn_run_script(&argv, es, S_FATAL|S_EXITCODE, "dns scr=
ipt");
+
+    argv_free(&argv);
+    gc_free(&gc);
+    return res;
+}
+
+static void
+run_up_down_script(bool up, struct options *o, const struct tuntap *tt)
+{
+    int status;
+    status =3D do_run_up_down_script(up, &o->dns_options, tt);
+    msg(M_INFO, "dns script exited with status %d", status);
+}
+
 #endif /* _WIN32 */

 void
@@ -637,5 +675,7 @@

 #ifdef _WIN32
     run_up_down_service(up, o, tt);
+#else
+    run_up_down_script(up, o, tt);
 #endif /* ifdef _WIN32 */
 }
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index f24e30b..39a3393 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -73,6 +73,7 @@
     struct dns_server *servers_prepull;
     struct dns_server *servers;
     struct gc_arena gc;
+    const char *script;
 };

 /**
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 8a6d3b6..9c7a9ae 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -907,6 +907,8 @@
 #ifndef ENABLE_DCO
     o->disable_dco =3D true;
 #endif /* ENABLE_DCO */
+
+    o->dns_options.script =3D DNS_UPDOWN_PATH;
 }

 void
@@ -8040,6 +8042,15 @@
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
+        set_user_script(options, &options->dns_options.script, p[1], p[0],=
 false);
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
Gerrit-PatchSet: 7
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--7ES6BDdvk0o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk <strong>uploaded patch set #7</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">dns: apply settings via script on unixoid sys=
tems<br><br>This introduces a new script hook, the dns-script and implement=
s such a<br>script for a few popular systems (and a default for the not so =
popular<br>ones). Like the name suggests this script is soleley for dealing=
 with<br>modifying how names are resolved when the VPN pushes some --dns<br=
>settings.<br><br>The default dns script is part of the distribution and is=
 installed with<br>openvpn. You can change the path the script is located a=
t as a compile<br>time option, defaults to libexecdir. There&#39;s also a n=
ew runtime option<br>--dns-script, which can run a custom script.<br><br>Ch=
ange-Id: Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10<br>Signed-off-by: Heiko =
Hund &lt;heiko@...2662...&gt;<br>---<br>M .gitignore<br>M CMakeLists.txt<br=
>M configure.ac<br>M distro/Makefile.am<br>A distro/dns-scripts/Makefile.am=
<br>A distro/dns-scripts/haikuos_file-dns-updown.sh<br>A distro/dns-scripts=
/openresolv-dns-updown.sh<br>A distro/dns-scripts/resolvconf_file-dns-updow=
n.sh<br>A distro/dns-scripts/systemd-dns-updown.sh<br>M src/openvpn/Makefil=
e.am<br>M src/openvpn/dns.c<br>M src/openvpn/dns.h<br>M src/openvpn/options=
.c<br>13 files changed, 400 insertions(+), 4 deletions(-)<br><br></pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit.openvpn.net:29418/openvpn refs/changes/38/838/7</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/.gitignore b/.gitignore</span><br><span>index db8bb73..04523af 100=
644</span><br><span>--- a/.gitignore</span><br><span>+++ b/.gitignore</span=
><br><span>@@ -49,6 +49,7 @@</span><br><span> /doc/doxygen/latex/</span><br=
><span> /doc/doxygen/openvpn.doxyfile</span><br><span> distro/systemd/*.ser=
vice</span><br><span style=3D"color: hsl(120, 100%, 40%);">+distro/dns-scri=
pts/dns-updown</span><br><span> sample/sample-keys/sample-ca/</span><br><sp=
an> vendor/cmocka_build</span><br><span> vendor/dist</span><br><span>diff -=
-git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index 9ffcc89..5a0a7=
e3 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeL=
ists.txt</span><br><span>@@ -40,7 +40,8 @@</span><br><span> option(ENABLE_P=
KCS11 &quot;BUILD with pkcs11-helper&quot; ON)</span><br><span> option(USE_=
WERROR &quot;Treat compiler warnings as errors (-Werror)&quot; ON)</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-set(PLUGIN_D=
IR /usr/local/lib/openvpn/plugins CACHE FILEPATH &quot;Location of the plug=
in directory&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
set(DNS_UPDOWN_PATH &quot;${CMAKE_INSTALL_PREFIX}/libexec/openvpn/dns-updow=
n&quot; CACHE STRING &quot;Default location for the DNS up/down script&quot=
;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set(PLUGIN_DIR &q=
uot;${CMAKE_INSTALL_PREFIX}/lib/openvpn/plugins&quot; CACHE FILEPATH &quot;=
Location of the plugin directory&quot;)</span><br><span> </span><br><span> =
# Create machine readable compile commands</span><br><span> option(ENABLE_C=
OMPILE_COMMANDS &quot;Generate compile_commands.json and a symlink for clan=
gd to find it&quot; OFF)</span><br><span>@@ -567,6 +568,8 @@</span><br><spa=
n> </span><br><span> add_library_deps(openvpn)</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+target_compile_options(openvpn=
 PRIVATE -DDNS_UPDOWN_PATH=3D\&quot;${DNS_UPDOWN_PATH}\&quot;)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> if(MINGW)</spa=
n><br><span>     target_compile_options(openvpn PRIVATE -municode -UUNICODE=
)</span><br><span>     target_link_options(openvpn PRIVATE -municode)</span=
><br><span>diff --git a/configure.ac b/configure.ac</span><br><span>index 9=
777e36..45d3ac1 100644</span><br><span>--- a/configure.ac</span><br><span>+=
++ b/configure.ac</span><br><span>@@ -315,37 +315,50 @@</span><br><span> 	p=
lugindir=3D&quot;\${libdir}/openvpn/plugins&quot;</span><br><span> fi</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+AC_ARG_=
VAR([SCRIPTDIR], [Path of script directory @&lt;:@default=3DPKGLIBEXECDIR@:=
&gt;@])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if test -n &=
quot;${SCRIPTDIR}&quot;; then</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	scriptdir=3D&quot;${SCRIPTDIR}&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+else</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+	scriptdir=3D&quot;\${pkglibexecdir}&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span> AC_DEFINE_UNQUOTED([TARGET_ALIAS], [&q=
uot;${host}&quot;], [A string representing our host])</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-AM_CONDITIONAL([TARGET_LINUX], [false])</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+AM_CONDITIONAL([ENABLE_=
DNS_SCRIPT],[true])</span><br><span> case &quot;$host&quot; in</span><br><s=
pan> 	*-*-linux*)</span><br><span> 		AC_DEFINE([TARGET_LINUX], [1], [Are we=
 running on Linux?])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
	AM_CONDITIONAL([TARGET_LINUX], [true])</span><br><span> 		AC_DEFINE_UNQUOT=
ED([TARGET_PREFIX], [&quot;L&quot;], [Target prefix])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+		AC_SUBST([DNS_UPDOWN_TYPE], [&quot;syst=
emd&quot;])</span><br><span> 		have_sitnl=3D&quot;yes&quot;</span><br><span=
> 		pkg_config_required=3D&quot;yes&quot;</span><br><span> 		;;</span><br><=
span> 	*-*-solaris*)</span><br><span> 		AC_DEFINE([TARGET_SOLARIS], [1], [A=
re we running on Solaris?])</span><br><span> 		AC_DEFINE_UNQUOTED([TARGET_P=
REFIX], [&quot;S&quot;], [Target prefix])</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+		AC_SUBST([DNS_UPDOWN_TYPE], [&quot;resolvconf_file&=
quot;])</span><br><span> 		CPPFLAGS=3D&quot;$CPPFLAGS -D_XPG4_2&quot;</span=
><br><span> 		test -x /bin/bash &amp;&amp; SHELL=3D&quot;/bin/bash&quot;</s=
pan><br><span> 		;;</span><br><span> 	*-*-openbsd*)</span><br><span> 		AC_D=
EFINE([TARGET_OPENBSD], [1], [Are we running on OpenBSD?])</span><br><span>=
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&quot;O&quot;], [Target prefix])</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+		AC_SUBST([DNS_UPDOWN=
_TYPE], [&quot;resolvconf_file&quot;])</span><br><span> 		;;</span><br><spa=
n> 	*-*-freebsd*)</span><br><span> 		AC_DEFINE([TARGET_FREEBSD], [1], [Are =
we running on FreeBSD?])</span><br><span> 		AC_DEFINE_UNQUOTED([TARGET_PREF=
IX], [&quot;F&quot;], [Target prefix])</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+		AC_SUBST([DNS_UPDOWN_TYPE], [&quot;openresolv&quot;])<=
/span><br><span> 		;;</span><br><span> 	*-*-netbsd*)</span><br><span> 		AC_=
DEFINE([TARGET_NETBSD], [1], [Are we running NetBSD?])</span><br><span> 		A=
C_DEFINE_UNQUOTED([TARGET_PREFIX], [&quot;N&quot;], [Target prefix])</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+		AC_SUBST([DNS_UPDOWN_TYP=
E], [&quot;openresolv&quot;])</span><br><span> 		;;</span><br><span> 	*-*-d=
arwin*)</span><br><span> 		AC_DEFINE([TARGET_DARWIN], [1], [Are we running =
on Mac OS X?])</span><br><span> 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&quo=
t;M&quot;], [Target prefix])</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+		AM_CONDITIONAL([ENABLE_DNS_SCRIPT],[false])</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+		AC_SUBST([DNS_UPDOWN_TYPE], [&quot;res=
olvconf_file&quot;])</span><br><span> 		have_tap_header=3D&quot;yes&quot;</=
span><br><span> 		ac_cv_type_struct_in_pktinfo=3Dno</span><br><span> 		;;</=
span><br><span>@@ -353,6 +366,8 @@</span><br><span> 		AC_DEFINE([TARGET_WIN=
32], [1], [Are we running WIN32?])</span><br><span> 		AC_DEFINE([ENABLE_DCO=
], [1], [DCO is always enabled on Windows])</span><br><span> 		AC_DEFINE_UN=
QUOTED([TARGET_PREFIX], [&quot;W&quot;], [Target prefix])</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+		AM_CONDITIONAL([ENABLE_DNS_SCRIPT],=
[false])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		AC_SUBST(=
[DNS_UPDOWN_TYPE], [&quot;windows&quot;])</span><br><span> 		CPPFLAGS=3D&qu=
ot;${CPPFLAGS} -DWIN32_LEAN_AND_MEAN&quot;</span><br><span> 		CPPFLAGS=3D&q=
uot;${CPPFLAGS} -DNTDDI_VERSION=3DNTDDI_VISTA -D_WIN32_WINNT=3D_WIN32_WINNT=
_VISTA&quot;</span><br><span> 		WIN32=3Dyes</span><br><span>@@ -360,10 +375=
,12 @@</span><br><span> 	*-*-dragonfly*)</span><br><span> 		AC_DEFINE([TARG=
ET_DRAGONFLY], [1], [Are we running on DragonFlyBSD?])</span><br><span> 		A=
C_DEFINE_UNQUOTED([TARGET_PREFIX], [&quot;D&quot;], [Target prefix])</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+		AC_SUBST([DNS_UPDOWN_TYP=
E], [&quot;openresolv&quot;])</span><br><span> 		;;</span><br><span> 	*-aix=
*)</span><br><span> 		AC_DEFINE([TARGET_AIX], [1], [Are we running AIX?])</=
span><br><span> 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&quot;A&quot;], [Tar=
get prefix])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		AC_SU=
BST([DNS_UPDOWN_TYPE], [&quot;resolvconf_file&quot;])</span><br><span> 		RO=
UTE=3D&quot;/usr/sbin/route&quot;</span><br><span> 		have_tap_header=3D&quo=
t;yes&quot;</span><br><span> 		ac_cv_header_net_if_h=3D&quot;no&quot;	# exi=
sts, but breaks things</span><br><span>@@ -371,10 +388,12 @@</span><br><spa=
n> 	*-*-haiku*)</span><br><span> 		AC_DEFINE([TARGET_HAIKU], [1], [Are we r=
unning Haiku?])</span><br><span> 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&qu=
ot;H&quot;], [Target prefix])</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+		AC_SUBST([DNS_UPDOWN_TYPE], [&quot;haikuos_file&quot;])</span><=
br><span> 		LIBS=3D&quot;${LIBS} -lnetwork&quot;</span><br><span> 		;;</spa=
n><br><span> 	*)</span><br><span> 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&q=
uot;X&quot;], [Target prefix])</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+		AC_SUBST([DNS_UPDOWN_TYPE], [&quot;resolvconf_file&quot;])</sp=
an><br><span> 		have_tap_header=3D&quot;yes&quot;</span><br><span> 		;;</sp=
an><br><span> esac</span><br><span>@@ -1505,6 +1524,7 @@</span><br><span> <=
/span><br><span> sampledir=3D&quot;\$(docdir)/sample&quot;</span><br><span>=
 AC_SUBST([plugindir])</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+AC_SUBST([scriptdir])</span><br><span> AC_SUBST([sampledir])</span><br><=
span> </span><br><span> AC_SUBST([systemdunitdir])</span><br><span>@@ -1541=
,6 +1561,7 @@</span><br><span> 	Makefile</span><br><span> 	distro/Makefile<=
/span><br><span> 	distro/systemd/Makefile</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	distro/dns-scripts/Makefile</span><br><span> 	doc/Ma=
kefile</span><br><span> 	doc/doxygen/Makefile</span><br><span> 	doc/doxygen=
/openvpn.doxyfile</span><br><span>diff --git a/distro/Makefile.am b/distro/=
Makefile.am</span><br><span>index 7a588da..b8fb85b 100644</span><br><span>-=
-- a/distro/Makefile.am</span><br><span>+++ b/distro/Makefile.am</span><br>=
<span>@@ -13,3 +13,7 @@</span><br><span> 	$(srcdir)/Makefile.in</span><br><=
span> </span><br><span> SUBDIRS =3D systemd</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+if ENABLE_DNS_SCRIPT</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+SUBDIRS +=3D dns-scripts</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+endif</span><br><span>diff --git a/distro/dns-scripts/Makefile.a=
m b/distro/dns-scripts/Makefile.am</span><br><span>new file mode 100644</sp=
an><br><span>index 0000000..ec7bfde</span><br><span>--- /dev/null</span><br=
><span>+++ b/distro/dns-scripts/Makefile.am</span><br><span>@@ -0,0 +1,28 @=
@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#  OpenVPN -- An application to secu=
rely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#             over a single UDP port, with support for SSL/TLS-based</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#             session =
authentication and key exchange,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#             packet encryption, packet authentication, and</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#             packet c=
ompression.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#  Copyright (C) 2002-2024=
 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+MAINTAINERCLEANFILES=
 =3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(srcdir)/Ma=
kefile.in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+EXTRA_DIST =3D \</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+	systemd-dns-updown.sh \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+	openresolv-dns-updown.sh \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	haikuos_file-dns-u=
pdown.sh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	resolvco=
nf_file-dns-updown.sh</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+script_SCRIPTS =
=3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	dns-updown</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+CLEANFILES =3D $(script_SCRIPTS)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+dns-updown: @DNS_UPDOWN_TYPE@...2841...</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+	cp ${srcdir}/@DNS_UPDOWN_T=
YPE@...2841... $@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+all: $(script_SCRIPTS=
)</span><br><span>diff --git a/distro/dns-scripts/haikuos_file-dns-updown.s=
h b/distro/dns-scripts/haikuos_file-dns-updown.sh</span><br><span>new file =
mode 100644</span><br><span>index 0000000..a4448bd</span><br><span>--- /dev=
/null</span><br><span>+++ b/distro/dns-scripts/haikuos_file-dns-updown.sh</=
span><br><span>@@ -0,0 +1,51 @@</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#!/bin/sh</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Simple OpenVPN=
 up/down script for modifying Haiku OS resolv.conf</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# (C) Copyright 2024 OpenVPN Inc &lt;sales@...220...=
..515...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+# SPDX-License-Identifier=
: BSD-2-Clause</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+# Example env from open=
vpn (most are not applied):</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dev tu=
n0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   script-type d=
ns-up</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_search=
_domain_1 mycorp.in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#   dns_search_domain_2 eu.mycorp.com</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#   dns_server_1_address_1 192.168.99.254</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_address_2 fd00::99=
:53</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1=
_port_1 53</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_s=
erver_1_port_2 53</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
  dns_server_1_resolve_domain_1 mycorp.in</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#   dns_server_1_resolve_domain_2 eu.mycorp.com</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_dnssec t=
rue</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1=
_transport DoH</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   d=
ns_server_1_sni dns.mycorp.in</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+set -e +u</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+conf=3D/boot/system/settings/network/resolv.conf</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+test -e &quot;$conf&quot; |=
| exit 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+case &quot;=
${script_type}&quot; in</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+dns-up)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    text=
=3D&quot;### openvpn ${dev} begin ###\n&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    text=3D&quot;${text}nameserver $dns_server_1_=
address_1\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  test -z &quot;$dns_server_1_address_2&quot; ||</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        text=3D&quot;${text}nameserver $dns_se=
rver_1_address_2\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    test -z &quot;$dns_server_1_address_3&quot; ||</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        text=3D&quot;${text}nameserver =
$dns_server_1_address_3\n&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tes=
t -z &quot;$dns_search_domain_1&quot; || {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        for i in $(seq 1 6); do</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            eval domains=3D\&quot;$domai=
ns\$dns_search_domain_${i} \&quot; || break</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        done</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        text=3D&quot;${text}search $domains\n&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    text=3D&quot;${text}### openvpn ${de=
v} end ###&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    sed -i &quot;1i${t=
ext}&quot; &quot;$conf&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dns-=
down)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sed -i &qu=
ot;/### openvpn ${dev} begin ###/,/### openvpn ${dev} end ###/d&quot; &quot=
;$conf&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ;;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+esac</span><br><span=
>diff --git a/distro/dns-scripts/openresolv-dns-updown.sh b/distro/dns-scri=
pts/openresolv-dns-updown.sh</span><br><span>new file mode 100644</span><br=
><span>index 0000000..d2ee1d7</span><br><span>--- /dev/null</span><br><span=
>+++ b/distro/dns-scripts/openresolv-dns-updown.sh</span><br><span>@@ -0,0 =
+1,56 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/bin/sh</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+# Simple OpenVPN up/down script for ope=
nresolv integration</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
# (C) Copyright 2016 Baptiste Daroussin</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#               2024 OpenVPN Inc &lt;sales@...515...&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+# SPDX-License-Identifier: BSD-2-Cla=
use</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# Example env from openvpn (most a=
re not applied):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dev tun0</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#   script-type dns-up</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_search_domain_1 m=
ycorp.in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_sea=
rch_domain_2 eu.mycorp.com</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#   dns_server_1_address_1 192.168.99.254</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#   dns_server_1_address_2 fd00::99:53</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_port_1 53<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_por=
t_2 53</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_serve=
r_1_resolve_domain_1 mycorp.in</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#   dns_server_1_resolve_domain_2 eu.mycorp.com</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_dnssec true</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_transport =
DoH</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1=
_sni dns.mycorp.in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+set -e +u</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+: ${script_type:=3Ddns-down}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+case &quot;${script_type}&quot; in</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+dns-up)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        i=3D1</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        maxns=3D3</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        while :; do</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            maxns=3D$((maxns - 1))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            [ $maxns -gt 0 ] || break</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            eval option=
=3D\&quot;\$dns_server_1_address_${i}\&quot; || break</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            [ &quot;${option}&quot; ] || =
break</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
=3D$((i + 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      echo &quot;nameserver ${option}&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        done</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        i=3D1</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        maxdom=3D6</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        while :; do</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            maxdom=3D$((maxdom - 1))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            [ $maxdom -gt 0 ] || break</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            eval option=3D\&q=
uot;\$dns_search_domain_${i}\&quot; || break</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            [ &quot;${option}&quot; ] || break</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=3D$((i + =
1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            echo=
 &quot;search ${option}&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        done</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    } | /sbin/resolvconf -a &quot;${dev}&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    ;;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+dns-down)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /sbin/resolvconf -d &quot;${dev}&quot; -f</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ;;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+esac</span><br><span>diff --git a/distro/dns-scripts/r=
esolvconf_file-dns-updown.sh b/distro/dns-scripts/resolvconf_file-dns-updow=
n.sh</span><br><span>new file mode 100644</span><br><span>index 0000000..a1=
a4a65</span><br><span>--- /dev/null</span><br><span>+++ b/distro/dns-script=
s/resolvconf_file-dns-updown.sh</span><br><span>@@ -0,0 +1,51 @@</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#!/bin/sh</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# Simple OpenVPN up/down script for modifying /etc/resolv.=
conf</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# (C) Copyright=
 2024 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# SPDX-License-Identifier: BSD-2-Clause</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+# Example env from openvpn (most are not applied):</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#   dev tun0</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#   script-type dns-up</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#   dns_search_domain_1 mycorp.in</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#   dns_search_domain_2 eu.mycorp.com</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_address_1 1=
92.168.99.254</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dn=
s_server_1_address_2 fd00::99:53</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#   dns_server_1_port_1 53</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#   dns_server_1_port_2 53</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#   dns_server_1_resolve_domain_1 mycorp.in</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_resolve=
_domain_2 eu.mycorp.com</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#   dns_server_1_dnssec true</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#   dns_server_1_transport DoH</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#   dns_server_1_sni dns.mycorp.in</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+set -e +u</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+conf=3D/etc/resolv.conf</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+test -e &quot;$conf&quo=
t; || exit 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+case &q=
uot;${script_type}&quot; in</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+dns-up)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
text=3D&quot;### openvpn ${dev} begin ###\n&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    text=3D&quot;${text}nameserver $dns_serve=
r_1_address_1\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    test -z &quot;$dns_server_1_address_2&quot; ||</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        text=3D&quot;${text}nameserver $d=
ns_server_1_address_2\n&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    test -z &quot;$dns_server_1_address_3&quot; ||</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        text=3D&quot;${text}namese=
rver $dns_server_1_address_3\n&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  test -z &quot;$dns_search_domain_1&quot; || {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        for i in $(seq 1 6); do</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            eval domains=3D\&quot;$=
domains\$dns_search_domain_${i} \&quot; || break</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        done</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        text=3D&quot;${text}search $domains\n&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    text=3D&quot;${text}### openvpn=
 ${dev} end ###&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sed -i &quot;=
1i${text}&quot; &quot;$conf&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+dns-down)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sed -=
i &quot;/### openvpn ${dev} begin ###/,/### openvpn ${dev} end ###/d&quot; =
&quot;$conf&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+esac</span><br>=
<span>diff --git a/distro/dns-scripts/systemd-dns-updown.sh b/distro/dns-sc=
ripts/systemd-dns-updown.sh</span><br><span>new file mode 100644</span><br>=
<span>index 0000000..5be04c3</span><br><span>--- /dev/null</span><br><span>=
+++ b/distro/dns-scripts/systemd-dns-updown.sh</span><br><span>@@ -0,0 +1,1=
28 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/bin/bash</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+# dns-updown - add/remove openvpn provid=
ed DNS information</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Copyright (C) 202=
4 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
# SPDX-License-Identifier: GPL-2.0</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# A=
dd/remove openvpn DNS settings from the env into/from</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# the system. Supported backends in this =
order:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#   * systemd-resolved</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#   * resolvconf</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+# Example env from openvpn (not all are always ap=
plied):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#   dev tun0</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#   script-type dns-up</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#   dns_search_domain_1 mycorp.in<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_search_domai=
n_2 eu.mycorp.com</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
  dns_server_1_address_1 192.168.99.254</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#   dns_server_1_address_2 fd00::99:53</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_port_1 53</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_port_2 53</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_resol=
ve_domain_1 mycorp.in</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#   dns_server_1_resolve_domain_2 eu.mycorp.com</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#   dns_server_1_dnssec true</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_transport DoH</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_sni dns.=
mycorp.in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+function do_resolved_servers {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    local sni=3D&quot;&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    [ &quot;$dns_server_1_t=
ransport&quot; =3D &quot;DoT&quot; ] &amp;&amp; sni=3D&quot;#$dns_server_1_=
sni&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    local addrs=3D&quot;&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for addr_var i=
n ${!dns_server_1_address_*}; do</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        local port_var=3D&quot;${addr_var/address/port}&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        local addr=
=3D&quot;${!addr_var}&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if [ -n &quot;${!port_var}&quot; ]; then</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            if [[ &quot;$addr&quot; =
=3D~ : ]]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            addr=3D&quot;[$addr]&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            fi</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            addrs+=3D&quot;${addr}:${!port_var}${sni} &quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            addrs+=3D&quot;=
${addr}${sni} &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    done=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    resolvectl dns &quot;$dev&quot; $a=
ddrs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+function do_resolved_domains {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    local list=3D&quot;&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    for domain_var in ${!dns_se=
arch_domain_*}; do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       list+=3D&quot;${!domain_var} &quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    done</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if [ -z &quot;${!dns_server_1_resolve_domain_*}&quot; ]; th=
en</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        resolvect=
l default-route &quot;$dev&quot; true</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        list+=3D&quot;~.&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        resolvectl default-route &quot;$dev&quot; false</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for domain_va=
r in ${!dns_server_1_resolve_domain_*}; do</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            [[ &quot;$list&quot; =3D~ (^| )&quot;${!=
domain_var}&quot;( |$) ]] &amp;&amp; continue</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            list+=3D&quot;~${!domain_var} &quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        done</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    resolvectl domain &quot;$dev&quot; $list</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+function do_resolved_dnssec {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if [ &quot;$dns_server_1_dnssec&quot; =3D &quot;optional&=
quot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  resolvectl dnssec &quot;$dev&quot; allow-downgrade</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    elif [ &quot;$dns_server_1_dnssec&quo=
t; =3D &quot;yes&quot; ]; then</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        resolvectl dnssec &quot;$dev&quot; true</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        resolvectl dnssec &quot;$dev&quot; fals=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+function do_resolved_dnsovertls {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if [ &quot;$dns_server_1_transport&quot; =3D &quot=
;DoT&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       resolvectl dnsovertls &quot;$dev&quot; true</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        resolvectl dnsovertls &quot;$dev&quot; false</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+function do_resolved {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    [[ &quot;$(readlink /etc/resolv.conf)&quot; =3D~ systemd ]] || re=
turn 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if [ &quot;$script_type&quot=
; =3D &quot;dns-up&quot; ]; then</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        do_resolved_servers</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        do_resolved_domains</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        do_resolved_dnssec</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        do_resolved_dnsovertls</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        resolvectl revert &quot;$dev&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return 0</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+function do_resol=
vconf {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    [ -x /sb=
in/resolvconf ] || return 1</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ &q=
uot;$script_type&quot; =3D &quot;dns-up&quot; ]; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        local domains=3D&quot;&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        for domain_var i=
n ${!dns_search_domain_*}; do</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            domains+=3D&quot;${!domain_var} &quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        done</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            local maxns=3D3</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            for addr_var in ${!dns_server=
_1_address_*}; do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              [ $((maxns--)) -gt 0 ] || break</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                echo &quot;nameserver ${!addr_var=
}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
done</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            [ -=
z &quot;$domains&quot; ] || echo &quot;search $domains&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        } | /sbin/resolvconf -a &q=
uot;$dev&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
lse</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /sbin/re=
solvconf -d &quot;$dev&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+do_resolved || do_resolvconf</span><br><span>diff --git a/src/openv=
pn/Makefile.am b/src/openvpn/Makefile.am</span><br><span>index d6d6592..1d7=
066c 100644</span><br><span>--- a/src/openvpn/Makefile.am</span><br><span>+=
++ b/src/openvpn/Makefile.am</span><br><span>@@ -30,7 +30,8 @@</span><br><s=
pan> 	$(OPTIONAL_LZ4_CFLAGS) \</span><br><span> 	$(OPTIONAL_PKCS11_HELPER_C=
FLAGS) \</span><br><span> 	$(OPTIONAL_INOTIFY_CFLAGS) \</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	-DPLUGIN_LIBDIR=3D\&quot;${plugindir}\&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-DPLUGIN_LIBDI=
R=3D\&quot;${plugindir}\&quot; \</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+	-DDNS_UPDOWN_PATH=3D\&quot;${scriptdir}/dns-updown\&quot;</sp=
an><br><span> </span><br><span> if WIN32</span><br><span> # we want unicode=
 entry point but not the macro</span><br><span>diff --git a/src/openvpn/dns=
.c b/src/openvpn/dns.c</span><br><span>index 12f88ab..96e1234 100644</span>=
<br><span>--- a/src/openvpn/dns.c</span><br><span>+++ b/src/openvpn/dns.c</=
span><br><span>@@ -30,6 +30,7 @@</span><br><span> #include &quot;dns.h&quot=
;</span><br><span> #include &quot;socket.h&quot;</span><br><span> #include =
&quot;options.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;run_command.h&quot;</span><br><span> </span><br><span> #if=
def _WIN32</span><br><span> #include &quot;win32.h&quot;</span><br><span>@@=
 -262,6 +263,7 @@</span><br><span>     clone.search_domains =3D clone_dns_d=
omains(o-&gt;search_domains, gc);</span><br><span>     clone.servers =3D cl=
one_dns_servers(o-&gt;servers, gc);</span><br><span>     clone.servers_prep=
ull =3D clone_dns_servers(o-&gt;servers_prepull, gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    clone.script =3D o-&gt;script;</span>=
<br><span> </span><br><span>     return clone;</span><br><span> }</span><br=
><span>@@ -519,6 +521,42 @@</span><br><span>     send_msg_iservice(o-&gt;ms=
g_channel, &amp;nrpt, sizeof(nrpt), &amp;ack, &quot;DNS&quot;);</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#else /* ifdef _WIN32 */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+script_env_set(b=
ool up, const struct dns_options *o, const struct tuntap *tt, struct env_se=
t *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    setenv_str(es, &quot;dev&qu=
ot;, tt-&gt;actual_name);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    setenv_str(es, &quot;script_type&quot;, up ? &quot;dns-up&quot; :=
 &quot;dns-down&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    setenv_dns_options(o, es);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+do_run_up_down_script(bool up, =
const struct dns_options *o, const struct tuntap *tt)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct argv argv =3D argv_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct env_set *es =
=3D env_set_create(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    script=
_env_set(up, o, tt, es);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_print=
f(&amp;argv, &quot;%s&quot;, o-&gt;script);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    argv_msg(M_INFO, &amp;argv);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    int res =3D openvpn_run_script(&am=
p;argv, es, S_FATAL|S_EXITCODE, &quot;dns script&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    argv_free(&amp;argv);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return res;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+run_up_down_script(bool=
 up, struct options *o, const struct tuntap *tt)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    int status;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    status =3D do_run_up_down_script(up, &amp;o-&gt;dns_options, tt)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_INFO, &q=
uot;dns script exited with status %d&quot;, status);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> #endif /* _WIN32 */</span><br><span> </sp=
an><br><span> void</span><br><span>@@ -637,5 +675,7 @@</span><br><span> </s=
pan><br><span> #ifdef _WIN32</span><br><span>     run_up_down_service(up, o=
, tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    run_up_down_script(up, =
o, tt);</span><br><span> #endif /* ifdef _WIN32 */</span><br><span> }</span=
><br><span>diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h</span><br><sp=
an>index f24e30b..39a3393 100644</span><br><span>--- a/src/openvpn/dns.h</s=
pan><br><span>+++ b/src/openvpn/dns.h</span><br><span>@@ -73,6 +73,7 @@</sp=
an><br><span>     struct dns_server *servers_prepull;</span><br><span>     =
struct dns_server *servers;</span><br><span>     struct gc_arena gc;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *script;</s=
pan><br><span> };</span><br><span> </span><br><span> /**</span><br><span>di=
ff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>in=
dex 8a6d3b6..9c7a9ae 100644</span><br><span>--- a/src/openvpn/options.c</sp=
an><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -907,6 +907,8 @=
@</span><br><span> #ifndef ENABLE_DCO</span><br><span>     o-&gt;disable_dc=
o =3D true;</span><br><span> #endif /* ENABLE_DCO */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    o-&gt;dns_options.script =3D DNS_UPDOWN_PATH;</span><br>=
<span> }</span><br><span> </span><br><span> void</span><br><span>@@ -8040,6=
 +8042,15 @@</span><br><span>         to-&gt;ip_win32_defined =3D true;</sp=
an><br><span>     }</span><br><span> #endif /* ifdef _WIN32 */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;d=
ns-script&quot;) &amp;&amp; p[1])</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        VERIFY_PERMISSION(OPT_P_SCRIPT);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (!no_more_than_n_args(msglevel, p, 2, NM_QU=
OTE_HINT))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto er=
r;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        set_user_script(opt=
ions, &amp;options-&gt;dns_options.script, p[1], p[0], false);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else =
if (streq(p[0], &quot;dns&quot;) &amp;&amp; p[1])</span><br><span>     {</s=
pan><br><span>         VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/838?usp=3Demail">change 838</a>. To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/838?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifbe4ffb44d3bfcaa50adb38cacb=
3436fcdc71b10 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 838 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
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


--7ES6BDdvk0o=--

