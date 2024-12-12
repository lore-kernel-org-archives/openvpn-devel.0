From: "d12fk (Code Review)" <gerrit@...515...>
Date: Thu, 12 Dec 2024 07:47:46 +0000
References: <gerrit.1733989644000.Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <512869b830f8378ca8280553affef768e5dd840b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KTZrXPDD+Bw="; charset=UTF-8
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

--KTZrXPDD+Bw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail

to review the following change.


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
A distro/dns-scripts/freebsd-dns-updown.sh
A distro/dns-scripts/linux-dns-updown.sh
A distro/dns-scripts/other-dns-updown.sh
M src/openvpn/Makefile.am
M src/openvpn/dns.c
M src/openvpn/dns.h
M src/openvpn/options.c
12 files changed, 344 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/38/838/1

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
index 9777e36..4bd9a69 100644
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
+		AC_SUBST([TARGET_OS], ["linux"])
 		have_sitnl=3D"yes"
 		pkg_config_required=3D"yes"
 		;;
 	*-*-solaris*)
 		AC_DEFINE([TARGET_SOLARIS], [1], [Are we running on Solaris?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["S"], [Target prefix])
+		AC_SUBST([TARGET_OS], ["solaris"])
 		CPPFLAGS=3D"$CPPFLAGS -D_XPG4_2"
 		test -x /bin/bash && SHELL=3D"/bin/bash"
 		;;
 	*-*-openbsd*)
 		AC_DEFINE([TARGET_OPENBSD], [1], [Are we running on OpenBSD?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["O"], [Target prefix])
+		AC_SUBST([TARGET_OS], ["openbsd"])
 		;;
 	*-*-freebsd*)
 		AC_DEFINE([TARGET_FREEBSD], [1], [Are we running on FreeBSD?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["F"], [Target prefix])
+		AC_SUBST([TARGET_OS], ["freebsd"])
 		;;
 	*-*-netbsd*)
 		AC_DEFINE([TARGET_NETBSD], [1], [Are we running NetBSD?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["N"], [Target prefix])
+		AC_SUBST([TARGET_OS], ["netbsd"])
 		;;
 	*-*-darwin*)
 		AC_DEFINE([TARGET_DARWIN], [1], [Are we running on Mac OS X?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["M"], [Target prefix])
+		AM_CONDITIONAL([ENABLE_DNS_SCRIPT],[false])
+		AC_SUBST([TARGET_OS], ["darwin"])
 		have_tap_header=3D"yes"
 		ac_cv_type_struct_in_pktinfo=3Dno
 		;;
@@ -353,6 +366,8 @@
 		AC_DEFINE([TARGET_WIN32], [1], [Are we running WIN32?])
 		AC_DEFINE([ENABLE_DCO], [1], [DCO is always enabled on Windows])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["W"], [Target prefix])
+		AM_CONDITIONAL([ENABLE_DNS_SCRIPT],[false])
+		AC_SUBST([TARGET_OS], ["windows"])
 		CPPFLAGS=3D"${CPPFLAGS} -DWIN32_LEAN_AND_MEAN"
 		CPPFLAGS=3D"${CPPFLAGS} -DNTDDI_VERSION=3DNTDDI_VISTA -D_WIN32_WINNT=3D_=
WIN32_WINNT_VISTA"
 		WIN32=3Dyes
@@ -360,10 +375,12 @@
 	*-*-dragonfly*)
 		AC_DEFINE([TARGET_DRAGONFLY], [1], [Are we running on DragonFlyBSD?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["D"], [Target prefix])
+		AC_SUBST([TARGET_OS], ["dragonfly"])
 		;;
 	*-aix*)
 		AC_DEFINE([TARGET_AIX], [1], [Are we running AIX?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["A"], [Target prefix])
+		AC_SUBST([TARGET_OS], ["aix"])
 		ROUTE=3D"/usr/sbin/route"
 		have_tap_header=3D"yes"
 		ac_cv_header_net_if_h=3D"no"	# exists, but breaks things
@@ -375,6 +392,7 @@
 		;;
 	*)
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["X"], [Target prefix])
+		AC_SUBST([TARGET_OS], ["other"])
 		have_tap_header=3D"yes"
 		;;
 esac
