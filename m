MIME-Version: 1.0
In-Reply-To: <20171105192019.GM958@...1296...>
References: <20171010231130.6832-1-simon@...2293...>
 <20171010231130.6832-9-simon@...2293...>
 <20171105192019.GM958@...1296...>
From: Selva <selva.nair@...277...>
Date: Sun, 5 Nov 2017 14:44:34 -0500
Message-ID: <CAKuzo_jOxPArF=OUAT1XoCcJPuWV3jDr9VDLpLcV8+UV37b_cQ@...278...>
Content-Type: multipart/alternative; boundary="94eb2c04422a7ae4d2055d419226"
Subject: Re: [Openvpn-devel] [PATCH 09/13] Signed/unsigned warnings of MSVC
 resolved
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Simon Rozman <simon@...2293...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c04422a7ae4d2055d419226
Content-Type: text/plain; charset="UTF-8"

Hi,


> > index 7a2d0e3..5422d33 100644
> > --- a/src/openvpnserv/validate.c
> > +++ b/src/openvpnserv/validate.c
> > @@ -298,7 +298,7 @@ IsUserInGroup(PSID sid, const PTOKEN_GROUPS
> token_groups, const WCHAR *group_nam
> >              break;
> >          }
> >          /* If a match is already found, ret == TRUE and the loop is
> skipped */
> > -        for (int i = 0; i < nread && !ret; ++i)
> > +        for (DWORD i = 0; i < nread && !ret; ++i)
>
> ... and here.
>
>
> Consider me not convinced...
>
> what exactly are the warnings MSVC spits out here?
>

I think these are needed to silence signed/unsigned comparison warnings
(== is ok, but  < and > would warn). gcc also would warn if -Wextra or
-Wsign-compare is used.

Simon may have more to say.

Selva

--94eb2c04422a7ae4d2055d419226
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><span><br>
&gt; index 7a2d0e3..5422d33 100644<br>
&gt; --- a/src/openvpnserv/validate.c<br>
&gt; +++ b/src/openvpnserv/validate.c<br>
&gt; @@ -298,7 +298,7 @@ IsUserInGroup(PSID sid, const PTOKEN_GROUPS token_=
groups, const WCHAR *group_nam<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If a match is already found, ret =
=3D=3D TRUE and the loop is skipped */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (int i =3D 0; i &lt; nread &amp;&amp;=
 !ret; ++i)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (DWORD i =3D 0; i &lt; nread &amp;&am=
p; !ret; ++i)<br>
<br>
</span>... and here.<br>
<br>
<br>
Consider me not convinced...<br>
<br>
what exactly are the warnings MSVC spits out here?<br></blockquote><div><br=
></div><div>I think these are needed to silence signed/unsigned comparison =
warnings</div><div>(=3D=3D is ok, but =C2=A0&lt; and &gt; would warn). gcc =
also would warn if -Wextra or=C2=A0</div><div>-Wsign-compare is used.</div>=
<div><br></div><div>Simon may have more to say.</div><div><br></div><div>Se=
lva</div></div></div></div>

--94eb2c04422a7ae4d2055d419226--

