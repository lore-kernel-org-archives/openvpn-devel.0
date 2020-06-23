From: David Sommerseth <openvpn@...2080...>
Message-ID: <c4628c37-0c3b-a402-ee9d-68ee7062e1f3@...2080...>
Date: Wed, 24 Jun 2020 00:55:16 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="oBETnbQVxGZt4iuTJ2frbFwLp5yMtllAh"
Subject: [Openvpn-devel] [RFC] Challenges with OpenVPN and configuring DNS
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Jonathan Wright <jon@...2563...>
Cc: Arne Schwabe <arne@...515...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oBETnbQVxGZt4iuTJ2frbFwLp5yMtllAh
Content-Type: multipart/mixed; boundary="sF4bWvOvGpSBu0uZm8E8EENEjNzQl5yGE";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>, Jonathan Wright <jon@...2563...>
Cc: Arne Schwabe <arne@...515...>
Message-ID: <c4628c37-0c3b-a402-ee9d-68ee7062e1f3@...2080...>
Subject: [RFC] Challenges with OpenVPN and configuring DNS

--sF4bWvOvGpSBu0uZm8E8EENEjNzQl5yGE
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hi,

Arne and I have discussed the challenge of DNS configuration and we have pa=
id
attention to a recent discussion here on the mailing list as well [1].  We
have tried to consider various platforms and have a few proposals for unify=
ing
and documenting DNS configuration as much as possible.

[1]
<https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19512.=
html>
    Message-Id: <f4b83fe0-cbe1-eed3-ff9b-4aaaea5a12b1@...1147...>


DNS configuration has become fairly advanced in the later OS releases,
compared to the traditional "send all requests to this DNS server" we're
all very well used to.

Scenarios we have considered:

 * Exclusive DNS resolver
   All DNS lookup requests should go to a specified DNS server regardless
   of the host configuration prior to the VPN connection.

 * Split-DNS
   Only selected "route domains" should use the provided DNS server

 * Windows has it's own DOMAIN setting which may impact how it handles
   DNS and NetBios configurations

 * Some platforms differentiates between "search domains" (which is the
   typical 'search' option in /etc/resolv.conf)  and "route domains" (which
   domains should use a specific DNS resolver)

 * DNSSEC
   Some resolver libraries supports enforcing or disabling DNSSEC - and
   some prefers DNSSEC but allows a downgrade (most typically needed for
   some login portals, where DNS lookups triggers a redirect if you are
   not already logged in).


We have the --dhcp-option option today, which can configure some of these
parameters, but its implementation can often be inconsistent across
platforms.  We propose here to standardize and properly document the
expected behavior.

--dhcp-option settings

 - DNS
       Provides an IPv4/IPv6 address to a DNS resolver to use.  Can
       be used multiple times.

 - DOMAIN
       Set Connection-specific DNS Suffix to `name`.  This should only
       be set once.  On Windows this will have a platform specific meaning.
       Only the first DOMAIN should be expected to be handled.

       If ``--dns-mode`` is set to default, DOMAIN will also be added
       to DOMAIN-SEARCH.  For compatibility with existing servers pushing
       multiple DOMAIN entries, additional DOMAIN entries are appended to
       the DOMAIN-SEARCH list.

 - DOMAIN-SEARCH
       This is the equivalent to the traditional DNS Domain Search setting
       (like `search` in `/etc/resolv.conf`).  Short hostnames will attempt
       DNS resolving using domains in all enlisted DOMAIN-SEARCH entries
       which results into a FQDN hostname for the lookup.

 - DOMAIN-ROUTE
       This can be used multiple times and defines domains which should
       only be resolved via the given DNS resolver.  The lookup is based
       on a FQDN hostname, expanded via DOMAIN-SEARCH.

 - DNSSEC
       Defines the expected DNSSEC behavior of the resolver.  Valid
       values:

       :code:`yes`
           If the provided DNS server does not support DNSSEC, look-ups
           will fail if this mode is used.

       :code:`no`
           DNSSEC validation is disabled.

       :code:`allow-downgrade`
           DNSSEC validation is enabled, but is turned off automatically
           if the selected server does not support it.

       If DNSSEC is not configured, it will default to the default host
       configuration.


We also propose to add a new OpenVPN option to tell the platform specific
DNS resolver how it should understand the --dhcp-options DNS related
options:

--dns-mode mode
  This defines how pushed DNS configuration settings should be processed
  when OpenVPN configures the DNS resolver on the host.  `mode` can one
  of these values:

  - default
    Current default behavior, defined by the platform.  This should
    typically not change the behavior much from prior OpenVPN releases.

  - split-dns
    Pushed DNS options should only be used for the VPN session.
    Hostname lookups will consider DOMAIN, DOMAIN-SEARCH and
    DOMAIN-ROUTE.  If a FQDN hostname matches any of these, the lookup
    should only be sent to the provided DNS resolver.  Non-matching
    lookups should go to the system defined DNS resolvers.

  - exclusive
    Any DNS lookup should go to to the DNS resolver provided by the
    OpenVPN server exclusively.  Any other system defined resolvers should
    not be considered.



In addition we also propose to provide a possibility for OpenVPN clients
to signal to the server what kind of DNS configuration it can support.
The rationale here is so the server can decide if it wants to allow the
connection (some VPN admins may want their clients to support specific
features) or more advanced servers may adopt the DNS configuration it
pushes to their clients, to get a more consistent behavior across VPN
clients.

