MIME-Version: 1.0
References: <20230327171236.51771-1-selva.nair@...277...>
 <b7194780-5729-9435-a641-9ef926926e86@...2181...>
 <CAKuzo_j5tMm+dVweJTrHM=+tGe5Cq_6NNwjb7sxhbLOiD=AN_g@...278...>
In-Reply-To: <CAKuzo_j5tMm+dVweJTrHM=+tGe5Cq_6NNwjb7sxhbLOiD=AN_g@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 27 Mar 2023 16:50:23 -0400
Message-ID: <CAKuzo_jy98_8sUrmh7ZC-ZB2KL_muScMcR13FyHT09u9QVPtCw@...278...>
Content-Type: multipart/alternative; boundary="0000000000003da47d05f7e7e506"
Subject: Re: [Openvpn-devel] [PATCH] Bug-fix: segfault in
 dco_get_peer_stats()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--0000000000003da47d05f7e7e506
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I should have added that as written the fault is with get_dco_peer stats().
It takes a pointer to "struct context" and dereferences a couple of layers
below it. The caller has no idea what it wants to see set in c. So, until
that is changed on all platforms (right now windows and linux), too much to
ask the caller to check that a valid dco handle is available.

Selva

On Mon, Mar 27, 2023 at 4:42=E2=80=AFPM Selva Nair <selva.nair@...277...> w=
rote:

>
>
> On Mon, Mar 27, 2023 at 4:30=E2=80=AFPM Antonio Quartulli <a@...2181...> =
wrote:
>
>> Hi,
>>
>> On 27/03/2023 19:12, selva.nair@...277... wrote:
>> > From: Selva Nair <selva.nair@...277...>
>> >
>> >    We persist peer-stats when restarting, but an early restart
>> >    before open_tun results in a segfault in dco_get_peer_stats().
>> >    To reproduce, trigger a TLS handshake error due to lack of common
>> >    protocols, for example.
>> >
>> >    Fix by checking  that tuntap is defined before dereferencing it.
>> >
>> > Signed-off-by: Selva Nair <selva.nair@...277...>
>>
>> Nice catch! Thanks a lot!
>>
>> > ---
>> > I'm not entirely sure this is the right place to fix this.
>> > Or is it the caller at fault exercising  dco_get_peer_stats()
>> > when tuntap is not set?
>>
>> Indeed that was my assumption.
>>
>> Does somebody have the stacktrace?
>> I wanted to check where this call is coming from exactly.
>>
>
> I didn't save the stacktrace.. The call comes through
>
>  persist_client_stats(c); (openvpn.c ~ line 100)
>
> which gets called on exiting the main eventloop for restart. Without it we
> used to lose
> the statistics on restart.
>
> Imho it'd be reasonable if the caller could check if we have a device
>> before invoking any DCO API.
>>
>
> Sure, I would think that the caller of dco_get_peer_stats() should just
> pass the dco handle to it
> and get the stats back. It's debatable who should check whether
> the dco handle is valid or not.
>
> But this may not be the time and place for a refactor. As dco is young, I
> think it can mature in 2.7..
>
> Selva
>
>
>
>>
>> Cheers,
>>
>> >
>> >   src/openvpn/dco_linux.c | 5 +++++
>> >   1 file changed, 5 insertions(+)
>> >
>> > diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
>> > index 317f9dc0..41540c0f 100644
>> > --- a/src/openvpn/dco_linux.c
>> > +++ b/src/openvpn/dco_linux.c
>> > @@ -975,6 +975,11 @@ dco_get_peer_stats(struct context *c)
>> >       uint32_t peer_id =3D c->c2.tls_multi->dco_peer_id;
>> >       msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peer_id);
>> >
>> > +    if (!c->c1.tuntap)
>> > +    {
>> > +        return 0;
>> > +    }
>> > +
>> >       dco_context_t *dco =3D &c->c1.tuntap->dco;
>> >       struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco,
>> OVPN_CMD_GET_PEER);
>> >       struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_GET_PEE=
R);
>>
>> --
>> Antonio Quartulli
>>
>

