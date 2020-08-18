MIME-Version: 1.0
References: <CAAWBBYPw=TZg1wftWZL5ABKVWkp7=6hpdaumLN2D24Cgr-E4pQ@...278...>
 <20200818062335.GV75094@...1296...>
 <20200818063212.GW75094@...1296...>
 <CAKuzo_jEGvTnkbsgJVm5beW5SapWoy_xLk_LA+-N59oa6SbbkA@...278...>
 <81A6F618-2F74-417F-A476-BF290CCFF143@...277...>
 <20200818181820.GZ75094@...1296...>
 <2F7C4631-7E3C-47FB-BC8E-E4271F38AD9F@...277...>
 <20200818192104.GB75094@...1296...>
In-Reply-To: <20200818192104.GB75094@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 18 Aug 2020 15:29:19 -0400
Message-ID: <CAKuzo_h2hLeQodHsJ7uzetq_XeGPJiu3i-o2tXuL29HbJcG6bA@...278...>
Content-Type: multipart/alternative; boundary="00000000000076dd3205ad2be882"
Subject: Re: [Openvpn-devel] 2.5-beta-1 Wintun requires SYSTEM privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Marvin Adeff <volleynbike@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000076dd3205ad2be882
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, Aug 18, 2020 at 3:21 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Tue, Aug 18, 2020 at 12:09:11PM -0700, Marvin Adeff wrote:
> > I???m sorry for the confusing response.
> >
> > Our systems do M2M monitoring and need to run OpenVPN even without a
> user logged in.  In previous versions we created a script run as a service
> (as SYSTEM) that started OpenVPN (using certificates for authentication).
> It also monitored tunnel status and restarted OpenVPN if necessary.  We
> never used the GUI.
> >
> > So we are watching how v2.5 develops to know how we will need to
> implement the new version.  We are also very interested in seeing what
> speed improvements wintun will offer.
> >
> > I hope that is clearer.
>
> Thanks for the clarification.
>
> In that regard, 2.5 will bring no surprises - if you already have SYSTEM
> privileges, and do not want/need a GUI, you can "just run OpenVPN" as
> you did before.
>
> You can do this with your script, or with the "openvpnsrv2" service,
> which basically runs openvpn on all config it finds in its config
> directory at system startup.  Not sure if these instances get restarted
> at exit (last time I looked at this was before 2.4.0 release...).
>
> If you already have SYSTEM, accessing wintun from openvpn directly will
> also work and should bring quite a bit of speed improvement.
>

I was wrong to assume that this just works. Looking at it again, the current
implementation of wintun support does not seem to cover this. Meaning the
only working approach is to use the interactive service.

If developing a new service, I would suggest to have
the service talk to the interactive service for starting openvpn. It will
return you the PID of openvpn.exe which can be monitored. An advantage
of this approach is that your service and openvpn.exe can run with limited
privileges like LOCAL SERVICE or a dedicated openvpn service user.
That said, I don't know anyone who has tested such a usage though it
should work in theory.

Selva

--00000000000076dd3205ad2be882
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Tue, Aug 18, 2020 at 3:21 PM Gert Doering &lt;<=
a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Tue, Aug 18, 2020 at 12:09:11PM -0700, Marvin Adeff wrote:<br>
&gt; I???m sorry for the confusing response.=C2=A0 <br>
&gt; <br>
&gt; Our systems do M2M monitoring and need to run OpenVPN even without a u=
ser logged in.=C2=A0 In previous versions we created a script run as a serv=
ice (as SYSTEM) that started OpenVPN (using certificates for authentication=
).=C2=A0 It also monitored tunnel status and restarted OpenVPN if necessary=
.=C2=A0 We never used the GUI. <br>
&gt; <br>
&gt; So we are watching how v2.5 develops to know how we will need to imple=
ment the new version.=C2=A0 We are also very interested in seeing what spee=
d improvements wintun will offer. <br>
&gt; <br>
&gt; I hope that is clearer. <br>
<br>
Thanks for the clarification.<br>
<br>
In that regard, 2.5 will bring no surprises - if you already have SYSTEM<br>
privileges, and do not want/need a GUI, you can &quot;just run OpenVPN&quot=
; as<br>
you did before.<br>
<br>
You can do this with your script, or with the &quot;openvpnsrv2&quot; servi=
ce, <br>
which basically runs openvpn on all config it finds in its config<br>
directory at system startup.=C2=A0 Not sure if these instances get restarte=
d <br>
at exit (last time I looked at this was before 2.4.0 release...).<br>
<br>
If you already have SYSTEM, accessing wintun from openvpn directly will <br>
also work and should bring quite a bit of speed improvement.=C2=A0 <br></bl=
ockquote><div><br></div><div>I was wrong to assume that this just works. Lo=
oking at it again, the current</div><div>implementation of wintun support d=
oes not seem to cover this. Meaning the</div><div>only working approach is =
to use the interactive service.</div><div><br></div><div>If developing a ne=
w service, I would suggest to have</div><div>the service talk to the intera=
ctive service for starting openvpn. It will</div><div>return you the PID of=
 openvpn.exe which can be monitored. An advantage</div><div>of this approac=
h is that your service and openvpn.exe can run with limited</div><div>privi=
leges like LOCAL SERVICE or a dedicated openvpn service user.</div><div>Tha=
t said, I don&#39;t=C2=A0know anyone who has tested such a usage though it<=
/div><div>should work in theory.</div><div><br></div><div>Selva</div></div>=
</div>

--00000000000076dd3205ad2be882--

