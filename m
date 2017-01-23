Date: Mon, 23 Jan 2017 10:32:25 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20170123023225.GU16061@...2182...>
References: <20170115144330.1835-1-a@...2181...>
	<82ec55bd-f475-b0a8-3e7e-bf6c54176d56@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zYo4Elh1vtcYNvbq"
Content-Disposition: inline
In-Reply-To: <82ec55bd-f475-b0a8-3e7e-bf6c54176d56@...1856...>
Subject: Re: [Openvpn-devel] [PATCH v5] convert *_inline attributes to bool
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--zYo4Elh1vtcYNvbq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sun, Jan 22, 2017 at 05:31:56PM +0100, Steffan Karger wrote:
> Hi,
>=20
> One more real comment and two nitpicks:
>=20
> On 15-01-17 15:43, Antonio Quartulli wrote:
> > @@ -3233,39 +3258,63 @@ options_postprocess_filechecks(struct options *=
options)
> >
> > [...]
> >
> > +    errs |=3D check_file_access_inline(options->cert_file_inline, CHKA=
CC_FILE,
> > +                                         options->cert_file, R_OK, "--=
cert");
>=20
> This line has 1 indent too many.

ops, thanks.

>=20
> > +    errs |=3D check_file_access_inline(options->extra_certs_file, CHKA=
CC_FILE,
> > +                                     options->extra_certs_file, R_OK,
> > +                                     "--extra-certs");
>=20
> I think the second one should be options->extra_certs_file_inline?

good catch, thanks! Unfortunately in my setup I don't use extra-certs, so I
couldn't run this piece of code :(
Having automated unit tests for these features would be really nice :/

>=20
> > --- a/src/openvpn/ssl.c
> > +++ b/src/openvpn/ssl.c
> > @@ -542,7 +542,7 @@ tls_version_parse(const char *vstr, const char *ext=
ra)
> >   */
> >  static void
> >  tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
> > -                   const char *crl_file_inline)
> > +                   bool crl_file_inline)
>=20
> The doxygen string of the crl_file_inline parameter needs to be updated
> too (like you did in the header file for the non-static functions).

my bad. will fix.

>=20
> Apart from these I am ready to give this an ACK.

Thanks! I'll send a new version soon!

Cheers,


--=20
Antonio Quartulli

--zYo4Elh1vtcYNvbq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYhWs2AAoJEJ6F1zG2JyOsO1UP+gNQ2ktYCQ3RIOy879B2BTxm
XECX1NnDWUTfLHLCCFDpY6ouYuMtEWtltzRPZXR+LMvxL+QVlGSjuuKDBIRX6QCA
cdYCN9FbtypC2zVMXHoRhShcGVI1qgqaApc9DMLzCwVyWTEXyTm5FwcVnActO35e
GUzaI2JzfG4xDUe/afmFmnLba9a9M3SUDSfnm1MWYunNM7saYWoI4LhYrka1X5An
zT05VRdl95kFPa7HamGwHX1nbPLQWn9WZRoAph7zSzb/VrVYH5/6nHxC9xcfA5Eo
73td7PIbuOdgpaK8BBQdD1f5aJl+kdD3QEda+x6H4TkQl6/mjj4bXI4xwZFZNGIY
VhOOgges2ZVY2Rpn0gLsmdePOyyVCjr8QBqWwUx5aGejEytTy+UffQBXHwQBruj9
UTWFQDaBUmFxAiB1y+AmhpQh3Zdz3RenD7sLL/tcQfi3RNm3CwCwUIfxuEhQEF3g
72YgfujXdA46tmgvjLBdRemVmz2Rt89R4b+UWcCWxIu5w0V9CwvxrTl0P6dC6J1+
u6hzvYkc6p/SaK8n4b7dW3/I50dBMS55JB9pBWVc2ZgvoANnfIC3Nd9HhVXAH/Rj
Qn7zFCwi/nwenhRvdAt89L8CPcz49q+RwJvo5Z/nRT/m+YdTVIJLsHUJA8vBMy8k
sr+CvuGWLN244tpIYMHd
=uD92
-----END PGP SIGNATURE-----

--zYo4Elh1vtcYNvbq--

