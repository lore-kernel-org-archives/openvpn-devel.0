Message-ID: <68c5481e04092002487a4ee75f@...278...>
From: Kisero <kisero@...277...>
Reply-To: Kisero <kisero@...277...>
Mime-Version: 1.0
Subject: [Openvpn-devel] logging remote peer disconnection
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
Date: Mon Sep 20 02:50:29 2004
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi, ive send two mails already and no answere..if imasking something
wrong just tell me :)

i need to know when a remote ip address disconnect..i could not find
anything on the man, or raising the verb level , or nothing. so i
start looking at the source code to get a patch for myselfe..im not
goot at alllll in #c , so maybe someone can help me out with this...
:)

i saw that in socket.c at line 1128 you got a msg to the log

msg (D_CLOSE, "TCP/UDP: Closing socket");

when the peer goes down...

the function wich calls that,  gets "link_socket_close (struct
link_socket *sock)" as a paramter, in the link_socket structure ,
there is a memeber wich is another struct called "struct sockaddr_in"
wich i think has the src ip address of the end point vpn wich is
closing the socket.

but i couldnt make it work...
does anyone have any idea? i dont knwo what else to do really.
thanks a lot

