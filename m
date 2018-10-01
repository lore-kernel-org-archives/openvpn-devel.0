MIME-Version: 1.0
References: <1538229228-10620-1-git-send-email-selva.nair@...277...>
 <CAGyAFMX_aMRUgLN3b96N3bTEvyKxVX0En_1O3mKLvbVMMJkVnQ@...278...>
In-Reply-To: <CAGyAFMX_aMRUgLN3b96N3bTEvyKxVX0En_1O3mKLvbVMMJkVnQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 1 Oct 2018 11:35:46 -0400
Message-ID: <CAKuzo_hFxC5kPFtjV9MYYd1M9DjE0HktUFRGNPNxiwiT49PSDg@...278...>
Content-Type: multipart/alternative; boundary="0000000000003ca2ff05772c903e"
Subject: Re: [Openvpn-devel] [PATCH] Enable dhcp on tap adapter using
 interactive service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000003ca2ff05772c903e
Content-Type: text/plain; charset="UTF-8"

Hi,

Thanks for the review and comments. A quick reply below, will send a v2
later.

On Mon, Oct 1, 2018 at 7:11 AM Lev Stipakov <lstipakov@...277...> wrote:

> Hi,
>
> Thanks, I tested on Windows 10 with Visual Studio build and works as
> expected.
>
> A few nitpicks:
>
> +    if (!WriteFile(pipe, &dhcp, sizeof(dhcp), &len, NULL)
>> +        || !ReadFile(pipe, &ack, sizeof(ack), &len, NULL))
>> +    {
>> +        msg(M_WARN, "TUN: could not talk to service: %s [%lu]",
>> +            strerror_win32(GetLastError(), &gc), GetLastError());
>> +        goto out;
>> +    }
>>
>
> A very similar code (communicate with service) is used in
> do_address_service and do_dns6_service, so
> how about factoring that code into separate method?
>

Sounds like a good idea. As this affects a number of unrelated contexts,
will follow up with a refactoring patch.


>
>
>> +    /* Path of netsh */
>> +    int n = GetSystemDirectory(argv0, MAX_PATH);
>> +    if (n > 0 && n < MAX_PATH) /* got system directory */
>> +    {
>> +        wcsncat(argv0, L"\\netsh.exe", MAX_PATH - n - 1);
>> +    }
>> +    else
>> +    {
>> +        wcsncpy(argv0, L"C:\\Windows\\system32\\netsh.exe", MAX_PATH);
>> +    }
>>
>
>
Same as above (code in netsh_dns_cmd).
>

Will do in v2.


>
>
>
>> +    /* max cmdline length in wchars -- include room for if index */
>> +    size_t ncmdline = wcslen(fmt) + 10 + 1;
>>
>
> Maybe comment that 10 is a max string length of int type and 1 is a nul
> terminator (do we need it here?).
>

Extra room for NUL is strictly not necessary as there is space in the
format specifier "%d" etc. Still, I think its better to have an explicit +1.

Selva

--0000000000003ca2ff05772c903e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br><br></div>Thanks for the review and comments. =
A quick reply below, will send a v2 later.<br><br><div class=3D"gmail_quote=
"><div dir=3D"ltr">On Mon, Oct 1, 2018 at 7:11 AM Lev Stipakov &lt;<a href=
=3D"mailto:lstipakov@...277...">lstipakov@...277...</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi,<div><br></div><div>Tha=
nks, I tested on Windows 10 with Visual Studio build and works as expected.=
</div><div><br></div><div>A few nitpicks:</div><div><br></div><div><div cla=
ss=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">+=C2=
=A0 =C2=A0 if (!WriteFile(pipe, &amp;dhcp, sizeof(dhcp), &amp;len, NULL)<br=
>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 || !ReadFile(pipe, &amp;ack, sizeof(ack), &am=
p;len, NULL))<br>+=C2=A0 =C2=A0 {<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WAR=
N, &quot;TUN: could not talk to service: %s [%lu]&quot;,<br>+=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 strerror_win32(GetLastError(), &amp;gc), GetLas=
tError());<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>+=C2=A0 =C2=A0 }<br=
></blockquote><div><br></div><div>A very similar code (communicate with ser=
vice) is used in do_address_service and do_dns6_service, so=C2=A0</div><div=
>how about factoring that code into separate method?</div></div></div></div=
></blockquote><div><br></div><div>Sounds like a good idea. As this affects =
a number of unrelated contexts, will follow up with a refactoring patch.<br=
><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div><div class=
=3D"gmail_quote"><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">+=C2=A0 =C2=A0 /* Path of netsh */<br>+=C2=A0 =C2=
=A0 int n =3D GetSystemDirectory(argv0, MAX_PATH);<br>+=C2=A0 =C2=A0 if (n =
&gt; 0 &amp;&amp; n &lt; MAX_PATH) /* got system directory */<br>+=C2=A0 =
=C2=A0 {<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wcsncat(argv0, L&quot;\\netsh.exe&=
quot;, MAX_PATH - n - 1);<br>+=C2=A0 =C2=A0 }<br>+=C2=A0 =C2=A0 else<br>+=
=C2=A0 =C2=A0 {<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wcsncpy(argv0, L&quot;C:\\W=
indows\\system32\\netsh.exe&quot;, MAX_PATH);<br>+=C2=A0 =C2=A0 }<br></bloc=
kquote><div>=C2=A0<br></div></div></div></div></blockquote><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"><div dir=3D"ltr"><div><div class=3D"gmail_quote"><div></div>=
<div>Same as above (code in netsh_dns_cmd).</div></div></div></div></blockq=
uote><div><br></div><div>Will do in v2.<br>=C2=A0<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"><div dir=3D"ltr"><div><div class=3D"gmail_quote"><div><br></=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">+=C2=
=A0 =C2=A0 /* max cmdline length in wchars -- include room for if index */<=
br>+=C2=A0 =C2=A0 size_t ncmdline =3D wcslen(fmt) + 10 + 1;<br></blockquote=
><div><br></div><div>Maybe comment that 10 is a max string length of int ty=
pe and 1 is a nul terminator (do we need it here?).</div></div></div></div>=
</blockquote><div><br></div><div>Extra room for NUL is strictly not necessa=
ry as there is space in the format specifier &quot;%d&quot; etc. Still, I t=
hink its better to have an explicit +1.<br><br></div><div>Selva<br></div></=
div></div>

--0000000000003ca2ff05772c903e--

