Message-ID: <48C78CA1.9020305@...41...>
Date: Wed, 10 Sep 2008 03:00:17 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.1_rc10 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-users@lists.sourceforge.net, Openvpn-devel@lists.sourceforge.net

2008.09.10 -- Version 2.1_rc10

* Added "--server-bridge" (without parameters) to enable
   DHCP proxy mode:  Configure server mode for ethernet
   bridging using a DHCP-proxy, where clients talk to the
   OpenVPN server-side DHCP server to receive their IP address
   allocation and DNS server addresses.

* Added "--route-gateway dhcp", to enable the extraction
   of the gateway address from a DHCP negotiation with the
   OpenVPN server-side LAN.

* Fixed minor issue with --redirect-gateway bypass-dhcp or bypass-dns
   on Windows.  If the bypass IP address is 0.0.0.0 or 255.255.255.255,
   ignore it.

* Warn when ethernet bridging that the IP address of the bridge adapter
   is probably not the same address that the LAN adapter was set to
   previously.

* When running as a server, warn if the LAN network address is
   the all-popular 192.168.[0|1].x, since this condition commonly
   leads to subnet conflicts down the road.

* Primarily on the client, check for subnet conflicts between
   the local LAN and the VPN subnet.

* Added a 'netmask' parameter to get_default_gateway, to return
   the netmask of the adapter containing the default gateway.
   Only implemented on Windows so far.  Other platforms will
   return 255.255.255.0.  Currently the netmask information is
   only used to warn about subnet conflicts.

* Minor fix to cryptoapi.c to not compile itself unless USE_CRYPTO
   and USE_SSL flags are enabled (Alon Bar-Lev).

* Updated openvpn/t_cltsrv.sh (used by "make check") to conform to new
   --script-security rules.  Also adds retrying if the addresses are in
   use (Matthias Andree).

* Fixed build issue with ./configure --disable-socks --disable-http.

* Fixed separate compile errors in options.c and ntlm.c that occur
   on strict C compilers (such as old versions of gcc) that require
   that C variable declarations occur at the start of a {} block,
   not in the middle.

* Workaround bug in OpenSSL 0.9.6b ASN1_STRING_to_UTF8, which
   the new implementation of extract_x509_field_ssl depends on.

* LZO compression buffer overflow errors will now invalidate
   the packet rather than trigger a fatal assertion.

* Fixed minor compile issue in ntlm.c (mid-block declaration).

* Added --allow-pull-fqdn option which allows client to pull DNS names
   from server (rather than only IP address) for --ifconfig, --route, and
   --route-gateway.  OpenVPN versions 2.1_rc7 and earlier allowed DNS names
   for these options to be pulled and translated to IP addresses by default.
   Now --allow-pull-fqdn will be explicitly required on the client to enable
   DNS-name-to-IP-address translation of pulled options.

* 2.1_rc8 and earlier did implicit shell expansion on script
   arguments since all scripts were called by system().
   The security hardening changes made to 2.1_rc9 no longer
   use system(), but rather use the safer execve or CreateProcess
   system calls.  The security hardening also introduced a
   backward incompatibility with 2.1_rc8 and earlier in that
   script parameters were no longer shell-expanded, so
   for example:

     client-connect "docc CLIENT-CONNECT"

   would fail to work because execve would try to execute
   a script called "docc CLIENT-CONNECT" instead of "docc"
   with "CLIENT-CONNECT" as the first argument.

   This patch fixes the issue, bringing the script argument
   semantics back to pre 2.1_rc9 behavior in order to preserve
   backward compatibility while still using execve or CreateProcess
   to execute the script/executable.

* Modified ip_or_dns_addr_safe, which validates pulled DNS names,
   to more closely conform to RFC 3696:

   (1) DNS name length must not exceed 255 characters

   (2) DNS name characters must be limited to alphanumeric,
       dash ('-'), and dot ('.')

* Fixed bug in intra-session TLS key rollover that was introduced with
   deferred authentication features in 2.1_rc8.

