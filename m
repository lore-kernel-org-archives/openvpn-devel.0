Message-ID: <b6de19e6-c57e-b8cf-b40d-32640b893291@...2108...>
Date: Thu, 20 Jun 2024 23:08:15 +0200
MIME-Version: 1.0
Content-Language: en-GB, en-US
From: David Sommerseth <dazo+openvpn@...2108...>
Subject: [Openvpn-devel] OpenVPN 3 Linux v22_dev released
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


OpenVPN 3 Linux v22_dev (Limited Release)

This is a limited release primarily targeting Fedora 39 and newer plus
Ubuntu 24.04.  Other Linux distributions shipping glib2 version 2.76
or newer will also benefit from this release.

This release contains a massive re-factoring of the D-Bus integration
layer with glib2.  The glib2 2.76 and newer releases contains several
internal changes which broke the D-Bus implementation layer in
OpenVPN 3 Linux v21 and older releases [1]. To fix this, it was decided
to split out the base D-Bus integration into a new standalone library
which OpenVPN 3 Linux will depend on.  This new project is called
GDBus++.

[1] <https://github.com/OpenVPN/openvpn3-linux/issues/171>

The GDBus++ library makes extended use of multi-threading when
processing D-Bus method calls and implements modern C++17 approaches
when handling requests to registered D-Bus objects.  It has also been
a strong focus on getting rid of as much of various glib2 warnings
which could occasionally appear in prior OpenVPN 3 Linux releases.

There are most likely a still a lot more room for improvements to both
the new GDBus++ and the upgraded OpenVPN 3 Linux code, which is why
this release targets a more limited release scope.

This release has only been through the full QA validation on Fedora 39,
Fedora 40 and Ubuntu 24.04.

That said, this new code can be made available for all the officially
supported RPM distributions by enabling a "development snapshots" repository.
But this repository will also not have the same QA guarantees as the
official stable repositories.

On a development note, this project has now migrated to use Meson [2] as
the build system.  The autoconf/automake build system is now completely
removed.  The Meson build system has turned out to be way simpler to
use and configure than autotools ever was, especially from a developers
point of view.

[2] <https://mesonbuild.com/>


There are unfortunately a few known issues which is targeted for
the coming v23 release:

   - AWS VPC integration is not yet ready, so this add-on is currently
     not available in this v22_dev release.  This is targeted for v23.

   - Shell completion may list duplicated options in some cases

   - openvpn3-admin journal --since has a time zone related issue
     and may not list all log events within the closest hours.


Other changes worth mentioning with this release:

* Improvement: Upgrade to OpenVPN 3 Core library v3.8.5

   This upgrade contains several bug fixes related to the option
   parser, mostly issues reported by a wide range of users.  In
   addition to incorrect behaviour with the stub compression when
   the --compress option was used.

* Improvement: openvpn3-admin journal --since argument

   The --since argument can now use the keywords 'today' and
   'yesterday'.

* Bug fix: openvpn3-admin log-service would not change some settings

   On some distributions, the --dbus-details and other boolean flags
   was not properly changed when requested.  This has been improved.


Credits
-------

Finally, it is needed to give a HUGE THANK YOU to all the community
testers which installed and tested rolling development snapshots during
the development of this release.  Without all this testing, we would
not have the same confidence in this release as we have now.  All your
help and feedback has been really valuable and helpful during this the
development phase.


Supported Linux distributions
-----------------------------

   - Fedora: 39, 40, Rawhide
   - Ubuntu: 24.04, (amd64, arm64)
   - Red Hat Enterprise Linux 8, 9 (no QA, development snapshot only [3])

Installation and getting started instructions can be found here:

   <https://community.openvpn.net/openvpn/wiki/OpenVPN3Linux>

The v23 release will also include support for all distributions again,
including Debian 12.  Debian 11, Red Hat Enterprise Linux 7 and
Ubuntu 23.10 will go EOL in just a few days or weeks and will no longer
be supported.


