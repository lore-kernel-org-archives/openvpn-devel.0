From: William Preston <openvpn@...275...>
Subject: Re: [Openvpn-devel] NTLM proxy problem.
References: <44294D0A.208@...101...>
In-Reply-To: <44294D0A.208@...101...>
MIME-Version: 1.0
Message-Id: <200604011802.56973.openvpn@...275...>
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
Date: Sat Apr  1 08:05:04 2006
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Tuesday 28 March 2006 16:49, inode wrote:
> I'm doing some test with openvpn, and I saw some problem using NTLM auth
> proxy.
>
> I tested the software on a ISA server and all work fine, the problem is
> using a squid proxy with NTLM.
>

I only tested NTLM against Microsoft ISA Server.

> - NTLM domain, actualy on openvpn config file the user can't set the
> domain of the credentials sent to the proxy. An Microsoft ISA server
> will have a "default domain" to try the authentication, but that doesn't
> mean that "default domain" will be the right one... Also on squid the
> domain is required and a null domain will be refused.

OK, fair enough :-)

can you let me know exactly how you compiled the NTLM support into
Squid so that I can reproduce this.  Are you linking against SaMBa - and if
so then which version?

thanks,


William


