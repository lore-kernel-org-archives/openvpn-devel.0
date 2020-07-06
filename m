Date: Mon, 6 Jul 2020 18:18:08 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200706161808.GI1431@...1296...>
References: <f4b83fe0-cbe1-eed3-ff9b-4aaaea5a12b1@...1147...>
 <20200621111403.GP1431@...1296...>
 <CAKuzo_h2oTaNK7A3+3MJ6GSfApr9L9vXYFtzELH8SaaNzqFWuQ@...278...>
 <f664dcaf-7224-1b17-c953-584557f2ac56@...1147...>
 <CAKuzo_iFf2iuOLg4LpXrz42MG1GggvdrcWKJrcDT6j38tQjrUw@...278...>
 <20200624102804.GM1431@...1296...>
 <50ad64e7-b75c-e40b-5d5e-9e89e90db45d@...1147...>
 <20200630141103.GY1431@...1296...>
 <67f23584-07bd-7f0a-de1d-6ac285342e46@...1147...>
 <885f8b43-cd49-a88e-4a69-4913c0636e56@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8hSxo1h+EBUf47rB"
Content-Disposition: inline
In-Reply-To: <885f8b43-cd49-a88e-4a69-4913c0636e56@...2080...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Multiple DNS search suffixes on
 Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: Jan Just Keijser <janjust@...1147...>, Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--8hSxo1h+EBUf47rB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jul 02, 2020 at 11:04:41PM +0200, David Sommerseth wrote:
> Can we please see this discussion also in context of this mail thread, wh=
ich
> tries to look a broader at this challenge?

There's two things here - a small and useful featurette which can go
into 2.5, and the broader negotiation / option rehaul work for 2.6.

> The main purpose of that RFC is to ensure we handle DNS and --dhcp-options
> consistently across all OpenVPN implementations we care about, and that we
> document this properly.

As far as I understand, jjk's patch is in line with what Tunnelblick
already does on MAC, and does not conflict with the larger plan.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--8hSxo1h+EBUf47rB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfA06/AAoJEB2Cnv7KVigS1KwL/iW6pbBDkQ3sfqJ8HIOaI1C/
9xqP4RcNRBh4Bplqd59FNnypnz9RdT3ABjp3zapXWJyTdfQJYlD4lqUhKky/bfLo
uxSH85BMmedw3jFlsgRK+hRjC8EtV8v03BifwjcsIGSG/IKpsC+J+lWlt34WdrSG
s0W6UhwWYrKbokasFCtd3gtqpM9KJ9ctn5VC2Tm19XMFvs5cf131pygvCmDuv8NN
IpFE3tjbmFje6wkWD3kYnTC/Si+enfOR97Og/vWugD5ZTLJaMqLNk3DcbNVVlFbN
9ZYkjYbYjoArk3VccCrtaGM5VSRGDz7WpO2hS1jNsiygysBtKkaUafuLWtm66pwt
TJZYkGUwkH8su7mrH3HpV8Rp/PqXMSJPmDwvd2zdymaNFU2eIwZSIWr3Squh0Ha1
LSA526zeDPWrnlqBRdwHTq72c+o7Mp6Zb9FCZjHOVpix5Op/viawGguUEYKFRjPP
r4920qy+tv8xz5M87U1uTREi0WHsJ5BfyM7zH8+Qyw==
=rjRP
-----END PGP SIGNATURE-----

--8hSxo1h+EBUf47rB--

