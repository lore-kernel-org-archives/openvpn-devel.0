MIME-Version: 1.0
In-Reply-To: <4A6EFCFF.2090400@...1114...>
References: <4A5EFE61.3020100@...41...> <4A5F9A9C.7000805@...41...>
	<20090727212401.GA13327@...33...>
	<3453b4110907280049h110ff9c1hf5639d619bdee6e1@...278...>
	<9e0cf0bf0907280059p482c20a8t1aaecab19162c8f@...278...>
	<3453b4110907280112m53e7c0fena3ec779eb41141f0@...278...>
	<9e0cf0bf0907280118t14949a47o5bb1bdefbb0721f5@...278...>
	<3453b4110907280133n32070ed3rd93598fd1b64740e@...278...>
	<9e0cf0bf0907280218p25c081f7v203b4780309cb6b9@...278...>
	<4A6EFCFF.2090400@...1114...>
Date: Tue, 28 Jul 2009 16:50:05 +0300
Message-ID: <9e0cf0bf0907280650i3dabf036gc9e2f8c745823e15@...278...>
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

I do not understand, but it looks that two of you are searching for a
solution inside the box, while the solution is out side the box.

I added the ability for OpenVPN to run using unprivileged user, yes,
please read it as-is, unprivileged user!!!
This means that you don't need any special permission to run OpenVPN.

How did I manage to do this?

Simply,
1. Linux's tun device access may be enabled to a specific user or group.
2. Wrap iproute2 calls.

So I run OpenVPN completely in unprivileged mode, it can access the
tun device, then when it wish to alter network configuration it can do
so by the wrapper (I used sudo for this).

Most OpenVPN configuration requires more than one time network settings.

In stead of sudo wrapper you can use SELinux enabled wrapper.

The advantage of sudo wrapper is that it is simple, and the script can
check if the new network configuration is valid for OpenVPN usage.

I am not against SELinux usage in OpenVPN. I just want you to be aware
that there is alternatives that can use OpenVPN without any special
right.

Alon.


On Tue, Jul 28, 2009 at 4:28 PM, David
Sommerseth<openvpn.list@...1114...> wrote:
> Alon Bar-Lev wrote:
>>
>> I do not understand either.
>>
>> If you run OpenVPN from unprivileged user from startup, this apposed
>> of letting OpenVPN to setuid(), what do you need to protect in middle
>> of operation?
>>
>> On Tue, Jul 28, 2009 at 11:33 AM, Sebastien
>> Raveau<sebastien.raveau@...1231...> wrote:
>>>
>>> I'm not sure I understand you...
>>>
>>> As I explained in
>>> http://article.gmane.org/gmane.network.openvpn.devel/2700 it is indeed
>>> possible to apply SELinux "from the outside" of a program, like
>>> chroot, and just like chroot doing that is less efficient and less
>>> practical.
>>>
>
> I hope I'm not interrupting badly now.
>
> A little basic part, for those wanting to understand the depths. What
> SELinux provides is access control on different kind of layers inside the
> kernel space, also on system calls. =C2=A0For a brief overview over SELin=
ux, have
> a look here: http://www.ibm.com/developerworks/linux/library/l-sppriv.htm=
l,
> http://www.ibm.com/developerworks/linux/library/l-selinux/index.html?S_TA=
CT=3D105AGX03&S_CMP=3DEDU
> (A lot of more good SELinux information is available on IBM's developerWo=
rks
> site)
>
> It makes sense to do a security context switch after OpenVPN has initiali=
sed
> and chrooted, then changing security context and drop the rest of the
> privileges. =C2=A0In the new OpenVPN security context, it should then not=
 be
> allowed to do any chrooting or network configuration (as this is a part of
> the initialisation, IMO), and even if possible, setuid() should be
> disallowed. =C2=A0That way you can really lock down everything OpenVPN sh=
ould not
> do - just allowing what it needs to do. =C2=A0Basically, the OpenVPN secu=
rity
> context should only be allowed to write to log files, execute code in
> plug-ins, read a limited range of files, and read/write to a network devi=
ce
> granting access to the openvpn context.
>
> What I am lacking in this patch, is a security context definition (at lea=
st
> an example of how to configure a proper context for OpenVPN). =C2=A0Furth=
er; has
> it been investigated if there need to be done some other context changes =
to
> the TUN/TAP devices? =C2=A0What about other files? =C2=A0If a log file is=
 labelled
> var_log_t, will the new openvpn security context be allowed to write to t=
his
> log file? =C2=A0How would this work with the security context of the dire=
ctory of
> the log file? (It might be that the easy approach would to do logging via
> syslog()) =C2=A0 Then what about plug-ins, how would OpenVPN work in these
> settings when the SELinux context is changed? =C2=A0F.ex. how would this =
patch
> work against the down-root.so plugin?
>
> I do agree, implementing SELinux in the openvpn code is an important step!
> =C2=A0But it seems to be just too easy to do setcon(). =C2=A0It is just m=
issing a
> consequence analysis of what else needs to be changed in addition to this
> patch.
>
> I'm not an SELinux expert, and Sebastien might know far more about SElinux
> =C2=A0than anyone of us. =C2=A0I don't want to trample on anyone feet ...=
 but I just
> wanted to have clarified these issues before I can give 100% support to t=
his
> patch, as it just seemed to be too easy.
>
>
> --
> kind regards,
>
> David Sommerseth
>
>
>

