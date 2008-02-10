Date: Sun, 10 Feb 2008 00:09:06 -0800 (PST)
From: Matti Linnanvuori <mattilinnanvuori@...109...>
MIME-Version: 1.0
Message-ID: <280428.48359.qm@...1079...>
Subject: [Openvpn-devel] [patch] manual page tcp-queue-limit
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

--- openvpn.8.orig 2008-02-10 09:56:33.741203500 +0200
+++ openvpn.8 2008-02-10 10:02:45.313124500 +0200
@@ -2595,13 +2595,13 @@
 .\"*********************************************************
 .TP
 .B --tcp-queue-limit n
-Maximum number of queued TCP output packets (default=64).
+Maximum number of output packets queued before TCP (default=64).
 
 When OpenVPN is tunneling data from a TUN/TAP device to a
 remote client over a TCP connection, it is possible that the TUN/TAP device
 might produce data at a faster rate than the TCP connection
-can support.  When the number of queued TCP output packets reaches
-this limit for a given client connection,
+can support.  When the number of output packets queued before sending to
+the TCP socket reaches this limit for a given client connection,
 OpenVPN will start to drop outgoing packets directed
 at this client.
 .\"*********************************************************


      ____________________________________________________________________________________
Never miss a thing.  Make Yahoo your home page. 
http://www.yahoo.com/r/hs

