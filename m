MIME-Version: 1.0
References: <1571304533-15614-1-git-send-email-lstipakov@...277...>
 <25c5ecd5-cd2c-1867-07ef-bcc90327cc73@...2318...>
 <1093a271-04e6-5f7d-4e13-96d40551a1f9@...277...>
 <CAKuzo_jvko-Fbyd9ei-5LtYTE6c02pYfD0qNt81QtyMh+fudwA@...278...>
In-Reply-To: <CAKuzo_jvko-Fbyd9ei-5LtYTE6c02pYfD0qNt81QtyMh+fudwA@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 17 Oct 2019 19:44:20 +0500
Message-ID: <CAFHpkQHsmU7oCX1i=XewEein2zyROmwLY2AofjT4Uw-SW6-9RQ@...278...>
Content-Type: multipart/alternative; boundary="00000000000070ec3605951c412d"
Subject: Re: [Openvpn-devel] [PATCH] msvc: OpenSSL 1.1.0 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Lev Stipakov <lstipakov@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000070ec3605951c412d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

it sounds strange (it does not make a lot of sense), but we can build
openssl without TLS1.3 support

=D1=87=D1=82, 17 =D0=BE=D0=BA=D1=82. 2019 =D0=B3. =D0=B2 19:27, Selva Nair =
<selva.nair@...277...>:

> On Thu, Oct 17, 2019 at 8:11 AM Lev Stipakov <lstipakov@...277...> wrote:
> >
> > Hi Fran=C3=A7ois,
> >
> > Fran=C3=A7ois Kooman kirjoitti 17.10.2019 klo 13.39:
> >
> > > "Version 1.1.0 will be supported until 2019-09-11" [1].
> > >
> > > Is there a plan to update to 1.1.1 for the Windows client?
> >
> > Indeed, there is probably no reason to not to switch to newer version.
> > We'll include 1.1.1 into the next release.
>
> Use of 1.1.1 on both client ans server side will default to PSS padding
> for RSA signature (for TLS 1.2 and 1.3) and break
> --management-external-key.
>
> So hold-off on building Windows release with 1.1.1 unless
> we can get https://patchwork.openvpn.net/patch/587/ finalized by then.
>
> Selva
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--00000000000070ec3605951c412d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">it sounds strange (it does not make a lot of sense), but w=
e can build openssl without TLS1.3 support<br></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D1=87=D1=82, 17 =D0=BE=D0=BA=
=D1=82. 2019 =D0=B3. =D0=B2 19:27, Selva Nair &lt;<a href=3D"mailto:selva.n=
air@...277...">selva.nair@...277...</a>&gt;:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">On Thu, Oct 17, 2019 at 8:11 AM Lev Stipakov &=
lt;<a href=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipakov@...1664...=
7...</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi Fran=C3=A7ois,<br>
&gt;<br>
&gt; Fran=C3=A7ois Kooman kirjoitti 17.10.2019 klo 13.39:<br>
&gt;<br>
&gt; &gt; &quot;Version 1.1.0 will be supported until 2019-09-11&quot; [1].=
<br>
&gt; &gt;<br>
&gt; &gt; Is there a plan to update to 1.1.1 for the Windows client?<br>
&gt;<br>
&gt; Indeed, there is probably no reason to not to switch to newer version.=
<br>
&gt; We&#39;ll include 1.1.1 into the next release.<br>
<br>
Use of 1.1.1 on both client ans server side will default to PSS padding<br>
for RSA signature (for TLS 1.2 and 1.3) and break<br>
--management-external-key.<br>
<br>
So hold-off on building Windows release with 1.1.1 unless<br>
we can get <a href=3D"https://patchwork.openvpn.net/patch/587/" rel=3D"nore=
ferrer" target=3D"_blank">https://patchwork.openvpn.net/patch/587/</a> fina=
lized by then.<br>
<br>
Selva<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div>

--00000000000070ec3605951c412d--

