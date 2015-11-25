Date: Wed, 25 Nov 2015 09:26:51 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151125082651.GT24952@...1296...>
References: <564BA6DB.4070703@...2070...>
	<564DE8B3.9030803@...2070...>
	<20151124083944.GY24952@...1296...>
	<5654A314.3080607@...2070...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mb9HKoJ6ED9lkHVp"
Content-Disposition: inline
In-Reply-To: <5654A314.3080607@...2070...>
Subject: Re: [Openvpn-devel] [PATCH v4-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <iam@...2070...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mb9HKoJ6ED9lkHVp
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 24, 2015 at 08:49:08PM +0300, ValdikSS wrote:
> I can't figure out why Thunderbird corrupts my patches.
> Please use the attached version.
> I still need help with 2.3 build system. If somebody willing to help me, =
please use the attached version.

Thanks for the attachments, this should work out nicely.

There is something I'd ask you to change, though - all these new
additions to win32.h are really only needed for the benefit of win32.c
(the DEFINE_GUID stuff), but win32.h is included from a LOT of places
- so it would be much cleaner to have this inside win32.c, and only
export the function prototypes

> +bool win_wfp_block_dns(const NET_IFINDEX index);
> +bool win_wfp_uninit();
> +bool win_wfp_init();

towards users.

Another thing I wonder - why have two functions for _init() and _block_dns(=
),
which in the end is either called both, or not at all.  Couldn't this be
just folded into one function (_block_dns()) which calls _init() internally?

This would reduce the impact on other code paths even further...


Lastly, not all of the new #include files are #ifdef'ed for _WIN32_WINNT=20
- are these all available on XP already, even if the libraries are not?

thanks,

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--mb9HKoJ6ED9lkHVp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVlVwyqkuBuNlUUl1AQJwWAP/QkFak2k/zAUuLwLA5H3UxBG0daeo91N8
WHKXuw96M2ce7NToSOZ8qtb070YvrXHIPKwQlqUbW1rnTssx56VbUpIyjK73cXRK
MznwbKCvARV5S23f328ZjHuc+9dA63riuid5gA2ZzbgUZXlQSncZO0OKOvN5h5zF
KPRrFLIg5lQ=
=0RQ7
-----END PGP SIGNATURE-----

--mb9HKoJ6ED9lkHVp--

