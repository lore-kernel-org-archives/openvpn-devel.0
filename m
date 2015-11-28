From: Steffan Karger <steffan@...1856...>
Date: Sat, 28 Nov 2015 11:38:25 +0100
Message-Id: <1448707105-10753-2-git-send-email-steffan@...1856...>
In-Reply-To: <1448707105-10753-1-git-send-email-steffan@...1856...>
References: <1448707105-10753-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 2/2] Fix rand_bytes return value checking
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

This patch is in response to an off-list report by Sebastian Krahmer of
the SuSE security team.  Sebastian noticed we do not check the return
value of rand_bytes() in prng_bytes(), which we really should.

Failing to check the return value occurs if no prng is used (i.e. in
static key mode, or when explicitly disabled using --prng none).
prng_bytes() is used for generating IVs, session IDs and filenames.

The impact of failing to check the return value seems very limited:

Not generating random file names or session IDs could cause collisions in
(temporary) file names and/or session IDs.  These in turn could cause
availability issues, but would not result in a breach in confidentiality
and/or integrity.

Our CBC mode protocol uses a packet id (timestamp + packet counter in
static key mode, or just the packet counter in TLS mode) at the start of
each packet (by default, but can be disabled using --no-iv and
--no-replay). Because the timestamp and packet counter are not
controllable by an attacker, it is not clear how predictable or even
repeating IVs could be used to mount an attack.  (Note that the fact that
*I* can't find or come up with an attack is not a very strong argument,
this remains somewhat worrisome.)

CFB and OFB modes are not affected, because they do not rely on the prng
for IVS.

Finally, RAND_bytes() actually failing is quite unlikely, as that would
result in all sorts of other problems we should have heard about.

Of course, we still really should fix this, so this patch adds return
value checking of rand_bytes() inside prng_bytes().  The ASSERT() might be
a bit crude, so a follow-up patch that adds a return value to prng_bytes()
and proper return value checking probably makes sense.  But at least this
is a quick and simple fix for the issue at hand.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 1ceb411..c18d88b 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1320,7 +1320,7 @@ prng_bytes (uint8_t *output, int len)
 	}
     }
   else
-    rand_bytes (output, len);
+    ASSERT (rand_bytes (output, len));
 }
 
 /* an analogue to the random() function, but use prng_bytes */
-- 
2.5.0


