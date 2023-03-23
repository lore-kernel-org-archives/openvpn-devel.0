MIME-Version: 1.0
References: <20230322113249.2039-1-lstipakov@...277...>
 <CAKuzo_iT15pQgAOVmr-00Jn4c7Yb_H-j28_S=GZ4_xKaFwLvaw@...278...>
 <CAEUTVqR-S8fZkCh6JRrO5ZzeYAq+GiP4qFx5d7vhPDpXfjnUeg@...278...>
 <CAKuzo_hbC6vUNr0JURC8tM+pc=8F_F2UQkFjn7c-Rm24FUGVRQ@...278...>
In-Reply-To: <CAKuzo_hbC6vUNr0JURC8tM+pc=8F_F2UQkFjn7c-Rm24FUGVRQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 23 Mar 2023 08:50:02 -0400
Message-ID: <CAKuzo_ho8-m4+7ksDu1fkT2bDsBMKcy8jaJbG7Pv8AypcYKUTg@...278...>
Content-Type: multipart/alternative; boundary="00000000000009953205f790b805"
Subject: [Openvpn-devel] Fwd:  [PATCH] Print DCO client stats on SIGUSR2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000009953205f790b805
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I didn't realize it until Lev pointed out that this reply yesterday
didn't go to the list.  FTR, copying to the list.

---------- Forwarded message ---------
From: Selva Nair <selva.nair@...277...>
Date: Wed, Mar 22, 2023 at 9:42=E2=80=AFAM
Subject: Re: [Openvpn-devel] [PATCH] Print DCO client stats on SIGUSR2
To: Lev Stipakov <lev@...515...>



>
>
> >> +    status_printf(so, "TCP/UDP read bytes," counter_format,
> c->c2.link_read_bytes + c->c2.dco_read_bytes);
> >> +    status_printf(so, "TCP/UDP write bytes," counter_format,
> c->c2.link_write_bytes + c->c2.dco_write_bytes);
> >
> > Same here --  have a place to read the total count from independent of
> dco.
>
> But what is wrong in fetching dco stats when we need them? What is the
> advantage of timer?
>

What happens when we have three other drivers like DCO? Not saying that
will ever happen, but using that as an example to clarify why I think this
is "wrong" style.

That said, I agree why a timer may not be a good idea either. If an
approach that can keep internal details "private" is going to be too
complex, we can live with this.

Selva

--00000000000009953205f790b805
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I didn&#39;t=C2=A0realize it until Lev pointed out that th=
is reply yesterday didn&#39;t=C2=A0go to the list.=C2=A0 FTR, copying to th=
e list.<br><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_a=
ttr">---------- Forwarded message ---------<br>From: <strong class=3D"gmail=
_sendername" dir=3D"auto">Selva Nair</strong> <span dir=3D"auto">&lt;<a hre=
f=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a=
>&gt;</span><br>Date: Wed, Mar 22, 2023 at 9:42=E2=80=AFAM<br>Subject: Re: =
[Openvpn-devel] [PATCH] Print DCO client stats on SIGUSR2<br>To: Lev Stipak=
ov &lt;<a href=3D"mailto:lev@...515..." target=3D"_blank">lev@...515...</a>=
&gt;<br></div><br><br><div dir=3D"ltr"><div class=3D"gmail_quote"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><br><br>
<br>
&gt;&gt; +=C2=A0 =C2=A0 status_printf(so, &quot;TCP/UDP read bytes,&quot; c=
ounter_format, c-&gt;c2.link_read_bytes + c-&gt;c2.dco_read_bytes);<br>
&gt;&gt; +=C2=A0 =C2=A0 status_printf(so, &quot;TCP/UDP write bytes,&quot; =
counter_format, c-&gt;c2.link_write_bytes + c-&gt;c2.dco_write_bytes);<br>
&gt;<br>
&gt; Same here --=C2=A0 have a place to read the total count from independe=
nt of dco.<br>
<br>
But what is wrong in fetching dco stats when we need them? What is the<br>
advantage of timer?<br></blockquote><div><br></div><div>What happens=C2=A0w=
hen we have three other drivers like DCO? Not saying that will ever happen,=
 but using that as an example to clarify why I think this is &quot;wrong&qu=
ot; style.=C2=A0</div><div><br></div><div>That said, I agree=C2=A0why a tim=
er may not be a good idea either. If an approach that can=C2=A0keep interna=
l details &quot;private&quot; is going to be too complex, we can live with =
this.</div><div><br></div><div>Selva</div></div></div>
</div></div>

--00000000000009953205f790b805--

