MIME-Version: 1.0
In-Reply-To: <fc90b284-5cb5-ec0e-3609-1187551aecdb@...2080...>
References: <1494008642-7239-1-git-send-email-selva.nair@...277...>
	<1494341557-11721-1-git-send-email-selva.nair@...277...>
	<fc90b284-5cb5-ec0e-3609-1187551aecdb@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 9 May 2017 14:00:55 -0400
Message-ID: <CAKuzo_jh8AXZJRd6kcao5ABf+nayrG-LWn4g45GYG6=YHxf_dg@...278...>
Content-Type: multipart/alternative; boundary=001a1146fe6253b0db054f1b24b4
Subject: Re: [Openvpn-devel] [PATCH 1/2 v2] In auth-pam plugin clear the
 password after use
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1146fe6253b0db054f1b24b4
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue, May 9, 2017 at 1:34 PM, David Sommerseth <openvpn@...2142...
topphemmelig.net> wrote:

> If the plug-in built and packaged separately and that build is not tied
> to OpenVPN itself, this can make this plug-in fail without any
> particular real reason if the OpenVPN binary gets updated independently.
>
> Even though not explicitly documented, we should never remove any
> information from the plug-in v3 structs, only append to and only append
> at the end of the existing structs.
>

I just assumed these "official" plugins will always be built and
distributed with openvpn core.
But if future revisions is guaranteed not to reorder/remove items in the
structs, a less strict check
is definitely better.


> The plug-ins in src/plugins should use, which ensures forward
> compatibility against the OpenVPN binary:
>
>    if (v3structver < OPENVPN_PLUGINv3_STRUCTVER)
>

Yes, will change to this.

Selva

--001a1146fe6253b0db054f1b24b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Tue, May 9, 2017 at 1:34 PM, Dav=
id Sommerseth <span dir=3D"ltr">&lt;<a href=3D"mailto:openvpn@...2080..." t=
arget=3D"_blank">openvpn@...2142...<wbr>topphemmelig.net</a>&gt;</span> wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><div id=3D"m_901749328671586206:8fx" =
class=3D"m_901749328671586206a3s m_901749328671586206aXjCH m_90174932867158=
6206m15bee46715c05994">If the plug-in built and packaged separately and tha=
t build is not tied<br>
to OpenVPN itself, this can make this plug-in fail without any<br>
particular real reason if the OpenVPN binary gets updated independently.<br>
<br>
Even though not explicitly documented, we should never remove any<br>
information from the plug-in v3 structs, only append to and only append<br>
at the end of the existing structs.=C2=A0 </div></blockquote><div><br></div=
><div>I just assumed these &quot;official&quot; plugins will always be buil=
t and distributed with openvpn core.<br>But if future revisions is guarante=
ed not to reorder/remove items in the structs, a less strict check<br>is de=
finitely better.<br></div><div id=3D"m_901749328671586206:8fx" class=3D"m_9=
01749328671586206a3s m_901749328671586206aXjCH m_901749328671586206m15bee46=
715c05994">=C2=A0<br><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote">
The plug-ins in src/plugins should use, which ensures forward<br>
compatibility against the OpenVPN binary:<br>
<br>
=C2=A0 =C2=A0if (v3structver &lt; OPENVPN_PLUGINv3_STRUCTVER)=C2=A0<br></bl=
ockquote><div><br></div><div>Yes, will change to this.=C2=A0</div></div></d=
iv><br></div><div class=3D"gmail_extra">Selva<br></div><div class=3D"gmail_=
extra"><br></div></div>

--001a1146fe6253b0db054f1b24b4--

