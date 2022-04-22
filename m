Date: Fri, 22 Apr 2022 21:05:34 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YmL8fpKi2/MqE/+s@...1296...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422134038.3801239-5-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="xLRvTTmL/3Xf90qo"
Content-Disposition: inline
In-Reply-To: <20220422134038.3801239-5-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 04/28] Add documentation for swap_hmac
 function
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

--xLRvTTmL/3Xf90qo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Apr 22, 2022 at 03:40:33PM +0200, Arne Schwabe wrote:
> +/**
> + * Move a packet authentication HMAC + related fields to or from the fro=
nt
> + * of the buffer so it can be processed by encrypt/decrypt.
> + *
> + * Turning the on wire format that starts with the opcode to a format
> + * that starts with the hmac
> + * e.g. "onwire" [opcode + packet id] [hmac] [remainder of packed]
> + *
> + *
> + *    "internal" [hmac] [opcode + packet id] [remainer of packet]
> + *

I was about to merge this as "it is easy, and does not change code", but
if we add documentation, it should be correct :-) - and this schematic
does not match my understanding of the actual code - which seems to
swap

  [opcode + session id] [hmac + packet id]

could you double check that?  The size of the "things it swaps" is

         /* hmac + packet_id (8 bytes) */
         const int hmac_size =3D hmac_ctx_size(ctx->hmac) + packet_id_size(=
true);
=20
         /* opcode + session_id */
         const int osid_size =3D 1 + SID_SIZE;

... so that would make it "[hmac + packet id]" not "[hmac]" and
"[opcode + packet id]"...?!

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--xLRvTTmL/3Xf90qo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiYvx7AAoJEB2Cnv7KVigSumAL/ifnrUznghBZDW68Adw3N7ee
evQrhZtl/AFiy/UxhtyDI0Xw9IcnzhXoRgKaVCFKkXt0yAdKxd1BHLWXb8KcJ4XF
4qhLJ2NBNiv9fIz6Xr6BCpItaFk715sBOZCLPn5ky9hscKr4PCpGDomD+g9InU3j
p3D3ieCbW7l0x0NwKleIcJL7YL+IeUAEqem/xsWZxEBItcLm7PKim9gRwHTwbxbI
8kRorkuizLyn7CN3GMg2z8Hp6kMx2s0sbmcxpYGu3M5dm9u3MpqVPn6CfL6wfWoT
af2Ax6FEOMjJGMoCKCF1GE0cxv2bTtNVsbaBBjlO6K9iSr2rCwmPGAMyA0a21pPP
Y1Bl7Qw3syC0ei8DQTIn3pqyYqxQT3s5b2MXGlKBqingbZqIhCDMZN65IPNwqpGP
hIu0IfNmqcb8oTJtFoytrxt7ihuLSyNzQxSrF4oqlgs2JuDOFCLKEkLpaFMkk/UZ
XXtbIja0M1rNQqFe2AfoUglOh3juGXZAkoLLyYgQ3Q==
=vts3
-----END PGP SIGNATURE-----

--xLRvTTmL/3Xf90qo--

