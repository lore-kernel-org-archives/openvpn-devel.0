MIME-Version: 1.0
References: <OpenVPN/openvpn-gui/issues/9@...1714...>
 <OpenVPN/openvpn-gui/issues/9/403117394@...1714...>
 <CAKuzo_jDCHm=VLc2wuKYJaf48Duy_4dHnbvHx4StVV6PjDausw@...278...>
 <CAEsd45Q87G=UTjt-PE29a41MFQU90_NJxmmux9=ZS=S7j=9E9A@...278...>
In-Reply-To: <CAEsd45Q87G=UTjt-PE29a41MFQU90_NJxmmux9=ZS=S7j=9E9A@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 17 Dec 2022 19:09:34 -0500
Message-ID: <CAKuzo_iNcK+B2Tg0a7LS+251JSnfHXd++Gy243+gtWOZx7VC=g@...278...>
Content-Type: multipart/alternative; boundary="00000000000072b8ea05f00f05dc"
Subject: Re: [Openvpn-devel] [OpenVPN/openvpn-gui] UI showing green
 connected status despite not beeing able to create a route (#9)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Cc: "Jonathan K. Bullard" <jkbullard@...277...>, Gert Doering <gert@...1296...>

--00000000000072b8ea05f00f05dc
Content-Type: text/plain; charset="UTF-8"

Hi,

Trying to resurrect this thread, as we still have this deficiency in
OpenVPN core that makes it difficult for UI's to report routing errors.

tldr: Can we get CONNECTED,ERROR instead of CONNECTED,SUCCESS on route
errors?

See also https://github.com/OpenVPN/openvpn-gui/issues/9

On Fri, Jul 6, 2018 at 3:38 PM Jonathan K. Bullard <jkbullard@...277...>
wrote:

> Hi,
>
> On Fri, Jul 6, 2018 at 3:24 PM, Selva Nair <selva.nair@...277...> wrote:
> >
> > Hi,
> >
> > Copying the devel list as a reminder that "we" have been asking for this
> change for a long time :)
> >
> > On Fri, Jul 6, 2018 at 2:48 PM, Gert Doering <notifications@...1714...>
> wrote:
> >>
> >> Hi,
> >>
> >> On Fri, Jul 06, 2018 at 08:25:02AM -0700, Selva Nair wrote:
> >> > Can we do something about this in openvpn core, so that the GUI can
> be report route errors?
> >>
> >> Currently when we get CONNECTED,SUCCESS we turn the icon green. If we
> get
> >>
> >> CONENCTED,ERROR we keep it amber and the state as "connecting.." even if
> >>
> >> the initialization sequence completes.
> >> >
> >> > So route errors can still be treated as non-fatal but we want to get
> CONNECTED,ERROR in such cases.
>
> +1 to routing errors causing CONNECTED,ERROR (I didn't even know that
> was possible). This confuses many Tunnelblick users.
>
> I'd be happy for routing errors to cause a FATAL error as long as the
> errors weren't caused by "route already exists" or something like
> that. But I assume that's too much trouble.
>
>
> Best regards,
>
> Jon
>

Selva

--00000000000072b8ea05f00f05dc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi,</div><div><br></div>Trying to re=
surrect this thread, as we still have this deficiency=C2=A0in OpenVPN=C2=A0=
core that makes it difficult for UI&#39;s to report routing errors.</div><d=
iv dir=3D"ltr"><br></div><div>tldr: Can we get CONNECTED,ERROR instead of C=
ONNECTED,SUCCESS on route errors?</div><div><br></div><div dir=3D"ltr">See =
also=C2=A0<a href=3D"https://github.com/OpenVPN/openvpn-gui/issues/9">https=
://github.com/OpenVPN/openvpn-gui/issues/9</a><br><div><br></div></div><div=
 class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 6,=
 2018 at 3:38 PM Jonathan K. Bullard &lt;<span class=3D"" id=3D":7nl.2" tab=
index=3D"-1" role=3D"menuitem" aria-haspopup=3D"true" style=3D"">jkbullard<=
/span>@<a href=3D"http://gmail.com">gmail.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Fri, Jul 6, 2018 at 3:24 PM, Selva Nair &lt;<a href=3D"mailto:selva.nair=
@...277..." target=3D"_blank">selva.nair@...277...</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; Copying the devel list as a reminder that &quot;we&quot; have been ask=
ing for this change for a long time :)<br>
&gt;<br>
&gt; On Fri, Jul 6, 2018 at 2:48 PM, Gert Doering &lt;<a href=3D"mailto:not=
ifications@...1714..." target=3D"_blank">notifications@...1714...</a>&gt; w=
rote:<br>
&gt;&gt;<br>
&gt;&gt; Hi,<br>
&gt;&gt;<br>
&gt;&gt; On Fri, Jul 06, 2018 at 08:25:02AM -0700, Selva Nair wrote:<br>
&gt;&gt; &gt; Can we do something about this in openvpn core, so that the G=
UI can be report route errors?<br>
&gt;&gt;<br>
&gt;&gt; Currently when we get CONNECTED,SUCCESS we turn the icon green. If=
 we get<br>
&gt;&gt;<br>
&gt;&gt; CONENCTED,ERROR we keep it amber and the state as &quot;connecting=
..&quot; even if<br>
&gt;&gt;<br>
&gt;&gt; the initialization sequence completes.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; So route errors can still be treated as non-fatal but we want=
 to get CONNECTED,ERROR in such cases.<br>
<br>
+1 to routing errors causing CONNECTED,ERROR (I didn&#39;t even know that<b=
r>
was possible). This confuses many Tunnelblick users.<br>
<br>
I&#39;d be happy for routing errors to cause a FATAL error as long as the<b=
r>
errors weren&#39;t caused by &quot;route already exists&quot; or something =
like<br>
that. But I assume that&#39;s too much trouble.<br>
<br>
<br>
Best regards,<br>
<br>
Jon<br></blockquote><div><br></div><div>Selva=C2=A0</div></div></div>

--00000000000072b8ea05f00f05dc--

