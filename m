Date: Wed, 9 Mar 2011 11:54:20 -0300
From: Federico Heinz <fheinz@...277...>
Message-ID: <20110309115420.6785189b@...1451...>
In-Reply-To: <4D778661.9060709@...1432...>
References: <20110308185252.301d0a1d@...1451...>
	<AANLkTi=FFxhdD5avAov9F8giPr-a_A=9Hzf3+Prm4p0V@...278...>
	<20110308210525.7d75f081@...1451...>
	<4D774565.7080507@...1114...>
	<4D778661.9060709@...1432...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Bind only to specified interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Markus =?ISO-8859-1?B?S/Z0dGVy?= <koetter@...1432...>
Cc: openvpn-devel@lists.sourceforge.net

On 09/03/2011, Markus K=F6tter wrote:
> David Sommerseth wrote:
> > One is that you do resolve the IP address based on the device
> > name.  What if the IP address changes on that device?  It would
> > be anticipated by most users that it would then listen to the new
> > IP address.  When being done via the command line, it is much
> > more obvious OpenVPN needs to be restarted on an IP address
> > change.
> You do not want to get into supporting changing addresses, really.
> While libnl would work for linux, but that does not cover bsds or=20
> anything else.

Agreed!

> To do this properly ...
> Either use SO_BINDTODEVICE, which is not portable again, or
> getifaddrs() to gather the addresses for the interface and
> multi-listen the daemon - which is not implemented.
> Neither getifaddrs nor SO_BINDTODEVICE are 100% portable, so there
> is no real proper way, nevertheless getifaddrs would be my choice.

I agree that getifaddrs() would be a better way of doing this *if*
the deamon knew how to multi-listen (or, to put it in another way,
*when* the daemon lerns to).

While I am willing to revise the code to use getifaddr() if that will
make it more palatable to the project, the current approach does work
and seems to me to be more portable.

	Fede

