Message-ID: <76d9c751-a58f-4171-9fb3-361cc2159c5b@...2108...>
Date: Tue, 20 May 2025 09:19:18 +0200
MIME-Version: 1.0
From: David Sommerseth <dazo+openvpn@...2108...>
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------3BbrsF3EZWSB8lLziGWoxQOA"
Subject: [Openvpn-devel] OpenVPN 3 Linux v24.1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <Openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------3BbrsF3EZWSB8lLziGWoxQOA
Content-Type: multipart/mixed; boundary="------------H0Ds0u9OVxSNtWM5ksZe296z";
 protected-headers="v1"
From: David Sommerseth <dazo+openvpn@...2108...>
To: openvpn-devel <Openvpn-devel@lists.sourceforge.net>,
 "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>
Message-ID: <76d9c751-a58f-4171-9fb3-361cc2159c5b@...2108...>
Subject: OpenVPN 3 Linux v24.1 released

--------------H0Ds0u9OVxSNtWM5ksZe296z
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

OpenVPN 3 Linux v24 (Bugfix/security release)

The v24.1 release is a small security and bugfix release.

* Security: CVE-2025-3908 - openvpn3-admin init-config follows symlink
  Wolfgang Frisch from the SUSE security team reach out and
  notified us of a potential issue with the openvpn3-admin init-config
  command following symlinks when creating needed directories.  This
  has been resolved and this command will no longer follow symlinks
  and will insist the user running this command to setup these
  directories manually with the correct ownership and privileges.

* Bugfix: openvpn3 session-manage --log-level can crash the Session Manager
  When changing the log-level for an on-going VPN session to an invalid
  log-level value, the Session Manager process would fail and stop
  running due to an uncaught exception.  The result would not affect
  the currently on-going VPN sessions, but none of those sessions could
  be managed via the session manager any more.  This has been fixed and
  the Session Manager will now reply to the caller with an error message
  instead.  This issue was reported by Wolfgang Frisch from the SUSE
  security team.

* Bugfix: Control character injection via command line arguments
  All the command line arguments would pass on ASCII control characters
  which could be used to inject misleading information into logs.  Since
  none of the entry points of user data need ASCII control characters
  except newline characters a few places, these characters are now
  removed.  This issue was reported by Wolfgang Frisch from the SUSE
  security team.

* Bugfix: openvpn3-service-backendstart crash during shutdown
  Occasionally the openvpn3-service-backendstart helper service could
  crash during it's shutdown phase.  This was due to an uncaught
  exception.  This has been resolved.

* Bugfix: VPN session failing to start without org.freedesktop.hostname1
  The current client code expected the org.freedesktop.hostname1
  (systemd-hostnamed) service to be available.  On systems without
  systemd, this would result in the client using a longer time to wait
  for this service to appear before continuing.  Meanwhile, the Session
  Manager would also not receive a response in time from this client
  process, thus considering it unresponsive and stopping the VPN session
  instead.  This has been resolved by querying the master D-Bus service
  if the org.freedesktop.hostname1 service is available or not and just
  continue without it, if it is unavailable.

* Build fix: Meson clean-up
  Newer Meson versions had several minor complaints about the build
  configuration.  These issues should now be resolved and Meson should
  no longer report any warnings.

* Build fix: GCC-15 related build issues
  The GCC-15 compiler now starts to complain about more issues which was
  not raised by prior compiler versions with the same compiler flags.
  Issues raised by GCC-15 are now fixed.


Known issues:

  - openvpn3-admin journal --since has a time zone related issue
    and may not list all log events within the closest hours.


Credits
-------
Wolfgang Frisch from the SUSE security team for their bug
and security reports.


Supported Linux distributions
-----------------------------

  - Debian: 12
  - Fedora: 40, 41, 42, Rawhide
  - Red Hat Enterprise Linux 8, 9
  - Ubuntu: 22.04, 24.04

Red Hat Enterprise Linux 10 is in tech preview.

Installation and getting started instructions can be found here:

  <https://community.openvpn.net/openvpn/wiki/OpenVPN3Linux>


--
kind regards,

David Sommerseth
OpenVPN Inc


---- Source tarballs ---------------------------------------------------
* OpenVPN 3 Linux v24.1

  <https://swupdate.openvpn.net/community/releases/openvpn3-linux-24.1.tar.=
xz>
  <https://swupdate.openvpn.net/community/releases/openvpn3-linux-24.1.tar.=
xz.asc>

---- SHA256 Checksums --------------------------------------------------

