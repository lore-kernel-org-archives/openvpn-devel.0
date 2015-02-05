Date: Thu, 5 Feb 2015 23:08:36 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20150205220835.GT8134@...1296...>
References: <CAB7qsSN2BzxzuY2hfqE59U+5dw4+wdGGOfUrXRQ4YmoMwAt4Mw@...278...>
	<54D34AA7.4030902@...1114...>
	<CAB7qsSN2+FiBwXb-e+uez+vvCUqngWEQ2k-8-C0qN4XHHrNn=w@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIW0mBdZQbss59/X"
Content-Disposition: inline
In-Reply-To: <CAB7qsSN2+FiBwXb-e+uez+vvCUqngWEQ2k-8-C0qN4XHHrNn=w@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix CN maximum length
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jorge Luiz Silva Peixoto <jorge.peixoto@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--WIW0mBdZQbss59/X
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi

On Thu, Feb 05, 2015 at 06:15:21PM -0300, Jorge Luiz Silva Peixoto wrote:
> > 64 characters according to some specs, but needs to be 65 to allow NULL
> > termination?  I'm speculating here ... so if I'm right I'd appreciate an
> > update to the comment above if it includes NULL termination or not.
>=20
> OK. Do I send this patch again to the list? Comment updated below.

Yes, please.  (Please mark as "patch v2").

>  /** Maximum length of common name (rfc5280) + null character byte */
> -#define TLS_USERNAME_LEN 64
> +#define TLS_USERNAME_LEN 65

NAK on this approach, see my other mail.

If this is the length, it should be the length - and if we need extra
space in the buffer, the buffer should have the "+1", and not all the
other stuff that want the real length a "-1".

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--WIW0mBdZQbss59/X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVNPp46kuBuNlUUl1AQKXrwQAkxejcm1bCbhzKBETd22BOxsS78vaEwpB
KCwBhKWuRL3asr4IpMQI54qvOTqQ9FiddShUDa7yVkdJHKRZ2ZPgjmtF8udKet9Q
Y826s62JeUdthlDhPHMHjo2qTkkmC91ttRxPyEyYmmedO3HFy4bweVqwPcCbRiZ3
zgAx+1oUFcQ=
=YS4f
-----END PGP SIGNATURE-----

--WIW0mBdZQbss59/X--

