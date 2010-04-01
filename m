Message-ID: <4BB45A07.5060300@...1338...>
Date: Thu, 01 Apr 2010 10:32:07 +0200
From: Fabian Knittel <fabian.knittel@...1338...>
MIME-Version: 1.0
References: <cover.1270060247.git.fabian.knittel@...1338...>
	<4BB3D6A3.7020207@...1114...>
In-Reply-To: <4BB3D6A3.7020207@...1114...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDD785DD2577168013DA33486"
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
--------------enigDD785DD2577168013DA33486
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi David,

David Sommerseth schrieb:
> Thank you very much for your patches!  I'll look into them soon.

Thanks!

> The
> patches seems to apply nicely against the feat_passtos branch.  I was
> worried about a conflict here, until I noticed where you had your roots :)

Actually, I was lucky to notice the openvpn-unstable.git repo before
submission.  My original patch-set was based on the subversion repo
branch beta21 and would have conflicted with feat_passtos.  I didn't
notice the git repo and the Wiki on secure-computing.net until I
happened to look at some openvpn-devel mails in the archive.  Does
openvpn.net link to them from somewhere?


> One thing, it would be good if you would do your commit with -s
> (--signoff).  We've not been strict about this so far, but I would like
> to see those sign-off messages.  (I'll make sure the developers
> documentation is 'up-to-date' in this matter, as I don't think that's
> mentioned now).

Will do.

>> Another question would be whether I should turn the feature into a compi=
le-time
>> selectable option.
>=20
> It's been several discussions about if such features should be #ifdef'ed
> or not.  The general consensus of the discussions is that it will most
> probably be accepted into a stable tree in the future quicker if it is a
> compile-time enablement.
>=20
> The main argument which I find acceptable, is that if a stability and/or
> security issue is found, it would be possible to easily disable all
> features and disable them one-by-one to find the offending feature.

I'll add the necessary #ifdefs and such.


> If you could do a bit more testing, also some stress/performance testing
> with several VLAN's being tested in parallel, that would be beneficial.

We'll definitely be doing that over here.  My main concern was whether
we would have to patch OpenVPN indefinitely with local enhancements or
whether there was a chance to include it upstream.  And now that things
look quite positive, we can go forward with the chosen approach. :)

> Having all this said, the feature itself seems reasonable for me to
> include into OpenVPN, so the missing step is just to mature the code to
> be sure we don't cause any regression.  And here some stress/performance
> testing will be helpful.  You scare at least me when stating that this
> code "was originally only intended as a proof of concept", which is why
> I'm not signing off these patches immediately and giving you a feature
> branch.  But I'm open for full inclusion!

Sounds great!  I'll definitely continue polishing the patch-set and
continue hitting the vlan code with more tests.


> And keep us updated on the progress with your patches!

Will do. :)

Cheers
Fabian




--------------enigDD785DD2577168013DA33486
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAku0WgcACgkQARH1aMTipzNgtgCeO33u7vYr3Da+KAb2+Zr+66Os
Aw0AoKJiN9jMhvDHKhHCogMDLbqmWWrJ
=yf8t
-----END PGP SIGNATURE-----

--------------enigDD785DD2577168013DA33486--

