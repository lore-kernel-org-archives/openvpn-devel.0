Date: Thu, 8 Oct 2015 14:32:41 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20151008123241.GA22054@...1296...>
References: <1444156707-14087-1-git-send-email-steffan@...1856...>
	<20151008064333.GR22054@...1296...>
	<56161D90.7040101@...1227...>
	<20151008081119.GW22054@...1296...>
	<CAA1Abx+Cad6b42JHCA-MA1XW_6JBmQCOdUDUxU_1Kyz+H0nE3A@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WVf18ZLo9bznw8Mz"
Content-Disposition: inline
In-Reply-To: <CAA1Abx+Cad6b42JHCA-MA1XW_6JBmQCOdUDUxU_1Kyz+H0nE3A@...278...>
Subject: Re: [Openvpn-devel] [PATCH] openssl: be less verbose about cipher
 translation errors
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

--WVf18ZLo9bznw8Mz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Oct 08, 2015 at 01:55:31PM +0200, Steffan Karger wrote:
> > But what happens in that case?  PolarSSL build, user requests something
> > he knows from OpenSSL, we don't have a translation entry for it - will
> > he receive "the default cipher set" (not what he is asking for) then?
>=20
> What our translation does is "if we know a translation for a cipher,
> then replace with translation, else warn and leave original". The
> resulting cipher string is then passed to the crypto library.  The
> crypto library will then either connect or give a (sometimes cryptic)
> error.  We do this, because we simply can't keep track of all (new, or
> just exotic) cipher names, but do want to offer config compatibility
> for most standard setups between polar<>openssl.

OK, now I understand.  So if a User puts in a polarssl cipher, he might
end up with a (non-useful) warning about "translation not found!" while
polarssl is all happy about it - and if he puts in a totally unknown
OpenSSL cipher, polarssl will refuse it anyway, so no need to have
an extra warning.

This is perfectly fine for me, then - I was just a bit worried about
"unexpected behaviour happening, with no clear warning".

(ACK)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--WVf18ZLo9bznw8Mz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVhZiaakuBuNlUUl1AQKI3AP/WkbB+7RkhM5Em0wVnCGM9BKWG28J7yr3
hJ0xQVLLJwH0QNCnKFHcXunN2TmDCImqCfxYTU6RVEV8OzP+T7Nw7NOTQ2N0AHgR
/P7xY3HCBE34TDAMVwx9Chl0o/yGQoHwlVSSHeTqdoLXq35zPdmFQagTS2CUmIKo
jhgfkqfkcXA=
=UTHG
-----END PGP SIGNATURE-----

--WVf18ZLo9bznw8Mz--

