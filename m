Message-ID: <50D2D610.5080406@...1114...>
Date: Thu, 20 Dec 2012 10:10:40 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20121214181815.GQ22465@...1296...>
In-Reply-To: <20121214181815.GQ22465@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7932DB821D5BD0B502E947F6"
Subject: Re: [Openvpn-devel] coverity issue 2 - dead default / code cleanup
 in mtcp.c
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7932DB821D5BD0B502E947F6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 14/12/12 19:18, Gert Doering wrote:
> Hi,
>=20
> next one: mtcp.c, about line 470:
>=20
>   unsigned int flags =3D MTP_NONE;
>=20
>   if (TUN_OUT(c))
>     flags |=3D MTP_TUN_OUT;
>   if (LINK_OUT(c))
>     flags |=3D MTP_LINK_OUT;
>=20
>   switch (flags)
>     {
>     case MTP_TUN_OUT|MTP_LINK_OUT:
>     case MTP_TUN_OUT:
>       newaction =3D TA_TUN_WRITE;
>       break;
>     case MTP_LINK_OUT:
>       newaction =3D TA_SOCKET_WRITE;
>       break;
>     case MTP_NONE:
>       if (mi && socket_read_residual (c->c2.link_socket))
>         newaction =3D TA_SOCKET_READ_RESIDUAL;
>       else
>         multi_tcp_set_global_rw_flags (m, mi);
>       break;
>     default:
>       {
>         struct gc_arena gc =3D gc_new ();
>         msg (M_FATAL, "MULTI TCP: multi_tcp_post bad state, mi=3D%s flags=
=3D%d",
>              multi_instance_string (mi, false, &gc),
>              flags);
>         gc_free (&gc);
>         break;
>       }
>     }
>=20
>=20
>=20
> coverity is complaining that the "default:" clause can never be reached,
> as all the possible values for "flags" are covered - and it's obviously
> right.  It's not something critical, more a "code cleanup" thing.
>=20
> (The whole usage of switch/case here reeks a bit, given that I think the=
=20
> code would be simpler by directly setting "newaction" depending on
> "if (TUN_OUT(c))" etc., not bothering with "flags" in the first place)
>=20
> Cleanup in 2.4?

Does it hurt to have this "dead code"?  Agreed, if all the flags are
covered, we'll never see 'default' in action.  But is it possible that
these flags can be extended at some point in the future, which we need
to account for?  I somehow find confidence in having this "trap" with
msg(M_FATAL,...) for future scenarios.  Not because I strongly believe
it will be needed, but more like a precaution (as in "Yes, we have
thought about this")


--=20
kind regards,

David Sommerseth


--------------enig7932DB821D5BD0B502E947F6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDS1hEACgkQDC186MBRfrrKaQCdEwL8DrCH2anp55vkHfxVI0jC
VR0AniRrQnn9ajWP/snI8obb4GgNF5rz
=8zX2
-----END PGP SIGNATURE-----

--------------enig7932DB821D5BD0B502E947F6--

