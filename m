Message-ID: <4D7C1D05.70408@...1114...>
Date: Sun, 13 Mar 2011 02:25:25 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20110308185252.301d0a1d@...1451...>	<20110309084745.GN9835@...1296...>	<20110309085656.18e0e796@...1451...>
	<20110311122309.1292c1dd@...1451...>	<4D7A7455.4070805@...1114...>	<20110312003517.3a86c508@...1451...>	<20110312153620.8987.qmail@...1287...>
	<20110312184423.3fee2f17@...1451...>
In-Reply-To: <20110312184423.3fee2f17@...1451...>
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
To: Federico Heinz <fheinz@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/03/11 22:44, Federico Heinz wrote:
| On 12/03/2011, Peter Stuge wrote:
[...snip...]
|> [...] unless you are prepared to listen on 0.0.0.0, which I would
|> guess already works without special OpenVPN options or code.
|
| Only... it doesn't work in all setups. As described in shorewall's
| multi-ISP guide[1] (search for "OpenVPN" in that page), sometimes you
| need to bind the daemon to a specific interface.
|
| That guide talks about binding to the interface in order to force
| traffic through a certain ISP (something I hope you will agree can be
| useful under a number of circumstances), but I have found that having
| OpenVPN listen on 0.0.0.0 in such a setup does not work properly:
| connections are unstable and drop for no apparent reason, and
| establishing the tunnel fails intermittently.

As Davide Brini already mentioned, I really wonder if this issue is due to
lack of --multihome in your configuration, combined with listen on 0.0.0.0.

~From the man page:

~       --multihome
~              Configure a multi-homed UDP server.  This  option  can  be  used
~              when  OpenVPN  has  been configured to listen on all interfaces,
~              and will attempt to bind client sessions  to  the  interface  on
~              which  packets are being received, so that outgoing packets will
~              be sent out of the same interface.  Note  that  this  option  is
~              only  relevant for UDP servers and currently is only implemented
~              on Linux.

~              Note: clients connecting to a --multihome server  should  always
~              use the --nobind option.

Can you please test this?


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk18HQUACgkQDC186MBRfrpvQgCgqTw4Iz0xieT6wDjzaiD8jowJ
XiQAn3JB+UgBFSaR9dD4eIexVJodfjXM
=LXsh
-----END PGP SIGNATURE-----

