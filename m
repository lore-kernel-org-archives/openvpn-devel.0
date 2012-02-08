Date: Wed, 8 Feb 2012 09:09:54 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120208080953.GS13929@...1296...>
References: <CA+3tv22Xq447J_EXKM4SYP-45V7LN0NJfH6o9skUNPPij3PDuQ@...278...>
	<1CED409804E2164C8104F9E623B08B90129328AD5E@...1436...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JWOY2/vB4uO4FuME"
Content-Disposition: inline
In-Reply-To: <1CED409804E2164C8104F9E623B08B90129328AD5E@...1436...>
Subject: Re: [Openvpn-devel] OpenVPN and Android 4.0 VPN API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Adriaan de Jong <dejong@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--JWOY2/vB4uO4FuME
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Feb 08, 2012 at 08:39:32AM +0100, Adriaan de Jong wrote:
>  - The ABI expects a two-stage setup process: set up a control
> channel first for negotiation, then a call VpnService.Builder with
> the proper routing, DNS, addresses, etc. As far as I've been told
> by other developers, this is not how OpenVPN currently works.

Unless I misunderstand something, this is *exactly* how OpenVPN works
on the client side :-) - connect to server, figure out what we need to
configure, then call init_tun(), add_route() etc. to configure interface
and routing.

Now, right now there is not a single "setup_stuff()" function but it's
spread across interface init, interface ifconfig, route addition, etc. -=20
but it shouldn't be too hard to build a set of "#ifdef ANDROID" functions
that just gather this information and then pass it in one go to the API.

> - We would need the management interface to export the routing
> and network parameters that need to be set, so that a surrounding
> android app can call the appropriate Java methods.

Which very much sounds like the --service-pipe stuff that Heiko is
building for Windows.  openvpn.exe runs as unprivileged process, and
when it wants to setup interfaces or routing, messages get sent via
the service pipe to the (new) openvpn service that does the privileged
operations.

>  - We would need a call in the management interface allowing the tun inte=
rface to be passed back into OpenVPN.

Can't you just pass "--dev tun4" to OpenVPN?  Or do you need to pass a=20
file descriptor, handed to you by VpnService, instead of opening the tun
inside OpenVPN?

Maybe I don't fully understand how that API should be working.

> None of these problems are impossible to solve, but they would
> take some refactoring of the OpenVPN main and connection code. Any
> input would of course be appreciated!

Heiko's new service stuff already solves large parts of this :-)

... and for the rest, well, we'd need a volunteer that wants to *work* on
this, not just ask for it...  I don't have an Android device (and no
time) so it wouldn't be me.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--JWOY2/vB4uO4FuME
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTzIt0akuBuNlUUl1AQJwlAQAtFI/Y5+w+3+fd1Un7GjMsXsDOfloJvo9
Wb05zvdE3VijTPo9o1hMsyllaNCFWg5BqhflSe1EL4NB2i64OVf1GewMSolPbxEh
XgBUYjUBH/ZAjSfZIqXKR4IFBX6NfF8RPZX0Htr2fU+ty/bAXVMej0lcxljmE2fw
6I5QrtRUuvM=
=TAGT
-----END PGP SIGNATURE-----

--JWOY2/vB4uO4FuME--

