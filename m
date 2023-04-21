MIME-Version: 1.0
References: <20230421150100.596718-1-arne@...1227...>
In-Reply-To: <20230421150100.596718-1-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 21 Apr 2023 11:22:49 -0400
Message-ID: <CAKuzo_gsWY+=Ew_LzCyYhbnZ+=YvThf0YAU1bvWCTtmrbss3RQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000ceab0a05f9da3b64"
Subject: Re: [Openvpn-devel] [PATCH] Add Apache2 linking with for new commits
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000ceab0a05f9da3b64
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

exemption -> exception in a number of places below

Though similar in meaning, better to use the standard wording here.

On Fri, Apr 21, 2023 at 11:02=E2=80=AFAM Arne Schwabe <arne@...1227...> wro=
te:

> After first round of mailing people with more than 10 commits we have
> almost all committers have agreed. This put this license in the realm
> of having a realistic change to work. Had any of these contributers
> disagreed, rewriting all their code might have been not feasible.
>
> The rationale of adding this exception now is to avoid having to
> have a second round of agreement for new contributers and ensure
> that all new code will include the exemption.


> Change-Id: Ide83f914f383b53ef37ddf628e4da5a78e241bf0
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  COPYING | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/COPYING b/COPYING
> index e12c51414..b4a148494 100644
> --- a/COPYING
> +++ b/COPYING
> @@ -31,6 +31,29 @@ OpenVPN license:
>    file, but you are not obligated to do so.  If you do not wish to
>    do so, delete this exception statement from your version.
>
> +Apache2 linking exemption:
> +---------------------------
> +OpenVPN is currently undergoing a license change to add an exemption for
> +Apache 2 linking. The following exemption is only valid for new
> contributions
> +after COMMITDATE and past contribution where the authors have already
> agreed
> +to the exemption.
> +
> +  In addition, as a special exception, OpenVPN Inc and the
> +  contributors give permission to link the code of this program to
> +  libraries (the "Libraries") licensed under the Apache License
> +  version 2.0 (this work and any linked library the "Combined Work")
> +  and copy and distribute the Combined Work without an obligation to
> +  license the Libraries under the GNU General Public License v2
> +  (GPL-2.0) as required by Section 2 of the GPL-2.0, and without an
> +  obligation to refrain from imposing any additional restrictions in
> +  the Apache License version 2 that are not in the GPL-2.0, as
> +  required by Section 6 of the GPL-2.0.  You must comply with the
> +  GPL-2.0 in all other respects for the Combined Work, including
> +  the obligation to provide source code.  If you modify this file, you
> +  may extend this exception to your version of the file, but you are
> +  not obligated to do so.  If you do not wish to do so, delete this
> +  exception statement from your version.
> +
>  LZO license:
>  ------------
>
> --
> 2.39.2 (Apple Git-143)
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000ceab0a05f9da3b64
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>exemption -&gt; exception in a number of places below=
</div><div><br></div><div>Though similar in meaning, better to use the stan=
dard wording here.</div><div><br></div><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, Apr 21, 2023 at 11:02=E2=80=AFAM Arne=
 Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1386...=
227...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">After first round of mailing people with more than 10 commits we have=
<br>
almost all committers have agreed. This put this license in the realm<br>
of having a realistic change to work. Had any of these contributers<br>
disagreed, rewriting all their code might have been not feasible.<br>
<br>
The rationale of adding this exception now is to avoid having to<br>
have a second round of agreement for new contributers and ensure<br>
that all new code will include the exemption.=C2=A0</blockquote><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
<br>
Change-Id: Ide83f914f383b53ef37ddf628e4da5a78e241bf0<br>
Signed-off-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=
=3D"_blank">arne@...1227...</a>&gt;<br>
---<br>
=C2=A0COPYING | 23 +++++++++++++++++++++++<br>
=C2=A01 file changed, 23 insertions(+)<br>
<br>
diff --git a/COPYING b/COPYING<br>
index e12c51414..b4a148494 100644<br>
--- a/COPYING<br>
+++ b/COPYING<br>
@@ -31,6 +31,29 @@ OpenVPN license:<br>
=C2=A0 =C2=A0file, but you are not obligated to do so.=C2=A0 If you do not =
wish to<br>
=C2=A0 =C2=A0do so, delete this exception statement from your version.<br>
<br>
+Apache2 linking exemption:<br>
+---------------------------<br>
+OpenVPN is currently undergoing a license change to add an exemption for<b=
r>
+Apache 2 linking. The following exemption is only valid for new contributi=
ons<br>
+after COMMITDATE and past contribution where the authors have already agre=
ed<br>
+to the exemption.<br>
+<br>
+=C2=A0 In addition, as a special exception, OpenVPN Inc and the<br>
+=C2=A0 contributors give permission to link the code of this program to<br>
+=C2=A0 libraries (the &quot;Libraries&quot;) licensed under the Apache Lic=
ense<br>
+=C2=A0 version 2.0 (this work and any linked library the &quot;Combined Wo=
rk&quot;)<br>
+=C2=A0 and copy and distribute the Combined Work without an obligation to<=
br>
+=C2=A0 license the Libraries under the GNU General Public License v2<br>
+=C2=A0 (GPL-2.0) as required by Section 2 of the GPL-2.0, and without an<b=
r>
+=C2=A0 obligation to refrain from imposing any additional restrictions in<=
br>
+=C2=A0 the Apache License version 2 that are not in the GPL-2.0, as<br>
+=C2=A0 required by Section 6 of the GPL-2.0.=C2=A0 You must comply with th=
e<br>
+=C2=A0 GPL-2.0 in all other respects for the Combined Work, including<br>
+=C2=A0 the obligation to provide source code.=C2=A0 If you modify this fil=
e, you<br>
+=C2=A0 may extend this exception to your version of the file, but you are<=
br>
+=C2=A0 not obligated to do so.=C2=A0 If you do not wish to do so, delete t=
his<br>
+=C2=A0 exception statement from your version.<br>
+<br>
=C2=A0LZO license:<br>
=C2=A0------------<br>
<br>
-- <br>
2.39.2 (Apple Git-143)<br>
<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div></div>

--000000000000ceab0a05f9da3b64--