@@ -1505,6 +1523,7 @@

 sampledir=3D"\$(docdir)/sample"
 AC_SUBST([plugindir])
+AC_SUBST([scriptdir])
 AC_SUBST([sampledir])

 AC_SUBST([systemdunitdir])
@@ -1541,6 +1560,7 @@
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
index 0000000..610bf18
--- /dev/null
+++ b/distro/dns-scripts/Makefile.am
@@ -0,0 +1,27 @@
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
+	linux-dns-updown.sh \
+	freebsd-dns-updown.sh \
+	other-dns-updown.sh
+
+script_SCRIPTS =3D \
+	dns-updown
+
+CLEANFILES =3D $(script_SCRIPTS)
+
+dns-updown: @TARGET_OS@...2841...
+	cp ${srcdir}/@TARGET_OS@...2841... $@
+
+all: $(script_SCRIPTS)
diff --git a/distro/dns-scripts/freebsd-dns-updown.sh b/distro/dns-scripts/=
freebsd-dns-updown.sh
new file mode 100644
index 0000000..12d742d
--- /dev/null
+++ b/distro/dns-scripts/freebsd-dns-updown.sh
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
diff --git a/distro/dns-scripts/linux-dns-updown.sh b/distro/dns-scripts/li=
nux-dns-updown.sh
new file mode 100644
index 0000000..4b459f5
--- /dev/null
+++ b/distro/dns-scripts/linux-dns-updown.sh
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
diff --git a/distro/dns-scripts/other-dns-updown.sh b/distro/dns-scripts/ot=
her-dns-updown.sh
new file mode 100644
index 0000000..e3bcf0d
--- /dev/null
+++ b/distro/dns-scripts/other-dns-updown.sh
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
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--KTZrXPDD+Bw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">dns: apply settings via script on unixoid systems<br><br>This=
 introduces a new script hook, the dns-script and implements such a<br>scri=
