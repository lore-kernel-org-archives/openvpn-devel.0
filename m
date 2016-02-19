References: <56C5C6F7.1020903@...277...>
	<CAA1AbxJEJyrzJLOXLN2gO6EbA2=QSAbJf3pEr0SUAgVReT5xXA@...278...>
	<56C5EE36.5080906@...277...> <20160218170312.GV24952@...1296...>
From: Jacek Wielemborek <d33tah@...277...>
Message-ID: <56C6F871.2000108@...277...>
Date: Fri, 19 Feb 2016 12:11:45 +0100
MIME-Version: 1.0
In-Reply-To: <20160218170312.GV24952@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Mprqvi2l8LInx8RAmeVR5sWF7bi32sXqI"
Subject: [Openvpn-devel] AFL-Fuzzing OpenVPN in inetd mode?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Mprqvi2l8LInx8RAmeVR5sWF7bi32sXqI
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

W dniu 18.02.2016 o 18:03, Gert Doering pisze:
> Hi,
>=20
> On Thu, Feb 18, 2016 at 05:15:50PM +0100, Jacek Wielemborek wrote:
>> The thing is that in order to fuzz it most efficiently, it would be good
>> to modify the server to use stdin/stdout (or dev null) for network I/O
>> and terminate after handling a single connection. Also, we would need to
>> disable any checksums, compression or encryption.
>=20
> OpenVPN can be called from inetd, so it can sort of handle "an already
> connected socket on stdin/stdout".
>=20
> "sort of" because the backend refuses most normal options in this case
> (it can only handle tap interfaces, and no --ifconfig, because the
> assumption is that this only makes sense if you attach to a pre-configured
> bridge) - but for fuzzing the network side, this should work.

I read up on inetd mode and couldn't find a working example. Could
someone show me a setup where I could make it read a request from stdin
and ideally make it terminate after a sample request? Then I could start
trying to plug it into AFL.


--Mprqvi2l8LInx8RAmeVR5sWF7bi32sXqI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWxvhxAAoJEGlViymZXJRvD88P/2jAvjLLPEotC0BrFLktCZIw
8ayWARZDnvKWrX1LTQIL6sgVQ9x0YT0PV1gDeIbdl2gDg5OYeHmRPZy4wvye3yoo
1CfPRnY58/oBxLpF52yP7i7tjgrvNvH7orlxabVHhdtr5p48SLaWE/65lqgZTWMn
KLMjaX/cNvsBTpSQMLciBorsQNaY2SRGJqZffdAw5beyfbgp7quHQErY8KKL/8Ne
Kzlp85lMi4cDgUkKsN96bZ9dv7BhdnPjUWqWNqyBYO+R24dI6SisRxFrtIuAtlbf
wu+xwK5lHSUTnmKnyu6Sov8T1TyVkaaZe1LJw8GwJhEYixDg6o+LYz1bX25sAaaE
6siKGMPHN/dZog5JbXHRbRmHgMG/36gmqyB21Cfj15mql0oAZovxg/P9aUR5cXGY
YAPw6jNAbkRbjA+sbGqkbUETs+f0RFlU/XgRJ8aFhrni0eIWNrdWbC/g8xYqWEUC
1cxm8QPw3Fe3GGMTtANk1Sb7YpAwGP3EFYWG5XoOkAqwk90b5Pq13EckmfCPrnXw
S3Vm883tBwp06PhUUkBXPSJ1Pl5oaVVnRjnNsrATX+MhcO6WvdkSaTCr5n7LRIvS
FGGLg6wH9e3AuCqnp4THrVfK1IMnGAdOeTkbqXACbBUwrI0XpVDS/oXX3eUSoOJQ
NhEQXoxh4lgYhBtI1hYx
=XURC
-----END PGP SIGNATURE-----

--Mprqvi2l8LInx8RAmeVR5sWF7bi32sXqI--

