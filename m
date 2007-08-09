Sender: marko@...1042...
Date: 09 Aug 2007 17:01:11 +0300
Message-ID: <m3k5s4remw.fsf@...1043...>
MIME-Version: 1.0
From: Marko Rauhamaa <marko@...1042...>
Subject: [Openvpn-devel] Memory accumulation problem
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net


In openvpn-2.0.9 socket_connect() (socket.c), print_sockaddr()
consumes memory without bounds if the server is permanently down or
unreachable becauses gc_free() is not called from within the loop.

Memory is consumed at 72 bytes every 5 seconds or 1.2 megabytes for each
24 hours (plus malloc overhead). That's enough to bring my openwrt box
to its knees within a week or so.

Proposed solution (untested):

       msg (D_LINK_ERRORS | M_ERRNO_SOCK,
 	   "TCP: connect to %s failed, will try again in %d seconds",
 	   print_sockaddr (remote, &gc),
 	   connect_retry_seconds);
+      gc_free (&gc);
+      gc = gc_new ();


Marko

-- 
Marko Rauhamaa      mailto:marko@...1042...     http://pacujo.net/marko/

