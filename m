MIME-Version: 1.0
In-Reply-To: <SN1PR08MB139154DAEBBDDF72D187B1E8B9260@...2065...>
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
	<CAKuzo_iV6NQJSGWORxLTY4+YLLE8u+ccAHTfVrpJtX0=TVZnWQ@...278...>
	<SN1PR08MB139154DAEBBDDF72D187B1E8B9260@...2065...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 23 Oct 2015 13:45:23 -0400
Message-ID: <CAKuzo_jigkF3R8XcxDaHM6GuKvr=M7y41RVpH8w0XmcdzF2xzg@...278...>
Content-Type: multipart/alternative; boundary=047d7bb04a623ed5e80522c92e7f
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

--047d7bb04a623ed5e80522c92e7f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This may be getting way too off-topic for this thread...

Please consider starting a new thread on this TAP I/O error.

On Fri, Oct 23, 2015 at 8:46 AM, Morris, Russell <rmorris@...1315...>
wrote:

> Hi,
>
>
>
> Let me try to collect some logs =E2=80=93 the issue is that I=E2=80=99m u=
sing NSSM =E2=80=A6 so it
> restarts openvpn on a crash, and wipes out the log (resets).
>

Use log-append


> FYI, here is what I see from the management interface (as this is what my
> app is using) =E2=80=93 first line is from the management interface (seco=
nd one
> from my app),
>
> [  344] Mangement FATAL Message Received: >FATAL:TUN/TAP I/O operation
> aborted, exiting
>
[  345] ERROR: OpenVPN Exiting, Event Raised to allow Reconnection to
> Management Interface!
>

>
> So it is exiting, just need more details if possible.
>
>
>
> And to clarify below =E2=80=A6 DHCP is for the IP address from my server,=
 inside
> the subnet (so I=E2=80=99m on the same subnet as my network). Make sense?=
 The
> external interface is fixed (IP and port).
>

You mean using the bridge mode? We never use bridging, so no idea how well
that works..

If you start a new thread please post the config and more error log.
Including the users-list may be a good idea too as there may be other
Windows users who have seen such behaviour.

Regards,

Selva

--047d7bb04a623ed5e80522c92e7f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br></div><div class=3D"gmail_extra">This may be getting way too off-t=
opic for this thread...</div><div class=3D"gmail_extra"><br></div><div clas=
s=3D"gmail_extra">Please consider starting a new thread on this TAP I/O err=
or.<br></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On F=
ri, Oct 23, 2015 at 8:46 AM, Morris, Russell <span dir=3D"ltr">&lt;<a href=
=3D"mailto:rmorris@...1315..." target=3D"_blank">rmorris@...1315...</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"adM">





</div><div lang=3D"EN-US" link=3D"blue" vlink=3D"purple"><div class=3D"adM">
</div><div><div class=3D"adM">
</div><p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&q=
uot;Calibri&quot;,sans-serif;color:#1f497d">Hi,<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d">Let me try to collect some logs =E2=
=80=93 the issue is that I=E2=80=99m using NSSM =E2=80=A6 so it restarts op=
envpn on a crash, and wipes out the log (resets). </span></p></div></div></=
blockquote><div><br></div><div>Use log-append</div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex"><div lang=3D"EN-US" link=3D"blue" vlink=3D"purple">=
<div><p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&qu=
ot;Calibri&quot;,sans-serif;color:#1f497d">FYI, here is what I see
 from the management interface (as this is what my app is using) =E2=80=93 =
first line is from the management interface (second one from my app),<u></u=
><u></u></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
11.0pt;font-family:&quot;Calibri&quot;,sans-serif">[=C2=A0 344] Mangement F=
ATAL Message Received: &gt;FATAL:TUN/TAP I/O operation aborted, exiting</sp=
an>=C2=A0</p></div></div></blockquote><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div l=
ang=3D"EN-US" link=3D"blue" vlink=3D"purple"><div><p class=3D"MsoNormal" st=
yle=3D"margin-left:.5in"><span style=3D"font-size:11.0pt;font-family:&quot;=
Calibri&quot;,sans-serif"><u></u><u></u></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
11.0pt;font-family:&quot;Calibri&quot;,sans-serif">[=C2=A0 345] ERROR: Open=
VPN Exiting, Event Raised to allow Reconnection to Management Interface!</s=
pan>=C2=A0</p></div></div></blockquote><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div =
lang=3D"EN-US" link=3D"blue" vlink=3D"purple"><div><p class=3D"MsoNormal" s=
tyle=3D"margin-left:.5in"><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif"><u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d">So it is exiting, just need more deta=
ils if possible.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d">And to clarify below =E2=80=A6 DHCP i=
s for the IP address from my server, inside the subnet (so I=E2=80=99m on t=
he same subnet as my network). Make sense? The external interface
 is fixed (IP and port).</span></p></div></div></blockquote></div><br>You m=
ean using the bridge mode? We never use bridging, so no idea how well that =
works..</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra=
">If you start a new thread please post the config and more error log. Incl=
uding the users-list may be a good idea too as there may be other Windows u=
sers who have seen such behaviour.</div><div class=3D"gmail_extra"><br></di=
v><div class=3D"gmail_extra">Regards,</div><div class=3D"gmail_extra"><br><=
/div><div class=3D"gmail_extra">Selva</div><div class=3D"gmail_extra"><br><=
/div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><br></=
div></div>

--047d7bb04a623ed5e80522c92e7f--

