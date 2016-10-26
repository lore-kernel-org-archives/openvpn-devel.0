Date: Wed, 26 Oct 2016 20:40:19 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20161026124019.GE8925@...2182...>
References: <20161026120631.15946-1-a@...2181...>
	<30247351-24a3-4314-40c5-bfb5e82f84b0@...1435...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fUvfsPTz/SzOZDdw"
Content-Disposition: inline
In-Reply-To: <30247351-24a3-4314-40c5-bfb5e82f84b0@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] don't mix settings when crl-verify
 option appears more than once
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

--fUvfsPTz/SzOZDdw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, Oct 26, 2016 at 02:29:19PM +0200, Steffan Karger wrote:
> Hi,
>=20
> On 26-10-16 14:06, Antonio Quartulli wrote:
> > clr-verify can be specified multiple times in the config file and the
> > expected behaviour is that the last occurrence should be used.
> >=20
> > Therefore, reset the optional flags everytime a new crl-verify
> > option is found.
> >=20
> > Signed-off-by: Antonio Quartulli <a@...2181...>
> > ---
> >  src/openvpn/options.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >=20
> > diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> > index 281ef0b..5192198 100644
> > --- a/src/openvpn/options.c
> > +++ b/src/openvpn/options.c
> > @@ -6966,6 +6966,14 @@ add_option (struct options *options,
> >  		  || (p[2] && streq (p[1], INLINE_FILE_TAG) ) || !p[2]) && !p[3])
> >      {
> >        VERIFY_PERMISSION (OPT_P_GENERAL);
> > +      /*
> > +       * If crl-verify appears more than once in the config file, we h=
ave to
> > +       * to keep settings belonging to the last occurrence only.
> > +       * Reset optional settings each time.
> > +       */
> > +      options->ssl_flags &=3D ~SSLF_CRL_VERIFY_DIR;
> > +      options->crl_file_inline =3D NULL;
> > +
> >        if (p[2] && streq(p[2], "dir"))
> >  	options->ssl_flags |=3D SSLF_CRL_VERIFY_DIR;
> >        options->crl_file =3D p[1];
>=20
> Feature-ACK.  I think this is a great idea.  This allows us to do an
> if(inline_file), instead of doing a strcmp against the 'magic inline
> string' everywhere.
>=20
> However, I think it would be better to keep all inline file handling
> consistent.  So I would prefer a patch that does this for all inline
> options, and replaces the strcmp()s at various places with if(inline).
>=20
> (Thinking about refactoring this, wouldn't it be even prettier to change
> crl_file_inline to a bool, indicating whether crl_file contains a file
> path or the file contents?  Might be a matter of style though, so feel
> free to ignore if you disagree.)

I totally agree on this.

I was planning to do the rest of the refactoring in a second patch.

At this point I think it would make sense to reject this patch and wait for=
 a
full patchset set where I will:

1) "fix" every inline option to be sure that we don't carry around bogus
settings
2) switch any *_inline field to bool
3) refactor the code to avoid strcmp()


Thanks for the quick reply!


Cheers,

--=20
Antonio Quartulli

--fUvfsPTz/SzOZDdw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYEKQxAAoJEJ6F1zG2JyOsmrsP/27NjZtwEYBGxsulXwQkBEVE
hHcuXtk9XXI3BPkFXAp9U6kuiQUakwIj7POlVB5F1U+HtvlxnObzUrZ2CBtB7I1V
fBzIa9qM4SPVj7kYsyuOZygXM7MRiMK1bCF9M10GD72DGUcAdTFDxaZY0NIkOA4a
AeatzhvGV2Ika1YuNrdegoYWaigvmtI5O6NJ7CBovyIbSWk3cBXzgydlK9uqqfpR
14zBs/bvd0+e/buwV65EkelvFq8b3sQuQCgYpPG5qfCd4cSwKUzPxsLYJeUCWqw3
d+jxSa4Tj4dWFJcTAkunkFjmQ81lQ5qvjWLTB5gMxGFGbLUGiFNDYAzEZSwfXiLK
wv1eNVZMcMisBZmexQzhP4Sp9qQcFEeq2H5bgYBe0fDQ7H7Mn9kWlIv4zvTdobPe
93O2ppbLkoIzn7EwkxD9v6+Uss5tNinfRMLPz8B8krITVSoIIz2mxR+caR4ZOscU
VGvASVSAbDAJYNIayXw8NexwMvblbjnm/DxIs9U8MTdfMtot/huM8S8/A85sdQNZ
2CFu7niSyXOaKgUVWjACr4w49LKPAH1s5T3oGkbje8aZatlCF0yAAFYcdwJ1vIrL
+TVnyzi3Qm6hKWfIX8uWKq7aH87Ew93GULelXUt+NrlHNl7Kl46ulnp9+l6RVWoG
tP3ZYp/4D5LXAx4XSzMR
=k7u5
-----END PGP SIGNATURE-----

--fUvfsPTz/SzOZDdw--

