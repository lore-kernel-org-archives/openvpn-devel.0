References: <834c4ed9-af60-1f0b-091d-da0fafa6bd96@...2080...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <dcc82a0c-97fb-03bc-b1f6-5e39bbc7ecde@...2080...>
Date: Wed, 7 Sep 2016 19:28:44 +0200
MIME-Version: 1.0
In-Reply-To: <834c4ed9-af60-1f0b-091d-da0fafa6bd96@...2080...>
Subject: Re: [Openvpn-devel] Modernising the management interface
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 31/08/16 20:55, David Sommerseth wrote:
>=20
> Hi,
>=20
> I have for a long time pondered on how we can make the management=20
> API more suitable for more modern tools and tasks.  So I am just=20
> giving an extremely early heads-up on on what I'm poking at ...
> and hopefully receive some feedbacks on what you think.
>=20
> One of the things which have struck me is that D-Bus is adopted a=20
> lot of places, and its internal API have been considered stable
> for about 10 years or more.  Even though there are areas where
> D-Bus seems a bit over-engineered, it has proved to be a very
> useful IPC mechanism for a lot of software.

[...snip...]

Time for some proof-of-concept code!

<https://gitlab.com/dazo/openvpn-dbus-poc/tree/master>

This is just a plain and silly TCP management to D-Bus proxy.  It
does nothing fancy, but it is just a little introduction to how
D-Bus can simplify getting an integration to a management interface
in OpenVPN.

To do the more advanced features, such as signalling ("push" messages
from server to listening D-Bus clients) is something which will
require a lot more work and I have not considered doing this.

All information to get started should be fairly well documented in the
source code.  But if anyone have any questions, no question is too silly
.

A few details.

- - *DO NOT RUN THIS IN PRODUCTION!*  This is *Proof of Concept* code.
  It will be buggy, it is hacky and you cannot fully trust it.

- - A proper implementation will not use Python on the D-Bus server side,
  but will be included into the core OpenVPN C code.

- - A proper implementation will also use "properties".  This is
  currently not possible to do via the dbus-python implementation, at
  least not without too much additional hackery.  For a PoC, I did not
  consider this important.  But a proper implementation in C will make
  use of object properties to provide read-only information.

- - The API provided via the D-Bus by this proxy WILL change.

- - Please do not start massive improvements to this code, unless
  it helps understanding better D-Bus features which can be worth
  investigating further.

  Again: A proper D-Bus server implementation will happen inside
  the OpenVPN C code.  This code is purely to help us getting further
  in this discussion.

- - And please do not judge the code harshly.  I have prioritised
  getting something which works for a PoC.  I have not added much
  styling or very describing comments.  And yes, there will be bugs.


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJX0E5MAAoJEIbPlEyWcf3yh4wP/i5hEjqzqHy6hnocA0ANT5ov
VGfG1ZUF4QMUsyhjEbN2D1OM5sPQaPmH20CRcwbZGaZnuavDtjwBjc82IeopGaYC
S4VmjQYNwGMawmrYTOH3/ITg/JzySQ60wKMv5AZBPK31zcqoFFKaYw8klsvTsj/N
sO+ew/btlNdeosMKBGX/4+VjadgsvudX/o7GYfHVRonZX9E3B7tV7gE4EX5Z99xn
UEnnwHzH6Olw6dhObNopPaFiFLte9Indt1iOLb3Fng0qZL5BDqw/ltr4h5klmD3R
gJGFi75yarT41wW65ONZPm/530gzuwWEyaS2yPJ8YF7QLSiy8RZcMhdxjUP4a+dA
31dBfv/pWXHwM5lan668d9aIjAJ/q++9IMZmwIaqNI7MCudwemXjZ1opnwopz5rQ
nDjtOCjMeUhYo7aJAPTcxfUF+ty4JnMSnkWMRt7PJg1hJG5E4VbRiWPPDIfsXW0h
g8WRMPHPe/bG3dC/qH6zdzupi7GqHy9UyPeVBFrJ56TuWoGeuRKQ6NL4ahn67Vt1
th5rifBMEqsq/wxeQ+7EBYlgkNrO7A9ewo/5KNQVnYeRUv+kWAwrxeUAYzMWh7B8
Co0UX0mKV65IR/QH0hwag0mRgS7IxTX9Y5pV7WTfqmIzxaggWTrcJFVRby5Wr4Cq
Na26b+buT6xGdEnotrqf
=3DbbcG
-----END PGP SIGNATURE-----

