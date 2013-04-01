MIME-Version: 1.0
In-Reply-To: <5159A262.9010206@...1227...>
References: <1364762609-30320-1-git-send-email-arne@...1227...>
	<20130401111231.GD428@...1296...>
	<CAEsd45RW-ueAjEJS5PkecX=MuxLdBXA3uJceyVL6=wrvE9xoeA@...278...>
	<515999BB.6040201@...1227...>
	<CAEsd45SdeLB1RyVEWjnbMQiSa8ekHciv=KjJFF6QiGn9pYxuvw@...278...>
	<5159A262.9010206@...1227...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Mon, 1 Apr 2013 11:18:41 -0400
Message-ID: <CAEsd45S5OqVBC1sMVMJn8BDxp6o0NuNBZJBJ3v=8184=RFJEZA@...278...>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Apr 1, 2013 at 11:06 AM, Arne Schwabe <arne@...1227...> wrote:
>
>
>>>>>> The "standard" utun.ko driver is sometimes problematic (e.g. VmWare =
Fusion 5 and tun.ko do not work together).
>>
>> If it is the other way around (use tun if it is available and if not,
>> try utun) then anybody who has loaded tun will continue to work with
>> that tun, and anybody who hasn't loaded tun will get utun if it is
>> available. So nothing breaks.
>>
>> It's hard for a GUI like Tunnelblick that doesn't parse the
>> configuration file to detect the situation (no dev-type option) to add
>> a "dev-type tun" to force the use of tun.
>>
>> But if we know that utun works for OpenVPN, then I don't have any
>> problem with the patch. But that utun "is sometimes problematic" makes
>> me worried that this may not be the case.
>
> The short history behind the patch: I was investing why Tunnelblick was n=
ot working on a collegues Macbook and as it turned out that you can have tu=
n.ko loaded or the VmWare Fusion network driver (at least on his Macbook). =
Otherwise you get errors on loading the module. But I remembered something =
about the utun stuff, found the example code again and come up with the pat=
ch. The setence from the commit should have been:
>
> The "standard" tun.ko driver is sometimes problematic (e.g. VmWare Fusion=
 5 and tun.ko do not work together).
>
> The utun driver not be fully compatbile with behaviour of the standard tu=
n.ko driver but all my tests (IPv6, IPv4) worked so far. For 2.3.x I fine w=
ith try utun first or try tun first behaviour but for -master/2.4 I would l=
ike to have try utun first so more people actually use utun so we get to kn=
ow if it is really 100% compatible/working.

Thanks; I get it. So it is the "standard" tun driver that is a
problem, and the utun driver fixes that problem. In that case, patch
is OK with me.

By "the 'standard' tun.ko driver", do you mean "tun.kext" from
tuntaposx (http://tuntaposx.sourceforge.net), which is what
Tunnelblick uses, or are you talking about something else?

