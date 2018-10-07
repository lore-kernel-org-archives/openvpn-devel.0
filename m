Date: Sun, 7 Oct 2018 15:01:23 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20181007130123.GD962@...1296...>
References: <1533722327-5228-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="cqF3yV8I+FsmjbWd"
Content-Disposition: inline
In-Reply-To: <1533722327-5228-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Don't print OCC warnings about
 'key-method', 'keydir' and 'tls-auth'
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

--cqF3yV8I+FsmjbWd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 08, 2018 at 11:58:47AM +0200, Steffan Karger wrote:
> Like 'proto', a mismatch in key-method, keydir or tls-auth would fail
> before we ever get to the point where we can print this warning.
>=20
> This prepares for removing these from the occ string later on, but also
> prepares for tls-crypt-v2, which allows a server to support tls-auth and
> tls-crypt-v2 connections in parallel.  Such a server will send 'keydir'
> and 'tls-auth' in the occ string.  This change removes the spurious
> warnings about that in the client log.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>

ACK on the feature, NAK on the implementation...

> @@ -3790,11 +3790,14 @@ options_warning_safe_scan2(const int msglevel,
>                             const char *b1_name,
>                             const char *b2_name)
>  {
> -    /* we will stop sending 'proto xxx' in OCC in a future version
> -     * (because it's not useful), and to reduce questions when
> -     * interoperating, we start not-printing a warning about it today
> +    /* We will stop sending 'key-method', 'keydir', 'proto' and 'tls-aut=
h' in
> +     * OCC in a future version (because it's not useful).  To reduce que=
stions
> +     * when interoperating, we no longer printing a warning about it.
>       */
> -    if (strncmp(p1, "proto ", 6) =3D=3D 0)
> +    if (strcmp(p1, "key-method ") =3D=3D 0
> +        || strcmp(p1, "keydir ") =3D=3D 0
> +        || strcmp(p1, "proto ") =3D=3D 0
> +        || strcmp(p1, "tls-auth ") =3D=3D 0)
>      {

... because this will actually not match if p1 is "proto TCPv4_SERVER" or
"key-method 2" (string in p1 being longer than "proto ", it will only
match with strncmp() ).

I wasn't sure why the original code had a strncmp() here, so I instrumented
a build to print "p1"...

Sun Oct  7 14:57:21 2018 OCC: 'proto TCPv4_SERVER'
Sun Oct  7 14:57:21 2018 OCC: 'key-method 2'
Sun Oct  7 14:57:21 2018 OCC: 'cipher BF-CBC'
Sun Oct  7 14:57:21 2018 OCC: 'auth SHA1'
Sun Oct  7 14:57:21 2018 OCC: 'keysize 128'

... and no match found...

While at it... could you ignore tun-ipv6 in v2, please? :-)

Sun Oct  7 14:57:21 2018 WARNING: 'tun-ipv6' is present in remote config bu=
t missing in local config, remote=3D'tun-ipv6'

thanks,

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--cqF3yV8I+FsmjbWd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbugOjAAoJEB2Cnv7KVigSfogMAIIQWbUo23h64+bz5fyjX4+W
pm0Q0Dbyr3iFqkrKWunM/BA80A2kNYE8aBbHnAVeyAMvtuK/lZI1tRMrR7KN/ctY
0P5JfZQR2Qm8rUc4oMqfBC2Gfr5dOoY2nuFo/r8nuOnT9sSX6imnTn9N4nwBOQBc
ufpg+YiI3hfg5FKv4vdLvTTXWdYK17hrt6Vb8nuCVijeIUN1K2MDEaizNHpDlxyj
vtA7BVTHuKJyAB+hKOdRjWME0se5fEfC6jLDJHTKl7mHXuEdNS9IwNNEHIEZdUOt
ijLhWuxKa4o/VsZeGos7ZYUXTzpVFIYLLgUmJ1DFFiVHQSbXuboKULn1vas0eA2m
QHPtTRPm3RSXxgoRxuJZUI/NxzF9vn/hhN3xCGZ+ygJeAyCuTSU0ywlFr4dJ7pER
4TMbLs/srOUCT2HBPNh6cBJn6dnX/j5PHuf5qUNotAymCP23LMiJ7MoSA1Qwqma0
YQnqU8qQCbO5iAW4hEWbG4y2uLTaerVMPVlSaSTMqQ==
=6lze
-----END PGP SIGNATURE-----

--cqF3yV8I+FsmjbWd--

