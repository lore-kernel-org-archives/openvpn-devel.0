From: David Sommerseth <openvpn@...2080...>
Message-ID: <ed56b8ea-00b7-eac2-7ab7-9bf9f21c838a@...2080...>
Date: Mon, 2 Nov 2020 14:30:56 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="WR43zHJrl8dVlJjMK5GnKV1USRCswbX0V"
Subject: [Openvpn-devel] OpenVPN 3 Linux client - v11 beta released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WR43zHJrl8dVlJjMK5GnKV1USRCswbX0V
Content-Type: multipart/mixed; boundary="P493Tu8GMibJ0aCdQqcWguLEOLVoeq0A3";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net
Message-ID: <ed56b8ea-00b7-eac2-7ab7-9bf9f21c838a@...2080...>
Subject: OpenVPN 3 Linux client - v11 beta released

--P493Tu8GMibJ0aCdQqcWguLEOLVoeq0A3
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

The OpenVPN 3 Linux v11 beta is now released.

This is available in our git repositories [0] and URLs for source tarballs
are listed later in this e-mail.  We have pre-built binaries for the
following Linux distributions:

    * Fedora 31, 32, 33 and Rawhide (via Fedora Copr: x86_64, aarch64, s390=
x)
    * RHEL/CentOS 7 and 8           (via Fedora Copr: x86_64, aarch64)
    * Debian 9 and 10               (amd64)
    * Ubuntu 16.04, 18.04, 19.10 and 20.04 (amd64)

A quick-start guide for OpenVPN 3 Linux can be found here:

    <https://community.openvpn.net/openvpn/wiki/OpenVPN3Linux>


The highlights of this release includes:

* Feature: OpenVPN Data Channel Off-load (DCO)

  This features is currently a tech-preview feature.  It is not
  targeted for production usage in its current shape.  As this is
  still under heavy development, we currently only support the latest
  Fedora releases (Fedora 32 and newer) and Ubuntu 20.04.  This
  currently requires Linux kernel 5.4 and newer.

  This facilitates a brand new kernel module, ovpn-dco, where all the
  crypto operations related to the OpenVPN data channel happens directly
  inside the kernel.  The data channel operations are related to the
  tunnelled network traffic.  This has the advantage of being able to
  reduce the network packet processing overhead compared to the
  traditional tun devices.

  When using the tun interfaces with OpenVPN, the remote side sends
  encrypted network traffic to a UDP or TCP socket.  The Linux kernel
  forwards these packets from kernel space to the OpenVPN user space
  process, which decrypts the packet and extracts the unencrypted
  network traffic.  This unencrypted data is then passed to a tun
  interface, which sends the traffic back to the kernel space for
  further processing.

  The ovpn-dco module changes this packet route.  When the remote
  side sends data channel packets, the ovpn-dco kernel module will
  receive the packet and will have the encryption keys needed to
  decrypt the packet directly in the kernel space and then pass it
  directly to the virtual interface ovpn-dco manages.  If the OpenVPN
  packet from the remote side is a control channel packet, the ovpn-dco
  kernel module will pass this traffic up to the OpenVPN user space
  process.  Control channel packets are used to pass authentication
  credentials, configuration setup, data channel key exchanges, etc.

  To make use of this feature, the kmod-ovpn-dco kernel module must be
  installed on the system.  The OpenVPN 3 Linux project provides
  kmod-ovpn-dco packages for Fedora 32, 33 and Rawhide in addition
  to Ubuntu 20.04.

  On Fedora, with the openvpn3 Copr repository enabled:

      # yum install kmod-ovpn-dco

  On Ubuntu, with the openvpn3 apt repository configured:

      # apt install kmod-ovpn-dco

  With the kernel module installed, the configuration file must be
  be imported:

      $ openvpn3 config-import --config CONFIG_FILENAME \
                     --name CFGNAME \
                     --persistent

  Then the imported configuration profile must get the DCO feature
  enabled:

      $ openvpn3 config-manage --show --name CFGNAME --dco true

  To preserve this setting through reboots, --persistent was added
  when importing the configuration file via 'openvpn3 config-import'.

  Now everything is ready and a VPN session can be started:

      $ openvpn3 session-start --config CFGNAME

  The ovpn-dco kernel module from the openvpn3 repositories has some
  limitations:

  - No TCP support
    ovpn-dco will require a UDP connection to the server.

  - No IPv6 support
    ovpn-dco does only support IPv4 for the connection
    to the remote server.

  - Limited data channel cipher support
    ovpn-dco only supports the AES-GCM ciphers.  Support for
    more ciphers will arrive later.

  - No interface statistics available
    The ovpn-dco module has not yet implemented traffic statistics.

  These limitations will be resolved in future releases.  A more
  comprehensive list of what ovpn-dco is working on and will support can
  be found in the ovpn-dco project.

  WARNING:
      The ovpn-dco kernel module is under heavy development.
      This means that the API used between the kernel space
      and OpenVPN user space processes may change.  Therefore
      the kernel module version must be the same which
      OpenVPN 3 Linux has been compiled against.  Once
      the API is has become stable, this restriction will no
      longer be needed.

* Bugfix: OpenVPN 3 Linux configuration manager could crash
  If an imported persistent configuration file would contain syntax
  errors, the openvpn3-service-configmgr process could crash (SEGV).
  This has been improved and the configuration manager will now ignore
  incorrect or corrupted persistent configuration files.

