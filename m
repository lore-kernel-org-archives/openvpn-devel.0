Message-ID: <51C2C433.9070402@...1227...>
Date: Thu, 20 Jun 2013 10:58:27 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1364762609-30320-1-git-send-email-arne@...1227...>
	<1371532990-2853-1-git-send-email-arne@...1227...>
	<CAEsd45RrzR5XAh=PN3WUPM41VrJdXeZef8KLCrtbBPEXiQJuPQ@...278...>
In-Reply-To: <CAEsd45RrzR5XAh=PN3WUPM41VrJdXeZef8KLCrtbBPEXiQJuPQ@...278...>
Subject: Re: [Openvpn-devel] [Patch v2] Add support of utun devices under
 Mac OS X
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
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 20.06.13 05:17, schrieb Jonathan K. Bullard:
> On Tue, Jun 18, 2013 at 1:23 AM, Arne Schwabe <arne@...1227...> wrote:
>> Mac OS X 10.7+ natively supports tun devices (called utun). The "standard" utun.ko driver is sometimes problematic (e.g. VmWare Fusion 5 and tun.ko do not work together).
>>
>> When OpenVPN is compiled with utun support it will if no dev-node is given first try to use utun and if that is not available will try the traditional tun devices
>>
>> Parts of the patches are inspired from Peter Sagerson's <psagers@...1829...> utun patch
>> Signed-off-by: Arne Schwabe <arne@...1227...>
Thanks for looking at the patch. I fixed all the bugs you found.
>
>
> The resulting binary works fine and uses utun on 10.6.8 and 10.7.5.
>
> (Interesting that utun isn't in the 10.6 SDK but utun works on 10.6.8.
> Since it isn't in the SDK, I assume it may be flakey and/or only in
> some OS X > 10.6.0. If it is flakey in 10.6.8, that's a problem
> because it will be used by default, but if it is just that it isn't in
> all of 10.6.*, that should be OK.)

I have a OS X 10.6 VM with Xcode 3.2.6 installed and this VM has the
if/utun.h header. I probably was added somewhere between 10.6.0 and 10.6.8.
>
> On 10.5.8, however, attempting to connect to a server fails with the
> following messages from the OpenVPN log:
>
> 2013-06-19 10:06:28 Opening utun (ioctl(CTLIOCGINFO)): No such file or
> directory: No such file or directory (errno=2)
> 2013-06-19 10:06:28 Exiting due to fatal error
>
> Someone should build with the patch properly (i.e. not like I did) on
> 10.7 or 10.8 and test it on 10.5 (and 10.4, ideally) to make sure the
> fallback really works. (I may be misunderstanding the code, but if
> "msg (M_ERR..." doesn't return, then that's at least part of the
> problem.)
>
> If fallback doesn't work in 10.4 and 10.5, then my view is that it
> should be changed so it does work (mostly because Tunnelblick supports
> 10.4 - 10.8 with a single OpenVPN binary). If OpenVPN doesn't want to
> support 10.5 or 10.4 to this extent, or if the fallback failure is
> caused by with the way I worked around not using the 10.7 SDK, I guess
> I'll just have to deal with it.
I changed the M_ERR to M_WARN. It should now work on 10.5.x but without
a 10.5 to test on it is difficult to say...

Arne

