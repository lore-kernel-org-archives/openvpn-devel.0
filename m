References: <efe4c17a-1d4d-d20f-cc77-cf7564ea1184@...2080...>
	<1472133483.61594.587.camel@...1866...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <8e9eb1dd-2505-7414-4828-6d6b6d1e25f0@...2080...>
Date: Thu, 25 Aug 2016 16:15:00 +0200
MIME-Version: 1.0
In-Reply-To: <1472133483.61594.587.camel@...1866...>
Subject: Re: [Openvpn-devel] [RFC] - Enable 2FA to be used with
	renegotiations
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: David Woodhouse <dwmw2@...1866...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 25/08/16 15:58, David Woodhouse wrote:
> On Thu, 2016-08-25 at 15:45 +0200, David Sommerseth wrote:
>>=20
>>=20
>> I've been working a bit on a new patch-set which enables
>> third-party user/password authentication mechanisms using two
>> factor authentications [2FA] (such as OTP) and not needing to
>> disable the renegotiation features of OpenVPN.
>=20
> Hm, you handle the server side of OTP through PAM alone?

This change does not change the initial authentication at all.  You
still need an authentication plug-in or --auth-user-pass-verify
script.  But once this first authentication passes successfully, the
OpenVPN server takes over the coming authentications required due to
re-negotiations.

A very simplistic diagram over the process

   Client                            Server           --plugin or
                                                 --auth-user-pass-verify
   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   connects and sends
   username + password  ----------> passes
                                    username +
                                    password  ------>   authenticates
                                                         user

                                 On SUCCESS   <------ sends SUCCESS/FAIL
                                 generate auth token
   replaces password  <--------- push auth-token
   with auth-token               to client

   ~~~~ rengotiation happens ~~~~

   sends username +
   password (auth-token) ------->  checks if
                                   clients auth-token
                                   matches token stored
                                   in session object
   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


> Any chance of client-side OTP working automatically using=20
> liboath/libstoken and/or being able to use OATH support on
> hardware like Yubikeys?

That is probably doable, but would require extending the plug-in API
and a plug-in to actually acquire a new OTP code.  For this patch-set
this is out of scope, as this change needs to happen inside the
authentication plug-in.


- --=20
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJXvv1kAAoJEIbPlEyWcf3yRpwP/0WFggjQUDdCHLpL5R0mh/Bp
YJbWlu89oy8sVoOn6dB/o6D5p+rKqYDsNu0ME3TE6z0tl4bY+k7N1eiYY96EZqlN
+N7HAuQGkb38Mpc+/hNUPrNhtt0Xl5NbMFgHCEPGdNrkO38HM1s5Z+sAba2lR04Q
aM5RlRlyUOBXIdr+m3k4WcFA6G/KzgcgDNZuztQQ8w7mFNoglVllWybdL+nNIbIL
emczNgEpH0/T95UdAvD8rg7rUBquSCYmhkEcWa1VgqcwniLuYShG10FW6DyuglpA
ZUMPqlNOoqYNgWzYFgIQe5EerHAGZt06VEBbMjZDcE91sOEp10mUrnnsELhTG9P0
kn4cK43zxtfrTez+J91P3T7ccGiutE4F3y+m/5iaRShuBdFechf+JWA6j3+KLyct
MWGIUhlc1wmBhgDToDL/5WaxiS64U78SZXCsBP6mXUbzJGGrUXdfXbdMn0gI5cfk
PzsMjKv7r2kEl2Pol/shzHcbRnNiSiqlDadwTA+Cgnlt6oJQn8SbsnKGIExbNWwj
1ldCLSToJHM8mWf63e0hl4RGKBGFIfVt7XMNsVDFy6J01JqWPDG1ggGQ5IhgpGmX
xIZv3nXELcE7vWaJLrORiXAfJ9j9K67H1KBH6JK6OueL7DStUXVzypVltlGdg0Ko
yit+GYTFBI1mW+d9adKs
=3Dj5fd
-----END PGP SIGNATURE-----

