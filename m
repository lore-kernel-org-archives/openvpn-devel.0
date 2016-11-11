References: <1476996158-5390-1-git-send-email-davids@...515...>
	<5f201645-8325-b93c-42db-355fef4da9ea@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <b348180e-8e88-7e16-3279-a5bdfeb8c397@...2080...>
Date: Fri, 11 Nov 2016 13:32:00 +0100
MIME-Version: 1.0
In-Reply-To: <5f201645-8325-b93c-42db-355fef4da9ea@...277...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="PWsQKm5uJHbNJ7fSLw2XiGHJg2dtwahjk"
Subject: Re: [Openvpn-devel] [PATCH] systemd: Improve the systemd unit files
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PWsQKm5uJHbNJ7fSLw2XiGHJg2dtwahjk
Content-Type: multipart/mixed; boundary="xtng9WhKd94S5II0D1at7puK5NHx2vPLa";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <b348180e-8e88-7e16-3279-a5bdfeb8c397@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Improve the systemd unit files
References: <1476996158-5390-1-git-send-email-davids@...515...>
	<5f201645-8325-b93c-42db-355fef4da9ea@...277...>
In-Reply-To: <5f201645-8325-b93c-42db-355fef4da9ea@...277...>

--xtng9WhKd94S5II0D1at7puK5NHx2vPLa
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable


On 11/11/16 13:09, debbie10t wrote:
> Hi,
>=20
> following are the server and client systemd unit files
> which work best for me.
>=20
>=20
> Tested on:
> Archlinux     - OpenVPN 2.3.13 x86_64-unknown-linux-gnu - systemd 231
> CentOS 7      - OpenVPN 2.3.12 x86_64-redhat-linux-gnu  - systemd 219
> Debian 8      - OpenVPN 2.3.13 x86_64-pc-linux-gnu      - systemd 215
> OpenSUSE 42.2 - OpenVPN 2.3.8 x86_64-suse-linux-gnu     - systemd 228
> Fedora 24     - OpenVPN 2.3.12 x86_64-redhat-linux-gnu  - systemd 229
> Ubuntu 16.04  - OpenVPN 2.3.13 x86_64-pc-linux-gnu      - systemd 229
>=20
> Tested with:
> Multiple server and multiple client configs all enabled.
>=20
> Tests:
> systemctl enable/disable/start/stop/restart/reboot
>=20
> Result:
> ALL Tests passed.


Thanks a lot for a very thorough testing!

I will update the patch with setting separate RuntimeDirectory=3D for
these two profiles, then we won't step on the toes of distro provided
openvpn{,@}.service files at all.

As there are quite few who are active on this ML and in our community
with systemd experience, I'm going to apply the updated patch before the
2.4_beta1 release - unless there comes an informative NAK message before
that time.  And if someone gives an ACK, it will be applied sooner.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc




> Note:
> I have inserted blank lines to help with email line wrap.
>=20
>=20
> =3D=3D=3D=3D=3D
>=20
>=20
> openvpn-client@...1685...
>=20
> [Unit]
> Description=3DOpenVPN tunnel for %I
> After=3Dsyslog.target network-online.target
> Wants=3Dnetwork-online.target
> Documentation=3Dman:openvpn(8)
> Documentation=3Dhttps://community.openvpn.net/openvpn/wiki/Openvpn24ManPa=
ge
> Documentation=3Dhttps://community.openvpn.net/openvpn/wiki/HOWTO
>=20
> [Service]
> PrivateTmp=3Dtrue
> RuntimeDirectory=3Dopenvpn-client
> RuntimeDirectoryMode=3D0710
> WorkingDirectory=3D/etc/openvpn/client
>=20
> ExecStart=3D/usr/sbin/openvpn --config %i.conf --nobind --suppress-timest=
amps
>=20
> CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW CAP_SETGID=
=20
> CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
>=20
> LimitNPROC=3D10
> DeviceAllow=3D/dev/null rw
> DeviceAllow=3D/dev/net/tun rw
>=20
> [Install]
> WantedBy=3Dmulti-user.target
>=20
>=20
> =3D=3D=3D=3D=3D
>=20
>=20
> openvpn-server@...1685...
>=20
> [Unit]
> Description=3DOpenVPN service for %I
> After=3Dsyslog.target network-online.target
> Wants=3Dnetwork-online.target
> Documentation=3Dman:openvpn(8)
> Documentation=3Dhttps://community.openvpn.net/openvpn/wiki/Openvpn24ManPa=
ge
> Documentation=3Dhttps://community.openvpn.net/openvpn/wiki/HOWTO
>=20
> [Service]
> PrivateTmp=3Dtrue
> RuntimeDirectory=3Dopenvpn-server
> RuntimeDirectoryMode=3D0710
> WorkingDirectory=3D/etc/openvpn/server
>=20
> ExecStart=3D/usr/sbin/openvpn --config %i.conf --status=20
> %t/openvpn-server/%i-status.log --status-version 2 --suppress-timestamps
>=20
> CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE=20
> CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
>=20
> LimitNPROC=3D10
> DeviceAllow=3D/dev/null rw
> DeviceAllow=3D/dev/net/tun rw
>=20
> [Install]
> WantedBy=3Dmulti-user.target
>=20
>=20
> =3D=3D=3D=3D=3D


--xtng9WhKd94S5II0D1at7puK5NHx2vPLa--

--PWsQKm5uJHbNJ7fSLw2XiGHJg2dtwahjk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYJbpAAAoJEIbPlEyWcf3yHV4QAKX1r9rhKztCFH4dct6iiFyu
yh9JtnkHguaEWx04MYHgwHLeJuaDpWmo6DeCMA6iPHjJsXyGPDCOuYpF9DoCZlKu
V8MOFpQuWjd10VA58Acgjqacf01b00ailmGdbH5HFdUseSlepsAAiusIQegea8VK
wQsiSI2w+m0HkKO6rmSzb973I8hknN2uebZUyvW5iSCPzPrrkI5qJAzA+ppRwmdI
jr9obRvEX+UAQzAK910GdYCCyBermIOtFdfJRLcFFBhloTRfVc2GXigcFVaigYds
uoGw6IALxKDwNJamEpdKgHzyTkeMwigLSQQwZ3xp//WNpXbTpSTl9+XiZi05aRfR
6jjdPdGqq6cH5Eg9KmlyxKecBXEQ7bCtYCoh7G/Og2J4ffbRkYR5vzwEZxQyfvk2
5PMJ/yXmLWGED8hfhyVvN3j/FfkE/XaLHnSQGCQdsLf4untwAJ9OvE9WecXtTomf
WwizTTmgNtqupVeTYwMEHuFezgQt3wo91pdGny0QRMbId2n6SHev9d/x6n+Sn+oN
SRu2R5UGgbY2wmW9V5PMgwewIkemCLiund2hx7rDQf3CnC3C6s4RdCou3jsHCoM5
enbGXyBc5J6B06Nksdgtp9lRNg2T8gHw66Q/HOccMQqkI5a2caXMelh4wcYNG3Mt
HNoMNJVbswAlSvaw0eUw
=4ClV
-----END PGP SIGNATURE-----

--PWsQKm5uJHbNJ7fSLw2XiGHJg2dtwahjk--

