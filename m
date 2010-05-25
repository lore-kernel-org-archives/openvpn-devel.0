MIME-Version: 1.0
In-Reply-To: <20100525130302.18618.qmail@...1287...>
References: <AANLkTinWsHCrRh6n-ABKzbBY2XLiGqVTgrBCzfv9s3LW@...278...>
	<20100525130302.18618.qmail@...1287...>
Date: Tue, 25 May 2010 16:33:25 +0300
Message-ID: <AANLkTinKBvHIpGax8pOTCwWb5MqXyu2ypOYTQ2afz5hc@...278...>
From: "nivwiz@...277..." <nivwiz@...277...>
Content-Type: multipart/alternative; boundary=001636c922dfb0e0c704876b3319
Subject: Re: [Openvpn-devel] bug: can't get dhcp using --up option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--001636c922dfb0e0c704876b3319
Content-Type: text/plain; charset=ISO-8859-1

Hi Peter,
I am very glad to hear your response.
here is the traffic I got when using the -up argument to start udhpc :
https://bugs.maemo.org/attachment.cgi?id=2706

as you can see the request is sent and replay is received, but somehow it
doesnt work.
I reported more info at https://bugs.maemo.org/show_bug.cgi?id=9679

As the dhcp request is set over the vpn , according to the wireshark
capture, do I still need to use -ping , as suggested in the offical
documents?


On Tue, May 25, 2010 at 4:03 PM, Peter Stuge <peter@...1287...> wrote:

> nivwiz@...277... wrote:
> > I want to report this bug:
>
> Can you help debug it? Add instrumentation to that script, or maybe
> to a new script, and see what is different about the interface when
> script is being run outside openvpn.
>
>
> //Peter
>
>
> ------------------------------------------------------------------------------
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--001636c922dfb0e0c704876b3319
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Peter,<br>I am very glad to hear your response.<br>here=
 is the traffic I got when using the -up argument to start udhpc : <a href=
=3D"https://bugs.maemo.org/attachment.cgi?id=3D2706">https://bugs.maemo.org=
/attachment.cgi?id=3D2706</a><br>
<br>as you can see the request is sent and replay is received, but somehow =
it doesnt work.<br>I reported more info at <a href=3D"https://bugs.maemo.or=
g/show_bug.cgi?id=3D9679">https://bugs.maemo.org/show_bug.cgi?id=3D9679</a>=
<br>
<br>As the dhcp request is set over the vpn , according to the wireshark ca=
pture, do I still need to use -ping , as suggested in the offical documents=
?<br><br><br><div class=3D"gmail_quote">On Tue, May 25, 2010 at 4:03 PM, Pe=
ter Stuge <span dir=3D"ltr">&lt;<a href=3D"mailto:peter@...1287...">peter@...220...=
..1287...</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div class=3D"im"=
><a href=3D"mailto:nivwiz@...277...">nivwiz@...277...</a> wrote:<br>
&gt; I want to report this bug:<br>
<br>
</div>Can you help debug it? Add instrumentation to that script, or maybe<b=
r>
to a new script, and see what is different about the interface when<br>
script is being run outside openvpn.<br>
<br>
<br>
//Peter<br>
<br>
---------------------------------------------------------------------------=
---<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" targ=
et=3D"_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a=
><br>
</blockquote></div><br></div>

--001636c922dfb0e0c704876b3319--

