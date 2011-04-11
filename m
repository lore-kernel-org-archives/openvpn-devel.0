MIME-Version: 1.0
In-Reply-To: <BANLkTinUx4T46adbiRtUWJ6ueOPGUdZ3eQ@...278...>
References: <BANLkTi=-c2jxGcNj=+gdujJhhDjwrWP2TQ@...278...>
	<BANLkTimGuA_zJ+H_e9wkDsh-cmar7OTq+Q@...278...>
	<BANLkTinUx4T46adbiRtUWJ6ueOPGUdZ3eQ@...278...>
Date: Tue, 12 Apr 2011 00:28:38 +0300
Message-ID: <BANLkTime4hkxrSdbKVg=Sfc2WWTL=gCwoA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: crocket <crockabiscuit@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Into configure.ac you add something like:
---
AC_ARG_ENABLE(
        [capabilities],
        [AS_HELP_STRING([--enable-capabilities],[enable Linux
capabilities @<:@disabled@:>@])],
        ,
        [enable_capabilities=3D"no"]
)
test "${enable_capabilities}" =3D "yes" &&
AC_DEFINE([ENABLE_CAPABILITIES], [1], [enable Linux capabilities])
---

Then in source you test for:
#ifdef ENABLE_CAPABILITIES

Alon.


On Tue, Apr 12, 2011 at 12:03 AM, crocket <crockabiscuit@...277...> wrote:
> How do I enable it via autoconf?
>
> On Tue, Apr 12, 2011 at 5:37 AM, Alon Bar-Lev <alon.barlev@...277...> wro=
te:
>> Usually, using cap should be enabled/disabled via autoconf.
>>
>> On Mon, Apr 11, 2011 at 11:23 PM, crocket <crockabiscuit@...277...> wrot=
e:
>>>
>>> diff -Naur a/init.c b/init.c
>>> --- a/init.c =C2=A0 =C2=A02010-11-05 04:29:02.000000000 +0900
>>> +++ b/init.c =C2=A0 =C2=A02011-04-12 05:11:43.540370471 +0900
>>> @@ -41,6 +41,10 @@
>>>
>>> =C2=A0#include "occ-inline.h"
>>>
>>> +#ifdef TARGET_LINUX
>>> +#include <sys/prctl.h>
>>> +#endif
>>> +
>>> =C2=A0static struct context *static_context; /* GLOBAL */
>>>
>>> =C2=A0/*
>>> @@ -904,6 +908,10 @@
>>> =C2=A0 =C2=A0 =C2=A0 if (no_delay)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0{
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_group (&c0->group_state);
>>> +#ifdef TARGET_LINUX
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 if(prctl(PR_SET_KEEPCAPS, 1) < 0)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_ERR, "prctl(PR_SET_KEEPCAPS=
, 1) failed");
>>> +#endif
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_user (&c0->user_state);
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c0->uid_gid_set =3D true;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>>
>>> The patch is above.
>>> I had been investigating why OpenVPN refused to use CAP_IPC_LOCK capabi=
lity.
>>> I found out that it was because OpenVPN invoked setuid and setuid
>>> erased POSIX capabilities.
>>> prctl(PR_SET_KEEPCAPS, 1) lets OpenVPN keep capabilities after setuid
>>> invocation.
>>>
>>> Thanks in advance for considering this patch.
>>>
>>> -----------------------------------------------------------------------=
-------
>>> Forrester Wave Report - Recovery time is now measured in hours and minu=
tes
>>> not days. Key insights are discussed in the 2010 Forrester Wave Report =
as
>>> part of an in-depth evaluation of disaster recovery service providers.
>>> Forrester found the best-in-class provider in terms of services and vis=
ion.
>>> Read this report now! =C2=A0http://p.sf.net/sfu/ibm-webcastpromo
>>> _______________________________________________
>>> Openvpn-devel mailing list
>>> Openvpn-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
>

