Reply-To: openvpn-devel@lists.sourceforge.net
References: <CAFHpkQF9yo3qjs0kYbkSZqKa4xjsy7u5e0VqZ76H21S6puH5Mw@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <03bff833-41dc-8c3d-442c-3f360888196e@...2080...>
Date: Wed, 23 May 2018 11:06:33 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQF9yo3qjs0kYbkSZqKa4xjsy7u5e0VqZ76H21S6puH5Mw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="36EGOSguckcbtyo16kk8fjaPwCsi4sBuT"
Subject: Re: [Openvpn-devel] linking interactive service and openvpn.exe
 into single binary ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--36EGOSguckcbtyo16kk8fjaPwCsi4sBuT
Content-Type: multipart/mixed; boundary="8scAsC5he3FbfgSJyc3t4i9f9K2Kirldr";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <03bff833-41dc-8c3d-442c-3f360888196e@...2080...>
Subject: Re: [Openvpn-devel] linking interactive service and openvpn.exe into
 single binary ?
References: <CAFHpkQF9yo3qjs0kYbkSZqKa4xjsy7u5e0VqZ76H21S6puH5Mw@...278...>
In-Reply-To: <CAFHpkQF9yo3qjs0kYbkSZqKa4xjsy7u5e0VqZ76H21S6puH5Mw@...278...>

--8scAsC5he3FbfgSJyc3t4i9f9K2Kirldr
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 23/05/18 10:08, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
> Hello,
>=20
> we observe weird registry corruption, when "exe_path" points to wrong loc=
ation.
> I came to an idea, why not to link both service and openvpn.exe into sing=
le
> openvpn.exe thus removing the need to specify exe_path at all ?
>=20
> thoughts ?

Why not just use dirname() of the openvpn.exe binary path and expect the
service to stay in the same directory?

Linking openvpn.exe and the interactive service is not going to be a trivial
task at all and will mandate two different main() functions which are
triggered depending on either basename(argv[0]) or some options ... this is
going to be messy.

Plus this approach can more open up new attack vectors as well, as a single
binary can do much more work.  Like a buffer overflow in the packet process=
ing
(UDP/TCP or TUN/TAP code paths) triggering execution of interactive service
functions - this can easily be abused for privilege separation as the
interactive service runs with elevated privileges while the plain openvpn s=
ide
runs unprivileged now.

So no, we should not "link" the interactive service with openvpn.exe.  Even
though I am no big fan of qmail and the ucspi-tcp package, there are a few =
key
things to learn from that approach.  Each individual piece in the qmail cha=
in
does a very limited set of tasks and focuses only on that.  So if there's a
exploit happening in one of the pieces in the chain, the damage is quite
controlled and limited to the privileges of that individual piece.  It can
truly be a big hassle and pain to set up such an environment, but it has so=
me
merits regardless.  I do not say we should split up OpenVPN like qmail, but=
 we
should try to keep the footprint privileged code running as small and
controlled as possible.  Which is why we have interactive service and why
we're working on a NETLINK integration on Linux.  And OpenVPN 3 on Linux ta=
kes
a very different approach to this as well, and there is work in the pipe to
reduce the privileged footprint even further.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--8scAsC5he3FbfgSJyc3t4i9f9K2Kirldr--

--36EGOSguckcbtyo16kk8fjaPwCsi4sBuT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJbBS8jAAoJEIbPlEyWcf3yragP/0mrXPJGDrK6xXhSDzc3xOYS
KuPFlunqju6jzCrDDjAsygZ1nWIAJGG53/CrR2H7DUZ8vlfWdWM0XN7jTS8jvp1z
Rl0cUpFV5cmar2cTy+kcT9yHbyJshNFM4g3aeUtqXHoMfoE6o8/sqHT4udITJNUn
lNKTVbMq8wensKfvdYWIOku2LRn+lzRws2/dCJ9AnUrDVa4qkuBVu9z+t4GHhXrp
RHBEow5+Y26HmxVpvaPIdKZoeLOluCocTSzMOVOr3VTMphpWUumA1Srr6L1genRz
xIMOsxeaa9Q/BUhlnKhlhYer4Aj8YTBTaIA0oIO25eGuKxVm42ie5rZaDB5Nyrnm
Rl7NGEI9CDbBQ4L59mRUmlzXUezxYUA6fvr5y6hLg+MKPsn1TBzTg08K8/Nb+jeL
dewV6PqlNqL/EDyIq4RwdhZuJeelh/DG2qwC+g9bvmPtoSvtbZnT+7GyJE5w0sB+
oR4b9s/XIjDnm0zurlUAhtnir+nwxV3Ku31OniuOoHpd9UqUhtyTu9E5qNOdw9Zt
yjbF3Grr/GzdE89slpNTXwdOM8hTD0R2WLhA+G/2UBWwel/mBbAbHnPZ6h9u8rkC
O8IjxNPe9TopMpC10d7IwKl8eKF3U4Fn9CnsGSSCSAaxVjVCKRLSfw+fbj9En5LY
ZDKR1wlGcZzLvhWyN5Dl
=I1zc
-----END PGP SIGNATURE-----

--36EGOSguckcbtyo16kk8fjaPwCsi4sBuT--

