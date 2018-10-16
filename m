MIME-Version: 1.0
References: <1515482173-29447-1-git-send-email-eyal.birger@...277...>
 <CAKuzo_hN5A=LB7sp7m3REEpMsePSm-8dpXQUNtbQJz6y8w7zOw@...278...>
In-Reply-To: <CAKuzo_hN5A=LB7sp7m3REEpMsePSm-8dpXQUNtbQJz6y8w7zOw@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 16 Oct 2018 17:48:29 -0400
Message-ID: <CAKuzo_iyBEgd0hUyFgQGm3cU+g9O7oCxs+=x_iDcHaxY5n-5Sg@...278...>
Content-Type: multipart/alternative; boundary="000000000000ba8ea105785f8438"
Subject: Re: [Openvpn-devel] [PATCH] Windows: Set interface IPv6 prefix
 length when configuring address
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000ba8ea105785f8438
Content-Type: text/plain; charset="UTF-8"

Hi,

Going through patchworks noticed this.

Thankfully this never got committed so here goes a retraction.

On Sun, Jan 21, 2018 at 1:45 PM Selva Nair <selva.nair@...277...> wrote:

> Hi,
>
> I'm on a reviewing spree (doing my penance), so here goes..
>
> Thanks for the patch
>
> On Tue, Jan 9, 2018 at 2:16 AM, Eyal Birger <eyal.birger@...277...> wrote:
> > Address prefix length defaults to /64 on Windows. This change allows
> using
> > Windows clients in setups that use a different prefix length.
> >
> > Note: the ability to set the prefix length is documented in the netsh
> > 'add address' command, but works on the 'set address' command as well.
>
> Aside:
> If interactive service is in use, the ip helper API is used and setting
> prefix already works.  Ideally I would like to see openvpn on Windows
> used only with the interactive service, but we are not there yet --
> instances started by the automatic service does not use it and there
> are some users still running the GUI as admin for some inexplicable
> reasons.
>
> So we need to continue supporting these code paths.
>
> >
> > Signed-off-by: Eyal Birger <eyal.birger@...277...>
> > ---
> >  src/openvpn/tun.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> > index 25831ce..b2b4795 100644
> > --- a/src/openvpn/tun.c
> > +++ b/src/openvpn/tun.c
> > @@ -1561,15 +1561,16 @@ do_ifconfig(struct tuntap *tt,
> >              }
> >              else
> >              {
> > -                /* example: netsh interface ipv6 set address
> interface=42 2001:608:8003::d store=active */
> > +                /* example: netsh interface ipv6 set address
> interface=42 2001:608:8003::d/64 store=active */
> >                  char iface[64];
> >                  openvpn_snprintf(iface, sizeof(iface), "interface=%lu",
> tt->adapter_index );
> >                  argv_printf(&argv,
> > -                            "%s%sc interface ipv6 set address %s %s
> store=active",
> > +                            "%s%sc interface ipv6 set address %s %s/%d
> store=active",
> >                              get_win_sys_path(),
> >                              NETSH_PATH_SUFFIX,
> >                              iface,
> > -                            ifconfig_ipv6_local );
> > +                            ifconfig_ipv6_local,
> > +                            tt->netbits_ipv6);
> >                  netsh_command(&argv, 4, M_FATAL);
> >                  /* set ipv6 dns servers if any are specified */
> >                  netsh_set_dns6_servers(tt->options.dns6,
> tt->options.dns6_len, actual);
>
> Works as expected and the code is good.
>
> Currently, on setting the address, a default route gets set with
> prefix /64 with gateway as OnLink (does not happen when iphelper api
> is used). Although our explicit route to fe80::8 may override it, it
> looks better to set the correct prefix in the address. So:
>
> Acked-by: Selva Nair <selva.nair@...277...>
>

Though this works in my tests I want to retract this ACK.

Apart from possible issues due to the appearance of the onlink route in
some cases, I think the correct approach going forward is to stop using
netsh and use the IP helper API for such tasks. And do it in the same way
as done using the service.

Un-Acked-by: Selva Nair <selva.nair@...277...> :)

Selva

