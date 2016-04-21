References: <950C8167-A5FF-4F56-9020-C956EED49557@...2127...>
	<5718879E.8050007@...1227...> <57189BF4.7040400@...515...>
	<5E0364AE-B4E5-45B7-A30D-4CB6C018BF1C@...2127...>
	<20160421180125.GK53051@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <57194638.5060409@...2080...>
Date: Thu, 21 Apr 2016 23:29:28 +0200
MIME-Version: 1.0
In-Reply-To: <20160421180125.GK53051@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="S4ucdriaCsABL0PVeD8C7x9eUH7E68C51"
Subject: Re: [Openvpn-devel] Unit testing in openvpn?
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Jens Neuhalfen <openvpn-devel@...2127...>
Cc: openvpn-devel <Openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--S4ucdriaCsABL0PVeD8C7x9eUH7E68C51
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 21/04/16 20:01, Gert Doering wrote:
> Hi,
>=20
> On Thu, Apr 21, 2016 at 07:40:16PM +0200, Jens Neuhalfen wrote:
>> The first candidate would be the U2F integration that I???d like
>> to write. A proven strategy for starting unit testing is to write
>> tests for all new features. This way the up-front cost is reduced
>> to the invest for ???the first test???.
>=20
> A test driver for the plugin API is actually something which might=20
> work reasonably well as test rig...
>=20

I have started working on a patch set to make it possible to unit test
plug-ins more easily.  But for this to make sense, I need to clean up
the OpenVPN code somewhat so it is possible to base it on much of the
code base already existing in OpenVPN.  That's a good way to also test
the OpenVPN side of the plug-in API.

Now all that sounds easy enough.  Then I realised a massive code
clean-up is needed, as there are some cross-dependencies where the
plug-in unit test framework would suddenly need the full network stack
in OpenVPN (which plug-in code paths never cross - yes socket.c, route.c
and forward.c was needed in my first attempts).  I did come quite a good
step forward on the last hackathon ... unfortunately my work+family
situation have made it hard to hack further on that in a long while.
But I have good hopes to believe I'll be able to spend more time on this
in not very far future.

The reason for looking into a test framework for plug-ins is that we
have some auth-pam patches we've been very cautious with due to lack of
testability.  And many more plug-ins can benefit from such a test
framework too.

> OTOH, testing one-time-passwords in an automated manner sounds
> complicated.

Not really, there are pretty solid TOTP/HOTP libraries which can be
integrated into test frameworks without too much hassle.  You just need
some keying material to be consistent between server side and client
side of the test.  I've already poked into this a few times.


--=20
kind regards,

David Sommerseth


--S4ucdriaCsABL0PVeD8C7x9eUH7E68C51
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlcZRjsACgkQDC186MBRfrof/gCeJk74T5Blr7lvhhHtGjDAHUML
mXoAniSLa/jJW2h5dZgeO8/BeKsdiaDc
=Aowr
-----END PGP SIGNATURE-----

--S4ucdriaCsABL0PVeD8C7x9eUH7E68C51--

