Date: Fri, 11 May 2012 20:56:41 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120511185641.GZ1359@...1296...>
References: <CAOazyz35bB=q1hpdzjj_aHZ7K_0koT8pcw0csham2AOwMqGrfg@...278...>
	<4FAAF945.8070005@...1227...>
	<CAOazyz12Rw0kOSS+siU7tLP4eXO5XkhexjVLn+uC97s4K1Z8EQ@...278...>
	<4FAAFCB4.8040606@...1227...>
	<CAOazyz2wP2ms7HC31LPp3VzFRBu+S3zURZm1ozz0MzjmhQv07g@...278...>
	<4FAB0556.50903@...1227...>
	<CAOazyz2pdJysuaEhoDL8O=S=CdEfW8XCuB6n8YrnKjOBqstTPA@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8A98@...1436...>
	<CAOazyz0Qb8xa-FUqQcMDX=w+=Vb3J8sQ2R8GAxNtfWxT-4DNkw@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8AB9@...1436...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NHt+8aug4e70lOou"
Content-Disposition: inline
In-Reply-To: <1CED409804E2164C8104F9E623B08B9012D1CF8AB9@...1436...>
Subject: Re: [Openvpn-devel] [PATCH] Openvpn for Android 4.0 Changeset
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Adriaan de Jong <dejong@...1435...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--NHt+8aug4e70lOou
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, May 10, 2012 at 09:00:05AM +0200, Adriaan de Jong wrote:
> That would be another option. In the model we were using (which might be =
different), the order is as follows:
>=20
> 1. openvpn is started
> 2. openvpn opens a socket to the remote host
> 2. openvpn establishes the control channel across this socket
> 3. openvpn passes socket and control channel data (IP, routing, DNS, etc)=
 through the management interface to the android app
> 4. android app passes these to the VPNService and receives an opened tun=
=20
> 5. android app passes the tun to openvpn
> 6. openvpn proceeds as usual

This looks very reasonable to me.

(As for the patch itself, I had no time to go through it yet, sorry)

Changing the build environment to build a shared library out of openvpn
is something I do not fully understand yet, though - and don't view
a particular useful goal right now.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--NHt+8aug4e70lOou
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT61g6akuBuNlUUl1AQI81gP/UPwwIjFaqqJxjtbiXWhO4wwcFMcKNmHV
39d9dy2jpAvFPJ/1nyHqrbQAhl0deP833QJly1ieIv2GnQbzFjFBT8tvHEDNh7xo
nLnoDSBRoF3xTCCDguqucR1SAQg8gc78PX0YF8Ub1QR5vAFupWyciGU4JhCRPhZy
dk3gt/OAV14=
=oDFZ
-----END PGP SIGNATURE-----

--NHt+8aug4e70lOou--

