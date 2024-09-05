Message-ID: <09e9f8a6-cf7a-67f5-e463-c87bf5179e73@...2108...>
Date: Thu, 5 Sep 2024 17:25:36 +0200
MIME-Version: 1.0
From: David Sommerseth <dazo+openvpn@...2108...>
References: <54Nu7vT0SZVJt4FEHSO4m1kqBqZks9pUHtm9RH7ZjiWR5ktqsZcuQb17jv46FDgVifTZKcj-YljhWdZJ9rA9cg==@protonmail.internalid>
Content-Language: en-GB, en-US
In-Reply-To: <54Nu7vT0SZVJt4FEHSO4m1kqBqZks9pUHtm9RH7ZjiWR5ktqsZcuQb17jv46FDgVifTZKcj-YljhWdZJ9rA9cg==@protonmail.internalid>
Subject: [Openvpn-devel] OpenVPN 3 Linux v23 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>, openvpn-users <openvpn-users@lists.sourceforge.net>

OpenVPN 3 Linux v23 (Stable release)

The v23 release is stable release which expands the distribution target
since v22_dev was released.  The goal for this step was to stabilize the
codebase which was migrated to GDBus++ and the new Meson building
system.  The next release (v24) will also be a stable release, with focus
on further stabilisation and less intrusive changes.

The v23 release brings back the OpenVPN 3 AWS-VPC Add-on which was not
ready for the v22_dev release.  This service has also been migrated to
use GDBus++.  The behaviour of this add-on should otherwise be identical
to the service shipped in v21 and older releases.

In addition, a new add-on is included in this release.  The Cloud
Connexa service is being extended with a new functionality, referred to
as Device Posture Checks (DPC).  This feature will enable the VPN server
to request certain checks to be performed on the client side and
reported back to the server.  These checks are restricted to what the
new OpenVPN 3 Device Posture Service (openvpn3-service-devposture)
provides.

This new feature is NOT installed nor enabled by default.  To enable the
client-side functionality, the openvpn3-addon-devposture package must
be installed, the VPN client configuration must be pre-imported and
an Enterprise ID must be assigned to the configuration profile.  That
will allow the server to request Device Posture Checks to be performed.

The currently implemented DPC tests only provides platform information,
like Linux distribution name and version, kernel versions, CPU
architecture and the client's local time.  In future releases, more
tests may be implemented.  More information on available tests and
the declaration of test profiles can be found here:

 
<https://codeberg.org/OpenVPN/openvpn3-linux/src/branch/master/addons/devposture/profiles/profile-format.md>


Known issues:

     - openvpn3-service-client may not exit cleanly unless stopped
       via 'openvpn3 session-manage --disconnect' first.  This may
       delay the shutdown process if a VPN session is running when
       the host is being shut down.  A fix is in progress and will
       be prepared for v24.

     - Shell completion may list duplicated options in some cases

     - openvpn3-admin journal --since has a time zone related issue
       and may not list all log events within the closest hours.


Other changes:

* Improvement: Upgrade to OpenVPN 3 Core Library v3.10.1

     This library update provides the functionality to provide the
     Device Posture Check functionality in the OpenVPN wire
     protocol.  A fix to resolve compilation errors when the
     -Wnon-virtual-dtor compiler flag is enabled is included too.


* Bugfix: Report client and version correctly in IV_GUI_VER

     The v22_dev release unfortunately changed the format of the
     IV_GUI_VER.  It would report: 'openvpn3-linux/v22:dev' when
     it should have been 'OpenVPN3/Linux/v22_dev'.  This has
     been fixed.


* Bugfix: --tag option not working with config-import or config-manage

     A regression bug was introduced in v22_dev which handled the
     available tracking of Configuration Manager features incorrectly
     and ended up disabling this feature in the openvpn3 config-import
     and openvpn3 config-manage commands.  This has been fixed.


* Bugfix: systemd-resolved support rejected IPv6 DNS resolver address

     An oversight in the systemd-resolved implementation refused to accept
     pushed DNS resolver addresses when it was an IPv6 address.  This has
     been fixed and both IPv4 and IPv6 addresses are now fully supported.


* Improvement: Python configuration parser support for 
--connect-retry{,-max}

     The Python configuration parser in the openvpn3 module did
     not provide a pass-through for --connect-retry and --connect-retry-max
     options.  This would result in configuration profiles containing
     these options would not function when using the Python based tools
     while it would work using the 'openvpn3' command.


Credits
-------

Thanks goes to those continuing testing and reporting issues.
A special thanks to Grzegorz Gutowski who provided the fix to
the Python module.  He is also the project lead behind the
openvpn3-indicator project, which provides a tray-icon for
OpenVPN 3 Linux.  If you use a graphical desktop, that's a
project worth checking out!

Many thanks also goes to Razvan Cojocaru who has stepped in providing
many great improvements and done all the work for the Device Posture
support in OpenVPN 3 Linux.  And Lev Stipakov who migrated the
OpenVPN 3 AWS-VPC add-on service to GDBus++


Supported Linux distributions
-----------------------------

     - Debian: 12
     - Fedora: 39, 40, Rawhide
     - Red Hat Enterprise Linux 8, 9
     - Ubuntu: 20.04, 22.04, 24.04

