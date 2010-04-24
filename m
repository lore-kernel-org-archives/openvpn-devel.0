Message-ID: <4BD2C31D.2090504@...1114...>
Date: Sat, 24 Apr 2010 12:08:29 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1272084868166011500@...1315...>
In-Reply-To: <1272084868166011500@...1315...>
Subject: Re: [Openvpn-devel] Status Message Missing IP Address
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn@...1315...
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 24/04/10 06:54, openvpn@...1315... wrote:
> 
> Hi,
> 
> I have found what seems to be an interesting feature (bug) of the
> management interface – as I have been using it to write a connection
> monitor application.
> 
> Up until recently I have been using the server-bridge command on the
> server, and setting up a bridge (allowing OpenVPN to assign the IP
> address). When I did this the management interface on the client
> reported the IP address that it was assigned (both in real-time or
> manual state commands). However, now I have changed the server
> configuration file to allow the local DHCP server (router) to assign the
> client IP address. While this works fine, and the client connection is
> functional, the management interface no longer reports the client IP
> address.
> 
> Is this a known (or for some reason planned) mode of operation?

Without having looked at the code, I would say this sounds reasonable.
As OpenVPN would not care about which IP address is being used when it
does not provide the IP address itself.  The only reason OpenVPN would
do that is to avoid giving out the same IP address to several clients.
The rest of OpenVPN's task is to pass the traffic coming from the
UDP/TCP port on the Internet side, encrypt/decrypt the data and put it
into the TAP interface (in your case).

Having that said, it can be done some research on how the "learn
address" state is implemented and how that state is used when OpenVPN is
not assigning the VPN IP addresses.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvSwx0ACgkQDC186MBRfrqT8QCfWhQGeVhp6Fm2CjF7jJ46Tdk8
wqcAn09kxxP+efeuZOoUTenph02+zwOW
=BWfu
-----END PGP SIGNATURE-----

