Date: Fri, 26 Mar 2021 07:58:51 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210326065851.GP976@...1296...>
References: <20210325000121.10331-1-arne@...1227...>
 <20210325000121.10331-2-arne@...1227...>
 <b418f610-6e7e-ba3c-8c30-6e0ef0c50fa5@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="0u2WXWk63XiemHti"
Content-Disposition: inline
In-Reply-To: <b418f610-6e7e-ba3c-8c30-6e0ef0c50fa5@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Remove deprecated option '--keysize'
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

--0u2WXWk63XiemHti
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Mar 26, 2021 at 12:12:40AM +0100, Antonio Quartulli wrote:
> > -#ifdef HAVE_EVP_CIPHER_CTX_SET_KEY_LENGTH
> > +    /* This serves as a check that the keylen is the correct as this f=
ails
> > +     * when key_len and the fixed size of cipher disagree */
> >      if (!EVP_CIPHER_CTX_set_key_length(ctx, key_len))
>=20
> Are you sure we need to keep this check?

Indeed, that also got me wondering (and is the reason why I didn't
just ack-and-merge it right away :-) - but I was waiting for someone
else to understand and ACK this)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--0u2WXWk63XiemHti
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgXYYqAAoJEB2Cnv7KVigSkKYL/jHcIjj2xeGgCn0WQIN88rHf
o/0p12lcHPgZQunEJjm+G5E8VbXIAYIap3+Gr8Yqu5WLPpksTqpqlibx5EeDZreH
VPT2gUyzv1EnB+ZXX2HsRRgFlEqeHKKxnhdv/ys2jQSGtqoi/3BO8o4guI/KEgvY
CUZ+wCPkofxsmFokjMEma+zlCPrOACqudtuiULnxL1Bpv6dhPw8Yu8Lq66+KrO1g
p4cwmXoThI6y92+4eGGbZXhXEkzq4aAPqEh1hjEwhr/agt/Jd0ioFKV0ymtny4TZ
hW7oTXVY5WMiudCU23T6aefPVTATtKGwzfMTmhG1vvl7zVykLNTYEzEO2ndOPNt8
A4vYEjkG7nbvFGM2xj7mQwFKZU/jY2A6RuoEimUeYpcNsCxfi7PvcytE2T/Hdz/e
nu+TU4mNJ6nzOpusOSdKbLxW7hPulg6UNSukgfG+aVQkZnmBsFv0wDAHhY5mbIrV
Nhgn8duK3JHZ3lxHhdiT5ResnrRFnRAJfoChhGVK1g==
=+PI+
-----END PGP SIGNATURE-----

--0u2WXWk63XiemHti--

