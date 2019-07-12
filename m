Date: Fri, 12 Jul 2019 18:48:59 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190712164859.GY1097@...1296...>
References: <20190403225657.8003-1-rosenp@...277...>
 <c6020cbf-4340-7e24-9bbc-50fbe6b2112d@...1227...>
 <f44b86bf-0258-294f-9fcb-ade6059464aa@...68...>
 <318a10cc-4521-232c-0909-e824b3ce9a9b@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Ss+0cqQwq/UQoUvX"
Content-Disposition: inline
In-Reply-To: <318a10cc-4521-232c-0909-e824b3ce9a9b@...1227...>
Subject: Re: [Openvpn-devel] [PATCHv2] openssl: Fix compilation without
 deprecated OpenSSL 1.1 APIs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Matthias Andree <matthias.andree@...68...>, openvpn-devel@lists.sourceforge.net

--Ss+0cqQwq/UQoUvX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 12, 2019 at 06:44:06PM +0200, Arne Schwabe wrote:
> Looks "wrong" in the sense that it does not match the style we want to
> have in openvpn.

Indeed.  I have seen and used "#   cpp-thing" in other projects, but
OpenVPN seems to have decided to not use space-indenting for nested
#if-things.

So, we'll keep this (and try to get rid of #ifdefs anyway :-) ).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Ss+0cqQwq/UQoUvX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdKLn6AAoJEB2Cnv7KVigSogEMAKyURm3p7WHq+Voqd6NNUIST
CSzgkMkGqTg8ZHeUwHEdmAz5WlzGnz7b0H9VxmtgNtU6Bqv93eQ98fi1yktXU8eI
RuC4jMYFZYPD3I+JgJQRJjD9ZWB9l7oD81fixDF3lHR7GSNwABuJ11EgXAwzAREq
qa4NuYSSUjY7bCuhQMkGfABOXMY+45+OlDo20e2cb4gimQJz+yEXDgWSvG5IqYz1
nqdNaPzxbLCk3X+zvanLuLB6r06AXK+1X0wN8nmLV9M7ioUHLNT4isUWI9XoKpJB
4PxrSRh8EVHWfh5cElpo8BAMQpFYjyViZ/6qOXOETns5tLbA04W+wEogNfqcmAZn
wjqedMbcv3Q84cBWsMzD7Qhwea7ECCKXYE5HLXnRntA3rVrGqEJHzwe0Sf8ab3Sr
v9xS4rhkgFAbxmXDdp+MyuddVspNVZkSE2E8L2aGZc+ovS/fkNNrVIcw7KY4mjx8
+X2Q7Sd4GzfUKef+sWkp6/ItqEUtW2rR2qb3uveGEg==
=ivSk
-----END PGP SIGNATURE-----

--Ss+0cqQwq/UQoUvX--

