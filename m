From: Steven Haigh <netwiz@...2277...>
Date: Thu, 15 Jun 2017 01:13:16 +1000
Message-ID: <106966713.aa984eDaXM@...2278...>
In-Reply-To: <CAKuzo_gvaAC_BFKjRTOOE_9zfg9ZPJTjvCYnmLzutwpRkxc-vA@...278...>
References: <4598001.fBjbu4afFW@...2278...>
	<CAKuzo_gvaAC_BFKjRTOOE_9zfg9ZPJTjvCYnmLzutwpRkxc-vA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2660829.aBuZpKX8XG";
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

--nextPart2660829.aBuZpKX8XG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thursday, 15 June 2017 12:42:53 AM AEST Selva Nair wrote:
> On Wed, Jun 14, 2017 at 9:32 AM, Steven Haigh <netwiz@...2277...> wrote:
> > script-security 2
> > client-connect          /etc/openvpn/yubikey-auth-tokens
> > auth-user-pass-verify   /etc/openvpn/yubikey-auth-tokens via-file
> > client-cert-not-required
> > username-as-common-name
>=20
> Why the last two entries? client-cert-not-required is not something one
> should encourage users to do. Apart from that yubikey verification may ha=
ve
> to be done asynchronously (using deferred auth), else connections to all
> clients will stall during each verification which may take some time.

In my setup, I use username + OTP. I don't provide a client cert to each=20
client.

I wonder if I could use $ENV{'username'} in client-connect instead to make=
=20
this a little more consistent. This would remove the need to 'username-as-
common-name' to be set.

How would a client cert as well as username/OTP affect this flow? Is that=20
expected to be verified by client-connect or another script? or is the cert=
=20
validation done elsewhere - by openvpn in this case I guess?

(apologies, mail client fat finger - I sent this reply to openvpn-users fir=
st=20
time around!)
--=20
Steven Haigh

=F0=9F=93=A7 netwiz@...2277...	=F0=9F=92=BB http://www.crc.id.au
=F0=9F=93=9E +61 (3) 9001 6090	=F0=9F=93=B1 0412 935 897=

--nextPart2660829.aBuZpKX8XG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEFHf0gfgNrH6ofcYGQa811Xp9MdwFAllBUowACgkQQa811Xp9
MdzLAw/+K8pLxdVD6g0ytrrKGlfh91ZlLE8vo2ohksT85CJUEICr9eAmB5ViFoAp
N+QD3ck2rXMtcPf7QGluRxN22VGoJRqzyQoajicDVwXQxnWWsB5fgzC1sGzNL68/
uMVj1N+Ia5NWGs53llagJfKuNpJpNysz1raLb/t+nOqHUdruz4P2tispSMCMGtcm
Y8nzsJiXweZy8sn4VbK0a3l08g5Y8PjQ256lwuzDDhV2MjHmVGPXvhPn7ea+yMef
+ECqW0epEqlM3lP/C6o0jLMOh0AVw2v3jCxQMOcV8MPI+Wsy/MV/qNatwpuA5CG8
uWGjSFBL5tfHOVuGtzy4FuC2FI27ztlTiYkVcAdOZFgv2j8l+/JY1vXYPksihCT2
wC8R7+msUVY7m0ixQmuGm01sYHX7ixAFrMEyil6nGh+Zafxn8u9nStW9+rpHlymr
lXHJZ+Cx1rSoiM4H/4L+tXMB9wOKwRwi+0rBlEnv5ehh9CJybUgfJ38BnR8d5AL9
MDv5/vgKa2HBs7QWZQYNK8MvHvpt8wRmVH5nHaoFkfUDwJ1G3mTVzbCVt4V19Fjy
L6MXjH68D1f8ETUHbBG/77VE4Mjmiub7LKB3izB1omXBx2QwxLoG2bCv24xGqp51
g8XzX9hrZqYecjNdwxWjNkHGXSR0nR1kDXLkLkTq2h/Sei+5h1A=
=HcFc
-----END PGP SIGNATURE-----

--nextPart2660829.aBuZpKX8XG--


