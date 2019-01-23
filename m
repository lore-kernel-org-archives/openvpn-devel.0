MIME-Version: 1.0
References: <1544210258-8754-1-git-send-email-selva.nair@...277...>
 <201901231908.x0NJ8NBX056343@...2054...>
In-Reply-To: <201901231908.x0NJ8NBX056343@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 23 Jan 2019 14:53:20 -0500
Message-ID: <CAKuzo_gzaOo3aoTR6=LAkjscTPaqC=RCkGWNb17Tum-BTeQWTA@...278...>
Content-Type: multipart/alternative; boundary="000000000000190f9f0580257384"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Move OpenSSL vs CNG
 signature digest type mapping to a function
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

--000000000000190f9f0580257384
Content-Type: text/plain; charset="UTF-8"

Hi,

I noticed the uncrustify changes only this morning when rebasing the next
patch for a v2. Thanks for taking care of that.

This refactoring is used in the following patch 2/2 (PSS padding needed for
OpenSSL 1.1.1) which Arne is reviewing. If 2.5 is far away, we may want to
make 2.4.x work with openssl 1.1.1. That said, we could continue shipping
2.4.x for Windows built against OpenSSL 1.1.0, so I'm fine with no PSS (and
hence no OpenSSL 1.1.1) support in 2.4.

Selva

On Wed, Jan 23, 2019 at 2:08 PM Gert Doering <gert@...1296...> wrote:

> Your patch has been applied to the master branch.
>
> It needed a bit of massaging due to the uncrustify patches to cryptoapi.c
> that happened in between (f57431cdc88f2), but since the relevant conflicts
> were all "simple whitespace changes", fairly easily solved.
>
> From a quick clance on cryptoapi.c in release/2.4 it looks like this
> might also be applicable - but "by default" I won't apply pure refactoring
> changes.  So: if you need this for a change that falls into release/2.4
> land ("long-term compatibility" or "bugfix"), please let me know.
>
> Test built on ubuntu 16.04/mingw.
>
> commit 0cab3475a83e9bad35b0eeb39b9ca886e6afaf1e
> Author: Selva Nair
> Date:   Fri Dec 7 14:17:37 2018 -0500
>
>      Move OpenSSL vs CNG signature digest type mapping to a function
>
>      Signed-off-by: Selva Nair <selva.nair@...277...>
>      Acked-by: Arne Schwabe <arne@...1227...>
>      Message-Id: <1544210258-8754-1-git-send-email-selva.nair@...277...>
>      URL:
> https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17999.html
>      Signed-off-by: Gert Doering <gert@...1296...>
>
>
> --
> kind regards,
>
> Gert Doering
>
>

--000000000000190f9f0580257384
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br><br>I noticed the uncrustify changes only this=
 morning when rebasing the next patch for a v2. Thanks for taking care of t=
hat.<br><br>This refactoring is used in the following patch 2/2 (PSS paddin=
g needed for OpenSSL 1.1.1) which Arne is reviewing. If 2.5 is far away, we=
 may want to make 2.4.x work with openssl 1.1.1. That said, we could contin=
ue shipping 2.4.x for Windows built against OpenSSL 1.1.0, so I&#39;m fine =
with no PSS (and hence no OpenSSL 1.1.1) support in 2.4.<br><br></div>Selva=
<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail-m_=
-2900189953194776465gmail_attr">On Wed, Jan 23, 2019 at 2:08 PM Gert Doerin=
g &lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Y=
our patch has been applied to the master branch.<br>
<br>
It needed a bit of massaging due to the uncrustify patches to cryptoapi.c<b=
r>
that happened in between (f57431cdc88f2), but since the relevant conflicts<=
br>
were all &quot;simple whitespace changes&quot;, fairly easily solved.<br>
<br>
From a quick clance on cryptoapi.c in release/2.4 it looks like this<br>
might also be applicable - but &quot;by default&quot; I won&#39;t apply pur=
e refactoring<br>
changes.=C2=A0 So: if you need this for a change that falls into release/2.=
4<br>
land (&quot;long-term compatibility&quot; or &quot;bugfix&quot;), please le=
t me know.<br>
<br>
Test built on ubuntu 16.04/mingw.<br>
<br>
commit 0cab3475a83e9bad35b0eeb39b9ca886e6afaf1e<br>
Author: Selva Nair<br>
Date:=C2=A0 =C2=A0Fri Dec 7 14:17:37 2018 -0500<br>
<br>
=C2=A0 =C2=A0 =C2=A0Move OpenSSL vs CNG signature digest type mapping to a =
function<br>
<br>
=C2=A0 =C2=A0 =C2=A0Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.n=
air@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0Acked-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1711...=
27..." target=3D"_blank">arne@...1227...</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0Message-Id: &lt;<a href=3D"mailto:1544210258-8754-1-git=
-send-email-selva.nair@...277..." target=3D"_blank">1544210258-8754-1-git-s=
end-email-selva.nair@...277...</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0URL: <a href=3D"https://www.mail-archive.com/openvpn-de=
vel@lists.sourceforge.net/msg17999.html" rel=3D"noreferrer" target=3D"_blan=
k">https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg1799=
9.html</a><br>
=C2=A0 =C2=A0 =C2=A0Signed-off-by: Gert Doering &lt;<a href=3D"mailto:gert@=
...1296..." target=3D"_blank">gert@...1296...</a>&gt;<br>
<br>
<br>
--<br>
kind regards,<br>
<br>
Gert Doering<br>
<br>
</blockquote></div>

--000000000000190f9f0580257384--

