MIME-Version: 1.0
In-Reply-To: <20120229212832.GC7024@...1296...>
References: <4F4CE4FE.3010009@...515...> <7855235.EvfmKnZP6h@...1526...>
	<CAP+U6t+ZUA3UpYfKms0Qr=-Cn1M-GP1EJtGybG0+j+O2xnfv7g@...278...>
	<1404593.Apkr3x9kAi@...1526...>
	<CAP+U6t+-8n=fFk+QP0Dm-H9YijcssjZjOHOpU5pwkSrXt1+qMQ@...278...>
	<20120229154604.GA7024@...1296...>
	<1056463883.20120229194318@...449...>
	<20120229212832.GC7024@...1296...>
Date: Wed, 29 Feb 2012 23:36:46 +0200
Message-ID: <CAOazyz3t+=2SsDA0+_sqByekvbE7R5Y+qHN2ysGDLw2hsiK8wg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
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
To: Gert Doering <gert@...1296...>
Cc: =?UTF-8?Q?Carsten_Kr=C3=BCger?= <C.Krueger@...448...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

2012/2/29 Gert Doering <gert@...1296...>:
> Hi,
>
> On Wed, Feb 29, 2012 at 07:43:18PM +0100, Carsten Kr=C3=BCger wrote:
>> > Part of the assumption here is "the user controls the openvpn config",
>> > and as such, he can make openvpn.exe run arbitrary scripts anyway - and
>> > to stop this from being a problem, just run openvpn.exe with your uid.
>>
>> What operation could be in script that is usefull when it's executed
>> in user context.
>>
>> I never used script with openvpn. I've no idea which are real world
>> applications for it.
>
> Scripts are for creative uses that the programmers of openvpn have not
> foreseen. =C2=A0Like "after the VPN is up, auto-sync all your git reposit=
ories"
> or "open up a few xterms with ssh's to $internalhosts".
>
> David had some other idea recently, which I forgot.

This is a great example why this functionality should *MOVE OUT* of
the openvpn code base.
The UI can monitor OpenVPN and run scripts when such events are
detected via the management interface.
The UI already runs in the context of the interactive user.

I would like to receive replies to[1].

Thanks,
Alon.

[1] http://sourceforge.net/mailarchive/message.php?msg_id=3D28910374

