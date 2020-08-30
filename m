Date: Sun, 30 Aug 2020 14:07:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200830120703.GV75094@...1296...>
References: <20200814080619.2108-1-arne@...1227...>
 <CAAWBBYM2+4FqN-HyV9W19fJfAHKd9K4KHhnQFz2_5f3tzdvMFA@...278...>
 <20200829194728.GU75094@...1296...>
 <CAAWBBYM+8YfP9-nwAsPYM806CzQXoy_5d+9MLkfyGPatE3BTAQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Y+QtaVjtxOtr8cXH"
Content-Disposition: inline
In-Reply-To: <CAAWBBYM+8YfP9-nwAsPYM806CzQXoy_5d+9MLkfyGPatE3BTAQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix client's poor man NCP fallback
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Rafael Gava <gava100@...277...>
Cc: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Y+QtaVjtxOtr8cXH
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Aug 29, 2020 at 09:42:46PM -0300, Rafael Gava wrote:
> Actually, I was testing Samuli's 2.5-beta2   installer from the link belo=
w:
> Note sure if it's with the patch for data-ciphers but I guess so.
> I'll pull the 2.5-beta2 code and build it in order to check if it's
> working properly.
>=20
> https://build.openvpn.net/downloads/releases/OpenVPN-2.5-beta2-I601-amd64=
.msi

The installer has the right binary, *but* the binary has the same=20
"ingrained" windows version number, so when going from beta1 to beta2,
the .msi will just not upgrade openvpn.exe.  Known bug (now), being
worked on.

[..]
> On Sat, Aug 29, 2020 at 4:47 PM Gert Doering <gert@...1296...> wrote:
> > Which combination of client/server is this exactly?  2.5-beta2 on
> > the client, what is on the server?  Can we have some more log file,
> > including the "PUSH_REPLY", please?
>
> The server version is 2.3.18.
> The client:
>=20
> 2020-08-29 16:02:50 us=3D235805 OpenVPN 2.5_beta2 x86_64-w64-mingw32 [SSL
> (OpenSSL)] [LZO] [LZ4] [PKCS11] [AEAD] built on Aug 27 2020
> 2020-08-29 16:02:50 us=3D235805 Windows version 10.0 (Windows 10 or great=
er)
> 64bit
> 2020-08-29 16:02:50 us=3D235805 library versions: OpenSSL 1.1.1g  21 Apr
> 2020, LZO 2.10

Mmmh.  Now, 2.3.18 is just a little bit oldish.  But still, 2.5_beta2
*should* work nicely with a 2.3 server, after adding "data-ciphers BF-CBC"
to your local config.

If it still doesn't do that, you found a new bug :-)

(Is the server compiled with --enable-small, which means "no OCC"?)

> I falled back to the 2.5-beta1 using the same configuration  and it worke=
d.
> Attached are both logs and the client config.

Uh.

So:
   2.5-beta1 --> 2.3.18 *works*
   2.5-beta2 --> 2.3.18 *fails*

is that correct?  (Seems beta1 might have accidentially worked, while
a fallback code path for "no NCP, no OCC" was disallowed in beta2 and
might be breaking this)

Arne?

> 2020-08-29 16:02:50 us=3D235805 OpenVPN 2.5_beta2 x86_64-w64-mingw32 [SSL=
 (OpenSSL)] [LZO] [LZ4] [PKCS11] [AEAD] built on Aug 27 2020
[..]
> 2020-08-29 16:02:53 us=3D643016 OPTIONS ERROR: failed to negotiate cipher=
 with server.  Add the server's cipher ('BF-CBC') to --data-ciphers (curren=
tly 'BF-CBC') if you want to connect to this server.

This is very clearly "beta2", and the error message looks most silly...

[..]
> 2020-08-29 21:08:10 us=3D91399 OpenVPN 2.5_beta1 x86_64-w64-mingw32 [SSL =
(OpenSSL)] [LZO] [LZ4] [PKCS11] [AEAD] built on Aug 14 2020
[..]
> 2020-08-29 21:08:13 us=3D679932 PUSH: Received control message: 'PUSH_REP=
LY,route 194.145.17.0 255.255.255.0,route-gateway 20.20.0.1,topology subnet=
,ping 90,ping-restart 600,socket-flags TCP_NODELAY,ifconfig 20.20.0.2 255.2=
55.0.0'
[..]
> 2020-08-29 21:08:13 us=3D679932 Outgoing Data Channel: Cipher 'BF-CBC' in=
itialized with 128 bit key

So... something is still not right here.


And I need to extend my testbed with server configs that match this (2.3,=20
2.3-enable-small, 2.4).

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Y+QtaVjtxOtr8cXH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfS5ZRAAoJEB2Cnv7KVigSSdYL/1q5Wx9FNecXdEOhxjuPUP4H
+mCDRav0Uqi+tbwTb/6WstrWPvoivdMAehjkjYZhKC/CUcQ6Z/BDUmnw5D68EUUH
G9QGJysrCyTKStUPEJ7RSJ732BPXcizLA5gxLF3s4OB4apPjIRIKmHeCXuWP8gYO
0IVFzdN2UwUroycILCryFNchu/tciYqCfG9PYsGY3KwQtTYSTTsfOIF4YDG+NrZq
XqKKz/CE0jWRgBtAjWGoeQlkt8ycw106+Vb/BuiTHB9xFjJZfcJ0AfA+sOJHwOK1
jPpo4WcYpQCvMQ6QYiQBLRYn7//ONE7LC1AJWldeIU5PwKzXZoRUoWbXlJ+J3MYI
6Ov3dwnN5+CVqPb5Vhztgw5VHLnmXOE1q4VfLblb+XtNebrxgH5iGaKoXeh96PRX
jiUjFQHdXPWUL5i66Y+dbI0E5JS+qg2G7PUq5xCwntrFarGhats0TiIkz7IzV9nR
CHrwCh38Vs69CChUCW2O+0qx9zMjP83SIJfikug70Q==
=YwLk
-----END PGP SIGNATURE-----

--Y+QtaVjtxOtr8cXH--