Installation and getting started instructions can be found here:

     <https://community.openvpn.net/openvpn/wiki/OpenVPN3Linux>

Debian 11, Red Hat Enterprise Linux 7 and Ubuntu 23.10 are EOL and
is no longer supported.


--
kind regards,

David Sommerseth
OpenVPN Inc


---- Source tarballs ---------------------------------------------------
* OpenVPN 3 Linux v23

 
<https://swupdate.openvpn.net/community/releases/openvpn3-linux-23.tar.xz>
 
<https://swupdate.openvpn.net/community/releases/openvpn3-linux-23.tar.xz.asc>

* GDBus++ v2

     <https://swupdate.openvpn.net/community/releases/gdbuspp-2.tar.xz>
     <https://swupdate.openvpn.net/community/releases/gdbuspp-2.tar.xz.asc>

---- SHA256 Checksums --------------------------------------------------

3c5a4e27e0618f395c1688b50b62b887543ff203d4c99af7f7bfe1d61d0e753b 
openvpn3-linux-23.tar.xz
cc801911df93072101e6218ac62c45e8f524cb42c0536e692d8da5fe8b1253d8 
openvpn3-linux-23.tar.xz.asc
0a3eab5c7f1f5ba803bec0902bb008b8c7a7040fdaf0e0e94b4ac77ffebf0bfd 
gdbuspp-2.tar.xz
361fe7f8ced70d49a2899ad4e790d6e9e1832f419ef3d7875226d44d997b7397 
gdbuspp-2.tar.xz.asc

---- git references ----------------------------------------------------

git repositories:

    - OpenVPN 3 Linux
      <https://codeberg.org/OpenVPN/openvpn3-linux> (PRIMARY)
      <https://gitlab.com/openvpn/openvpn3-linux>   (code-only mirror)
      <https://github.com/OpenVPN/openvpn3-linux>   (code-only mirror)

      git tag: v23
      git commit: d8239ede97fc91919f35a59a14a116769defcc49

    - GDBus++
      <https://codeberg.org/OpenVPN/gdbuspp/>       (PRIMARY)
      <https://gitlab.com/openvpn/gdbuspp/>         (code-only mirror)
      <https://github.com/openvpn/gdbuspp/>         (code-only mirror)

      git tag: v2
      git commit: 94f29d20accb755a08a9890efe5242d89d5b51bc

---- Changes from v22_dev to v23 ---------------------------------------

David Sommerseth (24):
         configmgr: Load configuration profiles before starting the 
D-Bus service
         netcfg: Make NetCfgNotifSubscriptions use uint32_t as filter 
bit mask
         codestyle: Fix minor code style deviations
         build: Enable overriding OpenVPN 3 Core Library version string
         scripts: Modify the output of the --gui-version
         addons/devposture: Fix compilation error with older JsonCpp 
libraries
         addons/devposture: Make devposture-proxy test program more generic
         addons/devposture: Document the Enterprise Profile file format
         build: Install some additional documentation by default
         docs: Clarify a GDBus++ and mbed TLS build dependencies better
         build: Set PACKAGE_NAME to 'OpenVPN3/Linux'
         Some minor #include clean-ups
         configmgr: Cleaning up #include files
         configmgr: Use CoreLog for logging events from the Core library.
         client: Don't stop if devposture service is unavailable
         devposture/test: Improve argument parsing in devposture-proxy
         addon/devposture/proxy: Properly re-throw 
DevPosture::Proxy::Handler exceptions
         netcfg/resolved: Factor out resolved::Exception to a separate file
         tests/resolved: Extend systemd-resolved proxy test client with 
IPv6 support
         netcfg/resolved: Add new D-Bus IP Address parser class
         netcfg/resolved: Use GDBus++ glib2 helpers extracting data in 
SearchDomains::GetGVariant
         netcfg/resolved: Plug-in resolved::IPAddress into ResolverRecord
         netcfg/resolved: Refactor out resolved::ResolverRecord
         core: Update to OpenVPN 3 Core Library v3.10.1

Grzegorz Gutowski (1):
         python: Pass through --connect-retry and --connect-retry-max

Lev Stipakov (5):
         netcfg: use proper C++ base type for NetCfgChangeType
         netcfg/proxy: Check non-response call for nullptr before freeing
         configmgr: remove unused class members
         addons/aws: Switch to GDBus++
         addons/aws: adapt to core RandomAPI changes

Razvan Cojocaru (10):
         core: Update to OpenVPN 3 Core Library releaseprep/3.10
         addons/devposture: Add openvpn3-linux-devposture
         configmgr: Add the enterprise-profile override
         ovpn3cli/config: Add openvpn3 config-manage --enterprise-profile
         client: Plug in Device Posture support
         configmgr: Use a regular expression to determine version number
         configmgr: Accumulate proxy feature flags instead of overwriting
         netcfg: Check stub-resolv.conf before giving up on systemd-resolved
         common: give SingleCommand a virtual destructor
         addons/devposture: Add core_ver and extra_ver to client_info

------------------------------------------------------------------------



-- 
kind regards,

David Sommerseth
OpenVPN Inc


