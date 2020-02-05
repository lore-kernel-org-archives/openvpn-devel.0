Date: Wed, 5 Feb 2020 14:05:11 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20200205130511.GM1431@...1296...>
References: <20200205124615.15758-1-domagoj@...2540...>
 <20200205124615.15758-3-domagoj@...2540...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="WG0/bXtUnGTsWt66"
Content-Disposition: inline
In-Reply-To: <20200205124615.15758-3-domagoj@...2540...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Fix linking issues on MinGW
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Domagoj Pensa <domagoj@...2540...>
Cc: openvpn-devel@lists.sourceforge.net

--WG0/bXtUnGTsWt66
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Feb 05, 2020 at 01:46:15PM +0100, Domagoj Pensa wrote:
> MinGW linking fails for several files due to a missing "static"
> declaration in functions tuntap_is_wintun() and tuntap_ring_empty().

It does not fail for us.  So what MinGW version on what OS are you using
to exhibit this error?

(The change might still make sense, but the explanation does not
make much sense - exporting a function which is not needed "outside"
should never cause a link fail)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--WG0/bXtUnGTsWt66
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJeOr2HAAoJEB2Cnv7KVigSPjAL/i2gtFd+5CRbrCMEMTGYxrzK
P012k+WU56bq9qraK/AyrGTrGPZOef0Nhj6Zppy8ee1QWksCPC3XK9oZxY8dyjdk
/uSwyqMTPaLO+K3ZNx0sthEy5gaayVV/iFYpyhFBbDZz+l0HGxiQLZq0rnp2EEVe
olTZixKLcF5pDM6XRddMTJOeCl5ytJ8SQJH+zTYgPfHWcuSHR8L2QQeo7EQ5b88G
aLXIBhurfMVYjti3WpohCUcjCwzVW1PXsFUMisDAdKjmTcWfj7MKHJbvCpFmxdsd
Q51T/tzrO1JLxCA9RJJfnDTjKk3uScdvzKd8ddc3nwzaXjCaWzzQZG+2XPIpSAP1
93C+XU0KodyXMFSk5RjfZ4Yqyv+UpuFX0BONK1Brx8MfSo8AER29cEXbFevdxkW6
zrEmrPlYwxAZyHAfi4cl3OFNj/SfIbiZZ+yufkb9nZq0GgrUl95EhfoPyBYx9sec
HJM6RS2I30gQv1bLoDXyhv6VFbmGC08k+1h2o6qGzg==
=uBEU
-----END PGP SIGNATURE-----

--WG0/bXtUnGTsWt66--

