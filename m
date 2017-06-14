From: Steven Haigh <netwiz@...2277...>
Date: Thu, 15 Jun 2017 02:00:07 +1000
Message-ID: <4097180.z8bzRHlKCk@...2278...>
In-Reply-To: <106966713.aa984eDaXM@...2278...>
References: <4598001.fBjbu4afFW@...2278...>
	<CAKuzo_gvaAC_BFKjRTOOE_9zfg9ZPJTjvCYnmLzutwpRkxc-vA@...278...>
	<106966713.aa984eDaXM@...2278...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4997291.oEYJkVNujE";
	micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] RFC: Yubikey authentication for OpenVPN.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--nextPart4997291.oEYJkVNujE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thursday, 15 June 2017 1:13:16 AM AEST Steven Haigh wrote:
> On Thursday, 15 June 2017 12:42:53 AM AEST Selva Nair wrote:
> > On Wed, Jun 14, 2017 at 9:32 AM, Steven Haigh <netwiz@...2277...> wrote:
> > > script-security 2
> > > client-connect          /etc/openvpn/yubikey-auth-tokens
> > > auth-user-pass-verify   /etc/openvpn/yubikey-auth-tokens via-file
> > > client-cert-not-required
> > > username-as-common-name
> >=20
> > Why the last two entries? client-cert-not-required is not something one
> > should encourage users to do. Apart from that yubikey verification may
> > have
> > to be done asynchronously (using deferred auth), else connections to all
> > clients will stall during each verification which may take some time.
>=20
> In my setup, I use username + OTP. I don't provide a client cert to each
> client.
>=20
> I wonder if I could use $ENV{'username'} in client-connect instead to make
> this a little more consistent. This would remove the need to 'username-as-
> common-name' to be set.
>=20
> How would a client cert as well as username/OTP affect this flow? Is that
> expected to be verified by client-connect or another script? or is the ce=
rt
> validation done elsewhere - by openvpn in this case I guess?
>=20
> (apologies, mail client fat finger - I sent this reply to openvpn-users
> first time around!)

Ok - in reviewing this, I've removed the use of the username in the first p=
art=20
of the token as generated in the 'client-connect' portion of the script. As=
 we=20
don't get a username in the client-connect, I've added a 64 char random str=
ing=20
to the first part of the token. While this doesn't help crypto wise - it=20
assists in making it a little more difficult to predict.

The driving part behind this is to try and not have a static preset key use=
d=20
in the generation of the auth-token. Instead, we use system specific and=20
connection specific things instead.

The up-shot of this is that it removes the need to use the 'username-as-
common-name' directive in the server config.

It would then be up to the server operator if they wished to use client-cer=
t-
not-required and just utilise username + OTP or issue client certs and use=
=20
cert + username + OTP.

I'll post a v2 of this script when the client side issues are taken care of=
=20
within openvpn for auth-tokens and am able to test the full loop around.

--=20
Steven Haigh

=F0=9F=93=A7 netwiz@...2277...	=F0=9F=92=BB http://www.crc.id.au
=F0=9F=93=9E +61 (3) 9001 6090	=F0=9F=93=B1 0412 935 897=

--nextPart4997291.oEYJkVNujE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEFHf0gfgNrH6ofcYGQa811Xp9MdwFAllBXYcACgkQQa811Xp9
MdxvvBAAvoKVExn5r88Crl3CA/jgVYKj4CZ7Biy7ED3HQHhSczdF+bXVcVZAvdbn
+tmXZct8N5Qsr3+47tnup4o3QJeps3lDwAWxkQ3i8VlUn4MjapMgPlrWFdIcx9dT
pbh50e8gkda0iJtnUKD6lOsosO9kbZOihiimom6ernsHfgc394GyVpsLLOjpovWA
z8vsKcY6M2IH2vnOtZHsMVYOi9eDuXaeEzzUhskwPHP7l22HiaY9v8hCLr+mu9Bk
yNczpkdD2WuEzsSIYBPgirgzJSnS8GIe4qwZJ/65tw7vJ4XRaLS5y9Colvv5BYK8
AsnFOKujzxMYx8okF2D5ELPCDks8SNUSptsswkrp+akFQHFxzMCT3s4yrlRsdd8B
HE+8fVh9GVI6/u0tKL0nroIwV8nmkvyRHoP0Z78MyAGTXz7S6Hfop3LYZd/GDFZm
TiISpDXb9o8Dv2y00uN96Ayz6+VSM1IxfENnTlNwjmY1MQS4KcjvJyrzZEmypu24
4G8QyZGw3Rq/Y36RHWbVrqY7XHSlpj203jmJNkdt78mHzFfahHt4KLT8bGiEUJj5
csHt8SAktcn+8l1ijPm/m/K/DE0YR0SquHaQVr3N9PT0vLpMXCRIEqUK5HALzq+/
qYD461gSbMolE6xibPY6AfQY5sCTIJ9/qdyoabVfYzaVOJEnCCg=
=E35h
-----END PGP SIGNATURE-----

--nextPart4997291.oEYJkVNujE--


