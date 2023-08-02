From: David Sommerseth <dazo+openvpn@...2108...>
Date: Wed,  2 Aug 2023 13:31:49 +0200
Message-Id: <20230802113149.36497-1-dazo+openvpn@...2108...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] ntlm: Clarify details on NTLM phase 3
 decoding
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
Cc: David Sommerseth <davids@...515...>

From: David Sommerseth <davids@...515...>

The code was very clear if we accept that the base64 decode of the
NTLM challenge was truncated or not.  Move the related code lines
closer to where it first used and comment what we are not concerned
about any truncation.

If the decoded result is truncated, the NTLM server side will reject
our new response to the challenge as it will be incorrect.  The
buffer size fixed and known to be in a cleared state before the
decode starts.

Resolves: TOB-OVPN-14
Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/ntlm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 0cb0a32f..2e772141 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -207,7 +207,6 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2,
      */
 
     char pwbuf[sizeof(p->up.password) * 2]; /* for unicode password */
-    uint8_t buf2[128]; /* decoded reply from proxy */
     uint8_t phase3[464];
 
     uint8_t md4_hash[MD4_DIGEST_LENGTH + 5];
@@ -230,8 +229,6 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2,
 
     bool ntlmv2_enabled = (p->auth_method == HTTP_AUTH_NTLM2);
 
-    CLEAR(buf2);
-
     ASSERT(strlen(p->up.username) > 0);
     ASSERT(strlen(p->up.password) > 0);
 
@@ -264,6 +261,12 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2,
     /* pad to 21 bytes */
     memset(md4_hash + MD4_DIGEST_LENGTH, 0, 5);
 
+    /* If the decoded challenge is shorter than required by the protocol,
+     * the missing bytes will be NULL, as buf2 is known to be zeroed
+     * when this decode happens.
+     */
+    uint8_t buf2[128]; /* decoded reply from proxy */
+    CLEAR(buf2);
     ret_val = openvpn_base64_decode(phase_2, buf2, -1);
     if (ret_val < 0)
     {
-- 
2.39.3


