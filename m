Date: Mon, 5 Dec 2022 13:08:43 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y43fS1uZEIJQdGu8@...1296...>
References: <20211123083758.15933-1-fkooman@...2318...>
 <65eac3b8-9269-b60d-f8fb-6274ff92fd28@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Q1YiCzl8RLfcZLtv"
Content-Disposition: inline
In-Reply-To: <65eac3b8-9269-b60d-f8fb-6274ff92fd28@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] implement net_gateway_ipv6 for
 --route-ipv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, =?iso-8859-1?Q?Fran=E7ois?= Kooman <fkooman@...2318...>

--Q1YiCzl8RLfcZLtv
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Sep 19, 2022 at 09:13:10PM +0200, Antonio Quartulli wrote:
> For the records, the following changes were requested to this patch=20
> (some via GH):
>=20
> 1) improve (add?) commit message;
> 2) add comments/documentation to ipv6_get_special_addr()
> 3) get rid of the ipv6_is_special_addr() wrapper as it is not really=20
> doing much.

I think the patch is small and "isolated" enough so it could go into
the next 2.6_beta2 - if I can have it, with these changes, by start
of next week...

Francois, would that work out?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Q1YiCzl8RLfcZLtv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjjd9LAAoJEB2Cnv7KVigSNeUL/iuR+MmSHmX5Q1fIZSfHlfBr
f3JlNlFbep9sQm6jVxSssDniFgRRmlZBOwRZr5MwEdynUW9eDG+2FiOJ7AP1Hiur
RfLfDv8ezMomvNZZvVxp6RqB/poURJCanSacsphx89hJb3vvjuF8TK1WLedCs2ae
dfd4niHBmpEjqkBrXobfi4F5xbLAX8/6dDTwJPKh3PAdQ8Vn9NolLX1e4b8BXxyn
4FIf4NMcT6OrtdOLSRgorF8So9G3zS1CeEFUaVCaAky/nny5WWaLXp6rcgYthf9d
TArY3fjsoNJXW251u6axipT+LwTVy4DuxVv+iu4H5qTWfesOI2h2k0haWtYlnkvk
po/Hmk3+xqQRVs4aOHYQgvXEFflj4i8oEbIjP/9EZYmPu8GZF2Rdq7y3LKgSwFEk
gwelfaVmI2mHdu+S/9Kzmz0oZYw4voX8uIM3EuIBtv4uZNfoTb4q9SgZo3C7PUFt
uPMIQfdp7iif1N4W8U00hMMlfvVPKZWyB6lc2tYdXA==
=xSOP
-----END PGP SIGNATURE-----

--Q1YiCzl8RLfcZLtv--

