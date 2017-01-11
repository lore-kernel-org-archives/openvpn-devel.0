Date: Wed, 11 Jan 2017 14:32:37 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20170111063237.GQ18524@...2182...>
References: <20161227112436.5045-1-a@...2181...>
	<97c51277-d8b7-b768-5205-706492e92f84@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Jbyekxk18hnEXT0m"
Content-Disposition: inline
In-Reply-To: <97c51277-d8b7-b768-5205-706492e92f84@...1856...>
Subject: Re: [Openvpn-devel] [PATCH v2] convert *_inline attributes to bool
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--Jbyekxk18hnEXT0m
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tue, Jan 10, 2017 at 10:35:10PM +0100, Steffan Karger wrote:
> Hi,
>=20
> In general this looks good.  Some remarks inline.  Please bear with me,
> we're almost there ;)

No worries :) and thanks for taking some time to review my patch!

[CUT]

> > +    if (!options->extra_certs_file)
> > +    {
> > +        errs |=3D check_file_access(CHKACC_FILE, options->extra_certs_=
file, R_OK,
> > +                                  "--extra-certs");
> > +    }
>=20
> ... more add ifs follow.
>=20
> I don't particularly like all these ifs.  What about adding a wrapper
> function like check_file_access_inline(bool inline, int flags, ...),
> containing basically "if(!inline) check_file_access(flags, ...)", so
> that we will here still have a nice 'check_file_access*()'-sled?
>=20
> (Thanks to Adriaan for the suggestion.)


Yeah, I liked the idea.

[CUT]

> > @@ -5154,7 +5194,8 @@ add_option(struct options *options,
> >          {
> >              options->plugin_list =3D plugin_option_list_new(&options->=
gc);
> >          }
> > -        if (!plugin_option_list_add(options->plugin_list, &p[1], &opti=
ons->gc))
> > +        if (!plugin_option_list_add(options->plugin_list, &p[1], is_in=
line,
> > +                                    &options->gc))
>=20
> Can we inline a plugin?  I wouldn't think so, but I've been surprised by
> our option parser before ;-)  (Arne or David might know this.)

Personally I don't know :) the parser logic seems so generic that I had the
feeling everything could be inline'd :D


> If not,
> you don't need to add the is_inline argument to
> plugin_option_list_add(), but just add a 'false' when someone down the
> chain calls make_extended_arg_array().

I agree with this - it is the right thing to do.

[CUT]

> > @@ -6496,7 +6531,7 @@ add_option(struct options *options,
> >      else if (streq(p[0], "push") && p[1] && !p[2])
> >      {
> >          VERIFY_PERMISSION(OPT_P_PUSH);
> > -        push_options(options, &p[1], msglevel, &options->gc);
> > +        push_options(options, &p[1], is_inline, msglevel, &options->gc=
);
>=20
> Same as with 'plugin', I don't think we can inline a 'push' option?


My understanding is that the code allows for push-options to be inline'd, b=
ut
right now there is no push-option that can be used that way. Am I wrong?


[CUT]


> > @@ -1209,11 +1204,12 @@ tls_ctx_load_ca(struct tls_root_ctx *ctx, const=
 char *ca_file,
> >                      {
> >                          crypto_msg(M_WARN,
> >                                     "Cannot load CA certificate file %s=
 (entry %d did not validate)",
> > -                                   np(ca_file), added);
> > +
> > +			                       print_if_inline(ca_file, ca_file_inline),
> > +                                   added);
>=20
> Indenting looks off.

Thanks for spotting. Will fix.


Cheers,

--=20
Antonio Quartulli

--Jbyekxk18hnEXT0m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYddGDAAoJEJ6F1zG2JyOsoh4QAKrfArmwnWz4OWUZTX0i3Z8W
ZyEg/+yMeh6wKROgJaW0uA3AcwOAb2lULWq8raQPDOvE9ZfqB+rMkNZ13hZqU5/z
FaxEyPp9fzjtiQ6xNe738In+kE5NnUTUsXw8KtineWHP1VUtALWu2Do5XaIFiTFu
66SkUBgv5J6HbfnygofgbYueiCAB+cxPtgtJkVz8Qr7V79bImoen5yUVQMWl6omc
ttWAm8lwqa8+EU1/JDbD/25HaM4o/nsxDRpvY1fsiF7w4D1tMvSCKnfVkk0EEvPk
RVGn73J/MVR62OziiK2tUIIloHPX2fXr1lr4SfD4ERaa/ZrIaCEAsNlDfoSR8BuX
BiBC0rp0EpdVpoVOuTyg4Wcsk62mba1LBTqRyeTFQQIggFsvjOjIp0Ym0RUvjFPb
jcotH92Y7ofHfaPq9WUWI2wekt2Sic78iUNckcfFpCCFoSo5kuT8rkHe7ZSvT3l7
3FlxmJxUOwLoaSTPN9Ilh384P6J8yRk397LdJ8Y3eoVzcZhnaU0hoL3StPoqT/4Y
YJ72l1E0aEY3LzjZBx+1/2VAbQjnBI7Jmw+Tm+Aor2rFTI3Nn/jlUoxhp3A4vBZ7
Ax18JexeLZY19AtOCmQ292CP1UA6SCUD7iljM48tvneGweZii43Cv96EfR5rWdA3
fS3HFILaNbaK9RECApCB
=gAek
-----END PGP SIGNATURE-----

--Jbyekxk18hnEXT0m--

