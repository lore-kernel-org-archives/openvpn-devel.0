Message-ID: <55843EAD.6010305@...1147...>
Date: Fri, 19 Jun 2015 18:09:17 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <20150617100752.GG382@...1296...>
In-Reply-To: <20150617100752.GG382@...1296...>
Subject: Re: [Openvpn-devel] why is "route add failure" considered not an
 error?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Yo Gert,

On 17/06/15 12:07, Gert Doering wrote:
> Hi,
>
> OpenVPN history confuses me :-) - right now, I am wondering about the
> following:
>
>   - if we call ifconfig to set up the tun device, and that fails, we
>     consider it a hard error (openvpn_exec_check(..., S_FATAL, ...) and
>     terminate
>
>   - if we then proceed to set up routing, and *that* fails, we just ignore
>     the result (we do take notice that we couldn't add a route, so we don't
>     try to remove it later on - but we do not actually fail)
>
> in some situations, this behaviour is causing problems...
>
> Typical example is windows when not running the gui with admin privileges.
> Interface config is done by ioctl()->DHCP (which we do have access rights
> to...), route add silently fails, VPN is "incomplete".  Another example is
> trac #563, which after quite a bit of discussion seems to boil down to
> "a previous instance of something left around a route to the /28 subnet
> that should have pointed to tun1, but instead it pointed to lo0, causing
> loops and non-working VPN"...
>
>
> So, we have good reasons to *not* do it that way, but I'm missing a reason
> why this is so...?
>
> Shall we change it in 2.4 to make route add failures S_FATAL?
>
> By default?  Or add an option to turn it back into a soft-fail in case
> someone knows what they ar doing?
>
>
I don't know what the reasoning was behind making "route failures" 
non-fatal, but strictly speaking the tunnel is functioning - it's just 
the routing that failed :)
I'd be in favour of adding  YetAnotherOption to override the "route 
failure" behaviour - but the real solution on e.g. the Windows side is 
to alter the GUI to pick up any routing failures and warn the user.

As a side note: I've gotten my hands on Windows 8.1 for my laptop. I'll 
install win8.1 (dual boot) on it shortly, so that we can debug the 
routing/ipconfig issues.

cheers,

JJK





