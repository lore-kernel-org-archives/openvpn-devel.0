References: <1476976749-24466-1-git-send-email-arne@...1227...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <3ec690d6-41a7-ea60-a350-7691b9a6d191@...515...>
Date: Fri, 21 Oct 2016 12:58:11 +0300
MIME-Version: 1.0
In-Reply-To: <1476976749-24466-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Make Changes.rst nicer for 2.4 release
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

The new ordering looks nice now. There is a formatting bug, see the=20
inline comment below.

While the purpose of this patch was not to add content to Changes.rst, I=20
think we should mention the Interactive Service, which is a major=20
feature in this release.

Il 20/10/2016 18:19, Arne Schwabe ha scritto:
> - Add `` to all options
> - Sort and group new features
> - Group changes a bit better
> - Fix some formatting/formulation
> ---
>  Changes.rst | 127 ++++++++++++++++++++++++++++++------------------------=
------
>  1 file changed, 63 insertions(+), 64 deletions(-)
>
> diff --git a/Changes.rst b/Changes.rst
> index 27dc99e..7e4b435 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -4,64 +4,63 @@ Version 2.4.0
>
>  New features
>  ------------
> -
> -pull-filter
> -    New option to explicitly allow or reject options pushed by the serve=
r.
> -    May be used multiple times and is applied in the order specified.
> -
> -push-remove
> -    new option to remove options on a per-client basis from the "push" l=
ist
> -    (more fine-grained than "push-reset")
> -
> -keying-material-exporter
> -    Keying Material Exporter [RFC-5705] allow additional keying material=
 to be
> -    derived from existing TLS channel.
> -
> -redirect-gateway ipv6
> -    OpenVPN has now feature parity between IPv4 and IPv6 for redirect
> -    gateway including the handling of overlapping IPv6 routes with
> -    IPv6 remote VPN server address
> -
> -Mac OS X Keychain management client
> -    add contrib/keychain-mcd which allows to use Mac OS X keychain
> -    certificates with OpenVPN
> -
>  Peer ID support
>      Added new packet format P_DATA_V2, which includes peer-id. If
>      server and client  support it, client sends all data packets in
>      the new format. When data packet arrives, server identifies peer
>      by peer-id. If peer's ip/port has changed, server assumes that
>      client has floated, verifies HMAC and updates ip/port in internal st=
ructs.
> +
> +Cipher negotiation
> +    Data channel ciphers are now by default negotiated.  If a client adv=
ertises
> +    support for Negotiable Crypto Parameters (NCP), the server will choo=
se a
> +    cipher (by default AES-256-GCM) for the data channel, and tell the c=
lient
> +    to use that cipher.  Data channel cipher negotiation can be controll=
ed
> +    using ``--ncp-ciphers`` and ``--ncp-disable``.
> +
> +
> +AEAD (GCM) data channel cipher support
> +    The data channel now supports AEAD ciphers (currently only GCM).  Th=
e AEAD
> +    packet format has a smaller overhead than the CBC packet format, (e.=
g. 20
> +    bytes per packet for AES-128-GCM instead of 36 bytes per packet for
> +    AES-128-CBC + HMAC-SHA1).
>
>  Dualstack client connect
> -    Instead of only using the first address of each --remote OpenVPN
> -    will now try all addresses (IPv6 and IPv4) of a --remote entry.
> +    Instead of only using the first address of each ``--remote`` OpenVPN
> +    will now try all addresses (IPv6 and IPv4) of a ``--remote`` entry.
> +
> +redirect-gateway ipv6
> +    OpenVPN has now feature parity between IPv4 and IPv6 for redirect
> +    gateway including the handling of overlapping IPv6 routes with
> +    IPv6 remote VPN server address
>
>  LZ4 Compression
>      Additionally to LZO compression OpenVPN now also supports LZ4
>      compression.
>
> -Windows version
> -    Windows version is detected, logged and possibly signalled to server
> -    (IV_PLAT_VER=3D<nn> if --push-peer-info is set on client)
> +pull-filter
> +    New option to explicitly allow or reject options pushed by the serve=
r.
> +    May be used multiple times and is applied in the order specified.
>
> -AEAD (GCM) data channel cipher support
> -    The data channel now supports AEAD ciphers (currently only GCM).  Th=
e AEAD
> -    packet format has a smaller overhead than the CBC packet format, (e.=
g. 20
> -    bytes per packet for AES-128-GCM instead of 36 bytes per packet for
> -    AES-128-CBC + HMAC-SHA1).
> +push-remove
> +    new option to remove options on a per-client basis from the "push" l=
ist
> +    (more fine-grained than ``--push-reset``)
>
>  Http proxy password inside config file
> -	Http proxy passwords can be specified with the inline file option
> -    http-proxy-user-pass
> +    Http proxy passwords can be specified with the inline file option
> +    ``<http-proxy-user-pass>`` .. ``</http-proxy-user-pass>``
>
> -Cipher negotiation
> -    Data channel ciphers are now by default negotiated.  If a client adv=
ertises
> -    support for Negotiable Crypto Parameters (NCP), the server will choo=
se a
> -    cipher (by default AES-256-GCM) for the data channel, and tell the c=
lient
> -    to use that cipher.  Data channel cipher negotiation can be controll=
ed
> -    using --ncp-ciphers and --ncp-disable.
> +Windows version
> +    Windows version is detected, logged and possibly signalled to server
> +    (IV_PLAT_VER=3D<nn> if ``--push-peer-info`` is set on client)
>
> +keying-material-exporter
> +    Keying Material Exporter [RFC-5705] allow additional keying material=
 to be
