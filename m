Message-ID: <cab864a5-038a-449c-a231-e5f816bd23ab@...2108...>
Date: Wed, 4 Mar 2026 00:39:37 +0100
MIME-Version: 1.0
From: David Sommerseth <dazo+openvpn@...2108...>
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------8IJ0rk0Z7TudvV3wCiTglUL0"
Subject: [Openvpn-devel] OpenVPN 3 Linux v27 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>, openvpn-devel <Openvpn-devel@lists.sourceforge.net>, openvpn-announce@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------8IJ0rk0Z7TudvV3wCiTglUL0
Content-Type: multipart/mixed; boundary="------------y5gvZV95yvFzCJoRC3lJCeT0";
 protected-headers="v1"
From: David Sommerseth <dazo+openvpn@...2108...>
To: "openvpn-users@lists.sourceforge.net"
 <openvpn-users@lists.sourceforge.net>,
 openvpn-devel <Openvpn-devel@lists.sourceforge.net>,
 openvpn-announce@lists.sourceforge.net
Message-ID: <cab864a5-038a-449c-a231-e5f816bd23ab@...2108...>
Subject: OpenVPN 3 Linux v27 released

--------------y5gvZV95yvFzCJoRC3lJCeT0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

OpenVPN 3 Linux v27 (Stable release)

The v27 release is a bug fix release with a few enhancements.


* FEATURE DEPRECATION: openvpn3-autoload

  ** THIS IS THE LAST RELEASE SHIPPING THIS UTILITY - MIGRATE NOW **

  The openvpn3-autoload feature was deprecated already in the
  v20 release.  This feature will be removed in a coming stable
  release.

  The replacement is the openvpn3-session@...1685... systemd unit.
  Please see the openvpn3-systemd man page [1] for more details.

  If you depend on openvpn3-autoload today, please migrate ASAP
  to the systemd approach.

  [1] <https://codeberg.org/OpenVPN/openvpn3-linux/src/branch/master/docs/m=
an/openvpn3-systemd.8.rst>


* Bugfix: Use dynamic naming schema for ovpn-dco interfaces

  Prior releases would not be able to start an OpenVPN configuration
  profile if the --dev argument used the device name while there
  already existed a device with the same name.  This has been resolved
  and OpenVPN 3 Linux will now use a dynamic naming schema similar to
  what non-DCO configurations use, appending a digit at the end of
  the device name.


* Bugfix: Deny starting the same configuration more times in parallel

  Prior releases would allow users to start more VPN sessions using
  the same configuration profile.  This could easily cause issues
  where none of the VPN tunnels would work.

  The OpenVPN 3 Session Manager will now block a user from starting
  duplicated VPN sessions if it detects the configuration D-Bus path
  is already used in a session the user owns.

  The openvpn3-systemd unit helper has also been extended to check
  the configuration profile name given via the systemd unit name.


* Bugfix: systemd-resolved integration has been refactored

  When the OpenVPN 3 Network Configuration Service wanted to
  configure the DNS resolver settings, it used a unique D-Bus
  path to the virtual network device in the org.freedesktop.resolve1
  service.  Unfortunately, the systemd-resolved could be a bit slow
  at creating and making these D-Bus objects available, which could
  cause the OpenVPN session to not see the DNS settings in a timely
  manner.  In some cases, it could even completely fail and the
  VPN session was running without the proper DNS resolver configured.

  This release makes use of a different systemd-resolved D-Bus API
  which is more responsive and available before the needed D-Bus
  object has been created and made available.  This results in DNS
  resolver settings being configured with a much higher success rate
  than earlier.


* Bugfix: Fix CreateVirtualInterface timeout errors

  When starting a new VPN session, on some systems, especially when
  under load, the OpenVPN 3 Backend VPN Client process could end up
  not getting the new virtual interface created and the client
  connection would fail.

  In other scenarios, if the user would try to restart VPN sessions
  too quickly - especially with ovpn-dco interfaces, it could also
  trigger a similar behaviour and in some cases also result in a
  deadlock in the OpenVPN 3 Network Configuration Service, making
  it impossible to start new VPN sessions.

  The whole logic related to the CreateVirtualInterface call chains
  has been remodelled to be more much more robust and ensure the
  order of creation and destruction of virtual interfaces are tighter
  and clearer.
