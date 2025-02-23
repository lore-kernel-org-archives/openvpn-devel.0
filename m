MIME-Version: 1.0
References: <CAAWBBYOr-ZKmr3754DqzkssCr04C=n75C4bOihN04nx-4-xVvw@...278...>
 <Z7hqbzqBZG1EC6jR@...2685...>
In-Reply-To: <Z7hqbzqBZG1EC6jR@...2685...>
From: Rafael Gava <gava100@...277...>
Date: Sun, 23 Feb 2025 15:26:36 -0300
Message-ID: <CAAWBBYOgTGFmfpX11FBBG08Z7RWL8qNFV--PgUv++Tpnz_VauQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000924c06062ed35d14"
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000924c06062ed35d14
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frank,

Thank you for your feedback. I'll make the changes as per your suggestions
and resubmit the patch later. My apologies for not realizing that you were
using a formatting check tool. I installed Uncrustify, and it worked
perfectly. :-)

I also wanted to ask about the automated tests on GitHub. Should I fork the
project and submit the patch there, or should I submit it directly to the
main project? What is the recommended approach?

Looking forward to your guidance.

Best regards,
Rafael


On Fri, Feb 21, 2025 at 8:58=E2=80=AFAM Frank Lichtenheld <frank@...2641...>
wrote:

> On Thu, Feb 20, 2025 at 04:48:27PM -0300, Rafael Gava wrote:
> > I believe this feature will be beneficial for many OpenVPN users,
> improving
> > automation and simplifying VPN gateway configurations. Please find the
> > patch inline for review and feedback.
> >
>
> Thanks for your submission. Some general notes about the patch.
> (Not a review of the actual change but more about the format of
> submission)
>
> > ----
> > From fbc7045d652b5f11e2aa043aa2af9ca14f36b604 Mon Sep 17 00:00:00 2001
> > From: Rafael Gava <gava100@...277...>
> > Date: Thu, 20 Feb 2025 19:19:39 +0000
> > Subject: [PATCH] Added the localhost token to the client-nat network
> option,
> >  enabling the application to dynamically use the client IP provided by
> the
> >  server.
>
> The subject line should be concise and make sense on its own. The rest
> of the commit message should be the longer description. You can achieve
> this
> by adding an empty line after the first one.
>
> > Signed-off-by: Rafael Gava <gava100@...277...>
> > ---
> >  src/openvpn/clinat.c  | 47 +++++++++++++++++++++++++++++++++++++++----
> >  src/openvpn/clinat.h  |  3 +++
> >  src/openvpn/init.c    |  2 ++
> >  src/openvpn/options.c |  1 +
> >  4 files changed, 49 insertions(+), 4 deletions(-)
> >
> > diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
> > index 2d3b359f..1c79b20d 100644
> > --- a/src/openvpn/clinat.c
> > +++ b/src/openvpn/clinat.c
> > @@ -127,12 +127,19 @@ add_client_nat_to_option_list(struct
> > client_nat_option_list *dest,
> >          return;
> >      }
> >
> > -    e.network =3D getaddr(0, network, 0, &ok, NULL);
> > -    if (!ok)
> > +    if (network && !strcmp(network, "localhost"))
> >      {
> > -        msg(msglevel, "client-nat: bad network: %s", network);
> > -        return;
> > +        msg (M_INFO, "*** client-nat localhost detected...");
> > +        e.network =3D 0xFFFFFFFF;
> > +    } else {
>
> This is not in line with our usual formatting. We always format
> like this
>
> }
> else
> {
>
> There is an uncrustify config in dev-tools/uncrustify.conf that can
> help to check the formatting. Or you submit the patch in Github or
> Gerrit which can do automated checks of the formatting.
>
> > +        e.network =3D getaddr(0, network, 0, &ok, NULL);
> > +        if (!ok)
> > +        {
> > +            msg(msglevel, "client-nat: bad network: %s", network);
> > +            return;
> > +        }
> >      }
> > +
> >      e.netmask =3D getaddr(0, netmask, 0, &ok, NULL);
> >      if (!ok)
> >      {
> > @@ -274,3 +281,35 @@ client_nat_transform(const struct
> > client_nat_option_list *list,
> >          }
> >      }
> >  }
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
> >                            struct buffer *ipbuf,
> >                            const int direction);
> >
> > +bool update_localhost_nat(struct client_nat_option_list *dest, in_addr=
_t
> > local_ip);
> > +
> > +
> >  #endif /* if !defined(CLINAT_H) */
> > diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> > index b57e5f8a..dadc10dc 100644
> > --- a/src/openvpn/init.c
> > +++ b/src/openvpn/init.c
> > @@ -2052,6 +2052,8 @@ do_open_tun(struct context *c, int *error_flags)
> >              *error_flags |=3D (status ? 0 : ISC_ROUTE_ERRORS);
> >          }
> >
> > +        update_localhost_nat(c->options.client_nat,
> c->c1.tuntap->local);
> > +
> >          ret =3D true;
> >          static_context =3D c;
> >      }
> > diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> > index 6b2dfa58..f7161931 100644
> > --- a/src/openvpn/options.c
> > +++ b/src/openvpn/options.c
> > @@ -254,6 +254,7 @@ static const char usage_message[] =3D
> >      "                   (Server) Instead of forwarding IPv6 packets
> send\n"
> >      "                   ICMPv6 host unreachable packets to the
> client.\n"
> >      "--client-nat snat|dnat network netmask alias : on client add 1-to=
-1
> > NAT rule.\n"
> > +    "                  set the network to 'localhost' to use the client
> ip
> > received from the server.\n"
>
> Please also include an update to the documentation in
> doc/man-sections/client-options.rst
>
> >      "--push-peer-info : (client only) push client info to server.\n"
> >      "--setenv name value : Set a custom environmental variable to pass
> to
> > script.\n"
> >      "--setenv FORWARD_COMPATIBLE 1 : Relax config file syntax checking
> to
> > allow\n"
> > --
> > 2.39.5
>
> Regards,
> --
>   Frank Lichtenheld
>

