MIME-Version: 1.0
References: <1600994969-7623-1-git-send-email-selva.nair@...277...>
 <CAGyAFMUivDd97TsJ4mFg1ktC_c1as-bD6n0CPGrTfA+qRDceKA@...278...>
In-Reply-To: <CAGyAFMUivDd97TsJ4mFg1ktC_c1as-bD6n0CPGrTfA+qRDceKA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 25 Sep 2020 10:29:24 -0400
Message-ID: <CAKuzo_gE+eROQ9PY-cFS0Cseh__cVy_gB6zG=5UpQqZuQPDufg@...278...>
Content-Type: multipart/alternative; boundary="000000000000c4c13205b024254b"
Subject: Re: [Openvpn-devel] [PATCH] Set DNS Domain using iservice
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000c4c13205b024254b
Content-Type: text/plain; charset="UTF-8"

Hi

Thanks for the review.

On Fri, Sep 25, 2020 at 5:24 AM Lev Stipakov <lstipakov@...277...> wrote:

> Hi,
>
> > Note: this will set the domain twice if both v4 and v6 DNS
> > servers are defined. It cant hurt, but could be avoided by
> > making the domain setting a separate call from the DNS
> > server setting.
>
> I think we should do that - there is no reason to make expensive call
> twice:
>

Separating the two is easy, but not sure how hard it would be to
avoid calling it twice. With the ipv6-only feature, ipv4 setting is no
longer guaranteed and elsewhere in the code we do some tasks twice: once
for v4 and once for v6 instead of keeping a tab.

I'll take a closer look.


>
> $ time wmic nicconfig where \(InterfaceIndex=38\) call SetDNSDomain
> vpntest.lev
> Executing
> (\\LAPTOP-4L3N7KFS\ROOT\CIMV2:Win32_NetworkAdapterConfiguration.Index=17)->SetDNSDomain()
> Method execution successful.
> Out Parameters:
> instance of __PARAMETERS
> {
>         ReturnValue = 0;
> };
>
> real    0m0,236s
> user    0m0,000s
> sys     0m0,015s

Besides, DOMAIN could also be set by DHCP - there is no point
> to do it via service in this case.
>

If DHCP is in use, do_dns_service() will not get called and the DOMAIN
setting will not be delegated to the service even with this patch.


> > +        strncpy(dns.domains, tt->options.domain, _countof(dns.domains));
> > +       /* truncation of domain name is not checked as it cant happen
> > +        * with 512 bytes room in dns.domains.
> > +        */
>
> Mix of tabs and whitespaces.
>

Will fix.


>
> > +    /* comma separated list must be enclosed in parenthesis */
>
> We don't pass lists yet, is this for future SearchDomains support?
>

Yes, kind of...

I have been playing with this for a while and was motivated because wmic
does support SetDNSSuffixSearchOrder. But works only for the global
setting, not per interface  -- it errors if a where clause is added.

I left the code in there as it may get supported in future. Also it took
awhile for me to figure out what format is needed for lists vs single
objects from the command line.


>
> > +    if (msg->domains[0]) {
> > +        err = SetDNSDomain(wide_name, msg->domains, lists);
> > +    }
>
> msg->domains comes from (unprivileged) client and might
> not be NULL terminated. Shall we do something like
>
>     msg->domains[sizeof(msg->domains) - 1] = '\0';
>
> Same for interface_t::name. Or am I missing something?
>

My mistake. Will fix. Also our own safer strncpynt instead of strncpy in
do_dns_service().

Thanks,

Selva

--000000000000c4c13205b024254b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><div><br></div>Thanks for the review.<div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, S=
ep 25, 2020 at 5:24 AM Lev Stipakov &lt;<a href=3D"mailto:lstipakov@...1354...=
..">lstipakov@...277...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">Hi,<br>
<br>
&gt; Note: this will set the domain twice if both v4 and v6 DNS<br>
&gt; servers are defined. It cant hurt, but could be avoided by<br>
&gt; making the domain setting a separate call from the DNS<br>
&gt; server setting.<br>
<br>
I think we should do that - there is no reason to make expensive call twice=
:<br></blockquote><div><br></div><div>Separating the two is easy, but not s=
ure how hard it would be to avoid=C2=A0calling it twice. With the ipv6-only=
 feature, ipv4 setting is no longer guaranteed and elsewhere in the code we=
 do some tasks twice: once for v4 and once for v6 instead of keeping a tab.=
</div><div><br></div><div>I&#39;ll take a closer look.</div><div>=C2=A0<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
$ time wmic nicconfig where \(InterfaceIndex=3D38\) call SetDNSDomain vpnte=
st.lev<br>
Executing (\\LAPTOP-4L3N7KFS\ROOT\CIMV2:Win32_NetworkAdapterConfiguration.I=
ndex=3D17)-&gt;SetDNSDomain()<br>
Method execution successful.<br>
Out Parameters:<br>
instance of __PARAMETERS<br>
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ReturnValue =3D 0;<br>
};<br>
<br>
real=C2=A0 =C2=A0 0m0,236s<br>
user=C2=A0 =C2=A0 0m0,000s<br>
sys=C2=A0 =C2=A0 =C2=A00m0,015s=C2=A0</blockquote><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
Besides, DOMAIN could also be set by DHCP - there is no point<br>
to do it via service in this case.<br></blockquote><div><br></div><div>If D=
HCP is in use, do_dns_service() will not get called and the DOMAIN setting =
will not be delegated to the service even with this patch.=C2=A0<br></div><=
div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 strncpy(dns.domains, tt-&gt;options.domai=
n, _countof(dns.domains));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* truncation of domain name is not checke=
d as it cant happen<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * with 512 bytes room in dns.domains.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
<br>
Mix of tabs and whitespaces.<br></blockquote><div><br></div><div>Will fix.<=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 /* comma separated list must be enclosed in parenthesis=
 */<br>
<br>
We don&#39;t pass lists yet, is this for future SearchDomains support?<br><=
/blockquote><div><br></div><div>Yes, kind of...</div><div><br></div><div>I =
have been playing with this for a while and was motivated because wmic does=
 support SetDNSSuffixSearchOrder. But works only for the global setting, no=
t per interface=C2=A0 -- it errors if a where clause is added.</div><div><b=
r></div><div>I left the code in there as it may get supported in future. Al=
so it took awhile for me to figure out what format is needed for lists vs s=
ingle objects from the command line.</div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 if (msg-&gt;domains[0]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D SetDNSDomain(wide_name, msg-&gt;d=
omains, lists);<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
msg-&gt;domains comes from (unprivileged) client and might<br>
not be NULL terminated. Shall we do something like<br>
<br>
=C2=A0 =C2=A0 msg-&gt;domains[sizeof(msg-&gt;domains) - 1] =3D &#39;\0&#39;=
;<br>
<br>
Same for interface_t::name. Or am I missing something?<br></blockquote><div=
><br></div><div>My mistake. Will fix. Also our own safer strncpynt instead =
of strncpy in do_dns_service().</div><div><br></div><div>Thanks,</div><div>=
<br></div><div>Selva</div></div></div></div>

--000000000000c4c13205b024254b--

