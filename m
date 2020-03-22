From: David Sommerseth <openvpn@...2080...>
Message-ID: <b7699035-f70a-6df4-c2a2-082d7f3433cf@...2080...>
Date: Sun, 22 Mar 2020 15:38:59 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="6DrCI7IBe8H0TuhA9NKKdCuAfIzKBXJnn"
Subject: [Openvpn-devel] OpenVPN git master builds for Fedora/RHEL/CentOS
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6DrCI7IBe8H0TuhA9NKKdCuAfIzKBXJnn
Content-Type: multipart/mixed; boundary="Q6Q87dAEgMgltPS2MHxn3SWPlYpNE3wUy";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <b7699035-f70a-6df4-c2a2-082d7f3433cf@...2080...>
Subject: OpenVPN git master builds for Fedora/RHEL/CentOS

--Q6Q87dAEgMgltPS2MHxn3SWPlYpNE3wUy
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hi,

I've put together a Fedora Copr repository which contains builds of the
OpenVPN 2.x git master; which will contains what will arrive in the next ma=
jor
release.

<https://copr.fedorainfracloud.org/coprs/dsommers/openvpn-git/>

Instructions are pretty simple when using yum copr.  If you are on
RHEL/CentOS/Scientific Linux, ensure you have the 'yum-plugin-copr' package
installed first.

Then you can just do:

    # yum copr enable dsommers/openvpn-git
    # yum clean all

If the copr plugin is not available, see the URL above for direct access to
the repository files.

If you already have openvpn installed:

	# yum update openvpn

Or replace 'update' with 'install' if this is a fresh openvpn install.

I will on some semi-regular intervals update these builds when I see git
master has been updated.   If you have any issues, you can easily downgrade=
 to
the previous version by doing 'yum downgrade openvpn'.

If you have automated updates enabled on your system, you might want to
consider to blacklist the openvpn package - as the openvpn git master might
not be as stable yet as the released versions.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--Q6Q87dAEgMgltPS2MHxn3SWPlYpNE3wUy--

--6DrCI7IBe8H0TuhA9NKKdCuAfIzKBXJnn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJed3iEAAoJEIbPlEyWcf3ypXgP/3/Q2+Tns+AbEsPkNslYGmEB
Fw+MEn6Xb528Z939Zq/0Zr4s10ZxHueu+VC+VhbuFsZKXVRsQPvzhSAosj2azJO3
PC9Wu80lC2PR9CAiXoZP2LzBgSa/wW2BVpNiVZMSyimbeMEKT7xspiAgPeYYLDYE
3btTPdXT2FymZySUjD6g19pC/pEtSoZojTH8jWwmXTh6OCB+FSCVmBHdEzlcZUsm
A7qBWld+wJ062mkyu5eQIdj3MEBXsbSLZtVXjfPUXN3s7lOF4gGv8Bx4MkHi+och
5l01ikKHca46Osx7ZobBGCWTMy8ChkJZ3ebZIoCbfmcYPUG+vGp32BGMKML9Oy0x
4B9dk7ipvxH19NgEs8K6k/c9njAXUd0+jsM1MPCnSxHcy42kOJ2+EP+WruNNq2GJ
hsl7m4BpCx/l+nhjn00iHz5bH4B7DVCq5QWQFpO5rt0ofpn6fmFVbk2Vpl0BPeUe
rRbQ1iaPfDwR4TNDpk3Omc/M2AKBJUrn0Z3iGn4heyVFIhZYmBOqSbYeL2mk//Z3
RN/Ebfy1vKK0C4ujvLwkER3TKJBWLbSN4Z8SpmdSp9+u4NOA2FdZezZKzEQUZ9MH
vUMfo0MPLBZC11Au1sD49ghOCCD7DHMLYOZPdCd4IyUFTjVQVFuXx1YA2TWwORCh
grubY6ohb/cUXd8ZA2S+
=wWfM
-----END PGP SIGNATURE-----

--6DrCI7IBe8H0TuhA9NKKdCuAfIzKBXJnn--

