Resent-To: "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>
Resent-Message-ID: <a8cac38a-2c44-7e51-85d1-3e46c1d89935@...2162...>
From: Steffan Karger <steffan.karger@...1435...>
Date: Tue, 9 May 2017 21:30:08 +0200
Message-ID: <1494358209-4568-2-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1494358209-4568-1-git-send-email-steffan.karger@...1435...>
References: <1494358209-4568-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2 (master)] Don't assert out on receiving
	too-large control packets (CVE-2017-7478)
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
To: security@...515...

Commit 3c1b19e0 changed the maximum size of accepted control channel
packets.  This was needed for crypto negotiation (which is needed for a
nice transition to a new default cipher), but exposed a DoS
vulnerability.  The vulnerability was found during the OpenVPN 2.4 code
audit by Quarkslab (commisioned by OSTIF).

To fix the issue, we should not ASSERT() on external input (in this case
the received packet size), but instead gracefully error out and drop the
invalid packet.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 Changes.rst       | 8 ++++++++
 src/openvpn/ssl.c | 7 ++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Changes.rst b/Changes.rst
index 3dba7e0..734ef73 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -327,3 +327,11 @@ Bugfixes
 --------
 - Fix memory leak introduced in 2.4.1: if --remote-cert-tls is used, we leaked
   some memory on each TLS (re)negotiation.
+
+Security
+--------
+- Fix a pre-authentication denial-of-service attack on both clients and servers.
+  By sending a too-large control packet, OpenVPN 2.4.0 or 2.4.1 can be forced
+  to hit an ASSERT() and stop the process.  If ``--tls-auth`` or ``--tls-crypt``
+  is used, only attackers that have the ``--tls-auth`` or ``--tls-crypt`` key
+  can mount an attack. (OSTIF/Quarkslab audit finding 5.1, CVE-2017-7478)
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index b1f0f6b..4fca283 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3716,7 +3716,12 @@ tls_pre_decrypt(struct tls_multi *multi,
                                 /* Save incoming ciphertext packet to reliable buffer */
                                 struct buffer *in = reliable_get_buf(ks->rec_reliable);
                                 ASSERT(in);
-                                ASSERT(buf_copy(in, buf));
+                                if(!buf_copy(in, buf))
+                                {
+                                    msg(D_MULTI_DROPPED,
+                                        "Incoming control channel packet too big, dropping.");
+                                    goto error;
+                                }
                                 reliable_mark_active_incoming(ks->rec_reliable, in, id, op);
                             }
 
-- 
2.7.4


