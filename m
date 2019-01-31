From: David Sommerseth <openvpn@...2080...>
Message-ID: <c7b39839-b27a-e98b-e5b7-051c2fca7f1f@...2080...>
Date: Thu, 31 Jan 2019 23:21:00 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="oug6xuen5crhQ7zs2PtRaKomELqqPqnFw"
Subject: [Openvpn-devel] OpenVPN 3 Linux client - v2/v3 beta released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>, openvpn-users <openvpn-users@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oug6xuen5crhQ7zs2PtRaKomELqqPqnFw
Content-Type: multipart/mixed; boundary="Q9XTZ183WoEtjhdU0WiMPJvdImqaTPQYz";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 openvpn-users <openvpn-users@lists.sourceforge.net>
Message-ID: <c7b39839-b27a-e98b-e5b7-051c2fca7f1f@...2080...>
Subject: OpenVPN 3 Linux client - v2/v3 beta released

--Q9XTZ183WoEtjhdU0WiMPJvdImqaTPQYz
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hi,

We have released the OpenVPN 3 Linux v3 (and v2) beta.  This is available in
our git repositories [0] and URLs for source tarballs are listed later in t=
his
e-mail.  RPM binaries for Fedora and RHEL/CentOS/Scientific Linux [1] compl=
eted
the build process quite recently too.  Debian and Ubuntu packages will
hopefully come in not too far future as well.

This release contains mostly minor bug fixes and enhancements to the command
line user interface.  And we now have man pages for all parts of the OpenVP=
N 3
Linux client.

One bigger new feature we have added is extending the OpenVPN 3 service,
which manages the TUN interfaces, IP address and routing configuration and
DNS configuration, to enable third-party applications to subscribe to
notifications whenever there are changes in regards to VPN tunnels.  These
notifications contains information about which TUN interface was created or
removed plus IP addresses, routes and DNS settings.  The default policy
enforces this service to run under the `openvpn` user account, but this can
easily be modified at runtime.  There is a fairly rough example Python
script [2] available as well as the documentation has been updated [3].
In a coming release, the openvpn3 Python module will be updated to give an
easier interface.


* Quick-start with OpenVPN 3 Linux once it has been installed

  $ openvpn2 --config my-vpn-config.conf --verb 6

This will start a VPN configuration profile with the most verbose logging. =
 If
the configuration does not contain --daemon, all logging will also be prese=
nt
in the console and the tunnel will be torn down with a simple CTRL-C.
Otherwise the VPN session will be running in the background and you get your
command prompt back again, and you need to manage this session using
`openvpn3 session-manage --config my-vpn-config.conf`

For more information see the various man-pages available [4].


Now if you wonder why we're releasing both v2 and v3 at the same time ...  A
bit too late we discovered an ugly bug in v2 which broke the log event
printing in the openvpn2 front-end.  This was after cloudflare had cached o=
ur
v2 release tarballs.  So to avoid confusion and frustration, we're pushing
out v3 now.


* Install Fedora Copr packages for Fedora, RHEL, CentOS and Scientific Linux

Ensure you have the yum-plugin-copr or dnf copr plugin installed.  For
RHEL/CentOS/Scientific Linux you will also need to have the Fedora EPEL
repository enabled [5].  Then run the following commands:

For yum users:

   $ yum copr enable dsommers/openvpn3
   $ yum install openvpn3-client

or for dnf users:

   $ dnf copr enable dsommers/openvpn3
   $ dnf install openvpn3-client



[0] <https://gitlab.com/openvpn/openvpn3-linux>
    <https://github.com/OpenVPN/openvpn3-linux>

[1] <https://copr.fedorainfracloud.org/coprs/dsommers/openvpn3/>

[2] <https://github.com/OpenVPN/openvpn3-linux/blob/master/src/tests/dbus/n=
etcfg-subscription-test>

[3] <https://github.com/OpenVPN/openvpn3-linux/blob/master/docs/dbus/dbus-s=
ervice-net.openvpn.v3.netcfg.md#method-netopenvpnv3netcfgnotificationsubscr=
ibe>
    <https://github.com/OpenVPN/openvpn3-linux/blob/master/docs/dbus/dbus-s=
ervice-net.openvpn.v3.netcfg.md#method-netopenvpnv3netcfgnotificationunubsc=
ribe>=20
[4] <https://github.com/OpenVPN/openvpn3-linux/tree/master/docs/man/>
[5] <https://fedoraproject.org/wiki/EPEL>



