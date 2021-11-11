Date: Thu, 11 Nov 2021 17:39:47 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YY1HU85OwqH442H+@greenie.muc.de>
References: <CAGyAFMVbX1m_LhB=rV1Kh0uqpjfgCy6WP9t1o2bLTT+dO-L9Gg@...278...>
 <20211109015927.311-1-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="JwuQWDk71vYDJf78"
Content-Disposition: inline
In-Reply-To: <20211109015927.311-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Use network address for emulated DHCP
 server as a default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--JwuQWDk71vYDJf78
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 09, 2021 at 03:59:27AM +0200, Lev Stipakov wrote:
> For subnet topology use "offset 0" as default for
> calculating DHCP server address, which makes it equal
> to the network address.

I assume this has been tested across all windows platforms, including
Windows 7?

On the patch itself, the code change looks good, I just need confirmation
about actual testing (with /30 and larger netmasks) across the variety
of platforms we support.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--JwuQWDk71vYDJf78
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhjUdTAAoJEB2Cnv7KVigS8ggL/jexQPJ8cgwbkwPrK75D0geA
pVBQLtHKCYM3jpqwKWAiu8p/saEo5SRrIPQIbnN9hzbZIVVieowAEKX0e8xBbr9/
RKJjoeW1n31qAsg4vgfiWqfZ5XvKlB76DwYi6+hsP3Mu7ksc4FUgyE18lfKbx4u7
vt4zUl7UoyvRwtWr83TzWmuAL0p7xhSHiYSdYXO2nNbEK/oRVsTLgczoMSs0pUIK
OWUShMPl4H399V8J35kWjcy9SeWZgp5ySBiXqN8Q69nYJ53l82H5JpuTSA8oBzpx
lUre3TFCyzUVpQsbj5u+ZuWGmx9m4hpXWc7BQwMB1VY34zXhj2E6dNCbX1ZJA2V+
rvYQhZBfpI16MT2SMTRafOTabDdCEhmVTFtNgNEINIw8GkueDGB8KZmwBf37Y9Ne
GUOuXJI8UJxkRSAbNmEvHYUOcP2bkOweuC/wSwirmml1Z7+X9iDg1jjNIVOQTiKg
iMxfF10f/y7gpDxiHOSB3St5d6ZQch2SaOPvdJGx8Q==
=xAXC
-----END PGP SIGNATURE-----

--JwuQWDk71vYDJf78--

