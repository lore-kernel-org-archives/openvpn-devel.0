Date: Sun, 18 Apr 2021 16:15:37 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210418141537.GA976@...1296...>
References: <20210415230545.22317-1-themiron@...2010...>
 <20210416120708.1532-1-themiron@...2010...>
 <20210416120708.1532-2-themiron@...2010...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="V+uful/WAgQmgGMp"
Content-Disposition: inline
In-Reply-To: <20210416120708.1532-2-themiron@...2010...>
Subject: Re: [Openvpn-devel] [PATCH v3 2/2] Add basic support for multipath
 gateway
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vladislav Grishenko <themiron@...2010...>
Cc: openvpn-devel@lists.sourceforge.net

--V+uful/WAgQmgGMp
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Apr 16, 2021 at 05:07:08PM +0500, Vladislav Grishenko wrote:
> Load balancing setup over multiple upstreams may include multipath
> gateway route, which is not not supported by OpenVPN.
> Let's add basic support for that for selecting best route for zero
> destination address - use any one of nexthop addresses as a gateway,
> weights are not handled.

What happens with the current code when we encounter such a situation?

I assume it will "just not work" and find no gateway address?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--V+uful/WAgQmgGMp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgfD8JAAoJEB2Cnv7KVigSI8UL/AmBCcwgODSGcF4cRYTTiCpG
5EBVmIRCMzgl5yaWFDC62JxTVM9X9xhSnjvKS1EAh2JlGbStiYCg87g9jp4TXLKU
G0HegtTrLx0f0Np/E3OSYNgMIxfmyTsvBIa2xn1bqDMnmqJYF65omm+4PXv0NzH4
jZRA7V6UzEFjm+5XCmaeFFGTP2atFJiyd16sEYTHH61fxYv7l9DmyBU9gsJLqx5y
wOyKkAHoAgTmuk1CQGUG7fo89FzjRi0RAg9m47XMsuvdAlFVJj2bxdDM7qWws1Em
th93KQtOV/dsm5GAr8R7VvBZkf1moljNRZPHena9AM1m1I+8K1GD86sJAymgRwyD
P3DYUQ3zu5BOiXWlO7I6wpjTYtmgTo8d8FtKXkeItZXMhmFl+xY8yTNwlQ2aL5zb
c0DFAclf7otvhv35rbPUscqb6sBCZ8nD+PHpymDpi4F8Mixs6aVW0f1xBuWFF8mu
9zqGkxCSxNKtZi0R+J+NuS6uNkA6m+r1/wxePCLcTA==
=5TgR
-----END PGP SIGNATURE-----

--V+uful/WAgQmgGMp--