pt for a few popular systems (and a default for the not so popular<br>ones)=
. Like the name suggests this script is soleley for dealing with<br>modifyi=
ng how names are resolved when the VPN pushes some --dns<br>settings.<br><b=
r>The default dns script is part of the distribution and is installed with<=
br>openvpn. You can change the path the script is located at as a compile<b=
r>time option, defaults to libexecdir. There&#39;s also a new runtime optio=
n<br>--dns-script, which can run a custom script.<br><br>Change-Id: Ifbe4ff=
b44d3bfcaa50adb38cacb3436fcdc71b10<br>Signed-off-by: Heiko Hund &lt;heiko@...220...=
..2662...&gt;<br>---<br>M .gitignore<br>M CMakeLists.txt<br>M configure.ac<=
br>M distro/Makefile.am<br>A distro/dns-scripts/Makefile.am<br>A distro/dns=
-scripts/freebsd-dns-updown.sh<br>A distro/dns-scripts/linux-dns-updown.sh<=
br>A distro/dns-scripts/other-dns-updown.sh<br>M src/openvpn/Makefile.am<br=
>M src/openvpn/dns.c<br>M src/openvpn/dns.h<br>M src/openvpn/options.c<br>1=
2 files changed, 344 insertions(+), 3 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/38/838/1</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/.gitignore b/.gitignore</span><br><span>index db8bb73..04523af 100644</s=
pan><br><span>--- a/.gitignore</span><br><span>+++ b/.gitignore</span><br><=
span>@@ -49,6 +49,7 @@</span><br><span> /doc/doxygen/latex/</span><br><span=
> /doc/doxygen/openvpn.doxyfile</span><br><span> distro/systemd/*.service</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+distro/dns-scripts/dn=
s-updown</span><br><span> sample/sample-keys/sample-ca/</span><br><span> ve=
ndor/cmocka_build</span><br><span> vendor/dist</span><br><span>diff --git a=
/CMakeLists.txt b/CMakeLists.txt</span><br><span>index ca58cd7..249f7bc 100=
644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.t=
xt</span><br><span>@@ -40,6 +40,7 @@</span><br><span> option(ENABLE_PKCS11 =
&quot;BUILD with pkcs11-helper&quot; ON)</span><br><span> option(USE_WERROR=
 &quot;Treat compiler warnings as errors (-Werror)&quot; ON)</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+set(DNS_UPDOWN_P=
ATH &quot;/usr/libexec/openvpn/dns-updown&quot; CACHE STRING &quot;Default =
location for the DNS up/down script&quot;)</span><br><span> set(PLUGIN_DIR =
/usr/local/lib/openvpn/plugins CACHE FILEPATH &quot;Location of the plugin =
directory&quot;)</span><br><span> </span><br><span> # Create machine readab=
le compile commands</span><br><span>@@ -565,6 +566,8 @@</span><br><span> </=
span><br><span> add_library_deps(openvpn)</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+target_compile_options(openvpn PRIV=
ATE -DDNS_UPDOWN_PATH=3D\&quot;${DNS_UPDOWN_PATH}\&quot;)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> if(MINGW)</span><br=
><span>     target_compile_options(openvpn PRIVATE -municode -UUNICODE)</sp=
an><br><span>     target_link_options(openvpn PRIVATE -municode)</span><br>=
<span>diff --git a/configure.ac b/configure.ac</span><br><span>index 9777e3=
6..4bd9a69 100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/=
configure.ac</span><br><span>@@ -315,37 +315,50 @@</span><br><span> 	plugin=
dir=3D&quot;\${libdir}/openvpn/plugins&quot;</span><br><span> fi</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+AC_ARG_VAR([=
SCRIPTDIR], [Path of script directory @&lt;:@default=3DPKGLIBEXECDIR@:&gt;@=
])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if test -n &quot;=
${SCRIPTDIR}&quot;; then</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	scriptdir=3D&quot;${SCRIPTDIR}&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+else</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+	scriptdir=3D&quot;\${pkglibexecdir}&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+fi</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> AC_DEFINE_UNQUOTED([TARGET_ALIAS], [&quot;$=
{host}&quot;], [A string representing our host])</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-AM_CONDITIONAL([TARGET_LINUX], [false])</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+AM_CONDITIONAL([ENABLE_DNS_S=
CRIPT],[true])</span><br><span> case &quot;$host&quot; in</span><br><span> =
	*-*-linux*)</span><br><span> 		AC_DEFINE([TARGET_LINUX], [1], [Are we runn=
ing on Linux?])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		AM_C=
ONDITIONAL([TARGET_LINUX], [true])</span><br><span> 		AC_DEFINE_UNQUOTED([T=
ARGET_PREFIX], [&quot;L&quot;], [Target prefix])</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+		AC_SUBST([TARGET_OS], [&quot;linux&quot;])</=
span><br><span> 		have_sitnl=3D&quot;yes&quot;</span><br><span> 		pkg_confi=
g_required=3D&quot;yes&quot;</span><br><span> 		;;</span><br><span> 	*-*-so=
laris*)</span><br><span> 		AC_DEFINE([TARGET_SOLARIS], [1], [Are we running=
 on Solaris?])</span><br><span> 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&quo=
t;S&quot;], [Target prefix])</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+		AC_SUBST([TARGET_OS], [&quot;solaris&quot;])</span><br><span> 		=
CPPFLAGS=3D&quot;$CPPFLAGS -D_XPG4_2&quot;</span><br><span> 		test -x /bin/=
bash &amp;&amp; SHELL=3D&quot;/bin/bash&quot;</span><br><span> 		;;</span><=
br><span> 	*-*-openbsd*)</span><br><span> 		AC_DEFINE([TARGET_OPENBSD], [1]=
, [Are we running on OpenBSD?])</span><br><span> 		AC_DEFINE_UNQUOTED([TARG=
ET_PREFIX], [&quot;O&quot;], [Target prefix])</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+		AC_SUBST([TARGET_OS], [&quot;openbsd&quot;])</s=
pan><br><span> 		;;</span><br><span> 	*-*-freebsd*)</span><br><span> 		AC_D=
EFINE([TARGET_FREEBSD], [1], [Are we running on FreeBSD?])</span><br><span>=
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&quot;F&quot;], [Target prefix])</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+		AC_SUBST([TARGET_OS]=
, [&quot;freebsd&quot;])</span><br><span> 		;;</span><br><span> 	*-*-netbsd=
*)</span><br><span> 		AC_DEFINE([TARGET_NETBSD], [1], [Are we running NetBS=
D?])</span><br><span> 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&quot;N&quot;]=
, [Target prefix])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
	AC_SUBST([TARGET_OS], [&quot;netbsd&quot;])</span><br><span> 		;;</span><b=
r><span> 	*-*-darwin*)</span><br><span> 		AC_DEFINE([TARGET_DARWIN], [1], [=
Are we running on Mac OS X?])</span><br><span> 		AC_DEFINE_UNQUOTED([TARGET=
_PREFIX], [&quot;M&quot;], [Target prefix])</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+		AM_CONDITIONAL([ENABLE_DNS_SCRIPT],[false])</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+		AC_SUBST([TARGET_OS], [=
&quot;darwin&quot;])</span><br><span> 		have_tap_header=3D&quot;yes&quot;</=
span><br><span> 		ac_cv_type_struct_in_pktinfo=3Dno</span><br><span> 		;;</=
span><br><span>@@ -353,6 +366,8 @@</span><br><span> 		AC_DEFINE([TARGET_WIN=
32], [1], [Are we running WIN32?])</span><br><span> 		AC_DEFINE([ENABLE_DCO=
], [1], [DCO is always enabled on Windows])</span><br><span> 		AC_DEFINE_UN=
QUOTED([TARGET_PREFIX], [&quot;W&quot;], [Target prefix])</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+		AM_CONDITIONAL([ENABLE_DNS_SCRIPT],=
[false])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		AC_SUBST(=
[TARGET_OS], [&quot;windows&quot;])</span><br><span> 		CPPFLAGS=3D&quot;${C=
PPFLAGS} -DWIN32_LEAN_AND_MEAN&quot;</span><br><span> 		CPPFLAGS=3D&quot;${=
CPPFLAGS} -DNTDDI_VERSION=3DNTDDI_VISTA -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA=
&quot;</span><br><span> 		WIN32=3Dyes</span><br><span>@@ -360,10 +375,12 @@=
</span><br><span> 	*-*-dragonfly*)</span><br><span> 		AC_DEFINE([TARGET_DRA=
GONFLY], [1], [Are we running on DragonFlyBSD?])</span><br><span> 		AC_DEFI=
NE_UNQUOTED([TARGET_PREFIX], [&quot;D&quot;], [Target prefix])</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+		AC_SUBST([TARGET_OS], [&quot;d=
ragonfly&quot;])</span><br><span> 		;;</span><br><span> 	*-aix*)</span><br>=
<span> 		AC_DEFINE([TARGET_AIX], [1], [Are we running AIX?])</span><br><spa=
n> 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&quot;A&quot;], [Target prefix])<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+		AC_SUBST([TARGET_O=
S], [&quot;aix&quot;])</span><br><span> 		ROUTE=3D&quot;/usr/sbin/route&quo=
t;</span><br><span> 		have_tap_header=3D&quot;yes&quot;</span><br><span> 		=
ac_cv_header_net_if_h=3D&quot;no&quot;	# exists, but breaks things</span><b=
r><span>@@ -375,6 +392,7 @@</span><br><span> 		;;</span><br><span> 	*)</spa=
n><br><span> 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&quot;X&quot;], [Target=
 prefix])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		AC_SUBST=
([TARGET_OS], [&quot;other&quot;])</span><br><span> 		have_tap_header=3D&qu=
ot;yes&quot;</span><br><span> 		;;</span><br><span> esac</span><br><span>@@=
 -1505,6 +1523,7 @@</span><br><span> </span><br><span> sampledir=3D&quot;\$=
(docdir)/sample&quot;</span><br><span> AC_SUBST([plugindir])</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+AC_SUBST([scriptdir])</span><br><s=
pan> AC_SUBST([sampledir])</span><br><span> </span><br><span> AC_SUBST([sys=
temdunitdir])</span><br><span>@@ -1541,6 +1560,7 @@</span><br><span> 	Makef=
ile</span><br><span> 	distro/Makefile</span><br><span> 	distro/systemd/Make=
file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	distro/dns-scr=
ipts/Makefile</span><br><span> 	doc/Makefile</span><br><span> 	doc/doxygen/=
Makefile</span><br><span> 	doc/doxygen/openvpn.doxyfile</span><br><span>dif=
f --git a/distro/Makefile.am b/distro/Makefile.am</span><br><span>index 7a5=
88da..b8fb85b 100644</span><br><span>--- a/distro/Makefile.am</span><br><sp=
an>+++ b/distro/Makefile.am</span><br><span>@@ -13,3 +13,7 @@</span><br><sp=
an> 	$(srcdir)/Makefile.in</span><br><span> </span><br><span> SUBDIRS =3D s=
ystemd</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+if ENABLE_DNS_SCRIPT</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+SUBDIRS +=3D dns-scripts</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+endif</span><br><span>diff=
 --git a/distro/dns-scripts/Makefile.am b/distro/dns-scripts/Makefile.am</s=
pan><br><span>new file mode 100644</span><br><span>index 0000000..610bf18</=
span><br><span>--- /dev/null</span><br><span>+++ b/distro/dns-scripts/Makef=
ile.am</span><br><span>@@ -0,0 +1,27 @@</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#  OpenVPN -- An application to securely tunnel IP networks</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#             over a single UDP p=
ort, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#             session authentication and key exchange,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#             packet enc=
ryption, packet authentication, and</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#             packet compression.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#  Copyright (C) 2002-2024 OpenVPN Inc &lt;sales@...515...&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+MAINTAINERCLEANFILES =3D \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	$(srcdir)/Makefile.in</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+EXTRA_DIST =3D \</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+	linux-dns-updown.sh \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	freebsd-dns-updown.sh \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	other-dns-updown.sh</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+scri=
pt_SCRIPTS =3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	dn=
s-updown</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+CLEANFILES =3D $(script_SCRIPT=
S)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+dns-updown: @TARGET_OS@...2841...</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+	cp ${srcdir}/@TARGET_=
OS@...2841... $@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+all: $(script_SCRIPTS)=
</span><br><span>diff --git a/distro/dns-scripts/freebsd-dns-updown.sh b/di=
stro/dns-scripts/freebsd-dns-updown.sh</span><br><span>new file mode 100644=
</span><br><span>index 0000000..12d742d</span><br><span>--- /dev/null</span=
><br><span>+++ b/distro/dns-scripts/freebsd-dns-updown.sh</span><br><span>@=
@ -0,0 +1,55 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/b=
in/sh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+# Simple OpenVPN up/down script =
for openresolv integration</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+# (C) Copyright 2016 Baptiste Daroussin</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#               2024 OpenVPN Inc &lt;sales@...1387...=
5...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# SPDX-License-Identifier: BS=
D-2-Clause</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+# Example env from openvpn =
(most are not applied):</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_search=
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
tyle=3D"color: hsl(120, 100%, 40%);">+[ -z &quot;${dns_vars_file}&quot; ] |=
| . &quot;${dns_vars_file}&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+: ${script_type:=3Ddns-down}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+case &quot;${script_type}&quot; in</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+dns-up)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        i=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        maxns=3D3</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        while :; do</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            maxns=3D$((maxns - 1))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            [ $maxns -gt 0 ] || break</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            eval option=3D\&quot;\$dns_=
server_1_address_${i}\&quot; || break</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            [ &quot;${option}&quot; ] || break</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            i=3D$((i + 1))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            echo &quot;=
nameserver ${option}&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        done</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        i=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  maxdom=3D6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 while :; do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     maxdom=3D$((maxdom - 1))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            [ $maxdom -gt 0 ] || break</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            eval option=3D\&quot;\$dns_search_=
domain_${i}\&quot; || break</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            [ &quot;${option}&quot; ] || break</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            i=3D$((i + 1))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            echo &quot;search ${o=
ption}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 done</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    } | /sbin/=
resolvconf -a &quot;${dev}&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
dns-down)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /sbin/=
resolvconf -d &quot;${dev}&quot; -f</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+esac</span><br><span>diff --git a/distro/dns-scripts/linux-dns-updown.sh=
 b/distro/dns-scripts/linux-dns-updown.sh</span><br><span>new file mode 100=
644</span><br><span>index 0000000..4b459f5</span><br><span>--- /dev/null</s=
pan><br><span>+++ b/distro/dns-scripts/linux-dns-updown.sh</span><br><span>=
@@ -0,0 +1,128 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#!=
/bin/bash</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# dns-updown - add/remove op=
envpn provided DNS information</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Copyr=
ight (C) 2024 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# SPDX-License-Identifier: GPL-2.0</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# Add/remove openvpn DNS settings from the env into/from</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# the system. Supported backe=
nds in this order:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   * systemd-resol=
ved</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   * resolvconf=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+# Example env from openvpn (not all a=
re always applied):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_search_dom=
ain_1 mycorp.in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   =
dns_search_domain_2 eu.mycorp.com</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#   dns_server_1_address_1 192.168.99.254</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_address_2 fd00::99:53<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_por=
t_1 53</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_serve=
r_1_port_2 53</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dn=
s_server_1_resolve_domain_1 mycorp.in</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#   dns_server_1_resolve_domain_2 eu.mycorp.com</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_dnssec true<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_server_1_tra=
nsport DoH</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_s=
erver_1_sni dns.mycorp.in</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+[ -z &quot;${dns_vars_file}&quo=
t; ] || . &quot;${dns_vars_file}&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
function do_resolved_servers {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    local sni=3D&quot;&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    [ &quot;$dns_server_1_transport&quot; =3D &quot;DoT=
&quot; ] &amp;&amp; sni=3D&quot;#$dns_server_1_sni&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    local addrs=3D&quot;&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    for addr_var in ${!dns_server_1_address_*}=
; do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        local p=
ort_var=3D&quot;${addr_var/address/port}&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        local addr=3D&quot;${!addr_var}&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if [ -n &quot;=
${!port_var}&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            if [[ &quot;$addr&quot; =3D~ : ]]; then</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                addr=3D&quot;[$addr]=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            f=
i</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            addrs+=
=3D&quot;${addr}:${!port_var}${sni} &quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            addrs+=3D&quot;${addr}${sni} &quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        fi</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    done</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    resolvectl dns &quot;$dev&quot; $addrs</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+function =
do_resolved_domains {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    local list=3D&quot;&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    for domain_var in ${!dns_search_domain_*}; do</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        list+=3D&quot;${!domain_v=
ar} &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    done<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ -z &quot;${=
!dns_server_1_resolve_domain_*}&quot; ]; then</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        resolvectl default-route &quot;$dev&quot;=
 true</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        list+=
=3D&quot;~.&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        resol=
vectl default-route &quot;$dev&quot; false</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        for domain_var in ${!dns_server_1_resolve_do=
main_*}; do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    [[ &quot;$list&quot; =3D~ (^| )&quot;${!domain_var}&quot;( |$) ]] &amp;=
&amp; continue</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       list+=3D&quot;~${!domain_var} &quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        done</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    fi</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    resolvectl =
domain &quot;$dev&quot; $list</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+function do_resolved_dnssec=
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ &quot;$d=
ns_server_1_dnssec&quot; =3D &quot;optional&quot; ]; then</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        resolvectl dnssec &quot;$dev&=
quot; allow-downgrade</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    elif [ &quot;$dns_server_1_dnssec&quot; =3D &quot;yes&quot; ]; then</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        resolvectl dn=
ssec &quot;$dev&quot; true</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    resolvectl dnssec &quot;$dev&quot; false</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    fi</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+function do_resolved_dnso=
vertls {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ &q=
uot;$dns_server_1_transport&quot; =3D &quot;DoT&quot; ]; then</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        resolvectl dnsovertls &qu=
ot;$dev&quot; true</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        reso=
lvectl dnsovertls &quot;$dev&quot; false</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    fi</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+function do_resolved {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    [[ &quot;$(readlink /e=
tc/resolv.conf)&quot; =3D~ systemd ]] || return 1</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if [ &quot;$script_type&quot; =3D &quot;dns-up&quot; ]; then=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        do_resolved=
_servers</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        do_=
resolved_domains</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     do_resolved_dnssec</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        do_resolved_dnsovertls</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        resolvectl revert &quot;$dev&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    fi</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+function do_resolvconf {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    [ -x /sbin/resolvconf ] || return 1</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if [ &quot;$script_type&quot; =3D &qu=
ot;dns-up&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        local domains=3D&quot;&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        for domain_var in ${!dns_search_domain_*}; do<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            domains+=
=3D&quot;${!domain_var} &quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        done</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      local maxns=3D3</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            for addr_var in ${!dns_server_1_address_*}; do</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                [ $((maxns--)) -gt=
 0 ] || break</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          echo &quot;nameserver ${!addr_var}&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            done</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            [ -z &quot;$domains&quot; ] || echo=
 &quot;search $domains&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        } | /sbin/resolvconf -a &quot;$dev&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        /sbin/resolvconf -d &quot;$dev&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return 0</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+do_resolved || do_resolv=
conf</span><br><span>diff --git a/distro/dns-scripts/other-dns-updown.sh b/=
distro/dns-scripts/other-dns-updown.sh</span><br><span>new file mode 100644=
</span><br><span>index 0000000..e3bcf0d</span><br><span>--- /dev/null</span=
><br><span>+++ b/distro/dns-scripts/other-dns-updown.sh</span><br><span>@@ =
-0,0 +1,50 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/bin=
/sh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# Simple OpenVPN up/down script fo=
r modifying /etc/resolv.conf</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# (C) Copyright 2024 OpenVPN Inc &lt;sales@...515...&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+# SPDX-License-Identifier: BSD-2-Clause</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# Example env from openvpn (most are not appl=
ied):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><s=
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
);">+conf=3D/etc/resolv.conf</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+test -e &quot;$conf&quot; || exit 1</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+test -z &quot;${dns_vars_file}&quot; || . &quot;${=
dns_vars_file}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+case &quot;${script_type}&quot; in</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+dns-up)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    text=3D&quot;### openvpn ${dev} begin ###\n&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    text=3D&quot;${text}nameserver $d=
ns_server_1_address_1\n&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    test -z &quot;$dns_server_1_address_2&quot; ||</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        text=3D&quot;${text}namese=
rver $dns_server_1_address_2\n&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    test -z &quot;$dns_server_1_address_3&quot; ||</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        text=3D&quot;${text=
}nameserver $dns_server_1_address_3\n&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    test -z &quot;$dns_search_domain_1&quot; || {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        for i in $(seq 1 6); do</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            eval domains=3D\=
&quot;$domains\$dns_search_domain_${i} \&quot; || break</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        done</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        text=3D&quot;${text}search $domains\n&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    text=3D&quot;${text}### =
openvpn ${dev} end ###&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sed -i=
 &quot;1i${text}&quot; &quot;$conf&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    ;;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+dns-down)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  sed -i &quot;/### openvpn ${dev} begin ###/,/### openvpn ${dev} end ###/d=
&quot; &quot;$conf&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+esac</sp=
an><br><span>diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am=
</span><br><span>index ecb2bcf..d8beabd 100644</span><br><span>--- a/src/op=
envpn/Makefile.am</span><br><span>+++ b/src/openvpn/Makefile.am</span><br><=
span>@@ -30,7 +30,8 @@</span><br><span> 	$(OPTIONAL_LZ4_CFLAGS) \</span><br=
><span> 	$(OPTIONAL_PKCS11_HELPER_CFLAGS) \</span><br><span> 	$(OPTIONAL_IN=
OTIFY_CFLAGS) \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	-DPLU=
GIN_LIBDIR=3D\&quot;${plugindir}\&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	-DPLUGIN_LIBDIR=3D\&quot;${plugindir}\&quot; \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+	-DDNS_UPDOWN_PATH=3D\&quot=
;${scriptdir}/dns-updown\&quot;</span><br><span> </span><br><span> if WIN32=
</span><br><span> # we want unicode entry point but not the macro</span><br=
><span>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>i=
ndex 4528a9c..2f21ed5 100644</span><br><span>--- a/src/openvpn/dns.c</span>=
<br><span>+++ b/src/openvpn/dns.c</span><br><span>@@ -30,6 +30,7 @@</span><=
br><span> #include &quot;dns.h&quot;</span><br><span> #include &quot;socket=
.h&quot;</span><br><span> #include &quot;options.h&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;run_command.h&quot;</sp=
an><br><span> </span><br><span> #ifdef _WIN32</span><br><span> #include &qu=
ot;win32.h&quot;</span><br><span>@@ -262,6 +263,7 @@</span><br><span>     c=
lone.search_domains =3D clone_dns_domains(o-&gt;search_domains, gc);</span>=
<br><span>     clone.servers =3D clone_dns_servers(o-&gt;servers, gc);</spa=
n><br><span>     clone.servers_prepull =3D clone_dns_servers(o-&gt;servers_=
prepull, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cl=
one.script =3D o-&gt;script;</span><br><span> </span><br><span>     return =
clone;</span><br><span> }</span><br><span>@@ -519,6 +521,42 @@</span><br><s=
pan>     send_msg_iservice(o-&gt;msg_channel, &amp;nrpt, sizeof(nrpt), &amp=
;ack, &quot;DNS&quot;);</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#else /* ifdef _WIN32 */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+script_env_set(bool up, const struct dns_options *o, con=
st struct tuntap *tt, struct env_set *es)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    setenv_str(es, &quot;dev&quot;, tt-&gt;actual_name);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    setenv_str(es, &quot;script_ty=
pe&quot;, up ? &quot;dns-up&quot; : &quot;dns-down&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    setenv_dns_options(o, es);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+do_run_up_down_script(bool up, const struct dns_options *o, const str=
uct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc=
 =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct argv argv =3D argv_new();</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct env_set *es =3D env_set_create(&amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    script_env_set(up, o, tt, es);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    argv_printf(&amp;argv, &quot;%s&quot;, o-&gt;scrip=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_msg(M_I=
NFO, &amp;argv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 int res =3D openvpn_run_script(&amp;argv, es, S_FATAL|S_EXITCODE, &quot;dn=
s script&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_free(&amp;arg=
v);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return res=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+run_up_down_script(bool up, struct options *o, const struct tun=
tap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    int status;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    status =3D do_run_up_down_scr=
ipt(up, &amp;o-&gt;dns_options, tt);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    msg(M_INFO, &quot;dns script exited with status %d&quo=
t;, status);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif =
/* _WIN32 */</span><br><span> </span><br><span> void</span><br><span>@@ -63=
7,5 +675,7 @@</span><br><span> </span><br><span> #ifdef _WIN32</span><br><s=
pan>     run_up_down_service(up, o, tt);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    run_up_down_script(up, o, tt);</span><br><span> #endif /* ifdef =
_WIN32 */</span><br><span> }</span><br><span>diff --git a/src/openvpn/dns.h=
 b/src/openvpn/dns.h</span><br><span>index f24e30b..39a3393 100644</span><b=
r><span>--- a/src/openvpn/dns.h</span><br><span>+++ b/src/openvpn/dns.h</sp=
an><br><span>@@ -73,6 +73,7 @@</span><br><span>     struct dns_server *serv=
ers_prepull;</span><br><span>     struct dns_server *servers;</span><br><sp=
an>     struct gc_arena gc;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const char *script;</span><br><span> };</span><br><span> </span=
><br><span> /**</span><br><span>diff --git a/src/openvpn/options.c b/src/op=
envpn/options.c</span><br><span>index cc723ca..319f370 100644</span><br><sp=
an>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c<=
/span><br><span>@@ -907,6 +907,8 @@</span><br><span> #ifndef ENABLE_DCO</sp=
an><br><span>     o-&gt;disable_dco =3D true;</span><br><span> #endif /* EN=
ABLE_DCO */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;dns_options.scrip=
t =3D DNS_UPDOWN_PATH;</span><br><span> }</span><br><span> </span><br><span=
> void</span><br><span>@@ -8073,6 +8075,15 @@</span><br><span>         to-&=
gt;ip_win32_defined =3D true;</span><br><span>     }</span><br><span> #endi=
f /* ifdef _WIN32 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    else if (streq(p[0], &quot;dns-script&quot;) &amp;&amp; p[1])</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_SCRIPT);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!no_more=
_than_n_args(msglevel, p, 2, NM_QUOTE_HINT))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            goto err;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        set_user_script(options, &amp;options-&gt;dns_options.script=
, p[1], p[0], false);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span>     else if (streq(p[0], &quot;dns&quot;) &amp;&am=
p; p[1])</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(=
OPT_P_DHCPDNS);</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail">change 838</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/838?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifbe4ffb44d3bfcaa50adb38cacb=
3436fcdc71b10 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 838 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--KTZrXPDD+Bw=--

