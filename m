Reply-To: openvpn-devel@lists.sourceforge.net
From: David Sommerseth <openvpn@...2080...>
Message-ID: <c049b10f-0fdb-ccae-d6cb-1456fda4f5d1@...2080...>
Date: Thu, 8 Jul 2021 21:52:47 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TwBaqKN9VsheGKIFddAH2MlkVSL8F3akm"
Subject: [Openvpn-devel] OpenVPN 3 Linux client - v14 beta released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TwBaqKN9VsheGKIFddAH2MlkVSL8F3akm
Content-Type: multipart/mixed; boundary="3jLQxLmvWiQtgkQAYmu7y9gwK5iXWwICs";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: openvpn-devel@lists.sourceforge.net
Message-ID: <c049b10f-0fdb-ccae-d6cb-1456fda4f5d1@...2080...>
Subject: OpenVPN 3 Linux client - v14 beta released

--3jLQxLmvWiQtgkQAYmu7y9gwK5iXWwICs
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

The OpenVPN 3 Linux v14 beta is now available.

The highlights of this release includes:

* Security: [CVE-2021-3547] --verify-x509-name overrides certificate
   checks

   The OpenVPN 3 Core library got support for --verify-x509-name in
   commit 583986920236f7e (committed 2019-11-08).  This implementation
   would reset prior certificate checks. If a prior certificate check
   failed and the --verify-x509-name check passed, the connection would
   be accepted as valid.  This has been fixed in the Core library as
   of OpenVPN 3 Core library commit febf01ef68b84f.

* systemd-resolved - support for DNS scopes

   This is the first step towards a better split-DNS support.  It
   implements the needed configuration settings to properly set up the
   global or tunnel DNS resolver scopes in systemd-resolved.  For the
   resolv-conf based mode, this setting will be ignored (and logged as a
   warning) as resolv-conf only supports a single DNS resolver.

   Currently, the tunnel scope is very simplistic and will only result in
   systemd-resolved not querying anything than pushed DOMAIN/DOMAIN-
   SEARCH domains via the DNS servers for the VPN session.  It is more a
   reverse filter, than an explicit filter.  All other "global" scopes
   will also be queried.  Domains *not* matching the DOMAIN/DOMAIN-SEARCH
   settings will be *not* queried via this VPN link.

   This behaviour is more how systemd-resolved is designed and this
   behaviour will hopefully be further improved later on.

   DNS scopes are configured via 'openvpn3 config-manage' on a pre-
   imported configuration file.

* Improved SELinux policies

   OpenVPN 3 Linux is now able to be run on CentOS, Fedora and Red Hat
   Enterprise Linux with DCO enabled on VPN profiles and with SELinux
   policies being enforced.  The openvpn3-service-netcfg and
   openvpn3-service-client processes will now run in their own confined
   environment with further restricted access.

* The OpenVPN 3 client will report IV_HWADDR

   When connecting, the client will report back some peer information to
   the server.  Until now, the IV_HWADDR has not been provided.  This
   value is supposed to be a fixed value per connecting host.  The
   reported information is a SHA256 hash of /etc/machine-id and some
   more OpenVPN 3 Linux specific values.  If this machine-id file is not
   readable, it will generate its own value and store it under
   /var/lib/openvpn3 for a persistent value.

* Support for querying the user for HTTP proxy credentials during
   connection

* Support for inline --http-user-pass values in configuration files

* Support for inline --auth-user-pass values in configuration files

* DCO support can now be activated with openvpn3 session-start and
   openvpn2 command line front-ends

* DCO device names will now carry the name of --dev in the configuration

In addition to several bug fixes and other improvements.


Supported Linux distributions:

   - Debian 9, 10 (amd64, arm64)
   - CentOS 7 (x86_64)
   - CentOS 8 (x86_64, aarch64)
   - Fedora 33, 34 and Rawhide (x86_64, aarch64, s390x)
   - Red Hat Enterprise Linux 7 (x86_64)
   - Red Hat Enterprise Linux 8 (x86_64, aarch64)
   - Ubuntu 16.04 (amd64)
   - Ubuntu 18.04, 20.04, 20.10 and 21.04 (amd64, arm64)

