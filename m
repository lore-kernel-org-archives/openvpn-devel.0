Date: Tue, 24 Mar 2020 14:35:39 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20200324133539.GH1431@...1296...>
References: <ce155eed-2936-8d5c-33a8-36f355fa243a@...2545...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="qBCOWMU5EZvXye3z"
Content-Disposition: inline
In-Reply-To: <ce155eed-2936-8d5c-33a8-36f355fa243a@...2545...>
Subject: Re: [Openvpn-devel] [PATCH] mbedTLS: Make sure TLS session survives
 move
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tom van Leeuwen <tom.van.leeuwen@...2545...>
Cc: openvpn-devel@lists.sourceforge.net

--qBCOWMU5EZvXye3z
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 24, 2020 at 11:42:02AM +0100, Tom van Leeuwen wrote:
> When an mbedTLS session is moved in move_session(), the contents of the
> the tls_session is copied to the new session and the old session is
> reinitialized. This tls_session contains, amongst other things, an
> mbedtls_ssl_config and bio_ctx structure. However, the mbedtls context has
> internal pointers to the mbedtls_ssl_config and bio_ctx. When the session
> is moved, these internal pointers point to the reinitialized session.
> Since there is no public method to update these internal pointers, this
> patch allocates the mbedtls_ssl_config and bio_ctx on the heap and stores
> the pointers in the tls_session instead.
>=20
> diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
> index 0f0b035b..4f194ad7 100644
> --- a/src/openvpn/ssl_mbedtls.c
> +++ b/src/openvpn/ssl_mbedtls.c
> @@ -1036,21 +1036,22 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl,
> =A0=A0=A0=A0 CLEAR(*ks_ssl);
> =A0
> =A0=A0=A0=A0 /* Initialise SSL config */

Without speaking of the merits of the patch it self, it got destroyed
on the way - all leading spaces got turned int "alt-space" (\xa0), so
it won't apply.

Can you re-send using "git send-email"?  This usually nicely manages
to avoid all classic "mail client breaks patch" problems.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--qBCOWMU5EZvXye3z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJeegyrAAoJEB2Cnv7KVigSzQQMAJseDW9RPFnV3Csq5WzBvoDM
SuUKQdJvfjXvlkoBr89wUaggH+3WG5eRcxnj0kJ9Nt4/gcER11Gwinc6gy8UP3C8
3Z75+unzFztP17JMkknZKRpu/0bcboxpK3PLXU+giMyzs3ZNWlZCBtZyeuEQcSls
AUYUuEYccZq2TCLzbu886XzSPHdT2zoMpqIlehCKGpzzpZNmCl1/QlVvLqA4hSQo
S/b6iBPkGf9fl1cF3yo2s3i5PmBC4vNI8tPs54Iw/uEVt7Xs2sNSkpK7WUI9h9uz
qmMpuPgxhXFwD0ianohRKaEldzOOAVS8g6KlzxDeqTgUwnXAWNB8SfrdBtiGi9go
nfzMychgcHruOarJMnKO2HgRiNk8HB51WE/JBY6OHmFIecaPWd+Wj3cZJlxYqep+
1M8n8ukxu44GQ77G/GIGuYadvlvpWF2c5Qktv704UhMXrRBWeytgqXdARPN8Q2NJ
20rg8+HCzNJUD7lSVHS9MiYEyNVxiKbXWWxiI0qXJg==
=5KZu
-----END PGP SIGNATURE-----

--qBCOWMU5EZvXye3z--

