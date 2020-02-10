From: David Sommerseth <openvpn@...2080...>
Message-ID: <335cdace-669b-d291-b6ad-66019113aff5@...2080...>
Date: Mon, 10 Feb 2020 23:32:47 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="UhryBbZBdjJ44PhzaBG1mM5jOsE2fSlfY"
Subject: [Openvpn-devel] OpenVPN 3 Linux client - v8 beta released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, OpenVPN Users <Openvpn-users@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UhryBbZBdjJ44PhzaBG1mM5jOsE2fSlfY
Content-Type: multipart/mixed; boundary="KDkEfvg5L66yIxDuicjTMa0fvuBSEyBXE";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>,
 OpenVPN Users <Openvpn-users@lists.sourceforge.net>
Message-ID: <335cdace-669b-d291-b6ad-66019113aff5@...2080...>
Subject: OpenVPN 3 Linux client - v8 beta released

--KDkEfvg5L66yIxDuicjTMa0fvuBSEyBXE
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hi,

The OpenVPN 3 Linux v8 beta is now released.

This is available in our git repositories [0] and URLs for source tarballs
are listed later in this e-mail.  We have pre-built binaries for the
following Linux distributions:

    * Fedora 30, 31 and Rawhide    (via Fedora Copr: x86_64, ppc64le, aarch=
64)
    * RHEL/CentOS 7 and 8          (via Fedora Copr: x86_64, ppc64le, aarch=
64)
    * Debian 9 and 10 (amd64)
    * Ubuntu 16.04, 18.04, 19.04 and 19.10 (amd64)

But there is an annoying detail with this release.  Cloudflare is doing
its best to ensure that the .deb package repositories are corrupt, invalid,
missing or not seeing the new files.  I've tried to do the magic steps
required to clean up this, with no results.

So for now, if you want to test it on those distros you need to build it
yourself from source or use Fedora, RHEL or CentOS - where the repos works
perfectly fine.  In the mean time I will try to figure out how to fix this
Cloudflux mess.


A quick-start guide for OpenVPN 3 Linux can be found here:

    <https://community.openvpn.net/openvpn/wiki/OpenVPN3Linux>


The highlights of this release includes:

* Improvement: Brand new DNS resolver settings handling.  This is expected
  to avoid several bugs found in the prior releases; from not cleaning
  up correctly to adding duplicated entries for pushed DNS settings.

* Improvement: Refactored the code tied to setting up the direct route for
  the VPN server.

* Improvement: openvpn3-admin log-service --list-subscriptions now adds the
  PID of the process the log subscription is tied to.

* Bugfix: The openvpn3 Python module broke in v7_beta for Ubuntu 16.04 and
  other distributions shipping with Python 3.5 or older.  This has now been
  fixed but it will be required to install the aenum Python module via
  pip3.  This is not needed on distributions with Python 3.6 or newer.

* Bugfix: The openvpn2 interface would not work if the --verb option was
  missing.

* Bugfix: The D-Bus policy was incorrect for the net.openvpn.v3.netcfg
  service, related to the org.freedesktop.DBus.Ping method.

* Bugfix: Corrected a typo in Python constants related to DNS_SERVER_ADDED

* Bugfix: openvpn2 will now warn about ignoring --up and --down options,
  and will silently ignore --down-pre and --script-security.  These are not
  relevant or supported in OpenVPN 3 Linux. Prior versions did not work.

* Build: It now builds with GCC 10

* Build: It should be possible to build openvpn3-linux with no warnings on
  most platforms (gcc-4.8.5 requires -std=3Dc++1y)

* OpenVPN 3 Core: Upgraded to the latest development version, with lots of
  bugfixes and improvements.


[0] <https://gitlab.com/openvpn/openvpn3-linux>
    <https://github.com/OpenVPN/openvpn3-linux>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



---- Source tarballs ----------------------------------------------------
* OpenVPN 3 Linux v8 beta

  <https://swupdate.openvpn.net/community/releases/openvpn3-linux-8_beta.ta=
r.xz>
  <https://swupdate.openvpn.net/community/releases/openvpn3-linux-8_beta.ta=
r.xz.asc>

---- SHA256 Checksums ---------------------------------------------------

74d806d43ed803aece46748292783b17e33c85d6f116a9d0d6b26ebcdae2a557  openvpn3-=
linux-8_beta.tar.xz
2a39c897b3f0669ba47af63409b36545fbde32fc9cb5c9cd0146c65fd6d4a651  openvpn3-=
linux-8_beta.tar.xz.asc

---- git references -----------------------------------------------------
git tag: v8_beta
git commit: ee9ae86605b4985fac94e7c534a0012dc8958f67

---- Changes from v7 to v8 ----------------------------------------------

Arne Schwabe (14):
      contrib: Add cli-netcfg as a CMake build target
      netcfg: Move D-Bus logic returning fd in method call
      netcfg: Use C++ default copy constructor in NetCfgOptions
      Code style fixes
      ovpn3cli: Compile config command with USE_TUN_BUILDER
      netcfg: Declare ~NetCfgProxyException() as an override properly
      netcfg: Move device object creation into a separate method
      netcfg: Factor out notification signals in core-tunbuilder
      netcfg: Implement honouring remove_cmds in core tunbuilder
      contrib: Update CMake file to add missing files
      netcfg/client: Replace add_bypass_route with socket_protect
      netcfg/client: Cleanup tun devices and protected sockets on exit
      build: Update cmake files to include DNS related changes
      netcfg/client: Fix NetCfg::Cleanup() not called from openvpn-service-=
