Message-ID: <52D5A65F.2060807@...1227...>
Date: Tue, 14 Jan 2014 22:04:31 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <20140113185822.GV226@...1296...>
	<52D51737.1040201@...1114...>
In-Reply-To: <52D51737.1040201@...1114...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="NRiKngGLN1vTaNDqBIXvwb8nAxLvt2npr"
Subject: Re: [Openvpn-devel] RFD: <net/route.h> and struct route (trac #340)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NRiKngGLN1vTaNDqBIXvwb8nAxLvt2npr
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

> Generally speaking, I'd prefer as few changes to the 2.3 branch as
> possible.  Try to let it be bugfixes mostly.  This is also to encourage
> users to move over to 2.4 ASAP when that's ready, with more new
> features.  It also helps stability and maintainability within the
> OpenVPN project.
>
> Arne's OpenVPN for Android seems to always have been more experimental
> and bleeding edge than OpenVPN Connect.  So unless Arne screams back at
> me telling me I'm wrong, I believe Arne will be one of the first ones to
> move over to the 2.4/master codebase, thus not making things that
> difficult for him.  But Arne is the one who can fully answer this.  If
> he says it will be more complicated, then let it go into 2.3 too.
I am already on 2.4/master codebase. I might consider tracking
release/2.4 in the future but definitively not release/2.3. (With all
the bugfixes/patches I need/want on Android it would be almost -master
anyway).

I have not really an opinoion about 2.3 and what should go in there. At
the moment it feels like release/2.3 is a "baby" master since almost all
changes are cherry picked into it.

Arne


--NRiKngGLN1vTaNDqBIXvwb8nAxLvt2npr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (Darwin)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLVpl8ACgkQe8+cMNS4zReE4gCfb73fwgUfK8ENuvmwNd0GYKJy
PKYAoNpGeC1WOEp7TS7lk9pa1lirxXsK
=bo4x
-----END PGP SIGNATURE-----

--NRiKngGLN1vTaNDqBIXvwb8nAxLvt2npr--

