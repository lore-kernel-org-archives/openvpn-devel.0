MIME-Version: 1.0
In-Reply-To: <000001cc8890$9d6d35b0$d847a110$@net>
References: <000001cc8890$9d6d35b0$d847a110$@net>
Date: Tue, 11 Oct 2011 21:42:58 -0700
Message-ID: <CADKk8=uwCojh_xxuQMXGHNQNnFbFfWf0Tdp0wp9ikxHsu43vEQ@...278...>
From: anjini shukla <anjinishukla@...277...>
Content-Type: multipart/alternative; boundary=90e6ba613bf08d99c504af12a879
Subject: Re: [Openvpn-devel] VPN Connects but can't route to destinations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Richard Francis <rfransix@...164...>
Cc: openvpn-devel@lists.sourceforge.net

--90e6ba613bf08d99c504af12a879
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

You need to set up IP masquerading, it is simple for linux machines:
iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE
for windows you require to set up ICS which can be done using windows UI

On Tue, Oct 11, 2011 at 8:39 PM, Richard Francis <rfransix@...164...>wrote:

> ** **
>
> Hi,****
>
> ** **
>
> I=92ve configured an openvpn TAP-Win32 Adapter V9 with an ip address of
> 12.0.0.2, subnet mask of 255.0.0.0, DHCP of 12.0.0.0, and DNS of 10.0.0.2=
22.
> ****
>
> ** **
>
> After I connect, I can only ping 10.0.0.222, nothing else on the 10.x.x.x
> network.****
>
> ** **
>
> And to get to .222, I had to, route add 10.0.0.0 MASK 255.0.0.0 12.0.0.2
> METRIC 30 to get there.****
>
> ** **
>
> What am I missing?****
>
> ** **
>
> Thank you very much.****
>
> ** **
>
> Richard****
>
> ** **
>
>
> -------------------------------------------------------------------------=
-----
> All the data continuously generated in your IT infrastructure contains a
> definitive record of customers, application performance, security
> threats, fraudulent activity and more. Splunk takes this data and makes
> sense of it. Business sense. IT sense. Common sense.
> http://p.sf.net/sfu/splunk-d2d-oct
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

--90e6ba613bf08d99c504af12a879
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

You need to set up IP=A0masquerading, it is simple for linux machines:<div>=
<span class=3D"Apple-style-span" style=3D"font-family: arial, sans-serif; f=
ont-size: 13px; background-color: rgb(255, 255, 255); ">iptables -t nat -I =
POSTROUTING -o eth0 -j MASQUERADE</span></div>
<div><font class=3D"Apple-style-span" face=3D"arial, sans-serif">for window=
s you require to set up ICS which can be done using windows UI<br></font><b=
r><div class=3D"gmail_quote">On Tue, Oct 11, 2011 at 8:39 PM, Richard Franc=
is <span dir=3D"ltr">&lt;<a href=3D"mailto:rfransix@...164...">rfransix@...493...=
164...</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div lang=3D"EN-US" link=3D"blue" vlink=3D"=
purple"><div><p class=3D"MsoNormal"><u></u>=A0<u></u></p><p class=3D"MsoNor=
mal">Hi,<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=A0<u></u></p><p class=3D"MsoNormal">I=92ve c=
onfigured an openvpn TAP-Win32 Adapter V9 with an ip address of 12.0.0.2, s=
ubnet mask of 255.0.0.0, DHCP of 12.0.0.0, and DNS of 10.0.0.222.<u></u><u>=
</u></p>
<p class=3D"MsoNormal"><u></u>=A0<u></u></p><p class=3D"MsoNormal">After I =
connect, I can only ping 10.0.0.222, nothing else on the 10.x.x.x network.<=
u></u><u></u></p><p class=3D"MsoNormal"><u></u>=A0<u></u></p><p class=3D"Ms=
oNormal">
And to get to .222, I had to, route add 10.0.0.0 MASK 255.0.0.0 12.0.0.2 ME=
TRIC 30 to get there.<u></u><u></u></p><p class=3D"MsoNormal"><u></u>=A0<u>=
</u></p><p class=3D"MsoNormal">What am I missing?<u></u><u></u></p><p class=
=3D"MsoNormal">
<u></u>=A0<u></u></p><p class=3D"MsoNormal">Thank you very much.<u></u><u><=
/u></p><p class=3D"MsoNormal"><u></u>=A0<u></u></p><font color=3D"#888888">=
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Richard</span><span st=
yle=3D"color:#1F497D"><u></u><u></u></span></p>
<p class=3D"MsoNormal"><u></u>=A0<u></u></p></font></div></div><br>--------=
----------------------------------------------------------------------<br>
All the data continuously generated in your IT infrastructure contains a<br>
definitive record of customers, application performance, security<br>
threats, fraudulent activity and more. Splunk takes this data and makes<br>
sense of it. Business sense. IT sense. Common sense.<br>
<a href=3D"http://p.sf.net/sfu/splunk-d2d-oct" target=3D"_blank">http://p.s=
f.net/sfu/splunk-d2d-oct</a><br>___________________________________________=
____<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" targ=
et=3D"_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a=
><br>
<br></blockquote></div><br></div>

--90e6ba613bf08d99c504af12a879--

