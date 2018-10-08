From: Lev Stipakov <lstipakov@...277...>
Date: Mon,  8 Oct 2018 17:19:26 +0300
Message-Id: <1539008366-19656-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] crypto.h: remove unused function declaration
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

From: Lev Stipakov <lev@...515...>

This removes declaration of function which has no definition and usage.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/crypto.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index f4b3dca..263725d 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -278,11 +278,6 @@ void read_key_file(struct key2 *key2, const char *file, const unsigned int flags
  */
 int write_key_file(const int nkeys, const char *filename);
 
-int read_passphrase_hash(const char *passphrase_file,
-                         const md_kt_t *digest,
-                         uint8_t *output,
-                         int len);
-
 void generate_key_random(struct key *key, const struct key_type *kt);
 
 void check_replay_consistency(const struct key_type *kt, bool packet_id);
-- 
2.7.4


