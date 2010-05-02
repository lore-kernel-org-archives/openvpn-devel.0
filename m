From: Davide Brini <dave_br@...1278...>
Date: Sun,  2 May 2010 12:07:38 +0100
Message-Id: <1272798458-1175-1-git-send-email-dave_br@...1278...>
In-Reply-To: <201005011842.30097.dave_br@...1278...>
References: <201005011842.30097.dave_br@...1278...>
Subject: [Openvpn-devel] [PATCH] Exclude ping and control packets from
	activity
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

Problem: using --ping and --inactive together partially defeats the
point of using --inactive as periodic ping packets are counted as
activity. Here is the original discussion:

http://article.gmane.org/gmane.network.openvpn.devel/3676

It turns out that "activity" is detected and recorded in two places
in the code, both in forward.c: in process_outgoing_tun() for received
packets, after they've been decrypted and sent to the TUN device; and
in process_outgoing_link(), after they've been encrypted and written
to the network socket.

In the first case we can be sure that packets that get so far are
really due to user activity, whereas in the second case there can be
non-user packets (like OpenVPN's internal ping packets, and TLS control
packets), and those should not be counted as activity as they are not
coming from the user.

So a need arises to detect those control packets and not count them as
activity for the purposes of --inactive. Unfortunately, at that stage
packets are already compressed and encrypted, so it's not possible to
look into them to see what they are. However, there seems to be a
convention in the code that packets whose buffer length in the context_2
structure is 0 should be ignored for certain purposes. TLS control
packets follow that convention already, so this patch makes a small
change in the code that generates the ping packets to set their buffer
length to 0 as well.
Finally, the call to register_activity() in process_outgoing_link() is
made conditional to the buffer length being > 0.

According to my tests, now --inactive behaves correctly according to
the configured parameters (time or time+bytes) even when --ping is
being used.

forward.c:
    Call register_activity() in process_outgoing_link() only if the
    packet is not a ping or TLS control packet.

openvpn.8:
    Updated the description of --inactive to describe the new semantics.

ping.c:
    Set c->c2.buf.len = 0 after the ping packet has been generated and
    encrypted.

Signed-off-by: Davide Brini <dave_br@...1278...>
---
 forward.c |    5 +++--
 openvpn.8 |   20 +++++++++++++++-----
 ping.c    |    2 ++
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/forward.c b/forward.c
index 752a566..0f76316 100644
--- a/forward.c
+++ b/forward.c
@@ -1157,8 +1157,9 @@ process_outgoing_link (struct context *c)
 		 size);
 	}
 
-      /* indicate activity regarding --inactive parameter */
-      register_activity (c, size);
+      /* if not a ping/control message, indicate activity regarding --inactive parameter */
+      if (c->c2.buf.len > 0 )
+        register_activity (c, size);
     }
   else
     {
diff --git a/openvpn.8 b/openvpn.8
index a29ad29..51bbc68 100644
--- a/openvpn.8
+++ b/openvpn.8
@@ -1352,15 +1352,25 @@ to be between 100 bytes/sec and 100 Mbytes/sec.
 .B --inactive n [bytes]
 Causes OpenVPN to exit after
 .B n
-seconds of inactivity on the TUN/TAP device.  The time length
-of inactivity is measured since the last incoming tunnel packet.
+seconds of inactivity on the TUN/TAP device. The time length of
+inactivity is measured since the last incoming or outgoing tunnel
+packet. 
 
 If the optional
 .B bytes
 parameter is included,
-exit after n seconds of activity on tun/tap device
-produces a combined in/out byte count that is less than
-.B bytes.
+exit if less than 
+.B bytes
+of combined in/out traffic are produced on the tun/tap device
+in 
+.B n 
+seconds.
+
+In any case, OpenVPN's internal ping packets (which are just
+keepalives) and TLS control packets are not considered
+"activity", nor are they counted as traffic, as they are used
+internally by OpenVPN and are not an indication of actual user
+activity.
 .\"*********************************************************
 .TP
 .B --ping n
diff --git a/ping.c b/ping.c
index b29927d..191ad74 100644
--- a/ping.c
+++ b/ping.c
@@ -86,5 +86,7 @@ check_ping_send_dowork (struct context *c)
    * encrypt, sign, etc.
    */
   encrypt_sign (c, true);
+  /* Set length to 0, so it won't be counted as activity */
+  c->c2.buf.len = 0;
   dmsg (D_PING, "SENT PING");
 } 
-- 
1.6.5.6