The arm64 support on selected Debian and Ubuntu releases are currently
considered a tech-preview.


The Data Channel Offload (DCO) tech-preview feature is supported in
these distributions:

   - CentOS 8
   - Fedora 33, 34 and Rawhide
   - Ubuntu 20.04, 20.10 and 21.04
   - Red Hat Enterprise Linux 8

If you have already installed the kmod-ovpn-dco package from our
repositories, remember to also update this package when upgrading
OpenVPN 3 Linux.

Instructions how to install OpenVPN 3 Linux can be found here:
<https://community.openvpn.net/openvpn/wiki/OpenVPN3Linux>


--=20
kind regards,

David Sommerseth
OpenVPN Inc


---- Source tarballs ---------------------------------------------------
* OpenVPN 3 Linux v14 beta

   <https://swupdate.openvpn.net/community/releases/openvpn3-linux-14_beta.=
tar.xz>
   <https://swupdate.openvpn.net/community/releases/openvpn3-linux-14_beta.=
tar.xz.asc>

---- SHA256 Checksums --------------------------------------------------

211ec3d46398f36e2fae18f736fd4a47315f9ae574fc4150fea256e131850ccd  openvpn3-=
linux-14_beta.tar.xz
5e6c1e6d86ef3f6a2be9567f67812732d119fdec9265420a532bd864576cca0a  openvpn3-=
linux-14_beta.tar.xz.asc

---- git references ----------------------------------------------------

git repositories:
     <https://gitlab.com/openvpn/openvpn3-linux>
     <https://github.com/OpenVPN/openvpn3-linux>

git tag: v14_beta
git commit: 6ae8c77ffcfcdbe594dfc5a524a741726d9247d0

---- Changes from v13 to v14 -------------------------------------------

Antonio Quartulli (1):
       ovpn-dco: adapt interfaces to new API format

Arne Schwabe (1):
       Add Coverity to jenkins build

David Sommerseth (67):
       build: Fix out-of-tree builds from git checkouts
       dbus/signals: Kick out the poor char */std::string "converters"
       netcfg: Fix incorrect return string in
           DNS::ResolverSettings::AddNameServers()
       log: Fix incorrect unsigned int logic
       log: Clean-up a switch statement
       client: Add exception safe-guard in BackendClientDBus d'tor
       netcfg: Fix incorrect IPv6 default gw setup
       submodules: Update OpenVPN 3 Core and ovpn-dco
       glib: Improve error message when GLibUtils::checkParams() fails
       configmgr: Prepare for --dns-scope in configuration profiles
       netcfg: Implement DNS resolver scope support
       client: Propagate VPN profile dns-scope setting to netcfg
       python: Add support for dns-scope setting via openvpn3-autoload
       client: Delay the forced shutdown on LogFATAL()
       client: Add ClientException to start improving client error
           handling
       cli: Be more friendly with ERR_PROFILE_SERVER_LOCKED_UNSUPPORTED
       tests/signal_listener: Add support for Log() with session tokens
       client: Enable DCO configuration override via D-Bus property
       sessionmgr: Provide access to the DCO flag in a VPN session
       docs/sessions: Update net.openvpn.v3.sessions D-Bus documentation
       docs/client: Update net.openvpn.v3.backends.be* D-Bus
           documentation
       ovpn3cli: Add --dco support to session-start
       python: Extend SessionManager.Session with DCO capabilities
       python: Extend ConfigParser with DCO support
       python/openvpn2: Add support for enabling/disabling DCO
       python/openvpn2: Fix stray verb debug print()
       ovpn3cli/session: Display an indicator on DCO enabled sessions
       Revert "configmgr: Add DCO device naming hack"
       ovpn3cli/session-start: Fix incorrect console input truncation
       dco: Update to latest ovpn-dco
       vendor: Update to ASIO 1.18.1
       core-ext: Fix improper processing of potential inline options
       selinux: Add policies for netcfg and client processes
       selinux: Rework the policy build Makefile
       build: Make netcfg DNS resolver configurable
       build: Detect Linux distro to configure DNS resolver
       build: Fix missing distribution of SELinux policy files
       python: Fix incorrect JSON parsing error message (filename)
       netcfg: Add method to extract only error message in
           NetCfgProxyException
       netcfg/proxy: Try to ensure net.openvpn.v3.netcfg is available
       cli: Properly catch if net.openvpn.v3.netcfg is unavailable
       configfile: Add "true" as a valid "present" value
       build: Save the OpenVPN 3 statedir into config.h
       common: Implement MachineID for uniquely identifying a host
       client: Implement passing IV_HWADDR
       vendor: Update to ASIO 1.18.2
       dco: Update to latest ovpn-dco
       core: Update to latest OpenVPN 3 Core library
       common: Add missing sstream include in machineid.cpp
       common,core: Fix compat issues with older OpenSSL
       common: Use proper OpenSSL EVP SHA256 APIs in MachineID related
           code
       netcfg: Only LogCritical when DNS resolver changes failed
       client: Properly handle device disabling exceptions
       selinux: Add missing file context transition for resolv.conf
       client: Improve error handling when interacting with the NetCfg
           service
       netcfg: Disable DNS::ResolverSettings for failing resolved updates
       netcfg/resolved: Catch more error situations
       client/core: Fix incorrect bool logic for TUN_SETUP/TUN_IFACE
           events
       client/core: Improve fatal exception handling in event()
       netcfg: Use the proper capng_select_t when dropping capabilities
       dbus: Extend DBusProxy with GetNameOwner() method
       dbus: Extend DBusProxy with StartServiceByName() method
       netcfg/resolved: Check if org.freedesktop.PolicyKit1 is available
       docs: Update README with polkit/policykit dependency requirement
       netcfg: Catch exceptions related to SystemdResolved init issues
       netcfg: Catch more exceptions when establishing a virtual
           interface
       selinux: Fix proper privileges for netcfg netlink_generic_socket

