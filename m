Date: Sat, 3 Mar 2012 09:07:17 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120303080717.GG1359@...1296...>
References: <b7eff4b3227380d9911bac1a18327c69@...1528...>
	<20120302145900.GF1359@...1296...> <4F5152B2.70705@...1490...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="76DTJ5CE0DCVQemd"
Content-Disposition: inline
In-Reply-To: <4F5152B2.70705@...1490...>
Subject: Re: [Openvpn-devel] Running udp and tcp server in the same instance
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jason Haar <Jason_Haar@...1490...>
Cc: openvpn-devel@lists.sourceforge.net

--76DTJ5CE0DCVQemd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Mar 03, 2012 at 12:07:30PM +1300, Jason Haar wrote:
> On 03/03/12 03:59, Gert Doering wrote:
> > I would *love* to have that. And it's somewhere on my TODO list of
> > things to implement in OpenVPN (multiple listening sockets in a single
> > process).
>=20
> Given the issue with the non-threaded nature of openvpn and the
> bottlenecks that can cause under load, what's wrong with running
> separate instances on multiple tcp and udp ports, and then using a
> "--client-connect" script to return a unique IP to clients?=20

Well, it's a workaround for shortcomings in OpenVPN :-) - and I prefer
to have my software do things I want, without the workarounds.

One issue I see with your script is that it will also need to change
routing tables on the server, to get the client IP stuffed into the
proper tunnel for this OpenVPN instance, and then it needs updating for=20
IPv6, and that's all avoidable if OpenVPN could do it in the first place...

> We use that
> so that all VPN users are always assigned "their" constant IP by mapping
> an IP to the CN field=20

Which works perfectly well from within OpenVPN, using "--client-config-dir"
and "--ifconfig-push"...  (or if you don't care for a specific IP address,
as long as it's the same on every time, with --ifconfig-pool-persist)

[..]
> With this, we have the luxury that every client always gets the same IP

That can be achieved much easier :-)

> - which makes asset management *much* easier and means you get
> marvellous side-effects like I can be SSH-ed into a work machine at
> home, suspend my laptop, go to another building and get an completely
> different Internet address, and yet seconds later have openvpn
> auto-reconnect to work and find my SSH session still works. So cool :-)

All *that* is built-in into OpenVPN already ;-))

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--76DTJ5CE0DCVQemd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT1HRNKkuBuNlUUl1AQIaAQP+OwrfDFXw5vZ8TlTqHLTHeAY8/oX918eQ
usf/NTKwdvvqdIZ3SqNj695vc3lpIx097ForbJ8mdDaBUFLz5nrvCRQvl6D92YQK
VmZI13HzUJ8OIeoSdxL0SQLYXBLe8wyqcRWZEjiEFkYfurG9OnInz62K1h5YGBlS
c8JfNKOKWhk=
=06w8
-----END PGP SIGNATURE-----

--76DTJ5CE0DCVQemd--

