MIME-Version: 1.0
References: <1550709982-19319-1-git-send-email-selva.nair@...277...>
 <201902281725.x1SHPXJq043376@...2054...>
In-Reply-To: <201902281725.x1SHPXJq043376@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 28 Feb 2019 12:33:46 -0500
Message-ID: <CAKuzo_jso35sxhAk4OUAiSXqX6g6OciS1vseyRgZBGVGRbOWUA@...278...>
Content-Type: multipart/alternative; boundary="00000000000047f3530582f7b289"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Better error message when
 script fails due to script-security setting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000047f3530582f7b289
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Feb 28, 2019 at 12:25 PM Gert Doering <gert@...1296...> wrote:

> Acked-by: Gert Doering <gert@...1296...>
>
> Thanks.  I have not tested the various error conditions, but the code
> makes sense to me and it passes compile and t_client tests (which use
> --up here), so it's not breaking stuff in fundamental and non-obvious
> ways.
>
> (Since David was mostly happy with the v1 approach except for the
> "127" and "switch()", I assume he's totally fine with v2 now :-) )
>
> Your patch has been applied to the master branch - it won't apply to
> 2.4 as we have no "run_command.*" there yet.  Shall we cherrypick
> bf97c00f7dba4 and 253f015558 to get there?  Or do you want to do a
> 2.4 version of the patch?
>

Would require more cherry-picks than that, or some manual edits, isn't it?

I can send a patch for 2.4 -- would you prefer the same as this --
i.e with switch(stat) in misc.c and and preprocessor macros in misc.h
or a simpler, return code = -2 and error message as in version 1?

Selva

--00000000000047f3530582f7b289
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, Feb 28, 2019 at 12:25 PM Gert Doering=
 &lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">Acked-by: Gert Doeri=
ng &lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...=
</a>&gt;<br>
<br>
Thanks.=C2=A0 I have not tested the various error conditions, but the code<=
br>
makes sense to me and it passes compile and t_client tests (which use<br>
--up here), so it&#39;s not breaking stuff in fundamental and non-obvious<b=
r>
ways.<br>
<br>
(Since David was mostly happy with the v1 approach except for the<br>
&quot;127&quot; and &quot;switch()&quot;, I assume he&#39;s totally fine wi=
th v2 now :-) )<br>
<br>
Your patch has been applied to the master branch - it won&#39;t apply to<br>
2.4 as we have no &quot;run_command.*&quot; there yet.=C2=A0 Shall we cherr=
ypick<br>
bf97c00f7dba4 and 253f015558 to get there?=C2=A0 Or do you want to do a<br>
2.4 version of the patch?<br></blockquote><div><br></div><div>Would require=
 more cherry-picks than that, or some manual edits, isn&#39;t it?<br><br></=
div><div>I can send a patch for 2.4 -- would you prefer the same as this --=
<br>i.e with switch(stat) in misc.c and and preprocessor macros in misc.h<b=
r>or a simpler, return code =3D -2 and error message as in version 1? <br><=
br></div><div>Selva <br></div></div></div>

--00000000000047f3530582f7b289--

