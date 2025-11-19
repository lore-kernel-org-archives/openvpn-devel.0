Date: Wed, 19 Nov 2025 15:43:37 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <aR3XmaUlPlK-pDqB@...1296...>
References: <CAOh3LPOnR5qbF-8xRuJFfZhWW25wNXBK3cUwC710cK4kRcSVpA.ref@...278...>
 <CAOh3LPOnR5qbF-8xRuJFfZhWW25wNXBK3cUwC710cK4kRcSVpA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ulmaKZrQRsyBiGC6"
Content-Disposition: inline
In-Reply-To: <CAOh3LPOnR5qbF-8xRuJFfZhWW25wNXBK3cUwC710cK4kRcSVpA@...278...>
Subject: Re: [Openvpn-devel] Old/New IP - Logic Redo
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jon Chiappetta <root@...2904...>
Cc: openvpn-devel@lists.sourceforge.net

--ulmaKZrQRsyBiGC6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 19, 2025 at 09:19:35AM -0500, Jon Chiappetta via Openvpn-devel =
wrote:
> This is something I noticed recently with potential connection
> interruptions which could occur which the original older code checked for!
>=20
> https://github.com/OpenVPN/openvpn/pull/910

Yeah, but, no.

Since our code is single-threaded, there is no time frame between
"unlearn" and "relearn" where a packet could come in and be dropped, due
to "address not known".

So yes, on a PUSH_UPDATE with "the same ifconfig again", we do more work
than we would have to do, but it has no adverse effects - and if you are
worried about that, then do not send PUSH_UPDATE with unchanged configs
(given that the client would do a full tun restart on receiving PUSH_UPDATE,
this has way more impact than on the server).


> There was an update pushed earlier this year which undid some important
> logic in terms of learning/unlearning the ifconfig IP address. The older
> original code would check that the new/old IPs don't match first before
> performing that logic. I believe this was important and correct because it
> could cause connection interruptions during the learn/unlearn process if
> the IP address has stayed the same!

The older code did not do proper unlearning at all, so was obviously not
correct.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ulmaKZrQRsyBiGC6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJpHdeZAAoJEB2Cnv7KVigSrDcMAJcMBjWkjijYXlk8KZCSUr9y
nV0SMs91hdwSI4AbShMsfISoz8/8hwrzWT9WPzywKqWPY3wnOF7CWBDbOYlBr2lG
+oFIw3KjeEUpwQhidUZA23e8FVvpqyz85AzEcKJV6Aemw2L2wFngU+rX++aJ7g2x
9ZoSn3G3MB8Lszkof50T3UJN0fchRBN6xMuFXmsepvNOT/+zc5c7QGiHkLxEkCnZ
1f59btZk7xhqhiLRyFAMafy2wWCuAoZ8+zy/UPbWx2Hg6+vvFf+TCtCyD5kV9auv
4kn7GWClSHEO+KIUMOAAdef49i6wNkiRSZOIFMzyU0LJVhQQFYl3+pBLBp78uRSt
w0SyezbhkeJsYUnY5R72xDLh/B0tqvM7AKrUv8mkx8rfXLCXgMRDV+1cy2ZqZYM0
nhfT+GgSHJoK6B98ozjdowZf5KJLCwKLTQP2zsdg8e3ko7c9RQnSc+Q6BC5xzfrj
pxthj1vMe5a/vtAkhYhZ/WotW1K872iy0NBH5hKcDQ==
=B/iE
-----END PGP SIGNATURE-----

--ulmaKZrQRsyBiGC6--

