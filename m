From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] logging remote ip disconnection
In-Reply-To: <68c5481e04092002491ec7e3aa@...278...>
Message-ID: <Pine.LNX.4.58.0409201122540.18881@...269...>
References: <68c5481e04092002491ec7e3aa@...278...>
MIME-Version: 1.0
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
Date: Mon Sep 20 10:29:01 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Kisero <kisero@...277...>
Cc: openvpn-devel@lists.sourceforge.net


On Mon, 20 Sep 2004, Kisero wrote:

> Hi, ive send two mails already and no answere..if imasking something
> wrong just tell me :)
> 
> i need to know when a remote ip address disconnect..i could not find
> anything on the man, or raising the verb level , or nothing. so i
> start looking at the source code to get a patch for myselfe..im not
> goot at alllll in #c , so maybe someone can help me out with this...
> :)
> 
> i saw that in socket.c at line 1128 you got a msg to the log
> 
> msg (D_CLOSE, "TCP/UDP: Closing socket");
> 
> when the peer goes down...
> 
> the function wich calls that,  gets "link_socket_close (struct
> link_socket *sock)" as a paramter, in the link_socket structure ,
> there is a memeber wich is another struct called "struct sockaddr_in"
> wich i think has the src ip address of the end point vpn wich is
> closing the socket.
> 
> but i couldnt make it work...
> does anyone have any idea? i dont knwo what else to do really.
> thanks a lot

When a remote address disconnects, the behavior is somewhat different 
depending on whether OpenVPN is running in TCP or UDP mode.  In TCP mode 
there is an explicit connection reset.  In UDP mode, because UDP is 
connectionless, the disconnection occurs due to a ping timeout, which can 
be controlled by inactive or ping and ping-restart/ping-exit.

If you want to run custom code when a client disconnects, you might take a 
look at the "client-disconnect" script directive.

James