[3] Fedora Copr development snapshots:
     <https://copr.fedorainfracloud.org/coprs/dsommers/openvpn3-devsnapshots/>


-- 
kind regards,

David Sommerseth
OpenVPN Inc


---- Source tarballs ---------------------------------------------------
* OpenVPN 3 Linux v22_dev

   <https://swupdate.openvpn.net/community/releases/openvpn3-linux-22_dev.tar.xz>
   <https://swupdate.openvpn.net/community/releases/openvpn3-linux-22_dev.tar.xz.asc>

* GDBus++ v1

   <https://swupdate.openvpn.net/community/releases/gdbuspp-1.tar.xz>
   <https://swupdate.openvpn.net/community/releases/gdbuspp-1.tar.xz.asc>

---- SHA256 Checksums --------------------------------------------------

ad8f373814bfbefd12f9824d57badef4535f6c1fde68d2c73d7ee14863547cb6  openvpn3-linux-22_dev.tar.xz
32af8668130966959319ccd2769146090de5eab73a98612add6a5f9a99ff6921  openvpn3-linux-22_dev.tar.xz.asc
e53e47f8529109e138d59ff38374818692b6fe26f2fee2d00642bba272e117a3  gdbuspp-1.tar.xz
eff710210822b8127ec7f2f9b6879ac8150d2c74099c498d4811a2668d7f9670  gdbuspp-1.tar.xz.asc

---- git references ----------------------------------------------------

git repositories:

  - OpenVPN 3 Linux
    <https://codeberg.org/OpenVPN/openvpn3-linux> (PRIMARY)
    <https://gitlab.com/openvpn/openvpn3-linux>   (code-only mirror)
    <https://github.com/OpenVPN/openvpn3-linux>   (code-only mirror)

    git tag: v22_dev
    git commit: 2ec1ebce758b1d521498c05c55e355b043c3d7f1

  - GDBus++
    <https://codeberg.org/OpenVPN/gdbuspp/>       (PRIMARY)
    <https://gitlab.com/openvpn/gdbuspp/>         (code-only mirror)
    <https://github.com/openvpn/gdbuspp/>         (code-only mirror)

    git tag: v1
    git commit: 7d80f553d64ec64790327b3e18b68f02448ca84c

---- Changes from v21 to v22_dev ---------------------------------------

