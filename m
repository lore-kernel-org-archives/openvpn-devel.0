Date: Wed, 27 Jul 2022 20:58:08 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YuGKwNinYLarY5v/@greenie.muc.de>
References: <20220625234150.3398864-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="34hbv7YqHtvZlfXO"
Content-Disposition: inline
In-Reply-To: <20220625234150.3398864-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3 1/5] Extract update_session_cipher
 into standalone function
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

--34hbv7YqHtvZlfXO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jun 26, 2022 at 01:41:46AM +0200, Arne Schwabe wrote:
> +
> +/**
> + * Checks if the cipher is allowed and updates the TLS session cipher wi=
th it,
> + * otherwise returns false
> + */
> +bool
> +update_session_cipher(struct tls_session *session, struct options *optio=
ns);
> +

Is that comment correct?  I can't find any "updating" here, only "checking".

What am I overlooking?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--34hbv7YqHtvZlfXO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi4Yq/AAoJEB2Cnv7KVigSZhoL/jyJqrQtUzc+836INpS5hdTx
tbAoeZGkPtrRN18R+O8wUQZgpLmlLChVBZF7Nai/ImHF53VlhCdFgXp78oJ9ljhp
Qsc/w5/1Cpr2gb6NWOtON7XWhROX1LmI/Dto5js+87jwwcKgsnZvoFg6ThpGYW4j
wwsi9NTlsSA3DFu/RPvDIP7BRYTTVQ8ypsbOTnpDRAUgTgNd98pFtjTFZLYv/YAw
8e0nY4oFRgY2PrlpAq9+MwDBe/j+arNeilzWk0RmDsz+9LAI5/CYgxyI96GRMfwv
hwL26mXXAiKzLAxeAHH94+2JRxFLZKGWDI9ijcC/uc1Jh4tlk2iJFXvQTxNsrbzr
fd/YBUSWwAkTVE/RXgrP5Imyimj7omoBPXwwDt+cwEuG4KI+KJz4ydiiRo0tBEYJ
8fqjQ38pnuDDW1RNDaWIS+Ulby7L8Ksbff6RqTEG3BX24Df2bf+ejM+Q7ZNZbsRx
e8q3fg81Ormtc+PwG672OpAwM92iHyfNjzcwVdEfjg==
=Q9C0
-----END PGP SIGNATURE-----

--34hbv7YqHtvZlfXO--

