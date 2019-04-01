Date: Mon, 1 Apr 2019 22:40:32 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190401204032.GH31008@...1296...>
References: <20190329193805.GQ31008@...1296...>
 <20190401112140.13212-1-cschenk@...2502...>
 <20190401112140.13212-4-cschenk@...2502...>
 <CAKuzo_iBrGGWghyvyV5TUtYqd+q7W6aZHproMbBhHzS5i139Kg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="TdMwOTenGjBWB1uY"
Content-Disposition: inline
In-Reply-To: <CAKuzo_iBrGGWghyvyV5TUtYqd+q7W6aZHproMbBhHzS5i139Kg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 4/4] Simplified if statements for better
 readability
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Christopher Schenk <cschenk@...2502...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TdMwOTenGjBWB1uY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Apr 01, 2019 at 11:59:04AM -0400, Selva Nair wrote:
> Finally, I'm not sure whether we still require patch authors to follow the
> code formatting style or we automatically run uncrustify during merge.

We have decided that all *core* authors are required to either run
uncrustify or "get it right on their own" - but Christopher is not
"core", so I could do that for him.

OTOH, I prefer to commit patches "as they come in on the list", so,
no code changes by me, not even formatting...

@Christopher: the source tree has "openvpn/dev-tools/uncrustify.conf".

If you copy that (on a unixish system) to $HOME/.uncrustify.cfg,
you can just call "uncrustify --replace $sourcefile" to have it change=20
the file to our accepted coding standard.  Much easier than hanggling
on the list later on.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--TdMwOTenGjBWB1uY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJconc/AAoJEB2Cnv7KVigSzugL/juBpQ9h6kD9avl52AyOuqtZ
IqUnyAICYstCaqnUWxO1dDv5wWiHiJ226PYrUGdNxR+wdqUNekYgkMsURIsEKiUd
1MmYHXbc6QTtP8sVKsQywfcIssLjNFaCMNROsy4TzPTrcW8Q8pMY6oKXpJFdfYvi
Y18pEaeOwSI6djG6eELvW1WLxQBQUi9/jFbJ9joS7d1eAavumeWYcsat7mJVv8c5
m6NIqQBYysU4UOZ6P9P1lyKZBaWRfCQEGyvmuyhS1+y8taIPW79Fzn/GAYZXUsPg
gbwQrxr0/MDPZmAwQFQy1fpGu6L9cLHnnKB2rjaUsBSHqLdTr6P3zPM5Bgw7K6n1
Km3oLSvfb5DREnpXzP/2rPN1WXz/1+qFrlQqITij/2P8Ih/bJnX7PpzUcpmWDZgi
+Yll6Yi5igpWTsWFAooLJeze0zD2RZgc2dALrTnUKAT2KfPOwI0pEYA8gr471kDT
I3DYPBwei6tvJykGusJyMW28ufedPl8uY98VhHWtZA==
=+1Ef
-----END PGP SIGNATURE-----

--TdMwOTenGjBWB1uY--

