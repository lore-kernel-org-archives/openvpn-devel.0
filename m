MIME-Version: 1.0
References: <1552943809-6367-1-git-send-email-selva.nair@...277...>
 <5a54b7c9-d466-c8c2-e468-42c16c88d1dd@...277...>
 <2bf767b9-8459-c0bf-3914-9afaee3093f8@...2181...>
 <CAKuzo_hbxCOTP_y1_4-i-=8WseuxbnjCEpTkgO5tF=oTcO+W_g@...278...>
 <6cfe67e9-4dff-bd34-129d-cb05a3321839@...277...>
In-Reply-To: <6cfe67e9-4dff-bd34-129d-cb05a3321839@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 20 Mar 2019 13:25:06 -0400
Message-ID: <CAKuzo_gyzh3qzG3skvv54jUvcgzSOx5LMf0B65cpEXEYgtjnVQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000001633d9058489e8ec"
Subject: Re: [Openvpn-devel] [PATCH] Improve the documentation for
 --dhcp-option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: tincanteksup <tincanteksup@...277...>
Cc: Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000001633d9058489e8ec
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 20, 2019 at 10:52 AM tincanteksup <tincanteksup@...277...>
wrote:
>
>
>
> On 20/03/2019 13:25, Selva Nair wrote:
> > Hi,
> >
> > On Wed, Mar 20, 2019 at 4:02 AM Antonio Quartulli <a@...2181...> wrote:
> >>
> >> Hi,
> >>
> >> On 18/03/2019 22:30, tincanteksup wrote:
> >>> Hi,
> >>>
> >>> this situation has been hanging around for so long is this brief note
> >>> really enough? Considering that the manual has numerous other URLs why
> >>> not include this URL here:
> >>> https://community.openvpn.net/openvpn/wiki/Pushing-DNS-to-clients
> >>>
> >>> We already have this:
> >>> https://community.openvpn.net/openvpn/wiki/SWEET32
> >>>
> >>
> >> the problem with URLs is that they become obsolete and we need to
> >> re-patch the manual in order to update them (or ensure the URL always
> >> work/redirect to something).
> >
> >
> > I have the same opinion about URLs. On top of that the wiki
> > description is inadequate and inaccurate. But that's a different
> > topic.
>
> Inadequate:
> Compared to NOTHING, the page is at least a step toward documentation.
>
> Inaccurate:
> Please expand ..

The wiki states that on Windows using version 2.4, OpenVPN-GUI+interactive
service required for processing this option. Not so.
Just as in 2.3, it works if run as admin. In fact, several setups run
OpenVPN on boot using OpenVPNService, and --dhcp-option does work for them.
With 2.4, it also works as limited user if started using the interactive
service (for example, using OpenVPN-GUI).

In both 2.3 and 2.4, the critical piece is not overriding --ipwin32 method
(adaptive or dynamic is required and the latter is the
default).

Selva


On Wed, Mar 20, 2019 at 10:52 AM tincanteksup <tincanteksup@...277...>
wrote:

>
>
> On 20/03/2019 13:25, Selva Nair wrote:
> > Hi,
> >
> > On Wed, Mar 20, 2019 at 4:02 AM Antonio Quartulli <a@...2181...> wrote:
> >>
> >> Hi,
> >>
> >> On 18/03/2019 22:30, tincanteksup wrote:
> >>> Hi,
> >>>
> >>> this situation has been hanging around for so long is this brief note
> >>> really enough? Considering that the manual has numerous other URLs why
> >>> not include this URL here:
> >>> https://community.openvpn.net/openvpn/wiki/Pushing-DNS-to-clients
> >>>
> >>> We already have this:
> >>> https://community.openvpn.net/openvpn/wiki/SWEET32
> >>>
> >>
> >> the problem with URLs is that they become obsolete and we need to
> >> re-patch the manual in order to update them (or ensure the URL always
> >> work/redirect to something).
> >
> >
> > I have the same opinion about URLs. On top of that the wiki
> > description is inadequate and inaccurate. But that's a different
> > topic.
>
> Inadequate:
> Compared to NOTHING, the page is at least a step toward documentation.
>
> Inaccurate:
> Please expand ..
>
>