7a85a6247f481a4eb998b79721a7ae87c27f43fea54d09d7cafc86c59cc94ded  openvpn3-=
linux-24.1.tar.xz.asc
c0e5db2cea4e9f2118b81425d3833b85821c515b72a53e21479c7a1f24d4bef0  openvpn3-=
linux-24.1.tar.xz

---- git references ----------------------------------------------------

git repositories:

 - OpenVPN 3 Linux
   <https://codeberg.org/OpenVPN/openvpn3-linux> (PRIMARY)
   <https://gitlab.com/openvpn/openvpn3-linux>   (code-only mirror)
   <https://github.com/OpenVPN/openvpn3-linux>   (code-only mirror)

   git tag: v24.1
   git commit: 8bba2a15088bd0ef9c2f18ff29186e890a010add

---- Changes from v24 to v24.1 --------------------------------------

David Sommerseth (31):
      build: Misc cleanup in Meson build scripts
      build: Fix incorrect default value assignment for create_statedir opt=
ion
      common: Refactor Configuration::File to use std::filesystem
      ovpn3cli/init-config: Refactor file/directory handling to use std::fi=
lesystem
      ovpn3cli/init-config: Don't follow symlinks setting up state/configs =
dirs
      sessionmgr: Catch incorrect log level requests in Session object
      build: Fix minor meson complaint in addons/aws
      build: Improve OpenVPN 3 Core library version extraction
      events/log: Refactor Events::Log()
      events/log: Simplify Events::Log::str() methods
      events/log: Implement character filter in Events::Log
      log: Extend LogSender with a Debug_wnl() method
      log/core: Enable multi-line logging via the Core D-Bus logger
      log/journal: Don't filter newlines from journald entries
      log: Preserve the newlines in the log when openvpn3-service-log starts
      tests: Add --allow-newline to logservice1 send subcommand
      common/cmdargparser: Minor code cleanup in RegisterParsedArgs::regist=
er_option()
      common/cmdargparser: Filter out ASCII control characters from command=
 line
      common: Merge and move string ctrl char sanitizing to a shared functi=
on
      log: Filter strings coming via D-Bus calls
      sessionmgr/client: Filter reason string to Pause D-Bus method call
      common: Filter input value to RequiresQueue::UpdateEntry()
      tests/request-queue: Remove unused local function
      configmgr/test: Add tests for control chars in various configuration =
profiles
      configmgr: Remove control characters from various user input via D-Bus
      netcfg: Remove control characters from the D-Bus method inputs
      log: Add missing cstdint header in logmetadata.hpp
      common: Check if org.freedesktop.hostname1 is available in PlatformIn=
fo
      client: Handle exceptions in ~BackendStarterSrv
      build: Allow version tags to contain dots and minor version digits
      configmgr/proxy: Ignore minor version number in feature check

--------------------------------------------------------------------


--------------H0Ds0u9OVxSNtWM5ksZe296z--

--------------3BbrsF3EZWSB8lLziGWoxQOA
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmgsLPYACgkQhs+UTJZx
/fIE3xAArbESjnBYNDSGJiAWIqsYE5Z+ORzLZQfNK40PMXPv1rp/4o7XY1jHRPss
aAfyLOx87Q6HVHZwdMpXRP1EM183VXPKsDosh+A5k2F6F8qqwRsfidakyJlWTYr6
gLhIsP8YFfrQrcxCAN8niGPDGOcPwu7GyjWNIFaxcCa+fGY6b2SSVAo43VmroS9a
+uVBXFHrC3motsnxIhkAerxngkp/p1dOJrAAusG7MQhgtrBtiC0979diovFFvU/z
1E/Mbwv2dJfFlmahVJffqlXMglg4URra8Rg5l9kDadt/HPVxmEDonvFmljnlERmB
yAmT5mw6pGxVk03TRjfwJvgpslXpbglXh4sKv8uHAsXZrwJykBYNHdN5Pdcrfknu
YwcrFPwaoFjPlHYglG095hG8khsLupg1Dm4A5SxfA0/gk8+GwcvybAyf2Be9i0rZ
HQEUhDlC912B3ybCmIeJKFKLpaz+b0R36tdhMyC6NIknKnEtIZwwg4tnqnSjgLr7
RZD/jjRHIzsP+52XtbonCEci10Q4A7Iuv4Y4ormr+kO6R2C0rV5bqqaYU7y8gnuP
+5YkPRcQKUYyuViaQ5DjL24yy1H6s6C60Ig0dg8TOUndufxmjV66yfIyRt6f9qLT
jRmL+UV1IS+EQrij9zGeoCoc1rQGvtfshcUKI4eKU8g4wVtXzVQ=
=KcSE
-----END PGP SIGNATURE-----

--------------3BbrsF3EZWSB8lLziGWoxQOA--

