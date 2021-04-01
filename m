From: Gert Doering <gert@...1296...>
Date: Thu,  1 Apr 2021 10:29:34 +0200
Message-Id: <20210401082934.29922-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Get rid of last PLUGIN_DEF_AUTH #ifdef
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

Commit 99d217b200 attempted to get rid of all #ifdef related to
--disable-def-auth but one of them managed to hide.  Remove.

The effect of this is that the "openvpn_acf_...tmp" files get not
removed after when an async auth plugin is in use.  This is can
get very annoying on a busy server.

Trac: #1186

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/ssl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 893e5753..08222b5e 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -992,9 +992,7 @@ key_state_free(struct key_state *ks, bool clear)
 
     packet_id_free(&ks->crypto_options.packet_id);
 
-#ifdef PLUGIN_DEF_AUTH
     key_state_rm_auth_control_files(ks);
-#endif
 
     if (clear)
     {
-- 
2.26.2


