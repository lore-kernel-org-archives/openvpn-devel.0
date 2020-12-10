From: David Sommerseth <openvpn@...2080...>
Message-ID: <a6054de9-7989-0e11-0517-7319d1b52028@...2080...>
Date: Thu, 10 Dec 2020 23:44:24 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="cj5CFOLWM2VDHS8kffnvwFglEuAwuvSft"
Subject: [Openvpn-devel] OpenVPN 3 Linux client - v13 beta released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cj5CFOLWM2VDHS8kffnvwFglEuAwuvSft
Content-Type: multipart/mixed; boundary="lDgdkfRsM6IF6afrmQUPhcvzDmvOrDcHj";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net
Message-ID: <a6054de9-7989-0e11-0517-7319d1b52028@...2080...>
Subject: OpenVPN 3 Linux client - v13 beta released

--lDgdkfRsM6IF6afrmQUPhcvzDmvOrDcHj
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hi,

The OpenVPN 3 Linux v13 beta is now ready.

The highlights of this release includes:

* Feature: IPv6 and TCP protocol support in
  OpenVPN Data Channel Off-load (DCO) kernel module
=20=20
  -------------------------------------
  ## WARNING ## TECH-PREVIEW FEATURE ##
  -------------------------------------

  The DCO feature is currently a tech-preview feature.  It is not
  targeted for production usage in its current shape.  As this is
  still under heavy development, we currently only support the latest
  Fedora releases (Fedora 32 and newer), Ubuntu 20.04 and Ubuntu 20.10.
  This currently requires Linux kernel 5.4 and newer.

  This release includes an updated ovpn-dco implementation which adds both
  TCP and IPv6 protocols to be used for the transport between client and se=
rver.

  If you are testing the DCO feature, also be sure you use the updated
  kmod-ovpn-dco package or build the ovpn-dco module based on git
  commit 8f04ed862539f0.

  Please see the information at the end how to enable the DCO feature.

* Bugfix: Misleading argument count when options are missing arguments
  If an option requring a certain minimum amount of arguments was missing o=
ne
  or more arguments, for example using just --keepalive 30, the error would=
 be:

     ERR_PROFILE_OPTION: option_error: option 'keepalive' must have at leas=
t 3 arguments

  This is incorrect.  The correct number should be "2 arguments".  This has
  been fixed in the OpenVPN 3 Core library which generated this error strin=
g.

* Bugfix: Multi-factor authentication broke with v12_beta
  With the v12_beta release, web based authentication was added.  This also
  added signalling support for the CR_TEXT authentication method which was =
not
  intended to be added.  This resulted in many multi-factor authentication
  configurations to fail, in particular those connecting to OpenVPN Access
  Server.  This has been corrected and openvpn3-linux does no longer signal
  CR_TEXT authentication method support.


Supported Linux distributions:

  - Debian 9, 10 (x86_64)
  - CentOS 7 and 8 (x86_64, aarch64)
  - Fedora 32, 33 and Rawhide (x86_64, aarch64, s390x)
  - Red Hat Enterprise Linux 7 and 8 (x86_64, aarch64)
  - Ubuntu 16.04, 18.04, 19.10 and 20.04 (x86_64)
  - Tech-preview: Ubuntu 20.10 [grovy] (x86_64)

  Ubuntu 20.10 is expected to be fully supported as of the next release.

Instructions how to install OpenVPN 3 Linux can be found here:
<https://community.openvpn.net/openvpn/wiki/OpenVPN3Linux>


--=20
kind regards,

David Sommerseth
OpenVPN Inc


