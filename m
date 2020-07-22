References: <20200722095446.25141-1-davids@...515...>
 <e0212118-cc75-f823-ff4d-4a496269bae2@...1227...>
 <2b58ab7d-78c5-5d31-ae3e-5c0c2166e08a@...2080...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <08acf9ec-16b6-74e8-bcc5-0f14e6ad3bef@...1227...>
Date: Wed, 22 Jul 2020 16:41:28 +0200
MIME-Version: 1.0
In-Reply-To: <2b58ab7d-78c5-5d31-ae3e-5c0c2166e08a@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ucfZhqJfmP1FAJFAfBUy7f7JryuMIjt24"
Subject: Re: [Openvpn-devel] [PATCH] options: Remove --udp-mtu
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ucfZhqJfmP1FAJFAfBUy7f7JryuMIjt24
Content-Type: multipart/mixed; boundary="0xu1F9JUjXotnvdypWwM42AWrXQHlaj6Y"

--0xu1F9JUjXotnvdypWwM42AWrXQHlaj6Y
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


>=20
>=20
>> But with alias I feel we just removing them because we found a newer
>> nicer name and as a user (especially another dev) removing an alias
>> feels like they are removed because of pride/principle that since they
>> are old they must be go away.=20
>=20
> This is really not my motivation, I do reject this sentiment and implicit=
ly
> pointing it like that towards me.  Lets keep the discussion on the techni=
cal
> side, not imply anything on the personal side.

Sorry, this was not meant to be on a personal level. I was more in the
idea commenting that it might looks like that this being the main
motivation since I find the other reasons not convincing. And external
people external who will look it up and find the only reason in the git
log that we added this alias 17 years ago and now remove it because it
is old might get exactly the same sentiment.

> What I do believe in is our role of maintaining this project.  Which mean=
s we
> need to clean up.  Some clean-ups are big.  Some are small.  This patch i=
s a
> small one.  Some times we keep options, some times we kick some out, some
> times we migrate them to better alternatives.

Yes. I would argue that here the benefit of keeping the option is small
but the benefit of cleaning up is even smaller, so it should stay.

Arne



--0xu1F9JUjXotnvdypWwM42AWrXQHlaj6Y--

--ucfZhqJfmP1FAJFAfBUy7f7JryuMIjt24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8YUBgACgkQFRhsZwKx
RFTVzQ/+PssbyYR9ksEXW9iMLyRYcT7V90q/P7B4qoyNqe4SpzJ+E51aVWT90ji+
b+iM1Rq+k/bPTwK80pMfuiJ51rkxKFzV3gjCJ/aRSrMEZ9+qHiiCR7Nmz6mkOHR3
bEi9O2Hfex5et/+d1UO6+LokpqdD86l4ojCBYQJn8DAKCQn1+XIdWKBRa251pt/C
kBJpIyLgPdCtWWsWMR/HSsyeN2+/gyeqR/VaSJeyIC9k9e+LSCdNIApVxhFdTVPw
/ZKOTEUkMIuml9iJy2bYmtHkr5/WzT+Rh/Y3Fn/KMHP8mOqT0UqxjFN6p2LrHerZ
1zk90vz+oCg6XMFm4VmqHGd6+vq6CNfibr86M6pcW7LoAvH/My2UKMK4XGB7vROH
6EaJZmyF2Ih2VxxC9OPe4kjDxw8yYaUY5yjr1a+EAlBMUC+JHfOhRFJdZz6rAj7c
OJDmHAO7h3KlFlITJgoa51CDDd8UrQIjmmmzP4Qdy3Ro/iJzFcpawnKBpW1MoXbt
B9zBTsTNUCshlWdk8TGO7VsL1XglLajHtM4Wy7/CDOThI6gc5Z6bY2wilrPRJWUl
CI5JQxNZmzDIsZqbyQlk2rrqkD39S6ZDsLqkn1JulrFVb+YqpF2tIQxl0sAt9wMs
pNOlWkVFONHeTWb49L4gaw7vbXUbVdSMqvxNh2NaXRSHp3pheS4=
=QoPl
-----END PGP SIGNATURE-----

--ucfZhqJfmP1FAJFAfBUy7f7JryuMIjt24--