To avoid extending the IV_* scope with even more values, we are proposing
to redo IV_PROTO to be a bit-field oriented variable.  This is still
possible as we currently have only defined the values of 1 and 2.  We
propose the following bit-mask:

    - bit 0 (1)
         Reserved (this is essentially today's IV_PROTO=3D1)

    - bit 1 (2)
         Supports P_DATA_V2 (IV_PROTO=3D2 in current implementations)

    - bit 2 (4) - Extended DNS support
         Supports the additional DNS options: DOMAIN-SEARCH, DOMAIN-ROUTE,
         DNSSEC.  DOMAIN will only allowed once.

    - bit 3 (8) - Split DNS
         Client can configure split DNS on the host

     - bit 4 (16) - Blocking/Exclusive DNS
         Client can configure exclusive DNS with blocking (exclusive)

     - bit 5 (32) - DNSSEC
          Client can modify DNSSEC configuration for VPN DNS resolver
          based on the DNSSEC option.

We have looked through the other IV_* options as well, and we can also
consider to allocate a bit for IV_TCPNL and start a process to deprecate
the dedicated IV_TCPNL variable.  This is to save space in the IV_* already
limited IV buffer.

We considered the compression options as well (IV_LZO, IV_LZ4, IV_LZ4v2
and IV_COMP_STUB*) but believe these should move away from compression
in the future.



Some of these IV_PROTO settings can on some platforms be added into OpenVPN
itself.  But we believe it is good to also allow the --plugin and script
hooks to also facilitate these settings.  This allows a simpler OpenVPN
binary to signal to the server that it intends to support various features.
In this discussion, we also realized this can also be used for the
auth-pending feature as well, which currently is only supported via the
management interface.

We therefore suggests adding yet another OpenVPN option:

--feature-support GROUP TEXT-FLAGS

  * GROUP: dns with these flags:

      - `extended`
        sets IV_PROTO bit 2 if not already set.

      - `split-dns`
         sets IV_PROTO bit 3

      - `dns-block`
         sets IV_PROTO bit 4

      - `dnssec`
         sets IV_PROTO bit 5

  * GROUP: auth-pending
        This signals to the server which kind of pending authentication
        features the client can support

      - `openurl`
        Adds `openurl` to IV_SSO

      - `proxyurl`
        Adds proxyurl to IV_SSO

      - `crtext`
        Adds crtext to IV_SSO


For platform implementations we have considered the following:

* macOS
  Tunnelblick uses external scripts which are well tested and seems to
  work fine.  Will it make sense to implement native DNS configuration
  support into OpenVPN on macOS?  This might mean we need to link OpenVPN
  against some Objective-C code to communicate directly with the network
  configuration APIs.  It could also be possible to implement this as an
  external plug-in, which extends OpenVPN's current behavior.

* Windows
  On Windows we already have a native implementation.  We did not consider
  any alternative approaches here.

* Android
  Has its own implementation in OpenVPN for Android, with ideas
  from the the Windows implementation.  This also facilitates the
  possibilities provided via the VPN API in Android.

* Linux
  Currently uses --up scripts (pull-resolv-conf, update-systemd-resolved)
  and --plugin (NetworkManager).  It is possible to implement a plug-in
  which talks directly to systemd-resolved as well.  Native support
  included would require linking against a D-Bus library, which can become
  pretty invasive.

  There are some advantages to move over to a --plugin
  for systemd-resolved support, as it can interact quicker with the
  service instead of running a script which parses options and does the
  same D-Bus calls to systemd-resolved.  But this will not get a too high
  priority as the script based update-systemd-resolved approach will work
  well too.

  OpenVPN 3 Linux will be extended with native systemd-resolved support
  in a coming release.

* *BSD
  We do not know enough of the capabilities here.  But a both script
  and --plugin solutions can work, especially if facilitating the new
  --feature-support option - where it will be more up to the script/plug-in
  to define what it will be capable of.


--
kind regards,

Arne Schwabe
David Sommerseth
OpenVPN Inc



--sF4bWvOvGpSBu0uZm8E8EENEjNzQl5yGE--

--oBETnbQVxGZt4iuTJ2frbFwLp5yMtllAh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJe8ohZAAoJEIbPlEyWcf3y3RIP/iTy1yTUi2h8f0/SUFkGVePb
hQ9MYsNgOIHREDC7vz/4Lp8sSr54ZbBbSipx/rHBo2Onxuc5br54Clw8q1n5SKQj
FI2zkm/2140YyNs9Z9LiCBjmHxjIfXTqprzLazINzE6qizXCd3zam3O+PlexWCRW
LrfZG1jPozAdZZ28qDjok1gtqlUrLm4mzmW0+jMoQJvXUkd2ms64Wd7krHVue32o
U30c5cHaGMbKtqmvSo8gc/UamKIE9nadacd/+qmvtQPxJxsH5CadOsyviujldy++
Y8RWHypNWVKrBQZQzd/PtJjhXPMVbWI2mItVcgmbIurbMYyQ+z39SxeI4ID+bssv
LNabQPSsOLMLBTEeRgRhNeE8BZkH6S5pRTLQyWYQToQqONLy7IYEJJ5jnJYmqfRU
VXpdU1cpq3OC+GuU0C80zDrMtOEKgX/Wycl5NVxCN0Lc3ly32YvSUpD2e5kThJhJ
TJk8IJ8X46vcm9HETAuGuYqxMaNB9CE96B6+cbtLRiYmCHokxmQ/B31/PS2lO3oz
BUUIMojvSX0JW7ctUff7VjoxNAeY4DJTG+2d2b7lStsTirwXvMbfmHOFuF4fw8dD
Z53p1LEARw+d44SlgYnLFIktB5ydQ/qfrd9st3Yjvw3mU4AWYA1N7Ev1mZVdABTx
Ra3Y3OtYryEQ3cDPmZQF
=OMx5
-----END PGP SIGNATURE-----

--oBETnbQVxGZt4iuTJ2frbFwLp5yMtllAh--

