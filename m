MIME-Version: 1.0
In-Reply-To: <44f51d16-5251-e257-263d-375d8e01abcb@...1227...>
References: <53533abe-e85d-7a42-49ce-465267997724@...515...>
	<44f51d16-5251-e257-263d-375d8e01abcb@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 19 Oct 2016 11:08:40 -0400
Message-ID: <CAKuzo_ix8a-LDv0tQXk3GoAQ_VAkRAO4CRmz5di0_QM-CuiXbA@...278...>
Content-Type: multipart/alternative; boundary=001a11408170639865053f39304b
Subject: Re: [Openvpn-devel] Proper location for user-specific OpenVPN
 configuration files used by OpenVPN-GUI?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11408170639865053f39304b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Am 19.10.16 um 15:04 schrieb Samuli Sepp=C3=A4nen:

> > Hi,
> >
> > While preparing OpenVPN 2.4-alpha1 release the discussion about
> > user-specific OpenVPN configuration files came up again. To give some
> > background, OpenVPN-GUI can now delegate privileged operations (e.g.
> > route adding) to the OpenVPN Interactive Service. This means that normal
> > users are now able to launch OpenVPN connections without having admin
> > privileges. On top of that, users can now store OpenVPN configuration
> > files in their home directory, under %USERPROFILE%\OpenVPN\config[*].
> > The rationale for this directory choice was discussed here:


The reason for that rather improper choice of %USERPROFILE%\OpenVPN\config
was that the current import functionality is rather limited and does not
handle any dependent files like ca/cert/key/scripts --- it works well when
everything is inline. So we wanted the config folder to be easily
accessible/visible for users who need to manually copy additional files.

But the chosen location is indeed very intrusive and I too think we should
change it.

Arne Schwabe <arne@...1227...> wrote:

>
> I vote for %APPDATA%
>

David Sommerseth <openvpn@...2080...> wrote:

"When in Rome do as the Romans"


Looks like there is a general consensus on this. If so, I will post a patch
later today to use %APPDATA%

Selva

--001a11408170639865053f39304b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br></div><div class=3D"gmail_extra"><div class=3D"gmail_extra">Am 19.=
10.16 um 15:04 schrieb Samuli Sepp=C3=A4nen:</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-lef=
t-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">&gt; Hi,=
<br>&gt;<br>&gt; While preparing OpenVPN 2.4-alpha1 release the discussion =
about<br>&gt; user-specific OpenVPN configuration files came up again. To g=
ive some<br>&gt; background, OpenVPN-GUI can now delegate privileged operat=
ions (e.g.<br>&gt; route adding) to the OpenVPN Interactive Service. This m=
eans that normal<br>&gt; users are now able to launch OpenVPN connections w=
ithout having admin<br>&gt; privileges. On top of that, users can now store=
 OpenVPN configuration<br>&gt; files in their home directory, under %USERPR=
OFILE%\OpenVPN\config[*<wbr>].<br>&gt; The rationale for this directory cho=
ice was discussed here:</blockquote><div>=C2=A0</div></div><div class=3D"gm=
ail_extra"><div class=3D"gmail_quote">The reason for that rather improper c=
hoice of=C2=A0%USERPROFILE%\OpenVPN\confi<wbr>g was that the current import=
 functionality is rather limited and does not handle any dependent files li=
ke ca/cert/key/scripts --- it works well when everything is inline. So we w=
anted the config folder to be easily accessible/visible for users who need =
to manually copy additional files.=C2=A0</div><div class=3D"gmail_quote"><b=
r></div><div class=3D"gmail_quote">But the chosen location is indeed very i=
ntrusive and I too think we should change it.</div><div class=3D"gmail_quot=
e"><br></div><div class=3D"gmail_quote">Arne Schwabe &lt;<a href=3D"mailto:=
arne@...1227..." target=3D"_blank">arne@...1227...</a>&gt; wrote:</div><div=
 class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bo=
rder-left-style:solid;padding-left:1ex"><span class=3D"m_866382763799189539=
5gmail-m_-3793118210550290160gmail-">
<br>
</span>I vote for %APPDATA%<br></blockquote><div><br></div><div>David Somme=
rseth &lt;<a href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...220...=
..2142...<wbr>topphemmelig.net</a>&gt; wrote:<br></div><div><br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-=
width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;paddin=
g-left:1ex">&quot;When in Rome do as the Romans&quot;</blockquote><div><br>=
</div><div>Looks like there is a general consensus on this. If so, I will p=
ost a patch later today to use %APPDATA%<br></div><div><br></div><div>Selva=
</div></div></div></div>

--001a11408170639865053f39304b--

