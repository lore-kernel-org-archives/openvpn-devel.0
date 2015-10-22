MIME-Version: 1.0
In-Reply-To: <SN1PR08MB1391BB977BF308697478D928B9270@...2065...>
References: <56211F0D.2010806@...515...> <2421664.qQJpUDo69u@...1526...>
	<56261F0D.9020208@...515...> <1921973.yRGlOPzy2x@...2001...>
	<20151022075000.GD22054@...1296...>
	<SN1PR08MB1391D82901BB0F9F4C8CB5E9B9270@...2065...>
	<20151022173701.GP22054@...1296...>
	<SN1PR08MB13915E4AEE4D1046CE7953AFB9270@...2065...>
	<20151022182439.GS22054@...1296...>
	<SN1PR08MB13916305A3CB7B167CC0B1A7B9270@...2065...>
	<56293AC9.7010702@...1147...>
	<SN1PR08MB1391BB977BF308697478D928B9270@...2065...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 22 Oct 2015 16:52:20 -0400
Message-ID: <CAKuzo_iV6NQJSGWORxLTY4+YLLE8u+ccAHTfVrpJtX0=TVZnWQ@...278...>
Content-Type: multipart/alternative; boundary=089e013c6aba015de00522b7ad40
Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Morris, Russell" <rmorris@...1315...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--089e013c6aba015de00522b7ad40
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 22, 2015 at 3:58 PM, Morris, Russell <rmorris@...1315...>
wrote:

> Hi,
>
> Just checked - yep, 9.0.0.21. It seems to be from 2014 though?
>
> And to the other email I just sent (that seemed to bounce?),
>

Probably my mistake, in one of the posts I changed the address from devel
to users unintentionally..


>
> Yes, this is a Windows 7 machine. I think the issue is standby / network
> change related. In particular, standby / resume seems to cause a lot of
> grief. I also run on a desktop, not near as many (or really any) issues.
> But standby / resume -> crash!
>
> FYI, just had this exact issue, 1 minute ago. Got an OpenVPN connection,
> but no IP address (DHCP). Killed openvpn, disable / enable TAP, start
> openvpn and reconnect -> life is good again. Pretty reliable to make this
> happen =E2=80=A6 =EF=81=8C.
>
>
Our home laptop goes from sleep to resume all the time without major
issues. But we are not connecting to any public servers -- private servers
that run on a fixed IP and port, no DHCP, so may be that is one difference?

We have one Windows 7 laptop in a really really remote location that is set
to stay connected all the time.. The local network at that site crashes at
least twice a day and still the VPN comes back every time the network is
back. Its set not to sleep, so more like a desktop, but it does
occasionally move from one site to another.  Considering the remoteness of
the location and the flakiness of the remote network I have been more than
impressed by the way openvpn has served us for last 3 years.

But roaming is something I haven't tested much at all. When users travel
they do get connectivity from hotels etc., so that kind of "network change"
works well too.


> Perhaps some more detailed logs to debug?
>

Sure, would help.

Regards,

Selva

--089e013c6aba015de00522b7ad40
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Thu, Oct 22, 2015 at 3:58 PM, Morris=
, Russell <span dir=3D"ltr">&lt;<a href=3D"mailto:rmorris@...1315..." targe=
t=3D"_blank">rmorris@...1315...</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">=
<div id=3D":4z6" class=3D"" style=3D"overflow:hidden">Hi,<br>
<br>
Just checked - yep, 9.0.0.21. It seems to be from 2014 though?<br>
<br>
And to the other email I just sent (that seemed to bounce?),<br></div></blo=
ckquote><div><br></div><div>Probably my mistake, in one of the posts I chan=
ged the address from devel to users unintentionally..</div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;=
padding-left:1ex"><div id=3D":4z6" class=3D"" style=3D"overflow:hidden">
<span class=3D""><br>
Yes, this is a Windows 7 machine. I think the issue is standby / network ch=
ange related. In particular, standby / resume seems to cause a lot of grief=
. I also run on a desktop, not near as many (or really any) issues. But sta=
ndby / resume -&gt; crash!<br>
<br>
</span>FYI, just had this exact issue, 1 minute ago. Got an OpenVPN connect=
ion, but no IP address (DHCP). Killed openvpn, disable / enable TAP, start =
openvpn and reconnect -&gt; life is good again. Pretty reliable to make thi=
s happen =E2=80=A6 =EF=81=8C.<div class=3D""><div id=3D":5cw" class=3D"" ta=
bindex=3D"0"><img class=3D"" src=3D"//ssl.gstatic.com/ui/v1/icons/mail/imag=
es/cleardot.gif"></div></div><div class=3D""><br></div></div></blockquote><=
div>=C2=A0</div><div><div>Our home laptop goes from sleep to resume all the=
 time without major issues. But we are not connecting to any public servers=
 -- private servers that run on a fixed IP and port, no DHCP, so may be tha=
t is one difference?=C2=A0</div><div><br></div><div>We have one Windows 7 l=
aptop in a really really remote location that is set to stay connected all =
the time.. The local network at that site crashes at least twice a day and =
still the VPN comes back every time the network is back. Its set not to sle=
ep, so more like a desktop, but it does occasionally move from one site to =
another.=C2=A0 Considering the remoteness of the location and the flakiness=
 of the remote network I have been more than impressed by the way openvpn h=
as served us for last 3 years.=C2=A0</div><div><br></div><div>But roaming i=
s something I haven&#39;t tested much at all. When users travel they do get=
 connectivity from hotels etc., so that kind of &quot;network change&quot; =
works well too.=C2=A0</div></div><div><br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div id=3D=
":4z6" class=3D"" style=3D"overflow:hidden"><div class=3D"">
</div><span class=3D"im"><br>
Perhaps some more detailed logs to debug?<br></span></div></blockquote><div=
><br></div><div>Sure, would help.</div><div><br></div><div>Regards,</div><d=
iv><br></div><div>Selva</div></div><br><br></div></div>

--089e013c6aba015de00522b7ad40--

