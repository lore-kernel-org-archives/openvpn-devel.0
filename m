Date: Thu, 23 Jan 2014 13:35:52 +0100
From: Thomas Veerman <thomas.veerman@...1862...>
Message-ID: <etPan.52e10ca8.238e1f29.177@...1863...>
In-Reply-To: <52E10721.8060105@...1227...>
References: <20130620192348.GW20843@...1296...>
	<1371811708-8528-1-git-send-email-arne@...1227...>
	<52E10721.8060105@...1227...>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="52e10ca8_46e87ccd_177"
Subject: Re: [Openvpn-devel] [Patch v7] Add support of utun devices under
 Mac OS X
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, Arne Schwabe <arne@...1227...>

--52e10ca8_46e87ccd_177
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-.B \-\-dev\-node tun
-. When not specifying a
+.B \-\-dev\-node tun\fR.
+When not specifying a

Should do the trick.

--
Thomas

On January 23, 2014 at 1:12:41 PM, Arne Schwabe (arne@...1227...) wrote:

Am 21.06.13 12:48, schrieb Arne Schwabe: 
> +to select a specific utun instance. To force using the tun.kext (/dev/tunX) use 
> +.B \-\-dev\-node tun 
> +. When not specifying a 
> +.B \-\-dev\-node 
> +option openvpn will first try to open utun, and fall back to tun.kext. 
I just noticed that this does not work because man does ignore the line 
starting with a ".". 

Does anyone know how to fix this? My attempts of escaping the . were not 
fruitful. 

Arne 

------------------------------------------------------------------------------ 
CenturyLink Cloud: The Leader in Enterprise Cloud Services. 
Learn Why More Businesses Are Choosing CenturyLink Cloud For 
Critical Workloads, Development Environments & Everything In Between. 
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk 
_______________________________________________ 
Openvpn-devel mailing list 
Openvpn-devel@lists.sourceforge.net 
https://lists.sourceforge.net/lists/listinfo/openvpn-devel 

--52e10ca8_46e87ccd_177
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html><head><style>body{font-family:Helvetica,Arial;font-size:13px}</style>=
</head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; -web=
kit-line-break: after-white-space; "><div id=3D"bloop_customfont" style=3D"=
font-family:Helvetica,Arial;font-size:13px; color: rgba(0,0,0,1.0); margin:=
 0px; line-height: auto;"><div id=3D"bloop_customfont" style=3D"margin: 0px=
; "><div id=3D"bloop_customfont" style=3D"margin: 0px; ">-.B \-\-dev\-node =
tun</div><div id=3D"bloop_customfont" style=3D"margin: 0px; ">-. When not s=
pecifying a</div><div id=3D"bloop_customfont" style=3D"margin: 0px; ">+.B \=
-\-dev\-node tun\fR.</div><div id=3D"bloop_customfont" style=3D"margin: 0px=
; ">+When not specifying a</div></div><div id=3D"bloop_sign_139048049751993=
9072" class=3D"bloop_sign"><div style=3D"font-family: helvetica, arial; "><=
br></div><div style=3D"font-family: helvetica, arial; ">Should do the trick=
.</div><div style=3D"font-family: helvetica, arial; "><br></div><div style=
=3D"font-family: helvetica, arial; ">--</div><div style=3D"font-family: hel=
vetica, arial; ">Thomas</div></div></div> <br><p style=3D"color:#A0A0A8;">O=
n January 23, 2014 at 1:12:41 PM, Arne Schwabe (<a href=3D"mailto://arne@...1186...=
.1227...">arne@...1227...</a>) wrote:</p> <blockquote type=3D"cite" class=
=3D"clean_bq"><span><div><div>Am 21.06.13 12:48, schrieb Arne Schwabe:
<br>&gt; +to select a specific utun instance. To force using the tun.kext (=
/dev/tunX) use
<br>&gt; +.B \-\-dev\-node tun
<br>&gt; +. When not specifying a
<br>&gt; +.B \-\-dev\-node
<br>&gt; +option openvpn will first try to open utun, and fall back to tun.=
kext.
<br>I just noticed that this does not work because man does ignore the line
<br>starting with a ".".
<br>
<br>Does anyone know how to fix this? My attempts of escaping the . were not
<br>fruitful.
<br>
<br>Arne
<br>
<br>-----------------------------------------------------------------------=
-------
<br>CenturyLink Cloud: The Leader in Enterprise Cloud Services.
<br>Learn Why More Businesses Are Choosing CenturyLink Cloud For
<br>Critical Workloads, Development Environments &amp; Everything In Betwee=
n.
<br>Get a Quote or Start a Free Trial Today.=20=20
<br>http://pubads.g.doubleclick.net/gampad/clk?id=3D119420431&amp;iu=3D/414=
0/ostg.clktrk
<br>_______________________________________________
<br>Openvpn-devel mailing list
<br>Openvpn-devel@lists.sourceforge.net
<br>https://lists.sourceforge.net/lists/listinfo/openvpn-devel
<br></div></div></span></blockquote></body></html>=

--52e10ca8_46e87ccd_177--