> +    derived from existing TLS channel.
> +
> +Mac OS X Keychain management client
> +    added contrib/keychain-mcd which allows to use Mac OS X keychain
> +    certificates with OpenVPN
>
>  User-visible Changes
>  --------------------
> @@ -75,33 +74,23 @@ User-visible Changes
>  - proto udp and proto tcp specify to use IPv4 and IPv6. The new
>    options proto udp4 and tcp4 specify to use IPv4 only.
>
> -- connect-timeout specifies now the timeout until the first TLS packet
> -  is received (identical to server-poll-timeout) and this timeout now
> -  includes the removed socks proxy timeout and http proxy timeout.
> -
> -  In --static mode connect-timeout specifies the timeout for TCP and
> -  proxy connection establishment
> -
> -- connect-retry-max now specifies the maximum number of unsuccessful
> -  attempts of each remote/connection entry before exiting.
> -
> -- sndbuf and recvbuf default now to OS default instead of 64k
> +- ``--sndbuf`` and ``--recvbuf`` default now to OS defaults instead of 6=
4k
>
>  - OpenVPN exits with  an error if an option has extra parameters;
>    previously they were silently ignored
>
> -- The default of tls-cipher is now "DEFAULT:!EXP:!PSK:!SRP:!kRSA"
> +- The default of ``--tls-cipher`` is now "DEFAULT:!EXP:!PSK:!SRP:!kRSA"
>    instead of "DEFAULT" to always select perfect forward security
>    cipher suites
>
> -- --tls-auth always requires OpenVPN static key files and will no
> +- ``--tls-auth`` always requires OpenVPN static key files and will no
>    longer work with free form files
>
> -- proto udp6/tcp6 in server mode will now try to always listen to
> -  both IPv4 and IPv6 on platforms that allow it. Use bind ipv6only
> +- ``--proto udp6/tcp6`` in server mode will now try to always listen to
> +  both IPv4 and IPv6 on platforms that allow it. Use ``--bind ipv6only`

Second ` at the end is missing. It should say

``--bind ipv6only``


>    to explicitly listen only on IPv6.
>
> -- Removed --enable-password-save from configure. This option is now
> +- Removed ``--enable-password-save`` from configure. This option is now
>    always enabled.
>
>  - Stricter default TLS cipher list (override with ``--tls-cipher``), tha=
t now
> @@ -117,26 +106,36 @@ User-visible Changes
>  - mbed TLS builds: minimum RSA key size is now 2048 bits.  Shorter keys =
will
>    not be accepted, both local and from the peer.
>
> -- --http-proxy-timeout and the static non-changeable socks timeout (5s)
> -  have been folded into a "unified" --connect-timeout which covers all
> +- ``--connect-timeout`` specifies now the timeout until the first TLS pa=
cket
> +  is received (identical to ``--server-poll-timeout``) and this timeout =
now
> +  includes the removed socks proxy timeout and http proxy timeout.
> +
> +  In ``--static`` mode connect-timeout specifies the timeout for TCP and
> +  proxy connection establishment
> +
> +- ``--connect-retry-max`` now specifies the maximum number of unsuccessf=
ul
> +  attempts of each remote/connection entry before exiting.
> +
> +- ``--http-proxy-timeout`` and the static non-changeable socks timeout (=
5s)
> +  have been folded into a "unified" ``--connect-timeout`` which covers a=
ll
>    steps needed to connect to the server, up to the start of the TLS exch=
ange.
>    The default value has been raised to 120s, to handle slow http/socks
>    proxies graciously.  The old "fail TCP fast" behaviour can be achieved=
 by
> -  adding "--connect-timeout 10" to the client config.
> +  adding "``--connect-timeout 10``" to the client config.
>
> -- --http-proxy-retry and --sock-proxy-retry have been removed. Proxy con=
nections
> +- ``--http-proxy-retry`` and ``--sock-proxy-retry`` have been removed. P=
roxy connections
>      will now behave like regular connection entries and generate a USR1 =
on failure.
>
> -- --connect-retry gets an optional second argument that specifies the ma=
ximum
> +- ``--connect-retry`` gets an optional second argument that specifies th=
e maximum
>    time in seconds to wait between reconnection attempts when an exponent=
ial
>    backoff is triggered due to repeated retries. Default =3D 300 seconds.
>
>  - Data channel cipher negotiation (see New features section) can override
> -  ciphers configured in the config file.  Use --ncp-disable if you don't=
 want
> -  that.
> +  ciphers configured in the config file.  Use ``--ncp-disable`` if you d=
o not want
> +  this behavior.
>
>  - All tun devices on all platforms are always considered to be IPv6
> -  capable. The --tun-ipv6 option is ignored (behaves like it is always
> +  capable. The ``--tun-ipv6`` option is ignored (behaves like it is alwa=
ys
>    on).
>
>
>

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

