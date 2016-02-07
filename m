MIME-Version: 1.0
In-Reply-To: <CACqLfMnrWmytCz9Oz9ES1qsQienJXbxOjGAHydx2RS=5sL=waQ@...278...>
References: <CACqLfMnrWmytCz9Oz9ES1qsQienJXbxOjGAHydx2RS=5sL=waQ@...278...>
From: Leonardo <leobasilio@...277...>
Date: Sun, 7 Feb 2016 16:43:27 -0200
Message-ID: <CACqLfMkwi_Y+jQg4zyivzwyTkPApNVQx6XWYBXiSxBANYC5nOg@...278...>
Subject: [Openvpn-devel] Fwd: [PATCH] Fix misleading socket error code on
	Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi. First of all, this is my first contribution ever to an open source
project. I hope I'm doing this right.

After installing OpenVPN 2.3.10 on my Windows computer and trying to
connect to a VPN server, I was getting this error message:

TCP: connect to [AF_INET]x.x.x.x:80 failed, will try again in 5
seconds: The system tried to join a drive to a directory on a joined
drive.

Hours of googling and no real solution later, I've decided to check
the source code and see if I could find the real cause of this error.
It was a timeout error. Indeed there's a mismapping going on, as
suggested here:

http://sourceforge.net/p/openvpn/mailman/message/33101265/

I have both MinGW-w64 and Visual Studio 2015, and in both headers
WSAETIMEDOUT is defined as ETIMEDOUT which is defined as 138, despite
the online documentation saying that WSAETIMEDOUT should be 10060.

https://msdn.microsoft.com/en-us/library/windows/desktop/ms740668%28v=vs.85%29.aspx

I couldn't find any explanation about this, but based on other
threads, this issue seems to be around for quite some time now. After
the patch below, the right error message comes out:

TCP: connect to [AF_INET]x.x.x.x:80 failed: Connection timed out (WSAETIMEDOUT)

I understand that's not the most elegant solution, but given the above
said, I don't see an alternative. There are many forum threads out
there just because of this misleading error message.


Signed-off-by: Leonardo Basilio <leobasilio@...277...>
---
 src/openvpn/socket.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 396fa54..c01ef3d 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1177,7 +1177,11 @@ openvpn_connect (socket_descriptor_t sd,
         {
           if (--connect_timeout < 0)
         {
+#ifdef WIN32
+          status = 10060;
+#else
           status = ETIMEDOUT;
+#endif
           break;
         }
           openvpn_sleep (1);
--
2.7.0.windows.1