=20=20
=20=20
* Bugfix: Properly stop sessions which has been disconnected via --inactive

  The OpenVPN 3 Backend Client process and the Session Manager was
  lacking the logic to properly handle VPN sessions being automatically
  disconnected when session was considered inactive, configured via
  the --inactive option.

  In prior releases, the related openvpn3-service-client process would
  not stop and the OpenVPN 3 Session Manager would need to be
  explicitly told to disconnect the session, even though it was
  already stopped.

  This has been improved and the openvpn3-service-client process will
  now properly shutdown itself and the OpenVPN 3 Session Manager will
  register that the session has been stopped and mark the session as
  disconnected and closed.


* Bugfix: OpenVPN 3 Configuration Manager does not log persisted profiles

  When the OpenVPN 3 Configuration Manager starts, it will load all
  the persistent configuration profiles into memory.  But due to an
  incorrect log level handling internally, it would never respect the
  log level value when starting up.  This resulted in not logging all
  the imported persistent configuration profiles.


* Bugfix: OpenVPN 3 Configuration Manager did not transfer ownership

  When the net.openvpn.v3.configuration.TransferOwnership method was
  called on a configuration profile path, it would not do the transfer
  unless it was root who owned the profile.  This meant that only
  root could transfer profiles the root user imported and could not
  do any other transfers after that point.

  This release improves this by allowing root to always be able
  to transfer the ownership of any configuration profile paths
  to all users, regardless of who owns the profile.


* Bugfix: Avoid a file descriptor leak on tun interfaces

  When the VPN session was restarted or reconnecting with a full
  interface teardown, the openvpn3-service-client process would
  leak a file descriptor, which could end up in a crash if this
  happened too often.  It could also block the other openvpn3
  background service processes from operating as well in some
  cases.
=20=20

* Bugfix: System logs shows g_variant_new_object_path assertion errors

  When starting a new VPN session, this error would be found in the
  system logs (syslog, journald):
=20=20
    g_variant_new_object_path: assertion 'g_variant_is_object_path (object_=
path)' failed

  This has been fixed by avoiding replying with an invalid D-Bus path
  before the information with this path would be available.


* Enhancement: Log the process ID (pid) of the log event sender

  When the systemd-journald is configured to do the system logging,
  all log events have the _PID value of the openvpn3-service-log
  process.  This release adds an O3_SENDER_PID meta data field
  in the systemd-journal, representing the process ID of the process
  sending the log event.

  This is handy when there are system logs indicating issues
  with a process but only indicating the PID value.  The
  'openvpn3-admin journal' command has been extended with a --pid
  argument to filter only log events from this process ID.  Or
  the same can be done via 'journalctl O3_SENDER_PID=3D1234'.


* Enhancement: Add openvpn3-desktop-session-watcher

  This is a simple stand-alone utility for graphical desktop
  environments.  It will issue a desktop notification when new VPN
  sessions are started or the running status of the session changes.

  If the VPN session requires web-based authentication, the
  notification will also include the URL for the authentication which
  the user can click on to start the user authentication process.

  There is also a systemd unit file provided with this tool, to be
  used by the end-user.  See the openvpn3-desktop-session-watcher(1)
  man page for details how to enable this feature at login.


* Deprecated command removed: openvpn3 config-show

  This has bee an alias for openvpn3 config-dump since the v17_beta
  release.
=20=20

* OpenVPN 3 Core Library update

  The OpenVPN 3 Core Library has been updated to version 3.11.6
  providing a fix for the ovpn-dco interface name resolution when
  there is a name conflict.


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

  - There is a file descriptor leak with ovpn-dco interfaces when VPN
    session are restarted or a reconnect with a full interface
    teardown is needed.  This is noticeable in environments with
    unstable connections to the VPN server.  The current workaround
    is to not use DCO interfaces if this is an issue.


Supported Linux distributions
-----------------------------

  - Debian: 12, 13
  - Fedora: 42, 43
  - Red Hat Enterprise Linux 8, 9, 10[*]
  - Ubuntu: 22.04, 24.04, 25.05

