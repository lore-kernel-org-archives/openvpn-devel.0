From: Gert Doering <gert@...1296...>
Date: Thu, 15 May 2025 17:29:44 +0200
Message-ID: <20250515152950.1329-1-gert@...1296...>
In-Reply-To: <gerrit.1747322927000.I8ca39e8c175909c62447dc28eea7035446330929@...2715...>
References: <gerrit.1747322927000.I8ca39e8c175909c62447dc28eea7035446330929@...2715...>
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

Change-Id: I8ca39e8c175909c62447dc28eea7035446330929
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1023
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/distro/dns-scripts/haikuos_file-dns-updown.sh b/distro/dns-scripts/haikuos_file-dns-updown.sh
index 748804e..7239b70 100644
--- a/distro/dns-scripts/haikuos_file-dns-updown.sh
+++ b/distro/dns-scripts/haikuos_file-dns-updown.sh
@@ -37,7 +37,7 @@
     done
 }
 
-onf=/boot/system/settings/network/resolv.conf
+conf=/boot/system/settings/network/resolv.conf
 test -e "$conf" || exit 1
 case "${script_type}" in
 dns-up)