--0000000000003da47d05f7e7e506
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div>I should have added that as w=
ritten=C2=A0the fault is with get_dco_peer stats(). It takes a pointer to &=
quot;struct context&quot; and dereferences a couple of layers below it. The=
 caller has no idea what it wants to see set in c. So, until that is change=
d on all platforms (right now windows and linux), too much to ask the calle=
r to check that a valid dco handle is available.<div><br></div><div>Selva</=
div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Mon, Mar 27, 2023 at 4:42=E2=80=AFPM Selva Nair &lt;<a href=3D"mailt=
o:selva.nair@...277...">selva.nair@...277...</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"lt=
r"><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Mon, Mar 27, 2023 at 4:30=E2=80=AFPM Antonio Quartulli &lt;<a hre=
f=3D"mailto:a@...2181..." target=3D"_blank">a@...2181...</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On 27/03/2023 19:12, <a href=3D"mailto:selva.nair@...277..." target=3D"_bla=
nk">selva.nair@...277...</a> wrote:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 We persist peer-stats when restarting, but an early resta=
rt<br>
&gt;=C2=A0 =C2=A0 before open_tun results in a segfault in dco_get_peer_sta=
ts().<br>
&gt;=C2=A0 =C2=A0 To reproduce, trigger a TLS handshake error due to lack o=
f common<br>
&gt;=C2=A0 =C2=A0 protocols, for example.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 Fix by checking=C2=A0 that tuntap is defined before deref=
erencing it.<br>
&gt; <br>
&gt; Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." =
target=3D"_blank">selva.nair@...277...</a>&gt;<br>
<br>
Nice catch! Thanks a lot!<br>
<br>
&gt; ---<br>
&gt; I&#39;m not entirely sure this is the right place to fix this.<br>
&gt; Or is it the caller at fault exercising=C2=A0 dco_get_peer_stats()<br>
&gt; when tuntap is not set?<br>
<br>
Indeed that was my assumption.<br>
<br>
Does somebody have the stacktrace?<br>
I wanted to check where this call is coming from exactly.<br></blockquote><=
div><br></div><div>I didn&#39;t save the stacktrace.. The call comes throug=
h</div><div><br></div><div>=C2=A0persist_client_stats(c); (openvpn.c ~ line=
 100)</div><div><br></div><div>which gets called on exiting the main eventl=
oop for restart. Without it we used to lose</div><div>the statistics on res=
tart.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Imho it&#39;d be reasonable if the caller could check if we have a device <=
br>
before invoking any DCO API.<br></blockquote><div><br></div><div>Sure, I wo=
uld think that the caller of dco_get_peer_stats() should just pass the dco =
handle to it</div><div>and get the stats back. It&#39;s debatable who shoul=
d check whether the=C2=A0dco=C2=A0handle is valid or not.</div><div><br></d=
iv><div>But this may not be the time and place for a refactor. As dco is yo=
ung, I think it can mature in 2.7..</div><div><br>Selva</div><div>=C2=A0</d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Cheers,<br>
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0src/openvpn/dco_linux.c | 5 +++++<br>
&gt;=C2=A0 =C2=A01 file changed, 5 insertions(+)<br>
&gt; <br>
&gt; diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c<br>
&gt; index 317f9dc0..41540c0f 100644<br>
&gt; --- a/src/openvpn/dco_linux.c<br>
&gt; +++ b/src/openvpn/dco_linux.c<br>
&gt; @@ -975,6 +975,11 @@ dco_get_peer_stats(struct context *c)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t peer_id =3D c-&gt;c2.tls_multi-&gt;=
dco_peer_id;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0msg(D_DCO_DEBUG, &quot;%s: peer-id %d&quot;,=
 __func__, peer_id);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 if (!c-&gt;c1.tuntap)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dco_context_t *dco =3D &amp;c-&gt;c1.tuntap-=
&gt;dco;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_cre=
ate(dco, OVPN_CMD_GET_PEER);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct nlattr *attr =3D nla_nest_start(nl_ms=
g, OVPN_ATTR_GET_PEER);<br>
<br>
-- <br>
Antonio Quartulli<br>
</blockquote></div></div>
</blockquote></div>

--0000000000003da47d05f7e7e506--

