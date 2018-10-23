MIME-Version: 1.0
References: <CADkMwqTKd1tjTboxmvgrvk9kVtHDtubvQmEQ0m=nt4GB-RtoqA@...278...>
 <CAFHpkQG10QOhGUb4R4VyPHwCNMfkVSQgCVgmypsBidsgNcsBaw@...278...>
 <CADkMwqQ+F-rLr3V5_BxjixbvnyOW6T+Y6tP---3PBaOcHkRBpA@...278...>
 <CAFHpkQExnJLdr1kNMkXoYxXjOdX4+M3KTcOfBp1ZQwmV3CkkXA@...278...>
 <CADkMwqS7AUDVz_tj0_6ewhJ7YgfJmph71dK-hCVhgOY=5+z3oA@...278...>
 <CAFHpkQHhy_w=0vSag_cqwQ=BiPStuVBzK0GOheMpjvpFFY_wAQ@...278...>
 <CADkMwqQCC_5=tWyX5HPQpPBVqwm8eoisYY=GtjLYcwx7KpN2Hg@...278...>
 <CAFHpkQHpaLNwfWvm3C6YsWE1wTRndXMJPa4QkBqcvMGTwk7=dw@...278...>
 <CADkMwqRaW_7VrDg+k0ok6ZNqaZo=FheJFz+ZW958E5HD4xX_cQ@...278...>
 <CAFHpkQGOV+g7-Fe+ANHCPAE4_Ew8fgWo3DOoeYhExyVzdr5Dfg@...278...>
 <CADkMwqTZ9F8wbYrJjmoQQ56yf+e2DwRc3MQ7y6R0E3gSL4Zf2g@...278...>
 <CAKuzo_iVf7zOFV7b-5d0gR=6Ea9RR3o0420jhNtmSAuAq1MegA@...278...>
 <CADkMwqT8_Y8C4MSw7Jxjm+D+A9irBPVtouC9o+XE+EuzP0J6Fg@...278...>
 <CAKuzo_j3z2qSsxw1G_EYFtZCqch+nNd-9=gu9MKRXX+eP2LhYQ@...278...>
 <DM5PR2101MB11120B19BDCDCC39A3C834D3B0E40@...2412...>
 <CAKuzo_iFdNEOKsBq3tJ8VKye-zh5se6LSS5BpeJxoSP5J7EK-A@...278...>
 <CADkMwqSmonP074Xu-Wgex=gQ=K89VGXDAEc-efNqD0iLGu29zQ@...278...>
 <DM5PR2101MB11121D4F30EA5206D1BA11EAB0E60@...2412...>
In-Reply-To: <DM5PR2101MB11121D4F30EA5206D1BA11EAB0E60@...2412...>
From: Rostyslav Maryliak <rostyslav.maryliak@...2454...>
Date: Wed, 24 Oct 2018 01:37:05 +0300
Message-ID: <CADkMwqTFZaVMXS79ck1esi9EWAt4hhnpCZ9Fq12nZw5VyAm_=g@...278...>
Content-Type: multipart/alternative; boundary="00000000000077eafb0578ed0428"
Subject: Re: [Openvpn-devel] Slow outbound network speed for Windows Server
 2016 only via the OpenVPN tunnel
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jon Kunkee <jkunkee@...2393...>
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel@lists.sourceforge.net

--00000000000077eafb0578ed0428
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear John and Selva,

I've tried almost all advises I was able to find in Internet but still no
luck.
Also, I've tried to test this hacky tap-adapter from jkunkee. I was able to
build the tapinstall itself, but failed to add new adapter with it.

Are you able to recreate my scenario and confirm the problem as I have on
your side?
Do you have any suggestions I can try?

On Mon, Oct 8, 2018 at 10:43 PM Jon Kunkee <jkunkee@...2393...> wrote:

