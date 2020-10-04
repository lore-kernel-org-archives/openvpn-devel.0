Date: Sun, 4 Oct 2020 18:08:13 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20201004160813.GO976@...1296...>
References: <b1352a58-c9a1-ab2d-f85d-c419c8887ef0@...515...>
 <1759346.tdWV9SEqCh@...2258...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2IUIi54rL+LZyXu+"
Content-Disposition: inline
In-Reply-To: <1759346.tdWV9SEqCh@...2258...>
Subject: Re: [Openvpn-devel] OpenVPN 2.5-rc1 released unable to redirect
 IPv4 default gateway under Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Thomas =?iso-8859-1?Q?Sch=E4fer?= <tschaefer@...75...>
Cc: openvpn-devel@lists.sourceforge.net

--2IUIi54rL+LZyXu+
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Thomas,

On Tue, Sep 22, 2020 at 04:21:49PM +0200, Thomas Sch=E4fer wrote:
> I get=20
> Note: unable to redirect IPv4 default gateway -- Cannot read current defa=
ult gateway from system

I'm fairly sure I found this, and a fix has been merged today.

I expect us to release a RC3 this week, so it can be thoroughly tested.

(You saw the same effect before, but it was a different bug this time...
I've already increased my testing coverage on one of the build machines
now to actually test redirecting v4/v6 gateway, over v4/v6 connections,
and will add one more test machine that has no default route, with the
same test cases - so, hopefully, preventing this from ever happening
again)

thanks for testing & reporting.

gert


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--2IUIi54rL+LZyXu+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfefNsAAoJEB2Cnv7KVigS3nkL/02x3XzH7yPcdazQ5Kf/RLA1
9//RY125pOXPHdBxgmuWdlchNNPzSW+nZSghmkxf6dj6ZXSUoWGMlqQQpMEXcXif
YN7UqJcTM4UU2uv3BmeIrwajZsfkxNQ7Udc2k2XfFFVz3hfszkn33FuuyAGcibHW
XNsySEV0OAgwAw/zCETyxP0Qh+V7f3e49XtaH4AXfRCgBohsF9Hro5LwsD1rOOb0
4yy1JwC0mCpEUEMMBALXrVdIrwbhbWVwiuv+/BZ5dmYOVLK7jhKLPcvhRVUZYEhp
eDgAoO85EIghj7tMpfIpCR4LqgvNcwFtFxGAh1B22jZsV4hhVGqTp1ZtCEE0ITN1
J2OqMkK13LTbZMsDH1kAi09cGg3vQRVb08K7ZqZ8OInumrWbhx5tgDUuwj+suAtd
8cy72owUAS+dMgcnxzoLQGK9rkUcNzhuzSP0NGybYUtRQirkwmij6192Ptwr7z72
SWz39dndQKLmh7/LrGG9VTK72zwwuuCmmGEvo+eHVg==
=m3aG
-----END PGP SIGNATURE-----

--2IUIi54rL+LZyXu+--

