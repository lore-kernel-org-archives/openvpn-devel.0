From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <2de146f7-a01d-1ceb-1f99-e36bd9feeeab@...515...>
Date: Tue, 5 Oct 2021 12:19:29 +0300
MIME-Version: 1.0
Content-Language: en-US
Subject: [Openvpn-devel] OpenVPN 2.5.4 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>, openvpn-users@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

The OpenVPN community project team is proud to release OpenVPN 2.5.4.=20
This release include a number of fixes and small improvements. Windows=20
executable and libraries are now built natively on Windows using MSVC,=20
not cross-compiled on Linux as with earlier 2.5 releases. Windows=20
installers include updated OpenSSL and new OpenVPN GUI. The latter=20
includes several improvements, the most important of which is the=20
ability to import profiles from URLs where available.

Source code and Windows installers can be downloaded from our download page:

<https://openvpn.net/community-downloads/>

Debian and Ubuntu packages are available in the official apt repositories:

<https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos>

On Red Hat derivatives we recommend using the Fedora Copr repository.

<https://copr.fedorainfracloud.org/coprs/dsommers/openvpn-release/>

---

Overview of changes since OpenVPN 2.4

   Faster connections

     Connections setup is now much faster

   Crypto specific changes

     ChaCha20-Poly1305 cipher in the OpenVPN data channel
       Requires OpenSSL 1.1.0 or newer)
     Improved TLS 1.3 support when using OpenSSL 1.1.1 or newer
     Client-specific tls-crypt keys (--tls-crypt-v2)
     Improved Data channel cipher negotiation
     Removal of BF-CBC support in default configuration (see below for
possible incompatibilities)

   Server-side improvements

     HMAC based auth-token support for seamless reconnects to standalone
       servers or a group of servers.
     Asynchronous (deferred) authentication support for auth-pam plugin
     Asynchronous (deferred) support for client-connect scripts and
       plugins

   Network-related changes

     Support IPv4 configs with /31 netmasks now
     802.1q VLAN support on TAP servers
     IPv6-only tunnels
     New option --block-ipv6 to reject all IPv6 packets (ICMPv6)

   Linux-specific features

     VRF support
     Netlink integration (OpenVPN no longer needs to execute
       ifconfig/route or ip commands)

Windows-specific features

     Wintun driver support, a faster alternative to tap-windows6
     Setting tun/tap interface MTU
     Setting DHCP search domain
     Allow unicode search string in --cryptoapicert option
     EasyRSA3, a modern take on OpenVPN CA management
     MSI installer

---

Important notices

BF-CBC cipher is no longer the default

Cipher handling for the data channel cipher has been significantly
changed between OpenVPN 2.3/2.4 and v2.5, most notably there are no
"default cipher BF-CBC" anymore because it is no longer considered a
reasonable default. BF-CBC is still available, but it needs to be
explicitly configured now.

For connections between OpenVPN 2.4 and v2.5 clients and servers, both
ends will be able  to negotiate a better cipher than BF-CBC. By default
they will select one of the AES-GCM ciphers, but this can be influenced
using the --data-ciphers setting.

Connections between OpenVPN 2.3 and v2.5 that have no --cipher setting
in the config (=3D defaulting to BF-CBC and not being negotiation-capable)
must be updated. Unless BF-CBC is included in --data-ciphers or there is
a "--cipher BF-CBC" in the OpenVPN 2.5 config, a v2.5 client or server
will refuse to talk to a v2.3 server or client, because it has no common
data channel cipher and negotiating a cipher is not possible. Generally,
we recommend upgrading such setups to OpenVPN 2.4 or v2.5. If upgrading
is not possible we recommend adding data-ciphers
AES-256-GCM:AES-128-GCM:AES-128-CBC (for v2.5+) or cipher AES-128-CBC
(v2.4.x and older) to the configuration of all clients and servers.

If you really need to use an unsupported OpenVPN 2.3 (or even older)
release and need to stay on BF-CBC (not recommended), the OpenVPN 2.5
based client will need a config file change to re-enable BF-CBC.  But be
warned that BF-CBC and other related weak ciphers will be removed in
coming OpenVPN major releases.

For full details see the Data channel cipher negotiation section on the
man page.

Connectivity to some VPN service provider may break

Connecting with an OpenVPN 2.5 client to at least one commercial VPN
service that
implemented their own cipher negotiation method that always reports back
that it is using BF-CBC to the client is broken in v2.5. This has always
caused warning about mismatch ciphers. We have been in contact with some
service providers and they are looking into it.  This is not something
the OpenVPN community can fix. If your commercial VPN does not work with
a v2.5 client, complain to the VPN service provider.

More details on these new features as well as a list of deprecated
features and user-visible changes are available in Changes.rst:

<https://github.com/OpenVPN/openvpn/blob/release/2.5/Changes.rst>

---

Linux packages are available from

<https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos>
<https://copr.fedorainfracloud.org/coprs/dsommers/openvpn-release/>

Useful resources

     Official documentation:
<http://openvpn.net/index.php/open-source/documentation/howto.html>
     Wiki: <https://community.openvpn.net/>
     Easy RSA 3 HOWTO:
<https://community.openvpn.net/openvpn/wiki/EasyRSA3-OpenVPN-Howto>
     Forums: <https://forums.openvpn.net/>
     User mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
     User IRC channel: #openvpn at irc.freenode.net

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

