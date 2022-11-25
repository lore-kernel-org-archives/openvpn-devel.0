Date: Fri, 25 Nov 2022 21:59:23 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y4Esq+n4CQwp2alv@...1296...>
References: <20221125155341.19456-1-kprovost@...2661...>
 <20221125155341.19456-2-kprovost@...2661...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ocNNzkFg6JhmuFej"
Content-Disposition: inline
In-Reply-To: <20221125155341.19456-2-kprovost@...2661...>
Subject: Re: [Openvpn-devel] [PATCH] dco: pass control packets through the
 socket on FreeBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kristof Provost <kprovost@...2661...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ocNNzkFg6JhmuFej
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 25, 2022 at 04:53:41PM +0100, Kristof Provost via Openvpn-devel=
 wrote:
> Also remove the FreeBSD dco_do_write() implementation, as this function
> will never be called any more on FreeBSD. Assert this.
[..]
> +     * called. See should_use_dco_socket(). */
> +    assert(false);
> +    return -EINVAL;

The patch works fine (tested on the FreeBSD 14 "current of a few weeks
ago" server rig), *but* the coding police says that we need to have
an "ASSERT(0)" here (uppercase)...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ocNNzkFg6JhmuFej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjgSyrAAoJEB2Cnv7KVigSZt8L/iLrhXi3OqkzmVAAgyXlMTq1
KRaZPM7FXVHc/UrU/Jyy3CpHdSTZ9qGQaQSBmkdzaGqqcF9+RzEsSrtmJEnSo8sr
ybqRo2JmMngNSBQtQ5ebh/yhj1qfm7KvMPxrsk9y8hGaIxwCyWM7bmv8WMB+3L4U
jdcwQKhW/kRc828TtKFnVTNS8DDmXDw8y8LW1BwjRxIpEknaUyVazaTpS6xXMfht
dLSk+jJh+y2agbXlQpqY4Uj8+pzWnFZ1o3wZSV1NX1hlEI+riNwm542cpP42mTPh
6zQqT58TejMd1OnSy/Eb/rHwB/pNAFaPmSJMAtZwPy59iZIKTsXCyzlTzHehzlG/
ify9XJ/NwadOVHCZ3mlbIMM+zWYxXljzNnNQ8N7K9mVV7fBxOB17nThQHiosLQbT
nwlsgPuXC8f6F0g4bTUIHd1KaFVNvj7T18+eSAOpF8RA1lMj1jzESUADKM1yTJNA
ZQ9xQ08Vi/2vjp6L0RtrC8ZE9qW+Mxc0qSicOJLcRg==
=v43K
-----END PGP SIGNATURE-----

--ocNNzkFg6JhmuFej--

