MIME-Version: 1.0
References: <CAAWBBYOr-ZKmr3754DqzkssCr04C=n75C4bOihN04nx-4-xVvw@...278...>
 <baac3422-1f0b-4587-bef6-0e23f8b6a296@...1227...>
In-Reply-To: <baac3422-1f0b-4587-bef6-0e23f8b6a296@...1227...>
From: Rafael Gava <gava100@...277...>
Date: Sun, 23 Feb 2025 16:05:19 -0300
Message-ID: <CAAWBBYPh5gUvLrdkSXyzGcwn7FP-VUVQXg1pHpPbjemdknzY=w@...278...>
Content-Type: multipart/alternative; boundary="000000000000092733062ed3e805"
Subject: Re: [Openvpn-devel] [PATCH] Add 'localhost' token to client-nat
 network option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000092733062ed3e805
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arne,

Thank you for your feedback.

I agree with your suggestion and will replace the localhost token with
'assigned-ip' before resubmitting the patch.

Regarding your question about testing P2P, I haven't tested it yet. Do you
happen to have a configuration I could use for this scenario?

Best regards,
Rafael

On Fri, Feb 21, 2025 at 9:05=E2=80=AFAM Arne Schwabe <arne@...1227...> wrot=
e:

> Am 20.02.25 um 20:48 schrieb Rafael Gava:
> > Dear OpenVPN Community,
> >
> > I am submitting this patch to introduce a 'localhost' token to the
> > `client-nat` network option, allowing OpenVPN clients to dynamically use
> > the IP address provided by the server. This enhancement is particularly
> > useful in scenarios where OpenVPN is deployed as a VPN gateway bridging
> > a local network and a VPN tunnel.
> >
> > Currently, the `client-nat` option requires a static client IP, which
> > limits its flexibility when dealing with dynamically assigned IP
> > addresses. By introducing a 'localhost' token, OpenVPN can automatically
> > substitute it with the current client-assigned IP address, streamlining
> > network configurations in dynamic environments.
> >
> > Example:
> >
> > client-nat snat localhost 255.255.255.255 172.19.80.17
>
> I would assume that localhost here matches only 127.0.0.1. I would
> prefer something like assigned-ip or something that actually matches the
> real behaviour instead of reusing something that already has a pretty
> established meaning.
>
> >=3D
> > diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
> > index 2d3b359f..1c79b20d 100644
> > --- a/src/openvpn/clinat.c
> > +++ b/src/openvpn/clinat.c
> > @@ -127,12 +127,19 @@ add_client_nat_to_option_list(struct
> > client_nat_option_list *dest,
> >           return;
> >       }
> >
> > -    e.network =3D getaddr(0, network, 0, &ok, NULL);
> > -    if (!ok)
> > +    if (network && !strcmp(network, "localhost"))
> >       {
> > -        msg(msglevel, "client-nat: bad network: %s", network);
> > -        return;
> > +        msg (M_INFO, "*** client-nat localhost detected...");
>
> This looks like a left over debug message.
>
> > +        e.network =3D 0xFFFFFFFF;
> > +    } else {
> > +        e.network =3D getaddr(0, network, 0, &ok, NULL);
> > +        if (!ok)
> > +        {
> > +            msg(msglevel, "client-nat: bad network: %s", network);
> > +            return;
> > +        }
> >       }
> > +
> >       e.netmask =3D getaddr(0, netmask, 0, &ok, NULL);
> >       if (!ok)
> >       {
> > @@ -274,3 +281,35 @@ client_nat_transform(const struct
> > client_nat_option_list *list,
> >           }
> >       }
> >   }
> > +
> > +/*
> > +* Replaces the localhost token with the IP received from OpenVPN
> > +*/
> > +bool
> > +update_localhost_nat(struct client_nat_option_list *dest, in_addr_t
> > local_ip)
> > +{
> > +    int i;
> > +    bool ret =3D false;
> > +
> > +    if (!dest) {
> > +        return ret;
> > +    }
> > +
> > +    for (i=3D0; i <=3D dest->n; i++)
> > +    {
> > +        struct client_nat_entry *nat_entry =3D &dest->entries[i];
> > +        if (nat_entry && nat_entry->network =3D=3D 0xFFFFFFFF)
> > +        {
> > +            struct in_addr addr;
> > +
> > +            nat_entry->network =3D ntohl(local_ip);
> > +            addr.s_addr =3D nat_entry->network;
> > +            char *dot_ip =3D inet_ntoa(addr);
> > +
> > +            msg (M_INFO, "CNAT - Updating NAT table from localhost to:
> > %s", dot_ip);
> > +            ret =3D true;
> > +        }
> > +    }
> > +
> > +    return ret;
> > +}
> > diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
> > index 94141f51..06afa3b4 100644
> > --- a/src/openvpn/clinat.h
> > +++ b/src/openvpn/clinat.h
> > @@ -64,4 +64,7 @@ void client_nat_transform(const struct
> > client_nat_option_list *list,
> >                             struct buffer *ipbuf,
> >                             const int direction);
> >
> > +bool update_localhost_nat(struct client_nat_option_list *dest,
> > in_addr_t local_ip);
> > +
> > +
> >   #endif /* if !defined(CLINAT_H) */
> > diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> > index b57e5f8a..dadc10dc 100644
> > --- a/src/openvpn/init.c
> > +++ b/src/openvpn/init.c
> > @@ -2052,6 +2052,8 @@ do_open_tun(struct context *c, int *error_flags)
> >               *error_flags |=3D (status ? 0 : ISC_ROUTE_ERRORS);
> >           }
> >
> > +        update_localhost_nat(c->options.client_nat,
> c->c1.tuntap->local);
> > +
> >           ret =3D true;
> >           static_context =3D c;
> >       }
> > diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> > index 6b2dfa58..f7161931 100644
> > --- a/src/openvpn/options.c
> > +++ b/src/openvpn/options.c
> > @@ -254,6 +254,7 @@ static const char usage_message[] =3D
> >       "                   (Server) Instead of forwarding IPv6 packets
> > send\n"
> >       "                   ICMPv6 host unreachable packets to the
> client.\n"
> >       "--client-nat snat|dnat network netmask alias : on client add 1-
> > to-1 NAT rule.\n"
> > +    "                  set the network to 'localhost' to use the client
> > ip received from the server.\n"
> >       "--push-peer-info : (client only) push client info to server.\n"
> >       "--setenv name value : Set a custom environmental variable to pass
> > to script.\n"
> >       "--setenv FORWARD_COMPATIBLE 1 : Relax config file syntax checking
> > to allow\n"
>
>
> OpenVPN also needs to work in configuration that are pure p2p without
> --pull (or --client with is --tls-client +  --pull). Have you tested
> that it works in that configuration as well?
>
> Arne
>
>
>

