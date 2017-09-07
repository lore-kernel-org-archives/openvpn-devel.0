Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170906235202.26551-1-davids@...515...>
 <45ee0784-77cf-bba1-85cf-f7c6265b25f5@...277...>
 <41cf1b9e-bb4b-a2f1-3c3a-cde43c8e0eb4@...2080...>
 <84bc7ec5-886e-7ae6-87a7-0385d0506376@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <8c9c7f22-30a6-a192-f56d-961605a6d1c2@...2080...>
Date: Fri, 8 Sep 2017 00:55:48 +0200
MIME-Version: 1.0
In-Reply-To: <84bc7ec5-886e-7ae6-87a7-0385d0506376@...277...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="wQ3bCGnrlTd0T2IXcHuOmmgPulK1XGG74"
Subject: Re: [Openvpn-devel] [PATCH] systemd: Enable systemd's auto-restart
 feature for server profiles
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: fragmentux <fragmentux@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wQ3bCGnrlTd0T2IXcHuOmmgPulK1XGG74
Content-Type: multipart/mixed; boundary="SVnBTV4Vs7e57iiLxLm9PnsbA8bnoo9aj";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: fragmentux <fragmentux@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <8c9c7f22-30a6-a192-f56d-961605a6d1c2@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Enable systemd's auto-restart
 feature for server profiles
References: <20170906235202.26551-1-davids@...515...>
 <45ee0784-77cf-bba1-85cf-f7c6265b25f5@...277...>
 <41cf1b9e-bb4b-a2f1-3c3a-cde43c8e0eb4@...2080...>
 <84bc7ec5-886e-7ae6-87a7-0385d0506376@...277...>
In-Reply-To: <84bc7ec5-886e-7ae6-87a7-0385d0506376@...277...>

--SVnBTV4Vs7e57iiLxLm9PnsbA8bnoo9aj
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 07/09/17 23:02, fragmentux wrote:
i,
>=20
> all your comment are totally valid from a sys-admin point of view but
> from an openvpn POV, the only responsibility is to provide a secure VPN.
>=20
> Use all of systemd's functions to maximize openvpn's process *security*
> But *forcing* restart as an almost unconditional default is nonsense.

We are in the position to promote sane and good defaults.  This
behaviour is considered sane and good by many sys-admins.  So when these
two view-points intersects, I see no harm of us actually promoting this
change.

> How would you do this for non-systemd systems ?

Isn't that obvious?  systemd unit files are for systemd.  Non-systemd
systems doesn't have systemd unit files, thus there is very little we
can do about them.

> I disagree with making this change to the default
> openvpn-server@...1685... unit file.

Your opposition have been noted.

> If you really want to include them then how about:
>=20
> Either:
> =C2=A0 openvpn-server@...1685... (responsible for start/stop etc actions)
> =C2=A0 openvpn-server-auto-restart@...1685... (speaks for itself)

NAK.  This is not how the design around systemd unit files is intended
to be used.  Plus: it already exists a Debian bug ticket where there are
comments about us adding 2 more unit files.  If adding even more, I can
already sense the heat increasing on that ticket.

> Or rather
> =C2=A0 include extra .service files in ./contrib. as samples or such.

NAK.  I rather have a document simply describing how to change the
defaults using 'systemctl edit'.  Which is exactly how systemd is
designed to be used.  But we should have a baseline of recommended
defaults, and sys-admins can choose to opt-out of these defaults through
standard mechanisms, not by adding complexity through more unit files to
scan through.

Just image a system which actively uses both openvpn-server@ and
openvpn-server-autorestart@...220...  Unless we also split up
/etc/openvpn/server ... it will be even more confusing when
investigating a server in 2 years why something is misbehaving.  "Did
this config run through this or that unit file?".  openvpn-server@ is
clear and specific, it handles server configurations.  Period.

If you want a specific configuration or all openvpn-server@ OpenVPN
configurations to behave differently from the recommended defaults, then
you do that through 'systemctl edit', where it is very visible if this
specific configuration have some additional tweaks not - through
'systemctl status'.  This way sys-admins won't have remember or research
which 'sub-unit file' of openvpn-server@ to achieve a specific behaviour.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--SVnBTV4Vs7e57iiLxLm9PnsbA8bnoo9aj--

--wQ3bCGnrlTd0T2IXcHuOmmgPulK1XGG74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZsc5+AAoJEIbPlEyWcf3yCEEQAJ97FG9vK/NO9kfH1lVJhgAD
yyNzhg0sL5kutaPFDBwRu1mDQVAiDk9TftCSArIix0CyGLxxloATYxArPqcu8uyU
QqZRyOdtifzPFWKk5jqRg7Q7ggus3OqRnxTcpwRYV6jfA1nML43ziSUrn0xPSi+L
vr8OQrc5mFbKX9yO7KghxBZyj6szdT/a6zxa8ImvIk7FWiW0+v/WsLZnUrR+huj6
l4rwCqPW5VnSxfG2SKZ1IbWoCBnFSI/oPCvNBN6T4EE1LlMkd2ynqD/0ANWvvAcy
VEPvsaAcdDX09gpHbtkdFTJ84l8/hB+uI7yoYLAB1dd64WWYOv38eICVAsgYPHPO
C0LOdBBK/Eck2UUJnsiHrr5QRZK++/BWmDwbUNM8Kh81KcN3j+qa/DZg+Pan/TKt
y0ysCPa/JjsoVOasVQCUDhwcX8X8BW0MdlKkOxEPiqs5lg/0Kv40X+UMMg7wX3fl
YEslZw9/kk2YgMAVS9xv2wmSF+ZkH+k5zUX7ggUdYHBNU05DhMdTDUbtSTTrESgR
i4gCoWzuxfcXQearboFlW5WDNJKfOc+hIw9F3VDKTRN3JPrtqBRCnpy8pSfIgf2B
sR1pm6KXlDlObO+vVxetk3/2SBcP/GxYBrdg09G5HwKl1q9oTMJIgS6c1WRpIkv1
nyC1AZp/BQbEfuE3Fsa7
=AhJ1
-----END PGP SIGNATURE-----

--wQ3bCGnrlTd0T2IXcHuOmmgPulK1XGG74--

