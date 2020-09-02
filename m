MIME-Version: 1.0
References: <20200902133755.308-1-lstipakov@...277...>
 <CAKuzo_hmoG=MfxsuefwJ5CUMHvXAYCH-n5A-DP4JsJsWBPr-qg@...278...>
 <CAGyAFMVpyJ2tgwopvArJrteJcPCF2bE80ezbGXVgotpJQBsBYQ@...278...>
In-Reply-To: <CAGyAFMVpyJ2tgwopvArJrteJcPCF2bE80ezbGXVgotpJQBsBYQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 2 Sep 2020 10:22:43 -0400
Message-ID: <CAKuzo_j1iQ=M1mKnnCvUcUxS5HfER_2OTmxooaORS1z684_Hew@...278...>
Content-Type: multipart/alternative; boundary="0000000000008a878505ae555f77"
Subject: Re: [Openvpn-devel] [PATCH] openvpnmsica: make adapter renaming
 non-fatal
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--0000000000008a878505ae555f77
Content-Type: text/plain; charset="UTF-8"

Hi

On Wed, Sep 2, 2020 at 9:54 AM Lev Stipakov <lstipakov@...277...> wrote:

> Hi,
>
> >>                  if (dwResult != ERROR_SUCCESS)
> >>                  {
> >> -                    tap_delete_adapter(NULL, &guidAdapter,
> &bRebootRequired);
> >> +                    /* failed renaming is not a fatal error, continue
> */
> >> +                    dwResult = ERROR_SUCCESS;
> >
> >
> > This looks strange. If we are going to rewrite dwResult, why set it and
> check it at all, just call
> > tap_set_adapter() without storing the return value and add the comment.
>
> I think this is good for documentation purposes - that we are aware
> that function may fail, but in this case it is not fatal and we continue.
>

That's achieved also by just adding a comment that we don't check the
return value as failure is not fatal. Anyway, this works too.


>
> > Or, better, print a warning message saying the rename failed.
>
> Warning is printed inside tap_delete_adapter().
>

tap_delete_adapter() is not called here. I was suggesting that if we do
check the return value, let us also print a  warning that renaming failed.
That can't be  done anywhere except just before converting the error
to SUCCESS.

Selva

--0000000000008a878505ae555f77
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Sep 2, 2020 at 9:54 AM Lev Stipakov &lt;<a =
href=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipakov@...277...</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi=
,<br>
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
dwResult !=3D ERROR_SUCCESS)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 tap_delete_adapter(NULL, &amp;guidAdapter, &amp;bRebootRequired);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* failed renaming is not a fatal error, continue */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 dwResult =3D ERROR_SUCCESS;<br>
&gt;<br>
&gt;<br>
&gt; This looks strange. If we are going to rewrite dwResult, why set it an=
d check it at all, just call<br>
&gt; tap_set_adapter() without storing the return value and add the comment=
.<br>
<br>
I think this is good for documentation purposes - that we are aware<br>
that function may fail, but in this case it is not fatal and we continue.<b=
r></blockquote><div><br></div><div>That&#39;s achieved also by just adding =
a comment that we don&#39;t check the</div><div>return value as failure is =
not fatal. Anyway, this works too.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
&gt; Or, better, print a warning message saying the rename failed.<br>
<br>
Warning is printed inside tap_delete_adapter().<br></blockquote><div><br></=
div><div>tap_delete_adapter() is not called here. I was suggesting that if =
we do=C2=A0</div><div>check the return value, let us also print a=C2=A0 war=
ning that renaming failed.=C2=A0</div><div>That can&#39;t be=C2=A0 done any=
where except just before converting the error</div><div>to SUCCESS.</div><d=
iv><br></div><div>Selva</div></div></div>

--0000000000008a878505ae555f77--

