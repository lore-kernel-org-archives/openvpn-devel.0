From: Gert Doering <gert@...1296...>
Date: Sat, 14 Jun 2025 15:44:52 +0200
Message-ID: <20250614134500.11239-1-gert@...1296...>
In-Reply-To: <gerrit.1749787477000.I48cec222d46c67e6620281cd8b2346323b546fcd@...2715...>
References: <gerrit.1749787477000.I48cec222d46c67e6620281cd8b2346323b546fcd@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] fix typo in haikuos dns-updown script
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

Change-Id: I48cec222d46c67e6620281cd8b2346323b546fcd
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1061
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/distro/dns-scripts/haikuos_file-dns-updown.sh b/distro/dns-scripts/haikuos_file-dns-updown.sh
index 777b72d..6da0954 100644
--- a/distro/dns-scripts/haikuos_file-dns-updown.sh
+++ b/distro/dns-scripts/haikuos_file-dns-updown.sh
@@ -28,7 +28,7 @@
 
 set -e +u
 
-conly_standard_server_ports() {
+only_standard_server_ports() {
     i=1
     while true; do
         eval addr=\"\$dns_server_${n}_address_${i}\"