--000000000000ba8ea105785f8438
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br><br></div><div>Going through patchworks notice=
d this.<br><br></div>Thankfully this never got committed so here goes a ret=
raction.<br><div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Su=
n, Jan 21, 2018 at 1:45 PM Selva Nair &lt;<a href=3D"mailto:selva.nair@...1665...=
77...">selva.nair@...277...</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">Hi,<br>
<br>
I&#39;m on a reviewing spree (doing my penance), so here goes..<br>
<br>
Thanks for the patch<br>
<br>
On Tue, Jan 9, 2018 at 2:16 AM, Eyal Birger &lt;<a href=3D"mailto:eyal.birg=
er@...277..." target=3D"_blank">eyal.birger@...277...</a>&gt; wrote:<br>
&gt; Address prefix length defaults to /64 on Windows. This change allows u=
sing<br>
&gt; Windows clients in setups that use a different prefix length.<br>
&gt;<br>
&gt; Note: the ability to set the prefix length is documented in the netsh<=
br>
&gt; &#39;add address&#39; command, but works on the &#39;set address&#39; =
command as well.<br>
<br>
Aside:<br>
If interactive service is in use, the ip helper API is used and setting<br>
prefix already works.=C2=A0 Ideally I would like to see openvpn on Windows<=
br>
used only with the interactive service, but we are not there yet --<br>
instances started by the automatic service does not use it and there<br>
are some users still running the GUI as admin for some inexplicable<br>
reasons.<br>
<br>
So we need to continue supporting these code paths.<br>
<br>
&gt;<br>
&gt; Signed-off-by: Eyal Birger &lt;<a href=3D"mailto:eyal.birger@...277...=
" target=3D"_blank">eyal.birger@...277...</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 src/openvpn/tun.c | 7 ++++---<br>
&gt;=C2=A0 1 file changed, 4 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
&gt; index 25831ce..b2b4795 100644<br>
&gt; --- a/src/openvpn/tun.c<br>
&gt; +++ b/src/openvpn/tun.c<br>
&gt; @@ -1561,15 +1561,16 @@ do_ifconfig(struct tuntap *tt,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* example: n=
etsh interface ipv6 set address interface=3D42 2001:608:8003::d store=3Dact=
ive */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* example: n=
etsh interface ipv6 set address interface=3D42 2001:608:8003::d/64 store=3D=
active */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char ifa=
ce[64];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 openvpn_=
snprintf(iface, sizeof(iface), &quot;interface=3D%lu&quot;, tt-&gt;adapter_=
index );<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argv_pri=
ntf(&amp;argv,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%s%sc interface ipv6 set address %s %s s=
tore=3Dactive&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%s%sc interface ipv6 set address %s %s/%=
d store=3Dactive&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_win_sys_path(),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NETSH_PATH_SUFFIX,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iface,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ifconfig_ipv6_local );<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ifconfig_ipv6_local,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tt-&gt;netbits_ipv6);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 netsh_co=
mmand(&amp;argv, 4, M_FATAL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* set i=
pv6 dns servers if any are specified */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 netsh_se=
t_dns6_servers(tt-&gt;options.dns6, tt-&gt;options.dns6_len, actual);<br>
<br>
Works as expected and the code is good.<br>
<br>
Currently, on setting the address, a default route gets set with<br>
prefix /64 with gateway as OnLink (does not happen when iphelper api<br>
is used). Although our explicit route to fe80::8 may override it, it<br>
looks better to set the correct prefix in the address. So:<br>
<br>
Acked-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D"=
_blank">selva.nair@...277...</a>&gt;<br></blockquote><div><br></div><div>Th=
ough this works in my tests I want to retract this ACK.<br><br>Apart from p=
ossible issues due to the appearance of the onlink route in some cases, I t=
hink the correct approach going forward is to stop using netsh and use the =
IP helper API for such tasks. And do it in the same way as done using the s=
ervice. <br><br></div><div>Un-Acked-by: Selva Nair &lt;<a href=3D"mailto:se=
lva.nair@...277...">selva.nair@...277...</a>&gt; :)<br><br></div><div>Selva=
<br></div></div></div></div></div>

--000000000000ba8ea105785f8438--

