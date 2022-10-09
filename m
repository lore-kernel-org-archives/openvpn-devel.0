Date: Sun, 9 Oct 2022 14:55:16 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Y0LEtHfB/8beDBjj@...1296...>
References: <20220217182234.33850-1-arne@...1227...>
 <3032908.4Ter4YMrkd@...2664...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="uh9tWObSxeAIXV6s"
Content-Disposition: inline
In-Reply-To: <3032908.4Ter4YMrkd@...2664...>
Subject: Re: [Openvpn-devel] [PATCH v3] Fix OpenVPN querying user/password
 if auth-token with user expires
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

--uh9tWObSxeAIXV6s
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 18, 2022 at 10:26:04AM +0200, Heiko Hund wrote:
> On Donnerstag, 17. Februar 2022 19:22:34 CEST Arne Schwabe wrote:
>=20
> > @@ -590,6 +590,7 @@ init_query_passwords(const struct context *c)
> >      /* Auth user/pass input */
> >      if (c->options.auth_user_pass_file)
> >      {
> > +        enable_auth_user_pass();
> >  #ifdef ENABLE_MANAGEMENT
> >          auth_user_pass_setup(c->options.auth_user_pass_file,
> > &c->options.sc_info); #else
>=20
> This should be inside the #ifdef to do exactly the same as before, i.e.=20
> doesn't introduce side effects potentially.=20

Actually, it shouldn't.  The #ifdef is

  #ifdef ENABLE_MANAGEMENT
    auth_user_pass_setup(..., foo)
  #else
    auth_user_pass_setup(..., NULL)
  #endif

so either the enable_auth_user_pass() goes before the #ifdef, or would
need to be in both branches.  So the patch is fine as it is, one can
just not see this from the hunk alone.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--uh9tWObSxeAIXV6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjQsS0AAoJEB2Cnv7KVigS8a4L/AyP8MXFj/Uez7bhjxz0Iq2G
S1fs3Wi0oD/5JBKCsri8BPY6Y2TjAut4C0LrDVWCHv42/A5IDp9UzJTGQLCrw2Ia
uJQ7NpErG0QwB8LBEFX1/1MeUs7Wfy9sHnuLCw8BGEaGns/8YhPi9bdaoviPThSt
k30i4cj7JwyIFHDJRmMGtEhCCGVOP6iJ7NWGbD5afR8Vp2dAi+LJIldUiYqsgUDb
2rNdq1Z/pdxB73KCX5SK3RGSBIDADvkEwMoX302HKxQDPd7HAJobLtNweV+j5kHT
fXgEIX50RrSFIUV8anJUEgTKtJcCSxZzTQFrSSOzmWJ7ayBmtrL8POVgknb5vpA9
9c/H2Zlz0C0UKdHvr7ZGtdhlpmUWBvVd/jQf9+xCRcSskoQVg+9xkpBBYIDZQIwy
DRxD8JSM5gCgLeO0cEcg8bJPtxqqJ5JAaI57D9vyDYfp6rw+E6i+5hb/S48v3pF7
2G7CjA/rZG03Nj/F0Vwxu6uUlDq3sMyetuVDxKNYPw==
=G3xs
-----END PGP SIGNATURE-----

--uh9tWObSxeAIXV6s--

