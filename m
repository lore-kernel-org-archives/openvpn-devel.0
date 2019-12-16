From: David Sommerseth <openvpn@...2080...>
Message-ID: <aae70cff-44a2-ed18-f0f8-0bbcc9b0d4c8@...2080...>
Date: Mon, 16 Dec 2019 19:38:40 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="m37oOGIMoXJ2HRWDm7S7SPMlBQil8lq2q"
Subject: [Openvpn-devel] OpenVPN 3 Linux client - v7 beta released
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
--m37oOGIMoXJ2HRWDm7S7SPMlBQil8lq2q
Content-Type: multipart/mixed; boundary="glioxitWURQIHZ5iPsTZQWCAgYTfNMtzk";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>,
 OpenVPN Users <Openvpn-users@lists.sourceforge.net>
Message-ID: <aae70cff-44a2-ed18-f0f8-0bbcc9b0d4c8@...2080...>
Subject: OpenVPN 3 Linux client - v7 beta released

--glioxitWURQIHZ5iPsTZQWCAgYTfNMtzk
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

The OpenVPN 3 Linux v7 beta release has finally arrived, overdue for
several months.  This is available in our git repositories [0] and URLs for
source tarballs are listed later in this e-mail.  We have pre-built
binaries for the following Linux distributions:

    * Fedora 29, 30, 31 and Rawhide  (via Fedora Copr, x86_64 + ppc64le)
    * RHEL/CentOS 7 and 8            (via Fedora Copr, x86_64 + ppc64le)
    * Debian 9 and 10 (amd64)
    * Ubuntu 16.04, 18.04, 19.04 and 19.10 (amd64)

See the "Quick-start for OpenVPN 3 Linux" section later in this mail
for a pointer to documentation how to install this client.

The highlights of this release includes:

  # Support for --verify-x509-name
    The OpenVPN 3 Core library which this client builds on has been
    extended to support this option.  The openvpn2 command line front-end
    shipped in this client has been updated to also pass this option
    further.

  # New utility: openvpn3-as
    This new utility can import a configuration profile directly from an
    OpenVPN Access Server.  All which is needed is the URL to the Access
    Server and the user credentials.

  # The output of openvpn3 sessions-list has been improved
    The report this utility provides has been cleaned up a little and
    now also reports which tun interfaces and session names the Core
    library uses for each session.

  # Warning if compression is enabled on the tunnel
    The OpenVPN 3 log entries will now contain a warning line if
    compression has been enabled on the tunnel.  This goes further than to
    only check the local configuration file, but also consider what the
    server may push.  This means it will NOT give a compression warning
    if the local client configuration contains compression arguments but
    the server pushes compression settings disabling compression.

  # The openvpn3-admin version command now supports the --service argument
    which will query all the OpenVPN 3 D-Bus services and report the
    running version of each service.  This is useful for debugging and to
    see if the system is running the proper versions of all OpenVPN 3 Linux
    services.
=20=20=20=20
  # The openvpn3-admin log-service command has been extended with
    the --list-subscriptions argument.  This gives an admin (root user)
    more information about which D-Bus services has requested the logger
    service to attach/subscribe to log events.
=20=20=20=20
  # The OpenVPN 3 Python module has been extended with NetCfgManager
    This gives a limited set of methods useful for debugging and simpler
    management of the OpenVPN 3 Network Configuration service.=20

  # Error messages coming from the D-Bus infrastructure has been cleaned up
    and not really helpful and quite technical references has been removed.

  # D-Bus policy has been split up
    Earlier releases had all policies for all OpenVPN 3 Linux D-Bus
    services in a single file.  This making the policy management harder
    than needed and splitting it up into separate policy files per service
    made it simpler to understand the policies in use.

  # Fixed a bug causing D-Bus services to exit while have been in use.
    All the OpenVPN 3 Linux D-Bus services makes use of an idle-exit logic
    which ensures the service is shut down if it has not been used for some
    time.  Before this fix, the service could still exit if it had been
    used for a shorter time interval than the idle-exit timer.  This was
    incorrect and it will now also consider the time since the last
    interaction with the service and not just if some D-Bus objects are
    active and being managed by the service.

  # Several other bugfixes
    The stability has been improved a lot in several areas and error
    situations are handled more gracefully than before, either by trying
    a bit harder to complete the task at hand or to provide a bit more
    user friendly error messages.

