From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20030417121516.GA19479@...33...>
References: <20030417085657.GA5962@...33...> <200304171114.h3HBE7121769@...41...>
Mime-Version: 1.0
In-Reply-To: <200304171114.h3HBE7121769@...41...>
Subject: [Openvpn-devel] Re: New beta available + progress update
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Apr 17 05:19:05 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Thu, 17 Apr 2003, James Yonan wrote:

> A better alternative (orginally suggested by you) is to avoid fragmenting in
> the first place by bouncing back ICMP_DEST_UNREACH/ICMP_FRAG_NEEDED to the TUN
> device.  This won't work on TAP devices because the ethernet MTU is fixed at 1500.
> 
> Unfortunately (or fortunately depending on your perspective), my network
> connections are not broken enough to benefit from the FRAGMENT_ENABLE stuff
> just yet, so I can't really test it properly.

Well, the peer that was behind an overloaded 1 Mbps 2 km radio link has
now moved and has become a V.34+ modem link (33k6 bps), with
corresponding effects on the MTU. I wonder if running a local pppd pair
with properly MTU can be used to figure if fragmentation works, but
there's yet have to be someone who drops individual fragments (unless
gremlin mode does it already) for real testing.

OTOH, fragmenting links also have a natural impact on the packet loss:
if you assume 10% packet loss on the transport layer (that transports
the fragment), and you fragment a TAP packet of 1500+ bytes into 3 of
approx 500 bytes (say, MTU=552), the effective packet loss for TCP or
something is much higher: it takes losing a single fragment to
retransmit, so the effective packet loss will come out as 27% (not
taking burst loss into account).

I also have another patch to fix prototype warnings:

diff -u thread.h thread.h
--- thread.h	17 Apr 2003 10:51:21 -0000
+++ thread.h	17 Apr 2003 11:05:38 -0000
@@ -118,17 +118,17 @@
 #define MUTEX_UNLOCK(lock)
 
 static inline void
-thread_init()
+thread_init(void)
 {
 }
 
 static inline void
-thread_cleanup()
+thread_cleanup(void)
 {
 }
 
 static inline int
-thread_number()
+thread_number(void)
 {
   return 0;
 }
@@ -139,7 +139,7 @@
 }
 
 static inline void
-work_thread_join ()
+work_thread_join (void)
 {
 }
 

-- 
Matthias Andree

