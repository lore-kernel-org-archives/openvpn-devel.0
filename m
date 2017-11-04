MIME-Version: 1.0
In-Reply-To: <CAKuzo_iidZQh1G9mCgnvu-j9iABO96M7mdvZACpXG7o9Fo-spw@...278...>
References: <CAKuzo_gAf8be+-mMijjn0YqA+rxoRPH0ZpEkG7LNv_6+3+oQgw@...278...>
 <20171102192115.336-1-simon@...2293...>
 <CAKuzo_iidZQh1G9mCgnvu-j9iABO96M7mdvZACpXG7o9Fo-spw@...278...>
From: Selva <selva.nair@...277...>
Date: Sat, 4 Nov 2017 15:59:52 -0400
Message-ID: <CAKuzo_iOXui4WDuRqf6-NybpfeWNjKR3GLn7dsw98FoNoSHNMw@...278...>
Content-Type: multipart/alternative; boundary="94eb2c0590085a4f28055d2daba4"
Subject: Re: [Openvpn-devel] [PATCH] openvpnserv: Add support for
 multi-instances
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c0590085a4f28055d2daba4
Content-Type: text/plain; charset="UTF-8"

Hi Simon,

On Thu, Nov 2, 2017 at 11:26 PM, Selva <selva.nair@...277...> wrote:

> Hi Simon,
>
> On Thu, Nov 2, 2017 at 3:21 PM, Simon Rozman <simon@...2293...> wrote:
>
>> While openvpn.exe can run multiple concurrent processes, openvpnserv.exe
>> is usually only one single globally unique running process.
>>
>> This patch extends openvpnserv.exe to support multiple service instances
>> in parallel allowing side-by-side OpenVPN installations.
>>
>
> That was fast. On a quick glance, looks good but the patch does not apply
> on current master. Did you base it on some of your recent patches not
> all of which are yet merged? Looks like the contexts in common.c and
> interactive.c do not match so the patch fails.
>

Even after the merge of pending patches this does not apply.

     openvpn_sntprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),
> -                      TEXT("\\\\.\\pipe\\" PACKAGE "\\service_%lu"),
> GetCurrentThreadId());
>

This shows the patch is based on a private branch. Currently the client
pipe is not named after
PACKAGE as this snippet would imply.


> +                      TEXT("\\\\.\\pipe\\%s\\service_%lu"),
> service_instance, GetCurrentThreadId());
>      ovpn_pipe = CreateNamedPipe(ovpn_pipe_name,
>                                  PIPE_ACCESS_DUPLEX |
> FILE_FLAG_FIRST_PIPE_INSTANCE | FILE_FLAG_OVERLAPPED,
>                                  PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE
> | PIPE_WAIT, 1, 128, 128, 0, NULL);


Could you please send a v2 rebased to current master?

Thanks,

Selva

--94eb2c0590085a4f28055d2daba4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Simon,<div class=3D"gmail_extra"><br><div class=3D"gmai=
l_quote">On Thu, Nov 2, 2017 at 11:26 PM, Selva <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div dir=3D"ltr">Hi Simon,<div class=3D"gmail_extra"><br><div class=3D"gmail=
_quote"><span class=3D"gmail-">On Thu, Nov 2, 2017 at 3:21 PM, Simon Rozman=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:simon@...2293..." target=3D"_blank=
">simon@...2293...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">While openvpn.exe can run multiple concurrent processes,=
 openvpnserv.exe<br>
is usually only one single globally unique running process.<br>
<br>
This patch extends openvpnserv.exe to support multiple service instances<br>
in parallel allowing side-by-side OpenVPN installations.<br></blockquote><d=
iv><br></div></span><div>That was fast. On a quick glance, looks good but t=
he patch does not apply</div><div>on current master. Did you base it on som=
e of your recent patches not</div><div>all of which are yet merged? Looks l=
ike the contexts in common.c and</div><div>interactive.c do not match so th=
e patch fails.</div></div></div></div></blockquote><div><br></div><div>Even=
 after the merge of pending patches this does not apply.=C2=A0</div><div><d=
iv><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0 =C2=
=A0 =C2=A0openvpn_sntprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),<br>- =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0TEXT(&quot;\\\\.\\pipe\\&quot; PACKAGE &quot;\\service_%lu&quot;), GetCu=
rrentThreadId());<br></blockquote><div><br></div><div><div>This shows the p=
atch is based on a private branch. Currently the client pipe is not named a=
fter</div><div>PACKAGE as this snippet would imply.</div></div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TEXT(&quot;\\\\.=
\\pipe\\%s\\service_%lu&quot;), service_instance, GetCurrentThreadId());<br=
>=C2=A0 =C2=A0 =C2=A0ovpn_pipe =3D CreateNamedPipe(ovpn_pipe_name,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PIPE_ACCESS_DUPLEX | FILE_FLAG_FIR=
ST_PIPE_INSTANCE | FILE_FLAG_OVERLAPPED,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_WAIT, 1, 128,=
 128, 0, NULL);</blockquote></div><div><div><br></div><div>Could you please=
 send a v2 rebased to current master?</div><div><br></div><div>Thanks,</div=
><div><br></div><div>Selva<br></div></div></div></div></div>

--94eb2c0590085a4f28055d2daba4--