---- Source tarballs ----------------------------------------------------
* OpenVPN 3 Linux v3 beta
  <http://swupdate.openvpn.net/community/releases/openvpn3-linux-3_beta.tar=
.xz>
  <http://swupdate.openvpn.net/community/releases/openvpn3-linux-3_beta.tar=
.xz.asc>

* OpenVPN 3 Linux v2 beta (only listed for consistency)
  <http://swupdate.openvpn.net/community/releases/openvpn3-linux-2_beta.tar=
.xz>
  <http://swupdate.openvpn.net/community/releases/openvpn3-linux-2_beta.tar=
.xz.asc>

---- SHA 256 Checksums --------------------------------------------------
5d245a8ab79e9ad74ea3880b30890b44ac6ae600775747cb9860282992fcb06c  openvpn3-=
linux-3_beta.tar.xz
0c1baba2cf1924857ccf2d834a38106419515c4d45284a71b310d120a57258bf  openvpn3-=
linux-3_beta.tar.xz.asc
260820538bec38c790c7ffa7a86f045e33ffb300819e912d4df4d01db2ff3fab  openvpn3-=
linux-2_beta.tar.xz
b0a1659998bdfb8a5f7bf904be6abe5ec7ac21fcd16872298b9c2f8aaccd2453  openvpn3-=
linux-2_beta.tar.xz.asc
-------------------------------------------------------------------------

---- Changes from v2 to v3 ----------------------------------------------
David Sommerseth (5):
      log: Make LogSender::ProxyLog() use LogEvent objects directly
      sessionmgr: Make SessionLogEvent::GetLastLogEntry() reuse code
      sessionmgr: Don't preseve the session token
      sessionmgr/log: Allow sessionmgr to intercept and manipulate proxied =
LogEvents
      ovpn3cli: Make the version command use the argv[0]

Lev Stipakov (1):
      log: Add log group for external log event senders

---- Changes from v1 to v2 ----------------------------------------------
Arne Schwabe (1):
      tests: Add clinetcfg - simple test client using netcfg

David Sommerseth (80):
      core: Rebase to latest upstream openvpn3 core library
      configmgr: Add LookupConfigName method
      configmgr/proxy: Implement C++ interface for LookupConfigName()
      cli/session: Allow session-start --config to use profile names
      python: Add support for changing profile names in autoloader
      shell: Extend auto-completion for openvpn3 session-start --config
      shell: Improve auto-completion with subdirs
      build: Fix 'make distcheck' again, clinetcfg needs config-version.h
      shell: Fix mixed whitespace
      sessionmgr: Implement LookupConfigName() method
      sessionmgr/proxy: Implement LookupConfigName() for sessions
      ovpn3cli: Extend session commands with --config
      shell: Improve --config completion further
      docs: Add man pages for openvpn3 config* commands
      configmgr: Remove support for 'insecure' tls-cert-profile
      docs: Add man pages for openvpn3 session* commands
      docs: Add man pages related to logging
      docs: Add missing man page sections to SEE ALSO segments
      docs: Add man pages for the missing openvpn3-service-* services
      docs: Add a generic openvpn3-linux.7 man page
      Add missing test programs to .gitignore
      netcfg: Add str() method to class Network
      netcfg: Extend NetCfgDevice with methods setting/getting device name
      netcfg: Fix incorect const flags for sending StateChange signals
      dbus/signals: Declare Send() methods const
      netcfg: Save the real tun interface name
      netcfg: Send signals on changes
      netcfg: Rename NetCfgStateEvent to NetCfgChangeEvent
      netcfg: Implement GVariant parsing of NetworkChange events
      netcfg: Add operator=3D=3D methods in NetCfgChangeEvent
      netcfg: Extend NetCfgChangeEvent unit test
      netcfg: Implement NetCfgChangeEvent for excluded routes
      netcfg: Implement NetCfgChangeEvent for DNS changes
      netcfg: The main netcfg manager object do not send NetworkChange sign=
als
      netcfg: Make NetCfgChangeType bit oriented
      netcfg: Extend output possibilities in NetCfgChangeEvent::TypeStr()
      netcfg: Extend NetCfgEvent with FilterMaskList()
      netcfg: Extend NetCfgChangeEvent with FilterMaskStr()
      dbus/signal: Extend DBusSignalProducer::Send() to support std::vector
      dbus/signal: Extend DBusSignalProducer with new protected methods
      netcfg: Move signal_broadcast option into NetCfgOptions
      netcfg: Implement basic subscription management for signals
      netcfg: Implement support for subscriptions in NetCfgSignals
      netcfg: Implement NetworkChange subscription management
      docs: Extend documentation to cover netcfg NetworkChange subscription=
 methods
      docs: Fix lots of typing errors in netcfg interface references
      dbus: Fix some minor disorganized errors in the policy
      client/dbus: Tighten D-Bus policy for net.openvpn.v3.be* services
      log/dbus: Make the main LogSender::Log() method virtual
      client: Add session token to all Log events
      netcfg: Remove netcfg's own PID from from network device paths
      client: Use more unique device name than 'o3tun'
      netcfg: Add empty objects constructors on VPNAddress and Network clas=
