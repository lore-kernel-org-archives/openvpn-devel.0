Date: Tue, 8 Nov 2022 18:21:04 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y2qQAK8TKEv4pWcp@...1296...>
References: <20220625234150.3398864-2-arne@...1227...>
 <20220801123401.3670571-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vkTmO34sC2KfVzWA"
Content-Disposition: inline
In-Reply-To: <20220801123401.3670571-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v4 2/5] Allow tun-mtu to be pushed
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

--vkTmO34sC2KfVzWA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Aug 01, 2022 at 02:34:01PM +0200, Arne Schwabe wrote:
> +
> +Tun MTU can be pushed
> +    As part of changing the ``--tun-mtu`` default to 1420 (see below), t=
he
> +    client can now also dynamically configure its MTU and the server will
> +    try to push the client MTU when the client supports it. The directive
> +    ``--tun-mtu-max`` has been introduced to specify the maximum pushable
> +    MTU size.

This text needs rewording, as the default isn't changed.

I can do this on the fly, but I'm not sure what to write here - maybe

> +Tun MTU can be pushed
> +    Clients can now also dynamically configure their MTU and the server =
will
> +    try to push the ``--tun-mtu`` the client should use when the client
> +    supports it. The directive ``--tun-mtu-max`` has been introduced to=
=20
> +    specify the maximum pushable MTU size.


>          struct tls_session *session =3D &c->c2.tls_multi->session[TM_ACT=
IVE];
> +        if (!check_session_cipher(session, &c->options))
> +        {
> +            /* The update_session_cipher method will already print an er=
ror */
> +            return false;
> +        }
> +
> +        /* Cipher is considered safe, so we can use it to calculate the =
max
> +         * MTU size */

I'm not sure I understand that comment, and the introducion of=20
check_session_cipher() above...  where's the cipher used for the MTU
calculation below?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--vkTmO34sC2KfVzWA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjapAAAAoJEB2Cnv7KVigSHZgMAJFxYIAgrL7NdAzetXrU117q
Lv64nABa3IYKls933OR4M3kAIMwJ/NjMwkwwrjnpEkJ877h1OEYT6Fdhy+CN9IQ2
wRhEfHE/i5U9m97RWPvDUs7pfq7UNwr2qrD+5Jbd0/RrTd7r7vgl6ZCioUvUOFrO
cVx3sHOIAOpXHwQ0K9E0OBuUs2hvFWKhkySvzniiP3k4QMoWy9QU0ksDvL+GOcm1
SPwXK6oL7pUHoTgJbwY4HdHzf5QgoWDUD2E0JNX0UvyPsiA8hpOT4nJSbK8buZiB
s9mlcESm4DO5xyHzBsgF0PgU1H99KBKG492i1LSpFrCnfE1QY/ARpEeK7D0AS3FD
TUUiEB2SZNnIM/dqn+MkHI4/SRQfDsT9ZyvNltRnIXg5QSobKXOmEIftrLi3TQKf
DQu3WT1I58s8t0ilXjtciO33PUylWTPHJHMpzYhw190W5Qk+ls67KH4rqzco9ikD
S8sGFCQZgJKyi4Z/MpERknH1jV5kF0lOJ/ILbilEDA==
=xENl
-----END PGP SIGNATURE-----

--vkTmO34sC2KfVzWA--

