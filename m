From: David Sommerseth <openvpn@...2080...>
Message-ID: <b6a0586a-f97f-086a-5700-25eb4b1a68a6@...2080...>
Date: Thu, 23 Apr 2020 21:36:11 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7msHYmshEeiOZu18OxgS7hzzgnTLoMvE7"
Subject: [Openvpn-devel] OpenVPN 3 Linux client - v9 beta released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: OpenVPN Users <Openvpn-users@lists.sourceforge.net>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7msHYmshEeiOZu18OxgS7hzzgnTLoMvE7
Content-Type: multipart/mixed; boundary="6QVMwG3pXijBB8kt34WeLCOWFJ0SpekFM";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: OpenVPN Users <Openvpn-users@lists.sourceforge.net>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <b6a0586a-f97f-086a-5700-25eb4b1a68a6@...2080...>
Subject: OpenVPN 3 Linux client - v9 beta released

--6QVMwG3pXijBB8kt34WeLCOWFJ0SpekFM
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hi,

The OpenVPN 3 Linux v9 beta is now released.

This is available in our git repositories [0] and URLs for source tarballs
are listed later in this e-mail.  We have pre-built binaries for the
following Linux distributions:

    * Fedora 30, 31 and 32         (via Fedora Copr: x86_64, aarch64)
    * RHEL/CentOS 7 and 8          (via Fedora Copr: x86_64, aarch64)
    * Debian 9 and 10 (amd64)
    * Ubuntu 16.04, 18.04, 19.10 and 20.04 (amd64)

Ubuntu 19.04 is no longer supported upstream, so we do no longer provide
builds for this disitribution version.

Normally we also have Fedora Rawhide builds available, but there are some
issues with the Fedora Rawhide images so it is currently not possible to
provide these builds there yet.  This may change in coming days.

A quick-start guide for OpenVPN 3 Linux can be found here:

    <https://community.openvpn.net/openvpn/wiki/OpenVPN3Linux>


The highlights of this release includes:

* Feature: AWS VPC add-on service (openvpn3-addon-aws package) which
  can be configured on EC2 Linux hosts deployed inside an AWS Virtual
  Private Cloud (VPC).  This allows the host running an OpenVPN 3 Linux
  client with this service configured to act as a proper VPN gateway
  for hosts inside the VPC.  The AWS service will update the VPC
  configuration dynamically, adding and removing routes pushed to the
  VPN client.  The openvpn3-service-aws(8) man page contains the
  configuration details.

* Bugfix: openvpn3 session-manage --restart and --resume
  modes would not respond to re-authentication requests required by the
  VPN server

* Bugfix: openvpn3 session-start and openvpn3 session-manage
  commands would not handle CTRL-C (SIGINT) situations properly during
  the connect phase to the remote server or when asking for user input.
  Prior releases would just leave the VPN session running in the
  background.  To get rid of these background sessions the user had
  to also use openvpn3 session-manage --disconnect to really stop
  these lingering sessions.  With this update, interrupting the
  openvpn3 session-start and openvpn3 session-manage operations
  during the connect phase or when acquiring user input, will result
  in the running VPN session will be properly shutdown.

* SELinux: The policy file needed on hosts with SELinux enabled has
  been relocated to a more proper location for such extensions, moving
  it out of /etc/openvpn3/selinux.  A slightly modified version
  of this SELinux policy has also been accepted for inclusion in the
  upstream SELinux reference policy project.  Packagers needs to
  ensure this policy is not shipped on distributions with a recent
  enough reference policy.  See the GitHub pull-request #209 [1] in
  the SELinux reference policy project for details.


--=20
kind regards,

David Sommerseth
OpenVPN Inc


[0] <https://gitlab.com/openvpn/openvpn3-linux>
    <https://github.com/OpenVPN/openvpn3-linux>
[1] <https://github.com/SELinuxProject/refpolicy/pull/209>


