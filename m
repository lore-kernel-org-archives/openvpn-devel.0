MIME-Version: 1.0
In-Reply-To: <20161201080741.GE78624@...1296...>
References: <1480466372-2396-1-git-send-email-selva.nair@...277...>
	<201611301858.uAUIwRPD071804@...2054...>
	<bcec447a-d77b-996e-e1ed-b2daf9a88696@...1227...>
	<20161201080741.GE78624@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 1 Dec 2016 11:19:56 -0500
Message-ID: <CAKuzo_jKubExZUh0C-Ta5tOgqdrJ8Hhwu06JHuvtFmyPk3O_VA@...278...>
Content-Type: multipart/alternative; boundary=001a113bc88069929905429b324c
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Force 'def1' method when
 --redirect-gateway is done through service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113bc88069929905429b324c
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu, Dec 1, 2016 at 3:07 AM, Gert Doering <gert@...1296...> wrote:

> On Wed, Nov 30, 2016 at 11:06:02PM +0100, Arne Schwabe wrote:
> > Slight correction. We actually set 0.0.0.0/0 on Android but Android
> > *always* translates that into a 0.0.0.0/1 and a 128.0.0.0/1 rule.
> >
> > We could do the same and do the translation in the interactive service
> > instead of OpenVPN itself.
>
> We could, but that wouldn't solve the issue of OpenVPN trying to
> remove the existing default route (which we would have to special-case-and-
> ignore) and reinstall it later on (which must not be translated to
> 2x /1, but ignored as well).
>
> The service code doesn't know whether a route is "for the VPN API" or
> "for anything else" (which openvpn on "non VPN API" platforms always
> could do) so this would be a much more intrusive change...


I think it could work like this:

In DeleteRoute()
   if dest == 0/0 delete routes to 0/1 and 128/1
   (ignore any "route does not exist" error)

In AddRoute() <-- this function doesn't currently exist
   if dest == 0/0 add routes to 0/1 and 128/1
   (this will add two extra routes when default gateway is restored, but
cant hurt)

In this scenario, route to 0/0 is never touched by the service.

When we ask the service to:
   delete default route to gw --> nothing happens unless there were routes
to 0/1 and 128/1
   add default route through tun  --> adds routes to 0/1 and 128/1 via tun
   delete default route through tun --> OK
   add default route to gw --> adds routes to 0/1 and 128/1 via gw

When process exits/crashes, the service thread exits and the extra routes
to 0/1 and 128/1 get removed. If service crashes those routes will remain,
not ideal, but safe, I suppose.

Did I overlook something?

Not that I like it. Wonder how android does it.

Selva

--001a113bc88069929905429b324c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Thu, Dec 1, 2016 at 3:07 AM, Gert Do=
ering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_b=
lank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-c=
olor:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><span class=
=3D"m_-4208075415750049702gmail-">On Wed, Nov 30, 2016 at 11:06:02PM +0100,=
 Arne Schwabe wrote:<br>
&gt; Slight correction. We actually set <a href=3D"http://0.0.0.0/0" rel=3D=
"noreferrer" target=3D"_blank">0.0.0.0/0</a> on Android but Android<br>
&gt; *always* translates that into a <a href=3D"http://0.0.0.0/1" rel=3D"no=
referrer" target=3D"_blank">0.0.0.0/1</a> and a <a href=3D"http://128.0.0.0=
/1" rel=3D"noreferrer" target=3D"_blank">128.0.0.0/1</a> rule.<br>
&gt;<br>
&gt; We could do the same and do the translation in the interactive service=
<br>
&gt; instead of OpenVPN itself.<br>
<br>
</span>We could, but that wouldn&#39;t solve the issue of OpenVPN trying to=
<br>
remove the existing default route (which we would have to special-case-and-=
<br>
ignore) and reinstall it later on (which must not be translated to<br>
2x /1, but ignored as well).<br>
<br>
The service code doesn&#39;t know whether a route is &quot;for the VPN API&=
quot; or<br>
&quot;for anything else&quot; (which openvpn on &quot;non VPN API&quot; pla=
tforms always<br>
could do) so this would be a much more intrusive change...</blockquote></di=
v><br>I think it could work like this:</div><div class=3D"gmail_extra"><br>=
</div><div class=3D"gmail_extra">In DeleteRoute()<br></div><div class=3D"gm=
ail_extra">=C2=A0 =C2=A0if dest =3D=3D 0/0 delete routes to 0/1 and 128/1</=
div><div class=3D"gmail_extra">=C2=A0 =C2=A0(ignore any &quot;route does no=
t exist&quot; error)</div><div class=3D"gmail_extra"><br></div><div class=
=3D"gmail_extra">In AddRoute() &lt;-- this function doesn&#39;t currently e=
xist</div><div class=3D"gmail_extra">=C2=A0 =C2=A0if dest =3D=3D 0/0 add ro=
utes to 0/1 and 128/1</div><div class=3D"gmail_extra">=C2=A0 =C2=A0(this wi=
ll add two extra routes when default gateway is restored, but cant hurt)</d=
iv><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">In this =
scenario, route to 0/0 is never touched by the service.</div><div class=3D"=
gmail_extra"><br></div><div class=3D"gmail_extra">When we ask the service t=
o:=C2=A0</div><div class=3D"gmail_extra">=C2=A0 =C2=A0delete default route =
to gw --&gt; nothing happens unless there were routes to 0/1 and 128/1</div=
><div class=3D"gmail_extra">=C2=A0 =C2=A0add default route through tun =C2=
=A0--&gt; adds routes to 0/1 and 128/1 via tun</div><div class=3D"gmail_ext=
ra">=C2=A0 =C2=A0delete default route through tun --&gt; OK</div><div class=
=3D"gmail_extra">=C2=A0 =C2=A0add default route to gw --&gt; adds routes to=
 0/1 and 128/1 via gw</div><div class=3D"gmail_extra">=C2=A0 =C2=A0</div><d=
iv class=3D"gmail_extra">When process exits/crashes, the service thread exi=
ts and the extra routes to 0/1 and 128/1 get removed. If service crashes th=
ose routes will remain, not ideal, but safe, I suppose.</div><div class=3D"=
gmail_extra"><br></div><div class=3D"gmail_extra">Did I overlook something?=
</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Not t=
hat I like it. Wonder how android does it.<br></div><div class=3D"gmail_ext=
ra"><br></div><div class=3D"gmail_extra">Selva</div></div>

--001a113bc88069929905429b324c--

