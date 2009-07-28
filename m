MIME-Version: 1.0
In-Reply-To: <4A6F05B0.4020602@...1114...>
References: <4A5EFE61.3020100@...41...>
	<3453b4110907280049h110ff9c1hf5639d619bdee6e1@...278...>
	<9e0cf0bf0907280059p482c20a8t1aaecab19162c8f@...278...>
	<3453b4110907280112m53e7c0fena3ec779eb41141f0@...278...>
	<9e0cf0bf0907280118t14949a47o5bb1bdefbb0721f5@...278...>
	<3453b4110907280133n32070ed3rd93598fd1b64740e@...278...>
	<9e0cf0bf0907280218p25c081f7v203b4780309cb6b9@...278...>
	<4A6EFCFF.2090400@...1114...>
	<9e0cf0bf0907280650i3dabf036gc9e2f8c745823e15@...278...>
	<4A6F05B0.4020602@...1114...>
Date: Tue, 28 Jul 2009 17:20:05 +0300
Message-ID: <9e0cf0bf0907280720y45b629d5sd7fe3d2525811280@...278...>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn.list@...1114...>
Cc: Openvpn-devel@lists.sourceforge.net

I don't understand you guys.

I never said do not use SELinux, or that SELinux does not have advantages.
I know perfectly what the advantages are.

BUT it is much easier to create profile to unprivileged user that runs
OpenVPN than a profile of a daemon that needs special rights.

As far as I learned, when security is concerned:
1. Make your solution as simple as possible.
2. Make the simple solution secure enough.
3. Enhance the security using security products.

When you try to do (3) before (1) you get unmanageable solution, which
in time also results in unsecured solution.

Just my two cents.

Alon.

On Tue, Jul 28, 2009 at 5:05 PM, David
Sommerseth<openvpn.list@...1114...> wrote:
>
>
> Alon Bar-Lev wrote:
>>
>> I do not understand, but it looks that two of you are searching for a
>> solution inside the box, while the solution is out side the box.
>>
>> I added the ability for OpenVPN to run using unprivileged user, yes,
>> please read it as-is, unprivileged user!!!
>> This means that you don't need any special permission to run OpenVPN.
>>
>> How did I manage to do this?
>>
>> Simply,
>> 1. Linux's tun device access may be enabled to a specific user or group.
>> 2. Wrap iproute2 calls.
>
> This is not what SELinux primarily solves, even though it also solves this
> too. =C2=A0But it can restrict access to resources OpenVPN initially shou=
ld only
> have.
>
> OpenVPN depends on devices in kernel space, even if you restrict that on =
the
> "normal" file system level (chmod 600 /dev/net/tun*), a bug/exploit in the
> device being used can still be used for privilege escalation. =C2=A0This =
is one
> of the attack vectors SELinux tries to solve. =C2=A0It makes sure the app=
lication
> do not get access to devices, files, processes, etc which is not defined =
in
> the security context - because this is possible attack vectors.
>
>> I am not against SELinux usage in OpenVPN. I just want you to be aware
>> that there is alternatives that can use OpenVPN without any special
>> right.
>
> Agreed, there are plenty of alternatives, but they only focus on the
> user-space area primarily, not kernel space. =C2=A0In the wrapper you sug=
gest,
> there is nothing here protecting against malformed information being sent=
 to
> the wrapper around iproute2, combine that with some buffer overflows bugs=
 in
> iproute2, and you have yet another attack vector. =C2=A0Take a look after=
 the
> latest cheddar_bay exploit being found recently. =C2=A0Here several small=
 flaws
> are used together to gain root shell access on a vulnerable system.
>
> SELinux will make it more difficult, as it is even more tricky to disable
> the SELinux controll mechanism on the way.
>
>
> Kind regards,
>
> David Sommerseth
>
>
>> On Tue, Jul 28, 2009 at 4:28 PM, David
>> Sommerseth<openvpn.list@...1114...> wrote:
>>>
>>> Alon Bar-Lev wrote:
>>>>
>>>> I do not understand either.
>>>>
>>>> If you run OpenVPN from unprivileged user from startup, this apposed
>>>> of letting OpenVPN to setuid(), what do you need to protect in middle
>>>> of operation?
>>>>
>>>> On Tue, Jul 28, 2009 at 11:33 AM, Sebastien
>>>> Raveau<sebastien.raveau@...1231...> wrote:
>>>>>
>>>>> I'm not sure I understand you...
>>>>>
>>>>> As I explained in
>>>>> http://article.gmane.org/gmane.network.openvpn.devel/2700 it is indeed
>>>>> possible to apply SELinux "from the outside" of a program, like
>>>>> chroot, and just like chroot doing that is less efficient and less
>>>>> practical.
>>>>>
>>> I hope I'm not interrupting badly now.
>>>
>>> A little basic part, for those wanting to understand the depths. What
>>> SELinux provides is access control on different kind of layers inside t=
he
>>> kernel space, also on system calls. =C2=A0For a brief overview over SEL=
inux,
>>> have
>>> a look here:
>>> http://www.ibm.com/developerworks/linux/library/l-sppriv.html,
>>>
>>> http://www.ibm.com/developerworks/linux/library/l-selinux/index.html?S_=
TACT=3D105AGX03&S_CMP=3DEDU
>>> (A lot of more good SELinux information is available on IBM's
>>> developerWorks
>>> site)
>>>
>>> It makes sense to do a security context switch after OpenVPN has
>>> initialised
>>> and chrooted, then changing security context and drop the rest of the
>>> privileges. =C2=A0In the new OpenVPN security context, it should then n=
ot be
>>> allowed to do any chrooting or network configuration (as this is a part
>>> of
>>> the initialisation, IMO), and even if possible, setuid() should be
>>> disallowed. =C2=A0That way you can really lock down everything OpenVPN =
should
>>> not
>>> do - just allowing what it needs to do. =C2=A0Basically, the OpenVPN se=
curity
>>> context should only be allowed to write to log files, execute code in
>>> plug-ins, read a limited range of files, and read/write to a network
>>> device
>>> granting access to the openvpn context.
>>>
>>> What I am lacking in this patch, is a security context definition (at
>>> least
>>> an example of how to configure a proper context for OpenVPN). =C2=A0Fur=
ther;
>>> has
>>> it been investigated if there need to be done some other context changes
>>> to
>>> the TUN/TAP devices? =C2=A0What about other files? =C2=A0If a log file =
is labelled
>>> var_log_t, will the new openvpn security context be allowed to write to
>>> this
>>> log file? =C2=A0How would this work with the security context of the di=
rectory
>>> of
>>> the log file? (It might be that the easy approach would to do logging v=
ia
>>> syslog()) =C2=A0 Then what about plug-ins, how would OpenVPN work in th=
ese
>>> settings when the SELinux context is changed? =C2=A0F.ex. how would thi=
s patch
>>> work against the down-root.so plugin?
>>>
>>> I do agree, implementing SELinux in the openvpn code is an important
>>> step!
>>> =C2=A0But it seems to be just too easy to do setcon(). =C2=A0It is just=
 missing a
>>> consequence analysis of what else needs to be changed in addition to th=
is
>>> patch.
>>>
>>> I'm not an SELinux expert, and Sebastien might know far more about
>>> SElinux
>>> =C2=A0than anyone of us. =C2=A0I don't want to trample on anyone feet .=
.. but I
>>> just
>>> wanted to have clarified these issues before I can give 100% support to
>>> this
>>> patch, as it just seemed to be too easy.
>>>
>>>
>>> --
>>> kind regards,
>>>
>>> David Sommerseth
>>>
>>>
>>>
>

