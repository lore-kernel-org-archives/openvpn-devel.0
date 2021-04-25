Date: Sun, 25 Apr 2021 19:26:08 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210425172608.GY976@...1296...>
References: <mailman.44934.1619368532.1299.openvpn-devel@lists.sourceforge.net>
 <CAHhAHvhNmyRKYuMA8b2cWgL9MvRbo62QPVh34AZLOyVKfcQ9Jw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="bLuQDSWLyIhYXw1d"
Content-Disposition: inline
In-Reply-To: <CAHhAHvhNmyRKYuMA8b2cWgL9MvRbo62QPVh34AZLOyVKfcQ9Jw@...278...>
Subject: Re: [Openvpn-devel] Windows openvpnserv2 default reg values instead
 of crash
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Nilsson <nikize+ovpn@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--bLuQDSWLyIhYXw1d
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Apr 25, 2021 at 06:44:34PM +0200, Christian Nilsson wrote:
> I have been wondering if there is any particular reason that
> crashes in openvpnserv2 should be preferred over
> having default values if missing from the registry?

openvpnserv2 should never *crash*.

"End itself with an error message" (which is not a "crash") is debatable=20
for default values that leave no reasonable default fallback - but=20
generally, if it makes sense to default to something, this is a good=20
strategy.

So, please send patches :-) (using "git send-email" to stop your mail
client from messing up tabs etc)

gert=20

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--bLuQDSWLyIhYXw1d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJghaYwAAoJEB2Cnv7KVigSyJAL/39Hj1Er5zd/PTuCTndnFqb0
HuwPYcR6mTldgqnSX3HlCt38cp+mkVA4W44oCABmP/Irdw4CyK5ErFylC9A8552E
PJKboWc9rbuQ6GTi4aXx5N7j9aZ1/bwjT6vEBmybOzo7TEXBRAvOkySRNOlm9hav
/5DxgHonQJhn29A9OA1QScfl68G3mMaioCRbs7m5Cwjxha2Uk86w4bnhhRH5pVOL
ldGidWvNSLFptcBzkcUrtyHvi3Pd9KsMtlwVXFgLOekK9Q5u881WxJ2c1cE6fBJD
NLb5cU6mY4vmGHHqwM/6yzcd/TENXzDwCcNdENJw8OwTAc6TjMYFJZLbFJseW1sD
Yr6W8VOdgvLkKmbnnjW+qlcALS97iD74QVvN6Hjouj09SqwOh7huI9lmOalwgj5M
iE3jF5LpnuJxeQHMB6uCWu5KtjH8L0lG4lGcFn08zDt/xyyWSp18MkO7UEOne8Pq
AOQer90M75fFxub2l7RIXOmTWTrSVwr5NB2x8QMVWA==
=w5Rj
-----END PGP SIGNATURE-----

--bLuQDSWLyIhYXw1d--

