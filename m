From: David Sommerseth <openvpn@...2080...>
Message-ID: <544b892e-81ea-3105-b1ef-c75522230454@...2080...>
Date: Mon, 27 Jul 2020 12:51:02 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="dfEiRYlqpLMx5pl6kAd3VrrA5j3pEWzgc"
Subject: [Openvpn-devel] OpenVPN 3 Linux client - v10 beta released
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
--dfEiRYlqpLMx5pl6kAd3VrrA5j3pEWzgc
Content-Type: multipart/mixed; boundary="gnzBCwlqar5VHSAdrsuMf68s3vbSYQK01";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 openvpn-users <openvpn-users@lists.sourceforge.net>
Message-ID: <544b892e-81ea-3105-b1ef-c75522230454@...2080...>
Subject: OpenVPN 3 Linux client - v10 beta released

--gnzBCwlqar5VHSAdrsuMf68s3vbSYQK01
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hi,

The OpenVPN 3 Linux v10 beta is now released.

This is available in our git repositories [0] and URLs for source tarballs
are listed later in this e-mail.  We have pre-built binaries for the
following Linux distributions:

    * Fedora 31 and 32         (via Fedora Copr: x86_64, aarch64)
    * RHEL/CentOS 7 and 8      (via Fedora Copr: x86_64, aarch64)
    * Debian 9 and 10 (amd64)
    * Ubuntu 16.04, 18.04, 19.10 and 20.04 (amd64)

A quick-start guide for OpenVPN 3 Linux can be found here:

    <https://community.openvpn.net/openvpn/wiki/OpenVPN3Linux>


The highlights of this release includes:

* Feature: systemd-resolved integration

  By default, OpenVPN 3 Linux will modify the /etc/resolv.conf file
  with DNS configurations pushed by the VPN server.  This release
  adds systemd-resolved as an alternative to this approach, where
  the systemd-resolved service will be in charge of querying the
  proper DNS resolvers and there will no longer be any fight over
  configuration files such as /etc/resolv.conf.

  In this release, pushed DNS configurations will be handled quite
  similar to how DNS queries has been handled before.  The DNS settings
  pushed by the VPN server will typically take precedence, but
  systemd-resolved may query other servers on other interfaces as well.
  That said, if the VPN server pushes "dhcp-options DOMAIN ....", hosts
  under that domain will in this case only be queried via the VPN tunnel
  alone.  You may call this a partial DNS-split.

  In coming releases, we will evaluate further possibilities to configure
  how DNS requests would be handled by systemd-resolved.  This could
  include modes such as full split (only query for pushed DOMAIN via the
  DNS server provided by the VPN) or exclusive VPN (DNS queries should
  only go via the VPN tunnel).

  This systemd-resolved integration requires at least CentOS 8,
  Fedora 31, 32 or Rawhide, Red Hat Enterprise 8 or Ubuntu 20.04.  Other
  distributions may work as long as it uses systemd v243 or newer.

  To enable systemd-resolved, fully ensure that systemd-resolved is
  properly configured and activated on your system.  Currently only
  Ubuntu 20.04 does that somewhat out-of-the-box (there might be some
  additional changes to nsswitch.conf is required for optimal
  performance).  Please read the available systemd-resolved
  documentation for your Linux distribution.

  Once systemd-resolved is enabled and activated, run this command
  as root before starting any VPN tunnels:

     # openvpn3-admin netcfg-service --config-set systemd-resolved 1

  and wait until the openvpn3-service-netcfg has restarted.  With
  the log-level set to 5 or higher in netcfg-service, the log file will
  include this log line:

      Network Configuration VERB2: systemd-resolved DNS configuration backe=
nd

* Feature: openvpn3 log with --config will now wait for a not-started sessi=
on

  When starting the end-user session logging, prior versions required the
  VPN session to already be running before a log client could be attached.

  With this release, if the session has not already been started, the
  openvpn3 log command will wait until it sees the appropriate VPN session
  has started and will attach to it instantly.  This allows to grab the
  first log lines of a starting VPN sessions for an end-user without
  other ways of accessing OpenVPN logs.

* Improvement: openvpn3-as indicates tls-crypt-v2 support to AS

  When downloading a VPN configuration profile from an OpenVPN Access
  Server, the openvpn3-as script will now signal to the server it is
  capable of handling configurations with --tls-crypt-v2.