--000000000000924c06062ed35d14
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div></div>Hi Frank,<br><br>Thank you for=
 your feedback. I&#39;ll make the changes as per your suggestions and resub=
mit the patch later. My apologies for not realizing that you were using a f=
ormatting check tool. I installed Uncrustify, and it worked perfectly. :-)<=
br><br>I also wanted to ask about the automated tests on GitHub. Should I f=
ork the project and submit the patch there, or should I submit it directly =
to the main project? What is the recommended approach?<br><br>Looking forwa=
rd to your guidance.<br><br>Best regards,<br>Rafael<div><br></div></div><br=
><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D=
"gmail_attr">On Fri, Feb 21, 2025 at 8:58=E2=80=AFAM Frank Lichtenheld &lt;=
<a href=3D"mailto:frank@...2641...">frank@...2641...</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, Feb 20, 2025 at=
 04:48:27PM -0300, Rafael Gava wrote:<br>
&gt; I believe this feature will be beneficial for many OpenVPN users, impr=
oving<br>
&gt; automation and simplifying VPN gateway configurations. Please find the=
<br>
&gt; patch inline for review and feedback.<br>
&gt; <br>
<br>
Thanks for your submission. Some general notes about the patch.<br>
(Not a review of the actual change but more about the format of<br>
submission)<br>
<br>
&gt; ----<br>
&gt; From fbc7045d652b5f11e2aa043aa2af9ca14f36b604 Mon Sep 17 00:00:00 2001=
<br>
&gt; From: Rafael Gava &lt;<a href=3D"mailto:gava100@...277..." target=3D"_=
blank">gava100@...277...</a>&gt;<br>
&gt; Date: Thu, 20 Feb 2025 19:19:39 +0000<br>
&gt; Subject: [PATCH] Added the localhost token to the client-nat network o=
ption,<br>
&gt;=C2=A0 enabling the application to dynamically use the client IP provid=
ed by the<br>
&gt;=C2=A0 server.<br>
<br>
The subject line should be concise and make sense on its own. The rest<br>
of the commit message should be the longer description. You can achieve thi=
s<br>
by adding an empty line after the first one.<br>
<br>
&gt; Signed-off-by: Rafael Gava &lt;<a href=3D"mailto:gava100@...277..." ta=
rget=3D"_blank">gava100@...277...</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 src/openvpn/clinat.c=C2=A0 | 47 ++++++++++++++++++++++++++++++++=
+++++++----<br>
&gt;=C2=A0 src/openvpn/clinat.h=C2=A0 |=C2=A0 3 +++<br>
&gt;=C2=A0 src/openvpn/init.c=C2=A0 =C2=A0 |=C2=A0 2 ++<br>
&gt;=C2=A0 src/openvpn/options.c |=C2=A0 1 +<br>
&gt;=C2=A0 4 files changed, 49 insertions(+), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c<br>
&gt; index 2d3b359f..1c79b20d 100644<br>
&gt; --- a/src/openvpn/clinat.c<br>
&gt; +++ b/src/openvpn/clinat.c<br>
&gt; @@ -127,12 +127,19 @@ add_client_nat_to_option_list(struct<br>
&gt; client_nat_option_list *dest,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; <br>
&gt; -=C2=A0 =C2=A0 e.network =3D getaddr(0, network, 0, &amp;ok, NULL);<br>
&gt; -=C2=A0 =C2=A0 if (!ok)<br>
&gt; +=C2=A0 =C2=A0 if (network &amp;&amp; !strcmp(network, &quot;localhost=
&quot;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(msglevel, &quot;client-nat: bad netwo=
rk: %s&quot;, network);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_INFO, &quot;*** client-nat localho=
st detected...&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 e.network =3D 0xFFFFFFFF;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
<br>
This is not in line with our usual formatting. We always format<br>
like this<br>
<br>
}<br>
else<br>
{<br>
<br>
There is an uncrustify config in dev-tools/uncrustify.conf that can<br>
help to check the formatting. Or you submit the patch in Github or<br>
Gerrit which can do automated checks of the formatting.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 e.network =3D getaddr(0, network, 0, &amp=
;ok, NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ok)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(msglevel, &quot;client-=
nat: bad network: %s&quot;, network);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 e.netmask =3D getaddr(0, netmask, 0, &amp;ok, NULL=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!ok)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 {<br>
&gt; @@ -274,3 +281,35 @@ client_nat_transform(const struct<br>
&gt; client_nat_option_list *list,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt; +<br>
&gt; +/*<br>
&gt; +* Replaces the localhost token with the IP received from OpenVPN<br>
&gt; +*/<br>
&gt; +bool<br>
&gt; +update_localhost_nat(struct client_nat_option_list *dest, in_addr_t<b=
r>
&gt; local_ip)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +=C2=A0 =C2=A0 bool ret =3D false;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!dest) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i=3D0; i &lt;=3D dest-&gt;n; i++)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct client_nat_entry *nat_entry =3D &a=
mp;dest-&gt;entries[i];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (nat_entry &amp;&amp; nat_entry-&gt;ne=
twork =3D=3D 0xFFFFFFFF)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct in_addr addr;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nat_entry-&gt;network =3D n=
tohl(local_ip);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr.s_addr =3D nat_entry-&=
gt;network;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *dot_ip =3D inet_ntoa(=
addr);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_INFO, &quot;CNAT - U=
pdating NAT table from localhost to:<br>
&gt; %s&quot;, dot_ip);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h<br>
&gt; index 94141f51..06afa3b4 100644<br>
&gt; --- a/src/openvpn/clinat.h<br>
&gt; +++ b/src/openvpn/clinat.h<br>
&gt; @@ -64,4 +64,7 @@ void client_nat_transform(const struct<br>
&gt; client_nat_option_list *list,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct buffer *ipbuf,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const int direction);<br>
&gt; <br>
&gt; +bool update_localhost_nat(struct client_nat_option_list *dest, in_add=
r_t<br>
&gt; local_ip);<br>
&gt; +<br>
&gt; +<br>
&gt;=C2=A0 #endif /* if !defined(CLINAT_H) */<br>
&gt; diff --git a/src/openvpn/init.c b/src/openvpn/init.c<br>
&gt; index b57e5f8a..dadc10dc 100644<br>
&gt; --- a/src/openvpn/init.c<br>
&gt; +++ b/src/openvpn/init.c<br>
&gt; @@ -2052,6 +2052,8 @@ do_open_tun(struct context *c, int *error_flags)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *error_flags |=3D (sta=
tus ? 0 : ISC_ROUTE_ERRORS);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 update_localhost_nat(c-&gt;options.client=
_nat, c-&gt;c1.tuntap-&gt;local);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 static_context =3D c;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; diff --git a/src/openvpn/options.c b/src/openvpn/options.c<br>
&gt; index 6b2dfa58..f7161931 100644<br>
&gt; --- a/src/openvpn/options.c<br>
&gt; +++ b/src/openvpn/options.c<br>
&gt; @@ -254,6 +254,7 @@ static const char usage_message[] =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0(Server) Instead of forwarding IPv6 packets send=
\n&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0ICMPv6 host unreachable packets to the client.\n=
&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;--client-nat snat|dnat network netmask alias=
 : on client add 1-to-1<br>
&gt; NAT rule.\n&quot;<br>
&gt; +=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 set the network to &#39;localhost&#39; to use the client ip<b=
r>
&gt; received from the server.\n&quot;<br>
<br>
Please also include an update to the documentation in<br>
doc/man-sections/client-options.rst<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;--push-peer-info : (client only) push client=
 info to server.\n&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;--setenv name value : Set a custom environme=
ntal variable to pass to<br>
&gt; script.\n&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;--setenv FORWARD_COMPATIBLE 1 : Relax config=
 file syntax checking to<br>
&gt; allow\n&quot;<br>
&gt; -- <br>
&gt; 2.39.5<br>
<br>
Regards,<br>
-- <br>
=C2=A0 Frank Lichtenheld<br>
</blockquote></div></div>

--000000000000924c06062ed35d14--

