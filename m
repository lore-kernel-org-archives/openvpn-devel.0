Message-ID: <4de9bda2-170d-610e-320d-ca1c24a6a120@...2108...>
Date: Thu, 26 Oct 2023 09:53:14 +0200
MIME-Version: 1.0
From: David Sommerseth <dazo+openvpn@...2108...>
References: <t1MQZ_-jSxZdlHXeRfgHr6imCso24bK-SYQV9dY2vjw5YSsXc06b5FkHQa6kFc6FMZKZ_2ooQ8HMPyifwD4BBw==@protonmail.internalid>
Content-Language: en-GB, en-US
In-Reply-To: <t1MQZ_-jSxZdlHXeRfgHr6imCso24bK-SYQV9dY2vjw5YSsXc06b5FkHQa6kFc6FMZKZ_2ooQ8HMPyifwD4BBw==@protonmail.internalid>
Subject: [Openvpn-devel] OpenVPN 3 Linux v21 released
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

OpenVPN 3 Linux v21 (stable)

This announcement comes a bit delayed as we have spent time ensuring
brand new software package repositories for both .deb and .rpm
packages are working properly.

We have now introduced a set of repositories suitable for production
environments.  These new repositories will only ship stable releases
which has been through a full set of quality assurance testing.
Packages in this repository will primarily focus on packages for
enterprise and long-term support Linux distributions, such as Debian
stable, Red Hat Enterprise Linux and Ubuntu LTS releases.

Fedora Copr repositories will still be used, but will also ship
development and beta releases.  We are also working on establishing
a similar repository for .deb packages too.  The Fedora Copr and the
coming repository for .deb packages will target faster moving Linux
distributions, such as the Fedora and the non-LTS Ubuntu releases.

    *NOTE*   The repository used for .deb packages up to
    *NOTE*   OpenVPN 3 Linux v20 will no longer receive
    *NOTE*   any updates.  You *MUST* setup the new
    *NOTE*   repository for .deb packages to receive the
    *NOTE*   OpenVPN 3 Linux v21 release

The community wiki has been updated with information how to enable
the new repositories, for both .deb and .rpm based distributions:

     <https://community.openvpn.net/openvpn/wiki/OpenVPN3Linux>

Over to the OpenVPN 3 Linux v21 details ...

Thais primarily a maintenance release with several minor bug fixes
and some general improvements.

*HOWEVER*, due to issues related to newer glib2 versions on
Arch Linux, Fedora and non-LTS Ubuntu releases, the v21 release
is targeting *only Enterprise/LTS distributions*.  The glib2
integration is going through a large overhaul to work better with
newer versions.  There will come a separate development release
for these distributions once that work has completed.  Details
related to this work can be tracked in this ticket:

     <https://github.com/OpenVPN/openvpn3-linux/issues/171>


* Improvement: Upgrade OpenVPN 3 Core Library to v3.8.2

    This is an upgrade from Core Library 3.7, which provides more
    enhancements and adds support for the newer ovpn-dco-v2 kernel
    module.  This is the same kernel module version OpenVPN 2.6
    supports.


* Bugfix: OpenVPN 3 Linux AWS VPC lacks support for IMDSv2

    mattjbyrd reported the AWS VPC integration was not working with EC2
    instances where IMDSv2 was enforced.  This issue is resolved with
    the OpenVPN 3 Core Library upgrade.

    Details: <https://github.com/OpenVPN/openvpn3-linux/issues/192>


* Bugfix: Python StatusCallback did not work without LogCallback enabled

    Jeremy Fleischman reported an issue related the openvpn3 Python
    module did not work when just setting up a
    SessionManager.StatusCallback() method.  He provided a fix which is
    now included in v21.  Thanks a lot, Jeremy!

    Details:
<https://github.com/OpenVPN/openvpn3-linux/commit/ba6fe37e7e28d1e633b56052383da3072f03c11e>


