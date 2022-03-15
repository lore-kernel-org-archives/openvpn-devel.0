Date: Tue, 15 Mar 2022 16:28:28 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YjCwnCXBzFRVUzzn@...1296...>
References: <20220313200715.13518-1-openvpn@...2080...>
 <20220313200715.13518-3-openvpn@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="mn+oimTcHM9R4QBK"
Content-Disposition: inline
In-Reply-To: <20220313200715.13518-3-openvpn@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2.4 v4 2/3] plug-ins: Disallow multiple
 deferred authentication plug-ins
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel@lists.sourceforge.net

--mn+oimTcHM9R4QBK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 13, 2022 at 09:07:14PM +0100, David Sommerseth wrote:
>                  case OPENVPN_PLUGIN_FUNC_DEFERRED:
> -                    deferred =3D true;
> +                    if ((type =3D=3D OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY
> +                        && deferred_auth_done)
> +                    {

As discussed on IRC, a fat finger sneaked into this and stole a bracket.

So, formally, NAK, as I won't change code, except in emergencies (which
this isn't)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--mn+oimTcHM9R4QBK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiMLCcAAoJEB2Cnv7KVigSZN8L/28BltVDzAkCv/hs2plkxDBQ
c5K7VGxFEC7S6uPZkpHy4skGjVw9MbAq0G23A79BnlV5vQNI4z2IT+fWN78GhrNz
XWBO1aA8WZIcWWapWWulcpHjkLXWpTWmQRNRD5Dh0pzzxOi5Nl3rBEYJBO63LvbY
xHGOkmhd5TQaQf6EvVgfhgP7y2nCAR2e7wZ8dSJRFBuymdfzgZCDwDtXVwTG3g/N
1x7HUd39kpO4i7uFeuTN0GsJeG4blUvpapui0ElcgirA4zkUa8PWMeGRN2Nf8Hti
/KlGOsTRTyt5uBNeedGQaok+bZ6T0VisN3GVK0MuB7FDjpx/75SIV159cwmK2G3h
2LW9wQihLDfcNHiWbvAq8Edj2GfEQZGOefxLPBb3ckweo6LBK1yu0GzD6IQrZjeY
mY07H8ZW65BsYhiFlecgCq+WvhQplhJvkNcrm8xx7qC74I6C8LUevKA2sr6ZtMNq
HTtqrGi7dTooV8bzQMa4OampoBSDdPKVuz4dUKKZWQ==
=+rDu
-----END PGP SIGNATURE-----

--mn+oimTcHM9R4QBK--