OpenVPN 3 Linux is on track for prime-time production.  It will still come a
some more beta releases, to iron out last missing features and other
improvements.  But OpenVPN 3 Linux is essentially feature ready now.

If you are using OpenVPN 3 Linux, please report back if there are issues you
have or improvements you feel is important for the stable release.

* Quick-start for OpenVPN 3 Linux
See this community wiki page for information how to install and use
OpenVPN 3 Linux: <https://community.openvpn.net/openvpn/wiki/OpenVPN3Linux>


[0] <https://gitlab.com/openvpn/openvpn3-linux>
    <https://github.com/OpenVPN/openvpn3-linux>


---- Source tarballs ----------------------------------------------------
* OpenVPN 3 Linux v7 beta

  <https://swupdate.openvpn.net/community/releases/openvpn3-linux-7_beta.ta=
r.xz>
  <https://swupdate.openvpn.net/community/releases/openvpn3-linux-7_beta.ta=
r.xz.asc>

---- SHA 256 Checksums --------------------------------------------------
eadde1b2f2f593dd5020086b53901c42fc5a4562ba105f2add3e4e2c71767c7f  openvpn3-=
linux-7_beta.tar.xz
765e1f8072fd32226d3f249669c02bf7a9ef2623129bd51f0a64cd63bfaac508  openvpn3-=
linux-7_beta.tar.xz.asc

---- git references -----------------------------------------------------
git tag: v7_beta
git commit: 9478329ed017ba252b61b702d16a076b3adab678

---- Changes from v6 to v7 ----------------------------------------------
David Sommerseth (72):
      docs: Updated README file
      python: Give better information when starting background VPN sessions
      build: Ensure we really use the system liblz4 library
      docs: Update the pre-built section in README
      ovpn3cli: Fix misbehaving log --session-path
      core: Update to latest OpenVPN 3 Core Library
      tests: Adding unit-test framework
      tests: Port a few simple unit tests
      tests: Ported NetCfgChangeEvent unit test
      tests: Ported StatusEvent selftest to unit test
      tests: Ported LogEvent selftest to unit test
      common/cmdargparser: Slight minor improvements
      common: Make cmdargparser.hpp a separate compilation unit
      client: Tackle better if NetCfgProxy object is lost
      netcfg: Add version property to main service object
      netcfg: Make proxy-netcfg a separate compilation unit
      dbus/proxy: Ensure access denials exceptions are handled explicitly
      log: Don't throw access denied exception during init
      ovpn3cli/admin: Add --service argument to openvpn3-admin version
      tests: Make Jenkins run unit tests and collect results
      client: Expose session name via D-Bus
      sessionmgr: Expose session name
      ovpn3cli/session: Display session name
      python: Add OpenVPN 3 version to Python constants
      python: Add openvpn3-as - Access Server support utility
      python/openvpn3-as: Fix trailing slashes in URLs
      python/openvpn3-as: Extend with challenge/response auth support
      tests: Fix failing unittest with --enable-debug-core-events
      proxy: Add input validation on D-Bus paths
      client: Proxy warning from Core when compression has been enabled
      proxy: Provide method extracting proxy object path
      client: Provide methods retrieving netcfg device path and name
      client: Expose netcfg device path and name via D-Bus
      sessionmgr: Expose NetCfg device path and name for VPN sessions
      cli/session: Expose device name used by session in sessions-list
      session/proxy: Fix memory leaks in GetConnectionStats()
      sessionmgr: Add two new main manager methods
      sessionmgr/proxy: Add proxy methods for interface lookups
      ovpn3cli: Add argument helper for retrieving interface names
      ovpn3cli/session: Add --interface option to some session commands
      tests: Fix lookup unit-test with SUSE docker containers
      log/proxy: Fix -Wcatch-value compiler warnings
      core-ext: Replace hacky option string export
      client: Fix incorrect processing of port override
      netcfg: Fix inconsistent glib2 behaviour on Ubuntu
      sessionmgr: Handle missing backend gracefully for device_name
      tests: Add test program quering version property in services
      Fix incorrect spelling of 'retrieving'
      dbus/proxy: Strip "remote" part of GDBus errors
      core: Update to latest OpenVPN 3 Core library
      python: Add support for --verify-x509-name
      proxy: Don't throw access denials in GetServiceVersion()
      man: Update openvpn2
      proxy: Fix incorrect error in DBusProxy::GetServiceVersion()
      netcfg: Reorganize netcfg-changeevent.{cpp,hpp}
      policy: Split up the D-Bus policy per service
      proxy: Move the GDBus error message strip after AccessDenied check
      dbus: Ensure the D-Bus connection still valid
      sessionmgr/proxy: Verify session objects availability before calling =
