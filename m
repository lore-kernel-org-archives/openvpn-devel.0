MIME-Version: 1.0
In-Reply-To: <20171102192115.336-1-simon@...2293...>
References: <CAKuzo_gAf8be+-mMijjn0YqA+rxoRPH0ZpEkG7LNv_6+3+oQgw@...278...>
 <20171102192115.336-1-simon@...2293...>
From: Selva <selva.nair@...277...>
Date: Thu, 2 Nov 2017 23:26:44 -0400
Message-ID: <CAKuzo_iidZQh1G9mCgnvu-j9iABO96M7mdvZACpXG7o9Fo-spw@...278...>
Content-Type: multipart/alternative; boundary="94eb2c059008c59869055d0bad76"
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

--94eb2c059008c59869055d0bad76
Content-Type: text/plain; charset="UTF-8"

Hi Simon,

On Thu, Nov 2, 2017 at 3:21 PM, Simon Rozman <simon@...2293...> wrote:

> While openvpn.exe can run multiple concurrent processes, openvpnserv.exe
> is usually only one single globally unique running process.
>
> This patch extends openvpnserv.exe to support multiple service instances
> in parallel allowing side-by-side OpenVPN installations.
>

That was fast. On a quick glance, looks good but the patch does not apply
on current master. Did you base it on some of your recent patches not
all of which are yet merged? Looks like the contexts in common.c and
interactive.c do not match so the patch fails.

Hi,
>
> RegisterServiceCtrlHandlerEx() is obviously happy with any service

name for `SERVICE_WIN32_OWN_PROCESS` service types. I have

tested it.
>

Oh, really? I didn't think that would be the case. Looking at the docs
again,
the older non-Ex variant (RegisterServiceCtrlHandler()) does state that the
name is not checked in case of OWN_PROCESS. Probably that got carried
over to the ...Ex() though not documented as such.

Cheers,

Selva

--94eb2c059008c59869055d0bad76
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Simon,<div class=3D"gmail_extra"><br><div class=3D"gmai=
l_quote">On Thu, Nov 2, 2017 at 3:21 PM, Simon Rozman <span dir=3D"ltr">&lt=
;<a href=3D"mailto:simon@...2293..." target=3D"_blank">simon@...2293...</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">While openvpn.exe can =
run multiple concurrent processes, openvpnserv.exe<br>
is usually only one single globally unique running process.<br>
<br>
This patch extends openvpnserv.exe to support multiple service instances<br>
in parallel allowing side-by-side OpenVPN installations.<br></blockquote><d=
iv><br></div><div>That was fast. On a quick glance, looks good but the patc=
h does not apply</div><div>on current master. Did you base it on some of yo=
ur recent patches not</div><div>all of which are yet merged? Looks like the=
 contexts in common.c and</div><div>interactive.c do not match so the patch=
 fails.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Hi,<br>
<br>
RegisterServiceCtrlHandlerEx() is obviously happy with any service=C2=A0</b=
lockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">name for `SERVICE_WIN32_OWN_PROCES=
S` service types. I have=C2=A0</blockquote><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">t=
ested it.<br></blockquote><div><br></div><div>Oh, really? I didn&#39;t thin=
k that would be the case. Looking at the docs again,</div><div>the older no=
n-Ex variant (RegisterServiceCtrlHandler()) does state that the</div><div>n=
ame is not checked in case of OWN_PROCESS. Probably that got carried</div><=
div>over to the ...Ex() though not documented as such.</div><div><br></div>=
<div>Cheers,</div><div><br></div><div>Selva</div></div></div></div>

--94eb2c059008c59869055d0bad76--

