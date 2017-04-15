Date: Sat, 15 Apr 2017 11:16:47 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170415091647.GG30424@...1296...>
References: <20170413172609.29093-1-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EY/WZ/HvNxOox07X"
Content-Disposition: inline
In-Reply-To: <20170413172609.29093-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Fix broken ./configure on systems
 without openssl.pc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--EY/WZ/HvNxOox07X
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 13, 2017 at 07:26:09PM +0200, David Sommerseth wrote:
> +/* Strip out some of the version information we don't care about */
> +#define OSSLVER OPENSSL_VERSION_NUMBER >> 12
> +#if OSSLVER < 0x10001
> +#error OpneSSL too old
> +#endif

While this works (except for the typo) - why not just do full-length math,=
=20
as in

#if OPENSSL_VERSION_NUMBER < 0x10001000L
#error OpneSSL too old
#endif

(note the L prefix, as in the opensslv.h #define)

?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--EY/WZ/HvNxOox07X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJY8eT+AAoJEB2Cnv7KVigSmAIL+wUrx62cIFiCuHxdSvhr1C8X
GTOLoclPb9FRpSXYxMxbk3dsyT0QnzHhipXyPexevY2S7/zB5ji7VXMH1GsW5AJs
TU6a9uYlNJCSJNzNTx0g6BbGxa9zJLzcb2YKGFrPhrpfKaw1BDxHkDee1/px1EhE
bscBJWC3Vh6p9Q2ZUdr54jPqUN32SuIerwGXssoQd+pl4PnVevNfoLxV22eidwlu
rhV9E/ekcjbre7VfleiNVkbKtj/HgeXVX3zemLAGRoSjsxL1wHjlz1IO3uobDQ+s
pq5gJmamJFu5igoZQllTtl0TbvAQb6+DVCuNmNHMuoN03dHExLe5TgyVxnX+QIGW
ajrp2tkJFaeou+ixrWhjHQWA5PSfZ2c56j7j/Qy0NYAI29j0wTBoZdxTJHzVfUrm
1VQqcGXfIao/d3qHtkFOUe9+AO44gF47vjAcQK4mSFEP/NiZKnVbRRffNH6taZnH
2sQL2tSuh0/SSvS6XymATsURs3AfDe9TJ8aILfpGBw==
=1kRL
-----END PGP SIGNATURE-----

--EY/WZ/HvNxOox07X--

