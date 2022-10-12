Date: Wed, 12 Oct 2022 22:43:17 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Y0cm5SIpQH0g2UjA@...1296...>
References: <20221012133457.1927871-1-arne@...1227...>
 <20221012133457.1927871-2-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="9Lxjin+hDxKBs0ab"
Content-Disposition: inline
In-Reply-To: <20221012133457.1927871-2-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] Use dedicated multi->dco_peer_id
 for DCO instead of multi->peer_id
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

--9Lxjin+hDxKBs0ab
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 12, 2022 at 03:34:55PM +0200, Arne Schwabe wrote:
> The lifetime and state machine of multi->peer_id does not exactly the
> lifetime/state of DCO. This is especially for p2p NCP where a reconnection
> can change the peer id. Also use this new field with value -1 to mean
> not installed, replacing the dco_peer_added field.

The code seems to disagree with itself whether it's -1 or 0, if I
read this correctly...

> @@ -461,10 +461,10 @@ dco_remove_peer(struct context *c)
>          return;
>      }
>=20=20
> -    if (c->c1.tuntap && c->c2.tls_multi && c->c2.tls_multi->dco_peer_add=
ed)
> +    if (c->c1.tuntap && c->c2.tls_multi && c->c2.tls_multi->dco_peer_id)
>      {

This checks for "not 0"...

> -        dco_del_peer(&c->c1.tuntap->dco, c->c2.tls_multi->peer_id);
> -        c->c2.tls_multi->dco_peer_added =3D false;
> +        dco_del_peer(&c->c1.tuntap->dco, c->c2.tls_multi->dco_peer_id);
> +        c->c2.tls_multi->dco_peer_id =3D -1;

... but sets -1 here, which would evaluate to "true"...?

(All the rest sets "-1", AFAICS, just the if() here is weird)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--9Lxjin+hDxKBs0ab
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjRyblAAoJEB2Cnv7KVigSiFUMAIiN8c/U4i33FigjvpWs+JmN
tMQnHzRWlH1ZRV92bX6+qjH+os78iHWQpP4xxRLHeZ9JmFMzTopPBMzn1OZp9G6r
UfpMZFFH5du7jeiO3ATu+3eQnGBAaiZwIJVEWgnu4EN0CzMnHu34JK2EkqC0Pijv
EKsevdCv39vipupKAnNdZzWo5TlQAeSLIua+FQ4R7BmIVaKBdi0cWtPqjWHItULz
8CDIKrcRq2Q0ee+3U8sHXHekplGyz9rrHqpA7ObVJRz5JqCV6b6B57nnDkro6aeM
vdurgpkruHkE6avigBXtN9iRNlExKRDyzwXZq/e2Z3eCRmt0PbG3si7K03MjUfwg
gqy7BoyjJkbD8RbMlucH0mdFGncI7KyCBpWA1HymRNFFHKJRSevP12u0XEUO57JS
/5jhy5B3OCrVCjKpzyo3Vabu3YLNSobZNa6DLlTZYqjsYbhMT6sJVxJtMKvlbpie
A1IMiUCl5rz6dn/k/xGujcRGdtMGYrjcQFntm9xlCA==
=SuMv
-----END PGP SIGNATURE-----

--9Lxjin+hDxKBs0ab--

