MIME-Version: 1.0
In-Reply-To: <3e7224ae-474c-1cfd-7bcf-3b9eeb14cb7a@...1227...>
References: <CAAWBBYOc5H=0X7b=i_gizvTZUDv2RwxQUEOY85P6c3z-y_U8og@...278...>
	<3e7224ae-474c-1cfd-7bcf-3b9eeb14cb7a@...1227...>
From: Rafael Gava <gava100@...277...>
Date: Wed, 27 Jul 2016 08:53:32 -0300
Message-ID: <CAAWBBYO9jbqR8rv_rTEAhEUsG90Okffor1j3o7XuPXDdxw9Hug@...278...>
Content-Type: multipart/alternative; boundary=e89a8fb1ed36b15b5205389caa16
Subject: Re: [Openvpn-devel] [PATCH] Added client-ip option to NAT
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--e89a8fb1ed36b15b5205389caa16
Content-Type: text/plain; charset=UTF-8

Hi Arne,

I left both options available, at least for now.  Either 'client-ip', or
'localhost' as an undocumented alias.

This patch to 'client-nat' is necessary to allow it to work properly on a
Windows client (not necessary on Linux) of client/server configuration when
server issues OVPN DHCP addresses but the client has a static IP.
Otherwise the traffic from the Windows client device back through the
tunnel uses the DHCP address as source instead of the static IP.  And this
breaks the system.  We have had to use our own build of this for many years
now.  We have several thousand clients running in this way on our system.

Your request not to use 'localhost' is ok.  So I changed 'client-ip'. But
since we have so many clients already configured with the 'localhost'
keyword, we would like to gradually make the transition.  We would like to
have 'localhost' be an undocumented alias to 'client-ip', at least until we
have made the transition.

Our hope is that we can do what is necessary to make this option available
for others as well and merge it into the main build.  When originally
searching for a solution the 'client-nat' issue, we noticed that we were
not the only ones running into it.

BR

Rafael


On Mon, Jul 25, 2016 at 5:20 AM, Arne Schwabe <arne@...1227...> wrote:

>
>
> Am 05.07.16 um 15:13 schrieb Rafael Gava:
> > Hi Arne, sorry for replying so late.
> >
> > Below is the NAT client-ip patch fixing the messed up whitespaces.
> > The only difference from the previous patch, besides the whitespaces,
> > is that I'm considering both strings 'client-ip' and 'localhost' as
> > valid options.
> >
> > Please, whatever problem let me know.
> Wasn't the general consensus on the mailing list that making localhost
> an alias for client-ip is confusing? I wonder why you introduced it again.
>
> Arne
>

--e89a8fb1ed36b15b5205389caa16
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Arne,<br></div><div><div><br></div><div>I left bot=
h options available, at least for now.=C2=A0 Either &#39;client-ip&#39;, or=
 &#39;localhost&#39; as an undocumented alias. =C2=A0</div><div><br></div><=
div>This patch to &#39;client-nat&#39; is necessary to allow it to work pro=
perly on a Windows client (not necessary on Linux) of client/server configu=
ration when server issues OVPN DHCP addresses but the client has a static I=
P.=C2=A0 Otherwise the traffic from the Windows client device back through =
the tunnel uses the DHCP address as source instead of the static IP.=C2=A0 =
And this breaks the system.=C2=A0 We have had to use our own build of this =
for many years now.=C2=A0 We have several thousand clients running in this =
way on our system.</div><div><br></div><div>Your request not to use &#39;lo=
calhost&#39; is ok.=C2=A0 So I changed &#39;client-ip&#39;. But since we ha=
ve so many clients already configured with the &#39;localhost&#39; keyword,=
 we would like to gradually make the transition.=C2=A0 We would like to hav=
e &#39;localhost&#39; be an undocumented alias to &#39;client-ip&#39;, at l=
east until we have made the transition.</div><div><br></div><div>Our hope i=
s that we can do what is necessary to make this option available for others=
 as well and merge it into the main build.=C2=A0 When originally searching =
for a solution the &#39;client-nat&#39; issue, we noticed that we were not =
the only ones running into it.</div></div><div><br></div><div>BR</div><div>=
<br></div><div>Rafael</div><div><br></div></div><div class=3D"gmail_extra">=
<br><div class=3D"gmail_quote">On Mon, Jul 25, 2016 at 5:20 AM, Arne Schwab=
e <span dir=3D"ltr">&lt;<a href=3D"mailto:arne@...1227..." target=3D"_blank=
">arne@...1227...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><=
br>
<br>
Am 05.07.16 um 15:13 schrieb Rafael Gava:<br>
<span class=3D"">&gt; Hi Arne, sorry for replying so late.<br>
&gt;<br>
&gt; Below is the NAT client-ip patch fixing the messed up whitespaces.<br>
&gt; The only difference from the previous patch, besides the whitespaces,<=
br>
&gt; is that I&#39;m considering both strings &#39;client-ip&#39; and &#39;=
localhost&#39; as<br>
&gt; valid options.<br>
&gt;<br>
&gt; Please, whatever problem let me know.<br>
</span>Wasn&#39;t the general consensus on the mailing list that making loc=
alhost<br>
an alias for client-ip is confusing? I wonder why you introduced it again.<=
br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Arne<br>
</font></span></blockquote></div><br></div>

--e89a8fb1ed36b15b5205389caa16--