David Sommerseth (324):
       ovpn3cli/admin: log-service lacked initial state and init
       ovpn3cli/admin: Add today/yesterday to journal --since
       codestyle: Use default lambda scope indentation
       processwatch: Remove the processwatch.hpp feature
       idlecheck: Remove IdleChecker implementation for GDBus++ refactoring
       build: Add bare meson build setup
       GDBus++: First step in migrating to the new D-Bus implementation
       GDBus++: Rework constants setup for OpenVPN 3 Linux
       GDBus++: Migrate the log/proxy-log.hpp implementation
       build: Add bare meson setup for generating man pages
       build: Install the base D-Bus policy
       build: Replace individual D-Bus auto-start service files with a template
       GDBus++: Migrate openvpn3-service-backendstart
       build: Add some log handling into the internal shared common library
       GDBus++: Migrate D-Bus proxy code for net.openvpn.v3.config
       client: Simplify StatusEvent() constructors
       build: Extend version extraction to include a few git flags
       build: Build and install SELinux policies via Meson
       GDBus++: Partial migration of netcfg code required to build VPN client backend
       common: Extend RequiresQueue with callback functionality
       GDBus++: Complete migration of StatusEvent()
       GDBus++: Kick out THROW_LOGEXCEPTION() macro
       GDBus++: GDBus++: Complete migration of LogEvent()
       GDBus++/LogSender: Use SignalDeclaration() methods setting up signals
       GDBus++/common: Improve RequiresQueue, avoid static_cast<>()
       GDBus++: First stab at migrating openvpn3-service-client
       build/selinux: Fix wrongly behaving SELinux build detection
       build: Fix issues with missing sd_id128 variable in meson
       build: Prepare the ground for building dco-keyconfig.proto
       GDBus++/common: Migrate PlatformInfo
       GDBUs++/sessionmgr: Initial migration of SessionManager::Event()
       GDBus++/netcfg: Initial migration of NetCfg:DNS::ResolverSettings()
       netcfg: Enforce smart-pointer usage for  NetCfg::DNS::ResolverSettings()
       GDBus++/netcfg: Extend NetCfgChangeType with GDBus++ glib2 helpers
       GDBus++: Migrate the unit tests
       client/log: Rewrite the Core library D-Bus log implementation
       client: Fix minor coding style issues in ConnectionStatDetails
       common: Refactor build-config.h inclusion in MachineID
       Avoid including build-config.h in header files
       GDBus++: Complete migration of NetCfg::DNS::SettingsManager
       common: Add missing sstream include file in configfileparser.hpp
       GDBus++: Migrated NetCfgSubscriptions
       client: Minor code cleanup in core-client.hpp
       GDBus++: Migrate NetCfgSignals
       GDBus++: Extend NetCfgProxy::Device with DCO support
       GDBus++/client: Fix dco and log_level property handling
       client: Remove pointless debug logging of the current run status
       client: Add debug logging when validate_sender() rejects a caller
       build: Use --prod-version as Meson project version
       build: Replace hard-coded -Werror with werror option
       client/core: Rename 'signal' object to 'signals'
       client/core: Reorder and fix #include file related challenges
       client/core: Relocate statistics.hpp include
       client/core: Clean up some #include hierarchy in core-client/core-client-netcfg
       build: Add libnl-3.0 as a dependency
       build: Add debug_internal build configuration flag
       client: Add BackendSignals::Create() static helper function
       log/proxy: Use DBus::Object::Path instead of std::string
       configmgr/proxy: Use DBus::Object::Path instead of std::string
       client: Use DBus::Object::Path in NetCfgTunBuilder::netcfg_get_device_path()
       client: Cleanup leftovers in NetCfgTunBuilder for ovpncli-netcfg
       client: Add debug logging when requesting NetCfg Cleanup()
       netcfg/proxy: Use DBus::Object::Path instead of std::string
       tests/netcfg: Migrate netcfg-changeevent-selftest to GDBus++/meson
       netcfg: Migrate NetCfgChangeEvent fully to GDBus++
       tests/netcfg: Migrate netcfg-proxy-unit to GDBus++/Meson
       tests/netcfg: List D-Bus paths if the "Re-fetching" fails
       core: Update to OpenVPN 3 Core Library v3.8.4
       netcfg/dns: Migrate NetCfg::DNS::resolved proxy to GDBus++
       netcfg/dns: Refactor the SettingsManager and ResolverBackendInterface
       netcfg/dns: Refactor NetCfg::DNS::ResolvConfFile
       netcfg/dns: Fix NetCfg::DNS::ResolverSettings::operator<<() behaviour
       netcfg/dns: Refactor NetCfg::DNS::SystemdResolved
       netcfg/build: Include NetCfgChangeType into the static netcfg library
       build: Move some netcfg components out of the static libnetcfg library
       GDBus++: Migrate openvpn3-service-netcfg (non-DCO)
       selinux: Allow openvpn3-service-netcfg to use syslog
       client: Fix incorrect empty session_path property
       client: Explicitly set the scope on a few Core library types
       netcfg/dns: Fix glib2 GVariant ref counting issues
       netcfg: Preserve a pointer to the LogWriter object in NetCfgDevice
       netcfg: Return the proper data type in DcoAvailable
       netcfg: GDBus++: Complete migration of openvpn3-service-netcfg
       vendor: Remove googletest as a git submodule
       netcfg: Check the results when preserving capabilities
       netcfg/dns: systemd-resolved SetDefaultRoute is a method
       netcfg/dns: Detect unsupported SetDefaultRoute feature in systemd-resolved
       sessionmgr: Replace GetIntrospection() with SessionManager::Event::SignalDeclaration()
       sessionmgr: Minor cleanups of SessionManager::Event
       log: Make the StatusChange signal optional in LogSender
       log: Make LogWriter::Ptr a std::shared_ptr
       netcfg: Use DBus::Object::Path in method_fetch_interface_list()
       client: Add AttentionReq class
       GDBus++/tests: Migrate signal-listener
       configmgr/proxy: Do an extra object existence check in ctor
       dbus: Add a GDBus++ DBus::Object extension - Object::ACL
       core: Update to OpenVPN 3 Core Library v3.8.5
       Provide operator<<() function for OpenVPN 3 Linux specific types
       log: Fix incorrect data type in LogProxy::ProxyLogEvents()
       python: Migrate openvpn3.constants generator to Meson
       sessionmgr: Remove not needed arg in SessionManager::Event::SignalDeclaration()
       build: Include dbus/path.cpp into the common static library
       sessionmgr: Adding SessionManager::NewTunnelQueue infrastructure
       sessionmgr: Add generic code for sending session and manager signals
       sessionmgr: GDBus++ migration of the openvpn3-service-sessionmgr
       Codestyle refresh of migrated code
       docs: Update openvpn3-service-sessionmgr man page
       docs: Update D-Bus documentation for net.openvpn.v3.sessions
       vendor: Upgrade ASIO to v1.30.2
       build: Relocate build-version.h for dist packaging
       build: Fix scripts/get-version, use proper path for build-version.h
       build: Generate and install openvpn3/constants.h
       netcfg/dns: Fix missing virtual destructor compiler warnings
       configmgr: Fix warnings about dangling references
       gdbus++: Simplified DBus::Service API
       tests: Extend request-queue-service with file logging
       tests: Add request-queue-test
       tests: Make PlatformInfo unit-test run without D-Bus
       tests: Add more Meson test cases
       tests: Classify already declared Meson test cases
       events: Relocate AttentionReq and StatusEvent
       events: Relocate LogEvent into Events::Log
       dbus: Codestyle cleanup in GDBusPP::Object::Extension::ACL
       dbus/signals: Refactor AttentionRequired and StatusChange signals
       sessionmgr: Cleanup in sessionmgr-events.hpp
       log: Refactor LogFilter to Log::EventFilter
       dbus/signals: Implement ::Signals::Log
       dbus: Clean up minor issues in DBusRequiresQueueProxy
       dbus: Extend DBusRequiresQueueProxy to allow proxy assignment later on
       sessionmgr: Migrate the Session Manager D-Bus proxy client to GDBus++
       dbus/signals: Implement Signals::ReceiveLog
       log: Clarify DBus::Signal::Group::Create() call destination
       signals/statuschange: Harden StatusChange::GetLastStatusChange() in empty cases
       client/backendstart: Rework how StatusChange signals are sent
       client: Rework how backend VPN client sends StatusChange/AttentionRequired
       client: Rework RegistrationRequest signal sending
       sessionmgr: Refactor out StatusChange calls via LogSender
       sessionmgr: Fix a few minor codestyle related issues
       log: Remove StatusChange signal handling from LogSender
       log: Remove classes and features which is no longer needed
       tests: Migrate logservice1 debug/test tool to GDBus++
       tests: Extend logservice1 with logtag settings support
       build: Refactor ENABLE_DEBUG macro in netcfg-dns-direct-file-selftest
       build: Remove debug_internal setting
       common: Add a '[DCO]' tag in get_version() string when DCO enabled
       build: Redo the ENABLE_OVPNDCO macro setup
       log: Clean up LogTag
       log: Extend Log::EventFilter with a smart-pointer creator
       log: Cleanup LogMetaData and LogMetaDataValue
       events: Extend Events::Log() to also carry signal sender details
       signals: Extend Signals::ReceiveLog() to pass signal sender details
       log: Simplify the LogWriter API slightly
       log: LogWriter::Write() implementations must check if metadata is valid
       log/proxy: LogServiceProxy::Detach() must wait for a reply
       log: Make more Log::EventFilter methods publicly available
       log: Improve misleading Log::EventFilter error message
       client: Signals sent should not change the D-Bus path
       client: Backendstarter can use a bit longer idle-exit
       sessionmgr: Improve retrieve sessions helper method
       dbus/signals: std::move() the callback lambda to the signal handler
       events/log: Extend Events::Log to carry a LogTag::Ptr
       log: Simplify LogWriter API - remove PrependMeta() + AddLogTag()
       log: Rework passing of LogTag to the LogWriter backend
       signals/statuschange: Implement Signals::ReceiveStatusChange
       sessionmgr: Disable log forwarding for sessions closing
       GDBus++/log: Migration of net.openvpn.v3.log / openvpn3-service-log
       sessionmgr: Add missing session_name property in Session objects
       log: Initialize logstream pointer properly
       docs: Create, build and install man pages
       log: Remove unused namespace in openvpn3-service-log.cpp
       build/tests: Build the cmdparser-test program
       common: Remove RCPtr from cmdargparser.[ch]pp
       common/cmdargparser: Pass std::string by reference
       common/cmdargparser: Replace typedef with using for consistency
       GDBus++/ovpn3cli: Start migration of openvpn3 and openvpn3-admin cli tools
       policy: Allow access to GetAll property method in backends and log services
       tests: Migrate dbus/get-service-version-prop to Meson and GDBus++
       GDBus++/ovpn3cli: Migrate 'openvpn3-admin version'
       build: Move DNS configuration code from netcfg service to netcfgmgr_lib
       GDBus++/ovpn3cli: Migrate 'openvpn3-admin init-config'
       log/journald: Add O3_LOG_SENDER meta data for log service
       log/journald: Update the journald log parser to new Events::Log location
       log/journald: Extend the journald parser to include the updated log service
       GDBus++/ovpn3cli: Migrate 'openvpn3-admin journal'
       sessionmgr/proxy: Add Session::GetConfigName()
       GDBus++/ovpn3cli: Migrate argument helper functions
       GDBus++/ovpn3cli: Migrate 'openvpn3-admin log-service'
       netcfg/proxy: Enforce NetCfgProxy::Manager to be a smart-pointer
       log: Add additional mutex around log subscription changes
       netcfg: Catch errors sending signals
       netcfg/dns: Preserve device name in systemd-resolved D-Bus proxy
       netcfg/dns: Retrieve values set in NetCfg::DNS::resolved::Link setters
       netcfg/dns-resolved: Implement sending NetworkChange DNS added/removed signals
       netcfg/dns: Provide device name when sending DNS_*_REMOVED signals
       netcfg: Fix incorrect signal subscription D-Bus API
       netcfg: Don't try to send NetworkChange signals without subscribers
       netcfg/NetworkChange: Implement crude subscription ownership tracking
       netcfg: Activate the missing NetworkChange subscription feature
       netcfg/proxy: Fix typo in D-Bus data type subscription retrival
       netcfg: Fix type inconsistency in NetCfgChangeType
       netcfg/proxy: Use DBus::Exception::GetRawError() instead of what()
       netcfg/proxy: Use synchronous call for NotificationUnsubscribe
       netcfg: Base NetCfg exceptions on DBus::Exception
       GDBus++/ovpn3cli: Migrate 'openvpn3-admin netcfg-service'
       sessionmgr/proxy: Don't call StartServiceByName() in the constructor
       build: Add workaround for tinyxml2 macro bug in OpenVPN 3 Core
       sessionmgr/proxy: Implement SessionManager::Proxy::Manager::Introspect()
       sessionmgr/proxy: Implement methods for a few Session object properties
       GDBus++/ovpn3cli: Migrate 'openvpn3-admin sessionmgr-service'
       sessionmgr: Remove superfluous check in helper_retrieve_sessions()
       utils: Add a global time_t to local date/time string converter
       configmgr/proxy: Extend the configmgr proxy with property getters
       GDBus++/ovpn3cli: Migrate 'openvpn3 configs-list'
       configmgr/proxy: Extend the configmgr proxy with CheckObjectExists()
       configmgr/proxy: Add helper code for using smart-pointers
       ovpn3cli/arghelpers: Add optional DBus::Connection to retrieve_config_path()
       GDBus++/ovpn3cli: Migrate 'openvpn3 config-manage'
       GDBus++/ovpn3cli: Migrate 'openvpn3 config-acl'
       GDBus++/ovpn3cli: Migrate 'openvpn3 config-dump'
       GDBus++/ovpn3cli: Migrate 'openvpn3 config-remove'
       GDBus++/ovpn3cli: Migrate 'openvpn3 config-import'
       configmgr/proxy: Improve error message on config object not found
       sessionmgr/proxy: Add GetConfigPath() method
       GDBus++/ovpn3cli: Migrate 'openvpn3 sessions-list'
       GDBus++/ovpn3cli: Migrate 'openvpn3 session-stats'
       sessionmgr/proxy: Add CheckSessionExists() method
       GDBus++/ovpn3cli: Migrate 'openvpn3 session-acl'
       client: Use StatusMinor::SESS_AUTH_URL for pending web authentications
       common/cmdargparser: Add missing #include <sstream>
       dbus: Improve object ownership GetUID/GetPID call error scenarios
       common: Add missing #include<string> in open-uri.hpp
       events: Fix typ0 in the Status method - Get/SetPrintMode
       log/proxy: Harden the LogProxy::Remove() method
       sessionmgr: Improve log_forwarders access across multiple threads
       configmgr/proxy: Update DBus::Proxy::Exception throw APIs
       sessionmgr: Session::method_ready() uses wrong exception string for parsing
       sessionmgr/proxy: Use *::List where possible for handling known std::vector<> types
       sessionmgr/proxy: Session::Ready() cannot use simple_call()
       sessionmgr/proxy: Session::GetLastStatus() should not return a const object
       GDBus++/ovpn3cli: Migrate 'openvpn3 session-auth'
       sessionmgr/proxy: Base SessionManager::Proxy::Exception on DBus::Exception
       ovpn3cli: retrieve_config_path() should return DBus::Object::Path
       sessionmgr/proxy: Provide all details when Proxy::Session::Ready() fallback throws
       configmgr/proxy: OpenVPN3ConfigurationProxy::Import() should return DBus::Object::Path
       ovpn3cli/GDBus++: Migrate 'openvpn3 session-start'
       ovpn3cli/session: Move statistics_plain() helper function to helpers.cpp
       ovpn3cli/GDBus++:  Migrate 'openvpn3 session-manage'
       sessionmgr: Don't wipe the log_forwarders map until we're done
       log/logwriter: Extend the API to handle Events::Status
       common/utils: Add is_colour_terminal() helper function
       tests/GDBus++: Migrate the logfwd-listener test program
       sessionmgr/proxy: Move local exceptions to SessionManager::Proxy::Exception
       ovpn3cli/GDBus++: Migrate 'openvpn3 log'
       ovpn3cli: Make main() provide argv[0] details in exceptions
       GDBus++: Remove left overs from the old DBus implementation
       policy: Be more generous with access to Ping methods
       sessionmgr/proxy: Add extra check at setup to check availability in Manager
       configmgr/proxy: Replace Ping in ctor with CheckObjectExists()
       ovpn3cli/log: Fix signal setup errors with fresh starts
       ovpn3cli/log: LogAttach::lookup_config_name() does not always need iterations
       build: Remove autoconf/automake build configuration
       docs: Update README and BUILD documentation
       codestyle: Do a complete reformat for consistency
       docs/man: The logger service is renamed - openvpn3-service-log
       docs: Update the renamed openvpn3-service-log in misc documentation
       src: Update to the renamed openvpn3-service-log in the sources
       docs/man: Generalize the generation and installation of man pages
       build: Move finding 'cp' from dco to main meson.build
       build: Install the Python code via Meson
       docs: Minor style cleanup in dbus-overview.md
       build: Install the distro/systemd files if systemd is enabled
       build: Remove the '-dev' extension to binaries
       build: Split out the openvpn3/ Python module to a separate meson.build
       build: Prepare and install bash-completion files when enabled
       build: Generate and install polkit and PolicyKit rules
       build: Install the persistent configurations directory
       build: Migrate profilemerge-optionlist test program to Meson
       tests: Build config JSON import/export test programs
       tests: Build open-uri-test
       common: Get rid of glib-unix.h from cmdargparser.hpp
       build: Reduce linking deps for test programs
       build: Don't build unit-tests unless enabled
       ovpn3cli: Fix failing shell-completion for 'openvpn3 log'
       configmgr: Adjust ACLs for Fetch/FetchJSON and public_access rights
       configmgr: Grant read access to more config object properties
       configmgr: Provide better user-error when Authorize() rejects access
       log: Don't duplicate Events::Log() prefix in the log writes
       ovpn3cli/log: Remove duplicated Events::Log details in log output
       configmgr/proxy: Add/Remove tag methods provided odd errors
       ovpn3cli/config-manage: Remove not needed details in errors from --tag and --remove-tag
       ovpn3cli/config-manage: Extract all profile before displaying it
       configmgr/proxy: Add method to retrieve the D-Bus path of the object
       ovpn3cli/config-acl: Add some air around the output and show D-Bus path
       ovpn3cli/config-manage: Add D-Bus path to --show
       configmgr: Fix properties via add_persistent_property() not working
       code style: Use BreakBeforeBinaryOperators: NonAssignment
       code style clean-up
       ovpn3cli/config-manage: Better message on profile objects not found
       ovpn3cli: Improve overall error extraction for the command line
       ovpn3cli/log: Improve error message when LogForward() call fails
       netcfg/proxy: Fix incorrect data type for Device::SetMtu()
       netcfg: Implement missing device object properties
       configmgr: Fix mixed up Log Attach() API usage
       sessionmgr: Generalize the check if the backend VPN proxy is valid
       sessionmgr: Remove the backend VPN proxy if session closing fails
       sessionmgr: Catch errors if DBus::Object::Manager::RemoveObject() fails
       sessionmgr: Fail Authorization() if VPN backend is dead
       configmgr/proxy: Calling CheckObjectExists() should not happen in ctor
       sessionmgr/proxy: Improve the SessionManager::Proxy::Manager setup
       configmgr: Ensure log service is available on config import
       configmgr: Improve error message to user on import errors
       client: Check vpnclient object exists in 'Ready' callback
       ovpn3cli/session-start: Improve stability starting sessions from file
       tests: Don't run config-override-selftest if Config Manager is inaccessible
       configmgr: Extend configuration objects with a Validate() D-Bus method
       ovpn3cli/session-start: Validate config profiles before starting a new VPN session
       python: Add config profile validation in openvpn2 and openvpn3-systemd
       ovpn3cli/config: Add profile validity check in config-manage and configs-list
       github: Add issue template - migration to codeberg.org
       configmgr/proxy: Add feature check for Validate method
       ovpn3cli/session-start: Always refresh feature set setting up configmgr proxy
       netcfg/proxy: Check non-response calls for nullptr before freeing
       client: Catch exceptions from NetCfgProxy::Device method calls
       netcfg: Return when no DNS resolver is configured in method_add_dns_search()

Frank Lichtenheld (1):
       build-selinux-policy: make sure to use bash

Razvan Cojocaru (4):
       GDBus++: Migrate openvpn3-service-configmgr
       build: Use version_compare(), not lexicographical comparisons
       Use get_option('sbindir') instead of hardcoded 'sbin'
       log/syslog: Don't assign NULL to const std::string& parameter

------------------------------------------------------------------------


