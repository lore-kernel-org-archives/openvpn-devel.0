MIME-Version: 1.0
References: <CALVjyqoi3ZkOn2p+2i=xBS_pNHKbym0eReWCWHAg9+-ULwtEgQ@...278...>
 <CALVjyqo5NNddn3E+cV_eAySc1VzYeLXPvvKUykOusaZF9LhjxQ@...278...>
 <20200515204626.GO1431@...1296...>
In-Reply-To: <20200515204626.GO1431@...1296...>
From: Shreyas Heranjal <mailshreyas@...277...>
Date: Mon, 18 May 2020 08:36:53 -0700
Message-ID: <CALVjyqrmhf8UVc0rwf+cfUC76s3qs6oge+=n4s37XJ8vxZQHNA@...278...>
Content-Type: multipart/alternative; boundary="000000000000cc8c2f05a5edf0b7"
Subject: Re: [Openvpn-devel] deferred client-connect -
 https://patchwork.openvpn.net/patch/607/
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

--000000000000cc8c2f05a5edf0b7
Content-Type: text/plain; charset="UTF-8"

Hi Gert,

Thanks for the response.
Also, I was wondering if there was any sample code for using
the OPENVPN_PLUGIN_CLIENT_CONNECT_V2 plugin to influence the ifconfig-push
on the clients. I want to assign client IP addresses to the connecting
clients based on some logic in the plugin.

I went through the code and looks like the config needs to be returned as
part of the plugin_return struct. Is that correct? Is this the way to do it?

Thanks,
S

On Fri, May 15, 2020 at 1:46 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Fri, May 15, 2020 at 12:40:08PM -0700, Shreyas Heranjal wrote:
> > > I want to use client-connect plugin to assign IP addresses to the
> clients,
> > > and I want to do it asynchronously through my IPAM service. I was going
> > > through the openvpn-devel forum and found this patch.
> > > https://patchwork.openvpn.net/patch/607/
> > >
> > > Is this patch safe to use? Any reason why this was not included in the
> > > latest version of Openvpn?
>
> It's being worked on.  The patchset is fairly large and has not been
> reviewed fully (and initial review turned up the wish for some
> restructuring).
>
> gert
>
>
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never
> doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh
> Mistress
>
> Gert Doering - Munich, Germany
> gert@...1296...
>

--000000000000cc8c2f05a5edf0b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif;font-size:small">Hi Gert,</div><div class=3D"gmail_default" style=
=3D"font-family:tahoma,sans-serif;font-size:small"><br></div><div class=3D"=
gmail_default" style=3D"font-family:tahoma,sans-serif;font-size:small">Than=
ks for the response.</div><div class=3D"gmail_default" style=3D"font-family=
:tahoma,sans-serif;font-size:small">Also, I was wondering if there was any =
sample code for using the=C2=A0OPENVPN_PLUGIN_CLIENT_CONNECT_V2 plugin to i=
nfluence the ifconfig-push on the clients. I want to assign client IP addre=
sses to the connecting clients based on some logic in the plugin.</div><div=
 class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif;font-size:s=
mall"><br></div><div class=3D"gmail_default" style=3D"font-family:tahoma,sa=
ns-serif;font-size:small">I went through the code and looks like the config=
 needs to be returned as part of the plugin_return struct. Is that correct?=
 Is this the way to do it?</div><div class=3D"gmail_default" style=3D"font-=
family:tahoma,sans-serif;font-size:small"><br></div><div class=3D"gmail_def=
ault" style=3D"font-family:tahoma,sans-serif;font-size:small">Thanks,</div>=
<div class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif;font-si=
ze:small">S=C2=A0=C2=A0</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, May 15, 2020 at 1:46 PM Gert Doering =
&lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Fri, May 15, 2020 at 12:40:08PM -0700, Shreyas Heranjal wrote:<br>
&gt; &gt; I want to use client-connect plugin to assign IP addresses to the=
 clients,<br>
&gt; &gt; and I want to do it asynchronously through my IPAM service. I was=
 going<br>
&gt; &gt; through the openvpn-devel forum and found this patch.<br>
&gt; &gt; <a href=3D"https://patchwork.openvpn.net/patch/607/" rel=3D"noref=
errer" target=3D"_blank">https://patchwork.openvpn.net/patch/607/</a><br>
&gt; &gt;<br>
&gt; &gt; Is this patch safe to use? Any reason why this was not included i=
n the<br>
&gt; &gt; latest version of Openvpn?<br>
<br>
It&#39;s being worked on.=C2=A0 The patchset is fairly large and has not be=
en<br>
reviewed fully (and initial review turned up the wish for some<br>
restructuring).<br>
<br>
gert<br>
<br>
<br>
-- <br>
&quot;If was one thing all people took for granted, was conviction that if =
you <br>
=C2=A0feed honest figures into a computer, honest figures come out. Never d=
oubted <br>
=C2=A0it myself till I met a computer with a sense of humor.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Robert A. Heinlein, The Moon is a Harsh Mist=
ress<br>
<br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296..." target=3D"_blank">gert@...1296...</a><br>
</blockquote></div>

--000000000000cc8c2f05a5edf0b7--

