MIME-Version: 1.0
References: <20230327114937.28246-1-selva.nair@...277...>
 <ZCGHgCdMAsIN7BOQ@...2685...>
In-Reply-To: <ZCGHgCdMAsIN7BOQ@...2685...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 27 Mar 2023 08:30:21 -0400
Message-ID: <CAKuzo_gD2gr9RZDD4CPaytDE_WN_mXC1+j60tmEVHPAZCsMN3g@...278...>
Content-Type: multipart/alternative; boundary="000000000000fff2ba05f7e0e8b4"
Subject: Re: [Openvpn-devel] [PATCH] Make cert_data.h and
 test_cryptoapi/pkcs11.c MSVC compliant
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000fff2ba05f7e0e8b4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2023 at 8:09=E2=80=AFAM Frank Lichtenheld <frank@...2641...>
wrote:

> On Mon, Mar 27, 2023 at 07:49:37AM -0400, selva.nair@...277... wrote:
> > From: Selva Nair <selva.nair@...277...>
> >
> > - Do not use non-literal initializers for static objects
> > - Replace empty initializer {} by {0}
> >
> > Signed-off-by: Selva Nair <selva.nair@...277...>
>

I should have referenced Frank's original patch with:

Co-authored-by: Frank Lichtenheld <frank@...2641...>

> ---
> > To be applied after the test-pkcs11 patch set
>
> Tested MSVC build (in my cmake branch) and verified that this is a
> suitable replacement for my earlier attempt to fix same issue.
>
> Acked-By: Frank Lichtenheld <frank@...2641...>
>
> Regards,
> --
>   Frank Lichtenheld
>

--000000000000fff2ba05f7e0e8b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 27, 2023 at 8:09=E2=80=AF=
AM Frank Lichtenheld &lt;<a href=3D"mailto:frank@...2641...">frank@...2724...=
..</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On Mon, Mar 27, 2023 at 07:49:37AM -0400, <a href=3D"mailto:selva.nair@...1186...=
.277..." target=3D"_blank">selva.nair@...277...</a> wrote:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt; <br>
&gt; - Do not use non-literal initializers for static objects<br>
&gt; - Replace empty initializer {} by {0}<br>
&gt; <br>
&gt; Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." =
target=3D"_blank">selva.nair@...277...</a>&gt;<br></blockquote><div><br></d=
iv><div>I should have referenced Frank&#39;s original patch with:</div><div=
>=C2=A0</div><div>Co-authored-by: Frank Lichtenheld &lt;<a href=3D"mailto:f=
rank@...2641...">frank@...2641...</a>&gt;</div><div><br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
&gt; ---<br>
&gt; To be applied after the test-pkcs11 patch set<br>
<br>
Tested MSVC build (in my cmake branch) and verified that this is a<br>
suitable replacement for my earlier attempt to fix same issue.<br>
<br>
Acked-By: Frank Lichtenheld &lt;<a href=3D"mailto:frank@...2641..." target=
=3D"_blank">frank@...2641...</a>&gt;<br>
<br>
Regards,<br>
-- <br>
=C2=A0 Frank Lichtenheld<br>
</blockquote></div></div>

--000000000000fff2ba05f7e0e8b4--