>
> (Side note: I do work for Microsoft, but I don't speak for Microsoft,
> don't know the networking stack well, and am not an NDIS dev.)
>
> >>>> I don't know what causes this (the TAP driver?) but hopefully others
> may chime in with some clue.
>
> >>> I wonder if this will be addressed by adding the missing
> buffer-remaining query OIDs. Unfortunately I don=E2=80=99t know enough to=
 say for
> sure, but they are used for protocol behavior hinting.
>
> Please note that this is just one theory. I don't currently have the
> networking expertise to determine what the problem is given the informati=
on
> in this thread, so it's possible something else entirely is the problem.
>
> >> That was what I was hinting at too, but in the same boat here: not
> knowing enough about NDIS architecture I'm not in a position to make a
> patch for the missing OIDs.
> >>
> >> That said, as server 2016 uses the same kernel as Windows 10 (doesn't
> it?) such issues should show up on that platform too. Or are there some
> network protocol improvements that are enabled only on server 2016?
>
> Windows Server 2016 is roughly equivalent to the Windows 10 Anniversary
> Update (1607), though it has more changes backported since its
> servicing-vs-upgrade cadence is very different from desktop Windows'
> cadence. That said, yes, it's the same kernel.
>
> The question here is whether Server has more features lit up than client,
> and my digging suggests 'not in the TCP/IP stack'--but Server 2016 did ha=
ve
> significant changes and does allow a lot more configuration (as described
> earlier with 'custom' profiles):
>
> https://www.speedguide.net/articles/windows-10-anniversary-updates-to-tcp=
-6266
>
> Server is more perf-sensitive than desktop, so it wouldn't surprise me if
> the Server 2016 TCP/IP stack started to rely on these OIDs for congestion
> control. The Server 2016 HLK tests do require that they be implemented.
> (This is one reason it is not (yet!) certified.)
>
> If you're feeling daring, you could try rebuilding the driver with this
> extremely hacky change and see if the perf changes:
>
> https://github.com/jkunkee/tap-windows6/commit/2706c9a98bd25a0fee6559ac13=
2d75622475c26e
>
> HTH,
> Jon
>
>

--=20

Best regards,

*Rostyslav Maryliak*

System Administrator



*iDeals=E2=84=A2 Solutions Group*| + 38(073)437-72-51 <%2B%2038%28093%29575=
-35-16> |
Skype: rostyslav.maryliak.ideals| *rostyslav.maryliak@...2454...
<dmitry.zaporozhchenko@...2454...>* | www.idealsvdr.com
<http://www.idealscorp.com/>

--=20
CONFIDENTIALITY NOTE:
The information transmitted, including attachments,

is intended only for the person(s) or entity to which it is addressed and

may contain confidential and/or privileged material. Any review,

retransmission, dissemination or other use of, or taking of any action in

reliance upon this information by persons or entities other than the

intended recipient is prohibited. If you received this in error, please

contact the sender and destroy any copies of this information.

--00000000000077eafb0578ed0428
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">Dear John and Selva,</div><div class=3D"gmail_default" =
style=3D"font-family:arial,helvetica,sans-serif"><br></div><div class=3D"gm=
ail_default" style=3D"font-family:arial,helvetica,sans-serif">I&#39;ve trie=
d almost all advises I was able to find in Internet but still no luck.</div=
><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-ser=
if">Also, I&#39;ve tried to test this hacky tap-adapter from jkunkee. I was=
 able to build the tapinstall itself, but failed to add new adapter with it=
.</div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sa=
ns-serif"><br></div><div class=3D"gmail_default" style=3D"font-family:arial=
,helvetica,sans-serif">Are you able to recreate my scenario and confirm the=
 problem as I have on your side?</div><div class=3D"gmail_default" style=3D=
"font-family:arial,helvetica,sans-serif">Do you have any suggestions I can =
try?</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Mon, Oct=
 8, 2018 at 10:43 PM Jon Kunkee &lt;<a href=3D"mailto:jkunkee@...2393...">j=
kunkee@...2393...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><b=
r>
(Side note: I do work for Microsoft, but I don&#39;t speak for Microsoft, d=
on&#39;t know the networking stack well, and am not an NDIS dev.)<br>
<br>
&gt;&gt;&gt;&gt; I don&#39;t know what causes this (the TAP driver?) but ho=
pefully others may chime in with some clue.<br>
<br>
&gt;&gt;&gt; I wonder if this will be addressed by adding the missing buffe=
r-remaining query OIDs. Unfortunately I don=E2=80=99t know enough to say fo=
r sure, but they are used for protocol behavior hinting.<br>
<br>
Please note that this is just one theory. I don&#39;t currently have the ne=
tworking expertise to determine what the problem is given the information i=
n this thread, so it&#39;s possible something else entirely is the problem.=
<br>
<br>
&gt;&gt; That was what I was hinting at too, but in the same boat here: not=
 knowing enough about NDIS architecture I&#39;m not in a position to make a=
 patch for the missing OIDs.<br>
&gt;&gt;<br>
&gt;&gt; That said, as server 2016 uses the same kernel as Windows 10 (does=
n&#39;t it?) such issues should show up on that platform too. Or are there =
some network protocol improvements that are enabled only on server 2016?<br>
<br>
Windows Server 2016 is roughly equivalent to the Windows 10 Anniversary Upd=
ate (1607), though it has more changes backported since its servicing-vs-up=
grade cadence is very different from desktop Windows&#39; cadence. That sai=
d, yes, it&#39;s the same kernel.<br>
<br>
The question here is whether Server has more features lit up than client, a=
nd my digging suggests &#39;not in the TCP/IP stack&#39;--but Server 2016 d=
id have significant changes and does allow a lot more configuration (as des=
cribed earlier with &#39;custom&#39; profiles):<br>
<a href=3D"https://www.speedguide.net/articles/windows-10-anniversary-updat=
es-to-tcp-6266" rel=3D"noreferrer" target=3D"_blank">https://www.speedguide=
.net/articles/windows-10-anniversary-updates-to-tcp-6266</a><br>
<br>
Server is more perf-sensitive than desktop, so it wouldn&#39;t surprise me =
if the Server 2016 TCP/IP stack started to rely on these OIDs for congestio=
n control. The Server 2016 HLK tests do require that they be implemented. (=
This is one reason it is not (yet!) certified.)<br>
<br>
If you&#39;re feeling daring, you could try rebuilding the driver with this=
 extremely hacky change and see if the perf changes:<br>
<a href=3D"https://github.com/jkunkee/tap-windows6/commit/2706c9a98bd25a0fe=
e6559ac132d75622475c26e" rel=3D"noreferrer" target=3D"_blank">https://githu=
b.com/jkunkee/tap-windows6/commit/2706c9a98bd25a0fee6559ac132d75622475c26e<=
/a><br>
<br>
HTH,<br>
Jon<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"l=
tr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><p st=
yle=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Calibri,sans-seri=
f"><span style=3D"font-size:12pt;color:rgb(89,89,89)">Best regards,</span><=
/p><p style=3D"margin:0in 0in 0.0001pt;font-family:Calibri,sans-serif"><fon=
t color=3D"#595959"><span style=3D"font-size:16px"><b>Rostyslav Maryliak</b=
></span></font></p><p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-=
family:Calibri,sans-serif"><span style=3D"font-size:12pt;color:rgb(89,89,89=
)">System Administrator</span></p><p style=3D"margin:0in 0in 0.0001pt;font-=
size:11pt;font-family:Calibri,sans-serif"><span style=3D"font-size:12pt;col=
or:rgb(89,89,89)">=C2=A0</span></p><p style=3D"margin:0in 0in 0.0001pt;font=
-size:11pt;font-family:Calibri,sans-serif"><b><span style=3D"font-size:12pt=
;color:rgb(35,176,24)">iDeals=E2=84=A2 Solutions Group</span></b><span styl=
e=3D"font-size:12pt;color:rgb(89,89,89)">|=C2=A0<a href=3D"tel:%2B%2038%280=
93%29575-35-16" value=3D"+380935753516" style=3D"color:rgb(17,85,204)" targ=
et=3D"_blank">+ 38(073)437-72-51</a>=C2=A0| Skype: rostyslav.maryliak.ideal=
s|</span><span style=3D"color:rgb(31,73,125)">=C2=A0</span><u><span style=
=3D"font-size:12pt;color:rgb(35,176,24)"><a href=3D"mailto:dmitry.zaporozhc=
henko@...2454..." style=3D"color:rgb(17,85,204)" target=3D"_blank"><span st=
yle=3D"color:rgb(5,99,193)">rostyslav.maryliak@...2454...</span></a></span>=
</u><u><span style=3D"color:rgb(35,176,24)">=C2=A0</span></u><span style=3D=
"font-size:12pt;color:rgb(89,89,89)">|</span><span style=3D"font-size:12pt;=
color:rgb(35,176,24)">=C2=A0</span><span lang=3D"RU" style=3D"font-size:12p=
t;color:rgb(35,176,24)"><a href=3D"http://www.idealscorp.com/" style=3D"col=
or:rgb(17,85,204)" target=3D"_blank"><span lang=3D"EN-US" style=3D"color:rg=
b(35,176,24)">www.idealsvdr.com</span></a></span></p></div></div></div></di=
v></div></div></div></div>

<br>
<span style=3D"font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;fo=
nt-size:12pt"><font face=3D"Trebuchet" size=3D"2">CONFIDENTIALITY NOTE:
The information transmitted, including attachments,
is intended only for the person(s) or entity to which it is addressed and
may contain confidential and/or privileged material. Any review,
retransmission, dissemination or other use of, or taking of any action in
reliance upon this information by persons or entities other than the
intended recipient is prohibited. If you received this in error, please
contact the sender and destroy any copies of this information.</font></span=
>=

--00000000000077eafb0578ed0428--