---- Tech preview: Enable OpenVPN Data Channel Offload ------------------

      -------------------------------------
      ## WARNING ## TECH-PREVIEW FEATURE ##
      -------------------------------------

      The ovpn-dco kernel module is under heavy development.
      This means that the API used between the kernel space
      and OpenVPN user space processes may change.  Therefore
      the kernel module version must be the same which
      OpenVPN 3 Linux has been compiled against.  Once
      the API is has become stable, this restriction will no
      longer be needed.

  Currently the DCO feature is only available for testing on Fedora 32,
  Fedora 33, Fedora Rawhide, Ubuntu 20.04 and Ubuntu 20.10.

  On Fedora, with the openvpn3 Copr repository enabled:

      # yum install kmod-ovpn-dco

  On Ubuntu, with the openvpn3 apt repository configured:

      # apt install kmod-ovpn-dco

  With the kernel module installed, the configuration file must be
  be imported:

      $ openvpn3 config-import --config CONFIG_FILENAME \
                     --name CFGNAME \
                     --persistent

  Then the imported configuration profile must get the DCO feature
  enabled:

      $ openvpn3 config-manage --show --config CFGNAME --dco true

  To preserve this setting through reboots, --persistent was added
  when importing the configuration file via 'openvpn3 config-import'.

  Now everything is ready and a VPN session can be started:

      $ openvpn3 session-start --config CFGNAME

  In the log data generated by OpenVPN 3 Linux, you should see
  an UDPv4-DCO, UDPv6-DCO, TCPv4-DCO or TCPv6-DCO reference similar
  to this line:

      [...] CONNECTED servername:port (x.x.x.x) via /UDPv4-DCO [...]


---- Source tarballs ----------------------------------------------------
* OpenVPN 3 Linux v11 beta

  <https://swupdate.openvpn.net/community/releases/openvpn3-linux-13_beta.t=
ar.xz>
  <https://swupdate.openvpn.net/community/releases/openvpn3-linux-13_beta.t=
ar.xz.asc>

---- SHA256 Checksums ---------------------------------------------------

3eb1ea7166f21525c23ff37d971ac71916e4b476df7ddd6c50dc3684e864e738  openvpn3-=
linux-13_beta.tar.xz
fa69dedbeaf754eac298e55f7b3b490959cc34b183ee777cd8651533b403241e  openvpn3-=
linux-13_beta.tar.xz.asc

---- git references -----------------------------------------------------

git repositories:
    <https://gitlab.com/openvpn/openvpn3-linux>
    <https://github.com/OpenVPN/openvpn3-linux>

git tag: v13_beta
git commit: 20319752618587500d7d5bc496965d742ce161dc

---- Changes from v11 to v12 --------------------------------------------

David Sommerseth (1):
      client: Don't signal support for crtext authentication

Lev Stipakov (5):
      ovpn-dco: support for various transport protocols
      core: Update to Core library with ovpn-dco transport improvements
      ovpn-dco: Update to latest git master
      ovpn-dco: truncate nonce_tail length
      ovpn-dco: remove cbc-hmac support

-------------------------------------------------------------------------


--lDgdkfRsM6IF6afrmQUPhcvzDmvOrDcHj--

--cj5CFOLWM2VDHS8kffnvwFglEuAwuvSft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJf0qTOAAoJEIbPlEyWcf3y3goP/RNq3NDTZxRnBodm0vsjCZYt
/SadLPl1XWOCnTH0ZySCjJTOy1hIKQDEtWgtjjNUEBj/tltze7NrrLVCTcVRojUr
AVX91hsB4OHvi/s8AjQgJCv9ao3ybSm1FqOsS/bR6E3fCg5xQ9vr+YloB/bjFEaC
xrsQxFStdBbHnExFV8PR32wtTe5jokRj7NGZpN1RJEL2jDdGQU0MdJosgt69nsTM
Can4WHIFFO86fHhgbaNNdLjwsWIrEwXOXnHnTdehMCJFJukAaRp26LGGtJIiXpeL
UvwsyS0Ezglo3EltkyvmdUU6RjihxTapskLoEp/4zeQ+33OPaoKCYs9OqWk2rr8j
WtABJrWo11KSzF9OvBv/tlyQbB+BDqz5yYWZoTSSg/23ws95By7tnHnUbKRs78Q3
7Baeh3D/hxgXcBoOUIdzrxA8agz6eDtDID5mBAfLOXJVknpuZMjZwkKLWZzAgSth
ETMW/DdPL2zl5FmjCZHm1tjq2s09yMEAQEaoRuRXt3mUQPGDR4dxO+YFWiR/mQoC
/WuEihlnHv6pRN2rkCknK4yv1EVK3bse7cmjAhszYQJo7U9SAxN2Cx81P8IX0jwD
QADk1gcAwKZMbysZP+z47729+PeJWMEL9Swev4GtuNgycDF/zjaUNYriWjw5NXp1
bj7ygTwenm3mWfoFhs7o
=cFpj
-----END PGP SIGNATURE-----

--cj5CFOLWM2VDHS8kffnvwFglEuAwuvSft--

