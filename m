References: <20200727221341.22544-2-themiron@...2010...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <98f65e22-a66c-aeea-f705-ad5a0f7a2e28@...1227...>
Date: Fri, 14 Aug 2020 14:19:02 +0200
MIME-Version: 1.0
In-Reply-To: <20200727221341.22544-2-themiron@...2010...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cQ2xilEEkGTtANozjwn0Xxn7rN3YPgqGC"
Subject: Re: [Openvpn-devel] [PATCH 2/2] Allow killing of client instances
 by cn with wildcards
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vladislav Grishenko <themiron@...2010...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cQ2xilEEkGTtANozjwn0Xxn7rN3YPgqGC
Content-Type: multipart/mixed; boundary="VqK5cl905SOFyXdXubHglSiyVwV8uXx2T"

--VqK5cl905SOFyXdXubHglSiyVwV8uXx2T
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


>      int count =3D 0;
>=20=20
> +    /* Allow trailing wildcard */
> +    int len =3D strlen(del_cn);
> +    len +=3D (len > 1 && del_cn[len-1] =3D=3D '*') ? -1 : 1;

This is very compact and not very readable

A comment that says why you are adding +1 would be good.

I first thought it was incorrect and went through godbolt to figure out
the '*' string is longer so its prefix is short and normal string needs
the \0 instead: https://godbolt.org/z/vqsPeW


> +
>      hash_iterator_init(m->iter, &hi);
>      while ((he =3D hash_iterator_next(&hi)))
>      {
> @@ -3779,7 +3783,7 @@ management_callback_kill_by_cn(void *arg, const cha=
r *del_cn)
>          if (!mi->halt)
>          {
>              const char *cn =3D tls_common_name(mi->context.c2.tls_multi,=
 false);
> -            if (cn && !strcmp(cn, del_cn))
> +            if (cn && !strncmp(cn, del_cn, len))
>              {
>                  multi_signal_instance(m, mi, SIGTERM);
>                  ++count;
>=20

Feature-Ack. But I would like the string len magic be documented/written
in a better understandable way.

Arne


--VqK5cl905SOFyXdXubHglSiyVwV8uXx2T--

--cQ2xilEEkGTtANozjwn0Xxn7rN3YPgqGC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl82gTYACgkQFRhsZwKx
RFQZug//dcrCFUYxT4rRvL6vbAWReaz3QnC4xd+FOMpPw0TTBpojbMz9/Vo+LPVh
9+vgU73fV1vR2hSxHd+4dGPwuIjH8J964OPmklvz2R3GVeczkPpJVwnGF9aJQ8hE
1pDGspc4KpqtRiG73JaeRpvsbJRXz+1DOjLOQYGZzjl0XqG7W9OfXhcr7kxeP0H8
icFOpGYzrllwPW5hePg4o3mGBBQ37rK5ecftyWVevl7jn02i3YEsc+vAZu5o9pv1
m1fY7cAS2dvH7LWOh//uff3gcleyFjnxT675cie39zWwDQ84wdRKQusiizjTL3aQ
/jZfn84vvb+FNL+dZOKvGPYvvHzsy0qyqG22SQI/MF9v6fiFY9gylVzNslQJlq0L
q49nBL93MUBw8Wwb1X5LHcz24MkeQ/d3+tAlCIUnVF8K2JDmtfa9ATLQ36rqlVnQ
KsCO9tFesFjP2RgyZPTiwOIWVLhyu9GmqNWY6Vwbk3+gXT8HZtHNmrcDa+tpUpaw
Y2lpZtymofp7hAAB3Qndj9LZ7CO5K7t3kjksGQrNFSIB7U4H5aDbwaSuMcNp+XvG
Mene2CL/ncRa9jbpLx0GcSWFjlUzw0IRhxnt5smldoeGi7oJTN09+OHDatgvIE8H
otULvS/QrlvwWCL3jYOGPXYIhIX6GBCPxDyenCafdn9bgYqC5vE=
=rxy2
-----END PGP SIGNATURE-----

--cQ2xilEEkGTtANozjwn0Xxn7rN3YPgqGC--