--0000000000001633d9058489e8ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Wed, Mar 20, 2019 at 10:52 AM tincanteksup &lt;<a href=
=3D"mailto:tincanteksup@...277...">tincanteksup@...277...</a>&gt; wrote:<br=
>&gt;<br>&gt;<br>&gt;<br>&gt; On 20/03/2019 13:25, Selva Nair wrote:<br>&gt=
; &gt; Hi,<br>&gt; &gt;<br>&gt; &gt; On Wed, Mar 20, 2019 at 4:02 AM Antoni=
o Quartulli &lt;a@...2181...&gt; wrote:<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; H=
i,<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; On 18/03/2019 22:30, tincanteksup wrot=
e:<br>&gt; &gt;&gt;&gt; Hi,<br>&gt; &gt;&gt;&gt;<br>&gt; &gt;&gt;&gt; this =
situation has been hanging around for so long is this brief note<br>&gt; &g=
t;&gt;&gt; really enough? Considering that the manual has numerous other UR=
Ls why<br>&gt; &gt;&gt;&gt; not include this URL here:<br>&gt; &gt;&gt;&gt;=
 <a href=3D"https://community.openvpn.net/openvpn/wiki/Pushing-DNS-to-clien=
ts">https://community.openvpn.net/openvpn/wiki/Pushing-DNS-to-clients</a><b=
r>&gt; &gt;&gt;&gt;<br>&gt; &gt;&gt;&gt; We already have this:<br>&gt; &gt;=
&gt;&gt; <a href=3D"https://community.openvpn.net/openvpn/wiki/SWEET32">htt=
ps://community.openvpn.net/openvpn/wiki/SWEET32</a><br>&gt; &gt;&gt;&gt;<br=
>&gt; &gt;&gt;<br>&gt; &gt;&gt; the problem with URLs is that they become o=
bsolete and we need to<br>&gt; &gt;&gt; re-patch the manual in order to upd=
ate them (or ensure the URL always<br>&gt; &gt;&gt; work/redirect to someth=
ing).<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; I have the same opinion about =
URLs. On top of that the wiki<br>&gt; &gt; description is inadequate and in=
accurate. But that&#39;s a different<br>&gt; &gt; topic.<br>&gt;<br>&gt; In=
adequate:<br>&gt; Compared to NOTHING, the page is at least a step toward d=
ocumentation.<br>&gt;<br>&gt; Inaccurate:<br>&gt; Please expand ..<br><br>T=
he wiki states that on Windows using version 2.4, OpenVPN-GUI+interactive s=
ervice required for processing this option. Not so.<br>Just as in 2.3, it w=
orks if run as admin. In fact, several setups run OpenVPN on boot using Ope=
nVPNService, and --dhcp-option does work for them. With 2.4, it also works =
as limited user if started using the interactive service (for example, usin=
g OpenVPN-GUI).<br><br>In both 2.3 and 2.4, the critical piece is not overr=
iding --ipwin32 method (adaptive or dynamic is required and the latter is t=
he<br>default).<br><br>Selva</div><br><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 20, 2019 at 10:52 AM tincanteks=
up &lt;<a href=3D"mailto:tincanteksup@...277...">tincanteksup@...277...</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 20/03/2019 13:25, Selva Nair wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; On Wed, Mar 20, 2019 at 4:02 AM Antonio Quartulli &lt;a@...2181...&gt;=
 wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hi,<br>
&gt;&gt;<br>
&gt;&gt; On 18/03/2019 22:30, tincanteksup wrote:<br>
&gt;&gt;&gt; Hi,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; this situation has been hanging around for so long is this bri=
ef note<br>
&gt;&gt;&gt; really enough? Considering that the manual has numerous other =
URLs why<br>
&gt;&gt;&gt; not include this URL here:<br>
&gt;&gt;&gt; <a href=3D"https://community.openvpn.net/openvpn/wiki/Pushing-=
DNS-to-clients" rel=3D"noreferrer" target=3D"_blank">https://community.open=
vpn.net/openvpn/wiki/Pushing-DNS-to-clients</a><br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; We already have this:<br>
&gt;&gt;&gt; <a href=3D"https://community.openvpn.net/openvpn/wiki/SWEET32"=
 rel=3D"noreferrer" target=3D"_blank">https://community.openvpn.net/openvpn=
/wiki/SWEET32</a><br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; the problem with URLs is that they become obsolete and we need to<=
br>
&gt;&gt; re-patch the manual in order to update them (or ensure the URL alw=
ays<br>
&gt;&gt; work/redirect to something).<br>
&gt; <br>
&gt; <br>
&gt; I have the same opinion about URLs. On top of that the wiki<br>
&gt; description is inadequate and inaccurate. But that&#39;s a different<b=
r>
&gt; topic.<br>
<br>
Inadequate:<br>
Compared to NOTHING, the page is at least a step toward documentation.<br>
<br>
Inaccurate:<br>
Please expand ..<br>
<br>
</blockquote></div>

--0000000000001633d9058489e8ec--

