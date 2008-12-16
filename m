From: Bernhard Fischer <bf@...1168...>
Date: Tue, 16 Dec 2008 22:13:57 +0100
References: <706B159B681A4818845483E38E87367A@...576...>
In-Reply-To: <706B159B681A4818845483E38E87367A@...576...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart20496722.GFyVkiN5tm";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200812162214.05751.bf@...1168...>
Subject: Re: [Openvpn-devel] TUN/TAP Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Dave <dev@...575...>, openvpn-devel@lists.sourceforge.net

--nextPart20496722.GFyVkiN5tm
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 16 December 2008, you wrote:
> ...
>
> > I'm working on a project (www.abenteuerland.at/onioncat) that
> > needs a TUN
> > device. I'm now trying to port the software to Windows
> > (Cygwin).
> >
> > ...........
> >
> > How do I compile and install the TUN/TAP driver?
>>
> You will need the DDK, but here's a silly question:  can you not use the
> existing (built) one?  Are you making modifications to the driver itself?
>

No, I don't need any modification. I know, that the pre-built one works wit=
h=20
openvpn.
But if I start the Cygwin shell there's no /dev/tun. Hence, I thought that =
I=20
have to compile and install it from source.
But maybe I need another method (than /dev/tun) to access the driver on=20
Windows. I tried to find the right code parts within the Opnevpn source but=
=20
unfortunately I didn't know where to look...the code base isn't small ;)

> I admittedly did not read thoroughly your project page, but it looks like
> you are wanting to replace the user-mode openvpn component (which does the
> encryption and tunnelling) with TOR to provide a kind of transparent TOR
> proxy.  I would expect you can do this with the existing TAP driver becau=
se
> it's a little like not caring so much about the remote VPN network, but
> rather caring more about your default gateway.  Just a guess.

Yes, you're right. OnionCat is a transparent VPN (like OpenVPN) based on TO=
R's=20
hidden services. That's why I use the TUN/TAP device. It works very well on=
=20
Linux und other Unixoids but now I'd like to port it to Windows. My biggest=
=20
problem seems to be this TUN/TAP driver, hence my posting ;)
Maybe you could give me some hints.

Thanks,
Berhard

--nextPart20496722.GFyVkiN5tm
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQEcBAABAgAGBQJJSBoWAAoJEB2of8NcX/1HbmoH/1jnsAbATC1/v/RM52EziwKU
GhQlKo70JsdzE9Q77fbeqOJpRIeF6bXtcgVNAB+bfd/uzAxv6MD4i/ZaLFQm3vSg
QUbfZbZ/zIK5kVfWnmJhuG3JGc/dBi6sotoiafVRtwmbrac6EFCsm0lgFOxw/SzC
QeiwHqSw4LhwSDpdP8N2SftYs270/stdSgzcihCw1lIbVF21Th5pQWPbVHM1SkBQ
KHF1pZEhSrSxRsdBLALaDU+88xYnk/Ot/4UQ72M5FeGZArxGeZhb0HU6vmk7eT46
RTdJBjLBRHb8+fC4wU2N8N6w+/Y8WI+NMoHFDHopmEtKhuU018G9fpb4gY8zkYk=
=Ycp6
-----END PGP SIGNATURE-----

--nextPart20496722.GFyVkiN5tm--