* Bugfix: openvpn3 config-manage override may not always work

    The openvpn3 config-manage override options would in some cases not work
    due to a programming error related to an internal set_override() method
    and the SetOverride() D-Bus method.  The result was that typically
    string values ended up empty.  Now all the overrides can be configured
    again.


* Bugfix: OpenVPN 3 Python based configuration parser issues

    Several options and --profile-overrides did not work or was completely
    missing, like the dns-scope and allow-compression overrides.  This
    has been improved and the list of overrides should now be up-to-date
    with openvpn3 config-manage.

    The Python based option parser also did not fully support overrides
    with a boolean true/false setting properly.  This has also been
    fixed.


* Improvement: Detect needed host specific settings during package install

    The OpenVPN 3 Linux v20 introduced the openvpn3-admin init-config
    command.  This has been further improved and will now be run
    automatically during the package installation.  This command will
    probe the system for important features on the system, like what
    kind of system logging is in use, what kind of DNS resolver
    approach being available (systemd-resolved, /etc/resolv.conf) as
    well as doing other sanity checks, like if the needed openvpn
    user/group is present, important directories being configured
    correctly and that SELinux based systems have the proper file
    contexts set up.

    The default behaviour is that existing configuration changes done
    will NOT be overwritten.  But if no settings has been set, it will
    generate configurations files better matching the running system.


* Improvements: OpenVPN 3 Log Service

    The OpenVPN 3 Log service (openvpn3-service-logger) made it
    hard to track where Attached: and Detached: log events came
    from.  This does now add a PID reference, which can be traced
    more easily in the logs.


* Improvements: OpenVPN 3 Configuration Manager feature support tracking

    When upgrading OpenVPN 3 Linux versions, there might be situations
    where an older OpenVPN 3 Configuration Manager will be running but
    the openvpn3 command line tool is newer.  When the command line tool
    attempts to access features in the Configuration Manager backed not
    available, it would result in an error and a poorer user experience.

    The code providing the glue interface for the calling side (openvpn3)
    has been extended with a feature/version mapping, so it can filter out
    operations not supported if the backend version is lacking certain
    functions.  In most cases, the openvpn3 config commands will then
    continue to work as before, just not providing access to features
    available in newer back-ends.

    A similar functionality is planned for the Session Manager and is
    being considered for the OpenVPN 3 Python module.


* Improvements: OpenVPN 3 Python module

    Configuration profiles from OpenVPN Access Server and
    some times OpenVPN Cloud Connexa will often contain "meta options",
    typically prefixed with "# OVPN_".  The Python parser would
    not accept several of the deprecated meta options.  The
    parser has now been extended to filter out those options not
    needed, used or supported by the OpenVPN 3 Core Library.


* Improvements: Adjustments needed to satisfy Debian packaging

    Several minor issues has been done to satisfy the Debian package linter
    utility.  There are still some issues left, some will not be possible
    to improve before Debian ships with a newer dbus-daemon - as we need
    functionality present in a newer release.  The dbus-broker is also
    lacking a similar functionality currently.  See the _credits_  section
    below for a bit more details on this.


* Feature: Label/tag support for imported OpenVPN configuration profiles

    The OpenVPN 3 Configuration Manager and the openvpn3 config-manage and
    configs-list commands has been extended to with the ability to add one
    or more text labels to configuration profiles.  At import time, the
    openvpn3 config-import command can also assign tags immediately.

    Users with many imported configuration profiles can more easily filter
    which configurations shown with the openvpn3 configs-list command.
    Other tools (openvpn3-as, openvpn-connector-setup) will also make use
    of this feature as they are being updated, to more easily understand
    where a configuration profile arrived from.


* Feature: JSON formatted output with openvpn3 configs-list and config-dump

    The list of configurations can now be retrieved as a JSON formatted
    list via the openvpn3 configs-lists.

    The openvpn3 config-dump will normally dump the normal configuration
    using the standard OpenVPN configuration file format.  The JSON format
    will contain all the additional meta options, overrides and access
    control lists not expressed in the standard file format.  This format
    is the same format used internally for persistent configuration
    profiles.


