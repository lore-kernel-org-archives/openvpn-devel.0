Date: Fri, 11 Feb 2022 10:44:07 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YgYv50jgbpMyGlv8@...1296...>
References: <20220210162632.3309974-1-arne@...1227...>
 <20220210162632.3309974-2-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="4xBYs6F1XFJr7H5L"
Content-Disposition: inline
In-Reply-To: <20220210162632.3309974-2-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v4 2/8] Change the default for mssfix to
 mssfix 1492 mtu
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--4xBYs6F1XFJr7H5L
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 10, 2022 at 05:26:26PM +0100, Arne Schwabe wrote:
> The current default is 1450, which translates to 1478 byte packets for ud=
p4
> and 1498 byte packets for udp6. This commit changes the mssfix default
> to take the outer IP overhead into account as well and changes the target=
 to
> 1492. 1492 was picked in our community meeting for being a very common
> encapsulation upper bound.
>=20
> The change also disables an mssfix default if tun-mtu is set to a value
> different than 1500.

I think this needs a followup patch... I'll apply it (as it does what
it says on the lid), but it needs further work, see below.


Feature-ACK on having "1492 mtu" by default, so that is good.

It should have a Changes.rst entry for "User-visible Changes" - I tried
to draft something, but then decided to send it back via the list.  Here's
my draft text

  - :code:`--mssfix` default has been changed from 1450 to ``1492 mtu`` to
    take IPv4 or IPv6 encap and today's typical SoHo internet links into
    account.  If :code:`--tun-mtu` is changed from the default setting,
    the default for :code:`--mssfix` is now ``off``

Also, the patch needs to change the manpage from

    "Default value of 1450 allows ..."
to=20
    "Default value of ``1492 mtu`` allows packets to be transmitted
     over a link with MTU 1492 or higher without IP level fragmentation.
     If :code:`tun-mtu` is used to set a value !=3D 1500, mssfix needs
     to be configured with an explicit value, as no default applies."
(or such)


The code itself looks a bit fumbly with changing "o->ce.mssfix_encap =3D tr=
ue"
in the defaults section, just to change it back to "false" in the options.c
handler - why not leave it at false, as it's set to "true" anyway at
setting MSSFIX_DEFAULT?


But my main concern is this combination of options:

  --tun_mtu 1400 --mssfix

what would the user expect OpenVPN to do here?  I would expect "apply
mssfix handling, in a reasonable fashion for the configured tun_mtu",
but what OpenVPN does is "turn off mssfix, because, not 1500".

So the default "no mssfix in the config" and "mssfix without arguments"
are handled the same way.  If this is intentional ("mssfix without
arguments does nothing if the tun_mtu is not 1500") it should be
documented.


This said, the patch applies and works fine.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--4xBYs6F1XFJr7H5L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiBi/nAAoJEB2Cnv7KVigS0lAL+wVwrEtl5vlR8HFjPcBGZBwp
Wn2g2xCynJC5zHb4y/m4bohBKWoHYZ+k+7eO6zzAaC+pZHxeYuzYYezL0ZuNS6T7
TxJCbeGqal2OGHVRXhoq16ClrQeEOPZBnCqSgNU0XMc66iToMG8jcqY/CoChgq/Q
jA0eeqV2VVNNJTIvhqYRrgD+I82tSFz9/XhigeA8p2dDWl94FD+/+yrga7ir3qxG
i9GGF4YJf1SxwjJYnMBmaWFTYFJl/5FF455OzBgf5r28wA8h2bSxG6IwR744GYFv
cOUhxqnhxAmHLPVbQgSKvTZ9D2Ka03FDvQD3hdZXHlGM3BtqsRQErkmMfgjwb2Qr
wY1QVfbUSd5WYnZ8j5lpgCRSzlZ59gY693TZnGT5ACb46iTWO6v39+NJuStSSzK4
3YHpVCLIw0BWhd1SO+F8jOGbLhSR5aeb/5o5BRA9Ynv2NPmrc8+1X0rMNGmGmLBh
QzRyN7yDurTHFEEjZaondq0Mw7ahqEq25ArhROpuqg==
=kkoi
-----END PGP SIGNATURE-----

--4xBYs6F1XFJr7H5L--