---- Source tarballs ----------------------------------------------------
* OpenVPN 3 Linux v9 beta

  <https://swupdate.openvpn.net/community/releases/openvpn3-linux-9_beta.ta=
r.xz>

<https://swupdate.openvpn.net/community/releases/openvpn3-linux-9_beta.tar.=
xz.asc>

---- SHA256 Checksums ---------------------------------------------------

c6d530b660239c80b96e3207fae69839b186704d3416f25f4cd1d8daef12ff36
openvpn3-linux-9_beta.tar.xz
ec535ce49e4b957ae54bb717d7a72fb5c89bb4b67c1f0202a4c178e8c8e5674d
openvpn3-linux-9_beta.tar.xz.asc

---- git references -----------------------------------------------------

git tag: v9_beta
git commit: 4e251217750ebf1b268e345815f3df3b154f576f

---- Changes from v8 to v9 ----------------------------------------------

David Sommerseth (13):
      selinux: Clean up SELinux policy
      selinux: Compress the policy and move install dir
      build: Rework SELinux logic with --disable-selinux-build
      addons/aws: Implement proper option parser
      log/core: Extend CoreDBusLogBase to also set LogGroup
      docs: Update D-Bus service doc for net.openvpn.v3.netcfg
      selinux: Further minor improvement to policy module
      python: Add --dev-node to the list of ignored options
      docs/man: More rendering improvements to openvpn2(1)
      vendor: Update to asio-1.14.0
      ovpn3cli/session: Handle re-authentication for --resume/--restart
      ovpn3cli/sessions: Improve SIGINT handling when starting/resuming ses=
sions
      ovpn3cli/session: Improve user input of credentials

Lev Stipakov (5):
      netcfg/cli.cpp: add missing #ifdef guard
      Add missing override declaration
      Update to latest openvpn3-core library
      addons: Add Amazon Web Service VPC support
      man: Add conditional man page for openvpn3-service-aws

-------------------------------------------------------------------------



--6QVMwG3pXijBB8kt34WeLCOWFJ0SpekFM--

--7msHYmshEeiOZu18OxgS7hzzgnTLoMvE7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJeoe4xAAoJEIbPlEyWcf3yeyEP/3NO4htYNvcKfzzuf5i/VTM5
vzW//baD/BxJNDHFFlJaUoOnwKhm7JPlBn1pzcr6jug9GotQ+c/HfpzXzj3BH4oP
LD1stDbdI/pM6haDYxRk4YXOfRGC6J+aSLKG73Ywd76Gcrftb2E4uLChZ3JFa9X+
LQFna7DJKxhCzsJu7PwIxGQCriA0ew2vrpM9Hk7qYGXDf5EjnONxFnvwJxVOoBsA
HqoTCmncliqy5StONrRAJ8kd/zifWIHIPoR/nV5x5KPRVTrnoP0JbNdYkigyZtk+
v3r7AkQNaBgoJf0WWr0M99kMEP4kL82YDOVdxJKTBmHqedli3tYk3JZDLh5sTy8B
RZWz5a16/Fz/Ku/Q/ixiwXMmhf7ifxO15DP3PbdD7NzV8BJdfCPhu0BoZ3CB/yHD
zJxeuFOqhmSffC8GCSVm05f95emrKRCpYWXmfMmo2AxtLdJBkeLurIn11yd61j3p
cZC/QvpuJMPv0GCXPvFPHgtmvyF7XKruJI1nYQqVZyxbek+t99a79uHggMukEtIQ
G8D2T3Pc8tyHrS6w2nA9A4rETRXYh96QecP4pbDTvlTNDjJjk+LNX4f7NoTj/i63
TJ1UzMcbK/TuICcHpRFzM9DLk0w0CGNhUdhDvN+ydwEMCAMB4Gh1lEqBn8nBJaQ1
d5FiEVZgxwn44L7W2RVD
=5ZYK
-----END PGP SIGNATURE-----

--7msHYmshEeiOZu18OxgS7hzzgnTLoMvE7--