* Bugfix: AWS integration failed to propagate routes in some AWS regions

  The openvpn3-service-aws process could in some AWS regions fail to push
  routes to the AWS-VPC, leading to a process crash.  Both the crash and
  the AWS service has been extended with more region CA certificates used
  for the request validations.  In addition it will now pick up more of
  system CA certificate file locations than before.


--=20
kind regards,

David Sommerseth
OpenVPN Inc


[0] <https://gitlab.com/openvpn/openvpn3-linux>
    <https://github.com/OpenVPN/openvpn3-linux>


---- Source tarballs ----------------------------------------------------
* OpenVPN 3 Linux v10 beta

  <https://swupdate.openvpn.net/community/releases/openvpn3-linux-10_beta.t=
ar.xz>
  <https://swupdate.openvpn.net/community/releases/openvpn3-linux-10_beta.t=
ar.xz.asc>

---- SHA256 Checksums ---------------------------------------------------

6fb565d2ec19331ee3203d027d90598e51dec3cb31888be25d15e1c9911dbcd1  openvpn3-=
linux-10_beta.tar.xz
bc95ac62700e0924b43d7846a3ca7601d1ac2ef3efeb32f2f01d48d3b11d32f0  openvpn3-=
linux-10_beta.tar.xz.asc

---- git references -----------------------------------------------------

git tag: v10_beta
git commit: ff27a9f83b29448797e72ce9f92abc498647202a

---- Changes from v9 to v10----------------------------------------------

Arne Schwabe (5):
      Announce tls-crypt-v2 support on AS configuration import
      Compile fix for ILP32 platforms like Raspberry Pi
      contrib/cmake: Remove extra ${OPENVPN3_LINUX_ROOT} from source files
      contrib/cmake: Make CMakeLists.txt work with config.h from configure
      contrib: Improve Jenkinsfile with stage and archiving test-suite.log

David Sommerseth (82):
      vendor: Update ASIO to 1.16.0
      core: Update to latest core git master
      cli/session: Fix incorrect command reference in throws
      sessionmgr/proxy: Add TunInterfaceException
      cli/session: Properly catch DBusException
      log: Remove trailing newlines in LogEvents
      ovpn3cli/log: Indent multiline log lines
      ovpn3cli/log: Add --interface option
      sessionmgr: Fix crash with incorrect log level
      sessionmgr: Add SessionManager::Event class
      sessionmgr: Implement sending SessionManagerEvent signals
      ovpn3cli/log: Improve the complete session log setup logic
      client: Fix failing --log-file feature
      docs: Add missing dependency in Debian/Ubuntu instructions
      netcfg: Avoid segfault when configured without --resolv-conf
      client: New debug option in openvpn3-service-backendstart
      common/build: Rework version information handling
      build: Clean up after version metadata rework
      build: Fix 'make install'
      dbus: Clarify a few StatusMinor states in the comment
      client: Process CLIENT_HALT event
      build: Fix 'make uninstall' for the SELinux policy
      client: Fix incorrect environment array handling
      netcfg: Fix a typo in the AddNameServers exceptions
      netcfgmgr/dns: Add indication when to apply DNS settings
      netcfgmgr/dns: Extend ResolverSettings object store tun device name
      netcfgmgr/dns: Apply resolver settings according to the backend
      dbus/glib: Extend checkParams() to optionally ignore children count
      dbus/proxy: Migrate to better value extraction in GetProperty() and C=
heckServiceAvail()
      policy: Added polkit policy for systemd-resolved interaction
      netcfg: Add proxy code for systemd-resolved
      netcfg: Add ResolverBackendInterface implementation for systemd-resol=
ved
      netcfg: Complete the systemd-resolved support
      netcfg: systemd-resolved - Make all global queries also go via VPN
      policy: Add support for legacy polkit PKLA files
      man: Minor cleanups and improvements
      common/cmdargparser: Refactor ParsedArgs passing to be a smart pointer
      common/ParsedArgs: New methods to retrieve the last set option values
      common: Extend ParsedArgs with CheckExclusiveOptions() method
      common: Extend command parser with ParsedArgsConfig class
      man: Make template out of a few of the man pages
      netcfg: Extend service with --state-dir
      common: Extend ParsedArgs::Present() with a std::vector variant
      common: Move command line parsing related exception
      common: Implement a simple and generic JSON config parser
      common: Extend ParsedArgs with a simpler config file parser approach
      netcfg: Implement the new config file parser
      common: Remove the no longer used ParsedArgsConfig implementation
      netcfg: Extend manager object with a config_file property
      cli/netcfg-service: Extend with --config-show, --config-set and --con=
