Date: Sun, 15 Oct 2023 16:34:27 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZSv4c6RygwPMRtXG@...1296...>
References: <gerrit.1696685196000.I8cb2cb083e3cdadf187b7874979d79af3974e759@...2715...>
 <20231008105316.21010-1-frank@...2641...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="itBYEEy7SGAQAhzb"
Content-Disposition: inline
In-Reply-To: <20231008105316.21010-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH] dco: warn if DATA_V1 packets are sent
 to userspace
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>, Arne Schwabe <arne-openvpn@...1227...>

--itBYEEy7SGAQAhzb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Oct 08, 2023 at 12:53:16PM +0200, Frank Lichtenheld wrote:
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index d8ad0d1..66843b4 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -1058,8 +1058,16 @@
>               * and return false.
>               */
>              uint8_t opcode =3D *BPTR(&c->c2.buf) >> P_OPCODE_SHIFT;
> -            if (tls_pre_decrypt(c->c2.tls_multi, &c->c2.from, &c->c2.buf=
, &co,
> -                                floated, &ad_start))
> +
> +            if ((opcode =3D=3D P_DATA_V1) && dco_enabled(&c->options))
> +            {
> +                msg(D_LINK_ERRORS,
> +                    "Data Channel Offload doesn't support DATA_V1 packet=
s. "
> +                    "Upgrade your server to 2.4.5 or newer.");
> +                c->c2.buf.len =3D 0;
> +            }
> +            else if (tls_pre_decrypt(c->c2.tls_multi, &c->c2.from, &c->c=
2.buf,
> +                                     &co, floated, &ad_start))

I understand the reasoning behind this patch, and the new code is
doing what it should

I do not like some more "visual" aspects of this - the comment above
this all is not changed, so does not match the code anymore, and the
newly introduced "else" makes the tls_pre_decrypt() branch start to
look like "this is 'just the else branch'", no longer "the main thing
being done here".

I'd leave off the "else", as tls_pre_decrypt() will do nothing and
return FALSE on "c->c2.buf_len <=3D 0".

Also, I'd reshuffle the function a bit - move the "opcode" assignment
before the existing comment block, and add a new comment for the
DATA_V1 case - maybe like this:

        if (c->c2.tls_multi)
        {
            uint8_t opcode =3D *BPTR(&c->c2.buf) >> P_OPCODE_SHIFT;

	    /*
	     * If DCO is enabled, the kernel drivers require that the
             * other end only sends P_DATA_V2 packets.  V1 are unknown
             * to kernel and passed to userland, but we cannot handle them
             * either because crypto context is missing - so drop the packe=
t.
             *
             * This can only happen with particular old (2.4.0-2.4.4) serve=
rs.
             */
            if ((opcode =3D=3D P_DATA_V1) && dco_enabled(&c->options))
            {
                msg(D_LINK_ERRORS,
                    "Data Channel Offload doesn't support DATA_V1 packets. "
                    "Upgrade your server to 2.4.5 or newer.");
                c->c2.buf.len =3D 0;
            }

            /*
             * If tls_pre_decrypt returns true, it means the incoming
             * packet was a good TLS control channel packet.  If so, TLS co=
de
             * will deal with the packet and set buf.len to 0 so downstream
             * stages ignore it.
             *
             * If the packet is a data channel packet, tls_pre_decrypt
             * will load crypto_options with the correct encryption key
             * and return false.
             */
            if (tls_pre_decrypt(c->c2.tls_multi, &c->c2.from, &c->c2.buf, &=
co,
                                floated, &ad_start))


what do you think?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--itBYEEy7SGAQAhzb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJlK/hzAAoJEB2Cnv7KVigSXMAL/0Gm39nK0kYzBNZVm7wN3W8a
VpzX2uS4aonX38xH2Ki2KrtnZTOxHIaE5rsbfE3jG0Fln9B2eXss6VluyAsPK6q6
cgi9zLf07HjodapouMw9AUb5G/9xyss4cF0pWNSjOpcg4j0VBV86j3ekVcyfNIuP
eAopWgvAydSfAuO9T/x0hU0DC1KdP4rrzC5OCj6+y3+BwG27XLrjo+/RlcWn/MIK
RSi79olMjTL5J9OS1rOy4zLpillDfkwv0Viw5Ea2V0jc/7T9XO4HwHro3/3tBMI6
DReWkObuoRPLmwDsM4nLxsVXa1SpD19u+D0P+iQGC4/p5K+KiFyzm+c4DFbXsjjI
7F5ZUV1YLyNAzJ/w8EvenkssUgKmD6Vu2AhmUEbfKT9YVVHqPr8jN/XXRxmn+8BK
gGvd9hWZeCHx3Rj32rF3R/2Z5mQND1o3E1aR2qsJn8NdCchYM2b4Cax6xXFAdVKv
dgAVzwDpRnzHR2Sxl6+XEyWx2ox9/F0hthp7AHbTsw==
=ZOy0
-----END PGP SIGNATURE-----

--itBYEEy7SGAQAhzb--

