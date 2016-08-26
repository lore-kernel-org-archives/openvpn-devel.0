Date: Fri, 26 Aug 2016 14:06:59 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160826120659.GW78279@...1296...>
References: <efe4c17a-1d4d-d20f-cc77-cf7564ea1184@...2080...>
	<CAA1AbxK5kCi5_NzeggKNt7+oLCvacMCEG0X4UwWqbzRKraTV=Q@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iq4NytuvSVzaNT9H"
Content-Disposition: inline
In-Reply-To: <CAA1AbxK5kCi5_NzeggKNt7+oLCvacMCEG0X4UwWqbzRKraTV=Q@...278...>
Subject: Re: [Openvpn-devel] [RFC] - Enable 2FA to be used with
	renegotiations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--iq4NytuvSVzaNT9H
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 26, 2016 at 12:21:50AM +0200, Steffan Karger wrote:
> One thing I think might be useful is a timeout that forces a client to
> do a full reauth.  I can imagine a company policy that, for example,
> requires users to perform a 2FA at least every 4 hours.  I'd want to
> implement such a policy without stretching the default 1 hour
> renegotiate to 4 hours.  But that might also be too much of a corner
> case which is not worth the extra code...

You just beat me to typing this :-) - right now, our corporate VPN uses
--reneg-sec 28800, because corporate policy says "2FA sessions must be
reauthenticated every 8 hours".

So, with the auth token stuff (which I find immensely amazing :-) ), we
could renegotiate much more often, but then we'd violate policy - so
"generate tokens that are valid for <n> hours" would be a very helpful
addition here.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--iq4NytuvSVzaNT9H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV8Aw4qkuBuNlUUl1AQJPVAQApQszOSAyoz6O803wRmaFjKRQS7CpGapj
9lZM4bfYgZw+lxkKYMyeu6vOljvAQgIj4YRrfy0VfxbO9vKkMkdmyMtvTVLZnunW
yUaxC2A56i1Zth8ZzpEI80P/w00f2T+9CrPllE5Hw4YCE1KzyI2agklyXO3BgZEW
syh20+aORNw=
=Sq+F
-----END PGP SIGNATURE-----

--iq4NytuvSVzaNT9H--