client

David Sommerseth (48):
      netcfg: NetCfgChangeEvent could incorrectly parse GVariant data
      client: Allow non-session manager access to log_level and device_path
      client: Provide more information on non-sessionmgr rejections
      client: Fix incorrect return in the Ready D-Bus method
      docs: Improve documentation
      dbus: Add missing glib2 include file in dbus/exceptions.hpp
      sessionmgr: Don't panic when device_path or device_name is unavailable
      common: Fix lookup functions returning uid/gid -1
      common/lookup: Update callers of lookup functions to handle exceptions
      core: Update to latest OpenVPN 3 Core library git master
      Replace empty destructors with default
      common/lookup: Add missing include file
      common/lookup: Fix memory leaks in lookup_{gid,uid}()
      build: Updating default C++ compiler flags
      contrib: Update Jenkins build slave tag
      python: Set a default verb level when --verb option is missing
      Update .gitignore
      policy: Fix incorrect org.freedesktop.DBus.Peer.Ping access on netcfg
      python: Fix incorrect NetCfgChangeType constant for DNS_SERVER_ADDED
      ovpn3cli/netcfg: Add presenting PID of subcribers in --list-subscribe=
rs
      python: Extend the IgnoreArg handler to issue warnings
      python: Add 4 script related options to the ignore list
      man: Add information about script execution in OpenVPN 3
      python: Extend ConfigParser to support embedding --auth-user-pass file
      netcfg: Make the NetCfgEvent const in NetCfgSignals::NetworkChange()
      netcfg/signals: Add support for providing device name with Debug logg=
ing
      netcfg: Add a new DNS settings framework
      netcfg: Implement new resolv.conf backend processor
      netcfg: Use the new DNS resolver settings framework
      netcfg: Do not apply DNS changes to backend with no registered changes
      netcfg: Explicitly restore the backup resolv.conf at exit
      netcfg: Add a mutex lock for changes to the resolv.conf file
      netcfg: Pass NetCfgSignals object to SettingsManager::ApplySettings()
      netcfg: Rework removal of DNS resolver settings
      netcfg/dns: Send NetworkChange signals on DNS resolver settings chang=
es
      build: Fix GCC 10 build issues - missing includes
      build: Fix GCC 10 build issues - uint*_fast_t
      contrib/jenkins: Run make distcheck with proper parallelism
      netcfg: Do not add duplicated DNS resolver settings
      netcfg/test: Fix memory leaks from GLibUtils::wrapInTuple()
      netcfg: Clear the memory buffered resolv.conf properly
      core: Update to latest OpenVPN 3 Core
      client: Don't provide statistics if vpnclient object is unavailable
      dbus: SetDBusError() does not change the exception object
      sessionmgr: Need to also tackle DBusException with CheckACL()
      build: Upgrade to Python 3.5 as the minimum version
      python/build: Add enum workaround for older Python versions
      core: Update to latest OpenVPN 3 Core

Lev Stipakov (1):
      contrib: add missing sources to CMake alternative

-------------------------------------------------------------------------


--KDkEfvg5L66yIxDuicjTMa0fvuBSEyBXE--

--UhryBbZBdjJ44PhzaBG1mM5jOsE2fSlfY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJeQdoVAAoJEIbPlEyWcf3yOr4QALIRoBA+XQ0O3MhP6IDpg4L1
GMOcoV1/sgpKis3QAS0PoOFTX9swoygRGaUD/JD55QV1w41Lhf1npc2jK9WFHLBe
2nxzY0/eDVr30XFurvSbV8I77E9pzZN244GNXy4srX/sAJ3vyGtjoFtBqST/inH0
sEI3I3FjVm5wt2XSJZv2DeopEsL9CmKToj9F/1bdMgh5J9LmOGDmazpRzozOzy3H
v+mxWWckCxKASkTKmSGjxtgHycbhpOeekZkRsPgNva2RLCWiiMCS7+VTR2U/rYtN
pIQDDZ1PNC5dmb8OFPaU5vOwxJFKiX3eHjqgyC6EdsVSKNnnpKWjLBFk3N5aWucx
g/baWmQFuAJkN8LGNXwp52daVecdBPKOSvMBOTHedmi98Hps5yS+nFARZW4sSYqr
IY8O70AS+n0cwncOd/4hzzjhcWPTK4Q+bxCG8quGopbOfxLIEu7OJp8Wyb2Y/lur
i2Ghetp1+NdeoAs58QkpLI5TKKeu4a+vMQDwcuqxZEMsF47NPGa4k7IY77XoIL5F
xxMcajmENub8uJK1v0kU9aYrU+qUcggapM+wte7oGAiPsuFHGAuwMy/hPh5SPMVW
6erObeEdoLWD8zC+9bwO591/NdUj6FYXxeKY66GNkUdqQ1D4eublOo7YgCBs5FXA
MSPPJWQ0Ta5rJXcBXIoP
=qyM6
-----END PGP SIGNATURE-----

--UhryBbZBdjJ44PhzaBG1mM5jOsE2fSlfY--

