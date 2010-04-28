Message-ID: <4BD7F030.6090604@...1338...>
Date: Wed, 28 Apr 2010 10:22:08 +0200
From: Fabian Knittel <fabian.knittel@...1338...>
MIME-Version: 1.0
References: <4BC330A0.5000209@...1338...> <4BD75D96.2050402@...1114...>
In-Reply-To: <4BD75D96.2050402@...1114...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig31D4059D6EB48BA68FC7336A"
Subject: Re: [Openvpn-devel] [PULL-REQUEST v3] VLAN-Tagging
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig31D4059D6EB48BA68FC7336A
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi David,

David Sommerseth wrote:
> I've finally found some time to dig into this again.  After some
> consideration, I decided to rebase your work on your feat_vlan_tagging
> branch against the openvpn-testing.git feat_vlan_tagging branch.
>=20
> This means that your earlier patches without signed-off-by tags are not
                                       ^^^^^^^--- with?
> merged in.  I am fine with that, as I've become stricter on those tags
> later on.
>=20
> The alternative is to scratch the feat_vlan_tagging branch now in
> openvpn-testing.git and re-establish it on your feat_vlan branch, which
> has those tags all from the beginning.
>=20
> So I will leave it up to you now how you want it.  But in the moment I
> this branch gets merged into allmerged, its too late to change your
> opinion.  I will wait for your reply on which approach you would like.

If I may choose freely, I'd prefer the fresh patch-set that has the
proper signed-of-by lines.  But I'm fine with both approaches.

I'll do all future changes incrementally so that this decision doesn't
come up again. :)

> When this is settled, the only missing thing is to get someone who can
> understand the code path being changed in your feature branch a bit
> better than me to give an official ACK.  When I get that ACK, it goes
> into allmerged.

Sounds great!

Cheers
Fabian


--------------enig31D4059D6EB48BA68FC7336A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkvX8DgACgkQARH1aMTipzNJJgCgpL2zyTmSjTvpqI+9rKaurisd
MQQAoMfc7oZU3BKgy+4Pf9F8PzSdv6jK
=2pAL
-----END PGP SIGNATURE-----

--------------enig31D4059D6EB48BA68FC7336A--