--000000000000092733062ed3e805
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Arne,<br><br>Thank you for your feedback.<br><br>I agre=
e with your suggestion and will replace the localhost token with &#39;assig=
ned-ip&#39; before resubmitting the patch.<br><br>Regarding your question a=
bout testing P2P, I haven&#39;t tested it yet. Do you happen to have a conf=
iguration I could use for this scenario?<br><br>Best regards,<br><div>Rafae=
l</div><div><br></div><div class=3D"gmail_quote gmail_quote_container"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 21, 2025 at 9:05=E2=80=AFAM A=
rne Schwabe &lt;<a href=3D"mailto:arne@...1227...">arne@...1227...</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Am 20.02.=
25 um 20:48 schrieb Rafael Gava:<br>
&gt; Dear OpenVPN Community,<br>
&gt; <br>
&gt; I am submitting this patch to introduce a &#39;localhost&#39; token to=
 the <br>
&gt; `client-nat` network option, allowing OpenVPN clients to dynamically u=
se <br>
&gt; the IP address provided by the server. This enhancement is particularl=
y <br>
&gt; useful in scenarios where OpenVPN is deployed as a VPN gateway bridgin=
g <br>
&gt; a local network and a VPN tunnel.<br>
&gt; <br>
&gt; Currently, the `client-nat` option requires a static client IP, which =
<br>
&gt; limits its flexibility when dealing with dynamically assigned IP <br>
&gt; addresses. By introducing a &#39;localhost&#39; token, OpenVPN can aut=
omatically <br>
&gt; substitute it with the current client-assigned IP address, streamlinin=
g <br>
&gt; network configurations in dynamic environments.<br>
&gt; <br>
&gt; Example:<br>
&gt; <br>
&gt; client-nat snat localhost 255.255.255.255 172.19.80.17<br>
<br>
I would assume that localhost here matches only 127.0.0.1. I would <br>
prefer something like assigned-ip or something that actually matches the <b=
r>
real behaviour instead of reusing something that already has a pretty <br>
established meaning.<br>
<br>
&gt;=3D<br>
&gt; diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c<br>
&gt; index 2d3b359f..1c79b20d 100644<br>
&gt; --- a/src/openvpn/clinat.c<br>
&gt; +++ b/src/openvpn/clinat.c<br>
&gt; @@ -127,12 +127,19 @@ add_client_nat_to_option_list(struct <br>
&gt; client_nat_option_list *dest,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt; - =C2=A0 =C2=A0e.network =3D getaddr(0, network, 0, &amp;ok, NULL);<br>
&gt; - =C2=A0 =C2=A0if (!ok)<br>
&gt; + =C2=A0 =C2=A0if (network &amp;&amp; !strcmp(network, &quot;localhost=
&quot;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(msglevel, &quot;client-nat: bad netwo=
rk: %s&quot;, network);<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_INFO, &quot;*** client-nat localho=
st detected...&quot;);<br>
<br>
This looks like a left over debug message.<br>
<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0e.network =3D 0xFFFFFFFF;<br>
&gt; + =C2=A0 =C2=A0} else {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0e.network =3D getaddr(0, network, 0, &amp=
;ok, NULL);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ok)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(msglevel, &quot;client-=
nat: bad network: %s&quot;, network);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0e.netmask =3D getaddr(0, netmask, 0, &amp;ok=
, NULL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ok)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt; @@ -274,3 +281,35 @@ client_nat_transform(const struct <br>
&gt; client_nat_option_list *list,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +/*<br>
&gt; +* Replaces the localhost token with the IP received from OpenVPN<br>
&gt; +*/<br>
&gt; +bool<br>
&gt; +update_localhost_nat(struct client_nat_option_list *dest, in_addr_t <=
br>
&gt; local_ip)<br>
&gt; +{<br>
&gt; + =C2=A0 =C2=A0int i;<br>
&gt; + =C2=A0 =C2=A0bool ret =3D false;<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0if (!dest) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; + =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0for (i=3D0; i &lt;=3D dest-&gt;n; i++)<br>
&gt; + =C2=A0 =C2=A0{<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct client_nat_entry *nat_entry =3D &a=
mp;dest-&gt;entries[i];<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nat_entry &amp;&amp; nat_entry-&gt;ne=
twork =3D=3D 0xFFFFFFFF)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct in_addr addr;<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nat_entry-&gt;network =3D n=
tohl(local_ip);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr.s_addr =3D nat_entry-&=
gt;network;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *dot_ip =3D inet_ntoa(=
addr);<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_INFO, &quot;CNAT - U=
pdating NAT table from localhost to: <br>
&gt; %s&quot;, dot_ip);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D true;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; + =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0return ret;<br>
&gt; +}<br>
&gt; diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h<br>
&gt; index 94141f51..06afa3b4 100644<br>
&gt; --- a/src/openvpn/clinat.h<br>
&gt; +++ b/src/openvpn/clinat.h<br>
&gt; @@ -64,4 +64,7 @@ void client_nat_transform(const struct <br>
&gt; client_nat_option_list *list,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct buffer *ipbuf,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const int direction);<br>
&gt; <br>
&gt; +bool update_localhost_nat(struct client_nat_option_list *dest, <br>
&gt; in_addr_t local_ip);<br>
&gt; +<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0#endif /* if !defined(CLINAT_H) */<br>
&gt; diff --git a/src/openvpn/init.c b/src/openvpn/init.c<br>
&gt; index b57e5f8a..dadc10dc 100644<br>
&gt; --- a/src/openvpn/init.c<br>
&gt; +++ b/src/openvpn/init.c<br>
&gt; @@ -2052,6 +2052,8 @@ do_open_tun(struct context *c, int *error_flags)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*error_flags |=
=3D (status ? 0 : ISC_ROUTE_ERRORS);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0update_localhost_nat(c-&gt;options.client=
_nat, c-&gt;c1.tuntap-&gt;local);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0static_context =3D c;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; diff --git a/src/openvpn/options.c b/src/openvpn/options.c<br>
&gt; index 6b2dfa58..f7161931 100644<br>
&gt; --- a/src/openvpn/options.c<br>
&gt; +++ b/src/openvpn/options.c<br>
&gt; @@ -254,6 +254,7 @@ static const char usage_message[] =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (Server) Instead of forwarding IPv6 packets <br>
&gt; send\n&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ICMPv6 host unreachable packets to the client.\=
n&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;--client-nat snat|dnat network netmask=
 alias : on client add 1- <br>
&gt; to-1 NAT rule.\n&quot;<br>
&gt; + =C2=A0 =C2=A0&quot; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0set the network to &#39;localhost&#39; to use the client <br>
&gt; ip received from the server.\n&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;--push-peer-info : (client only) push =
client info to server.\n&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;--setenv name value : Set a custom env=
ironmental variable to pass <br>
&gt; to script.\n&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;--setenv FORWARD_COMPATIBLE 1 : Relax =
config file syntax checking <br>
&gt; to allow\n&quot;<br>
<br>
<br>
OpenVPN also needs to work in configuration that are pure p2p without <br>
--pull (or --client with is --tls-client +=C2=A0 --pull). Have you tested <=
br>
that it works in that configuration as well?<br>
<br>
Arne<br>
<br>
<br>
</blockquote></div></div>

--000000000000092733062ed3e805--