Heiko Hund (4):
       update .gitignore
       core-extension: Add support for inline auth-user-pass
       core-extension: Add support for inline http-proxy-user-pass
       client: Allow querying HTTP proxy credentials dynamically

Romain Loutrel (1):
       python: Add --mute, --route-delay and --route-method to ignored
           options

-------------------------------------------------------------------------



--3jLQxLmvWiQtgkQAYmu7y9gwK5iXWwICs--

--TwBaqKN9VsheGKIFddAH2MlkVSL8F3akm
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmDnV5AACgkQhs+UTJZx
/fKrJg//aoYRC1QYz42Oe+ub5HVHqDGXKiQVzcrT3uCO8a7w5q3EjuqfwN5KNAM+
76h2VHtw6+U8w29OvBdK+ahH3Kivq2GddDHUs4x1bC9sG4C1exZte5pwEBJGDp8z
NdYsklVSci7BbonoNbi42wgZqWkQ3StnxuUdost6MAjRjUAyF/jTe6NO4x/ozfA0
LpBX2M8slybd6HACEWwAj909+lBOCqJpwQ34oO5xJXkPbXwKjNENZlZI5ObJxESC
XG2F4s3F5zcPw6SPG/SiXArDW0FapYCY9nIlctv5NfSUhkRPCCzmF5Guew5ykw3H
s7pDADdhCKpdyLPvd3AF1NJwauQLHEEuKBHyP37L8RkuYnUHyXJVckaieX9UJ6U7
g/KKfPrj4BZDLRBFiZ+2tiumIbmZzuiZrlgNd5uT0jfcmJ1oXroCP1YCB5C76jVb
754NtdIXH9U0VjN6B0gLUMf2EypnyvKEErSl1T3AsdQwHczbvdQdqtjccVcl5tb4
cYAhuDkh+oYEDJraUc0Lkv+srw0hTydmB0BYyghZm5nom3rKv8eETbUGsuLluUti
MnKwddzc7mEPYt4XV7ka13V+lE1JnlrF3TtmqxSjFqt8gu8Vm6KsWmTpgL8unU0C
9M3a1TlVz78Dcu8/mm6rnkA1pz4TuB+X3GWupf0tInDGa34VklA=
=OhB+
-----END PGP SIGNATURE-----

--TwBaqKN9VsheGKIFddAH2MlkVSL8F3akm--

