From: Frank Lichtenheld <frank@...2641...>
Date: Mon, 18 Aug 2025 18:46:08 +0200
Message-Id: <20250818164608.39836-1-frank@...2641...>
In-Reply-To: <gerrit.1755094344000.Id800cad0e92e0abc0d96079fdb5a9d57578e1446@...2715...>
References: <gerrit.1755094344000.Id800cad0e92e0abc0d96079fdb5a9d57578e1446@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] dns: fix systemd dns-updown script
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

In the resolvconf part of the script there was one instance of a dynamic
variable using _* left. The _* ones do not work as the regular ones, but
only when you directly place them within ${!}, not indirectly using a
variable.

Convert the code to use a loop and a check, like in all the other places
in the script.

Change-Id: Id800cad0e92e0abc0d96079fdb5a9d57578e1446
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1144
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/distro/dns-scripts/systemd-dns-updown.sh b/distro/dns-scripts/systemd-dns-updown.sh
index 9006e28..ed3947a 100644
--- a/distro/dns-scripts/systemd-dns-updown.sh
+++ b/distro/dns-scripts/systemd-dns-updown.sh
@@ -189,11 +189,13 @@
             domains+="${!domain_var} "
         done
         {
+            local i=1
             local maxns=3
-            local server_var=dns_server_${n}_address_*
-            for addr_var in ${!server_var}; do
-                [ $((maxns--)) -gt 0 ] || break
+            while [ "${i}" -le "${maxns}" ]; do
+                local addr_var=dns_server_${n}_address_${i}
+                [ -n "${!addr_var}" ] || break
                 echo "nameserver ${!addr_var}"
+                i=$((i+1))
             done
             [ -z "$domains" ] || echo "search $domains"
         } | /sbin/resolvconf -a "$dev"

