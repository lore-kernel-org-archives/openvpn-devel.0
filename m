Date: Fri, 29 Nov 2019 12:37:40 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20191129113740.GV40538@...1296...>
References: <20191128080631.117-1-lstipakov@...277...>
 <E1iaLck-0000Aj-5c@...2508...>
 <CAKuzo_jR6WYsM9QZhdyp8sW6avFGhDnFzx_dNN63JD4iiSmFag@...278...>
 <20191128194320.GM40538@...1296...>
 <2aa50cbc-cc17-81d5-ec9a-98fd5e8ba503@...2080...>
 <20191129105207.GU40538@...1296...>
 <f9930229-0e7c-a03d-3050-dae11e59b2c6@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="UTzqATxFly6eQdwo"
Content-Disposition: inline
In-Reply-To: <f9930229-0e7c-a03d-3050-dae11e59b2c6@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] fix clang warning about missing braces
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--UTzqATxFly6eQdwo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 29, 2019 at 12:25:13PM +0100, David Sommerseth wrote:
> On 29/11/2019 11:52, Gert Doering wrote:
> > On Fri, Nov 29, 2019 at 11:47:02AM +0100, David Sommerseth wrote:
> >> With GCC-4.3.8, I see this warning:
> >=20
> > This is about as old as you :-) - do we care about suppressing warnings
> > in old gcc versions that might suppress a *relevant* warning when
> > compiling with a current gcc version?
>=20
> This is the default compiler on stock RHEL-7 ... which goes EOL August 20=
24.

We're not going to break it.

I'm just not going to care very much about the warnings it might throw
(and I might object to any patches that are "just for the benefit of
suppressing warnings from gcc-4").

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--UTzqATxFly6eQdwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJd4QMEAAoJEB2Cnv7KVigSFc8L/17WHK4q/OacZ5x/fZFafOfW
71zb2VvJrsplRuB5pp473VZ/IV2uiTO95ACHvFWL8OE8Wiw9ge0LBQVKYGAioGbM
6IB45dflqs0bp3+uDF1ApJLpr8ja+TistNzQ+8gKDirImHekI7EO+6CNZN0n7zBS
MEuD8R/3zPVIC1mtzr8j89cCTmtnq58ndd3GvZzTet/zx25a+ps1C4SMftsZW1tc
Dk1Bx0qu/MnCDQCC9SK/gM4HXes6uz3uh+JPRe4DnFCXD6dh1cTJeX3kiiOveiRF
BHL+Jau/Rl5B4J8f7nfwoWwFS1vE5THaOS0qUZ0Y1/ss6zREQEGf4JvWcxR3JmCN
pNKeCgKUhdNUz/aL8LDRgvCmutXuuh87MPrXPsEucs3bGbb3X5NQ4VfmSa94tqa4
KntE3sYQ6NZZvx49OqEJ9yyEtCP1M27O4T4jgigzmR7ThOkD3QjEFheuHR/Pglt5
D1kBL2EYH+RiPJdDLglMLltn1qD2vPK+lxFcHGJnaw==
=qMwO
-----END PGP SIGNATURE-----

--UTzqATxFly6eQdwo--