* Bugfix: openvpn3 and openvpn3-admin could sometimes crash
  Occasionally on certain hosts, the 'openvpn3' and 'openvpn3-admin'
  tools could crash unexpectedly.  This was an error related to the
  argument alias processing and has been fixed to avoid this issue.

* Enhancements: The openvpn2 bash-completion support is extended
  In prior versions, the openvpn2 command did not provide any shell
  completion help to the --config option.  This has been resolved.

* OpenVPN Access Server configuration import improvements
  The 'openvpn3-as' utility now signals to the Access Server the
  downloaded configuration profile is intended to be imported into
  a local storage.

--=20
kind regards,

David Sommerseth
OpenVPN Inc


[0] <https://gitlab.com/openvpn/openvpn3-linux>
    <https://github.com/OpenVPN/openvpn3-linux>

---- Source tarballs ----------------------------------------------------
* OpenVPN 3 Linux v11 beta

  <https://swupdate.openvpn.net/community/releases/openvpn3-linux-11_beta.t=
ar.xz>
  <https://swupdate.openvpn.net/community/releases/openvpn3-linux-11_beta.t=
ar.xz.asc>

---- SHA256 Checksums ---------------------------------------------------

1207fa09f32d887cbbe8abc13ea589d0aa67126b70f6e9d1508006d67cedf12d  openvpn3-=
linux-11_beta.tar.xz
5af11fd30a8a73f8151eb062a4bb85bbd0e416d9816b835a585b892b3ccc53c1  openvpn3-=
linux-11_beta.tar.xz.asc

---- git references -----------------------------------------------------

git tag: v11_beta
git commit: 087393e775fb5b58b28147819ffc55a30b1d29ff

---- Changes from v10 to v11 --------------------------------------------

Arne Schwabe (1):
      Indicate that the openvpn-as imports a config

David Sommerseth (13):
      configmgr: Better handling of incorrect configuration profiles
      docs: Fix incorrect attribute header - user-auth:password
      core: Update client and aws service to use new Core process init
      common/cmdargparser: Fix lacking alias initialization
      netcfg: Rename the tun device properly on non-DCO builds
      configmgr: Add DCO device naming hack
      Update to latest OpenVPN 3 Core library
      dco: Update ovpn-dco submodule to get the latest header files
      docs: Update README with related to the new DCO feature
      docs/man: Add missing options in openvpn3-config-manage man page
      build: Fix out-of-tree builds when --enable-bash-completion is enabled
      shell: Improve openvpn2 --config bash completion
      core/ovpn-dco: Sync up DCO API changes

Lev Stipakov (16):
      openvpn3-service-client: add debug option to specify client path
      build: Define OPENVPN_USE_SITNL in configure.ac
      core: Update to latest openvpn3 Core library
      common: adapt to Core library changes in core JSON extensions
      tests: add missing include in netcfg cli
      Add ovpn-dco submodule
      build: Add ovpn-dco build options
      configmgr: Add support for "dco" config property
      client/netcfg: Initial support for ovpn-dco
      netcfg: Implement crypto key passing for ovpn-dco
      netcfg: Implement ovpn-dco tun establish()
      client/netcfg: Handle ovpn-dco device creation error
      netcfg: Implement ovpn-dco crypto key swapping
      netcfg: Implement setting peer properties for ovpn-dco
      Jenkinsfile: add ovpn-dco support
      ovpn-dco: explicitly subscribe for genl packets

-------------------------------------------------------------------------



--P493Tu8GMibJ0aCdQqcWguLEOLVoeq0A3--

--WR43zHJrl8dVlJjMK5GnKV1USRCswbX0V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfoAoQAAoJEIbPlEyWcf3y/VEP/Akkpjb3BOqjGQLybQ9JryVl
pSWlhFoFjPVNotFDCHauWU2lqo26lGzlXcRVdnrb2H44sW+BMWxTICbKWD6+0UJ7
/IidDjO1Lxx9z/IiKmlFAsruEvNqnzkwigldi2XUOrzFUAzcl4oj5HOtbPzB3fXi
cuifvU0Dzq7lvykBoPSWeRgBjrkDnaENy7nuQoSK95ktXfpaKBymezG43IyoRUWi
3VkVKU9wMjzyJ7P2bsFHP17hlnl1V9dXGBplBcVt7XgjP9Yg/hXcLYyM56KCU/sp
Wvw6M7DQKDvnbne3EKU0fcYlO/xKdVfY0c+5bFBKC/qqlINbHjywCFgV+dx0vM+E
ZPC2269PRzTyrv0ULRYA/oSo/xeSZcoHD0y4K4ZMyCjbS4t+Qn3/Baau6cs1IID0
NaOc+9uyyG0+EzTIMoS1PQ/VfbBQKQjBPh+LOl9E8IPQ2nBkqjLfJBgfF6rmr9nN
hEyjDB3dXv212j86QeUvCnc1RPF9hfSSu1lZEd31BWEjDnunygS0G3Pv5YWgmqIC
3HqMcBSSlX2/VSVouC4nEP2aVuqQqQMbWK6w9v8dXNZdq8v5OyLTOpnuit5P8QO/
BCET54XAmkVgs2OIRxt4OTKX9Kxcr0L+X5XULkcn4fDJ6OTZp9AhRoWRwkNPobP2
ilWknDPWPrdaKpQ2j3pK
=F8/x
-----END PGP SIGNATURE-----

--WR43zHJrl8dVlJjMK5GnKV1USRCswbX0V--

