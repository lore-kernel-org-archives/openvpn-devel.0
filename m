MIME-Version: 1.0
References: <1538229228-10620-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1538229228-10620-1-git-send-email-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 1 Oct 2018 14:10:56 +0300
Message-ID: <CAGyAFMX_aMRUgLN3b96N3bTEvyKxVX0En_1O3mKLvbVMMJkVnQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000a38fcc057728dc84"
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
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--000000000000a38fcc057728dc84
Content-Type: text/plain; charset="UTF-8"

Hi,

Thanks, I tested on Windows 10 with Visual Studio build and works as
expected.

A few nitpicks:

+    if (!WriteFile(pipe, &dhcp, sizeof(dhcp), &len, NULL)
> +        || !ReadFile(pipe, &ack, sizeof(ack), &len, NULL))
> +    {
> +        msg(M_WARN, "TUN: could not talk to service: %s [%lu]",
> +            strerror_win32(GetLastError(), &gc), GetLastError());
> +        goto out;
> +    }
>

A very similar code (communicate with service) is used in
do_address_service and do_dns6_service, so
how about factoring that code into separate method?



> +    /* Path of netsh */
> +    int n = GetSystemDirectory(argv0, MAX_PATH);
> +    if (n > 0 && n < MAX_PATH) /* got system directory */
> +    {
> +        wcsncat(argv0, L"\\netsh.exe", MAX_PATH - n - 1);
> +    }
> +    else
> +    {
> +        wcsncpy(argv0, L"C:\\Windows\\system32\\netsh.exe", MAX_PATH);
> +    }
>

Same as above (code in netsh_dns_cmd).



> +    /* max cmdline length in wchars -- include room for if index */
> +    size_t ncmdline = wcslen(fmt) + 10 + 1;
>

Maybe comment that 10 is a max string length of int type and 1 is a nul
terminator (do we need it here?).

-Lev

--000000000000a38fcc057728dc84
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Thanks, I tested on Windows 10 with=
 Visual Studio build and works as expected.</div><div><br></div><div>A few =
nitpicks:</div><div><br></div><div><div class=3D"gmail_quote"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">+=C2=A0 =C2=A0 if (!WriteFile(pipe, &a=
mp;dhcp, sizeof(dhcp), &amp;len, NULL)<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 || !=
ReadFile(pipe, &amp;ack, sizeof(ack), &amp;len, NULL))<br>+=C2=A0 =C2=A0 {<=
br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;TUN: could not talk to se=
rvice: %s [%lu]&quot;,<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strerr=
or_win32(GetLastError(), &amp;gc), GetLastError());<br>+=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto out;<br>+=C2=A0 =C2=A0 }<br></blockquote><div><br></div><di=
v>A very similar code (communicate with service) is used in do_address_serv=
ice and do_dns6_service, so=C2=A0</div><div>how about factoring that code i=
nto separate method?</div><div><br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">+=C2=A0 =C2=A0 /* Path of netsh */<br>+=C2=
=A0 =C2=A0 int n =3D GetSystemDirectory(argv0, MAX_PATH);<br>+=C2=A0 =C2=A0=
 if (n &gt; 0 &amp;&amp; n &lt; MAX_PATH) /* got system directory */<br>+=
=C2=A0 =C2=A0 {<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wcsncat(argv0, L&quot;\\net=
sh.exe&quot;, MAX_PATH - n - 1);<br>+=C2=A0 =C2=A0 }<br>+=C2=A0 =C2=A0 else=
<br>+=C2=A0 =C2=A0 {<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wcsncpy(argv0, L&quot;=
C:\\Windows\\system32\\netsh.exe&quot;, MAX_PATH);<br>+=C2=A0 =C2=A0 }<br><=
/blockquote><div><br></div><div>Same as above (code in netsh_dns_cmd).</div=
><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">+=C2=A0 =C2=A0 /* max cmdline length in wchars -- include room for =
if index */<br>+=C2=A0 =C2=A0 size_t ncmdline =3D wcslen(fmt) + 10 + 1;<br>=
</blockquote><div><br></div><div>Maybe comment that 10 is a max string leng=
th of int type and 1 is a nul terminator (do we need it here?).</div></div>=
</div><div class=3D"gmail_quote"><div dir=3D"ltr"><br></div></div><div dir=
=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature">-Lev<=
/div></div>

--000000000000a38fcc057728dc84--