it
      dbus/idlecheck: Consider last_operation when executing idle exit
      tests: Add simple connect/disconnect stress test
      dbus/signals: Add getter methods for interface and object path
      dbus/proxy: Ensure we have a valid D-Bus connection before proxy calls
      log: Add new admin method retrieving attached subscriptions
      log/proxy: Add C++ method for accessing GetSubscriberLog
      ovpn3cli/log-service: Add --list-subscriptions mode
      ovpn3cli/session: Minor overhaul of sessions-list
      sessionmgr: Grant access to the device_path in a session
      python/SessionManager: Add Introspection() and GetObjectPath() methods
      python: Add NetCfgChangeType constants
      python/NetCfgManager: New openvpn3 module for the netcfg service
      build: Clean up *~ files in a few forgotten places

-------------------------------------------------------------------------


--=20
kind regards,

David Sommerseth
OpenVPN Inc


--glioxitWURQIHZ5iPsTZQWCAgYTfNMtzk--

--m37oOGIMoXJ2HRWDm7S7SPMlBQil8lq2q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJd988xAAoJEIbPlEyWcf3yfQwP/jaoAdfZbbrJ7T4mELBi11Cx
yFrG4pMDabcqae3pZsyOFiyxi5RPkhTvarQjnU8z5QSlQD3gZg/BSda+vdq7GEt9
TK+uqheIKJwGGuz7yQNBQ1foX+MT99gnVoO1zEz1PK7wQxZfA6P3figAckPhHufi
gerOhgBeHokFmAzv2eUkBKWUIO8wIHk/O38uIagyBRkCZ/UlKm+FyRdUuAbmsanR
cwP1Jw0lU8V2g0PuZHF0B55M2l70y1hGEKFla31ygSHDy9qTXVfy9W2wOIimsGLe
XQw0O2aMr2Wtog4ZjeEcl40lLoKEJWwViM25yhZIZXertpR0PhQTw1J+b/r9eXsY
TyePME0tUUy1uEoH5pJ5U/2DcivjAwKKHRuFg1cJnjQD4Ru+DAWM1uvoGvqtnQfr
vOvv0ZxzcmvDlFdMUFsSzI4PtwF+NHMz05Ol749XCuokZUFRi1pUMayvN7WY0R3M
+ATnpkc4Fqm3eaPJszhjcTHUKmik6Rtwp4AlIGYqh3x1fstOpRyDegLNopGatl5U
AHt0IZvDDRLkRx/7XV5Pdtos/WO8QC98T8irYTgzqscpZsn8zzhd4H9hTVACR4BW
ihy3jA5XtJcu0X28RwwPX1uiL3bVnAAsmzScrBtI/piQbgNu47VCQXD4CbiGZSuf
0iSYED2c7CMLkUshJQMq
=hQ8X
-----END PGP SIGNATURE-----

--m37oOGIMoXJ2HRWDm7S7SPMlBQil8lq2q--

