Message-Id: <200305112338.h4BNcs119307@...41...>
Subject: Re: [Openvpn-devel] "extended socket error capability" and setting "verb 0"
From: "James Yonan" <jim@...41...>
In-Reply-To: <20030511173347.GA7940@...85...>
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
Date: Sun May 11 16:40:07 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Christof Meerwald <cmeerw@...83...>, openvpn-devel@lists.sourceforge.net

Christof,

Thanks for figuring that one out!

It's definitely a bug, I've been able to reproduce it, and I should have a fix
shortly.

James

Christof Meerwald <cmeerw@...83...> said:

> Hi,
> 
> there is a problem with OpenVPN 1.4.0 (at least on Linux 2.4.20) when
> "EXTENDED_SOCKET_ERROR_CAPABILITY" is enabled and "verb" is set to 0. In
> this case openvpn will consume 100 % CPU in it's select loop when an error
> is reported because select indicates that there is data available on the UDP
> socket, but the data is never read (with recvmsg(..., MSG_ERRQUEUE)) because
> format_extended_socket_error isn't called.
> 
> 
> bye, Christof
> 
> -- 
> http://cmeerw.org                                 JID: cmeerw@...84...
> mailto cmeerw at web.de
> 
> 
> -------------------------------------------------------
> Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
> The only event dedicated to issues related to Linux enterprise solutions
> www.enterpriselinuxforum.com
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 



-- 




