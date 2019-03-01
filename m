From: David Sommerseth <openvpn@...2080...>
Message-ID: <880fc97a-7e16-e17c-c049-e757cdc680c3@...2080...>
Date: Fri, 1 Mar 2019 22:00:44 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="yJNrZpQ3TYsyW3npXvXjVaXQNObVEEXJF"
Subject: [Openvpn-devel] OpenVPN 3 Linux client - v4 beta released
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
--yJNrZpQ3TYsyW3npXvXjVaXQNObVEEXJF
Content-Type: multipart/mixed; boundary="UoY38Z7EJBGXUb08thjtaaaMihBT5565H";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>,
 OpenVPN Users <Openvpn-users@lists.sourceforge.net>
Message-ID: <880fc97a-7e16-e17c-c049-e757cdc680c3@...2080...>
Subject: OpenVPN 3 Linux client - v4 beta released

--UoY38Z7EJBGXUb08thjtaaaMihBT5565H
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hi,

We are have just released OpenVPN 3 Linux v4 (beta).  his is available in
our git repositories [0] and URLs for source tarballs are listed later in t=
his
e-mail.  RPM binaries for Fedora and RHEL/CentOS/Scientific Linux [1]
completed the build process quite recently too.  Debian and Ubuntu packages
will come in releases not that far away.

The highlights of this release includes:

  # Persistent configuration storage
    Configuration profiles are stored in a configuration manager service.
    This is to have enable a better privilege separation and avoid access
    restrictions across various processes.  Until now the configuration
    manager kept configurations in memory only and to have some kind of
    persistence, you would need to use the openvpn3-autoload feature.

    With this release, configuration profiles imported with --persistent
    will make the configuration manager save the profile to disk as well,
    under a directory it has access too.  The configuration manager must
    be started with --state-dir /path/to/config/storage to enable this
    feature.  This is by default set to /var/lib/openvpn3/configs.

    Any modifications done to persistent configuration profiles via
    'openvpn3 config-acl' or 'openvpn3 config-manage' after the import
    will also be preserved.

  # Build with OpenSSL
    Until now OpenVPN 3 Linux did only support building against mbed TLS.
    This release adds the --with-crypto-library argument to ./configure.  W=
hen
    set to 'openssl', it will change from the default (mbedtls).

    At the moment OpenSSL 1.1 is NOT supported.  This is related to changes
    required in the OpenVPN 3 Core library, and this work is in progress.

  # All 'openvpn3 config-*' and 'openvpn3 session-*' commands also provides
    --config-path or --session-path as an alias to --path.

  # Most 'openvpn3 config-*' commands do now also support using --config
    as an alternative to --path/--config-path, where the configuration prof=
ile
    name is used instead of the D-Bus based configuration path.

In addition to the customary bug fixes and other improvements.



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

For more information see the various man-pages available [2].


* Install Fedora Copr packages for Fedora, RHEL, CentOS and Scientific Linux

Ensure you have the yum-plugin-copr or dnf copr plugin installed.  For
RHEL/CentOS/Scientific Linux you will also need to have the Fedora EPEL
repository enabled [3].  Then run the following commands:

For yum users:

   $ yum copr enable dsommers/openvpn3
   $ yum install openvpn3-client

or for dnf users:

   $ dnf copr enable dsommers/openvpn3
   $ dnf install openvpn3-client



[0] <https://gitlab.com/openvpn/openvpn3-linux>
    <https://github.com/OpenVPN/openvpn3-linux>

[1] <https://copr.fedorainfracloud.org/coprs/dsommers/openvpn3/>
[2] <https://github.com/OpenVPN/openvpn3-linux/tree/master/docs/man/>
[3] <https://fedoraproject.org/wiki/EPEL>



---- Source tarballs ----------------------------------------------------
* OpenVPN 3 Linux v3 beta
  <http://swupdate.openvpn.net/community/releases/openvpn3-linux-4_beta.tar=
.xz>
  <http://swupdate.openvpn.net/community/releases/openvpn3-linux-4_beta.tar=
.xz.asc>

---- SHA 256 Checksums --------------------------------------------------
db73cdcd1f9a77f181f5b73f3f2be045b5a6b224bced426fa443e6be0db89962  openvpn3-=
linux-4_beta.tar.xz
2f5f359a7eb42c92af4dfcb94ca1e186faab26f14e40d2998499dc78a9e42cac  openvpn3-=
linux-4_beta.tar.xz.asc

---- git references -----------------------------------------------------
git tag: v4_beta
git commit: d2fef7e83b46da8b4d9c3d417c8e3f7aa7aecae6

---- Changes from v3 to v4 ----------------------------------------------
Arne Schwabe (2):
      build: Allow GIT_CHECKOUT also to work with submodules and out of dir=
 git repos
      contrib: Add Jenkins build file

