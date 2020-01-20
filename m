MIME-Version: 1.0
References: <E1itVts-0007ZG-MA@...2479...>
 <CAGyAFMWcXo-yzhkRgiiZdcZ6xgDS6Wc3AOwbx5QV_HrLcnTBEQ@...278...>
 <5e25b262.1c69fb81.29c15.ca73SMTPIN_ADDED_MISSING@...2014...>
In-Reply-To: <5e25b262.1c69fb81.29c15.ca73SMTPIN_ADDED_MISSING@...2014...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 20 Jan 2020 16:33:14 +0200
Message-ID: <CAGyAFMUjh3KGftTTqw=gJgmm5VxYhLpNr6mMcoNAdPfOtAnWLA@...278...>
Content-Type: multipart/alternative; boundary="000000000000a1b8cc059c932c7a"
Subject: Re: [Openvpn-devel] [PATCH] Move keying material exporter check
 from syshead.h to configure.ac
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...2507...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000a1b8cc059c932c7a
Content-Type: text/plain; charset="UTF-8"

While I am not quite convinced we should use _FUNCS and
not _FUNC, the rest of code looks reasonable. It also changes
EKM to a more meaningful name.

I gave it full travis run, all configuration succeeded (
https://travis-ci.org/lstipakov/openvpn/builds/639461944).

Acked-by: Lev Stipakov <lstipakov@...277...>



ma 20. tammik. 2020 klo 16.00 Steffan Karger (steffan.karger@...2507...)
kirjoitti:

> On 20-01-2020 13:42, Lev Stipakov wrote:
> >     +       have_export_keying_material="yes"
> >     +       AC_CHECK_FUNCS(
> >     +               [SSL_export_keying_material],
> >     +               ,
> >     +               [have_export_keying_material="no"; break]
> >     +       )
> >
> >
> > Just wondering why not AC_CHECK_FUNC? In this case we could get rid of
> > "break".
> >
> > _FUNCS also defines HAVE_function macro, which we don't use in this
> > particular case.
> >
> > Noticed that we have similar code above:
> >
> >     have_crypto_aead_modes="yes"
> >     AC_CHECK_FUNCS(
> >         [EVP_aes_256_gcm],
> >         ,
> >         [have_crypto_aead_modes="no"; break]
> >     )
> >
> > so maybe that's why.
>
> This. It's too long ago that I fully remember, but I recall we changed
> to FUNCS for some reason in the past. Autoconf is full of surprises. So
> if we have something that works, and I want something similar, let's do
> it in the exact same way.
>
> -Steffan
>


-- 
-Lev

--000000000000a1b8cc059c932c7a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">While I am not quite convinced we should use _FUNCS and<di=
v>not _FUNC, the rest of code looks reasonable. It also changes</div><div>E=
KM to a more meaningful name.</div><div><br></div><div>I gave it full travi=
s run, all configuration succeeded (<a href=3D"https://travis-ci.org/lstipa=
kov/openvpn/builds/639461944">https://travis-ci.org/lstipakov/openvpn/build=
s/639461944</a>).</div><div><br></div><div>Acked-by: Lev Stipakov &lt;<a hr=
ef=3D"mailto:lstipakov@...277...">lstipakov@...277...</a>&gt;</div><div><br=
></div><div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">ma 20. tammik. 2020 klo 16.00 Steffan Karger (<a href=
=3D"mailto:steffan.karger@...2507...">steffan.karger@...2507...</a>) kirjoi=
tti:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 20-01-20=
20 13:42, Lev Stipakov wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0have_export_keying_mate=
rial=3D&quot;yes&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0AC_CHECK_FUNCS(<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0[SSL_export_keying_material],<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0[have_export_keying_material=3D&quot;no&quot;; break]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
&gt; <br>
&gt; <br>
&gt; Just wondering why not AC_CHECK_FUNC? In this case we could get rid of=
<br>
&gt; &quot;break&quot;.<br>
&gt; <br>
&gt; _FUNCS also defines=C2=A0HAVE_function macro, which we don&#39;t use i=
n this<br>
&gt; particular case.<br>
&gt; <br>
&gt; Noticed that we have similar code above:<br>
&gt; <br>
&gt; =C2=A0 =C2=A0 have_crypto_aead_modes=3D&quot;yes&quot;<br>
&gt; =C2=A0 =C2=A0 AC_CHECK_FUNCS(<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 [EVP_aes_256_gcm],<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 [have_crypto_aead_modes=3D&quot;no&quot;; =
break]<br>
&gt; =C2=A0 =C2=A0 )<br>
&gt; <br>
&gt; so maybe that&#39;s why.<br>
<br>
This. It&#39;s too long ago that I fully remember, but I recall we changed<=
br>
to FUNCS for some reason in the past. Autoconf is full of surprises. So<br>
if we have something that works, and I want something similar, let&#39;s do=
<br>
it in the exact same way.<br>
<br>
-Steffan<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">-Lev</div>

--000000000000a1b8cc059c932c7a--