Installation and getting started instructions can be found here:

  <https://community.openvpn.net/openvpn/wiki/OpenVPN3Linux>

The OpenVPN Inc. provided repositories will be updated in the coming
days.  The community provided repositories on Fedora Copr and
openSUSE Build Service are already published.

There are in addition other Linux distributions now providing
OpenVPN 3 Linux packages.  These distributions are primarily
supported by their respective distribution communities.  We will
naturally review and apply fixes deemed needed for any
distributions as they occur.

NOTE: Red Hat Enterprise Linux 10
  It is needed to use the 'rhel+epel-10-x86_64' chroot when running
  the 'dnf copr enable' command on RHEL-10.

      # dnf copr enable dsommers/openvpn3 rhel+epel-10-x86_64

  The stable repositories provided by OpenVPN Inc should not
  have this issue.


A few words on the git repositories
-----------------------------------

OpenVPN 3 Linux and GDBus++ has been pushed to three different
git hosting repositories.  The intention has been to have a reduntant
setup where those being very careful in pulling code can pull the
same code from more source trees, and they should all match.  If they
do not match, something unexpected has happened.

For a while now, Codeberg has been the primary repository, where
GitHub and GitLab has been code-mirrors only.  This will not change for
the time being.

With this release, another distributed approach is being tested out.
The Radicle network has been added as well, which is a distributed
git hosting.  This is a very different approach from the ones most
users knows quite well.  Radicle does not have a centralised server,
but all the repository data is distributed across a number of nodes
in the Radicle network.  For now, only the source code will pushed
to the Radicle network, as a code-mirror in parallel to GitLab and
GitHub.

For more details about Radicle: <https://radicle.xyz/>

Consider the Radicle repositories provided as experimental for the
time being.  We will spend some time getting to know Radicle better
before we decide how we will move forward with Radicle in the future.


--
kind regards,

David Sommerseth
OpenVPN Inc


---- Source tarballs ---------------------------------------------------
* OpenVPN 3 Linux v27

  <https://swupdate.openvpn.net/community/releases/openvpn3-linux-27.tar.xz>
  <https://swupdate.openvpn.net/community/releases/openvpn3-linux-27.tar.xz=
.asc>

* GDBus++ v3

  <https://swupdate.openvpn.net/community/releases/gdbuspp-3.tar.xz>
  <https://swupdate.openvpn.net/community/releases/gdbuspp-3.tar.xz.asc>

---- SHA256 Checksums --------------------------------------------------

d8c474032546bdd90b5b7f67e40c57b4b6030253f07bda7bb6ad0db84b9eed73  openvpn3-=
linux-27.tar.xz
c2da9a93a8db3555e640272f38b950702581ab219e87d62fc6797ee3f503224d  openvpn3-=
linux-27.tar.xz.asc
c7a053a13c4eb5811a542b747d5fcdb3a8e58a4a42c7237cc5e2e2ca72e0c94e  gdbuspp-3=
.tar.xz
b9cf732d7a347f324d6a5532dc48f80c2815dbf6704c169b4ee97a411506a99b  gdbuspp-3=
.tar.xz.asc

---- git references ----------------------------------------------------

git repositories:

 - OpenVPN 3 Linux
   <https://codeberg.org/OpenVPN/openvpn3-linux> (PRIMARY)
   <https://gitlab.com/openvpn/openvpn3-linux>   (code-only mirror)
   <https://github.com/OpenVPN/openvpn3-linux>   (code-only mirror)
=20=20=20
   rad:zN58oopqzrAkTregNZaRQpgg7x3c              (Radicle, code-only mirror)
   <https://app.radicle.xyz/nodes/iris.radicle.xyz/rad:zN58oopqzrAkTregNZaR=
