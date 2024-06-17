Date: Mon, 17 Jun 2024 15:40:04 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZnA8tBU2cKetUBmG@...1296...>
References: <ZmGqRY9vRywrLUHD@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Y/u4Zr/3KE3tawsm"
Content-Disposition: inline
In-Reply-To: <ZmGqRY9vRywrLUHD@...1296...>
Subject: Re: [Openvpn-devel] windows client tests needed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--Y/u4Zr/3KE3tawsm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

if you think this is a useful security enhancement, and would like to have
it in a "short term" 2.6.x release, we need test results...

please!

gert


On Thu, Jun 06, 2024 at 02:23:33PM +0200, Gert Doering wrote:
> Hi,
>=20
> we have new code in master that helps with the "TunnelCrack" and
> "TunnelVision" attacks, that is, packets intended to go into the
> VPN being leaked away by means of a malicious DHCP server (=3D routing
> points outside the tunnel, so packets never hit OpenVPN).
>=20
> We used to have
>=20
>   block-outside-dns
>=20
> to prevent Windows from doing DNS lookups "around the VPN" - the main
> intent of this was "make sure split DNS works", but a side effect has
> also been "avoid DNS leaks".
>=20
> Heiko has now extended this code to be able to "block everything not
> going into the VPN".  To activate this, you need
>=20
>   redirect-gateway def1 block-local
>=20
> in your config ("block-local" is the keyword, but without "def1" you
> end up with a split-tunnel and "nothing else is allowed", which is rarely
> a really good combination).
>=20
> Repeat: if "redirect-gateway block-local" is active, NO packets leave
> via LAN/WiFi/... interfaces, except those sourced by the openvpn.exe
> process.  This is important for maximum privacy, especially if you
> roam into a network with an untrusted DHCP server.
>=20
>=20
> Now - this code has been merged into "git master", and installers
> are here:
>=20
>    https://github.com/OpenVPN/openvpn-build/actions/runs/9391365526?pr=3D=
641
>=20
> (bottom of the page, "Artifacts", .zip files with a .msi inside).
>=20
>=20
> I want to have this in 2.6 as well, as it's sort of important for certain
> classes of users (and also VPN providers, offering this as a service) - b=
ut
> I do not feel it has been tested enough yet.
>=20
> So: PLEASE test these windows installers, in all 3 variants
>=20
>  1.  <nothing special in the config>
>  2.  block-outside-dns
>      (DNS is blocked, everything else not routed into the VPN tunnel - li=
ke
>      "your local printer" etc - still works)
>  3.  redirect-gateway def1 block-local
>      (ONLY VPN works)
>=20
> and report back to us.
>=20
> gert
>=20
> --=20
> "If was one thing all people took for granted, was conviction that if you=
=20
>  feed honest figures into a computer, honest figures come out. Never doub=
ted=20
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh Mist=
ress
>=20
> Gert Doering - Munich, Germany                             gert@...1296...




> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Y/u4Zr/3KE3tawsm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJmcDy0AAoJEB2Cnv7KVigSJ+8L/3XpXRm+x7tESzA1JcVNS1V0
CoFtlzFrscE1vsxSUQJj+VtA3lQOTHEj+lSdL7OA+AWc8Apzg4Y4vO/dv8al6LOc
N9biCbg4h9I0rzVj+XRbgrSR8emICdpgP6ckoEs3podHmmcqb9hA2rMPYbOiNsUg
htnb70SuHCEK/yIGo7IeDfXpvysvcQv1zAByDN+NIvpfLNQNIlHCU677tFASgTq+
0DyCd4uCLLzYlCBFkOEhxdD3UeFPnx772URJGWimjMBGeIkOm8Cp3Zy7Cn2GtQBC
aNOp+OuJIWdzVC8elBZxu9Un81fZRGGmpoAXgxrhyCqoO2oqYzEqHzd1Bdj0Oh/6
5EybFqIkRfI4HvIzUuw+0rCedVtqFoxvnZoKFf8dcSuf1Dkxz+jSjQjcukBX9PpB
xZeGHAw1/p2uPzCpcz/2ndG+LOZEIkh9yF/VSWFdboZhWVklFIVtdGT8ENR/NKJn
c3c5N3OX+5Uu9UinFjC/pSuQT+nFnljSHnSGELs2mg==
=8j48
-----END PGP SIGNATURE-----

--Y/u4Zr/3KE3tawsm--