ses
      netcfg: Extend NetworkChange signals with more structured details
      netcfg: Merge IPv4 and IPv6 NetCfgChangeType flags
      docs: Update the netcfg D-Bus service documentation
      openvpn3: Revamp the code preparing the available commands
      configmgr: Make overrides.hpp an independent compile unit
      ovpn3cli: Make arghelpers.hpp an independent compile unit
      openvpn3: Split up commands into independent compilation units
      openvpn3: Move the 'version' command to its own commands file
      ovpn3cli: Generalize the command line program implementation
      ovpn3cli: Split out log-service from log.cpp
      openvpn3: Move the log-service command over to openvpn3-admin
      openvpn3-admin: Add netcfg-service command
      man: Move user commands to man section 1
      build: Ensure config-version.h is built early
      shell: Extend bash auto-completion to support openvpn3-admin
      openvpn3: Improve config-import --help
      openvpn3-core: Update to latest upstream master
      docs: Correct missing change in dbus-service-net.openvpn.v3.client.md
      log: Make LogEvent::Parse() private
      log: Extend LogEvent to be more self-contained
      log: Make use of LogEvent parsing capabilities
      log: Extend LogEvent to support session-tokens
      log: Allow LogSender::GetLogIntrospection() to be overridden
      client: Extend Log signal from backend client with session token
      log: Log session token information as meta-data if present
      docs: Update README.md
      docs: Remove TODO.md

Lev Stipakov (11):
      Refactor request-queue tests
      requiresqueue.hpp: change instance method to static
      Replace throw() with noexcept
      Fix incorrect return statement
      Fix undefined behavior in method return
      netcfg/proxy: Implement proxy interface for subscription management A=
PI
      netcfg: Enable using NetCfgChangeType as bit flags
      dbus: enable introspection for netcfg
      cosmetics: Fix usage of uni/multi-cast terminology
      contrib: Add experimental CMake support for IDEs
      build: Fix the incorrect value of systemd_unitdir
-------------------------------------------------------------------------


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--Q9XTZ183WoEtjhdU0WiMPJvdImqaTPQYz--

--oug6xuen5crhQ7zs2PtRaKomELqqPqnFw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJcU3TTAAoJEIbPlEyWcf3yGGQQAIfDJh0wYUGAPQt0AxGtktNF
kqM7Fk9sd7hiq+sgXhBvSv84s4PGbxKy2UAfe3Lnq/2n2DlNb8KpHWYgKbq3kZ1u
ZFV6cT+jjkORqoUBZi5DrumOK/QOGtDJVGZ2n6Fr81sLByUmu7I2EtNHGL5Da5en
/h0PahWiVXNoM3+8XGr5QSUDFl8Rmliyk6ywzyRwWIttcswavhlhP0TyxcsvAtT/
de3IFwVW8KQHscTntGlNwKT7QoqJIAHHiydUtV2iXKHvTIJypjPpcI3q8IpJS9Ja
wfxQHPDrIGqvtcN2/oCbuROiUeg5FFvti4BqHhDE0W5BICb6ongJD++sRdayJSBg
Ei+miFstUvwb2k4DAcFFUrUIJQ5PB5ap9dyoHYIiU1cq9RB6GmujaQwCx8YCDOEG
/sd2tuW5trXfgSaYYoZFLOmbsXzzPwIfZToOm6bXept5tc07pL19PRCrvR/oa6Yz
wUzwkt6bDxnH3COY8kr3IpC8xp2wVVTK0Bs0mHy6W7W73liPsGI9PQ5+ELPSwso7
8Lq8YyYLNeqLreBsAaZS/lUcsp8nZ8eMPOLLxsObhvpeIC9Zt8hnlpq0TYsbmyTV
dla2BsriHircFFIDmxlV0PwocTTcZI7q87bh2RtLlX/FRnUkZgrloU7A5tiWKq7J
W7DlyljSDHmoB4qopDUM
=CcIP
-----END PGP SIGNATURE-----

--oug6xuen5crhQ7zs2PtRaKomELqqPqnFw--

