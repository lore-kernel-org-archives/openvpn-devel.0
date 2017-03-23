Date: Thu, 23 Mar 2017 11:11:27 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20170323031127.GB24725@...2182...>
References: <e79eb6bd-87bb-a8f7-eda6-e65b33addd24@...277...>
	<0440d93b-6ded-9efc-8fba-838b4e954261@...515...>
	<a4da2c12-b6ba-08c8-9de3-4ef127aafe3e@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uh9ZiVrAOUUm9fzH"
Content-Disposition: inline
In-Reply-To: <a4da2c12-b6ba-08c8-9de3-4ef127aafe3e@...2080...>
Subject: Re: [Openvpn-devel] Consider git tags for I60x
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, Mar 22, 2017 at 02:11:56PM +0100, David Sommerseth wrote:
> On 22/03/17 10:07, Samuli Sepp=E4nen wrote:
> > On 20/03/2017 17:13, debbie10t wrote:
> >> Hi
> >>
> >> just so this does not get forgotten about:
> >>
> >>   @dazo | slypknot: https://github.com/OpenVPN/openvpn-build
> >>   @dazo | I see that there are no tags with the I60x indicator ...
> >>           that could probably be something mattock should consider to =
add
> >> @cron2 | true
> >>
> >> Regards
> >>
> >=20
> > For openvpn-build I have not added release tags, as the commit message
> > usually contains the necessary information. For example:
> >=20
> > ---
> >=20
> > commit 23d42200f282d2fcdc57bd4262d1fffc0832c7ff
> > Author: Samuli Sepp=E4nen <samuli@...515...>
> > Date:   Tue Dec 27 12:31:39 2016 +0000
> >=20
> >     Update build parameters to match openvpn-install-2.4.0
> >=20
> >     Signed-off-by: Samuli Sepp=E4nen <samuli@...515...>
> >=20
> > ---
> >=20
> > Adding a tag per installer release is not a big deal, though, if we have
> > a use-case for it.
>=20
> Currently we do not have anything providing a guaranteed match between
> openvpn-install-2.x.y-I60z and a particular git commit.  This helps
> understanding what a release really contains, especially if you have
> more commits in a release.  Then you just do:
>=20
>    $ git shortlog v2.4.0-I601..v2.4.0-I602

I like this too - makes it really easy to revise what was changed between t=
wo
releases/tarballs. It's basically one little step more to perform when crea=
ting
the tarball.

>=20
> Another aspect is when you do signed commits (git tag -s), then the tag
> is "cryptographically bound" to a particular git commit.  That is
> incredibly hard to manipulate.  If the branch itself is modified the
> committish will change, thus there will be a mismatch between the branch
> committis and the commit the tag points at.  In fact, if you do a git
> checkout using the tag name, you will most likely get the correct commit
> checked out and not the manipulated one.
>=20

+1 on signing the tags - this increases the confidence in the code somebody=
 is
downloading. Manipulations are found immediately (unless done voluntarily by
the committer).

All in all, I think it would be worth adding these small steps, as git makes
them really easy to be performed.

my 2 cents.

Cheers,




> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot

> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--=20
Antonio Quartulli

--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbWDi87MfnL20Ye22noXXMbYnI6wFAljTPNwACgkQnoXXMbYn
I6yCNA/+NkSVDQ09dNCVWKjqlm9mfPLz6zR3E7vqJboRyG1hs7bmo5tF8Pn1aL5o
wNAiWK7gxwAnasmi8cTjtmWQPfLb/3sXz+HB5Bu09hCdrl9CYXStVzP7zC3V67M8
Sp1OwIFVesb8dCZZX9TOcxr2qRKpy4YXtxOjhRKu+6D6GTdqfSLsgf9BGCY4qAvr
IlLTahDWbfWYXRKC4IvqM6Sss0hd37eRaoaawsjC5R53/ZJCZBiKbgcd9uyQTnv/
yMyEYwXBZj00YvnUggVoEqBFh8kgUeN1e759mGjm48bdBAS7dbtkn5b5KHWNTLJZ
b2fp2isOi1yzbAhHJ+zeNUe6SSfqk+r6ikEwSWnFY+j+PkBWW2SXBrS+JDWIL3NG
txHqMe95lH1TbGakPmzFTH6TFIDcbXlhUBd6l6CzIRgY7h3QqD9HrpetjXHpig6y
X2WdiluMtnPT51IbJ7Zbbik5Mm/dvofDS/esP34IAM3PMTYO9SLbeIJszqDo2Vrd
P7mRMiVddrFqh2qBgCQMQOJAmMyQ674dNkEU5WjY/Pf0q7K3X33dHUVGkuXatTSB
7fvRFANO5ueJwnPTkshPYadB84qTO3S1dx2rI86380J9utxzljKXfaGQVnubXMiL
kN7aeuAmDx8FFVLkWDof3RA4xh7ocBnDQZGbwoW2JwCCsErWBR8=
=NIkd
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--

