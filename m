Date: Tue, 19 Oct 2010 16:03:49 +0200
Message-Id: <LAJJ2D$6AC5104694B27E91EDCB9FDC840528E4@...1417...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="_=__=_XaM3_.1287497029.2A.824435.42.21023.52.42.007.454446682"
From: "openvpn" <openvpn@...1416...>
Subject: Re: [Openvpn-devel] openvpn, NTLM and McAfee Web Gateway
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--_=__=_XaM3_.1287497029.2A.824435.42.21023.52.42.007.454446682
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Da: "Jan Just Keijser" janjust@...1147...
A: "openvpn" openvpn@...1416...
Cc: openvpn-devel@lists.sourceforge.net
Data: Mon, 18 Oct 2010 12:58:35 +0200
Oggetto: Re: [Openvpn-devel] openvpn, NTLM and McAfee Web Gateway

> openvpn wrote:
> > dear all,
> >
> > a few days ago I deployed an ovpn solution in a medium sized company.=20
> > One of the two ends of the vpn network is passing through a proxy with=
=20
> > NTLM authentication. ovpn has problems to recognize the authentication=
=20
> > because immediately after sending the message type 1, the proxy sends=20
> > no response, so I had to modify the source code by replacing the=20
> > current message with a similar but different one.
> >
> > in particular this one:
> >
> > TlRMTVNTUAABAAAAAgIAAA=3D=3D
> >
> >
> > become:
> >
> > TlRMTVNTUAABAAAAB4IIogAAAAAAAAAAAAAAAAAAAAAFASgKAAAADw=3D=3D
> >
> >
> > A detail of the work is available at:
> >
> > http://www.morzello.com/?p=3D350 (in Italian).
> >
> > I was wondering if you could have a function that supports this type=20
> > of proxy (such as McAfee Web Gateway).
> >
> I applied your "patch" and I still cannot get it to work for my=20
> httpd+mod_ntlm (NTLMv1 only) installation. The NTLM handshake that=20
> OpenVPN does is broken. Without the patch Wireshark tells me the first=20
> NTLMSPP message is invalid
>   http://www.nikhef.nl/~janjust/openvpn/openvpn-ntlm-error1.png
> If I change the phase_1 NTLM message to the above I get one step further=
=20
> but then it breaks at the next packet:
>   http://www.nikhef.nl/~janjust/openvpn/openvpn-ntlm-error2.png
> It seems the Windows domain and username are not stored properly inside=20
> the request. The same httpd+mod_ntlm installation works flawlessly using=
=20
> Internet Explorer 7: in that case the domain and user name are encoded=20
> just fine.
>=20
> What am I doing wrong?
>=20
> cheers,
>=20
> JJK
>=20
=C2=A0
Sorry Jan, mine was a dirty job in order to quick solve my problem. I think=
 the correct way to solve the issue is to deeper study the NTLM and NTLMv2 =
standard.=C2=A0 the error 1 is the same i've got before patching the code b=
ut i didn't spent much time to analyze the issue. I can try to solve the pr=
oblem if someone can test the results (with community agreement).
=C2=A0
have a nice day, vittorio

--_=__=_XaM3_.1287497029.2A.824435.42.21023.52.42.007.454446682
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


<div class=3D"xam_msg_class">
<div style=3D"font: normal 13px Arial; color:rgb(0, 0, 0);"><br><br>
<div><span style=3D"font-family: Arial; font-size: 11px; color: rgb(95, 95,=
 95);">Da</span><span style=3D"font-family: Arial; font-size: 12px; color: =
rgb(95, 95, 95); padding-left: 5px;">: "Jan Just Keijser" janjust@...1421...=
.</span></div>
<div><span style=3D"font-family: Arial; font-size: 11px; color: rgb(95, 95,=
 95);">A</span><span style=3D"font-family: Arial; font-size: 12px; color: r=
gb(95, 95, 95); padding-left: 5px;">: "openvpn" openvpn@...1416...</span></=
div>
<div><span style=3D"font-family: Arial; font-size: 11px; color: rgb(95, 95,=
 95);">Cc</span><span style=3D"font-family: Arial; font-size: 12px; color: =
