MIME-Version: 1.0
In-Reply-To: <3453b4110907280133n32070ed3rd93598fd1b64740e@...278...>
References: <4A5EFE61.3020100@...41...>
	<20090716133751.GA8884@...33...>
	<4A5F9A9C.7000805@...41...>
	<20090727212401.GA13327@...33...>
	<3453b4110907280049h110ff9c1hf5639d619bdee6e1@...278...>
	<9e0cf0bf0907280059p482c20a8t1aaecab19162c8f@...278...>
	<3453b4110907280112m53e7c0fena3ec779eb41141f0@...278...>
	<9e0cf0bf0907280118t14949a47o5bb1bdefbb0721f5@...278...>
	<3453b4110907280133n32070ed3rd93598fd1b64740e@...278...>
Date: Tue, 28 Jul 2009 12:18:41 +0300
Message-ID: <9e0cf0bf0907280218p25c081f7v203b4780309cb6b9@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc19 released
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
To: Sebastien Raveau <sebastien.raveau@...1231...>
Cc: Openvpn-devel@lists.sourceforge.net

I do not understand either.

If you run OpenVPN from unprivileged user from startup, this apposed
of letting OpenVPN to setuid(), what do you need to protect in middle
of operation?

On Tue, Jul 28, 2009 at 11:33 AM, Sebastien
Raveau<sebastien.raveau@...1231...> wrote:
> I'm not sure I understand you...
>
> As I explained in
> http://article.gmane.org/gmane.network.openvpn.devel/2700 it is indeed
> possible to apply SELinux "from the outside" of a program, like
> chroot, and just like chroot doing that is less efficient and less
> practical.
>
> On Tue, Jul 28, 2009 at 10:18 AM, Alon Bar-Lev<alon.barlev@...277...> wrote:
>> Do that.
>> But as in this case OpenVPN does not run under privilege account at
>> any time, you can do this simply without any selinux code into VPN.
>>
>> On Tue, Jul 28, 2009 at 11:12 AM, Sebastien
>> Raveau<sebastien.raveau@...1231...> wrote:
>>> On Tue, Jul 28, 2009 at 9:59 AM, Alon Bar-Lev<alon.barlev@...277...> wrote:
>>>> Why don't you use openvpn in completely unprivileged mode?
>>>> Look at [1] search for Unprivileged mode.
>>>> [1] http://openvpn.net/index.php/open-source/documentation/howto.html#security
>>>
>>> What makes you think I don't already? :-)
>>>
>>> I do, and it is *not* sufficient as this does not protect against
>>> kernel exploits. If a hacker manages to perform remote code execution
>>> in OpenVPN and thus exploit a vulnerable system call, (s)he obtains
>>> kernel privileges and all of a sudden all your setuid, chroot etc are
>>> useless...
>>>
>>> This can be countered with SELinux (and equivalents such as
>>> GRSecurity, RSBAC, LIDS etc) basically by applying access control on
>>> system calls.
>>>
>>>
>>> Kind regards,
>>>
>>> --
>>> Sebastien Raveau
>>>
>>
>
>
>
> --
> Sebastien Raveau
>

