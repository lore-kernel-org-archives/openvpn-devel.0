Message-ID: <2eec0f19-3ebc-4f83-b72d-9f62c817339b@...2108...>
Date: Wed, 24 Sep 2025 15:15:20 +0200
MIME-Version: 1.0
From: David Sommerseth <dazo+openvpn@...2108...>
Content-Language: en-US
Subject: [Openvpn-devel] OpenVPN 3 Linux v26 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: openvpn-announce@lists.sourceforge.net
Cc: "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>, openvpn-devel <Openvpn-devel@lists.sourceforge.net>

OpenVPN 3 Linux v26 (Stable release)

The v26 release is a small bugfix and enhancement release.

Please notice the deprecation of openvpn3-autoload.

* Enhancement: Improve user feedback when a VPN profile is not valid
  Since the OpenVPN 3 Linux v22_dev release, the
  openvpn3-service-configmgr service has provided an API to validate
  VPN profiles it manages.  This has been used in the rest of the
  available tools to check if everything is in order before
  attempting to start a VPN session.

  When a configuration profile was lacking certain required options,
  it would fail this validation.  But the feedback to the user was
  not much helpful and the user would need to check the
  configuration profile manually.

  With the v26 release, the end user will be provided a list of
  required configuration options missing.


* Enhancement: Set route metric value when provided via VPN session
  Since the very beginning of OpenVPN 3 Linux, the route metric
  value has been ignored.  This has been improved in the v26 release
  and the metric values provided in the configuration profile or
  pushed from the VPN server will now be respected.
  

* FEATURE DEPRECATION: openvpn3-autoload

  The openvpn3-autoload feature was deprecated already in the
  v20 release.  This feature will be removed in a coming stable
  release.

  The replacement is the openvpn3-session@...1685... systemd unit.
  Please see the openvpn3-systemd man page [1] for more details.

  If you depend on openvpn3-autoload today, please migrate ASAP
  to the systemd approach.

  [1] <https://codeberg.org/OpenVPN/openvpn3-linux/src/branch/master/docs/man/openvpn3-systemd.8.rst>


* Bugfix: Proper parsing of <connection/> tags in OpenVPN configs
  The internal VPN profile configuration parser did not properly
  parse configuration files containing <connection>...</connection>
  tags to configure a remote server.  This has been fixed and both
  the openvpn3-service-configmgr and the openvpn3 Python module has
  been updated to support this feature.


