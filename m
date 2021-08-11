Date: Wed, 11 Aug 2021 14:52:15 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YRPH/+6urQNXMAlv@...1296...>
References: <20210805180950.838612-1-arne@...1227...>
 <ca592ce5-3123-35df-7533-f7dc79740cef@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="iCFw5RWS1OfgigqG"
Content-Disposition: inline
In-Reply-To: <ca592ce5-3123-35df-7533-f7dc79740cef@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3] Modernise OpenVPN defaults and
 introduce '--compat-mode'
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--iCFw5RWS1OfgigqG
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 11, 2021 at 09:29:22AM +0200, Antonio Quartulli wrote:
> Wouldn't it be better to have one patch of reach default behaviour being
> charged with a concise but focused explanation as to why that default is
> being changed?
>=20
> After those patches, then another patch could come in implementing
> compat-mode.

NAK to the proposed approach, because that would give us incompatible
(and unfixable-incompatible) versions in between.

I am open to splitting this patch, but would turn it around

 - compat-mode comes *first*, with an option that basically "does nothing"

 - each change to a default setting brings in the required compat-mode
   adjustments

but I can live with "all in a single commit", provided the commit message
(+ Changes.rst) is clear enough on the "what and why".

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--iCFw5RWS1OfgigqG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhE8f6AAoJEB2Cnv7KVigSqckL/1JMT+ueWlONBqUisj3CVfkO
rmFaYHM6HaXtP7HGWozemJeV43C61O89KVnMiTIYgNVSlBhtFvEVes5eIKPtAx8f
v90Fgyw3O5vWyydlB4y98+tQK0M8ykLZfbK8L6DQ9QQRF1OiXoedo6R/SHh5Hq8J
6ywaFbQcWgYbJ+EWUkZmPyKGgJVublfgkc5oqz5ZlnjccqyYkM7lrAuxZcfY6y8t
Gjh/IUyqw7JM+ny8RqS5QbIZDNg8fuGp+8+428IhCPi5zGGSyTu4OG/9+GPFJmnf
RqJvaVLhMFQ4DTfvvm2D1HZXS3cx0FOclpsByLTTBBjsZrLKe5EPbzhXUAhqOiuB
o4gT2Y6ryHeAhVtDkqNa6HTGFQRryzX2HxhiU9VIlMU8cEELLq2fACWAga4m8NPV
xvdEUNN4/DKAzo9mw9NJz+Iu+yGxuII1Ups5L6c2HJ4L9xFiDVuAzBQSW2OXH/4S
7G4aQ41HzKrMXeN44JuOdgXHdYAvWqSSHAEyXuEiVg==
=KwjW
-----END PGP SIGNATURE-----

--iCFw5RWS1OfgigqG--

