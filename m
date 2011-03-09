Message-ID: <4D778661.9060709@...1432...>
Date: Wed, 09 Mar 2011 14:53:37 +0100
From: =?ISO-8859-1?Q?Markus_K=F6tter?=
 <koetter@...1432...>
MIME-Version: 1.0
References: <20110308185252.301d0a1d@...1451...>	<AANLkTi=FFxhdD5avAov9F8giPr-a_A=9Hzf3+Prm4p0V@...278...>	<20110308210525.7d75f081@...1451...>
	<4D774565.7080507@...1114...>
In-Reply-To: <4D774565.7080507@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Bind only to specified interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

any reason this list does not send a proper reply-to-list?

David Sommerseth wrote:
> One is that you do resolve the IP address based on the device name.  What if
> the IP address changes on that device?  It would be anticipated by most users
> that it would then listen to the new IP address.  When being done via the
> command line, it is much more obvious OpenVPN needs to be restarted on an IP
> address change.

You do not want to get into supporting changing addresses, really.
While libnl would work for linux, but that does not cover bsds or 
anything else.

> In fact, I wonder if it is even possible to
> assign multiple IPv4 addresses using iproute2 to a device without aliases.  It
> might be something similar in *BSD as well.  Your patch does not cover this
> scenario at all.

This is possible, one can have more than one IPv4 address per interface 
on linux using iproute2 easily.
To do this properly ...
Either use SO_BINDTODEVICE, which is not portable again, or getifaddrs() 
to gather the addresses for the interface and multi-listen the daemon - 
  which is not implemented.
Neither getifaddrs nor SO_BINDTODEVICE are 100% portable, so there is no 
real proper way, nevertheless getifaddrs would be my choice.


So besides from all mentioned points, even the approach to get the 
address is wrong.

Markus

