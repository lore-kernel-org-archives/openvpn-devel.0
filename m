Message-ID: <4BC21D82.5070608@...1338...>
Date: Sun, 11 Apr 2010 21:05:38 +0200
From: Fabian Knittel <fabian.knittel@...1338...>
MIME-Version: 1.0
References: <cover.1270060247.git.fabian.knittel@...1338...>	<1ae7a5fdae1e6d71bb7708a4f75ff060e3237c1c.1270060247.git.fabian.knittel@...1338...>	<20100331231158.2782.qmail@...1287...>	<4BB45497.8040707@...1338...>	<4BB46059.9080208@...1147...>
	<20100401091414.24106.qmail@...1287...> <4BB48345.7020408@...1338...>
	<4BB4882E.9020805@...1114...>
In-Reply-To: <4BB4882E.9020805@...1114...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDC0364760EC8D27B095F6A4F"
Subject: Re: [Openvpn-devel] [PATCH 4/9] vlan: Prepend and
 remove	VLAN	identifiers on outgoing and incoming frames
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDC0364760EC8D27B095F6A4F
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

[ I just noticed that I accidentally sent this only to David and not to
  the list. It was written and sent on Thu, 01 Apr 2010 15:46:21 +0200 ]

David Sommerseth wrote:
> But what kind traffic does hit the OpenVPN clients?  Does the OpenVPN
> server send only traffic to the corresponding VLAN the OpenVPN client is
> "assigned" to?  Or does it receive packages for all the VLAN's and does
> the "filtering" on the client side?

The client is unmodified and everything is handled on the server-side.
VLAN handling is transparent for the clients.  They only see packets
belonging to their VLAN and packets sent by them are implicitly assigned
to the VLAN they belong to.

> From a security and not the least from a performance perspective, the
> OpenVPN clients should only receive traffic which hits it's own VLAN
> (ie. the server does the "filtering" before sending data to the client).

I agree.  It also has the nice side-effect for us, that clients don't
need to be upgraded. :)

>  I'm not sure if I saw this in code or not ... but if it is in place and
> somebody could point me to the patch which does it, I would be happy.

I attempt to achieve this in patches 5 and 6. Patch 5 takes care of
unicast traffic and patch 6 takes care of broadcast traffic.


As far I understand it, packets are generally routed based on struct
mroute_addr.  As soon as a client sends a packet to the openvpn server,
the packet's sending address is learned and stored as an mroute_addr.
If a bit-wise comparison of a destination mroute_addr and learned
client's mroute_addr match, the packet is routed to that client.

In tap mode, the addresses of interest are the MAC addresses.  In patch
5 I extend what is stored in the mroute_addr: Instead of only storing
the 6 bytes of the MAC address, I also append the 2 bytes of the VID.
So now a destination MAC address of one VLAN will never match the
destination MAC address of another VLAN, because the mroute_addr fields
never match.

For broadcasting, no mroute_addr comparisons are done, so the change
from patch 5 doesn't help.  For a broadcast, the packet is simply
forwarded to each of the connected clients (unless PF prevents it).
Patch 6 adds a check to the broadcast loop to check whether the sender's
vid and the intended broadcast recipient have a matching vid.  So we now
selectively broadcast based on matching vid.


As I'm not fully familiar with OpenVPN's code base, so I can't be
absolutely sure that patch 5 and 6 catch all cases, but it's what I've
found to be relevant during my tests and code reviews.  I agree with
Peter, that this part is critical for security and should be thoroughly
reviewed.

Cheers
Fabian




--------------enigDC0364760EC8D27B095F6A4F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkvCHYoACgkQARH1aMTipzMM5QCgsMqQo7N5g5sGyiCIkmGbFDxh
a8sAniEKvgef+hAZnuBhJwM5TZGdqIxa
=VOn1
-----END PGP SIGNATURE-----

--------------enigDC0364760EC8D27B095F6A4F--

