Date: Fri, 24 Nov 2017 14:06:40 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171124130640.GK631@...1296...>
References: <ed338010-2918-fb1d-27e0-116712651b87@...2181...>
 <20171112172237.8285-1-steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="AqCDj3hiknadvR6t"
Content-Disposition: inline
In-Reply-To: <20171112172237.8285-1-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH v2] Use P_DATA_V2 for server->client
 packets too
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--AqCDj3hiknadvR6t
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

as just discussed on IRC, I'm not fully happy with this, and want=20
a v3...

On Sun, Nov 12, 2017 at 06:22:37PM +0100, Steffan Karger wrote:
[..]
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index 5947a31f..16a4101f 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -366,6 +366,7 @@ prepare_push_reply(struct context *c, struct gc_arena=
 *gc,
>              push_option_fmt(gc, push_list, M_USAGE, "peer-id %d",
>                              tls_multi->peer_id);
>          }
> +        tls_multi->use_peer_id =3D true;
>      }

While this *works* today, it relies on the fact that only clients
that can do IV_PROTO=3D2 will ever send IV_PROTO=3D<anything>.=20=20

But it still creates weird code (more context):

     /* Send peer-id if client supports it */
     optstr =3D peer_info ? strstr(peer_info, "IV_PROTO=3D") : NULL;
     if (optstr)
     {=20=20=20
         int proto =3D 0;
         int r =3D sscanf(optstr, "IV_PROTO=3D%d", &proto);
         if ((r =3D=3D 1) && (proto >=3D 2))
         {=20=20=20
             push_option_fmt(gc, push_list, M_USAGE, "peer-id %d",
                             tls_multi->peer_id);
         }
+        tls_multi->use_peer_id =3D true;
     }

where we set tls_multi->use_peer_id =3D true for any client that sends
IV_PROTO=3D<anything>, but the rules for "push a peer ID to the client"
is much stricter, requiring it to be IV_PROTO=3D<num> with num>=3D2 - so
the "tls_multi->use_peer_id =3D true;" should go inside that block.

gert

--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--AqCDj3hiknadvR6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaGBlfAAoJEB2Cnv7KVigS59YL/Ax5+AFXO7fIx1XXktymGtey
l7eKyJJiRE3cIzyItxLVNF3KjwXn48ey3tE6ZNMlHrtXpMuuR/lyKobJW9iE6Q/b
TbWw5rdbAU/nQ+JW5zZ+v59F6f7AYpeEgAYmerJcVjbzf4mPp+6p+MbfQMIvfZCg
6NkkjS6vwGpmTPxwJyUPFE7CLnx+qEU2IqS82RbvNhq5CXPatGFYTmhcExEPhP2X
QRLe3nn22YQaUL62O7JJsyMUIU2N0QhfdvRlr4BSN2xvI3pSHA8cH7G/QeUka5YA
4jvqL81phNkajIiarPsp69/XjTr1dafHz/9o9zfX8yXk8o7fItw/xKsSwf9Oevkn
MqWWeYX4Yiu8WU/8Hj1/oR4N4dZd6gBTJJ9SNomyZ4qeyfRdR9De/GEfWALtsym0
DShiRM+1zVY6qxLqdWzkuS+PmyhyehQiVGi1NF90d+npSlliHY39Arw+xMElXGmd
0oZE2ZJimHqGSZFZQ65OxqyYmQeH/KiRvDCWDwX8Og==
=MYdG
-----END PGP SIGNATURE-----

--AqCDj3hiknadvR6t--

