Date: Wed, 15 Mar 2023 19:43:12 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZBIRwKLH6eqqJnH7@...1296...>
References: <20230314144854.182110-1-arne@...1227...>
 <20230315150420.298988-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tR4sjhXxPhlZ1btN"
Content-Disposition: inline
In-Reply-To: <20230315150420.298988-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] Fix memory leaks in HMAC initial
 packet id
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

--tR4sjhXxPhlZ1btN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Mar 15, 2023 at 04:04:20PM +0100, Arne Schwabe wrote:
> The HMAC leaks are just forgotten frees/deinitialisations. tls_wrap_contr=
ol
> will sometimes return the original buffer (non tls-crypt) and sometimes
> tls_wrap.work, handling this buffer lifetime is a bit more complicated. I=
nstead
> of further complicating that code just give our work buffer the same life=
time
> as the other one inside tls_wrap.work as that is also more consistent.

This test passes all I've thrown at it, except stare-at-code...

Maybe I am misreading it, but want to make sure.

> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 124ac76bd..fa2681dc7 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -3483,6 +3483,7 @@ do_init_frame_tls(struct context *c)
>          frame_print(&c->c2.tls_auth_standalone->frame, D_MTU_INFO,
>                      "TLS-Auth MTU parms");
>          c->c2.tls_auth_standalone->tls_wrap.work =3D alloc_buf_gc(BUF_SI=
ZE(&c->c2.frame), &c->c2.gc);
> +        c->c2.tls_auth_standalone->workbuf =3D alloc_buf_gc(BUF_SIZE(&c-=
>c2.frame), &c->c2.gc);
>      }

At this place, we have a tls_auth_standalone() (!=3D NULL) already, which
got initialized by tls_auth_standalone_init().

We allocate tas->workbuf here.

> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 78cec90a1..f2331f712 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -1358,9 +1358,21 @@ tls_auth_standalone_init(struct tls_options *tls_o=
ptions,
>      packet_id_init(&tas->tls_wrap.opt.packet_id, tls_options->replay_win=
dow,
>                     tls_options->replay_time, "TAS", 0);
>=20=20
> +    tas->workbuf =3D alloc_buf_gc(tas->frame.buf.payload_size, gc);
>      return tas;
>  }

This is tls_auth_standalone_init(), which has already allocated
a tas->workbuf.

So my reading is "we allocate this twice" - which is not a super big
problem because it's both in the gc_arena and will be freed on session
exit (mmmh, which session, anyway?) - but it's still "too many bufs",
plus "readers of that code will get confused".

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--tR4sjhXxPhlZ1btN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkEhG/AAoJEB2Cnv7KVigS+/kL/0OWFF1opSTLtHK1Xqs/m4LF
509oPlGYmpd0eRC1+Q+J12nsNgCFeBNNfXCDL2Wf1ViMpu9fhxWAE3w43mAzbifn
vgolvakULjSIAjTi77FpyDnu4O10505TXHdJWTautajhmEvYxAzO8mhRs6GtfYAk
GUVQagMOR8rx2LYP4+BpYpLc3tFlQgYRE0g70mcUTN73IFaqt0brpq9VdTCJif2T
jbXVvUhmQE1Z9jwMKHVgNBsuVy0iypIyy4wsFHknVEtpZvxfLNeHoYJbEx1XWbEi
ciCJaQNcKpT3zSDEke/6pKC5ERi8jFFkgZWmUlOl4s/moew9YwDao44RSRyhvKBz
UF9U+QiXRaMxJ0Zizl/K0XA6xlKne+ppoxgm/q2wIcMntPzLYeLejoMaGxMYnzJj
KGXPHz9AQFpnUPX++MXpNAsJ7Uc6KH46vMDMuLIpHWXGc2h3aHqgOo51bczKPQaG
+CVmnw3OKTAzfh+sk7pZC/I4pxpSHpUUIhajmULqWQ==
=VLAf
-----END PGP SIGNATURE-----

--tR4sjhXxPhlZ1btN--