* Bugfix: Proper parsing of semicolon (;) as comment line
  The openvpn3 Python module did not properly parse configuration
  files which used semicolon (;) as a comment separator.  This
  has been improved and both hash (#) and semicolon can now be
  used for comments in configuration profiles.


* Bugfix: openvpn3-service-netcfg may stop on route setup errors
  In some corner cases, when the openvpn3-service-client (VPN
  client) process called the Network Configuration service
  (openvpn3-service-netcfg) to establish the VPN network
  interface, the Network Configuration service could crash
  and not recover, resulting in the VPN session not being able
  to be established.  This has been improved and this error
  situation is now handled and logged properly.


* Bugfix: Background D-Bus calls to systemd-resolved fails
  On some systems the D-Bus communication between the
  openvpn3-service-netcfg (NetCfg) process and systemd-resolved
  could be too slow, resulting in the NetCfg process retrying
  the D-Bus call.  Due to an incorrect retry logic, the parameters
  systemd-resolved would need had been released from memory and
  was no longer accessible.  This has been resolved and the
  retry logic now behaves as expected.


* Bugfix: VPN session restart triggers assertion warning in logs
  When an on-going VPN session is attempted restarted, for example
  via the openvpn3 session-manage command, the NetCfg service
  would log an assertion warning in the system logs.  This has
  been resolved and VPN session restarts will now work as expected.


* Bugfix: OpenVPN 3 AWS-VPC fails changing IPv6 routes
  Due to a typo in the parameter name used for changing IPv6
  routes in the AWS VPC service, setting IPv6 routes would result
  in an error.  This has been resolved in the OpenVPN 3 Core
  version 3.11.5 release, which OpenVPN 3 Linux v26 has
  upgraded to.


* OpenVPN 3 Core Library update
  The OpenVPN 3 Core Library has been updated to version 3.11.5,
  which is contains the fix for the AWS VPC route fix.  It also
  enables building against Linux 6.16 kernel headers.


Known issues:

  - The openvpn3-service-netcfg service does not differentiate between
    --dns server X resolve-domains and --dns search-domains when using
    the --resolv-conf mode, which is not as this feature is
    intended to work.  This was discovered in the v24 release and is
    on the schedule to be fixed in the next releases.  When this gets
    fixed, only --dns search-domains will be considered as search
    domains and --dns server X resolve-domains will enable split-DNS
    when using --systemd-resolved and otherwise ignored when using
    --resolv-conf with openvpn3-service-netcfg.


Supported Linux distributions
-----------------------------

  - Debian: 12, 13[*]
  - Fedora: 41, 42
  - Red Hat Enterprise Linux 8, 9, 10[*]
  - Ubuntu: 22.04, 24.04, 25.05

Installation and getting started instructions can be found here:

  <https://community.openvpn.net/openvpn/wiki/OpenVPN3Linux>

There are in addition other Linux distributions now providing
OpenVPN 3 Linux packages.  These distributions are primarily
supported by their respective distribution communities.  We will
naturally review and apply fixes deemed needed for any
distributions as they occur.

NOTE: Red Hat Enterprise Linux 10
  The Fedora Copr repository definition for RHEL+EPEL-10 *may*
  use a wrong URL.  After doing the 'dnf copr enable' step
  on RHEL-10, please ensure the URL contains 'rhel+epel' and
  not just 'epel'.  This is expected to automatically improve
  with time.

  The stable repositories provided by OpenVPN Inc should not
  have this issue.

NOTE: Debian 13 (Trixie)
  Debian 13 is added to the list of supported distribution versions.
  With Debian 13 there is now also an upstream distribution package
  as well, openvpn3-client, as well as the GDBus++ library.  The
  version in the distribution repository is at OpenVPN 3 Linux v24.1.
  This cannot be upgraded to a newer base line, due to Debian
  packaging rules.  The package maintainer will apply bug and security
  fixes as needed.

  If you want to use a newer OpenVPN 3 Linux on Debian 13, you will
  need to install the third-party repository provided by OpenVPN Inc.
  This is the same procedure as in Debian 12 and earlier.  With the
  v26 release, the package has been renamed to 'openvpn3-client' and
  an upgrade path from the openvpn3 package has been added.  After
  upgrading to v26, the openvpn3 transitional package can be removed
  via 'apt autoremove'.


--
kind regards,

David Sommerseth
OpenVPN Inc


---- Source tarballs ---------------------------------------------------
* OpenVPN 3 Linux v26

  <https://swupdate.openvpn.net/community/releases/openvpn3-linux-26.tar.xz>
  <https://swupdate.openvpn.net/community/releases/openvpn3-linux-26.tar.xz.asc>

* GDBus++ v3

  <https://swupdate.openvpn.net/community/releases/gdbuspp-3.tar.xz>
  <https://swupdate.openvpn.net/community/releases/gdbuspp-3.tar.xz.asc>

---- SHA256 Checksums --------------------------------------------------

80e35615ae913fbdbdda53495b27934a3bbb21d8b15c49a624d4992c15e196e1  openvpn3-linux-26.tar.xz
474ba43ae9a6f4e8e5488750ed779bf57e7e2efe9bc05d196f65adb83f830eb4  openvpn3-linux-26.tar.xz.asc
c7a053a13c4eb5811a542b747d5fcdb3a8e58a4a42c7237cc5e2e2ca72e0c94e  gdbuspp-3.tar.xz
b9cf732d7a347f324d6a5532dc48f80c2815dbf6704c169b4ee97a411506a99b  gdbuspp-3.tar.xz.asc

---- git references ----------------------------------------------------

git repositories:

 - OpenVPN 3 Linux
   <https://codeberg.org/OpenVPN/openvpn3-linux> (PRIMARY)
   <https://gitlab.com/openvpn/openvpn3-linux>   (code-only mirror)
   <https://github.com/OpenVPN/openvpn3-linux>   (code-only mirror)

   git tag: v26
   git commit: 42ecc42a782025f8774e907a8c1966524424bcee

 - GDBus++
   <https://codeberg.org/OpenVPN/gdbuspp/>       (PRIMARY)
   <https://gitlab.com/openvpn/gdbuspp/>         (code-only mirror)
   <https://github.com/openvpn/gdbuspp/>         (code-only mirror)

   git tag: v3
   git commit: 96f7fb688ed2dea3f192c63c5fe283dbe4900f16

---- Changes from v25 to v26 ---------------------------------------

David Sommerseth (30):
      build: Add fmt subproject
      configmgr: Add details when profile validation fails
      ovpn3cli/config-import: Show warning if imported profile is invalid
      netcfg/resolved: Ensure glib2 params are available on retries
      common: Refactor and clean-up core-extensions.hpp
      common/core-extensions: Move helper functions into OptionListJSON class
      tests: Parse Access Server meta options in config-export-json-test
      common: Properly parse <connection/> blocks
      netcfg: Catch Core library exceptions in method_establish()
      configmgr: Let <connection/> tags be equivalent to --remote when validating the profile
      python: Deprecate openvpn3.ConfigParser.SanityCheck()
      python/openvpn2: Make Configuration.Validate() errors more user friendly
      python/openvpn2: Add IMPORT_ONLY debug more
      python: Implement <connection/> tag support in ConfigParser
      netcfg: Clarify IP address 'prefix' usage
      netcfg: Split up the NetCfgProxy::Network object construction
      netcfg: Small clean-up/codestyle fixup for IPAddr, Network and VPNAddress classes
      netcfg: Add support for route metric when assing VPN routes
      netcfg/proxy: Add service version check for D-Bus API compatibility
      python: Semicolon is not accepted by openvpn3.ConfigParser
      common: Minor cleanups in cmdargparser code
      netcfg/resolved: Fix g_variant_ref assertion warning on session restarts
      core: Update to OpenVPN 3 Core Library v3.11.4
      docs: Minor updates to the coding style guide
      Code style cleanup
      git: Update .git-blame-ignore-revs ignoring last code-style changes
      Quick spellcheck fixes all over project
      configmgr: Fix auth-user-pass handling regression
      netcfg: Make logged metric details more user friendly
      core: Update to OpenVPN 3 Core Library v3.11.5

--------------------------------------------------------------------

