Date: Sun, 4 Oct 2020 18:05:10 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20201004160510.GN976@...1296...>
References: <63aacbfb-20a0-de78-fccb-bbf8a2ad4189@...2318...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="dBTySC83OhS/t4p9"
Content-Disposition: inline
In-Reply-To: <63aacbfb-20a0-de78-fccb-bbf8a2ad4189@...2318...>
Subject: Re: [Openvpn-devel] with IPv6 VPN connection,
 IPv4 traffic does not get router over VPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?iso-8859-1?Q?Fran=E7ois?= Kooman <fkooman@...2318...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--dBTySC83OhS/t4p9
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi again,

On Fri, Oct 02, 2020 at 03:26:29PM +0200, Fran=E7ois Kooman wrote:
> After testing connecting over native IPv6 to the VPN server, it turns=20
> out the IPv4 traffic is not routed over the VPN. This worked in older=20
> versions of OpenVPN (2.4.x) but no longer in OpenVPN 2.5rc2. I am=20
> testing with Windows 8.1, but the same was reported on Windows 10.

Antonio has reviewed the fix, and I have just pushed out new master
and release/2.5 trees with this.

If you build your own openvpn, I'd appreciate quick feedback :-) - otherwis=
e,
we'll release a RC3 "this week", so you can test this with pre-built
binaries as well.

Thanks again for the report.

gert


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--dBTySC83OhS/t4p9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfefK1AAoJEB2Cnv7KVigS/b8L/RszkaOCoznxU/p261l0WpUj
bB1li/9mmgSj+QVwGqFRDqlN7jfuA9pC2itmkKJ/71sjRRepBtMzj5lZGZVdQlGB
3PFZqDas4V3YUOqaoCWpd5n6f+KNf+nhSi5mSK4dvWJhW9XBIwoLNA6a8D/hRV4G
y9yy/9PoOZAu1u1dj4UGYQIbYn1r3dOiwdHGHDoPhRi95e6o+r/Z0fm7H3Db2zuK
9NieIeO+ducGgtoji+7a7cXHs8F4CVVYDNw6/Ae9oU+bc4AyvzlR5o3UA13Xohxe
bYLc+GhVjdSIVmO/5/ACBqVfa/BTB7HiXWH2623Q5KmFy//ySqD7HQ0O39uWFCrn
wZfN7pIYhLvhGrukJdc86DXVhbYm1sfQHK4qpxL3yHhZDrWN61cYD21prBpjA2Bt
JrLxE1o6UKHViYrMP4aymUR5Nz3DtWA2DVKYfnaaLU9Gw1woaY4YrfICEKgKA9cC
0aIzIgSL+08DCu+rV/IzkS72bC1Q97H3ZfBhN8V6XA==
=GN4e
-----END PGP SIGNATURE-----

--dBTySC83OhS/t4p9--

