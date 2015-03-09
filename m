Date: Mon, 9 Mar 2015 20:02:42 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20150309190242.GF21893@...1296...>
References: <20140827093409.GA659@...1900...> <20150223155132.GA28440@...2018...>
	<20150223161832.GN8134@...1296...>
	<54EB5549.9050108@...1114...> <54EE4F19.1000108@...1856...>
	<CAEW7GUvzbvR1FFSVA86pcY7tM4owucU88xTpLrUybDDCErpnTQ@...278...>
	<20150306184547.GY21893@...1296...>
	<CAEW7GUsx5JrASMJK1EnWaBRUwbv4jMx82-Sh8t=3b5HU73UEhA@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8kI7hWEHMS8Z+7/0"
Content-Disposition: inline
In-Reply-To: <CAEW7GUsx5JrASMJK1EnWaBRUwbv4jMx82-Sh8t=3b5HU73UEhA@...278...>
Subject: Re: [Openvpn-devel] Add support for Keying Material Exporter [RFC
	5705]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: daniel kubec <niel@...1898...>
Cc: openvpn-devel@lists.sourceforge.net

--8kI7hWEHMS8Z+7/0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 09, 2015 at 07:26:28PM +0100, daniel kubec wrote:
> It is actually well defines mechanism for "crypto/authentication"
> plugin developers and they should know what they are doing.
>=20
> Maybe Let's try to discuss that using IRC.

IRC explanation isn't going to help someone who comes across this in=20
a few months or years - a good example in the docs would really be
appreciated.

No code needed.  Just describe the parts that would be needed to make
this work - like "on the server, you need a plugin that talks to
foobar service to get a blinkenlight, on the client, you need a plugin
that uses EKM to make the light blink, via..."

Right now I see crypto that adds code, seems to not break anything, but
the only reason why the extra code is there is "oh, you can do lots of
cool things with it" - this should be spelled out better, to make it
useful to more people.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--8kI7hWEHMS8Z+7/0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVP3uUqkuBuNlUUl1AQLs5wQAs8JRJ+AF75KJevFqhD0MKRhXcEFSf6Lp
cwRVX0dD5u48+/gjz+V1fhqKoN6xIR+pw43r0QCp7UOW8wlLJfTyq3I0McCNfihE
Q4u9SHaQZl06q4idDopJWbFWMLOqvhxFQHawoECty7zUfp7dWa/AhCqWQG5Ucgrk
Y170RmxtaLo=
=Cnu7
-----END PGP SIGNATURE-----

--8kI7hWEHMS8Z+7/0--

