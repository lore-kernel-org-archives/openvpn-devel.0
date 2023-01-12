Date: Thu, 12 Jan 2023 08:55:37 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y7+8+QVS4iM6DgB/@greenie.muc.de>
References: <20230111160848.22906-1-gert@...1296...>
 <3991c027-442a-b869-196e-ceebf3eca1d9@...2181...>
 <CAKuzo_iZO9WW8xUJS1Qc-DNF5A2+UhK_0v8bzt21A7z9KG8PHg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="mPAIsP2+lIi/YFef"
Content-Disposition: inline
In-Reply-To: <CAKuzo_iZO9WW8xUJS1Qc-DNF5A2+UhK_0v8bzt21A7z9KG8PHg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Repair special-casing of EEXIST for
 Linux/SITNL route install
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Antonio Quartulli <a@...2181...>, Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--mPAIsP2+lIi/YFef
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jan 12, 2023 at 02:50:27AM -0500, Selva Nair wrote:
> Not sure I understand "can also be hacked alone".

I think that was intended to be "acked" alone :-)

Anyway, thanks for spotting this, and shame on me for only testing v4
("the v6 stuff is new and shiny and has none of these problems") - but
of course, the v6 netlink stuff was written together with the v4 netlink
stuff, and shares traits.

I'll send a v2 with v6 fixed and tested.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--mPAIsP2+lIi/YFef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjv7z5AAoJEB2Cnv7KVigS35IL/2eXn0KBIVKwIJRJzK+6KtQM
1U4ugNaKhqtCtGwQfn1RoDY7gnTJMy2FYLzm4CdDA/qPJyYoyHETeJ4WBwmaG1dj
h2gtZX2QX7awmdbBIqzggkWHfGpNOBGMytMlup++nZrKw5lk3wK2ZEb37DJm3irM
s/dU3Fk/B9Oi2By7uMSk/m9qpP4aEtoxdHASDVpFP2SS2YpmipXBB+lLF9R492QV
nkcWOWpyyRKkkLDfd/4zeFSr5LV/YMTHh3M2Xvykufrs5u/D+EcgVxCmt+CBEMku
gN7iRAl9Il/gxwDdpB87Lk9nQxrPoCxkhA+fE+w16JGPUg16rVco6481qn+HVMc8
WaqaTel0CRKQ2VrMp2vWnoUIsLfuWx+eZys44g1oZ5i0DiqnHKnd0vDZJ65MNMgS
hpk0fBq2YPrdsJjKyksTS6ByILjmV4AS0L9FXk+eYN2FeP9mFxNRkulIb/WAqFPK
Xec95P3dgmYPu1M3+aJi7nn9KDWqtofr4TFv9T8QFg==
=6dqE
-----END PGP SIGNATURE-----

--mPAIsP2+lIi/YFef--

