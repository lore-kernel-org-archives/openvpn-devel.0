Date: Fri, 26 Mar 2021 17:56:38 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210326165638.GY976@...1296...>
References: <20210326160545.26836-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="UJCP3JuDDRMx4b/m"
Content-Disposition: inline
In-Reply-To: <20210326160545.26836-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] Always disable TLS renegotiations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--UJCP3JuDDRMx4b/m
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Mar 26, 2021 at 05:05:45PM +0100, Arne Schwabe wrote:
> +    /* Disable TLS renegotiations. OpenVPN's renegotiation creates new S=
SL
> +     * session and does not depend on this feature. And TLS renegotiatio=
ns have
> +     * been problematic in the past */
> +    sslopt |=3D SSL_OP_NO_RENEGOTIATION;

Unfortunately this seems to be not available in OpenSSL 1.0.2, which
is what the OS ships on FreeBSD 11.4 (which is still supported).

../../../openvpn/src/openvpn/ssl_openssl.c:326:15: error: use of undeclared=
 identifier
      'SSL_OP_NO_RENEGOTIATION'
    sslopt |=3D SSL_OP_NO_RENEGOTIATION;

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--UJCP3JuDDRMx4b/m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgXhJFAAoJEB2Cnv7KVigSlekL/AhHM6/WvYI0P+lzeupR1J5F
OZd50EyLLFDoJjInmGC0vlupAvRbo4/8cnxntg2jCEf/Hfk7L2MmxCqsc4BHEj6V
yVqMuTUFECgCStTE6BQrcPnLhfm0rR+6yAPaU4UxTcaj9jK6opdmtZ40a+5F5vmn
ZUbtxsgp3SpQdIhB7OXEjazGSt7L0bubIQWCIarpSBg2Z5nGMwJ2/uUoFo9DoVVv
kSGDEyFlA5/RqnU6Z5sOm1Nn0l/7gEF3zhllE4KDC9kkz7aIhKIE6kSWlVtTv30v
CgDQ+uRFcFbJzoBb6ZGTpQdK6QNZBWJZBaMe58JyphqASntnY98wMS4GtAQAHWDi
hK4EkMl2m6gg6ZmxUXMvvUnZt/GRZ/m0x0t0dgrAk/lwm0R2+pL8wW1ScR1GDWTh
OwLE3mTM8TYTv62a+dtLTD19XK1fBwf71sCqMQ61cbgzXnXwhso+2WzCJYC/HAFE
Sg42q3cqXBxdKys2Wfcj7hEkfX9ZoIJ2vZDBLgYBNQ==
=dFIK
-----END PGP SIGNATURE-----

--UJCP3JuDDRMx4b/m--

