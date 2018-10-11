MIME-Version: 1.0
References: <CAGyAFMULV02g3gyCbvQ1+L+cMdE4UZMmzVfey-T1g4Y0NcmKeg@...278...>
 <1539174377-2678-1-git-send-email-lstipakov@...277...>
 <20181010185023.GD962@...1296...>
In-Reply-To: <20181010185023.GD962@...1296...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 11 Oct 2018 13:40:16 +0300
Message-ID: <CAGyAFMVqTChKmpfTY0XhdJB+q030LkxDCsitEwVrwV2Ui8bJdQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000003275960577f1993f"
Subject: Re: [Openvpn-devel] [PATCH v2] options.c: fix broken unary minus
 usage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--0000000000003275960577f1993f
Content-Type: text/plain; charset="UTF-8"

Hi,


> Since crypto_overhead and crypto_max_overhead() are both size_t, and
> frame_add_to_extra_frame() is declared to take an "unsigned int" now,
> this cast should not be necessary.


Visual Studio disagrees. Without explicit cast I got

> warning C4267: 'function': conversion from 'size_t' to 'const unsigned
int', possible loss of data

https://docs.microsoft.com/fi-fi/cpp/error-messages/compiler-warnings/compiler-warning-level-3-c4267?view=vs-2017


'var' : conversion from 'size_t' to 'type', possible loss of data
The compiler detected a conversion from size_t to a smaller type.


> Unnecessary casts hide bugs and hurt my eyes...
>

OTOH this is level 3 warning, which we have over 500. Since we'll probably
change level warning to 2 and
GCC doesn't complain, I'll remove it.

Maybe call the negative increment a "decrement" instead?
>

Yes.

Otherwise indeed much clearer.
>

V3 is on its way.

-- 
-Lev

--0000000000003275960577f1993f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hi,<br><div class=3D"gma=
il_quote"><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
Since crypto_overhead and crypto_max_overhead() are both size_t, and <br>
frame_add_to_extra_frame() is declared to take an &quot;unsigned int&quot; =
now, <br>
this cast should not be necessary.</blockquote><div><br></div><div>Visual S=
tudio disagrees. Without explicit cast I got</div><div><br></div><div>&gt; =
warning C4267: &#39;function&#39;: conversion from &#39;size_t&#39; to &#39=
;const unsigned int&#39;, possible loss of data</div><div><br></div><div><a=
 href=3D"https://docs.microsoft.com/fi-fi/cpp/error-messages/compiler-warni=
ngs/compiler-warning-level-3-c4267?view=3Dvs-2017">https://docs.microsoft.c=
om/fi-fi/cpp/error-messages/compiler-warnings/compiler-warning-level-3-c426=
7?view=3Dvs-2017</a>=C2=A0=C2=A0<br></div><div class=3D"gmail_quote"><br></=
div>&#39;var&#39; : conversion from &#39;size_t&#39; to &#39;type&#39;, pos=
sible loss of data<br>The compiler detected a conversion from size_t to a s=
maller type.<div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
Unnecessary casts hide bugs and hurt my eyes...<br></blockquote><div><br></=
div><div>OTOH this is level 3 warning, which we have over 500. Since we&#39=
;ll probably change level warning to 2 and=C2=A0</div><div>GCC doesn&#39;t =
complain, I&#39;ll remove it.</div><div><br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
Maybe call the negative increment a &quot;decrement&quot; instead?<br></blo=
ckquote><div><br></div><div>Yes.=C2=A0</div><div><br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
Otherwise indeed much clearer.<br></blockquote><div><br></div><div>V3 is on=
 its way.</div><div><br></div></div>-- <br><div dir=3D"ltr" class=3D"gmail_=
signature">-Lev</div></div></div></div>

--0000000000003275960577f1993f--

