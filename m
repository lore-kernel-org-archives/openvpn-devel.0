Message-ID: <4A6F634E.7020202@...1114...>
Date: Tue, 28 Jul 2009 22:45:02 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
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
	<3453b4110907281129x509c2bb1rbbfe4a817765e503@...278...>
In-Reply-To: <3453b4110907281129x509c2bb1rbbfe4a817765e503@...278...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc19 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Sebastien Raveau <sebastien.raveau@...1231...>, Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On 28/07/09 20:29, Sebastien Raveau wrote:
> (Hi again)
> 
> Alon: with all due respect to you and your work - which I am sure is
> the best way to go in some situations - I believe that you are wrong
> on the topic of maximum security...

+1

> First of all, what you're proposing is running OpenVPN as a
> not-exactly-unprivileged user (let's call it "least privileged user"),
> meaning that your user doesn't have 0 right but "only the right to
> modify the routing table". The problem is: in your configuration, this
> least privileged user has this write *permanently*, as opposed to
> starting OpenVPN as root, letting it use privileges during
> initialization and as soon as possible drop to a really-unprivileged
> user thanks to setgid/setgroups/setuid (which is what OpenVPN does
> when you specify the "user" option).

If I understood Alon correctly, he also executes OpenVPN as a less
privileged user, meaning that it is impossible to escape out of that
user, as the saved UID/GID will be a unprivileged user.  But!  Chroot
will in this setting be impossible, because only root can do chroot().

> As a matter of fact, I'm afraid I would even strongly recommend
> _against_ your suggestion, because if some company were to use OpenVPN
> on an Internet gateway with your configuration, a hacker would be able
> to alter the routing table for the whole company, and hence
> transparently redirect employees to phishing websites, just because
> your "unprivileged OpenVPN" is allowed to run /sbin/ip with any
> parameters at any time (which is a HUGE privilege).

+1 ... It is of course possible to tighten this even more, but it will
require even more complex efforts to do this right, and it will still
not cover all those gaps which SELinux can fill.  The user account which
openvpn will run as, will still need to run the wrapped ip/iproute
commands.  Thus you still will have an attack vector.

If in addition you have cleverly composed arguments to this wrapper, you
might even manage to escape the ip/iproute command and start another
program as root, say /bin/sh f.ex. ... or even change the root password
to a known password by editing /etc/shadow with a little /usr/bin/sed
command.  And if openvpn is not started as root, you cannot chroot this
process (at least not without having another startup wrapper around
openvpn).  And this attack vector, only SELinux can cover best, as the
security context would be different from what the openvpn process runs
with and the permissions needed to run /bin/sh, /usr/bin/sed, or another
non-openvpn approved binary.

> Now, to transpose that back to SELinux, if the setcon code could be
> added inside OpenVPN (next to the setuid and chroot code which have
> already been accepted as clearly benefiting) it would be possible to
> reduce the SELinux policy for OpenVPN from ~100 lines (
> http://oss.tresys.com/projects/clip/browser/trunk/refpolicy/src/selinux-policy-clip/policy/modules/services/openvpn.te?rev=13
> ) to ~10 !!  (basically just the lines allowing network I/O)

I still would say that these ~100 lines you link to her, Sebastien,
would still be needed.  Still not sure how plug-ins would like it with
this config.  But having a setcon() call inside OpenVPN, is just as
beneficial as having setuid(), setgid() and chroot() inside openvpn.
And none of these calls makes the other calls less needed.

Having that said, most of the policy Sebastian linked to here, covers
many of my concerns earlier.  Even though how code in plug-ins would be
executed (in which context) is more uncertain for me right now.

> I totally agree with you however on the "Keep It Simple, Stupid
> (KISS)" principle applied to security. I hope that this /10 cut in the
> oh-so-complex writing of a SELinux policy proves to you the benefit of
> my patch :-)

Even though SELinux itself is complex, it doesn't mean that using it is
too difficult.  Using it properly is more challenging though, compared
to not using it.  But we don't stop using firewalls because we find it
difficult, do we?  And nowadays, not many people find firewalling as
difficult as 10 years ago.