rgb(95, 95, 95); padding-left: 5px;">: openvpn-devel@lists.sourceforge.net<=
/span></div>
<div><span style=3D"font-family: Arial; font-size: 11px; color: rgb(95, 95,=
 95);">Data</span><span style=3D"font-family: Arial; font-size: 12px; color=
: rgb(95, 95, 95); padding-left: 5px;">: Mon, 18 Oct 2010 12:58:35 +0200</s=
pan></div>
<div><span style=3D"font-family: Arial; font-size: 11px; color: rgb(95, 95,=
 95);">Oggetto</span><span style=3D"font-family: Arial; font-size: 12px; co=
lor: rgb(95, 95, 95); padding-left: 5px;">: Re: [Openvpn-devel] openvpn, NT=
LM and McAfee Web Gateway</span></div>
<br>
<div>&gt; openvpn wrote:</div><div>&gt; &gt; dear all,</div><div>&gt; &gt;<=
/div><div>&gt; &gt; a few days ago I deployed an ovpn solution in a medium =
sized company. </div><div>&gt; &gt; One of the two ends of the vpn network =
is passing through a proxy with </div><div>&gt; &gt; NTLM authentication. o=
vpn has problems to recognize the authentication </div><div>&gt; &gt; becau=
se immediately after sending the message type 1, the proxy sends </div><div=
>&gt; &gt; no response, so I had to modify the source code by replacing the=
 </div><div>&gt; &gt; current message with a similar but different one.</di=
v><div>&gt; &gt;</div><div>&gt; &gt; in particular this one:</div><div>&gt;=
 &gt;</div><div>&gt; &gt; TlRMTVNTUAABAAAAAgIAAA=3D=3D</div><div>&gt; &gt;<=
/div><div>&gt; &gt;</div><div>&gt; &gt; become:</div><div>&gt; &gt;</div><d=
iv>&gt; &gt; TlRMTVNTUAABAAAAB4IIogAAAAAAAAAAAAAAAAAAAAAFASgKAAAADw=3D=3D</=
div><div>&gt; &gt;</div><div>&gt; &gt;</div><div>&gt; &gt; A detail of the =
work is available at:</div><div>&gt; &gt;</div><div>&gt; &gt; http://www.mo=
rzello.com/?p=3D350 (in Italian).</div><div>&gt; &gt;</div><div>&gt; &gt; I=
 was wondering if you could have a function that supports this type </div><=
div>&gt; &gt; of proxy (such as McAfee Web Gateway).</div><div>&gt; &gt;</d=
iv><div>&gt; I applied your "patch" and I still cannot get it to work for m=
y </div><div>&gt; httpd+mod_ntlm (NTLMv1 only) installation. The NTLM hands=
hake that </div><div>&gt; OpenVPN does is broken. Without the patch Wiresha=
rk tells me the first </div><div>&gt; NTLMSPP message is invalid</div><div>=
&gt;   http://www.nikhef.nl/~janjust/openvpn/openvpn-ntlm-error1.png</div><=
div>&gt; If I change the phase_1 NTLM message to the above I get one step f=
urther </div><div>&gt; but then it breaks at the next packet:</div><div>&gt=
;   http://www.nikhef.nl/~janjust/openvpn/openvpn-ntlm-error2.png</div><div=
>&gt; It seems the Windows domain and username are not stored properly insi=
de </div><div>&gt; the request. The same httpd+mod_ntlm installation works =
flawlessly using </div><div>&gt; Internet Explorer 7: in that case the doma=
in and user name are encoded </div><div>&gt; just fine.</div><div>&gt; </di=
v><div>&gt; What am I doing wrong?</div><div>&gt; </div><div>&gt; cheers,</=
div><div>&gt; </div><div>&gt; JJK</div><div>&gt; </div><div>&nbsp;</div><di=
v>Sorry Jan, mine was a dirty job in order to quick solve my problem. I thi=
nk the correct way to solve the issue is to deeper study the NTLM and NTLMv=
2 standard.&nbsp; the error 1 is the same i've got before patching the code=
 but i didn't spent much time to analyze the issue. I can try to solve the =
problem if someone can test the results (with community agreement).</div><d=
iv>&nbsp;</div><div>have a nice day, vittorio<br><br> </div></div>
</div>


--_=__=_XaM3_.1287497029.2A.824435.42.21023.52.42.007.454446682--


