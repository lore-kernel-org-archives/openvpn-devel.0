Message-ID: <20040216221919.GA2697@...85...>
References: <20040130120412.GA12576@...85...> <20040203222308.GA7843@...85...>
Mime-Version: 1.0
In-Reply-To: <20040203222308.GA7843@...85...>
From: Christof Meerwald <cmeerw@...83...>
Subject: [Openvpn-devel] Re: Socks proxy support for OpenVPN 1.5.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Feb 16 14:27:59 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Tue, 3 Feb 2004 23:23:08 +0100, Christof Meerwald wrote:
> On Fri, 30 Jan 2004 13:04:12 +0100, Christof Meerwald wrote:
>> I have added support for Socks5 proxies to OpenVPN 1.5.0. It should work for
>> TCP and UDP client modes (but I have only tested it in UDP client mode yet,
>> because that's what I plan to use).
> UDP packets might be truncated because the Socks server adds a 10-byte
> header to them - here is a patch (against 1.6 beta5) to fix it.

And here is the fix for the Win32 version:

diff -ur openvpn-1.6_beta6.orig/socket.c openvpn-1.6_beta6/socket.c
--- openvpn-1.6_beta6.orig/socket.c	Wed Feb 04 00:58:24 2004
+++ openvpn-1.6_beta6/socket.c	Mon Feb 16 21:38:56 2004
@@ -1364,6 +1364,9 @@
       wsabuf[0].len = maxsize ? maxsize : BLEN (&sock->reads.buf);
       ASSERT (wsabuf[0].len <= BLEN (&sock->reads.buf));
 
+      if (sock->proto == PROTO_UDPv4 && sock->socks_proxy)
+	wsabuf[0].len += 10;
+
       /* the overlapped read will signal this event on I/O completion */
       ASSERT (ResetEvent (sock->reads.overlapped.hEvent));
       sock->reads.flags = 0;


bye, Christof

-- 
http://cmeerw.org                                 JID: cmeerw@...84...
mailto cmeerw at web.de