And Alon, to your 3 bullet points ...

> As far as I learned, when security is concerned:
> 1. Make your solution as simple as possible.
> 2. Make the simple solution secure enough.
> 3. Enhance the security using security products.

I completely agree to you on these points.  The thing is that I (and
probably also Sebastien) already consider the two first points to be
covered pretty well, they are done.  Now we just want number 3 closed as
well, as this is not implemented at all.

Sebastien, back to your patch.  There is one thing I've been thinking
about today, regarding the --setcon parameter you introduce to the
openvpn binary.  Why does this need to be a runtime parameter?  I cannot
imagine you want to run openvpn with different security context on the
same box, or even the same Linux distro.  In my eyes, this would be a
static value.  The SELinux context could be a compile time argument,
IMHO, which just defines a constant/macro which is when calling
setcon().  Or is it something else I'm missing here?

If SELinux is found during configure, it could use a hard coded context.
 And it should still work no matter if SELinux is disabled or in
enforcing or permissive mode - as these modes are kernel specific and
only tells the kernel how it should do SELinux checks.  If the binary is
moved to another box without libselinux.so, that's a hack, and it would
still not work even if you had a --setcon parameter to OpenVPN.


kind regards,

David Sommerseth

> On Tue, Jul 28, 2009 at 4:20 PM, Alon Bar-Lev<alon.barlev@...277...> wrote:
>> I don't understand you guys.
>>
>> I never said do not use SELinux, or that SELinux does not have advantages.
>> I know perfectly what the advantages are.
>>
>> BUT it is much easier to create profile to unprivileged user that runs
>> OpenVPN than a profile of a daemon that needs special rights.
>>
>> As far as I learned, when security is concerned:
>> 1. Make your solution as simple as possible.
>> 2. Make the simple solution secure enough.
>> 3. Enhance the security using security products.
>>
>> When you try to do (3) before (1) you get unmanageable solution, which
>> in time also results in unsecured solution.
>>
>> Just my two cents.
>>
>> Alon.
>>
>> On Tue, Jul 28, 2009 at 5:05 PM, David
>> Sommerseth<openvpn.list@...1114...> wrote:
>>>
>>> Alon Bar-Lev wrote:
>>>> I do not understand, but it looks that two of you are searching for a
>>>> solution inside the box, while the solution is out side the box.
>>>>
>>>> I added the ability for OpenVPN to run using unprivileged user, yes,
>>>> please read it as-is, unprivileged user!!!
>>>> This means that you don't need any special permission to run OpenVPN.
>>>>
>>>> How did I manage to do this?
>>>>
>>>> Simply,
>>>> 1. Linux's tun device access may be enabled to a specific user or group.
>>>> 2. Wrap iproute2 calls.
>>> This is not what SELinux primarily solves, even though it also solves this
>>> too.  But it can restrict access to resources OpenVPN initially should only
>>> have.
>>>
>>> OpenVPN depends on devices in kernel space, even if you restrict that on the
>>> "normal" file system level (chmod 600 /dev/net/tun*), a bug/exploit in the
>>> device being used can still be used for privilege escalation.  This is one
>>> of the attack vectors SELinux tries to solve.  It makes sure the application
>>> do not get access to devices, files, processes, etc which is not defined in
>>> the security context - because this is possible attack vectors.
>>>
>>>> I am not against SELinux usage in OpenVPN. I just want you to be aware
>>>> that there is alternatives that can use OpenVPN without any special
>>>> right.
>>> Agreed, there are plenty of alternatives, but they only focus on the
>>> user-space area primarily, not kernel space.  In the wrapper you suggest,
>>> there is nothing here protecting against malformed information being sent to
>>> the wrapper around iproute2, combine that with some buffer overflows bugs in
>>> iproute2, and you have yet another attack vector.  Take a look after the
>>> latest cheddar_bay exploit being found recently.  Here several small flaws
>>> are used together to gain root shell access on a vulnerable system.
>>>
>>> SELinux will make it more difficult, as it is even more tricky to disable
>>> the SELinux controll mechanism on the way.
>>>
>>>
>>> Kind regards,
>>>
>>> David Sommerseth
>>>
>>>
>>>> On Tue, Jul 28, 2009 at 4:28 PM, David
>>>> Sommerseth<openvpn.list@...1114...> wrote:
>>>>> Alon Bar-Lev wrote:
>>>>>> I do not understand either.
>>>>>>
>>>>>> If you run OpenVPN from unprivileged user from startup, this apposed
>>>>>> of letting OpenVPN to setuid(), what do you need to protect in middle
>>>>>> of operation?
>>>>>>
>>>>>> On Tue, Jul 28, 2009 at 11:33 AM, Sebastien
>>>>>> Raveau<sebastien.raveau@...1231...> wrote:
>>>>>>> I'm not sure I understand you...
>>>>>>>
>>>>>>> As I explained in
>>>>>>> http://article.gmane.org/gmane.network.openvpn.devel/2700 it is indeed
>>>>>>> possible to apply SELinux "from the outside" of a program, like
>>>>>>> chroot, and just like chroot doing that is less efficient and less
>>>>>>> practical.
>>>>>>>
>>>>> I hope I'm not interrupting badly now.
>>>>>
>>>>> A little basic part, for those wanting to understand the depths. What
>>>>> SELinux provides is access control on different kind of layers inside the
>>>>> kernel space, also on system calls.  For a brief overview over SELinux,
>>>>> have
>>>>> a look here:
>>>>> http://www.ibm.com/developerworks/linux/library/l-sppriv.html,
>>>>>
>>>>> http://www.ibm.com/developerworks/linux/library/l-selinux/index.html?S_TACT=105AGX03&S_CMP=EDU
>>>>> (A lot of more good SELinux information is available on IBM's
>>>>> developerWorks
>>>>> site)
>>>>>
>>>>> It makes sense to do a security context switch after OpenVPN has
>>>>> initialised
>>>>> and chrooted, then changing security context and drop the rest of the
>>>>> privileges.  In the new OpenVPN security context, it should then not be
>>>>> allowed to do any chrooting or network configuration (as this is a part
>>>>> of
>>>>> the initialisation, IMO), and even if possible, setuid() should be
>>>>> disallowed.  That way you can really lock down everything OpenVPN should
>>>>> not
>>>>> do - just allowing what it needs to do.  Basically, the OpenVPN security
>>>>> context should only be allowed to write to log files, execute code in
>>>>> plug-ins, read a limited range of files, and read/write to a network
>>>>> device
>>>>> granting access to the openvpn context.
>>>>>
>>>>> What I am lacking in this patch, is a security context definition (at
>>>>> least
>>>>> an example of how to configure a proper context for OpenVPN).  Further;
>>>>> has
>>>>> it been investigated if there need to be done some other context changes
>>>>> to
>>>>> the TUN/TAP devices?  What about other files?  If a log file is labelled
>>>>> var_log_t, will the new openvpn security context be allowed to write to
>>>>> this
>>>>> log file?  How would this work with the security context of the directory
>>>>> of
>>>>> the log file? (It might be that the easy approach would to do logging via
>>>>> syslog())   Then what about plug-ins, how would OpenVPN work in these
>>>>> settings when the SELinux context is changed?  F.ex. how would this patch
>>>>> work against the down-root.so plugin?
>>>>>
>>>>> I do agree, implementing SELinux in the openvpn code is an important
>>>>> step!
>>>>>  But it seems to be just too easy to do setcon().  It is just missing a
>>>>> consequence analysis of what else needs to be changed in addition to this
>>>>> patch.
>>>>>
>>>>> I'm not an SELinux expert, and Sebastien might know far more about
>>>>> SElinux
>>>>>  than anyone of us.  I don't want to trample on anyone feet ... but I
>>>>> just
>>>>> wanted to have clarified these issues before I can give 100% support to
>>>>> this
>>>>> patch, as it just seemed to be too easy.
>>>>>
>>>>>
>>>>> --
>>>>> kind regards,
>>>>>
>>>>> David Sommerseth
>>>>>
>>>>>
>>>>>
> 
> 
> 


