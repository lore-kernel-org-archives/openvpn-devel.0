From: Gert Doering <gert@...1296...>
Date: Sat, 21 Jun 2025 14:12:54 +0200
Message-ID: <20250621121301.27509-1-gert@...1296...>
In-Reply-To: <gerrit.1749787477000.Iade06a8454ccf53668deef61f07217ead8ec6c63@...2715...>
References: <gerrit.1749787477000.Iade06a8454ccf53668deef61f07217ead8ec6c63@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] dns: add updown script for macOS
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

Change-Id: Iade06a8454ccf53668deef61f07217ead8ec6c63
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1062
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/configure.ac b/configure.ac
index 8bdec32..02b45f8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -364,8 +364,7 @@
 	*-*-darwin*)
 		AC_DEFINE([TARGET_DARWIN], [1], [Are we running on Mac OS X?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["M"], [Target prefix])
-		AM_CONDITIONAL([ENABLE_DNS_UPDOWN], [false])
-		AC_SUBST([DNS_UPDOWN_TYPE], ["resolvconf_file"])
+		AC_SUBST([DNS_UPDOWN_TYPE], ["macos"])
 		have_tap_header="yes"
 		ac_cv_type_struct_in_pktinfo=no
 		;;
diff --git a/distro/dns-scripts/Makefile.am b/distro/dns-scripts/Makefile.am
index 9fcd3f7..e3f9043 100644
--- a/distro/dns-scripts/Makefile.am
+++ b/distro/dns-scripts/Makefile.am
@@ -12,6 +12,7 @@
 	$(srcdir)/Makefile.in
 
 EXTRA_DIST = \
+	macos-dns-updown.sh \
 	systemd-dns-updown.sh \
 	openresolv-dns-updown.sh \
 	haikuos_file-dns-updown.sh \
diff --git a/distro/dns-scripts/macos-dns-updown.sh b/distro/dns-scripts/macos-dns-updown.sh
new file mode 100644
index 0000000..89d6882
--- /dev/null
+++ b/distro/dns-scripts/macos-dns-updown.sh
@@ -0,0 +1,217 @@
+#!/bin/bash
+#
+# dns-updown - add/remove openvpn provided DNS information
+#
+# (C) Copyright 2025 OpenVPN Inc <sales@...515...>
+#
+# SPDX-License-Identifier: BSD-2-Clause
+#
+# Example env from openvpn (most are not applied):
+#
+#   dns_vars_file /tmp/openvpn_dvf_58b95c0c97b2db43afb5d745f986c53c.tmp
+#
+#      or
+#
+#   dev utun0
+#   script_type dns-up
+#   dns_search_domain_1 mycorp.in
+#   dns_search_domain_2 eu.mycorp.com
+#   dns_server_1_address_1 192.168.99.254
+#   dns_server_1_address_2 fd00::99:53
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
+itf_dns_key="State:/Network/Service/openvpn-${dev}/DNS"
+dns_backup_key="State:/Network/Service/openvpn-${dev}/DnsBackup"
+
+function primary_dns_key {
+    local uuid=$(echo "show State:/Network/Global/IPv4" | /usr/sbin/scutil | grep "PrimaryService" | cut -d: -f2 | xargs)
+    echo "Setup:/Network/Service/${uuid}/DNS"
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
+function find_compat_profile {
+    local n=1
+    while :; do
+        local addr_var=dns_server_${n}_address_1
+        [ -n "${!addr_var}" ] || {
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
+function get_search_domains {
+    local search_domains=""
+    local resolver=0
+    /usr/sbin/scutil --dns | while read line; do
+        if [[ "$line" =~ resolver.# ]]; then
+            resolver=$((resolver+1))
+        elif [ "$resolver" = 1 ] && [[ "$line" =~ search.domain ]]; then
+            search_domains+="$(echo $line | cut -d: -f2 | xargs) "
+        elif [ "$resolver" -gt 1 ]; then
+            echo "$search_domains"
+            break
+        fi
+    done
+}
+
+function set_search_domains {
+    [ -n "$1" ] || return
+    dns_key=$(primary_dns_key)
+    search_domains="${1}$(get_search_domains)"
+
+    local cmds=""
+    cmds+="get ${dns_key}\n"
+    cmds+="d.add SearchDomains * ${search_domains}\n"
+    cmds+="set ${dns_key}\n"
+    echo -e "${cmds}" | /usr/sbin/scutil
+}
+
+function unset_search_domains {
+    [ -n "$1" ] || return
+    dns_key=$(primary_dns_key)
+    search_domains="$(get_search_domains)"
+    search_domains=$(echo $search_domains | sed -e "s/$1//")
+
+    local cmds=""
+    cmds+="get ${dns_key}\n"
+    cmds+="d.add SearchDomains * ${search_domains}\n"
+    cmds+="set ${dns_key}\n"
+    echo -e "${cmds}" | /usr/sbin/scutil
+}
+
+function set_dns {
+    find_compat_profile
+    local n=$?
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
+    i=1
+    local match_domains=""
+    while :; do
+        domain_var=dns_server_${n}_resolve_domain_${i}
+        [ -n "${!domain_var}" ] || break
+        # Add as match domain, if it doesn't already exist
+        [[ "$match_domains" =~ (^| )${!domain_var}( |$) ]] \
+            || match_domains+="${!domain_var} "
+        i=$((i+1))
+    done
+
+    i=1
+    local search_domains=""
+    while :; do
+        domain_var=dns_search_domain_${i}
+        [ -n "${!domain_var}" ] || break
+        # Add as search domain, if it doesn't already exist
+        [[ "$search_domains" =~ (^| )${!domain_var}( |$) ]] \
+            || search_domains+="${!domain_var} "
+        i=$((i+1))
+    done
+
+    if [ -n "$match_domains" ]; then
+        local cmds=""
+        cmds+="d.init\n"
+        cmds+="d.add ServerAddresses * ${addrs}\n"
+        cmds+="d.add SupplementalMatchDomains * ${match_domains}\n"
+        cmds+="d.add SupplementalMatchDomainsNoSearch # 1\n"
+        cmds+="add ${itf_dns_key}\n"
+        echo -e "${cmds}" | /usr/sbin/scutil
+        set_search_domains "$search_domains"
+    else
+        local cmds=""
+        cmds+="get $(primary_dns_key)\n"
+        cmds+="set ${dns_backup_key}\n"
+        cmds+="d.init\n"
+        cmds+="d.add ServerAddresses * ${addrs}\n"
+        cmds+="d.add SearchDomains * ${search_domains}\n"
+        cmds+="d.add SearchOrder # 5000\n"
+        cmds+="set $(primary_dns_key)\n"
+        echo -e "${cmds}" | /usr/sbin/scutil
+    fi
+
+    /usr/bin/dscacheutil -flushcache
+}
+
+function unset_dns {
+    find_compat_profile
+    local n=$?
+
+    local i=1
+    local search_domains=""
+    while :; do
+        domain_var=dns_search_domain_${i}
+        [ -n "${!domain_var}" ] || break
+        # Add as search domain, if it doesn't already exist
+        [[ "$search_domains" =~ (^| )${!domain_var}( |$) ]] \
+            || search_domains+="${!domain_var} "
+        i=$((i+1))
+    done
+
+    domain_var=dns_server_${n}_resolve_domain_1
+    if [ -n "${!domain_var}" ]; then
+        echo "remove ${itf_dns_key}" | /usr/sbin/scutil
+        unset_search_domains "$search_domains"
+    else
+        local cmds=""
+        cmds+="get ${dns_backup_key}\n"
+        cmds+="set $(primary_dns_key)\n"
+        cmds+="remove ${dns_backup_key}\n"
+        echo -e "${cmds}" | /usr/sbin/scutil
+    fi
+
+    /usr/bin/dscacheutil -flushcache
+}
+
+if [ "$script_type" = "dns-up" ]; then
+    set_dns
+else
+    unset_dns
+fi

