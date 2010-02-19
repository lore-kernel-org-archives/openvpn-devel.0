Message-ID: <4B7EBE5C.60702@...1114...>
Date: Fri, 19 Feb 2010 17:37:48 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040305090407070908080705"
Subject: [Openvpn-devel] [PATCH] verb 5 logging wrongly reports received
	bytes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------040305090407070908080705
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

With --verb 5, openvpn logs a single letter (rwRW) for each package
received or sent. I recently ran into a problem with the tun device on
Linux where the read from that device returned 0. Unfortunately this was
also logged as "r", which made me assume that openvpn had received
something, while it actually hadn't.

(See https://dev.openwrt.org/ticket/6650 for the bug that made me find out
about this problem with openvpn.)

I'm attaching a patch which prevents openvpn from logging "r" or "R"
when it didn't actually read anything. This is against openvpn 2.1-rc20,
but probably still applies to the most recent version.

This patch was received anonymously via the sf.net bug tracker:
<http://sourceforge.net/tracker/?func=detail&atid=454719&aid=2951003&group_id=48978>

Signed-off-by: David Sommerseth <dazo@...384...>
- ----------------------------------------------------------------------

ACK

Patch looks sensible, and applies cleanly to the master branch.

David S.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkt+vlgACgkQDC186MBRfrpB7gCfTmXPEVEGBD/Yn2UxVqocauNs
GgoAn1NKXihdqr6HnZRfH0DEd4iDBRdG
=nKYU
-----END PGP SIGNATURE-----

--------------040305090407070908080705
Content-Type: text/x-patch;
	name="0001-verb-5-logging-wrongly-reports-received-bytes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-verb-5-logging-wrongly-reports-received-bytes.patch"

From 0827641faed01bb53ec94c996f7a2f5133549b1d Mon Sep 17 00:00:00 2001
From: David Sommerseth <dazo@...384...>
Date: Fri, 19 Feb 2010 17:32:56 +0100
Subject: [PATCH] verb 5 logging wrongly reports received bytes

With --verb 5, openvpn logs a single letter (rwRW) for each package
received or sent. I recently ran into a problem with the tun device on
Linux where the read from that device returned 0. Unfortunately this was
also logged as "r", which made me assume that openvpn had received
something, while it actually hadn't.

(See https://dev.openwrt.org/ticket/6650 for the bug that made me find out
about this problem with openvpn.)

I'm attaching a patch which prevents openvpn from logging "r" or "R" when
it didn't actually read anything. This is against openvpn 2.1-rc20, but
probably still applies to the most recent version.

This patch was received anonymously via the sf.net bug tracker:
<http://sourceforge.net/tracker/?func=detail&atid=454719&aid=2951003&group_id=48978>

Signed-off-by: David Sommerseth <dazo@...384...>
---
 forward.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/forward.c b/forward.c
index 207b876..d563e11 100644
--- a/forward.c
+++ b/forward.c
@@ -755,7 +755,7 @@ process_incoming_link (struct context *c)
 
   /* log incoming packet */
 #ifdef LOG_RW
-  if (c->c2.log_rw)
+  if (c->c2.log_rw && c->c2.buf.len > 0)
     fprintf (stderr, "R");
 #endif
   msg (D_LINK_RW, "%s READ [%d] from %s: %s",
@@ -965,7 +965,7 @@ process_incoming_tun (struct context *c)
     c->c2.tun_read_bytes += c->c2.buf.len;
 
 #ifdef LOG_RW
-  if (c->c2.log_rw)
+  if (c->c2.log_rw && c->c2.buf.len > 0)
     fprintf (stderr, "r");
 #endif
 
-- 
1.6.6


--------------040305090407070908080705--

