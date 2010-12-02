Message-ID: <4CF82517.1000601@...1114...>
Date: Fri, 03 Dec 2010 00:00:39 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4CF7B2FA.9090105@...1147...> <4CF7BB67.2040409@...1114...>
	<4CF8168B.8080609@...1147...>
In-Reply-To: <4CF8168B.8080609@...1147...>
Subject: Re: [Openvpn-devel] script-security 1
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
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, OpenVPN Users <openvpn-users@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/12/10 22:58, Jan Just Keijser wrote:
[...snip...]
| I guess the only platform on which '--script-security 0' can do
| something useful is Windows, as the IPAPI calls are "internal", that is,
| they do not require an execve() to initialize things like adapters and
| routes.

That sounds like reasonable conclusion for me as well.

| hmmmm, come to think of it: wouldn't this be a nice feature on Linux/Mac
| OS too, i.e. bring up the tun/tap interface programmatically instead of
| using an external binary? I am not sure how portable it would be though.

Yes, indeed.  And we discussed this on the developers meeting a couple of
weeks ago actually.  There are possibilities to do this via a so called
NETLINK API to the kernel, at least on *BSD and Linux.  For Solaris I don't
know how that would work out.  Anyway the execve() approach would not be torn out.

The NETLINK layer, however, isn't too easy to work with, compared to just
calling external binaries.  Another aspect is that the API is somewhat
different between Linux and *BSD.  I don't know if it's different or how
different it would be between the *BSD flavours (which in theory should cover
OSX as well).  That's not a strong argument, though, as the route and ifconfig
command syntaxes differs between these OSes already.

Another advantage of this, at least in theory on Linux, is that when OpenVPN
is started as root, it should be possible to assign OpenVPN some network
capabilities when dropping privileges.  Capabilities is a kind of ACL on the
kernel layer.  So that means that a nobody:nobody user running openvpn would
be able to modify the routing table and tearing down and setting up the tunnel
device without root privileges.  This is for me a more interesting aspect of
using the NETLINK API.

Implementing NETLINK API will be investigated more for sure.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkz4JRcACgkQDC186MBRfroN1wCeIJo41ksWYaS5EzWkePa1LhEj
TQAAn0y8NzZGi/O318HLlUPJxkRBhYG7
=/8O2
-----END PGP SIGNATURE-----

