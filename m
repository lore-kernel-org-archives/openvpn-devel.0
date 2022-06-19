Date: Sun, 19 Jun 2022 19:03:54 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yq9W+juHzDvkjzcx@...1296...>
References: <20220607093619.23066-1-gert@...1296...>
 <80cdf6b1-f3c7-4a02-b7d5-05989749145e@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5vQchDzIIApwZ+47"
Content-Disposition: inline
In-Reply-To: <80cdf6b1-f3c7-4a02-b7d5-05989749145e@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Fix error message about extended errors
 for IPv4-only sockets.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--5vQchDzIIApwZ+47
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jun 19, 2022 at 11:38:17AM +0200, Arne Schwabe wrote:
> >   #if EXTENDED_SOCKET_ERROR_CAPABILITY
> >       /* if the OS supports it, enable extended error passing on the so=
cket */
> > -    set_sock_extended_error_passing(sock->sd);
> > +    set_sock_extended_error_passing(sock->sd, sock->info.af);
> >   #endif
> >   }
> >=20=20=20
>=20
> I have to NACK this patch. sock->info.af is not the actual address=20
> familiy but the family we want to use and it might be 0 if there is no=20
> udp4/udp6 in the config file.
>=20
> For a client you can look at sock->info.lsa->actual.dest if that is=20
> defined. For a server we seem to actually override/set that info.af=20
> value according to my debugger but with a client I get 0 in that value.=20
> It looks that set_mtu_discover_type in the same function has the same=20
> problem, so it is easy to this mistake.

So how do we know if this is a v4 or v6 socket, in a client?

Phrased differently - I could do a v2 which will just ignore this
particular errno value.  Maybe not "as clean" as not calling the
"wrong" setsockopt() in the first place, but will keep the log free
of non-useful error messages just fine...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--5vQchDzIIApwZ+47
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJir1b6AAoJEB2Cnv7KVigStKUL+wUe0sxma8nMbzNamOOgy1Lf
AAD2rW+rc7xZqRan8lsnnD6IJZY9DMo64r5eecSOeGuxWuKABwFQISuxkFwLGmw/
+DNPf28vLp4hc120284XrOb42Nio4chk970kan7qsCk7V7s/hKgL3gC/So6Mr1a7
0TEcuoxIdtO73W/zHKwAQA8xPX3U/R2ndKAdTWc8uUgG1dg7maelLvm4k23BFJdM
yM2fVgQO+9dr24/vajtN6K0E48AzAlimXRLfKHCMekIMYXhqbIdpj38122dSOGAP
7n5PJYRy9a8diz4v5SraAaIgeAYBd+/vdn92ZTvCyjb/shLmwGGUbpeVSMjz4rv3
P2UM99OSf16HDt+B0kSYoxSVj0dYcv7rZAR4f5ViPfkziJZ7kNjyGbTaBtai0FZU
rAyOK7N5uIT7njOebkXHt/eF7X5NbXUfw9CwSssVn4OBXEDkBTpHFiCd4EDW6+Uv
28xWgiAiyO0CAnL5tg28VE8Q6fN2x6s2ycvZ5maUNg==
=rRiB
-----END PGP SIGNATURE-----

--5vQchDzIIApwZ+47--

