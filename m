From: "d12fk (Code Review)" <gerrit@...515...>
Date: Sat, 21 Dec 2024 22:40:04 +0000
In-Reply-To: <gerrit.1733989644000.Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10@...2715...>
References: <gerrit.1733989644000.Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1fa88ef8520e5b9e6718a1a08d2290fec98bd988-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4jmg4080UBc="; charset=UTF-8
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

--4jmg4080UBc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail

to look at the new patch set (#2).


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
13 files changed, 396 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/38/838/2

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
index ca58cd7..249f7bc 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -40,6 +40,7 @@
 option(ENABLE_PKCS11 "BUILD with pkcs11-helper" ON)
 option(USE_WERROR "Treat compiler warnings as errors (-Werror)" ON)

+set(DNS_UPDOWN_PATH "/usr/libexec/openvpn/dns-updown" CACHE STRING "Defaul=
t location for the DNS up/down script")
 set(PLUGIN_DIR /usr/local/lib/openvpn/plugins CACHE FILEPATH "Location of =
the plugin directory")

 # Create machine readable compile commands
@@ -565,6 +566,8 @@

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
index 0000000..bf7ea87
--- /dev/null
+++ b/distro/dns-scripts/haikuos_file-dns-updown.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+#
+# Simple OpenVPN up/down script for modifying Haiku OS resolv.conf
+# (C) Copyright 2024 OpenVPN Inc <sales@...515...>
+#
+# SPDX-License-Identifier: BSD-2-Clause
+#
+# Example env from openvpn (most are not applied):
+#
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
+test -z "${dns_vars_file}" || . "${dns_vars_file}"
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
index 0000000..12d742d
--- /dev/null
+++ b/distro/dns-scripts/openresolv-dns-updown.sh
@@ -0,0 +1,55 @@
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
+[ -z "${dns_vars_file}" ] || . "${dns_vars_file}"
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
index 0000000..e3bcf0d
--- /dev/null
+++ b/distro/dns-scripts/resolvconf_file-dns-updown.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+#
+# Simple OpenVPN up/down script for modifying /etc/resolv.conf
+# (C) Copyright 2024 OpenVPN Inc <sales@...515...>
+#
+# SPDX-License-Identifier: BSD-2-Clause
+#
+# Example env from openvpn (most are not applied):
+#
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
+test -z "${dns_vars_file}" || . "${dns_vars_file}"
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
index 0000000..4b459f5
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
+[ -z "${dns_vars_file}" ] || . "${dns_vars_file}"
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
index ecb2bcf..d8beabd 100644
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
index 4528a9c..2f21ed5 100644
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
index cc723ca..319f370 100644
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
@@ -8073,6 +8075,15 @@
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
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-MessageType: newpatchset

--4jmg4080UBc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, plaisthos. </p>
<p>d12fk <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail">View Change</a=
></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">dns: apply settings via script on unixoid systems<br><br>This introduces =
a new script hook, the dns-script and implements such a<br>script for a few=
 popular systems (and a default for the not so popular<br>ones). Like the n=
ame suggests this script is soleley for dealing with<br>modifying how names=
 are resolved when the VPN pushes some --dns<br>settings.<br><br>The defaul=
t dns script is part of the distribution and is installed with<br>openvpn. =
You can change the path the script is located at as a compile<br>time optio=
n, defaults to libexecdir. There&#39;s also a new runtime option<br>--dns-s=
cript, which can run a custom script.<br><br>Change-Id: Ifbe4ffb44d3bfcaa50=
adb38cacb3436fcdc71b10<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt=
;<br>---<br>M .gitignore<br>M CMakeLists.txt<br>M configure.ac<br>M distro/=
Makefile.am<br>A distro/dns-scripts/Makefile.am<br>A distro/dns-scripts/hai=
kuos_file-dns-updown.sh<br>A distro/dns-scripts/openresolv-dns-updown.sh<br=
>A distro/dns-scripts/resolvconf_file-dns-updown.sh<br>A distro/dns-scripts=
/systemd-dns-updown.sh<br>M src/openvpn/Makefile.am<br>M src/openvpn/dns.c<=
br>M src/openvpn/dns.h<br>M src/openvpn/options.c<br>13 files changed, 396 =
insertions(+), 3 deletions(-)<br><br></pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2=
9418/openvpn refs/changes/38/838/2</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/.gitignore b/.gitig=
nore</span><br><span>index db8bb73..04523af 100644</span><br><span>--- a/.g=
itignore</span><br><span>+++ b/.gitignore</span><br><span>@@ -49,6 +49,7 @@=
</span><br><span> /doc/doxygen/latex/</span><br><span> /doc/doxygen/openvpn=
.doxyfile</span><br><span> distro/systemd/*.service</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+distro/dns-scripts/dns-updown</span><br><=
span> sample/sample-keys/sample-ca/</span><br><span> vendor/cmocka_build</s=
pan><br><span> vendor/dist</span><br><span>diff --git a/CMakeLists.txt b/CM=
akeLists.txt</span><br><span>index ca58cd7..249f7bc 100644</span><br><span>=
--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@=
@ -40,6 +40,7 @@</span><br><span> option(ENABLE_PKCS11 &quot;BUILD with pkc=
s11-helper&quot; ON)</span><br><span> option(USE_WERROR &quot;Treat compile=
r warnings as errors (-Werror)&quot; ON)</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+set(DNS_UPDOWN_PATH &quot;/usr/libex=
ec/openvpn/dns-updown&quot; CACHE STRING &quot;Default location for the DNS=
 up/down script&quot;)</span><br><span> set(PLUGIN_DIR /usr/local/lib/openv=
pn/plugins CACHE FILEPATH &quot;Location of the plugin directory&quot;)</sp=
an><br><span> </span><br><span> # Create machine readable compile commands<=
/span><br><span>@@ -565,6 +566,8 @@</span><br><span> </span><br><span> add_=
library_deps(openvpn)</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+target_compile_options(openvpn PRIVATE -DDNS_UPDOWN_PAT=
H=3D\&quot;${DNS_UPDOWN_PATH}\&quot;)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> if(MINGW)</span><br><span>     target_c=
ompile_options(openvpn PRIVATE -municode -UUNICODE)</span><br><span>     ta=
rget_link_options(openvpn PRIVATE -municode)</span><br><span>diff --git a/c=
onfigure.ac b/configure.ac</span><br><span>index 9777e36..45d3ac1 100644</s=
pan><br><span>--- a/configure.ac</span><br><span>+++ b/configure.ac</span><=
br><span>@@ -315,37 +315,50 @@</span><br><span> 	plugindir=3D&quot;\${libdi=
r}/openvpn/plugins&quot;</span><br><span> fi</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+AC_ARG_VAR([SCRIPTDIR], [Path of=
 script directory @&lt;:@default=3DPKGLIBEXECDIR@:&gt;@])</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+if test -n &quot;${SCRIPTDIR}&quot;; =
then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	scriptdir=3D&q=
uot;${SCRIPTDIR}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	scriptdir=
=3D&quot;\${pkglibexecdir}&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> AC_DEFINE_UNQUOTED([TARGET_ALIAS], [&quot;${host}&quot;], [A =
string representing our host])</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-AM_CONDITIONAL([TARGET_LINUX], [false])</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+AM_CONDITIONAL([ENABLE_DNS_SCRIPT],[true])</sp=
an><br><span> case &quot;$host&quot; in</span><br><span> 	*-*-linux*)</span=
><br><span> 		AC_DEFINE([TARGET_LINUX], [1], [Are we running on Linux?])</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-		AM_CONDITIONAL([TARGET=
_LINUX], [true])</span><br><span> 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&q=
uot;L&quot;], [Target prefix])</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+		AC_SUBST([DNS_UPDOWN_TYPE], [&quot;systemd&quot;])</span><br><=
span> 		have_sitnl=3D&quot;yes&quot;</span><br><span> 		pkg_config_required=
=3D&quot;yes&quot;</span><br><span> 		;;</span><br><span> 	*-*-solaris*)</s=
pan><br><span> 		AC_DEFINE([TARGET_SOLARIS], [1], [Are we running on Solari=
s?])</span><br><span> 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&quot;S&quot;]=
, [Target prefix])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
	AC_SUBST([DNS_UPDOWN_TYPE], [&quot;resolvconf_file&quot;])</span><br><span=
> 		CPPFLAGS=3D&quot;$CPPFLAGS -D_XPG4_2&quot;</span><br><span> 		test -x /=
bin/bash &amp;&amp; SHELL=3D&quot;/bin/bash&quot;</span><br><span> 		;;</sp=
an><br><span> 	*-*-openbsd*)</span><br><span> 		AC_DEFINE([TARGET_OPENBSD],=
 [1], [Are we running on OpenBSD?])</span><br><span> 		AC_DEFINE_UNQUOTED([=
TARGET_PREFIX], [&quot;O&quot;], [Target prefix])</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+		AC_SUBST([DNS_UPDOWN_TYPE], [&quot;resolvco=
nf_file&quot;])</span><br><span> 		;;</span><br><span> 	*-*-freebsd*)</span=
><br><span> 		AC_DEFINE([TARGET_FREEBSD], [1], [Are we running on FreeBSD?]=
)</span><br><span> 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&quot;F&quot;], [=
Target prefix])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		AC=
_SUBST([DNS_UPDOWN_TYPE], [&quot;openresolv&quot;])</span><br><span> 		;;</=
span><br><span> 	*-*-netbsd*)</span><br><span> 		AC_DEFINE([TARGET_NETBSD],=
 [1], [Are we running NetBSD?])</span><br><span> 		AC_DEFINE_UNQUOTED([TARG=
ET_PREFIX], [&quot;N&quot;], [Target prefix])</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+		AC_SUBST([DNS_UPDOWN_TYPE], [&quot;openresolv&q=
uot;])</span><br><span> 		;;</span><br><span> 	*-*-darwin*)</span><br><span=
> 		AC_DEFINE([TARGET_DARWIN], [1], [Are we running on Mac OS X?])</span><b=
r><span> 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&quot;M&quot;], [Target pre=
fix])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		AM_CONDITION=
AL([ENABLE_DNS_SCRIPT],[false])</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+		AC_SUBST([DNS_UPDOWN_TYPE], [&quot;resolvconf_file&quot;])</s=
pan><br><span> 		have_tap_header=3D&quot;yes&quot;</span><br><span> 		ac_cv=
_type_struct_in_pktinfo=3Dno</span><br><span> 		;;</span><br><span>@@ -353,=
6 +366,8 @@</span><br><span> 		AC_DEFINE([TARGET_WIN32], [1], [Are we runni=
ng WIN32?])</span><br><span> 		AC_DEFINE([ENABLE_DCO], [1], [DCO is always =
enabled on Windows])</span><br><span> 		AC_DEFINE_UNQUOTED([TARGET_PREFIX],=
 [&quot;W&quot;], [Target prefix])</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+		AM_CONDITIONAL([ENABLE_DNS_SCRIPT],[false])</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+		AC_SUBST([DNS_UPDOWN_TYPE], [&qu=
ot;windows&quot;])</span><br><span> 		CPPFLAGS=3D&quot;${CPPFLAGS} -DWIN32_=
LEAN_AND_MEAN&quot;</span><br><span> 		CPPFLAGS=3D&quot;${CPPFLAGS} -DNTDDI=
_VERSION=3DNTDDI_VISTA -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA&quot;</span><br>=
<span> 		WIN32=3Dyes</span><br><span>@@ -360,10 +375,12 @@</span><br><span>=
 	*-*-dragonfly*)</span><br><span> 		AC_DEFINE([TARGET_DRAGONFLY], [1], [Ar=
e we running on DragonFlyBSD?])</span><br><span> 		AC_DEFINE_UNQUOTED([TARG=
ET_PREFIX], [&quot;D&quot;], [Target prefix])</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+		AC_SUBST([DNS_UPDOWN_TYPE], [&quot;openresolv&q=
uot;])</span><br><span> 		;;</span><br><span> 	*-aix*)</span><br><span> 		A=
C_DEFINE([TARGET_AIX], [1], [Are we running AIX?])</span><br><span> 		AC_DE=
FINE_UNQUOTED([TARGET_PREFIX], [&quot;A&quot;], [Target prefix])</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+		AC_SUBST([DNS_UPDOWN_TYPE], =
[&quot;resolvconf_file&quot;])</span><br><span> 		ROUTE=3D&quot;/usr/sbin/r=
oute&quot;</span><br><span> 		have_tap_header=3D&quot;yes&quot;</span><br><=
span> 		ac_cv_header_net_if_h=3D&quot;no&quot;	# exists, but breaks things<=
/span><br><span>@@ -371,10 +388,12 @@</span><br><span> 	*-*-haiku*)</span><=
br><span> 		AC_DEFINE([TARGET_HAIKU], [1], [Are we running Haiku?])</span><=
br><span> 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&quot;H&quot;], [Target pr=
efix])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		AC_SUBST([D=
NS_UPDOWN_TYPE], [&quot;haikuos_file&quot;])</span><br><span> 		LIBS=3D&quo=
t;${LIBS} -lnetwork&quot;</span><br><span> 		;;</span><br><span> 	*)</span>=
<br><span> 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&quot;X&quot;], [Target p=
refix])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		AC_SUBST([=
DNS_UPDOWN_TYPE], [&quot;resolvconf_file&quot;])</span><br><span> 		have_ta=
p_header=3D&quot;yes&quot;</span><br><span> 		;;</span><br><span> esac</spa=
n><br><span>@@ -1505,6 +1524,7 @@</span><br><span> </span><br><span> sample=
dir=3D&quot;\$(docdir)/sample&quot;</span><br><span> AC_SUBST([plugindir])<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+AC_SUBST([scriptdir]=
)</span><br><span> AC_SUBST([sampledir])</span><br><span> </span><br><span>=
 AC_SUBST([systemdunitdir])</span><br><span>@@ -1541,6 +1561,7 @@</span><br=
><span> 	Makefile</span><br><span> 	distro/Makefile</span><br><span> 	distr=
o/systemd/Makefile</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
distro/dns-scripts/Makefile</span><br><span> 	doc/Makefile</span><br><span>=
 	doc/doxygen/Makefile</span><br><span> 	doc/doxygen/openvpn.doxyfile</span=
><br><span>diff --git a/distro/Makefile.am b/distro/Makefile.am</span><br><=
span>index 7a588da..b8fb85b 100644</span><br><span>--- a/distro/Makefile.am=
</span><br><span>+++ b/distro/Makefile.am</span><br><span>@@ -13,3 +13,7 @@=
</span><br><span> 	$(srcdir)/Makefile.in</span><br><span> </span><br><span>=
 SUBDIRS =3D systemd</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if ENABLE_DNS_SCRI=
PT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SUBDIRS +=3D dns-=
scripts</span><br><span style=3D"color: hsl(120, 100%, 40%);">+endif</span>=
<br><span>diff --git a/distro/dns-scripts/Makefile.am b/distro/dns-scripts/=
Makefile.am</span><br><span>new file mode 100644</span><br><span>index 0000=
000..ec7bfde</span><br><span>--- /dev/null</span><br><span>+++ b/distro/dns=
-scripts/Makefile.am</span><br><span>@@ -0,0 +1,28 @@</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#  OpenVPN -- An application to securely tunnel IP networks=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#             over =
a single UDP port, with support for SSL/TLS-based</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#             session authentication and key =
exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#         =
    packet encryption, packet authentication, and</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#             packet compression.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#  Copyright (C) 2002-2024 OpenVPN Inc &lt;sales@=
...515...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+MAINTAINERCLEANFILES =3D \</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+	$(srcdir)/Makefile.in</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+EXTRA_DIST =3D \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	systemd-dns-updown.sh \</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+	openresolv-dns-updown.sh \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+	haikuos_file-dns-updown.sh \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+	resolvconf_file-dns-updown.sh=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+script_SCRIPTS =3D \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+	dns-updown</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+CLEANFILES =3D $(script_SCRIPTS)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+dns-updown: @DNS_UPDOWN_TYPE@...2841...</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	cp ${srcdir}/@DNS_UPDOWN_TYPE@...2841... $@</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+all: $(script_SCRIPTS)</span><br><span>diff =
--git a/distro/dns-scripts/haikuos_file-dns-updown.sh b/distro/dns-scripts/=
haikuos_file-dns-updown.sh</span><br><span>new file mode 100644</span><br><=
span>index 0000000..bf7ea87</span><br><span>--- /dev/null</span><br><span>+=
++ b/distro/dns-scripts/haikuos_file-dns-updown.sh</span><br><span>@@ -0,0 =
+1,50 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/bin/sh</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+# Simple OpenVPN up/down script for mod=
ifying Haiku OS resolv.conf</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# (C) Copyright 2024 OpenVPN Inc &lt;sales@...515...&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+# SPDX-License-Identifier: BSD-2-Clause</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# Example env from openvpn (most are not appli=
ed):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#   dns_search_domain_1 mycorp.in=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_search_doma=
in_2 eu.mycorp.com</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
   dns_server_1_address_1 192.168.99.254</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#   dns_server_1_address_2 fd00::99:53</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_port_1 53</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_port_2 53</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_reso=
lve_domain_1 mycorp.in</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#   dns_server_1_resolve_domain_2 eu.mycorp.com</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#   dns_server_1_dnssec true</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_transport DoH</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_sni dns=
.mycorp.in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+set -e +u</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
conf=3D/boot/system/settings/network/resolv.conf</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+test -e &quot;$conf&quot; || exit 1</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+test -z &quot;${dns_vars_file}=
&quot; || . &quot;${dns_vars_file}&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+case &quot;${script_type}&quot; in</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+dns-up)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    text=3D&quot;### openvpn ${dev} begin ###\n&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    text=3D&quot;=
${text}nameserver $dns_server_1_address_1\n&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    test -z &quot;$dns_server_1_address_2&quo=
t; ||</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        text=
=3D&quot;${text}nameserver $dns_server_1_address_2\n&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    test -z &quot;$dns_server_1_addr=
ess_3&quot; ||</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   text=3D&quot;${text}nameserver $dns_server_1_address_3\n&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    test -z &quot;$dns_search_domain_1&quot; || =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for i in $=
(seq 1 6); do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      eval domains=3D\&quot;$domains\$dns_search_domain_${i} \&quot; || bre=
ak</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        done</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        text=3D&quot;${t=
ext}search $domains\n&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    te=
xt=3D&quot;${text}### openvpn ${dev} end ###&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    sed -i &quot;1i${text}&quot; &quot;$conf&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    ;;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+dns-down)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    sed -i &quot;/### openvpn ${dev} begin ###/,/### op=
envpn ${dev} end ###/d&quot; &quot;$conf&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    ;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+esac</span><br><span>diff --git a/distro/dns-scripts/openreso=
lv-dns-updown.sh b/distro/dns-scripts/openresolv-dns-updown.sh</span><br><s=
pan>new file mode 100644</span><br><span>index 0000000..12d742d</span><br><=
span>--- /dev/null</span><br><span>+++ b/distro/dns-scripts/openresolv-dns-=
updown.sh</span><br><span>@@ -0,0 +1,55 @@</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#!/bin/sh</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Sim=
ple OpenVPN up/down script for openresolv integration</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# (C) Copyright 2016 Baptiste Daroussin</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#               2024 =
OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
SPDX-License-Identifier: BSD-2-Clause</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
# Example env from openvpn (most are not applied):</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#   dns_search_domain_1 mycorp.in</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#   dns_search_domain_2 eu.mycorp.com</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_address_1 192=
.168.99.254</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_=
server_1_address_2 fd00::99:53</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#   dns_server_1_port_1 53</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#   dns_server_1_port_2 53</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#   dns_server_1_resolve_domain_1 mycorp.in</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_resolve_d=
omain_2 eu.mycorp.com</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#   dns_server_1_dnssec true</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#   dns_server_1_transport DoH</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#   dns_server_1_sni dns.mycorp.in</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
set -e +u</span><br><span style=3D"color: hsl(120, 100%, 40%);">+[ -z &quot=
;${dns_vars_file}&quot; ] || . &quot;${dns_vars_file}&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+: ${script_type:=3Ddns-down}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+case &quot;${script_type}&=
quot; in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dns-up)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        i=3D1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        maxns=3D3</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        while :; do</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            maxns=3D$((maxns - 1))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            [ $maxns -gt 0=
 ] || break</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    eval option=3D\&quot;\$dns_server_1_address_${i}\&quot; || break</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            [ &quot;${opti=
on}&quot; ] || break</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            i=3D$((i + 1))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            echo &quot;nameserver ${option}&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        done</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        i=3D1</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        maxdom=3D6</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        while :; do</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            maxdom=3D$((maxdom - 1))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            [ $maxdom -gt 0 ] || b=
reak</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            eva=
l option=3D\&quot;\$dns_search_domain_${i}\&quot; || break</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            [ &quot;${option}&quot; =
] || break</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   i=3D$((i + 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          echo &quot;search ${option}&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        done</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    } | /sbin/resolvconf -a &quot;${dev}&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    ;;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+dns-down)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /sbin/resolvconf -d &quot;${dev}&quot; -f</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    ;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+esac</span><br><span>diff --git a/distro/=
dns-scripts/resolvconf_file-dns-updown.sh b/distro/dns-scripts/resolvconf_f=
ile-dns-updown.sh</span><br><span>new file mode 100644</span><br><span>inde=
x 0000000..e3bcf0d</span><br><span>--- /dev/null</span><br><span>+++ b/dist=
ro/dns-scripts/resolvconf_file-dns-updown.sh</span><br><span>@@ -0,0 +1,50 =
@@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/bin/sh</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# Simple OpenVPN up/down script for modifying=
 /etc/resolv.conf</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
(C) Copyright 2024 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# SPDX-License-Identifier: BSD-2-Clause</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+# Example env from openvpn (most are not applied):</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#   dns_search_domain_1 mycorp.in</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_search_domain_2 eu.=
mycorp.com</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_s=
erver_1_address_1 192.168.99.254</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#   dns_server_1_address_2 fd00::99:53</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_port_1 53</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_port_2 53</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_resolve_do=
main_1 mycorp.in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  =
 dns_server_1_resolve_domain_2 eu.mycorp.com</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#   dns_server_1_dnssec true</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_transport DoH</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_sni dns.mycor=
p.in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+set -e +u</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+conf=
=3D/etc/resolv.conf</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
test -e &quot;$conf&quot; || exit 1</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+test -z &quot;${dns_vars_file}&quot; || . &quot;${dns_vars_=
file}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+case &qu=
ot;${script_type}&quot; in</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+dns-up)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    t=
ext=3D&quot;### openvpn ${dev} begin ###\n&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    text=3D&quot;${text}nameserver $dns_server=
_1_address_1\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    test -z &quot;$dns_server_1_address_2&quot; ||</span><br><span style=
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
<span>index 0000000..4b459f5</span><br><span>--- /dev/null</span><br><span>=
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
<span style=3D"color: hsl(120, 100%, 40%);">+#   dns_search_domain_1 mycorp=
.in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_search_d=
omain_2 eu.mycorp.com</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#   dns_server_1_address_1 192.168.99.254</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#   dns_server_1_address_2 fd00::99:53</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_port_1 53</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_port_2 5=
3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_r=
esolve_domain_1 mycorp.in</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#   dns_server_1_resolve_domain_2 eu.mycorp.com</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_dnssec true</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_transport DoH</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_sni =
dns.mycorp.in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+[ -z &quot;${dns_vars_file}&quot; ] || . =
&quot;${dns_vars_file}&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+function d=
o_resolved_servers {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    local sni=3D&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    [ &quot;$dns_server_1_transport&quot; =3D &quot;DoT&quot; ] &=
amp;&amp; sni=3D&quot;#$dns_server_1_sni&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    local addrs=3D&quot;&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    for addr_var in ${!dns_server_1_address_*}; do</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        local port_var=3D=
&quot;${addr_var/address/port}&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        local addr=3D&quot;${!addr_var}&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if [ -n &quot;${!port_va=
r}&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         if [[ &quot;$addr&quot; =3D~ : ]]; then</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                addr=3D&quot;[$addr]&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            fi</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            addrs+=3D&quot;$=
{addr}:${!port_var}${sni} &quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            addrs+=3D&quot;${addr}${sni} &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        fi</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    done</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
esolvectl dns &quot;$dev&quot; $addrs</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+function do_resolve=
d_domains {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    loca=
l list=3D&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    for domain_var in ${!dns_search_domain_*}; do</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        list+=3D&quot;${!domain_var} &quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    done</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if [ -z &quot;${!dns_ser=
ver_1_resolve_domain_*}&quot; ]; then</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        resolvectl default-route &quot;$dev&quot; true</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        list+=3D&quot;=
~.&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        resolvectl def=
ault-route &quot;$dev&quot; false</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        for domain_var in ${!dns_server_1_resolve_domain_*}; =
do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            [[ &q=
uot;$list&quot; =3D~ (^| )&quot;${!domain_var}&quot;( |$) ]] &amp;&amp; con=
tinue</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            li=
st+=3D&quot;~${!domain_var} &quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        done</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    resolvectl domain &q=
uot;$dev&quot; $list</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+function do_resolved_dnssec {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ &quot;$dns_server=
_1_dnssec&quot; =3D &quot;optional&quot; ]; then</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        resolvectl dnssec &quot;$dev&quot; all=
ow-downgrade</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    eli=
f [ &quot;$dns_server_1_dnssec&quot; =3D &quot;yes&quot; ]; then</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        resolvectl dnssec &quo=
t;$dev&quot; true</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        resol=
vectl dnssec &quot;$dev&quot; false</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    fi</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+function do_resolved_dnsovertls {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ &quot;$dns_=
server_1_transport&quot; =3D &quot;DoT&quot; ]; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        resolvectl dnsovertls &quot;$dev&=
quot; true</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        resolvectl d=
nsovertls &quot;$dev&quot; false</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+function do_resolved {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    [[ &quot;$(readlink /etc/resol=
v.conf)&quot; =3D~ systemd ]] || return 1</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if [ &quot;$script_type&quot; =3D &quot;dns-up&quot; ]; then</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        do_resolved_servers=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        do_resolved=
_domains</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        do_=
resolved_dnssec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    do_resolved_dnsovertls</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    resolvectl revert &quot;$dev&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    fi</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+function do_resolvconf {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    [ -x /sbin/resolvconf ] || return 1</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if [ &quot;$script_type&quot; =3D &quot;dns-up&=
quot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  local domains=3D&quot;&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        for domain_var in ${!dns_search_domain_*}; do</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            domains+=3D&quot;$=
{!domain_var} &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        done</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            loca=
l maxns=3D3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    for addr_var in ${!dns_server_1_address_*}; do</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                [ $((maxns--)) -gt 0 ] || br=
eak</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
echo &quot;nameserver ${!addr_var}&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            done</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            [ -z &quot;$domains&quot; ] || echo &quot;sea=
rch $domains&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       } | /sbin/resolvconf -a &quot;$dev&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        /sbin/resolvconf -d &quot;$dev&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return 0</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+do_resolved || do_resolvconf</span=
><br><span>diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am</=
span><br><span>index ecb2bcf..d8beabd 100644</span><br><span>--- a/src/open=
vpn/Makefile.am</span><br><span>+++ b/src/openvpn/Makefile.am</span><br><sp=
an>@@ -30,7 +30,8 @@</span><br><span> 	$(OPTIONAL_LZ4_CFLAGS) \</span><br><=
span> 	$(OPTIONAL_PKCS11_HELPER_CFLAGS) \</span><br><span> 	$(OPTIONAL_INOT=
IFY_CFLAGS) \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	-DPLUGI=
N_LIBDIR=3D\&quot;${plugindir}\&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+	-DPLUGIN_LIBDIR=3D\&quot;${plugindir}\&quot; \</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+	-DDNS_UPDOWN_PATH=3D\&quot;$=
{scriptdir}/dns-updown\&quot;</span><br><span> </span><br><span> if WIN32</=
span><br><span> # we want unicode entry point but not the macro</span><br><=
span>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>ind=
ex 4528a9c..2f21ed5 100644</span><br><span>--- a/src/openvpn/dns.c</span><b=
r><span>+++ b/src/openvpn/dns.c</span><br><span>@@ -30,6 +30,7 @@</span><br=
><span> #include &quot;dns.h&quot;</span><br><span> #include &quot;socket.h=
&quot;</span><br><span> #include &quot;options.h&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;run_command.h&quot;</span=
><br><span> </span><br><span> #ifdef _WIN32</span><br><span> #include &quot=
;win32.h&quot;</span><br><span>@@ -262,6 +263,7 @@</span><br><span>     clo=
ne.search_domains =3D clone_dns_domains(o-&gt;search_domains, gc);</span><b=
r><span>     clone.servers =3D clone_dns_servers(o-&gt;servers, gc);</span>=
<br><span>     clone.servers_prepull =3D clone_dns_servers(o-&gt;servers_pr=
epull, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    clon=
e.script =3D o-&gt;script;</span><br><span> </span><br><span>     return cl=
one;</span><br><span> }</span><br><span>@@ -519,6 +521,42 @@</span><br><spa=
n>     send_msg_iservice(o-&gt;msg_channel, &amp;nrpt, sizeof(nrpt), &amp;a=
ck, &quot;DNS&quot;);</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#else /* ifdef _WIN32 */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+script_env_set(bool up, const struct dns_options *o, const=
 struct tuntap *tt, struct env_set *es)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    setenv_str(es, &quot;dev&quot;, tt-&gt;actual_name);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    setenv_str(es, &quot;script_type=
&quot;, up ? &quot;dns-up&quot; : &quot;dns-down&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    setenv_dns_options(o, es);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+do_run_up_down_script(bool up, const struct dns_options *o, const struct =
tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D=
 gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t argv argv =3D argv_new();</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct env_set *es =3D env_set_create(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    script_env_set(up, o, tt, es);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    argv_printf(&amp;argv, &quot;%s&quot;, o-&gt;script);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_msg(M_INFO,=
 &amp;argv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int=
 res =3D openvpn_run_script(&amp;argv, es, S_FATAL|S_EXITCODE, &quot;dns sc=
ript&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_free(&amp;argv);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return res;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+run_up_down_script(bool up, struct options *o, const struct tuntap =
*tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int status;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    status =3D do_run_up_down_script(=
up, &amp;o-&gt;dns_options, tt);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    msg(M_INFO, &quot;dns script exited with status %d&quot;, =
status);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* _=
WIN32 */</span><br><span> </span><br><span> void</span><br><span>@@ -637,5 =
+675,7 @@</span><br><span> </span><br><span> #ifdef _WIN32</span><br><span>=
     run_up_down_service(up, o, tt);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    run_up_down_script(up, o, tt);</span><br><span> #endif /* ifdef _WIN=
32 */</span><br><span> }</span><br><span>diff --git a/src/openvpn/dns.h b/s=
rc/openvpn/dns.h</span><br><span>index f24e30b..39a3393 100644</span><br><s=
pan>--- a/src/openvpn/dns.h</span><br><span>+++ b/src/openvpn/dns.h</span><=
br><span>@@ -73,6 +73,7 @@</span><br><span>     struct dns_server *servers_=
prepull;</span><br><span>     struct dns_server *servers;</span><br><span> =
    struct gc_arena gc;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const char *script;</span><br><span> };</span><br><span> </span><br=
><span> /**</span><br><span>diff --git a/src/openvpn/options.c b/src/openvp=
n/options.c</span><br><span>index cc723ca..319f370 100644</span><br><span>-=
-- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</spa=
n><br><span>@@ -907,6 +907,8 @@</span><br><span> #ifndef ENABLE_DCO</span><=
br><span>     o-&gt;disable_dco =3D true;</span><br><span> #endif /* ENABLE=
_DCO */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;dns_options.script =
=3D DNS_UPDOWN_PATH;</span><br><span> }</span><br><span> </span><br><span> =
void</span><br><span>@@ -8073,6 +8075,15 @@</span><br><span>         to-&gt=
;ip_win32_defined =3D true;</span><br><span>     }</span><br><span> #endif =
/* ifdef _WIN32 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   else if (streq(p[0], &quot;dns-script&quot;) &amp;&amp; p[1])</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_SCRIPT);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!no_more_th=
an_n_args(msglevel, p, 2, NM_QUOTE_HINT))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            goto err;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        set_user_script(options, &amp;options-&gt;dns_options.script, p=
[1], p[0], false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span>     else if (streq(p[0], &quot;dns&quot;) &amp;&amp; =
p[1])</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT=
_P_DHCPDNS);</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail">change 838</a>. To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/838?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifbe4ffb44d3bfcaa50adb38cacb=
3436fcdc71b10 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 838 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--4jmg4080UBc=--

