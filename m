MIME-Version: 1.0
Sender: sebastien.raveau@...277...
In-Reply-To: <9e0cf0bf0907280720y45b629d5sd7fe3d2525811280@...278...>
References: <4A5EFE61.3020100@...41...>
	<9e0cf0bf0907280059p482c20a8t1aaecab19162c8f@...278...>
	<3453b4110907280112m53e7c0fena3ec779eb41141f0@...278...>
	<9e0cf0bf0907280118t14949a47o5bb1bdefbb0721f5@...278...>
	<3453b4110907280133n32070ed3rd93598fd1b64740e@...278...>
	<9e0cf0bf0907280218p25c081f7v203b4780309cb6b9@...278...>
	<4A6EFCFF.2090400@...1114...>
	<9e0cf0bf0907280650i3dabf036gc9e2f8c745823e15@...278...>
	<4A6F05B0.4020602@...1114...>
	<9e0cf0bf0907280720y45b629d5sd7fe3d2525811280@...278...>
Date: Tue, 28 Jul 2009 20:29:04 +0200
Message-ID: <3453b4110907281129x509c2bb1rbbfe4a817765e503@...278...>
From: Sebastien Raveau <sebastien.raveau@...1231...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc19 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: Openvpn-devel@lists.sourceforge.net

(Hi again)

David: you did not "interrupt badly", on the contrary I am glad that
the discussion continued while I was away :-)

Alon: with all due respect to you and your work - which I am sure is
the best way to go in some situations - I believe that you are wrong
on the topic of maximum security...

First of all, what you're proposing is running OpenVPN as a
not-exactly-unprivileged user (let's call it "least privileged user"),
meaning that your user doesn't have 0 right but "only the right to
modify the routing table". The problem is: in your configuration, this
least privileged user has this write *permanently*, as opposed to
starting OpenVPN as root, letting it use privileges during
initialization and as soon as possible drop to a really-unprivileged
user thanks to setgid/setgroups/setuid (which is what OpenVPN does
when you specify the "user" option).

I hope you understand that, paradoxically perhaps, the latter is
really more secure than the former.

As a matter of fact, I'm afraid I would even strongly recommend
_against_ your suggestion, because if some company were to use OpenVPN
on an Internet gateway with your configuration, a hacker would be able
to alter the routing table for the whole company, and hence
transparently redirect employees to phishing websites, just because
your "unprivileged OpenVPN" is allowed to run /sbin/ip with any
parameters at any time (which is a HUGE privilege).

Also, speaking of complexity and ease of use, let's pretend we're
debating over pre-initialization chroot vs post-initialization,
instead of setcon (the SELinux context switch). It is really the same
with setuid, but the difference is easier to understand in the case of
chroot.

Pre-initialization chroot (from the outside of OpenVPN if you will)
would require reproducing the filesystem environment OpenVPN will
need, which means copying /usr/sbin/openvpn
/usr/lib/libpkcs11-helper.so.1 /lib/tls/i686/cmov/libpthread.so.0
/lib/tls/i686/cmov/libc.so.6 /lib/ld-linux.so.2
/lib/tls/i686/cmov/libdl.so.2 /lib/i686/cmov/libcrypto.so.0.9.8
/lib/libz.so.1 /lib/i686/cmov/libssl.so.0.9.8 /usr/lib/liblzo2.so.2
just to get the executable to launch. Then you will most likely need
access to at least one of the /dev, /proc and /sys pseudo-filesystems
which means you will have to `mount --bind` them in the target
directory for your chroot, etc...

Post-initialization chroot, for which the code has been added inside
OpenVPN (see init.c:392 and misc.c:48) requires none of that and
actually does better, as you can have your OpenVPN chroot'ed in a
completely empty directory.

Now, to transpose that back to SELinux, if the setcon code could be
added inside OpenVPN (next to the setuid and chroot code which have
already been accepted as clearly benefiting) it would be possible to
reduce the SELinux policy for OpenVPN from ~100 lines (
http://oss.tresys.com/projects/clip/browser/trunk/refpolicy/src/selinux-pol=
icy-clip/policy/modules/services/openvpn.te?rev=3D13
) to ~10 !!  (basically just the lines allowing network I/O)


I totally agree with you however on the "Keep It Simple, Stupid
(KISS)" principle applied to security. I hope that this /10 cut in the
oh-so-complex writing of a SELinux policy proves to you the benefit of
my patch :-)


On Tue, Jul 28, 2009 at 4:20 PM, Alon Bar-Lev<alon.barlev@...277...> wrote:
> I don't understand you guys.
>
> I never said do not use SELinux, or that SELinux does not have advantages.
> I know perfectly what the advantages are.
>
> BUT it is much easier to create profile to unprivileged user that runs
> OpenVPN than a profile of a daemon that needs special rights.
>
> As far as I learned, when security is concerned:
> 1. Make your solution as simple as possible.
> 2. Make the simple solution secure enough.
> 3. Enhance the security using security products.
>
> When you try to do (3) before (1) you get unmanageable solution, which
> in time also results in unsecured solution.
>
> Just my two cents.
>
> Alon.
>
> On Tue, Jul 28, 2009 at 5:05 PM, David
> Sommerseth<openvpn.list@...1114...> wrote:
>>
>>
>> Alon Bar-Lev wrote:
>>>
>>> I do not understand, but it looks that two of you are searching for a
>>> solution inside the box, while the solution is out side the box.
>>>
>>> I added the ability for OpenVPN to run using unprivileged user, yes,
>>> please read it as-is, unprivileged user!!!
>>> This means that you don't need any special permission to run OpenVPN.
>>>
>>> How did I manage to do this?
>>>
>>> Simply,
>>> 1. Linux's tun device access may be enabled to a specific user or group.
>>> 2. Wrap iproute2 calls.
>>
>> This is not what SELinux primarily solves, even though it also solves th=
is
>> too. =A0But it can restrict access to resources OpenVPN initially should=
 only
