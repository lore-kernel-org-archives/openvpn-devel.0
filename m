Date: Tue, 28 Mar 2017 14:58:53 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170328125852.GX93896@...1296...>
References: <1490444478-13188-1-git-send-email-chipitsine@...277...>
	<20170325131746.GC93896@...1296...>
	<5cbc00da-6297-c90a-611c-63ed9b0136a0@...2080...>
	<20170328060459.GM93896@...1296...>
	<CAFHpkQEWMDMs9k=6g3e5a2iMuVWMxP6zzOWZayYyL79r1U7vRg@...278...>
	<20170328065648.GR93896@...1296...>
	<CAFHpkQE9uFNLvTpmoUb3wKadQG4QHyQ6iu1dDsQnRh3hoPGOvA@...278...>
	<1473eddd-c9f1-ddd7-3189-c9e4211c74e9@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="517pCzpsiLFBzq6n"
Content-Disposition: inline
In-Reply-To: <1473eddd-c9f1-ddd7-3189-c9e4211c74e9@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] resolve format string warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--517pCzpsiLFBzq6n
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 28, 2017 at 02:54:03PM +0200, David Sommerseth wrote:
> Gert proposed by a mistake to use uint8_t.  As integers are most
> commonly 32 bits, so uint32_t.  But that may be of a different length on
> some other platforms.  So using 'unsigned int' is most likely the safest
> type in this round.  Or if wanting to be really portability safe, have a
> look at what Simon pointed out, inttypes.h.

"unsigned int" is indeed perfectly correct for "%x"

I was not paying enough attention (and this is why I call for extra
care when doing "just a simple patch to fix a compiler warning", because
more complicated patches usually get more attention...)

Apologies for the noise I caused.  Actually the *first* patch in the
series might have been perfectly fine - need to check ;-)

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--517pCzpsiLFBzq6n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGbBAEBAgAGBQJY2l4MAAoJEB2Cnv7KVigSQTsL939FX4VARrXdwCB9+rEfyf6P
qblNFy6cQh4r9qkcZBE2tWU0Kl3JIwwdAEv7YNmqOZT6oolrBRtO5zEdRy/StpRF
EnH0tAN9kIDAo37TIJyzQ2wKOHn2bX+gp2DVCFJ+c3pESFps/UeIyYY2D9YgTgqY
aY3XWTAjtWDCUyW/eR7v+Qmp8AaEzV0GVHiZtlyRdTepECwOJ8O6zzjfvooUWQaU
B8Wt7wZ69qZdqhAuS6k1kFrinrAuanYoPz0bZebdrbg2zZPbCMZpdHXbJGKNIh1v
OgnFDdvk3tUWlqgWGFs2DjFgtvCztiz5/uKnqem6/dzPKz/6xf4uCEwEthEcAS3T
LT2nGSRoFgKcSLQAWoSXD7eK3GWNuLmbP4aED6E7Pfie5g01bnktVB6zDZJTCv7Q
9toaoxbGGtqHpH84bPTzBFLx4jo6XXlWuqNLSBB8e0U8NfdY/jKK0rRVusj+WrTp
u84tXoZ2y5eMfGOhTDRdIl7lWexMXcL7dQ1LClUU
=qfPD
-----END PGP SIGNATURE-----

--517pCzpsiLFBzq6n--