David Sommerseth (49):
      exceptions: Clean up, simplify and unify
      python: Fix missing return in autoload_main()
      python: Fix PEP-8 complains in openvpn2
      log: Extend LogConsumerProxy::InterceptLogEvent() with error handling
      sessionmgr: Filter out LogEvents not related to its own session
      sessionmgr: Add filtering on StatusChange when proxying
      client: Enable compile time session manager check disabling
      client: Fix crash when dynamic challenge auth is required
      build: Enforce wiping config-version.h when updating version.m4
      configmgr: Remove support for aliases
      dbus: Make GetObjectId() and GetObjectPath() methods const
      dbus: Make GetPublicAccess() and GetAccessList() return native C++ ty=
pes
      dbus/proxy: Declare proxy methods not changing the object const
      dbus/connection: Make truly const methods const
      dbus/creds: Make getter methods const
      configmgr/json: Clean up OptionListJSON class
      configmgr: Implement infrastructure for --state-dir
      configmgr: Save persistent configurations to state directory
      configmgr: Fix issue when sender UID cannot be retrieved in Fetch()
      configmgr: Split out the ConfigurationObject init
      configmgr: Split up set_override() to take native C++ types
      configmgr: Split out the config object registration
      configmgr: Add ConfigurationObject ctor for saved profiles
      configmgr: Rework ProfileMergeJSON to use Json::Value
      configmgr: Add private method for importing persistent configs
      configmgr: Load all persistent configurations when setting state dir
      python: Implement support for overrides
      dbus/proxy: Add retry logic in DBusProxy::CheckObjectExists()
      ovpn3cli: Be graceful to configmgr if it needs to start
      ovpn3cli/session: Fix missing spaces
      configmgr/docs: Misc updates to the service documentation
      dbus/proxy: Fix incorrect retry-loop check
      build: Implement possibility to support builds against different SSL/=
TLS libraries
      build: Enable building against OpenSSL
      build: Be stricter about what a version tag is
      Update to latest OpenVPN 3 Core library
      common: Prepare SingleCommandOption to handle alias arguments
      common: Extend SingleCommandOption with alias support
      common: Provide access to SingleCommandOptions via SingleCommand::Add=
Option()
      ovpn3cli: Add config/session path alias options
      ovpn3cli: Move config path from config name retrieval
      ovpn3cli/config: Extend with support for --config
      ovpn3cli/log: Add support for --config
      dbus: Extended GLibUtils with ExtractValue()
      configmgr: Replace g_variant_get() in ConfiguruationObject contructor
      core: Fix OptionListJSON::json_export() option truncation
      policy: Grant all users Ping priviege to netcfg service
      docs: Update README
      docs: man page maintenance

Lev Stipakov (3):
      python: Fix several PEP-8 related coding style issues
      common: fix incorrect iterator type in ProfileMergeJSON
      contrib: update CMakeLists.txt
-------------------------------------------------------------------------

--=20
kind regards,

David Sommerseth
OpenVPN Inc



--UoY38Z7EJBGXUb08thjtaaaMihBT5565H--

--yJNrZpQ3TYsyW3npXvXjVaXQNObVEEXJF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJceZ19AAoJEIbPlEyWcf3y7g4QAMTElQMiHGM9JzJnDJ8PKoFl
yhbW+tKOos6xCHLLlkk2UMbojP2FZXJ/CzeoJDeWEzBTnjvow+yJYArtnsisaADc
s2Ol1VFta9VsGo8ebe7xJWeeKOdeBvI7WnBparnOADOt3M5QDssjJuaUxPbtXyUo
a6qeEFriZnlufpcjjcZdbkxyogUFM7ufISGAy1Bgu+Zr9nMn7XgRPXp9C7th7kR/
9pimkr+Obf4MjYp+7DVAo+jCcgaiGyQimOI/AMNeqnkEeHaFP7BeHzX09Ai6C2Ci
51BaPlZzi1C/jKEsvDSIAXphegf3Ml4dbVk+t14d3zgL7b0D5/sr7unEx01ta5yZ
gHDsqcLFL2KRzW2T/MhtLLlARFLQ/visYin6YoZQX3ReL+mXD2gPPBBqajYFLRDo
x9QZ3+KyGrXvR1spUbfybUGP2ikT1LXEgaHnhcp1xbQqVsoi20qkA9wiWw6G2i0H
1DcwWWYkCBrkX/ZV7RLydtCoQIB6mYLQQDg6smE5polU1mOsCEl4Y3rfte0Vb//s
E9u5Y/mpkNmyJgKdFrZFEvsPQcRfEIW4TkwsWCzbiQUhDYkSm33KxXN9fFEB7JzW
2KZimStT7iOrKs7jqIX0Rm2Wp1Lb/6Lt7G14oJlVMfsc8Ly8e1d66ZUHPxFs51n6
dtIf7SX/f2hgqmTmUbRB
=Syjh
-----END PGP SIGNATURE-----

--yJNrZpQ3TYsyW3npXvXjVaXQNObVEEXJF--

