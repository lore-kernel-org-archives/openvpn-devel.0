From: Gert Doering <gert@...1296...>
Date: Tue, 13 Jun 2017 22:08:32 +0200
Message-Id: <20170613200832.15027-1-gert@...1296...>
In-Reply-To: <0d685667-eeef-f798-3b71-5e548f4f646c@...1435...>
References: <0d685667-eeef-f798-3b71-5e548f4f646c@...1435...>
Subject: [Openvpn-devel] [PATCH v2] Fix remotely-triggerable ASSERT() on
 malformed IPv6 packet.
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

Correct sanity checks on IPv6 packet length in mss_fixup_ipv6(),
and change the ASSERT() check in mss_fixup_dowork() into a simple
"return" (= the TCP header will simply not be inspected further).

CVE-2017-7508 has been assigned due to the serious nature of the
bug: it can be used to remotely shutdown an openvpn server or
client, if IPv6 and --mssfix are enabled and the IPv6 networks used
inside the VPN are known.

Found by Guido Vranken <guidovranken@...277...>.

v2: style changes

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/mss.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 51e1ae0..e451350 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -120,8 +120,12 @@ mss_fixup_ipv6(struct buffer *buf, int maxmss)
         return;
     }
 
+    /* skip IPv6 header (40 bytes),
+     * verify remainder is large enough to contain a full TCP header
+     */
     newbuf = *buf;
-    if (buf_advance( &newbuf, 40 ) )
+    if (buf_advance( &newbuf, 40 )
+        && BLEN(&newbuf) >= (int) sizeof(struct openvpn_tcphdr))
     {
         struct openvpn_tcphdr *tc = (struct openvpn_tcphdr *) BPTR(&newbuf);
         if (tc->flags & OPENVPN_TCPH_SYN_MASK)
@@ -145,7 +149,10 @@ mss_fixup_dowork(struct buffer *buf, uint16_t maxmss)
     int accumulate;
     struct openvpn_tcphdr *tc;
 
-    ASSERT(BLEN(buf) >= (int) sizeof(struct openvpn_tcphdr));
+    if (BLEN(buf) < (int) sizeof(struct openvpn_tcphdr))
+    {
+	return;
+    }
 
     verify_align_4(buf);
     tc = (struct openvpn_tcphdr *) BPTR(buf);
-- 
2.10.2



