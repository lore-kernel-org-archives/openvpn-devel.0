Message-ID: <4BC3119C.5060906@...1114...>
Date: Mon, 12 Apr 2010 14:27:08 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20100410154547.GJ2689@...1330...>
In-Reply-To: <20100410154547.GJ2689@...1330...>
Subject: Re: [Openvpn-devel] [PATCH] Fixed typo in manpage
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
To: Alberto Gonzalez Iniesta <agi@...64...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


On 10/04/10 17:45, Alberto Gonzalez Iniesta wrote:
> --- openvpn-2.1.0.orig/openvpn.8	2010-04-10 17:07:57.256694284 +0200
> +++ openvpn-2.1.0/openvpn.8	2010-04-10 17:08:06.036696780 +0200
> @@ -916,7 +916,7 @@
>  otherwise 0.
>  
>  The default can be specified by leaving an option blank or setting
> -it to "default".
> +it to "nil".

I've been reviewing this.  It's good to have docs in sync with the code.
 But in this case, it seems that this is not the proper fix.

I did some tests against v2.1.1 which I had handy ... I tested with:

 route <network> <netmask> <VPN gw>
 route <network> <netmask> <VPN gw> default
 route <network> <netmask> <VPN gw> nil
 route <network> <netmask> <VPN gw> garbage

On the 'default' case, the following line was executed:
 /sbin/ip route add <network>/<netmask> via <VPN gw>

On the 'nil' and 'garbage' cases, this route was setup:
 /sbin/ip route add <network>/<netmask> via <VPN gw> metric 0

Which means to me, that 'default' is the proper value to use.  On the
other hand, the verbose logging uses the 'nil' value in route.c:973 in
show_opt(), and the options.c:190 uses 'nil' as help text to the usage
screen.

I suggesting not to modify the man page at all.  I suggest updating
options.c to use 'default' instead of 'nil'.  A change in route.c need
to be more "clever", as that might give more some unexpected log lines
if <network>, <netmask> or <VPN gw> is not set.  The show_opt() function
is used for all of these values in print_route_option().

I'm suggesting throwing out the show_opt() function and replace it with
a macro:

   #define SHOW_OPT(val, nullval) (val ? val : nullval)

This would also be more efficient code than calling a function, and does
the same job.  The places where the show_opt() function is called,
SHOW_OPT() can be used like this:

    SHOW_OPT(ro->network, "nil")
    SHOW_OPT(ro->metric, "default")

This should fix the issue in a better way.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvDEZcACgkQDC186MBRfrraggCfTQHa7ZhaAwbY8DfNz1+Jgent
4YoAnjX/DnQoPri0Q/Mu7ZBvNBxOnjx1
=YgdK
-----END PGP SIGNATURE-----

