Message-ID: <4A23CE15.9080400@...1114...>
Date: Mon, 01 Jun 2009 14:48:21 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4A21B085.6090603@...41...>
In-Reply-To: <4A21B085.6090603@...41...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc17 released
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
To: James Yonan <jim@...41...>
Cc: Openvpn-devel@lists.sourceforge.net, OpenVpn-Users <openvpn-users@lists.sourceforge.net>



James Yonan wrote:
> Change Log:
> 
> 2009.05.30 -- Version 2.1_rc17
> 
> * Reduce the debug level (--verb) at which received management interface
>    commands are echoed from 7 to 3.  Passwords will be filtered.
> 
> * Fixed race condition in management interface recv code on
>    Windows, where sending a set of several commands to the
>    management interface in quick succession might cause the
>    latter commands in the set to be ignored.
> 
> * Increased management interface input command buffer size
>    from 256 to 1024 bytes.
> 
> * Minor tweaks to Windows build system.
> 
> * Added "redirect-private" option which allows private subnets
>    to be pushed to the client in such a way that they don't accidently
>    obscure critical local addresses such as the DHCP server address and
>    DNS server addresses.
> 
> * Added 'autolocal' redirect-gateway flag.  When enabled, the OpenVPN
>    client will examine the routing table and determine whether (a) the
>    OpenVPN server is reachable via a locally connected interface, or (b)
>    traffic to the server must be forwarded through the default router.
>    Only add a special bypass route for the OpenVPN server if (b) is true.
>    If (a) is true, behave as if the 'local' flag is specified, and do not
>    add a bypass route.
> 
>    The new 'autolocal' flag depends on the non-portable test_local_addr()
>    function in route.c, which is currently only implemented for Windows.
>    The 'autolocal' flag will act as a no-op on platforms that have not
>    yet defined a test_local_addr() function.
> 
> * Increased TLS_CHANNEL_BUF_SIZE to 2048 from 1024 (this will allow for
>    more option content to be pushed from server to client).
> 
> * Raised D_MULTI_DROPPED debug level to 4 from 3 to filter out (at debug
>    levels <=3) a common and usually innocuous warning.
> 
> * Fixed issue of symbol conflicts interfering with Windows CryptoAPI
>    functionality (Alon Bar-Lev).
> 
> * Fixed bug where the remote_X environmental variables were not being
>    set correctly when the 'local' option is specifed.
> 
> James

I just compared the 2.1_rc16 and 2.1_rc17 trees ... I see these files in 
the tar ball in addition:

        contrib/pull-resolv-conf/client.down.bak
        contrib/pull-resolv-conf/client.up.bak
        easy-rsa/2.0/pkitool.bak
        plugin/auth-pam/auth-pam.c.bak
        plugin/defer/simple.c.bak
        plugin/down-root/down-root.c.bak
        plugin/examples/log.c.bak
        plugin/examples/simple.c.bak
        tap-win32/common.h.bak
        tap-win32/constants.h.bak
        tap-win32/dhcp.c.bak
        tap-win32/dhcp.h.bak
        tap-win32/endian.h.bak
        tap-win32/error.c.bak
        tap-win32/error.h.bak
        tap-win32/hexdump.c.bak
        tap-win32/hexdump.h.bak
        tap-win32/i386/OemWin2k.inf.in.bak
        tap-win32/instance.c.bak
        tap-win32/lock.h.bak
        tap-win32/macinfo.c.bak
        tap-win32/macinfo.h.bak
        tap-win32/mem.c.bak
        tap-win32/proto.h.bak
        tap-win32/prototypes.h.bak
        tap-win32/tapdrvr.c.bak
        tap-win32/types.h.bak

Just a missing clean-up?  or something we should be worried about?


kind regards,

David Sommerseth


