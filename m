Date: Sun, 20 Dec 2020 19:54:02 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20201220185402.GQ976@...1296...>
References: <20201220105430.GP976@...1296...>
 <093511bd-43c0-a37c-1d8f-335d9df451d6@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="bN+oGdjWBBKFJM7z"
Content-Disposition: inline
In-Reply-To: <093511bd-43c0-a37c-1d8f-335d9df451d6@...1227...>
Subject: Re: [Openvpn-devel] wanted: mechanism to send text messages to
 client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--bN+oGdjWBBKFJM7z
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Dec 20, 2020 at 04:00:13PM +0100, Arne Schwabe wrote:
> > ... and the client would then either print this on the console
> > (if !management) or dump it to management, where the GUI/Tunnelblick
> > could pick it up and create a popup window.
> >
> See --echo.=A0 That is basically what you desribe as info-msg in your mail

While echo sounds as if it would do what I want, it doesn't.

Echo is "something magic" - it is never printed by the 2.x client, it
is not even logged.  And it's not displayed by the GUIs either, but
instead it can be used to "do things"...

So less "echo to user" but "send this string to the management interface
and make the mgmt client do something magic"...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--bN+oGdjWBBKFJM7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJf353KAAoJEB2Cnv7KVigSJy8L/0LV78Qw+ozFPoNo9+py2aKf
I6UyuG1+qxcbMMTTi7lEIl41WTlO3ngyyu/XPOl9ZQKzq2tvQCrfv6AFJ72vEvN0
tB6K0K6Kn7aUDNLUO+WJAVxbV2X0ga8VYWpLEipWvXcFUsn4tvqkVWd/0nc7DPB3
Wb1puh3KctD0OGu685Q2i1Cu8TAUkx5ZrXHS7WqQykPGP+w5ZPmsFXf+hJ4fV5Y2
1xNCO6MGyp//7uhUevz1MseylUWef9tJxWH6yTZbahrphMof70ZBvAnCka8sw2Jm
acj/OGn5RHB4e+ITKUiZdXyhEAX1SO4jJOhY+pRvDynRbw8gmsfRihWjLb7RCjZu
Q6Xn6jgVfLUvX4gy1XFWSWplLi9C07B5C9HlQgm8CniAVkP0JK01U7dxPURB2fJE
1IQY3c8kGZiZKc2cyhad6L8EfbHOXI1Xh41iIuSVNBDlFSbIwWQNbK2W4ivwKuFz
Qy7gM0LU+iyPRxW12FSoNJ79mtN/QQtNJkktQJAn0Q==
=etNY
-----END PGP SIGNATURE-----

--bN+oGdjWBBKFJM7z--

