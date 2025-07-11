From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 11 Jul 2025 12:08:53 +0200
Message-Id: <20250711100853.242102-1-frank@...2641...>
In-Reply-To: <gerrit.1751514980000.Id6f70237c7205063b001528a40391678b0d093ac@...2715...>
References: <gerrit.1751514980000.Id6f70237c7205063b001528a40391678b0d093ac@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] move macOS dns-updown common code into
 functions
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

Change-Id: Id6f70237c7205063b001528a40391678b0d093ac
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1074
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/distro/dns-scripts/macos-dns-updown.sh b/distro/dns-scripts/macos-dns-updown.sh
index f0640ee..56f1009 100644
--- a/distro/dns-scripts/macos-dns-updown.sh
+++ b/distro/dns-scripts/macos-dns-updown.sh
@@ -104,7 +104,7 @@
 
         n=$((n+1))
     done
-    return $n
+    echo $n
 }
 
 function get_search_domains {
@@ -157,41 +157,23 @@
     echo -e "${cmds}" | /usr/sbin/scutil
 }
 
-function set_dns {
-    find_compat_profile
-    local n=$?
-
+function addresses_string {
+    local n=$1
     local i=1
-    local addrs=""
+    local addresses=""
     while :; do
         local addr_var=dns_server_${n}_address_${i}
         local addr="${!addr_var}"
         [ -n "$addr" ] || break
-
-        local port_var=dns_server_${n}_port_${i}
-        if [ -n "${!port_var}" ]; then
-            if [[ "$addr" =~ : ]]; then
-                addr="[$addr]"
-            fi
-            addrs+="${addr}:${!port_var}${sni} "
-        else
-            addrs+="${addr}${sni} "
-        fi
+        addresses+="${addr} "
         i=$((i+1))
     done
+    echo "$addresses"
+}
 
-    i=1
-    local match_domains=""
-    while :; do
-        domain_var=dns_server_${n}_resolve_domain_${i}
-        [ -n "${!domain_var}" ] || break
-        # Add as match domain, if it doesn't already exist
-        [[ "$match_domains" =~ (^| )${!domain_var}( |$) ]] \
-            || match_domains+="${!domain_var} "
-        i=$((i+1))
-    done
-
-    i=1
+function search_domains_string {
+    local n=$1
+    local i=1
     local search_domains=""
     while :; do
         domain_var=dns_search_domain_${i}
@@ -201,11 +183,34 @@
             || search_domains+="${!domain_var} "
         i=$((i+1))
     done
+    echo "$search_domains"
+}
+
+function match_domains_string {
+    local n=$1
+    local i=1
+    local match_domains=""
+    while :; do
+        domain_var=dns_server_${n}_resolve_domain_${i}
+        [ -n "${!domain_var}" ] || break
+        # Add as match domain, if it doesn't already exist
+        [[ "$match_domains" =~ (^| )${!domain_var}( |$) ]] \
+            || match_domains+="${!domain_var} "
+        i=$((i+1))
+    done
+    echo "$match_domains"
+}
+
+function set_dns {
+    local n="$(find_compat_profile)"
+    local addresses="$(addresses_string $n)"
+    local search_domains="$(search_domains_string $n)"
+    local match_domains="$(match_domains_string $n)"
 
     if [ -n "$match_domains" ]; then
         local cmds=""
         cmds+="d.init\n"
-        cmds+="d.add ServerAddresses * ${addrs}\n"
+        cmds+="d.add ServerAddresses * ${addresses}\n"
         cmds+="d.add SupplementalMatchDomains * ${match_domains}\n"
         cmds+="d.add SupplementalMatchDomainsNoSearch # 1\n"
         cmds+="add ${itf_dns_key}\n"
@@ -222,7 +227,7 @@
         cmds+="get $(primary_dns_key)\n"
         cmds+="set ${dns_backup_key}\n"
         cmds+="d.init\n"
-        cmds+="d.add ServerAddresses * ${addrs}\n"
+        cmds+="d.add ServerAddresses * ${addresses}\n"
         cmds+="d.add SearchDomains * ${search_domains}\n"
         cmds+="d.add SearchOrder # 5000\n"
         cmds+="set $(primary_dns_key)\n"
@@ -233,22 +238,12 @@
 }
 
 function unset_dns {
-    find_compat_profile
-    local n=$?
+    local n="$(find_compat_profile)"
+    local addresses="$(addresses_string $n)"
+    local search_domains="$(search_domains_string $n)"
+    local match_domains="$(match_domains_string $n)"
 
-    local i=1
-    local search_domains=""
-    while :; do
-        domain_var=dns_search_domain_${i}
-        [ -n "${!domain_var}" ] || break
-        # Add as search domain, if it doesn't already exist
-        [[ "$search_domains" =~ (^| )${!domain_var}( |$) ]] \
-            || search_domains+="${!domain_var} "
-        i=$((i+1))
-    done
-
-    domain_var=dns_server_${n}_resolve_domain_1
-    if [ -n "${!domain_var}" ]; then
+    if [ -n "$match_domains" ]; then
         echo "remove ${itf_dns_key}" | /usr/sbin/scutil
         unset_search_domains "$search_domains"
     else

