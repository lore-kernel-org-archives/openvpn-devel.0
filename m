Date: Sat, 26 Jun 2021 11:31:27 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210626093127.GU976@...1296...>
References: <CAFHpkQEoWAMOzBP9Ra1ygp-8HpRxhB3kmQEvZYuRrBqrYV05qw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/uPUIP8cclAS4PsY"
Content-Disposition: inline
In-Reply-To: <CAFHpkQEoWAMOzBP9Ra1ygp-8HpRxhB3kmQEvZYuRrBqrYV05qw@...278...>
Subject: Re: [Openvpn-devel] is this expected when using "--dev null" ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/uPUIP8cclAS4PsY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jun 26, 2021 at 12:34:27PM +0500, ???????? ?????????????? wrote:
> I'm using "null" for testing (to avoid modifiyng routes and interfaces).
> current master tells me
>=20
> 2021-06-26 07:27:03 net_iface_mtu_set: rtnl: cannot get ifindex for null:
> No such device (errno=3D19)
> 2021-06-26 07:27:03 Linux can't set mtu (1500) on null
> 2021-06-26 07:27:03 Exiting due to fatal error
>=20
> is this considered as a feature or bug ?

I'd consider that a bug.

I use --dev null on a test client, without adverse effects, but that
is on FreeBSD...

gert


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--/uPUIP8cclAS4PsY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJg1vPuAAoJEB2Cnv7KVigSa/gL/iEBOvHN4vipS4OlFzZuZIK7
uxXQ7elGOrnbPRTVav174rPc41ClEGS00ox/RCpYGeXPpkufOOmNZplIS0/ezXvy
2Uvr4h81zf/8NIWwCyCAuCuwe5aJBJQtz97h6UvEoe5QGIJZbHXtkYy0i/KzXnt+
rtCc9g+2aeYe2Tar+cBtyuKNKJ3ljB4ztK0L7eEn2WrL6imP+9ziUNgiL9G9m6L2
l+aqqbsUo1hSX3hpW3jQy1o8+oIyZAZEIY1HmtXypjeRqmaDBitUzXSWliPxxVvz
ixiEyRpXbI9Sk2Kfo6v50tDZK4rcBxjxbsTOUwDUzLcste3zWIeU42LDrLSqS8/c
fv7bNMhEml9FjOX5G6Qz1C/rAMWq9P4zlwSdQnw1Mn5Zx6th6CtIfoG8/kK7ONiV
v+1GzPF8/EgWTKbDaqnWsRdAE5WdDfDGJsDq6+sVNSR/fG47OL1Fm6kM9U8N4Hok
gI/wIWJoSgCbHXF0B1+I0599oimRUKESMjegkZx0zA==
=lr2L
-----END PGP SIGNATURE-----

--/uPUIP8cclAS4PsY--

