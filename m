Date: Sun, 14 May 2023 14:41:53 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZGDXETofVi68X7Ah@...1296...>
References: <7072303.gtipl9YmvM@...2731...>
 <40c32f7b-b3a5-a09d-5b21-943b4a9ec736@...1227...>
 <5431695.haC6HkEk0m@...2731...>
 <3bc3d283-6cdf-d7fd-e1d5-037589eb904e@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="YcGTcgI/NQAbgWME"
Content-Disposition: inline
In-Reply-To: <3bc3d283-6cdf-d7fd-e1d5-037589eb904e@...1227...>
Subject: Re: [Openvpn-devel] Automatically restart Linux systemd OpenVPN
 client service on failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Melvin Vermeeren <vermeeren@...2730...>, openvpn-devel@lists.sourceforge.net

--YcGTcgI/NQAbgWME
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, May 14, 2023 at 02:38:06PM +0200, Arne Schwabe wrote:
> Yes the option we ignore to check if we have to reopen the tun device is=
=20
> quite short. We should probably turn this into a positive list instead=20
> of assuming that all options need to trigger to a tun reopen/close.

True, but even so - shouldn't the systemd unit file just restart the
openvpn client anyway?

(I see myself having to restart the OpenSolaris Community VPN client
ever so often...)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--YcGTcgI/NQAbgWME
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkYNcRAAoJEB2Cnv7KVigSDdoMALQ6EB892QGd9UeP6F4iTseM
Rpx4vLT3WvwW+NkqO7GHCyPBwUTEYsmPdc5XKn6QWK3TiUFFK9SBNSaWYdNQV0f6
4gRw6MAAbTEnfOOjUieKkF2DzBjXnpsDN0lX64xYqOw+Ok++i4dWYigMElS5G9su
z6K/48dshFN5YdUPRbuyXQFVEd/rt6xjKXTCEYZlkEAhtXHcQt8lxMYS6EiQJuXx
xTeZ5H+tF5/hxWMSkdyAS4Xf4BgMFd/9qMTQ9UYBBqcxzrgd261a+dujllUPIKME
axrvsyexm37zJrVWClHdRq4qncdmWA9jdLoVdkx6XpIpyoREMCK16EndLydh50Oa
IrmqNGlryrYxNbY4v0A4zbPBfsfNPUsamMD9bjKrGvbF6I2gcVYQUWT2ZPPL03sS
GNN4GHmaCf0ZtXEDCvGaLIIRPj1L7FXSdX9RaLC3ujagwNpcamIV8jbaZqTvOpiq
LumsAyLpgs3MZKCneB8VDn4Zgv8zgj8LTdFw+uvBlw==
=kjz4
-----END PGP SIGNATURE-----

--YcGTcgI/NQAbgWME--

