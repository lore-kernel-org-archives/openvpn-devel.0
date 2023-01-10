MIME-Version: 1.0
References: <20230106150412.1667492-1-selva.nair@...277...>
 <202301091217.309CH5AT018457@...2054...>
In-Reply-To: <202301091217.309CH5AT018457@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 9 Jan 2023 19:56:10 -0500
Message-ID: <CAKuzo_g44mi71vHj8E1-9O93hU9DRAb+8sttH_y0wmyO7X0Zrw@...278...>
Content-Type: multipart/alternative; boundary="0000000000007fa53a05f1de5a9d"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Distinguish route addition
 errors from route already exists
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--0000000000007fa53a05f1de5a9d
Content-Type: text/plain; charset="UTF-8"

Hi

On Mon, Jan 9, 2023 at 7:17 AM Gert Doering <gert@...1296...> wrote:

>
> I also notice that there is quite a bit of imbalance between IPv4 and
> IPv6 route addition on Windows - for IPv6, add_route_ipv6() will not
> print any messages (so, no diff here), while IPv4 has all that...
> maybe something to clean up in 2.7.
>
> We *also* might want to get rid of that obscure
>
>   /* failed, try increasing the metric to work around Vista issue */
>
> code bit, which looks extremely scary ("increasing metric with +1 in
> a tight loop until we reach 2048") and Vista is out of support anyway...
>

In fact the issue worked around is not a Vista thing but Vista+ including
Win10 and results from wrong use of the API. The old API used here requires
the metric parameter to be the route metric  + interface metric starting
Vista+.  So metric = 0 or any value < interface-metric fails. If we want a
metric of 5 on an interface that has a metric of 20, we have to pass in 25.

Looks like someone (I won't say who) added that obnoxious loop trying
metric from 0 to 2048 to work around this. Probably the idea was to support
pre-vista and vista without needing a run-time check.

That said, in Vista+ one should use CreateIpForwardEntry2() which is much
easier. As we do for IPv6 and for both v4 and v6 in the service.

Let's rewrite this function in 2.7.

Selva

--0000000000007fa53a05f1de5a9d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Jan 9, 2023 at 7:17 AM Gert Doering &lt;<a =
href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><br>
I also notice that there is quite a bit of imbalance between IPv4 and<br>
IPv6 route addition on Windows - for IPv6, add_route_ipv6() will not<br>
print any messages (so, no diff here), while IPv4 has all that...<br>
maybe something to clean up in 2.7.<br>
<br>
We *also* might want to get rid of that obscure <br>
<br>
=C2=A0 /* failed, try increasing the metric to work around Vista issue */<b=
r>
<br>
code bit, which looks extremely scary (&quot;increasing metric with +1 in<b=
r>
a tight loop until we reach 2048&quot;) and Vista is out of support anyway.=
..<br></blockquote><div><br></div><div>In fact the=C2=A0issue worked around=
=C2=A0is not a Vista thing but Vista+ including Win10 and results from wron=
g use of the API. The=C2=A0old API used here requires the metric parameter =
to be the route metric=C2=A0 + interface metric starting Vista+.=C2=A0 So m=
etric =3D 0 or any value &lt; interface-metric fails. If we want a metric o=
f 5 on an interface that has a metric of 20, we have to pass in 25.</div><d=
iv><br></div><div>Looks like someone (I won&#39;t say who) added that obnox=
ious loop trying metric from 0 to 2048 to work around this. Probably the id=
ea was to support pre-vista and vista without needing a run-time check.</di=
v><div><br></div><div>That said, in Vista+=C2=A0one should use CreateIpForw=
ardEntry2() which is much easier. As we do for IPv6 and for both v4 and v6 =
in the service.</div><div><br></div><div>Let&#39;s rewrite this function in=
 2.7.</div><div><br></div><div>Selva</div></div></div>

--0000000000007fa53a05f1de5a9d--