Qpgg7x3c>

   git tag: v27
   git commit: f0c5ff798e38439ea2595c6edfe392010f82394e


 - GDBus++
   <https://codeberg.org/OpenVPN/gdbuspp/>       (PRIMARY)
   <https://gitlab.com/openvpn/gdbuspp/>         (code-only mirror)
   <https://github.com/openvpn/gdbuspp/>         (code-only mirror)

   rad:z2Tpg8xVSDgTpoU4Q5FN1aPGqf6mG             (Radicle, code-only mirror)
   <https://app.radicle.xyz/nodes/iris.radicle.xyz/rad:z2Tpg8xVSDgTpoU4Q5FN=
1aPGqf6mG>
=20=20=20
   git tag: v3
   git commit: 96f7fb688ed2dea3f192c63c5fe283dbe4900f16

---- Changes from v26 to v27 ---------------------------------------

David Sommerseth (89):
      deprecation: Remove openvpn3 config-show
      spelling: Fix a few minor misspellings of OpenVPN
      netcfg: Add missing throw keyword for exceptions
      netcfg: NetCfgOptions::str() should be a const method
      configmgr: Fix failing TransferOwnership() D-Bus method
      configmgr: Set the log level earlier in the program startup
      configmgr: Improve logging of imported persistent configuration profi=
les
      configmgr: Improve logging when configuration profile changes owner
      coverity: Remove std::move() where not needed
      coverity: Add missing initialization
      coverity: Fix "dead code" findings
      configmgr: Report errors when failing to delete profile file
      log/journal: Catch date/timestamp parsing errors
      netcfg/device: Use the object variable not ctor variable
      netcfg: Remove pointless check for logservice in main function
      sessionmgr: Catch exception in Session::GetDeviceName()
      tests: Ensure request-queue test iterations do not overflow
      sessionmgr: Improve exception handling in main()
      ovpn3cli/session: Improve session_start() helper sigaction implementa=
tion
      coverity: Use std::move() on quite some objects
      coverity: Fix incorrect std::string::find() usage
      log: Catch all exceptions in openvpn3-service-log main()
      client: Pass openvpn::ClientAPI::Config object as a ref to worker thr=
ead
      configmgr/proxy: Pass DBus::Object::Path as const refs
      common/requiresqueue: Refactor argument passing - const ref std::stri=
ng
      code cleanup: Use std::vector::emplace_back()
      code cleanup: Remove const from function returns
      code cleanup: Pass string objects as const ref
      code cleanup: Remove const flag from function arguments
      client: Use DBus::Object::Path for variables containing a D-Bus path
      client: Remove not needed virtual declaration on an override
      events: Remove const arugment declaraions in methods
      distro/systemd: Rework error handling in OpenVPN3systemd.__request_ha=
ndler()
      distro/systemd: Add a failsafe starting the same configuration more t=
imes
      events/status: Refactor Events::Status::PrintMode handling
      client: Refactor DBus::Connection::Ptr passing
      dbus/path: Code cleanup in generate_path_uuid()
      client: Improve arg/env buffer allocation logic
      common: Fix typ0 in terminal type detection
      distro/systemd: Make the status reporting prettier
      vendor: Upgrade to ASIO 1.36.0
      netcfg: Make the Cleanup() D-Bus method call async
      netcfg: Catch errors better when calling GetUID, GetPID and GetSubscr=
iptionOwner
      netcfg: Improve error handling in the Destroy() D-Bus method
      netcfg/resolved: Pass if_index into resolved::Link object
      netcfg/resolved: Refactor all log/debug functions to use fmt::format()
      netcfg/resolved: Extend Link::BackgroundCall() with error callback
      netcfg/resolved: Add missing lock_guard mutex in Link::Storage::NumEr=
rors()
      netcfg/resolved: Switch SetDefaultRoute() to use SetLinkDefaultRoute(=
) D-Bus method
      netcfg/resolved: Add Link::WaitForBackgroundTasks() method
      netcfg/resolved: Rework background_call_data implementation
      netcfg/resolved: Simplify the AsioWorkerClass implementation
      dbus: Add GDBus++ support function - LookupObject()
      dbus: Replace CheckObjectExists() with LookupObject()
      netcfg/dco: Replace ASIO worker/io_context implementation
      netcfg/proxy: Replace g_variant_new() with glib2::Builder
      netcfg/device: Make the CreateVirtualInterface() call more robust
      netcfg/proxy: Make Manager::getVirtualInterface() return std::shared_=
