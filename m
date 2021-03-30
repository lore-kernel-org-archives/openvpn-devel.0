MIME-Version: 1.0
References: <CAAUX2SXSu=izbxjAiUNfuezsrv6NbQrrL7R7pQh8P4uumzQemw@...278...>
 <73707b45-c5fa-261e-2a7a-e7a03794c3ba@...1227...>
 <14d7cf12-9863-6d1d-1134-0f80dc498d2d@...2181...>
In-Reply-To: <14d7cf12-9863-6d1d-1134-0f80dc498d2d@...2181...>
From: Tony He <huangya90@...277...>
Date: Tue, 30 Mar 2021 22:57:52 +0800
Message-ID: <CAAUX2SX3zaRbFuP2n-GCj74YDtrkVVnA5PrtXzR=uCYCwAWK=A@...278...>
Content-Type: multipart/alternative; boundary="000000000000b5a1f905bec23988"
Subject: Re: [Openvpn-devel] [ovpn-dco] try to port to kernel 4.14.76,
 but can not join AF_NETLINK group
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000b5a1f905bec23988
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Antonio,

The issue is I used Arne's working dco branch, it fails to register
AF_NETLINK group.
Old code like:
  int ret =3D nl_socket_add_memberships(dco->nl_sock, dco->ovpn_dco_mcast_i=
d,
                                        RTNLGRP_LINK, RTNLGRP_NOTIFY,
RTNLGRP_NONE);

I see Arne just pushed new code:
int ret =3D nl_socket_add_membership(dco->nl_sock, dco->ovpn_dco_mcast_id);

Had a quick test, it's fine. I'm not sure why the old code in my X86-64 PC
is OK while it
doesn't work in this MIPS64 router. Maybe it's not related with the kernel
version.

Tony

Antonio Quartulli <a@...2181...> =E4=BA=8E2021=E5=B9=B43=E6=9C=8830=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:37=E5=86=99=E9=81=93=EF=BC=9A

> Hi Tony,
>
> On 30/03/2021 12:23, Arne Schwabe wrote:
> > Am 30.03.21 um 09:36 schrieb Tony He:
> >> Hi Antonio, Arne,
> >>
> >> Sorry to bother you. I have a router based on Linux kernel
> >> 4.14.76(4.14.x is LTS version). Because of some reasons,
> >> it's hard to upgrade to v5.x to play ovpn-dco. So I am porting ovpn-dco
> >> to 4.14.76 kernel. After some hacking, it's almost done.
> >> Now it seems that  only one issue needs to be resolved. The issue is
> >> openvpn 2.6 dco fails to join AF_NETLINK group.
> >>
> >
> > Note that we currently do not intent to support or do active development
> > on such old kernels.
> >
>
> Even if not currently on the roadmap, please let us know if you
> encounter particular issues with this kernel. I'd be interested in
> hearing about those, if any.
>
> Regards,
>
>
>
> --
> Antonio Quartulli
> OpenVPN Inc.
>
> --
> Antonio Quartulli
>

--000000000000b5a1f905bec23988
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Antonio,</div><div><br></div><div>The issue is I u=
sed Arne&#39;s working dco branch, it fails to register AF_NETLINK group.</=
div><div>Old code like:</div><div>=C2=A0 int ret =3D nl_socket_add_membersh=
ips(dco-&gt;nl_sock, dco-&gt;ovpn_dco_mcast_id,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RTNLGRP_LINK, RTNLGRP_NOTIFY, RTN=
LGRP_NONE);</div><div><br></div><div>I see Arne just pushed new code:</div>=
<div>int ret =3D nl_socket_add_membership(dco-&gt;nl_sock, dco-&gt;ovpn_dco=
_mcast_id);</div><div><br></div><div>Had a quick test, it&#39;s fine. I&#39=
;m not sure why the old code in my X86-64 PC is OK while it</div><div>doesn=
&#39;t work in this MIPS64 router. Maybe it&#39;s not related with the kern=
el version.</div><div><br></div><div>Tony<br></div><div><br></div><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Antonio Quartulli &=
lt;a@...2181...&gt; =E4=BA=8E2021=E5=B9=B43=E6=9C=8830=E6=97=A5=E5=91=A8=E4=
=BA=8C =E4=B8=8B=E5=8D=8810:37=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">Hi Tony,<br>
<br>
On 30/03/2021 12:23, Arne Schwabe wrote:<br>
&gt; Am 30.03.21 um 09:36 schrieb Tony He:<br>
&gt;&gt; Hi Antonio, Arne,<br>
&gt;&gt;<br>
&gt;&gt; Sorry to bother you. I have a router based on Linux kernel<br>
&gt;&gt; 4.14.76(4.14.x is LTS version). Because of some reasons,=C2=A0<br>
&gt;&gt; it&#39;s hard to upgrade to v5.x to play ovpn-dco. So I am porting=
 ovpn-dco<br>
&gt;&gt; to 4.14.76 kernel. After some hacking, it&#39;s almost done.<br>
&gt;&gt; Now it seems that=C2=A0 only one issue needs to be resolved. The i=
ssue is<br>
&gt;&gt; openvpn 2.6 dco fails to join AF_NETLINK group.<br>
&gt;&gt;<br>
&gt; <br>
&gt; Note that we currently do not intent to support or do active developme=
nt<br>
&gt; on such old kernels.<br>
&gt; <br>
<br>
Even if not currently on the roadmap, please let us know if you<br>
encounter particular issues with this kernel. I&#39;d be interested in<br>
hearing about those, if any.<br>
<br>
Regards,<br>
<br>
<br>
<br>
-- <br>
Antonio Quartulli<br>
OpenVPN Inc.<br>
<br>
-- <br>
Antonio Quartulli<br>
</blockquote></div></div>

--000000000000b5a1f905bec23988--

