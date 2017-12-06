MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE1085B4CA9F@...2294...>
References: <1512534521-14760-1-git-send-email-selva.nair@...277...>
 <99D61A626FDA8A4B90A270669121BE1085B4CA9F@...2294...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 6 Dec 2017 12:49:11 -0500
Message-ID: <CAKuzo_jSTnc7-x6U3fVD7ozn5AFc5BtkpmP41rahSufuZ9VB-Q@...278...>
Content-Type: multipart/alternative; boundary="001a114ff326de5c18055faf92e9"
Subject: Re: [Openvpn-devel] [PATCH] Refactor get_interface_metric to return
 metric and auto flag separately
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114ff326de5c18055faf92e9
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, Dec 6, 2017 at 12:18 PM, Simon Rozman <simon@...2293...> wrote:

> Hi,
>
> I have briefly reviewed this patch. If you look at each
> get_interface_metric() call you'll notice exactly the same repeating
> pattern:
>
>         tap_metric_v4 = get_interface_metric(index, AF_INET, &is_auto);
>         if (is_auto)
>         {
>             tap_metric_v4 = 0;
>         }
>         tap_metric_v6 = get_interface_metric(index, AF_INET6, &is_auto);
>         if (is_auto)
>         {
>             tap_metric_v6 = 0;
>         }
>
> Should the get_interface_metric() be rewritten to return:
> 0 = automatic metric
> n = manual metric
>
>
That's exactly what the original version does and the purpose of the patch
is to not do so. Else this function is not useful when someone really wants
to
find what the metric is as the value of 0 hides that info. Note that even
when
automatic metric is in use the interface has some metric set.

I want to use it in another patch where the actual metric is required even
if automatic metric is in use.

Selva

--001a114ff326de5c18055faf92e9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Wed, Dec 6, 2017 at 12:18 PM, Simon Rozman <span dir=3D"ltr">&lt;=
<a href=3D"mailto:simon@...2293..." target=3D"_blank">simon@...2293...</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
I have briefly reviewed this patch. If you look at each get_interface_metri=
c() call you&#39;ll notice exactly the same repeating pattern:<br>
<span><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tap_metric_v4 =3D get_interface_metric(index, A=
F_INET, &amp;is_auto);<br>
</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_auto)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tap_metric_v4 =3D 0;<br>
<span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tap_metric_v6 =3D get_interface_metric(index, A=
F_INET6, &amp;is_auto);<br>
</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_auto)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tap_metric_v6 =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
Should the get_interface_metric() be rewritten to return:<br>
0 =3D automatic metric<br>
n =3D manual metric<br>
<br></blockquote><div><br></div><div>That&#39;s exactly what the original v=
ersion does and the purpose of the patch</div><div>is to not do so. Else th=
is function is not useful when someone really wants to</div><div>find what =
the metric is as the value of 0 hides that info. Note that even when</div><=
div>automatic metric is in use the interface has some metric set.</div><div=
><br></div><div>I want to use it in another patch where the actual metric i=
s required even</div><div>if automatic metric is in use.</div><div><br></di=
v><div>Selva</div></div></div></div>

--001a114ff326de5c18055faf92e9--