>> have.
>>
>> OpenVPN depends on devices in kernel space, even if you restrict that on=
 the
>> "normal" file system level (chmod 600 /dev/net/tun*), a bug/exploit in t=
he
>> device being used can still be used for privilege escalation. =A0This is=
 one
>> of the attack vectors SELinux tries to solve. =A0It makes sure the appli=
cation
>> do not get access to devices, files, processes, etc which is not defined=
 in
>> the security context - because this is possible attack vectors.
>>
>>> I am not against SELinux usage in OpenVPN. I just want you to be aware
>>> that there is alternatives that can use OpenVPN without any special
>>> right.
>>
>> Agreed, there are plenty of alternatives, but they only focus on the
>> user-space area primarily, not kernel space. =A0In the wrapper you sugge=
st,
>> there is nothing here protecting against malformed information being sen=
t to
>> the wrapper around iproute2, combine that with some buffer overflows bug=
s in
>> iproute2, and you have yet another attack vector. =A0Take a look after t=
he
>> latest cheddar_bay exploit being found recently. =A0Here several small f=
laws
>> are used together to gain root shell access on a vulnerable system.
>>
>> SELinux will make it more difficult, as it is even more tricky to disable
>> the SELinux controll mechanism on the way.
>>
>>
>> Kind regards,
>>
>> David Sommerseth
>>
>>
>>> On Tue, Jul 28, 2009 at 4:28 PM, David
>>> Sommerseth<openvpn.list@...1114...> wrote:
>>>>
>>>> Alon Bar-Lev wrote:
>>>>>
>>>>> I do not understand either.
>>>>>
>>>>> If you run OpenVPN from unprivileged user from startup, this apposed
>>>>> of letting OpenVPN to setuid(), what do you need to protect in middle
>>>>> of operation?
>>>>>
>>>>> On Tue, Jul 28, 2009 at 11:33 AM, Sebastien
>>>>> Raveau<sebastien.raveau@...1231...> wrote:
>>>>>>
>>>>>> I'm not sure I understand you...
>>>>>>
>>>>>> As I explained in
>>>>>> http://article.gmane.org/gmane.network.openvpn.devel/2700 it is inde=
ed
>>>>>> possible to apply SELinux "from the outside" of a program, like
>>>>>> chroot, and just like chroot doing that is less efficient and less
>>>>>> practical.
>>>>>>
>>>> I hope I'm not interrupting badly now.
>>>>
>>>> A little basic part, for those wanting to understand the depths. What
>>>> SELinux provides is access control on different kind of layers inside =
the
>>>> kernel space, also on system calls. =A0For a brief overview over SELin=
ux,
>>>> have
>>>> a look here:
>>>> http://www.ibm.com/developerworks/linux/library/l-sppriv.html,
>>>>
>>>> http://www.ibm.com/developerworks/linux/library/l-selinux/index.html?S=
_TACT=3D105AGX03&S_CMP=3DEDU
>>>> (A lot of more good SELinux information is available on IBM's
>>>> developerWorks
>>>> site)
>>>>
>>>> It makes sense to do a security context switch after OpenVPN has
>>>> initialised
>>>> and chrooted, then changing security context and drop the rest of the
>>>> privileges. =A0In the new OpenVPN security context, it should then not=
 be
>>>> allowed to do any chrooting or network configuration (as this is a part
>>>> of
>>>> the initialisation, IMO), and even if possible, setuid() should be
>>>> disallowed. =A0That way you can really lock down everything OpenVPN sh=
ould
>>>> not
>>>> do - just allowing what it needs to do. =A0Basically, the OpenVPN secu=
rity
>>>> context should only be allowed to write to log files, execute code in
>>>> plug-ins, read a limited range of files, and read/write to a network
>>>> device
>>>> granting access to the openvpn context.
>>>>
>>>> What I am lacking in this patch, is a security context definition (at
>>>> least
>>>> an example of how to configure a proper context for OpenVPN). =A0Furth=
er;
>>>> has
>>>> it been investigated if there need to be done some other context chang=
es
>>>> to
>>>> the TUN/TAP devices? =A0What about other files? =A0If a log file is la=
belled
>>>> var_log_t, will the new openvpn security context be allowed to write to
>>>> this
>>>> log file? =A0How would this work with the security context of the dire=
ctory
>>>> of
>>>> the log file? (It might be that the easy approach would to do logging =
via
>>>> syslog()) =A0 Then what about plug-ins, how would OpenVPN work in these
>>>> settings when the SELinux context is changed? =A0F.ex. how would this =
patch
>>>> work against the down-root.so plugin?
>>>>
>>>> I do agree, implementing SELinux in the openvpn code is an important
>>>> step!
>>>> =A0But it seems to be just too easy to do setcon(). =A0It is just miss=
ing a
>>>> consequence analysis of what else needs to be changed in addition to t=
his
>>>> patch.
>>>>
>>>> I'm not an SELinux expert, and Sebastien might know far more about
>>>> SElinux
>>>> =A0than anyone of us. =A0I don't want to trample on anyone feet ... bu=
t I
>>>> just
>>>> wanted to have clarified these issues before I can give 100% support to
>>>> this
>>>> patch, as it just seemed to be too easy.
>>>>
>>>>
>>>> --
>>>> kind regards,
>>>>
>>>> David Sommerseth
>>>>
>>>>
>>>>
>>
>



--=20
Sebastien Raveau

