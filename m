MIME-Version: 1.0
In-Reply-To: <515999BB.6040201@...1227...>
References: <1364762609-30320-1-git-send-email-arne@...1227...>
	<20130401111231.GD428@...1296...>
	<CAEsd45RW-ueAjEJS5PkecX=MuxLdBXA3uJceyVL6=wrvE9xoeA@...278...>
	<515999BB.6040201@...1227...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Mon, 1 Apr 2013 10:43:59 -0400
Message-ID: <CAEsd45SdeLB1RyVEWjnbMQiSa8ekHciv=KjJFF6QiGn9pYxuvw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add support of utun devices under Mac
	OS X
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Apr 1, 2013 at 10:29 AM, Arne Schwabe <arne@...1227...> wrote:
>
> Am 01.04.13 15:26, schrieb Jonathan K. Bullard:
>
>> On Mon, Apr 1, 2013 at 7:12 AM, Gert Doering <gert@...1296...> wrote:
>>>
>>> Hi,
>>>
>>> On Sun, Mar 31, 2013 at 10:43:29PM +0200, Arne Schwabe wrote:
>>>>
>>>> Mac OS X 10.7+ natively supports tun devices (called utun). The
>>>> "standard" utun.ko driver is sometimes problematic (e.g. VmWare Fusion 5 and
>>>> tun.ko do not work together).
>>>>
>>>> When OpenVPN is compiled with utun support it will if no dev-node is
>>>> given first try to use utun and if that is not available will try the
>>>> traditional tun devices
>>
>>
>> The "utun" stuff is new to me; all I can find is the source code for
>> it. Is this one of the "hidden features" of iOS that that OpenVPN for
>> iOS app uses, and that is also in OS X 10.7 and up?
>
> Basically yes.
>
>> Most configuration files I've seen do not include a dev-node option.
>> Does a "dev tun" option in the file imply, for this purpose, "dev-type
>> tun"?
>>
>> If I understand this correctly, a user who updates to 10.7+ will be
>> using utun instead of tun. That may be problematic (I don't know).
>>
>> Wouldn't it be better to use the legacy tun if it exists, and if not,
>> then use the utun? That would be backward-compatible with such
>> configuration files.
>
>
> Currently the patch tries to open utun first and if that fails it will try
> to open tun. If you specify something like dev-node tun17 or dev-node utun23
> it will only try to open that specific kind of tun node.

Yes. The point I was trying to make was that most configuration files
that I've seen don't have 'dev-node' options, so they will try utun
first and only if that fails will they try try to open tun. So when
they update to 10.7+, OpenVPN will start to use utun instead of tun
(since it will be available in 10.7+), and that may break backward
compatibility if the utun doesn't work exactly the same way that tun
works, which I gather from the comment that

>>>> The "standard" utun.ko driver is sometimes problematic (e.g. VmWare Fusion 5 and tun.ko do not work together).

If it is the other way around (use tun if it is available and if not,
try utun) then anybody who has loaded tun will continue to work with
that tun, and anybody who hasn't loaded tun will get utun if it is
available. So nothing breaks.

It's hard for a GUI like Tunnelblick that doesn't parse the
configuration file to detect the situation (no dev-type option) to add
a "dev-type tun" to force the use of tun.

But if we know that utun works for OpenVPN, then I don't have any
problem with the patch. But that utun "is sometimes problematic" makes
me worried that this may not be the case.

