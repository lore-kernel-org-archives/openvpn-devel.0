Date: Sun, 24 Jul 2022 21:12:18 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yt2Zkt1K5ThfAaYn@...1296...>
References: <Yt2Fdvaom94pVcOQ@...2684...>
 <Yt2Wqc2zTdyx5Zj5@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="nBDQs5BvGCPomBfO"
Content-Disposition: inline
In-Reply-To: <Yt2Wqc2zTdyx5Zj5@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] PUSH_BUNDLE_SIZE is too short
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Angel Abad <angel@...334...>
Cc: openvpn-devel@lists.sourceforge.net

--nBDQs5BvGCPomBfO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jul 24, 2022 at 08:59:53PM +0200, Gert Doering wrote:
> Can you please show a log file that demonstrates the problem?

Oh, and "what software is running on the server side"?  Long push replys
have to be split, and if there is something non-official which does not
split the to-be-sent records as the official server does, it's not a
client side bug.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--nBDQs5BvGCPomBfO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi3ZmSAAoJEB2Cnv7KVigSzrgMAKtzJwF8jtX86C53xfhWag2H
toQcd4nJZTAUNeJgqMA+lvZdkwtADsc2M/KXfZvYEgE/Qv35xPuJ2CeGRNImJRK7
hqrxYohUh85XRJmy0aQnHnRLZdAIBuRY0Sy91Iuy2YIlJt1k8Wklss+3eeUKXYWv
pQqfPDUyUVxPJTtr8LfPNKSWCu3CClIMN1AIr+sCF07G+szj8L//UkwJJe0uUIsy
lrkXmAShvI4PQH5e6+++DInQF8XooQO9gvoIOgbTfRHy+AynizF5OijbdUix/Gc9
Ry8zwo1is4gdf25hECtnGCAQ1UliyVxwa9cMXVtnwLB3cABnjnci44na1Kma6bDO
lDqS7feQOYEgw60SZ0XjFgdeln7iQo0cPhBqKMHBycaNME0JIYyHn0ZJVq1WKYol
Qjz4/km4ivghAA20s0VYwesBR6DqqDCwpvT4bCrwqNymGaqb3jaQ7qkYdcN8UN7F
NPk0EW32euEQLrey/MAy1aRoquqfP6aIE6QI+YwHGw==
=OYL7
-----END PGP SIGNATURE-----

--nBDQs5BvGCPomBfO--

