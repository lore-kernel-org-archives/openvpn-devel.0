From: Gert Doering <gert@...1296...>
Date: Thu, 26 Jun 2025 11:19:52 +0200
Message-ID: <20250626091959.23505-1-gert@...1296...>
In-Reply-To: <gerrit.1750848307000.I7b413578a8fc0c65fca26f72b901a9f7bc34b137@...2715...>
References: <gerrit.1750848307000.I7b413578a8fc0c65fca26f72b901a9f7bc34b137@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] fix macOS dns-updown handling of
 parallel full redirects
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

The script didn't handle scenarios well where two or more parallel VPN
connections want to replace the default DNS server. The DNS configuration
has a chance to get broken by the connections going down in a different
order than they came up in.

Disallowing all but the first connection to modify the default DNS server
will effectively prevent this issue. While it may break DNS for the
latter connections, it is the best we can do without knowing specifics
about the configurations.

Change-Id: I7b413578a8fc0c65fca26f72b901a9f7bc34b137
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1066
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/distro/dns-scripts/macos-dns-updown.sh b/distro/dns-scripts/macos-dns-updown.sh
index 89d6882..c15abaa 100644
--- a/distro/dns-scripts/macos-dns-updown.sh
+++ b/distro/dns-scripts/macos-dns-updown.sh
@@ -30,6 +30,7 @@
 
 itf_dns_key="State:/Network/Service/openvpn-${dev}/DNS"
 dns_backup_key="State:/Network/Service/openvpn-${dev}/DnsBackup"
+dns_backup_key_pattern="State:/Network/Service/openvpn-.*/DnsBackup"
 
 function primary_dns_key {
     local uuid=$(echo "show State:/Network/Global/IPv4" | /usr/sbin/scutil | grep "PrimaryService" | cut -d: -f2 | xargs)
@@ -166,6 +167,11 @@
         echo -e "${cmds}" | /usr/sbin/scutil
         set_search_domains "$search_domains"
     else
+        echo list ${dns_backup_key_pattern} | /usr/sbin/scutil | grep -q 'no key' || {
+            echo "setting DNS failed, already redirecting to another tunnel"
+            exit 1
+        }
+
         local cmds=""
         cmds+="get $(primary_dns_key)\n"
         cmds+="set ${dns_backup_key}\n"
@@ -200,6 +206,9 @@
         echo "remove ${itf_dns_key}" | /usr/sbin/scutil
         unset_search_domains "$search_domains"
     else
+        # Do not unset if this tunnel did not set/backup DNS before
+        echo list ${dns_backup_key} | /usr/sbin/scutil | grep -qv 'no key' || return
+
         local cmds=""
         cmds+="get ${dns_backup_key}\n"
         cmds+="set $(primary_dns_key)\n"