* Feature: Filtering options when retrieving available configurations

    The openvpn3 configs-list command has been extended with several
    filter arguments to only extract filters with a specific tag or
    owner as well as a simple prefix filter on the configuration name.

    The OpenVPN 3 Configuration Manager also exposes two new D-Bus
    methods to retrieve available configuration profiles based on a
    tag or owner.


* Feature: Simple and verbose list formats in openvpn3 configs-list

    The default listing in openvpn3 configs-list has been simplified
    and will only list one configuration profile per line now.  The
    more comprehensive list can be retrieved using the --verbose
    argument.  The verbose list will also include configuration tags.


Supported Linux distributions
-----------------------------

    - Debian 10, 11, 12 (amd64, arm64)
    - Red Hat Enterprise Linux 7 (x86_64)
    - Red Hat Enterprise Linux 8 and 9 (x86_64, aarch64)
    - Ubuntu 20.04 and 22.04, (amd64, arm64)

The arm64 support on selected Debian and Ubuntu releases are
considered tech-preview.  We would like to get feedback from
arm64 users how OpenVPN 3 Linux works here, then we can remove
the tech-preview label for arm64.

Installation and getting started instructions can be found here:

    <https://community.openvpn.net/openvpn/wiki/OpenVPN3Linux>


Credits
-------

This release has also received help from other contributors.
Thank you to all of you!

      Antonio Quartulli
      Frank Lichtenheld
      Jeremy Fleischman
      mattjbyrd

In addition, a "thanks in advance" goes to the work Marc Leeman is
currently doing to provide a native Debian repository package for
OpenVPN 3 Linux.  Thanks a lot, Marc!

That work can be followed here:
    <https://github.com/OpenVPN/openvpn3-linux/issues/193>


--
kind regards,

David Sommerseth
OpenVPN Inc


---- Source tarballs ---------------------------------------------------
* OpenVPN 3 Linux v21


<https://swupdate.openvpn.net/community/releases/openvpn3-linux-21.tar.xz>

<https://swupdate.openvpn.net/community/releases/openvpn3-linux-21.tar.xz.asc>

---- SHA256 Checksums --------------------------------------------------

7f9ca44d44453658c702a461627b29e450969bc182090bd2cd080a3dda1e2f5b
openvpn3-linux-21.tar.xz
75b8dbcfa4d8e1589281659891f7b905bece7ec7e792a331b996bb5f237fb93b
openvpn3-linux-21.tar.xz.asc

---- git references ----------------------------------------------------

git repositories:
      <https://codeberg.org/OpenVPN/openvpn3-linux> (Primary)
      <https://gitlab.com/openvpn/openvpn3-linux>   (mirror)
      <https://github.com/OpenVPN/openvpn3-linux>   (mirror)

git tag: v21
git commit: edf113b8138a2e535657c3609eccaef9cc26f060

---- Changes from v20 to v21 -------------------------------------------

Antonio Quartulli (2):
        ovpn3cli/init-config: use namespace NetCfg::DNS also if no
systemd is available
        netcfg-dco: remove code made obsolete by ovpn-dco-v2

David Sommerseth (128):
        Update GitHub pull-req template
        configmgr: Add override caching to
OpenVPN3ConfigurationProxy::GetOverrides()
        configmgr: Extend Configuration Proxy with GetOverrideValue()
        ovpn3cli/config: Explicitly provide DNS Resolver Scope setting
        netcfg/dns: Enable default DNS routing when scope is global
        netcfg/dns: Document the
