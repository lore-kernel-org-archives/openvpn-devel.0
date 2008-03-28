Message-ID: <9e0cf0bf0803281418y4c1b9216y2e532dcb7287b5bb@...278...>
Date: Fri, 28 Mar 2008 23:18:06 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <47ED5E94.4010701@...1085...>
MIME-Version: 1.0
References: <47ED5E94.4010701@...1085...>
Subject: Re: [Openvpn-devel] [patch] Windows --up parameter quoting problem
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Josh Cepek <josh.cepek@...1085...>
Cc: openvpn-devel@lists.sourceforge.net, James Yonan <jim@...41...>

Hello,

You have a valid argument.
I would have suggested to quotes all "%s" arguments of commands, and
solve this properly once and for all.

Alon.

On 3/28/08, Josh Cepek <josh.cepek@...1085...> wrote:
> Under Windows, when run_up_down() from misc.c executes the --up script,
>  the position of the parameters depends on the device name of the tun/tap
>  adapter.  For example, a default installation creates a device that may
>  be called "Local Area Connection 2" (number varies), but this device
>  name isn't quoted when passed to the --up program.  This makes
>  determining the actual name (or any other parameters for that matter)
>  nearly impossible.
>
>  I've attached a patch that quotes the device argument in the
>  run_up_down() function insuring it is always the first argument to the
>  --up script no matter how many spaces appear in the device name.
>
>  --
>
> Josh
>
>
> diff -Naur openvpn-2.1_rc7/misc.c openvpn-2.1_rc7_new/misc.c
>  --- openvpn-2.1_rc7/misc.c      2008-01-23 21:08:41.000000000 +0000
>  +++ openvpn-2.1_rc7_new/misc.c  2008-03-28 20:34:15.000000000 +0000
>  @@ -206,7 +206,7 @@
>        ASSERT (arg);
>
>        buf_printf (&cmd,
>  -                 "%s %d %d %s %s %s",
>  +                 "\"%s\" %d %d %s %s %s",
>                   arg,
>                   tun_mtu, link_mtu,
>                   ifconfig_local, ifconfig_remote,
>  @@ -225,7 +225,7 @@
>        setenv_str (es, "script_type", script_type);
>
>        buf_printf (&cmd,
>  -                 "%s %s %d %d %s %s %s",
>  +                 "%s \"%s\" %d %d %s %s %s",
>                   command,
>                   arg,
>                   tun_mtu, link_mtu,
>
> -------------------------------------------------------------------------
>  Check out the new SourceForge.net Marketplace.
>  It's the best place to buy or sell services for
>  just about anything Open Source.
>  http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
> _______________________________________________
>  Openvpn-devel mailing list
>  Openvpn-devel@lists.sourceforge.net
>  https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>
>

