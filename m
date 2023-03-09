From: Kristof Provost <kprovost@...2661...>
Date: Thu, 09 Mar 2023 13:13:25 +0100
Message-ID: <72CE0EE5-EF58-4AAB-A4A7-E5608AE160EC@...2661...>
In-Reply-To: <dec5d3c5-4a93-3d42-8c90-51a45af0801e@...1227...>
References: <20230309092635.7450-1-kprovost@...2661...>
 <dec5d3c5-4a93-3d42-8c90-51a45af0801e@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] dco: print FreeBSD version
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 9 Mar 2023, at 13:06, Arne Schwabe wrote:
> Am 09.03.23 um 10:26 schrieb Kristof Provost via Openvpn-devel:
>> From: Kristof Provost <kp@...1376...>
>>
>> Implement dco_version_string() for FreeBSD.
>> Unlike Linux and Windows the DCO driver is built into the operating
>> system itself, so we log the OS version as a proxy for the DCO version.
>> ---
>>   src/openvpn/dco_freebsd.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
>> index 2b94b2a2..a5e96bb2 100644
>> --- a/src/openvpn/dco_freebsd.c
>> +++ b/src/openvpn/dco_freebsd.c
>> @@ -31,6 +31,8 @@
>>   #include <sys/param.h>
>>   #include <sys/linker.h>
>>   #include <sys/nv.h>
>> +#include <sys/utsname.h>
>> +
>>   #include <netinet/in.h>
>>    #include "dco_freebsd.h"
>> @@ -627,7 +629,17 @@ out:
>>   const char *
>>   dco_version_string(struct gc_arena *gc)
>>   {
>> -    return "v0";
>> +    struct utsname name;
>> +    struct buffer out =3D alloc_buf_gc(256, gc);
>> +    int ret;
>> +
>> +    ret =3D uname(&name);
>> +    if (ret !=3D 0)
>> +        return "N/A";
>
> There should be { around the return

I=E2=80=99ll fix that.

>> +
>> +    buf_printf(&out, "%s", name.version);
>> +
>> +    return (char *)out.data;
>
> This should use BSTR(data) instead.
>
I copied Antonio=E2=80=99s code here, but that is better, so I=E2=80=99ll f=
ix that too.

> Instead of copying/printf, you could also just do:
>
>     struct utsname* uts;
>     ALLOC_OBJ_GC(uts, struct utsname, gc);
>
>
>     if (uname(&name) !=3D 0)
>     {
>         return "N/A";
>     }
>
>     return uts->name;
>
I was going to object that we can=E2=80=99t return stack variables, but tha=
t=E2=80=99s an allocation of utsname, and it removes an intermediate step, =
so yeah, that=E2=80=99s better too (and means I can just copy your code, ca=
ll it my own and pretend I did work ;))

Thanks.
Kristof