fig-unset
      netcfg: Fix incorrect default log-level
      cli/netcfg: Add --config-file-override to netcfg-service
      cli/netcfg: Make netcfg-service command more robust
      common: Extend Configuration::File parser with option groups
      cli/netcfg: Extend netcfg-service with CheckExclusiveOptions() check
      common: Extend Configuration::File with GetRelatedExclusiveOptions()
      common: Extend ParsedArgs::ImportConfigFile() with exclusive check
      netcfg: Allow configuration file to override command line arguments
      python: Add support for --tls-cipher
      cli/log: Extend shell auto-completion with --config
      cli/log: Fix typ0 in AttachByConfig() method name
      deps: Update ASIO to 1.17.0
      deps: Update OpenVPN 3 Core library to latest git master
      Update .gitignore - it was missing openvpn3.pp.bz2
      dbus: Add a couple of missing header files
      cli: Handle DBusProxyAccessDeniedException events better
      netcfg/resolved: Better exception handling when communicating with sy=
stemd-resolved
      python/shell: Add bash-completion for openvpn2
      build: Enable installing bash-completion scripts
      docs: Update README.md with missing googletest mention
      common: Fix Configuration::File::Save() not writing empty files
      build/aws: Simplify the autotools setup for addons/aws
      build: Fix missing uninstall of bash-completion scripts
      build/aws: Fix failing out-of-tree builds
      build/aws: Fix incorrect distribution of D-Bus policy and systemd uni=
t files
      contrib/CI: Enable the AWS addon in Jenkins builds
      common: Configuration::File::Load() should accept empty files
      netcfg/resolved: Revert tun interface DNS settings on removal
      core: Update to latest OpenVPN 3 Core library
      cli/admin: netcfg-service could exit with an empty error
      build: Update versioning script to account for double digit versions
      docs: Update README.md

Lev Stipakov (5):
      client: properly handle client termination
      contrib: Add missing files in CMakelists.txt
      addons/aws: Improve error handling
      addons/aws: AWS certificates to verify instance identity
      addons/aws: provide AWS certs directory to core library

-------------------------------------------------------------------------



--gnzBCwlqar5VHSAdrsuMf68s3vbSYQK01--

--dfEiRYlqpLMx5pl6kAd3VrrA5j3pEWzgc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfHrGXAAoJEIbPlEyWcf3yt74P/A1v7MTLp8Dow5WwwAQv8nno
u7OQ+JZf2kFCDzAQ/EO00L9t0Qng34PST6mPOPPqBmPka260cLHWMGQWyyh0Ezx9
/G9VlxKx2EAfa6fBXJnHxVbwyhVl9PjvEFz+KcFFW15tXcWU9uB5CaRlgT4cci5o
JEvDK3jfUHcv8Zn9tCMXJYbVSgkN/dLwq9DByrROUz5HcrFiY921bMF+3gX0YDBl
lMlQoqLsZvd+vr6zEtNz2DgJVfmxevxwageQ3facmFmGptR6fidZl1MRuXSS5Xp2
KFsF3kdtRkZm6AAAeZkHje3a+qTOYg2x4rcyW/LLRpu7moh80Q6WOpoY4QU0F35L
3tZev1l08wiHgF4YHenybScXRje5CEjVvX/g/SoTSmn7Li0QXwQbjDgpjRYbdnLl
9UKj3ig/OvHeJ0QCjn/EajcqkemjKkOt9O2qX5ws53mn5iTYXiR/6uzy57J/sdNg
QWK9Ga4K6HMfTMHSGxIJl3O8bVNLPRgcmNamAoHDwllJF4mrTF03Q84h2wI3iHuc
yzYqEH66qJJGlNggHN5KvlFE8D00HL3CO2vKyFkURMf+s9p95Z+iUIrfLipTpaS1
AfWjYl2frCrNc7NRBs4k/5ivutPAn/HKROMqJNVRC2Rj1DGzB4qbNOHCJi6d78BJ
Gl7ESUPpyTUNJBiWQxSD
=ycSU
-----END PGP SIGNATURE-----

--dfEiRYlqpLMx5pl6kAd3VrrA5j3pEWzgc--

