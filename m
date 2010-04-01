Message-ID: <4BB48A89.3090608@...1338...>
Date: Thu, 01 Apr 2010 13:59:05 +0200
From: Fabian Knittel <fabian.knittel@...1338...>
MIME-Version: 1.0
References: <cover.1270060247.git.fabian.knittel@...1338...>	<4BB3D6A3.7020207@...1114...>	<4BB45A07.5060300@...1338...>
	<4BB45E4B.1000106@...1114...>
In-Reply-To: <4BB45E4B.1000106@...1114...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6C5D635F2C759D9B99D45C24"
Subject: Re: [Openvpn-devel] [RFC][PATCH 0/9] VLAN tagging on TAP devices
 in	OpenVPN server mode
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
--------------enig6C5D635F2C759D9B99D45C24
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

David Sommerseth schrieb:
> On 01/04/10 10:32, Fabian Knittel wrote:
>> We'll definitely be doing that over here.  My main concern was whether
>> we would have to patch OpenVPN indefinitely with local enhancements or
>> whether there was a chance to include it upstream.  And now that things
>> look quite positive, we can go forward with the chosen approach. :)
>=20
> Thanks a lot!  This really will help us a lot.  If you even dare to try
> a local merge against the 'allmerged' branch when you do some bigger
> tests, that would also be very much appreciated.

OK. I assume feat_passtos isn't merged into allmerged yet, right?  I'll
probably pluck Davide Guerri's patch from feat_passtos and do the
testing together with my vlan patches on allmerged. (Assuming things
don't explode too badly on allmerged :).)

> Btw!  How is it with IPv6 and your patches?  We have quite some patches
> for that in the tree already.  And as I see you patch in the [PATCH 1/9]
> the is_ipv4() function, you might want to be sure this will also work in
> the IPv6 world as well.

AFAICS, IPv6 support for tap should only come into the picture when we
attempt to inspect the packets for specific purposes, like packet
filtering or retrieving the packet's priority (TOS in IPv4).  So
although the patches don't yet explicitly handle IPv6, I don't expect
them to conflict with it either...

I'll have a look when I merge to allmerged.  And we'll be testing
autoconfigured IPv6 addresses over tap in our setup, so we'll hopefully
catch obvious problems.


>> Sounds great!  I'll definitely continue polishing the patch-set and
>> continue hitting the vlan code with more tests.
>=20
> Cool!  Please let me know if you patches will go on top of the current
> patch-set you sent, or if you come with a new patch-set based upon the
> feat_passtos branch.

I'd be fine with whatever you would prefer ... If you have no
preferences, I'd probably continue rebasing my internal branch on
feat_passtos until all comments have been worked in and we've completed
our basic tests.  But I can also use a more incremental approach, if
that simplifies your reviewing work or you'd like the existing code to
be visible on openvpn-testing.git.

Cheers
Fabian


--------------enig6C5D635F2C759D9B99D45C24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAku0ipAACgkQARH1aMTipzPYpACfdshZl/1Ue7glrMEGRFN66OeS
r70Anj9/sY3t+0SvNuIkt7Pnu/YTKbE5
=b/vU
-----END PGP SIGNATURE-----

--------------enig6C5D635F2C759D9B99D45C24--

