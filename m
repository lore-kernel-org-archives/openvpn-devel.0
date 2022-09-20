MIME-Version: 1.0
References: <20220818084825.187755-1-a@...2181...>
 <20220918220618.31112-1-a@...2181...>
 <YyntXHQMcmih8aLE@...1296...>
 <32aae0d4-d225-a5c1-3ee2-2b03b184d324@...2181...>
In-Reply-To: <32aae0d4-d225-a5c1-3ee2-2b03b184d324@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 20 Sep 2022 15:57:43 -0400
Message-ID: <CAKuzo_gyYS=_cfV9QYi+UbpZbRuKdpJJjuCq3jFdhmNna2=2rg@...278...>
Content-Type: multipart/alternative; boundary="00000000000093ffdb05e92141c8"
Subject: Re: [Openvpn-devel] [PATCH v4] push-peer-info: rearrange function
 generating peer info
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--00000000000093ffdb05e92141c8
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 20, 2022 at 3:26 PM Antonio Quartulli <a@...2181...> wrote:

> Hi,
>
> On 20/09/2022 18:42, Gert Doering wrote:
> > Hi,
> >
> > On Mon, Sep 19, 2022 at 12:06:18AM +0200, Antonio Quartulli wrote:
> >> +    switch (session->opt->push_peer_info_detail)
> >>       {
> >> -        /* push version */
> >> -        buf_printf(&out, "IV_VER=%s\n", PACKAGE_VERSION);
> >> +        case 3:
> >> +        {
> > ...
> >> +        }
> >>
> >> +        /* fall through */
> >
> > These {} brackets are not needed by C or our style guide.
>
> they are required when the first instruction after a case label is a
> variable declaration. So this is needed for case 3, but could be avoided
> for the other 2.
>

IMO, we should have a policy of avoiding variable declarations within case:
clauses.

Whether its the first line after the case: label or not, if the scope is
not limited using {}, it leads to possible jumping over initialization. Its
so easy to overlook that. Unfortunately C (unlike C++) complains loudly
only if the declaration is next to the label.  One could always use {},
but that makes code hard to read. I think its much better to require that
all locals used within a switch block must be defined before all case:
labels.

Selva

--00000000000093ffdb05e92141c8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 20, 2022 at 3:26 PM Anton=
io Quartulli &lt;<a href=3D"mailto:a@...2181...">a@...2181...</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On 20/09/2022 18:42, Gert Doering wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; On Mon, Sep 19, 2022 at 12:06:18AM +0200, Antonio Quartulli wrote:<br>
&gt;&gt; +=C2=A0 =C2=A0 switch (session-&gt;opt-&gt;push_peer_info_detail)<=
br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* push version */<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 buf_printf(&amp;out, &quot;IV_VER=3D%=
s\n&quot;, PACKAGE_VERSION);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 3:<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; ...<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;=C2=A0 =C2=A0<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fall through */<br>
&gt; <br>
&gt; These {} brackets are not needed by C or our style guide.<br>
<br>
they are required when the first instruction after a case label is a <br>
variable declaration. So this is needed for case 3, but could be avoided <b=
r>
for the other 2.<br></blockquote><div><br></div><div>IMO, we should have a =
policy of avoiding variable declarations within case: clauses.<br></div><di=
v><br></div><div>Whether its the first line after the case: label or not, i=
f the scope is not limited using {}, it leads to possible jumping over init=
ialization. Its so easy to overlook that. Unfortunately C (unlike C++) comp=
lains loudly only if the declaration is next to the label.=C2=A0 One could =
always use {},=C2=A0 but that makes code hard to read. I think its much bet=
ter to require that all locals used within a switch block must be defined b=
efore all case: labels.</div><div><br></div><div>Selva</div></div></div>

--00000000000093ffdb05e92141c8--

