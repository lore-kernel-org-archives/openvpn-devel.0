References: <20160916161354.GM78279@...1296...>
	<1476263591-12401-1-git-send-email-arne@...1227...>
	<760c0976-c0fa-f3d1-d243-aeaac9991b97@...2080...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <af69765c-bedf-f507-a0c7-eb159f049f95@...2080...>
Date: Thu, 13 Oct 2016 17:54:27 +0200
MIME-Version: 1.0
In-Reply-To: <760c0976-c0fa-f3d1-d243-aeaac9991b97@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v4] Remove tun-ipv6 Option. Instead
 assume that IPv6 is always supported.
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Please disregard this mail.  I will resent it again without getting it
destroyed by Engimail's text wrapping.

David S.



On 13/10/16 17:52, David Sommerseth wrote:
> On 12/10/16 11:13, Arne Schwabe wrote:
>> This option was useful when Ipv6 tun support was non standard
>> and was an internal/user specified flag that tracked the Ipv6 
>> capability of the tun device.
> 
>> All supported OS support IPv6. Also tun-ipv6 is pushable by the 
>> remote so not putting tun-ipv6 does not forbid ipv6 addresses.
> 
>> This commit also clean up a bit of the ipv6 related tun.c.
>> Changes for most platforms are minimal.
> 
>> For linux a bit more cleanup is done: - Remove compatibility 
>> defines that were added 2008 - Always use IFF_NO_PI for the
>> linux tun and not only for IPv4 only tun setups (Android also
>> always IFF_NO_PI works fine with Ipv6).
> 
>> This commit also remove a non ipv6 fallback for tap driver from 
>> OpenVPN 2.2-beta or earlier and only warns.
> 
>> Patch V2: Integrate Gert's comments Patch V3: Remove tun_ipv4 
>> option. It only used for MTU discovery and there it was wrong
>> since it should on the transport protocol if at all Patch V4:
>> Completely remove support for NetBSD <= 4.0 and remove
>> NETBSD_MULTI_AF defines --- Changes.rst           |   3 ++
>> src/openvpn/forward.c | 2 +- src/openvpn/helper.c  |   2 -
>> src/openvpn/init.c    |   6 --- src/openvpn/multi.c   |   8 ++-
>> src/openvpn/openvpn.h |   5 -- src/openvpn/options.c |  11 +---
>> src/openvpn/options.h |   1 - src/openvpn/route.c   |  13 ++---
>> src/openvpn/tun.c     | 139 
>> +++++++------------------------------------------- 
>> src/openvpn/tun.h     |   2 - 11 files changed, 30
>> insertions(+), 162 deletions(-)
> 
>> diff --git a/Changes.rst b/Changes.rst index 9fcba75..2956003 
>> 100644 --- a/Changes.rst +++ b/Changes.rst @@ -135,6 +135,9 @@ 
>> User-visible Changes ciphers configured in the config file.  Use 
>> --ncp-disable if you don't want that.
> 
>> +- ALl tun devices on all platforms are considered always IPv6 
>> capable. The --tun-ipv6
> 
> Silly typo.  (I would have done this one in-flight, hadn't it been
> for a few other minor things).
> 
> [...snip...]
>> @@ -4577,7 +4569,6 @@ add_option (struct options *options, else
>> if (streq (p[0], "tun-ipv6") && !p[1]) { VERIFY_PERMISSION 
>> (OPT_P_UP); -      options->tun_ipv6 = true; }
> 
> Should we add a "Deprecated/NO-OP option used." message?
> 
> [...snip....]
> 
>> +++ b/src/openvpn/route.c @@ -1729,10 +1729,10 @@ add_route_ipv6 
>> (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
>>  } #endif
> 
>> -  if ( !tt->ipv6 ) +  if (!tt->did_ifconfig_ipv6_setup) { - msg(
>> M_INFO, "add_route_ipv6(): not adding %s/%d, no IPv6 on if %s", -
>> network, r6->netbits, device ); +      msg( M_INFO, 
>> "add_route_ipv6(): not adding %s/%d, no IPv6 ifconfig on if %s",
>> + network, r6->netbits, device);
> 
> Wouldn't it be nicer we said "no IPv6 address configured on 
> interface %s" ?  Just trying to be slightly more user friendly in
> the logs.
> 
>> --- a/src/openvpn/tun.c +++ b/src/openvpn/tun.c @@ -741,8 +741,8
>> @@ do_ifconfig (struct tuntap *tt,
> 
>> argv_init (&argv);
> 
>> -      msg( M_INFO, "do_ifconfig, tt->ipv6=%d, 
>> tt->did_ifconfig_ipv6_setup=%d", -	           tt->ipv6, 
>> tt->did_ifconfig_ipv6_setup ); +      msg( M_INFO, "do_ifconfig, 
>> tt->did_ifconfig_ipv6_setup=%d", + tt->did_ifconfig_ipv6_setup
>> );
> 
> While we're changing log lines ... could we make this one a bit
> less technical, or at least increase the verb level if we want it
> to be so technical?  Again, just to be more user friendly
> 
> [...snip...]
> 
>> @@ -1526,7 +1513,7 @@ open_tun_generic (const char *dev, const
>> char *dev_type, const char *dev_node, bool dynamic_opened =
>> false;
> 
> 
>> -  if ( tt->ipv6 && ! ipv6_explicitly_supported ) +  if (  ! 
>> ipv6_explicitly_supported ) msg (M_WARN, "NOTE: explicit support 
>> for IPv6 tun devices is not provided for this OS");
> 
> Isn't this if() block a NOOP?
> 
> $ git grep -Hni ipv6_explicitly_supported src/openvpn/tun.c:1521:
> bool ipv6_explicitly_supported, bool dynamic, 
> src/openvpn/tun.c:1529:  if ( tt->ipv6 && !
> ipv6_explicitly_supported )
> 
> Could we kill this as well?
> 
> 
> [...snip...0
>> @@ -1977,53 +1940,13 @@ close_tun (struct tuntap *tt) int
>> write_tun (struct tuntap* tt, uint8_t *buf, int len) { -  if
>> (tt->ipv6) - { -      struct tun_pi pi; -      struct iphdr *iph;
>> -      struct iovec vect[2]; -      int ret; - -      iph =
>> (struct iphdr *)buf; - -      pi.flags = 0; - -
>> if(iph->version == 6) -	pi.proto = htons(OPENVPN_ETH_P_IPV6); -
>> else -	pi.proto = htons(OPENVPN_ETH_P_IPV4); - -
>> vect[0].iov_len = sizeof(pi); - vect[0].iov_base = &pi; -
>> vect[1].iov_len = len; - vect[1].iov_base = buf; - -      ret =
>> writev(tt->fd, vect, 2); - return(ret - sizeof(pi)); -    } -
>> else -    return write (tt->fd, buf, len); +  return write
>> (tt->fd, buf, len);
> 
> whitespace issue.
> 
>> }
> 
>> int read_tun (struct tuntap* tt, uint8_t *buf, int len) { -  if 
>> (tt->ipv6) -    { -      struct iovec vect[2]; -      struct
>> tun_pi pi; -      int ret; - -      vect[0].iov_len = sizeof(pi);
>> - vect[0].iov_base = &pi; -      vect[1].iov_len = len; - 
>> vect[1].iov_base = buf; - -      ret = readv(tt->fd, vect, 2); - 
>> return(ret - sizeof(pi)); -    } -  else -    return read
>> (tt->fd, buf, len); +  return read (tt->fd, buf, len);
> 
> whitespace issue.
> 
> [....snip....]
>> @@ -5308,11 +5208,10 @@ open_tun (const char *dev, const char 
>> *dev_type, const char *dev_node, struct tu /* usage of numeric 
>> constants is ugly, but this is really tied to * *this* version
>> of the driver */ -    if ( tt->ipv6 && tt->type == DEV_TYPE_TUN
>> && + if (tt->type == DEV_TYPE_TUN && info[0] == 9 && info[1] < 8)
>> { - msg( M_INFO, "WARNING:  Tap-Win32 driver version %d.%d does
>> not support IPv6 in TUN mode.  IPv6 will be disabled.  Upgrade
>> to Tap-Win32 9.8 (2.2-beta3 release or later) or use TAP mode to
>> get IPv6", (int) info[0], (int) info[1] ); -	tt->ipv6 = false; +
>> msg( M_INFO, "WARNING:  Tap-Win32 driver version %d.%d does not
>> support IPv6 in TUN mode.  IPv6 will not work.  Upgrade to
>> Tap-Win32 9.8 (2.2-beta3 release or later) or use TAP mode to get
>> IPv6", (int) info[0], (int) info[1] );
> 
> Maybe we should review the contents of this log line as well?  Can
> at least point at the latest 2.3 release instead of a beta
> release.
> 
> 
> I see that a few of my comments are not directly related to
> removing --tun-ipv6.  But I'm not convinced there's any benefit in
> having them in a separate patch.  I'm okay with either approach.
> 
> 
> -- kind regards,
> 
> David Sommerseth
> 

- -- 
kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJX/64zAAoJEIbPlEyWcf3yOdgP/2xcR+dYM1VQLHEPhKCoFrZ1
+gl9py6z124K0jswkFjCbm4l1EfJyPmxDZt9GfvBr+j+3lT/yZoEPMNhQG7F6LM3
czYAx0vFuI51/8s6GSXfh/APoJTTQhOSprzEbkluPjeVa46fUZ8XeXeTHoJbaujD
ilF1XengPHp671yJVlEPPAL2rnNrMaNi7NMA3Fy1/K83I0fK8D7dxSVtcVrIWjIG
qlV68YbIxyYbxelM0AdLAcKsiCffZIe3Ojy+UoGjnLBKjnbbvkqMbzdHk7982Fp0
QNAwe+WwCw4Q5kl2W2DGPdZY88aU9v4EBWdEa3JF3QMwj1b1F0KY7E/9r3iHYDNe
cNBNwN4D2sjd1SdTCL1sAV2Iih+i1T8/gLYPNdXp8Zkf6HaI3nWtyCF8BEB7CeO6
zsmMBMeWc+ld6zjhaOL2JYRj94qkmuCgGtNa4khd34Ih5OAlk1E/GyrkCWdSCTAS
T7eD7V5AfGzBfx4Hu2XJVAEOpzjU6NKVtqHBCecni3PUk2Uyjj5v6Zcl1vzoiyye
AHSeYmazB5h24ywA5k0JukCLblaKP1bciStXPlGByAHtOHA7ZTPR7SUvsV1VIBOA
BMPJaEabUhYIvhK82bqA1DxUpBngPaNxFvesMkJTQgS7zE9gj1C3ATd6vuLMYHIY
E1q3yTuEYIDwaJUN0wr/
=+AHi
-----END PGP SIGNATURE-----

