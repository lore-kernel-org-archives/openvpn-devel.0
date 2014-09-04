Message-ID: <5408494D.7050407@...1435...>
Date: Thu, 4 Sep 2014 13:13:17 +0200
From: Steffan Karger <steffan.karger@...1435...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000009000000080300040403"
Subject: [Openvpn-devel] [PATCH] Remove quadratic complexity from
	openvpn_base64_decode()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--------------000009000000080300040403
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi,

Attached a patch for a change suggested by Jann Horn, to remove the
quadratic complexity from openvpn_base64_decode().

The suggestion was originally sent to the security list, because
quadratic complexity can potentially lead to a denial-of-service attack
vector. In the current OpenVPN codebase, this is however *not* the case.

OpenVPN doesn't use it's base64 encoding a lot. The only place where a
denial of service could be interesting is when the server uses a
management interface, and an authenticated client sends a malicious
challenge response to the server. Those responses are sent over the TLS
channel, and openvpn limits those messages to 2048 bytes
(TLS_CHANNEL_BUF_SIZE). The old base64 decode code has a complexity of
(n/8)^2 (one strlen over on average half the string length per 4-byte
base64 token), which results in 65536 byte comparisons per message.
That's not enough to be practical for an attack.

That said, I do like the suggestion to make the code constant time. I'd
say it should be applied to both master and 2.3 branches as a bugfix.

-Steffan

--------------000009000000080300040403
Content-Type: text/x-patch;
	name="0001-Remove-quadratic-complexity-from-openvpn_base64_deco.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-Remove-quadratic-complexity-from-openvpn_base64_deco.pa";
	filename*1="tch"

From 488390691137e9a8ea4c2c63db930e2396049934 Mon Sep 17 00:00:00 2001
From: Jann Horn <jann@...1933...>
Date: Wed, 16 Jul 2014 21:55:42 +0200
Subject: [PATCH] Remove quadratic complexity from openvpn_base64_decode()

Every four input characters, openvpn_base64_decode called token_decode,
which in turn called strlen() on the remaining input. This means that
base64 decoding in openvpn had quadratic complexity.

All we really need to know is whether the token is complete, so replace
the check to check just that, and make the complexity linear wrt the
input length.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/base64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/base64.c b/src/openvpn/base64.c
index bb89aae..7dccec2 100644
--- a/src/openvpn/base64.c
+++ b/src/openvpn/base64.c
@@ -110,7 +110,7 @@ token_decode(const char *token)
     int i;
     unsigned int val = 0;
     int marker = 0;
-    if (strlen(token) < 4)
+    if (!token[0] || !token[1] || !token[2] || !token[3])
 	return DECODE_ERROR;
     for (i = 0; i < 4; i++) {
 	val *= 64;
-- 
1.9.1


--------------000009000000080300040403--

