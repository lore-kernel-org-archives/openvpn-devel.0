MIME-Version: 1.0
In-Reply-To: <BANLkTime4hkxrSdbKVg=Sfc2WWTL=gCwoA@...278...>
References: <BANLkTi=-c2jxGcNj=+gdujJhhDjwrWP2TQ@...278...>
	<BANLkTimGuA_zJ+H_e9wkDsh-cmar7OTq+Q@...278...>
	<BANLkTinUx4T46adbiRtUWJ6ueOPGUdZ3eQ@...278...>
	<BANLkTime4hkxrSdbKVg=Sfc2WWTL=gCwoA@...278...>
Date: Tue, 12 Apr 2011 07:07:17 +0900
Message-ID: <BANLkTikFp73sFw0+zL7xNTn2G1-1QH_NRQ@...278...>
From: crocket <crockabiscuit@...277...>
Subject: Re: [Openvpn-devel] I made a patch that prevents POSIX capabilities
 from disappearing during UID downgrade.
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
To: Alon Bar-Lev <alon.barlev@...277...>, openvpn-devel@lists.sourceforge.net

Why don't you submit a patch for this?
Although my patch doesn't seem to make OpenVPN retain linux
capabilities during UID downgrade, if you made a patch that includes
my patch, linux people would appreciate it.

On Tue, Apr 12, 2011 at 6:28 AM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> Into configure.ac you add something like:
> ---
> AC_ARG_ENABLE(
> =A0 =A0 =A0 =A0[capabilities],
> =A0 =A0 =A0 =A0[AS_HELP_STRING([--enable-capabilities],[enable Linux
> capabilities @<:@disabled@:>@])],
> =A0 =A0 =A0 =A0,
> =A0 =A0 =A0 =A0[enable_capabilities=3D"no"]
> )
> test "${enable_capabilities}" =3D "yes" &&
> AC_DEFINE([ENABLE_CAPABILITIES], [1], [enable Linux capabilities])
> ---
>
> Then in source you test for:
> #ifdef ENABLE_CAPABILITIES
>
> Alon.
>
>
> On Tue, Apr 12, 2011 at 12:03 AM, crocket <crockabiscuit@...277...> wrote:
>> How do I enable it via autoconf?
>>
>> On Tue, Apr 12, 2011 at 5:37 AM, Alon Bar-Lev <alon.barlev@...277...> wr=
ote:
>>> Usually, using cap should be enabled/disabled via autoconf.
>>>
>>> On Mon, Apr 11, 2011 at 11:23 PM, crocket <crockabiscuit@...277...> wro=
te:
>>>>
>>>> diff -Naur a/init.c b/init.c
>>>> --- a/init.c =A0 =A02010-11-05 04:29:02.000000000 +0900
>>>> +++ b/init.c =A0 =A02011-04-12 05:11:43.540370471 +0900
>>>> @@ -41,6 +41,10 @@
>>>>
>>>> =A0#include "occ-inline.h"
>>>>
>>>> +#ifdef TARGET_LINUX
>>>> +#include <sys/prctl.h>
>>>> +#endif
>>>> +
>>>> =A0static struct context *static_context; /* GLOBAL */
>>>>
>>>> =A0/*
>>>> @@ -904,6 +908,10 @@
>>>> =A0 =A0 =A0 if (no_delay)
>>>> =A0 =A0 =A0 =A0{
>>>> =A0 =A0 =A0 =A0 =A0set_group (&c0->group_state);
>>>> +#ifdef TARGET_LINUX
>>>> + =A0 =A0 =A0 =A0 if(prctl(PR_SET_KEEPCAPS, 1) < 0)
>>>> + =A0 =A0 =A0 =A0 =A0 msg (M_ERR, "prctl(PR_SET_KEEPCAPS, 1) failed");
>>>> +#endif
>>>> =A0 =A0 =A0 =A0 =A0set_user (&c0->user_state);
>>>> =A0 =A0 =A0 =A0 =A0c0->uid_gid_set =3D true;
>>>> =A0 =A0 =A0 =A0}
>>>>
>>>> The patch is above.
>>>> I had been investigating why OpenVPN refused to use CAP_IPC_LOCK capab=
ility.
>>>> I found out that it was because OpenVPN invoked setuid and setuid
>>>> erased POSIX capabilities.
>>>> prctl(PR_SET_KEEPCAPS, 1) lets OpenVPN keep capabilities after setuid
>>>> invocation.
>>>>
>>>> Thanks in advance for considering this patch.
>>>>
>>>> ----------------------------------------------------------------------=
--------
>>>> Forrester Wave Report - Recovery time is now measured in hours and min=
utes
>>>> not days. Key insights are discussed in the 2010 Forrester Wave Report=
 as
>>>> part of an in-depth evaluation of disaster recovery service providers.
>>>> Forrester found the best-in-class provider in terms of services and vi=
sion.
>>>> Read this report now! =A0http://p.sf.net/sfu/ibm-webcastpromo
>>>> _______________________________________________
>>>> Openvpn-devel mailing list
>>>> Openvpn-devel@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>>
>>
>

