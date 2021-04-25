Date: Sun, 25 Apr 2021 22:52:20 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210425205220.GA976@...1296...>
References: <mailman.44934.1619368532.1299.openvpn-devel@lists.sourceforge.net>
 <CAHhAHvhNmyRKYuMA8b2cWgL9MvRbo62QPVh34AZLOyVKfcQ9Jw@...278...>
 <20210425172608.GY976@...1296...>
 <CAHhAHvhQmvtJvY0CBqCp_viU1wckZ61BQ5kEaHki8Mvy-nPJjQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="oqPdk2VGBVXm4Qm+"
Content-Disposition: inline
In-Reply-To: <CAHhAHvhQmvtJvY0CBqCp_viU1wckZ61BQ5kEaHki8Mvy-nPJjQ@...278...>
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
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--oqPdk2VGBVXm4Qm+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Apr 25, 2021 at 08:06:27PM +0200, Christian Nilsson wrote:
> On Sun, 25 Apr 2021 at 19:26, Gert Doering <gert@...1296...> wrote:
> > On Sun, Apr 25, 2021 at 06:44:34PM +0200, Christian Nilsson wrote:
> > > I have been wondering if there is any particular reason that
> > > crashes in openvpnserv2 should be preferred over
> > > having default values if missing from the registry?
> >
> > openvpnserv2 should never *crash*.
[..]
>=20
> Indeed debatable, hmm, but to be clear and avoid misunderstandings;
> "Exception occured during OpenVPN service start: " ..
> and rethrown exception that is not catched, so I still actually do
> think that crash is the correct term here.

So, yes.  It should never do that.

(I did not investigate to see what sort of "unexpected exit" it did,
just state this as a sort of governing principle - if it aborts, it
should so with a clear error message, explaining what is wrong.  Not
"uncaught exception" or "segmentation fault")

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--oqPdk2VGBVXm4Qm+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJghdaEAAoJEB2Cnv7KVigSbaUL/09lO48evDGYaQbcBdcESGs7
TOrttxYXPRODU0iOXsYSFs9Z0U27XNbyt/3d/b95UEyqtotdQoZjxBDWEYhNJzmQ
F9fjH3tPzSEscCPN5BjQZQfB8VRO8EuAYWxLiETI7awP1jE49gmMDHSkufqKxNEr
FN+ONzwYRRXZqYj0Dtmr/X3lDfrCXwodKMKkJvcqyWdu33zJRon7A4YKtKzZUGuA
vMREFPJQPuGw2KyC6kEXe0Hf5OwZqIBJ9bnM3v43/lp5D2q2/IKzjQ1Ky87iTAuJ
/v7jiorAANPzODOfRAjHjGzwVfkzoJ0sq0DlRBq2RK4Bg5SD4JbckoYQyIM9dL+h
MaG7IyNzTRm97MFBSGFbOjS+kvs5nF31g8/UVAZq8Z0xQy2ppDmVenK/yRmEOjqj
OB2GokV0vOMG4dgkVEWWINFahiN35EP6XjBoP+JqGsN+0G6s4c6I6uebGRJEfPpZ
zLyH5QBK4oF8IjuKa8RQntXknck3yfJlxQjp7Dn1BA==
=Qxl1
-----END PGP SIGNATURE-----

--oqPdk2VGBVXm4Qm+--

