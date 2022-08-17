Date: Wed, 17 Aug 2022 17:24:12 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yv0IHO0RZL4ILkdf@...1296...>
References: <20220810094605.123072-1-frank@...2641...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="rf3kIQIeyxDOgrLG"
Content-Disposition: inline
In-Reply-To: <20220810094605.123072-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH] dco_p2p_add_new_peer: do not warn about
 missing default gw
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

--rf3kIQIeyxDOgrLG
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 10, 2022 at 11:46:05AM +0200, Frank Lichtenheld wrote:
> Currently we issue a message when using --ifconfig but
> not specifying a default gateway. This seems to be misleading,
> the setup will still work fine since in P2P we now send
> all traffic to the peer anyway. Or it might be irrelevant
> if all route specifications include a gateway anyway.
>=20
> Since it is probably better to have no message than a
> misleading one, remove it.

For the record, this is has been obsoleted by=20

  https://patchwork.openvpn.net/project/openvpn2/patch/20220815223941.26839=
-1-a@...2181.../

which rips out the whole section of code, more than "just the warning".

much better :-)

Setting this one to "superseded" in patchwork.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--rf3kIQIeyxDOgrLG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi/QgcAAoJEB2Cnv7KVigSWLEL/j33hgARVY4Jz860EaEzJjjw
2nYLgsm3md9zq3rHf402WpWIyRkJtwEcdNWvxrTchhy36CfhZnGRWXghMgKjdAxR
JTame2HWoI/wZ5EDvxXJHTjjoxGUw6E1UZs8bd/Msm8xehIpd+XOth0QuYdmyIEC
gcaNi5Nxes2JuJqVKfAMmCBWYURn8btV/ZDNp7UO4ftoOsBv4xbheLdYexidW4lK
j8GKXZc0MD42iNkz94ktBMXqozqMUCIw7ZTl0QN+SKklmN4ZrC+bfMghq2FAAZxZ
rdSxU1nQMhjj2gO72RRj54VWyH9PP8QHbH20hrD92DgKoe03mTJlGbt4IBI7/Fe3
RahGD+bHQlfHJJKs5LBgljjihO7BSeJ6evdhfvsqE0xKyZg9OlPlyM+mcjg/AQKJ
at1Wilp+WKg2fFs6Rxm0GJ1G7Knpykb/xnfKZaydeo7yjtz4qMf9V7TKYWAD239/
aBLOZL0qMNxe/FhlWcGQALCFreF3kW0ctoAhIPyymQ==
=NYzJ
-----END PGP SIGNATURE-----

--rf3kIQIeyxDOgrLG--

