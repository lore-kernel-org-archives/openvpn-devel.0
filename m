Date: Mon, 11 Mar 2024 17:32:56 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Ze8yOJzqQ3W5fbe1@...1296...>
References: <20240308102818.9249-1-gert@...1296...>
 <202403081151.428BpXTq026459@...2054...>
 <Ze7ulBhO5hBj+Z1o@...2685...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Fj6xH3flwFm/CYi1"
Content-Disposition: inline
In-Reply-To: <Ze7ulBhO5hBj+Z1o@...2685...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: t_client.sh: Allow to skip
 tests
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--Fj6xH3flwFm/CYi1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 11, 2024 at 12:44:20PM +0100, Frank Lichtenheld wrote:
> On Fri, Mar 08, 2024 at 12:51:33PM +0100, Gert Doering wrote:
> [...]
> > Your patch has been applied to the master branch.
>=20
> Could we please cherry-pick this to release/2.6 as well?
>=20
> Would make it much easier to use this capability in our buildbot
> infrastructure and the patch only affects tests anyway.

I did toy with the idea, but was afraid it wouldn't work as so much
of the new unit test infra is only in master - the t_client patch is
trivial, but ntlm_support + mock_msg.

Turns out this went smoothly, so here we go...

gert@...2718... ~/openvpn-26.git $ tests/ntlm_support
gert@...2718... ~/openvpn-26.git $ echo $?
0

(openssl build)

> > commit 0c7cf0694ee6f878168330e9a084c255c51a9e8b
> > Author: Frank Lichtenheld
> > Date:   Fri Mar 8 11:28:18 2024 +0100
> >=20
> >      t_client.sh: Allow to skip tests

commit bbc77d1719d2d5b33e58abac5eba8b8e409561ab (HEAD -> release/2.6, vweb1=
/release/2.6)
Author: Frank Lichtenheld <frank@...2641...>
Date:   Fri Mar 8 11:28:18 2024 +0100

    t_client.sh: Allow to skip tests
    (cherry picked from commit 0c7cf0694ee6f878168330e9a084c255c51a9e8b)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Fj6xH3flwFm/CYi1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJl7zI4AAoJEB2Cnv7KVigSA7EL+gO/PhxOfjUd2LVvRZ0K5Mou
1FRtngEhxDl0yzuCrOVNQXiGgcQEflmx1QqhpZruFfPw4DIcXsCcol4I/DkGFaOO
ugipwkUXRmRAAqluQSBnMXBEYIstGLdWBKrEKuusO3yB42pW/8DkzQMdoaKFb8Ef
aSCV3n7GzSaLxB8OUulH6bhz94ZUqG/0ElMJxydXyR+9LayYLm/lJ1H+6ZunE3aS
yh9GH7+6KFBSsPujh/2orzCPIKMltyZ494foaBqRMAoZHI02HV3jUMnFV0+sk5rc
Cv0Y3nIWC38rH4J+j134TbFnGvCRUw1y17f90H0zd8aZlr17RXAi41CvK/UwMLja
KGBje/Of/F3psvD4l81uc4DD/1uiQcgbcaZZkt8BgiFJZGZjhDlizNdNV/EF9sbT
ichFqi23lm+0AY43I3g/pDPMqtK4l0GDFOe10/4qs48u652Qc1FIizm8wtBFZiEB
vUfntPuq202MWstpwB3MwJCrcsannKHVfyU5DYMTig==
=0e0A
-----END PGP SIGNATURE-----

--Fj6xH3flwFm/CYi1--

