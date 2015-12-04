MIME-Version: 1.0
In-Reply-To: <5661214C.8040905@...2070...>
References: <565A3985.3030800@...1227...>
	<1448835033-24287-1-git-send-email-iam@...2070...>
	<CAKuzo_iVJWYj9v3UtdYscBG1BvfwYj33TMrr0b48tk5n_yXxCQ@...278...>
	<5660EA2A.1020903@...515...> <5661214C.8040905@...2070...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 4 Dec 2015 00:50:37 -0500
Message-ID: <CAKuzo_ja1WDLP3V=X_amn70t2Yj6zyNV7H4LU5vg+mAsqY6Nag@...278...>
Content-Type: multipart/alternative; boundary=001a114b2a5260150805260c17f7
Subject: Re: [Openvpn-devel] [PATCH v7-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <iam@...2070...>
Cc: James Yonan <james@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114b2a5260150805260c17f7
Content-Type: text/plain; charset=UTF-8

Hi,

On Fri, Dec 4, 2015 at 12:14 AM, ValdikSS <iam@...2070...> wrote:

> These issues should be fixed. Please check PATCH v7.
>

I think you missed the NET_LUID one. I had thought this was fixed earlier,
but v7 still has this issue

On 04.12.2015 04:19, James Yonan wrote:
> > These may have been fixed by now, but noticed some issues in the
> original patch that was discussed in the OpenVPN-devel IRC meeting several
> weeks ago.
> >
> > * win_adapter_index_to_luid is declared to return a
> >   NET_LUID but not all code paths return a value.
>

The relevant code is

+ if (ConvertInterfaceIndexToLuid(index, &tapluid) == NO_ERROR)
+       dmsg (D_LOW, "Tap Luid: %I64d", tapluid.Value);

which leaves tapluid undefined if there was an error.

Selva

--001a114b2a5260150805260c17f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Fri, Dec 4, 2015 at 12:14 AM, Va=
ldikSS <span dir=3D"ltr">&lt;<a href=3D"mailto:iam@...2070..." target=3D"_b=
lank">iam@...2070...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">These issues should be fixed. Please check PATCH v7.<b=
r></blockquote><div><br>I think you missed the NET_LUID one. I had thought =
this was fixed earlier, but v7 still has this issue<br><br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<div><div>On 04.12.2015 04:19, James Yonan wrote:<br>
&gt; These may have been fixed by now, but noticed some issues in the origi=
nal patch that was discussed in the OpenVPN-devel IRC meeting several weeks=
 ago.<br>
&gt;<br>
&gt; * win_adapter_index_to_luid is declared to return a<br>
&gt;=C2=A0 =C2=A0NET_LUID but not all code paths return a value.<br></div><=
/div></blockquote><br></div><div class=3D"gmail_quote">The relevant code is=
<br><br>+ if (ConvertInterfaceIndexToLuid(index, &amp;tapluid) =3D=3D NO_ER=
ROR)<br>+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dmsg (D_LOW, &quot;Tap Luid: %I64d=
&quot;, tapluid.Value);<br></div><br></div><div class=3D"gmail_extra">which=
 leaves tapluid undefined if there was an error.<br><br></div><div class=3D=
"gmail_extra">Selva<br></div><div class=3D"gmail_extra"><br></div></div>

--001a114b2a5260150805260c17f7--

