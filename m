MIME-Version: 1.0
In-Reply-To: <20151220134642.GY24952@...1296...>
References: <CAGyAFMXoH2aXQwn84AiV0c=OP2Rhv6i1-D_E+RXMXu8ZQFTvVA@...278...>
	<20151220134642.GY24952@...1296...>
Date: Sun, 20 Dec 2015 19:32:56 +0200
Message-ID: <CAGyAFMW_qSWu=Y1DfYai=ENLP-nk1hebMaYykAa5HJXVfQy3qA@...278...>
From: Lev Stipakov <lstipakov@...277...>
Subject: Re: [Openvpn-devel] XP broken
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: ValdikSS ValdikSS <iam@...2070...>

Hi,

Screenshot seems to be lost in transmission.

Moving to openvpn-devel.

We could probably detect XP only (or technically "less then Vista") by
checking that IsWindowsVistaOrGreater() == false which seems to be
simpler. It should fix the problem.

However I like the idea that server will be able to know client's win
version, which might help with troubleshooting. I wouldn't not change
"IV_PLAT" value, so shall we add something like "IV_PLAT_WINVER=6.1"?

-Lev

2015-12-20 15:46 GMT+02:00 Gert Doering <gert@...1296...>:

> Unfortunately, this is a bit complicated.
>
> First, XP really doesn't *do* interface indexes in netsh (*rant*) - I
> have attached a screen shot.  German, unfortunately, but "Zeichenkette"
> is "string", and the example clearly has an interface name there...
>
> We *could* introduce yet another option ("--ip-win32 netsh-names"),
> but the usefulness of that would depend on "whoever writes the .conf file
> knows what client OS it is for" (plus, we add an option that 2.4 won't
> have because it has no XP support anyway).  This does not sound like
> the way forward.
>
> So, I think we need to do this in two steps:
>
>  - add (in win32.c) a "win32_version_info()" function that will do the
>    necessary things to figure out what Windows version we're running on.
>    Stackoverflow suggests that this is complicated, as Windows will lie
>    to programs most of the time, so "Win10" is reported as "Win8" unless
>    there is something in the manifest (whatever that is) that tells windows
>    "this program is prepared to deal with THE TRUTH"
>
>  - while at it, add "win32_version_string()" which would produce a printed
>    version of this - so we can log it at startup, to help people diagnose
>    why something isn't working for a user - and we could send it to the
>    server as well if --push-peer-info is enabled (ssl.c, push_peer_info())
>
>  - and then, make the interface index bit conditional...
>
>     if ( win32_version_info() == WIN_XP )
>         device = tt->actual;
>     else
>       {
>         buf_printf (&out, "interface=%d", tt->adapter_index );
>         device = buf_bptr(&out);
>       }
>
>    (for add/delete_route_ipv6(), but ifconfig would look the same)
>
>
> the win32_version_* stuff would go into 2.3 and master, because having
> that information is generally useful - the conditional setting only into
> 2.3.10
>
> what do you think?

-- 
-Lev

