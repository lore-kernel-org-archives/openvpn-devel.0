From: Aaron Sethman <androsyn@...45...>
Subject: Re: [Openvpn-devel] tunnelling ipv6 on linux
In-Reply-To: <200210041035.g94AZiY17345@...41...>
Message-ID: <Pine.LNX.4.44.0210071706140.18511-100000@...48...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=openvpn-devel>
Date: Mon Oct  7 14:08:03 2002
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, 4 Oct 2002, James Yonan wrote:

> Hi Aaron,
>
> I've incorporated your IPv6 over tun patch for Linux into the latest OpenVPN beta, and added some basic infrastructure code and a --tun-ipv6 option which enables the IPv6 over tun support.  The option makes a placeholder for all OSes to support IPv6 over tun that is off by default and does not break any existing usage.
>
> Beta is available here and on CVS:
>
> http://openvpn.sourceforge.net/beta/openvpn-1.3.1.6.tar.gz
>
> My IPv6 testing capabilities are limited at this point, so please test.
I've tested between two Linux boxes and it seems to be working perfect at
this point.  I'll give it some more testing and see how it goes.  I'll
also look into testing on a Solaris box, but I'm guessing that will need
some extra help to get working.

Regards,

Aaron