NetCfg::DNS::systemdResolved::updateQueueEntry properties
        build: Fix improper cleanup
        aws: Remove execute flag on systemd unit file
        log: Save a flag for changed properties in LogServiceProxy
        log: Extend LogServiceProxy to track what the original value was
        ovpn3cli/admin: Refactor log-service command
        docs: Improve doxygen setup
        common: Add missing header file in lookup.hpp
        netcfg/dns: New method - ResolvConfFile::GetNameServers()
        ovpn3cli: Extend init-config to also consider /etc/resolv.conf
        log: Extend LogMetaDataValue to handle integers
        log: Parse the O3_INTERNAL_METHOD meta data
        log: Extend Logger with GetLogTagPtr() method
        log/service: Refactor out log detaching logic to separate method
        log/service: Enable automatic cleanup of stray subscriptions
        python: Fix ConfigParser.ReadConfigFile not removing semicolon
comments
        Update to OpenVPN 3 Core library v3.8 baseline
        client: Check if the configuration is DCO compliant before start
        vendor: Update to ASIO 1.28.0
        log: Add caller PID to Attach/Detach calls
        docs: Remove Linux distributions which is no longer supported
        log: Strip double {tag:...} references in openvpn3-admin journal
output
        core: Update to latest OpenVPN 3 Core 3.8 related changes
        ovpn3cli: Add --exists and --quiet to config-manage
        configmgr: Add missing #include<dbus/path.hpp>
        docs: Add missing configmgr description: SetOverride/UnsetOverride
        configmgr: Add support for assigning tags to config profiles
        configmgr: Preserve configuration profile tags on disk
        configmgr: Return gracefully if a method call is not processed
        configmgr: Expose C++ method for checking config profile tags
        configmgr: Add D-Bus method to search for config profile tags
        configmgr/proxy: Extend proxy object with tag management
        ovpn3cli: Show config profile tags in config-manage
        configmgr/proxy: Improve tag management error handling in proxy
object
        ovpn3cli: Add tag management to config-manage
        ovpn3cli/config-manage: Consider --quiet in all informational output
        configmgr/proxy: Make tag prefix 'system:' reserved
        python: Extend Configuration implementation with tag management
        python: Implement SearchByTag() in ConfigurationManager object
        python: Extend ConfigurationManager.Import() to add system tags
        python/openvpn3-as: Add an openvpn3-as specific system tag on import
        configmgr: Refactor ConfigManagerObject D-Bus method call handler
        configmgr: Refactor ConfigurationObject D-Bus method call handler
        configmgr: Rework the config profile usage counter check logic
        configmgr: Replace __FUNCTION__ macro in GLibUtils calls
        core: Switch to OpenVPN 3 Core version 3.8
        configmgr: Reorder #include files
        configmgr: Remove stray handler_fetch_json() method
        configmr: Refactor g_variant_get() calls, use GLibUtils instead
        dbus/glib: Extend GVariantBuilder helpers with type override
        configmgr: Refactor std::vector D-Bus return values to use GLibUtils
        configmgr/proxy: Refactor g_variant_get() calls, use GLibUtils
instead
        dbus: Extend GLibUtils with ParseGVariantList()
        configmr/proxy: Refactor proxy code retrieving D-Bus arrays
        ovpn3cli: Add --filter-config to configs-list command
        configmgr/proxy: Extend proxy object with tag search
        ovpn3cli: Add --filter-tag to configs-list command
        configmgr: Add D-Bus method to search for profiles by specific owner
        configmgr/proxy: Extend proxy object with SearchByOwner()
        ovpn3cli: Add --filter-owner to configs-list
        ovpn3cli: Add --count to configs-list
        ovpn3cli: Improve configs-list output
        client: Do not reset empty env array in backendstart
        core: Update to OpenVPN 3 Core library v3.8.1
        dbus: Clean up odd init booleans in DBusProxy
        dbus: Cleaning up impropoer DBusProxy internal proxy pointers 
freeing
        dbus: Remove the DBusProxy() constructor accepting DBus() objects
        dbus: Protect DBusProxy::proxy pointers changes better
        ovpn3cli: Fix signedness comparison issue in cmd_config_manage()
        netcfg: Fix improper use of std::move() variables in
