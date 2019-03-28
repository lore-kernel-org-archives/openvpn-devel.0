MIME-Version: 1.0
References: <20190328122701.7396-1-cschenk@...2502...>
 <1363f761-21e4-f5e6-8c49-234e1339bc3d@...1227...>
In-Reply-To: <1363f761-21e4-f5e6-8c49-234e1339bc3d@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 28 Mar 2019 11:00:57 -0400
Message-ID: <CAKuzo_gmJSuz0vYx+YugB4qcz3M8MRWNEVw3FuHXsL2KKRSH2Q@...278...>
Content-Type: multipart/alternative; boundary="00000000000046e02f058528d322"
Subject: Re: [Openvpn-devel] [PATCH] Setting adapter mtu on windows systems
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Christopher Schenk <cschenk@...2502...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, Christopher Schenk <Christopher.Schenk@...160...>

--00000000000046e02f058528d322
Content-Type: text/plain; charset="UTF-8"

Hi

On Thu, Mar 28, 2019 at 9:13 AM Arne Schwabe <arne@...1227...> wrote:

> Am 28.03.19 um 13:27 schrieb Christopher Schenk:
> > From: Christopher Schenk <Christopher.Schenk@...160...>
> >
> > ---
> >  src/openvpn/tun.c | 39 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 38 insertions(+), 1 deletion(-)
> >
> > diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> > index 48a8fdf7..93d028c8 100644
> > --- a/src/openvpn/tun.c
> > +++ b/src/openvpn/tun.c
> > @@ -69,6 +69,12 @@ static void netsh_ifconfig(const struct
> tuntap_options *to,
> >                             const in_addr_t netmask,
> >                             const unsigned int flags);
> >
> > +static void netsh_set_mtu_ipv4(const char *flex_name,
> > +                               const int mtu);
> > +
> > +static void netsh_set_mtu_ipv6(const char *flex_name,
> > +                               const int mtu);
> > +
> >  static void netsh_set_dns6_servers(const struct in6_addr *addr_list,
> >                                     const int addr_len,
> >                                     const char *flex_name);
> > @@ -1000,6 +1006,7 @@ do_ifconfig_ipv6(struct tuntap *tt, const char
> *ifname, int tun_mtu,
> >          netsh_command(&argv, 4, M_FATAL);
> >          /* set ipv6 dns servers if any are specified */
> >          netsh_set_dns6_servers(tt->options.dns6, tt->options.dns6_len,
> ifname);
> > +        netsh_set_mtu_ipv6(ifname, tun_mtu);
> >      }
> >
> >      /* explicit route needed */
> > @@ -1391,9 +1398,9 @@ do_ifconfig_ipv4(struct tuntap *tt, const char
> *ifname, int tun_mtu,
> >              case IPW32_SET_NETSH:
> >                  netsh_ifconfig(&tt->options, ifname, tt->local,
> >                                 tt->adapter_netmask,
> NI_IP_NETMASK|NI_OPTIONS);
> > -
> >                  break;
> >          }
> > +             netsh_set_mtu_ipv4(ifname, tun_mtu);
> >      }
> >
> >  #else  /* if defined(TARGET_LINUX) */
> > @@ -5236,6 +5243,36 @@ out:
> >      return ret;
> >  }
> >
> > +static void
> > +netsh_set_mtu_ipv4(const char *flex_name,
> > +                   const int mtu)
> > +{
> > +     struct argv argv = argv_new();
> > +     argv_printf(&argv, "%s%sc interface ipv4 set subinterface %s mtu =
> %d store=active",
>
> The spacing here looks a bit odd. I would have expected mtu=%d instead.
> Is this necessary or was there a reason for doing this?
>
> Patch looks okay enough to ACK but:
>
> In general, this patch adds a missing feature (setting MTU) with one
> windows interface only (netsh). And more commonly used interface
> (interactive service)would be different then leading to harder to debug
> problems.
>

I would go a step further to say we should not add new features that
do not work when started using the interactive service.

Secondly, we should avoid the old style use of netsh and instead use the
iphelper API as far as possible. It should be possible to
set MTU using the SetIfEntry() or SetIpInterfaceEnrty() function -- I
haven't
checked which one is appropriate here.

Selva

--00000000000046e02f058528d322
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Mar 28, 2019 at 9:13 AM Arne Schwabe &lt;<a=
 href=3D"mailto:arne@...1227...">arne@...1227...</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Am 28.03.19 um 13:27 schrie=
b Christopher Schenk:<br>
&gt; From: Christopher Schenk &lt;<a href=3D"mailto:Christopher.Schenk@...1386...=
60..." target=3D"_blank">Christopher.Schenk@...160...</a>&gt;<br>
&gt; <br>
&gt; ---<br>
&gt;=C2=A0 src/openvpn/tun.c | 39 ++++++++++++++++++++++++++++++++++++++-<b=
r>
&gt;=C2=A0 1 file changed, 38 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
&gt; index 48a8fdf7..93d028c8 100644<br>
&gt; --- a/src/openvpn/tun.c<br>
&gt; +++ b/src/openvpn/tun.c<br>
&gt; @@ -69,6 +69,12 @@ static void netsh_ifconfig(const struct tuntap_opti=
ons *to,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const in_addr_t netmask,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const unsigned int flags);<br>
&gt;=C2=A0 <br>
&gt; +static void netsh_set_mtu_ipv4(const char *flex_name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const int mtu);<br>
&gt; +<br>
&gt; +static void netsh_set_mtu_ipv6(const char *flex_name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const int mtu);<br>
&gt; +<br>
&gt;=C2=A0 static void netsh_set_dns6_servers(const struct in6_addr *addr_l=
ist,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const int add=
r_len,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *f=
lex_name);<br>
&gt; @@ -1000,6 +1006,7 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *=
ifname, int tun_mtu,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 netsh_command(&amp;argv, 4, M_FATAL)=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* set ipv6 dns servers if any are s=
pecified */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 netsh_set_dns6_servers(tt-&gt;option=
s.dns6, tt-&gt;options.dns6_len, ifname);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 netsh_set_mtu_ipv6(ifname, tun_mtu);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* explicit route needed */<br>
&gt; @@ -1391,9 +1398,9 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *=
ifname, int tun_mtu,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPW32_SET_NETSH:<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 netsh_if=
config(&amp;tt-&gt;options, ifname, tt-&gt;local,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tt-&gt;adapter_netmask, NI_=
IP_NETMASK|NI_OPTIONS);<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0netsh_set_mtu_ipv4(if=
name, tun_mtu);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #else=C2=A0 /* if defined(TARGET_LINUX) */<br>
&gt; @@ -5236,6 +5243,36 @@ out:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static void<br>
&gt; +netsh_set_mtu_ipv4(const char *flex_name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
const int mtu)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct argv argv =3D argv_new();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0argv_printf(&amp;argv, &quot;%s%sc interface ipv4=
 set subinterface %s mtu =3D %d store=3Dactive&quot;,<br>
<br>
The spacing here looks a bit odd. I would have expected mtu=3D%d instead.<b=
r>
Is this necessary or was there a reason for doing this?<br>
<br>
Patch looks okay enough to ACK but:<br>
<br>
In general, this patch adds a missing feature (setting MTU) with one<br>
windows interface only (netsh). And more commonly used interface<br>
(interactive service)would be different then leading to harder to debug<br>
problems.<br></blockquote><div><br></div><div>I would go a step further to =
say we should not add new features that</div><div>do not work when started =
using the interactive service.</div><div><br></div><div>Secondly, we should=
 avoid the old style use of netsh and instead use the</div><div>iphelper AP=
I as far as possible. It should be possible to</div><div>set MTU using the =
SetIfEntry() or SetIpInterfaceEnrty() function -- I haven&#39;t</div><div>c=
hecked which one is appropriate here.</div><div><br></div><div>Selva=C2=A0<=
/div></div></div>

--00000000000046e02f058528d322--

