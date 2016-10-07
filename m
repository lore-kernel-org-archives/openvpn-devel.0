MIME-Version: 1.0
In-Reply-To: <CAKuzo_gOs9-P48kLPtvnW+NhMdqFP07W6yQNMrVT=Opf1JA8Mg@...278...>
References: <1470684488-21307-3-git-send-email-davids@...515...>
	<1470999445-4288-1-git-send-email-davids@...515...>
	<CAKuzo_gOs9-P48kLPtvnW+NhMdqFP07W6yQNMrVT=Opf1JA8Mg@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 7 Oct 2016 15:56:01 -0400
Message-ID: <CAKuzo_jq=jQyzP1vG-GugzqojyRZKBW8cMsXPR4TPXoxNLU3cw@...278...>
Content-Type: multipart/alternative; boundary=001a113c0372ed58ce053e4bcd0b
Subject: [Openvpn-devel] Fwd: [PATCH v4.1 2/4] Re-implement the systemd
 support using the new query user API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113c0372ed58ce053e4bcd0b
Content-Type: text/plain; charset=UTF-8

This ACK never went to the list.. sending again..

---------- Forwarded message ----------
From: Selva Nair <selva.nair@...277...>
Date: Fri, Aug 26, 2016 at 9:00 PM
Subject: Re: [Openvpn-devel] [PATCH v4.1 2/4] Re-implement the systemd
support using the new query user API
To: David Sommerseth <davids@...515...>



On Fri, Aug 12, 2016 at 6:57 AM, David Sommerseth <davids@...515...>
wrote:

> This provides exactly the same systemd functionality which existed
> before the query user infrastructure got implemented.
>
>   [v5 - Ensure NULL termination fix in d09fbf958f1c is included ]
>
>   [v4 - change disapproved &= syntax ]
>
>   [v3 - Remove QUERY_USER_EXEC_ALTERNATIVE macro, simplify
>         alternatives definition directly in console.h.  For
>         now only depend on ENABLE_SYSTEMD]
>
>   [v2 - Removed the QUERY_USER_FOREACH macro]
>
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  configure.ac                  |   2 +-
>  src/openvpn/Makefile.am       |   2 +-
>  src/openvpn/console.h         |   6 +--
>  src/openvpn/console_systemd.c | 115 ++++++++++++++++++++++++++++++
> ++++++++++++
>  4 files changed, 120 insertions(+), 5 deletions(-)
>  create mode 100644 src/openvpn/console_systemd.c
>

With the NUL termination back in place all look good.
ACK (for master only)

Selva

--001a113c0372ed58ce053e4bcd0b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This ACK never went to the list.. sending again..<div><br>=
<div class=3D"gmail_quote">---------- Forwarded message ----------<br>From:=
 <b class=3D"gmail_sendername">Selva Nair</b> <span dir=3D"ltr">&lt;<a href=
=3D"mailto:selva.nair@...277...">selva.nair@...277...</a>&gt;</span><br>Dat=
e: Fri, Aug 26, 2016 at 9:00 PM<br>Subject: Re: [Openvpn-devel] [PATCH v4.1=
 2/4] Re-implement the systemd support using the new query user API<br>To: =
David Sommerseth &lt;<a href=3D"mailto:davids@...515...">davids@...515...</=
a>&gt;<br><br><br><div dir=3D"ltr"><div class=3D"gmail_extra"><span class=
=3D""><br><div class=3D"gmail_quote">On Fri, Aug 12, 2016 at 6:57 AM, David=
 Sommerseth <span dir=3D"ltr">&lt;<a href=3D"mailto:davids@...515..." targe=
t=3D"_blank">davids@...515...</a>&gt;</span> wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex"><span>This provides exactly the same systemd functionality which=
 existed<br>
before the query user infrastructure got implemented.<br>
<br>
</span>=C2=A0 [v5 - Ensure NULL termination fix in d09fbf958f1c is included=
 ]<br>
<div><div><br>
=C2=A0 [<span>v4</span> - change disapproved &amp;=3D syntax ]<br>
<br>
=C2=A0 [v3 - Remove QUERY_USER_EXEC_ALTERNATIVE macro, simplify<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 alternatives definition directly in console.h.=
=C2=A0 For<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 now only depend on ENABLE_SYSTEMD]<br>
<br>
=C2=A0 [v2 - Removed the QUERY_USER_FOREACH macro]<br>
<br>
Signed-off-by: David Sommerseth &lt;<a href=3D"mailto:davids@...515..." tar=
get=3D"_blank">davids@...515...</a>&gt;<br>
---<br>
=C2=A0<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0<span>2</span> +-<br>
=C2=A0src/openvpn/Makefile.am=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0<span=
>2</span> +-<br>
=C2=A0src/openvpn/console.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0=
6 +--<br>
=C2=A0src/openvpn/console_systemd.c | 115 ++++++++++++++++++++++++++++++<wb=
r>++++++++++++<br>
=C2=A0<span>4</span> files changed, 120 insertions(+), 5 deletions(-)<br>
=C2=A0create mode 100644 src/openvpn/console_systemd.c<br>
</div></div></blockquote></div><br></span>With the NUL termination back in =
place all look good. <br>ACK (for master only)<span class=3D"HOEnZb"><font =
color=3D"#888888"><br><br></font></span></div><span class=3D"HOEnZb"><font =
color=3D"#888888"><div class=3D"gmail_extra">Selva<br></div></font></span><=
/div>
</div><br></div></div>

--001a113c0372ed58ce053e4bcd0b--