NetCfgProxyException
        dbus: Fix copy-paste error in DBusProxy destructor
        configmgr: Use a better data type for timestamps in JSON Export()
        netcfg/unit: Add DNSResolverSettings.AddNameServer_multiple test
        netcfg/dns: Replace RC/RCPtr with std::shared_ptr in 
ResolverSettings
        netcfg/dns: Be consistent with for-iterators in SettingsManager
        dbus: Add more details when dbus_proxy_call() fails
        dbus: Fix incorrect use of proxy object in DBusProxy::GetNameOwner()
        build: Add a few missing #include files
        netcfg/dns: Improve details on file removal in 
FileGenerator::Write()
        netcfg/dns: Catch and report errors in
ResolvConfFile::~ResolvConfFile()
        netcfg: Check fd properly before close() in
NetCfgServiceObject::protect_socket()
        common: Fix potential memleak in SingleCommand::parse_commandline()
        common: Fix incorrect arg passing in Configuration::OptionMapEntry
        common: Fix incorrect lambda arg passing in Configuration::File
        docs: Fix incorrect signal signature for netcfg.NetworkChange
        ovpn3cli/configs-list: Add --json output format
        build: Do not distribute ovpn-dco header as part of openvpn3-linux
        configmgr: Use Json::Value::UInt64 instead of uint64_t
        dbus/glibutils: Don't initialize std::stringstream
        configmgr: Check override type as well as D-Bus type in
set_override()
        configmgr: Add missing #include in overrides.hpp
        configmgr: Fix incorrect set_override() declaration
        configmgr: Fix lacking config override value extraction
        configmgr/tests: Update config-override-selftest exception checks
        python: Add support for --ignore-unknown-option in openvpn2
        core/config: Extend OpenVPN Access Server configuration support
        core/config: Filter out meta-options in 
OptionListJSON::json_export()
        tests: Add unit test for OptionsJSON string and JSON export methods
        common: Extend ParsedArgs::Present(std::vector<>) to optionally
return empty string
        ovpn3cli: Don't throw an exception in config-manage if operation
is not found
        python: Fix typ0 in error message with incorrect override key
        python: Move supported profile overrides definition
        python: Ensure --profile-overrides is not put into generated config
        python: Add support for allow-compression profile override setting
        ovpn3cli/config: Move openvpn3 config-import into a separate
compilation unit
        ovpn3cli/config: Extend JSON schema used by config-dump --json
        python: ConfigParser does not process boolean overrides correctly
        python: Add support for dns-scope profile override in ConfigParser
        core: Update to OpenVPN 3 Core library v3.8.2
        configmgr/proxy: Add framework for backend feature checking
        configmgr/proxy: Add CfgMgrFeatures::TAGS checking
        ovpn3cli/config: Add feature check for configs-list and 
config-manage
        configmgr/proxy: Add forcing feature loading in the
OpenVPN3ConfigurationProxy
        ovpn3cli/config: Add --tag support to config-import
        ovpn3cli/config: Fix typo in JSON key for transfer_owner_session
        ovpn3cli/config: Add missing feature check in config-dump
        proxy: Fix incorrect version extraction logic with non-service
root paths
        build: Rework the OpenVPN 3 Core library version macro
(OPENVPN_VERSION)
        python: ConfigParser does not accept --bind
        python: ConfigParser did not accept dns-fallback-google and
persist-tun overrides
        docs/man: Use the proper section tag in openvpn3-systemd.8
        misc: Fixing several typ0s all over the code base
        docs: Minor touches to README and BUILD docs

Frank Lichtenheld (1):
        docs/man: Fix description in openvpn3-config-manage man page

Jeremy Fleischman (1):
        python: Fix StatusChangeCallback() so it works without a LogCallback

------------------------------------------------------------------------

-- 
kind regards,

David Sommerseth
OpenVPN Inc


