MIME-Version: 1.0
In-Reply-To: <CAKuzo_gdOZq1m_fmV6NA2uM7+_5v-R9Pbsgut=C5yELx7bEp+g@...278...>
References: <CAFHpkQGwrOTkOy0UDNUkAa3m4YZeUb7ZpKRjFWaj50KaAX47_Q@...278...>
 <CAKuzo_gdOZq1m_fmV6NA2uM7+_5v-R9Pbsgut=C5yELx7bEp+g@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 22 Feb 2018 06:44:10 +0500
Message-ID: <CAFHpkQF-ZzVwJYwFppb7rJOkQ+Sc7PGZ0TPO7Ei4goszA55pmA@...278...>
Content-Type: multipart/alternative; boundary="089e082f54882fbd9d0565c32e81"
Subject: Re: [Openvpn-devel] challenge/response example ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--089e082f54882fbd9d0565c32e81
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2018-02-21 22:03 GMT+05:00 Selva Nair <selva.nair@...277...>:

> Hi,
>
> On Tue, Feb 20, 2018 at 10:10 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=
=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...>
> wrote:
> > Hello,
> >
> > is there any step-by-step example of implementing either static or
> dynamic
> > challenge response ?
>
> Static is easy:
> On client: add --static-challenge "Enter OTP" 1 to the client config.
> On server, merge my auth-pam plugin patch :)
> https://patchwork.openvpn.net/patch/212/
> and see the commit message for examples on using the plugin
>
> Dynamic is even easier on the client side, if Windows -- just use
> OpenVPN Windows GUI
> But for server side, the only way I know is to consult the
> management-notes.txt and implement a custom setup using
> management-client-auth.
>

any known example of such an implementation?


>
> Selva
>

--089e082f54882fbd9d0565c32e81
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2018-02-21 22:03 GMT+05:00 Selva Nair <span dir=3D"ltr">&lt;<a href=3D"=
mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;=
</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On Tue, Feb 20, 2018 at 10:10 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD &lt;<a href=3D"mailto:chipitsine@...277...">chi=
pitsine@...277...</a>&gt; wrote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; is there any step-by-step example of implementing either static or dyn=
amic<br>
&gt; challenge response ?<br>
<br>
</span>Static is easy:<br>
On client: add --static-challenge &quot;Enter OTP&quot; 1 to the client con=
fig.<br>
On server, merge my auth-pam plugin patch :)<br>
<a href=3D"https://patchwork.openvpn.net/patch/212/" rel=3D"noreferrer" tar=
get=3D"_blank">https://patchwork.openvpn.net/<wbr>patch/212/</a><br>
and see the commit message for examples on using the plugin<br>
<br>
Dynamic is even easier on the client side, if Windows -- just use<br>
OpenVPN Windows GUI<br>
But for server side, the only way I know is to consult the<br>
management-notes.txt and implement a custom setup using<br>
management-client-auth.<br></blockquote><div><br></div><div>any known examp=
le of such an implementation?<br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Selva<br>
</font></span></blockquote></div><br></div></div>

--089e082f54882fbd9d0565c32e81--