ptr
      client: Add more debug info in NetCfgTunBuilder::tun_builder_teardown=
()
      netcfg/dco: Refactor the DCO device teardown
      log/journald: Add O3_SENDER_PID as log event meta data
      ovpn3cli/journal: Add --pid argument to openvpn3-admin journal
      docs: Remove outdated information from openvpn3-admin-journal man page
      netcfg: Don't attach logging for net.openvpn.v3.netcfg.core
      ovpn3cli: Mark "object not found" errors as ExitReason::ABORTED in qu=
ery_user_input()
      sessionmgr: Extend SessionManager::Session with GetConfigPath()
      sessionmgr: Block starting duplicated sessions
      ovpn3cli/session proxy: Improve error messages sent to the command li=
ne user
      common/utils: Slight refactoring of version retrival functions
      common/utils: Move Doxygen comment for set_console_echo()
      tests: Remove log-listener2 test program
      netcfg/resolved: std::move() a arguments which can benefit from it
      client: Catch DBus::Exception as well in ~NetCfgTunBuilder()
      client: Log the D-Bus path to the NetCfg object on device creation
      netcfg/proxy: Fix incorrect DCO::SwapKeys() D-Bus argument
      client: Plug a file descriptor leak with virtual tun interfaces
      python: Add openvpn3-desktop-session-watcher
      tests/python: Add a simple example script for watching log/status cha=
nges
      configmgr: Add possibility for root to override Configuration::CheckA=
CL() check
      configmgr: Grant root access to TransferOwnership regardless of the c=
onfiguraiton profile ACL
      core: Update to OpenVPN 3 Core Library v3.11.6
      client: device_path property cannot be empty
      client: Check if client thread is joinable when disconnecting
      client: Use std::make_shared() when creating CoreVPNClient
      client: Properly assign main loop to signals in BackendClientObject
      client: Properly signal connection is done in inactivity timeout
      dbus/signals: Add callback hook to Signals::StatusChange
      events/status: Extend Status::Check() to also check multiple StatusMi=
nor codes
      sessionmgr: Act upon StatusChange signals from backend client

--------------------------------------------------------------------

--------------y5gvZV95yvFzCJoRC3lJCeT0--

--------------8IJ0rk0Z7TudvV3wCiTglUL0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmmncTkACgkQhs+UTJZx
/fLqlQ/+K7KZ7oiJ9KZuS4Nccqbbi90L6qlGuJuppdgY2rn82p3+/73G2bfuMbW/
T7KyvIStAETY5673vtAxlux64TgATtFRd8xDJkGJFHyUMUZC/VBDQ+uPyLiusckp
gKEGm640FnHQDdAyHSxRP1SDF8flbfAbjYCkDCY1H4vgADAgHQj3/B4owpklV+69
uH2XUyKAyYlkg9p14PS+fJPudzafr5YW66EboUOp7kz+A31rBu+uVaLAC+tj803E
Lu11MwMXA9E4aksgSLx5wKI3zjTvIoHb33JCn9FzxSbPzMUhPLwnHUFWvBuaSCl3
o7522sKm6iM9wXr9/mnf67zHawMlnBZpChnkmPoq9GFzHD+rORLH3GQBR9rxIM8I
ECsJ4AjK/LmsCEjFsvx0n5qcyVMJyOourYB1B+S/tSwhc2LGgO4VWWxOxH2OAbI6
8nd161MPMcB0m0F/LYqOfX8gWWu9GggZ/ZP+J+m523IyRciSCtNcl/XkiU/8MyuP
495JZavEUo9PSDTzlaD/hitcD2H4tmIaKhPcQHEoEGMCI4Tizsvdt2XpwKOiO4nY
1XfXuOTrN7yRDJt9Lj9XNAd8zjNHGdRVHA3OYq6vs0U+Upa3148kVYlrBYRPeRHH
j+5qz4V5/PRQwsunAlI1HsNJx8yGDA/OsBAkQflMIC29T9Mshxc=
=t6az
-----END PGP SIGNATURE-----

--------------8IJ0rk0Z7TudvV3wCiTglUL0--

