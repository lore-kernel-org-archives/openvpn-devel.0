From: "Michael H. Warfield" <mhw@...1243...>
In-Reply-To: <9e0cf0bf0907282147n3dcdb7f6ue91065cc2d606f72@...278...>
References: <4A5EFE61.3020100@...41...>
	<3453b4110907280133n32070ed3rd93598fd1b64740e@...278...>
	<9e0cf0bf0907280218p25c081f7v203b4780309cb6b9@...278...>
	<4A6EFCFF.2090400@...1114...>
	<9e0cf0bf0907280650i3dabf036gc9e2f8c745823e15@...278...>
	<4A6F05B0.4020602@...1114...>
	<9e0cf0bf0907280720y45b629d5sd7fe3d2525811280@...278...>
	<3453b4110907281129x509c2bb1rbbfe4a817765e503@...278...>
	<4A6F634E.7020202@...1114...>
	<3453b4110907281422u4284faen6cd632e62f11cdf7@...278...>
	<9e0cf0bf0907282147n3dcdb7f6ue91065cc2d606f72@...278...>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-dE3UWDR79l7m7CN7ylwU"
Date: Wed, 29 Jul 2009 09:47:19 -0400
Message-Id: <1248875239.7329.41.camel@...1244...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc19 released
Reply-To: mhw@...1243...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: mhw@...1243..., openvpn-devel@lists.sourceforge.net

--=-dE3UWDR79l7m7CN7ylwU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-07-29 at 07:47 +0300, Alon Bar-Lev wrote:
> Well,
> I do not understand you guys.

> If you think SELinux is so great, why do you need chroot?
> It is like you put some money in safe, and then put the safe into
> another safe, it never ends... Why only two safe, let's put another
> safe...
> I know that this is the approach many of security advisors use, but I
> never could have found the logic.
> If you want to keep your money safe use a single safe and select the
> strongest one.

	Security professionals refer to is as "defense in depth".  Look it up.
The opposite of which is "all your eggs in one basket".  Not good.

	With defense in depth, if an attacker finds a hole in one defensive
layer, he should get caught in another.  That way, he has to be perfect
and get through all your defenses without getting caught while you only
have to stop him at one.  The other way (single defense), your defense
must always be perfect and reliable while he only needs a single hole
through that single layer.

	Your choice.

> And final note regarding the iproute wrapper.
> It is a *WRAPPER*, if I needed top secured implementation I would have
> created a daemon listening to network change requests using unix
> domain sockets, wrap this up in SELinux profile, and implementing a
> logic that allows only changes to tap/tun interface with specific
> attributes, and allowing routing table update with specific details.
> Then add a wrapper that uses the unix domain socket in order to access
> the daemon. OpenVPN will use the wrapper so it needs no special
> privilege. The daemon validates what SELinux or any other security
> product cannot validate: Network configuration changes. All done
> within a valid and separate context.
>=20
> As I wrote earlier, most of OpenVPN configurations need to execute
> iproute also during session. For example, if you like to connect two
> sites, your super SELinux secured solution will work only at one site.
>=20
> No need to discuss this further. I get your point.
>=20
> Alon.
>=20
> -------------------------------------------------------------------------=
-----
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-D=
ay=20
> trial. Simplify your report design, integration and deployment - and focu=
s on=20
> what you do best, core application coding. Discover what's new with=20
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--=20
Michael H. Warfield (AI4NB) | (770) 985-6132 |  mhw@...1243...
   /\/\|=3Dmhw=3D|\/\/          | (678) 463-0932 |  http://www.wittsend.com=
/mhw/
   NIC whois: MHW9          | An optimist believes we live in the best of a=
ll
 PGP Key: 0xDF1DD471        | possible worlds.  A pessimist is sure of it!


--=-dE3UWDR79l7m7CN7ylwU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQCVAwUASnBS5uHJS0bfHdRxAQJV/QP/VDxURD5BEyLkWSU9revnUkSQHaJLBtaG
k2hOb6tE8fJHax3Vb6uZ2omtcGDYR23e2itLlwofmM+nxJYeBEO5XSh55BZvYkh/
RAYKxhB4RMs+g0zbNk3OidbiwOxoWEQkESjyROmHfjAUEQ8j4CiX3PSf947v5O88
gpngBWbR3N8=
=YP4h
-----END PGP SIGNATURE-----

--=-dE3UWDR79l7m7CN7ylwU--


