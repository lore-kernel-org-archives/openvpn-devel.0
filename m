From: Russell Morris <openvpn@...1315...>
Date: Mon, 08 Aug 2011 20:16:25 -0500
Message-id: <1312852585163750500@...1315...>
In-reply-to: <201108081608.22398.heiko.hund@...1489...>
References: <1311649077083710500@...1315...> <1311721403985112500@...1315...>
	<1312758902759591500@...1315...>
	<201108081608.22398.heiko.hund@...1489...>
MIME-version: 1.0
Content-type: multipart/mixed;
	boundary="===axigen=2219995521518047684736865136804335244864=axigen==="
Subject: Re: [Openvpn-devel] Windows Auto-Proxy
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

This is a MIME message. You may need a MIME compliant mail user agent.
--===axigen=2219995521518047684736865136804335244864=axigen===
Content-Type: multipart/alternative;
	boundary="===axigen=2863102795599554509940116230946434730980=axigen==="

--===axigen=2863102795599554509940116230946434730980=axigen===
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Heiko,
Well, I can try ... :-). Some thoughts here - hope this helps, but of cours=
e feel free to ask questions!
1) I have attached some code I put together to detect proxy information aut=
omatically (using WinHTTP, and in particular WinHttpGetProxyForUrl). It wor=
ks with PAC files (at least it did for me ... :-)). I have also included so=
me links in the code, to get more info on the Windows API's. Please excuse =
the poor coding though - I'm a HW guy, not a SW expert (not even close!). T=
he slew of messages that I have put in the code are just FYI for now. These=
 could be split to console output, or logging, or just removed. Whatever yo=
u prefer.
BTW, I'm not sure how you use proxy in your code. At least with the PAC fil=
e that I go through, I get a response back of the format proxy.domain.net:8=
080;10.10.10.10:8080. We may need to parse this (again, just not sure how y=
ou use it). Also, I have not implemented asynchronous processing. It can be=
 done, but not sure it buys much, as you really can't proceed until the pro=
xy information is available. I also haven't modified the WinHTTP timeout. A=
gain, this can be done if needed (but the response is typically quite quick=
).
I agree with your targets - and one further comment ... auto-proxy detectio=
n should be done every time a connection attempt is to be started (i.e. eve=
n when reconnecting), agreed?
2) I can't say too much about automatic logon, but I have seen some example=
 code on Microsoft's web site related to using fAutoLogonIfChallenged (more=
 details starting from http://msdn.microsoft.com/en-us/library/aa383153(v=
=3Dvs.85).aspx). They seem to show this automatically logging on the the pr=
oxy server (for HTTP requests), so it may be worth a try.
Thoughts? Hope this helps you out!
Take care,... Russell


On Mon, 08/08/2011 09:08 AM, Heiko Hund <heiko.hund@...1489...> wrote:
> Hi,
>=20
> On Monday 08 August 2011 01:15:02 Russell Morris wrote:
> > Has anyone had any luck with the auto-proxy function, in particular with
> > PAC files? It really doesn't seem to be working for me ... :-(.
>=20
> Are you aware of https://community.openvpn.net/openvpn/ticket/24 ? This i=
s=20
> probably what's causing your trouble... and of course the fact that the=20
> current impelmentation does not do proxy auto detection.
>=20
> I'll start resolving these issues now as it is something the GUI is relyi=
ng=20
> onto as well. Openvpn should even be able to handle per Dial-up and VPN=20
> connection proxy settings if things work out.
>=20
> > Also, does anyone have a proxy server that requires authentication? I
> > currently use a text file (which does work!), but there are also Windows
> > functions that should send domain login information automatically. It
> > would be nice to to that ... :-).
>=20
> I like that idea, but t's probably unrelated to auto-proxy. Could you poi=
nt me=20
> to the APIs.
>=20
> Heiko
> --
> Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
> Astaro a Sophos Company | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Ge=
rmany
> Commercial Register: Mannheim HRA 702710 | Headquarter Location: Karlsruhe
>=20=20
> Represented by the General Partner Astaro Verwaltungs GmbH
> Amalienbadstra=C3=9Fe 41 Bau 52 | 76227 Karlsruhe | Germany=20
> Commercial Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,
> Markus Hennig, Jan Hichert, G=C3=BCnter Junk, Dr. Frank Nellissen
>=20
> -------------------------------------------------------------------------=
-----
> BlackBerry&reg; DevCon Americas, Oct. 18-20, San Francisco, CA
> The must-attend event for mobile developers. Connect with experts.=20
> Get tools for creating Super Apps. See the latest technologies.
> Sessions, hands-on labs, demos & much more. Register early & save!
> http://p.sf.net/sfu/rim-blackberry-1
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20=

--===axigen=2863102795599554509940116230946434730980=axigen===
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html><head><style id=3D"axi-htmleditor-style" type=3D"text/css">p { margin=
: 0px; }</style></head><body style=3D"font-size: 10pt; font-family: Arial; =
background-image: none; background-repeat: repeat; background-attachment: f=
ixed;">Hi Heiko,<div><br></div><div>Well, I can try ... :-). Some thoughts =
here - hope this helps, but of course feel free to ask questions!</div><div=
><br></div><div>1) I have attached some code I put together to detect proxy=
 information automatically (using WinHTTP, and in particular WinHttpGetProx=
yForUrl). It works with PAC files (at least it did for me ... :-)). I have =
also included some links in the code, to get more info on the Windows API's=
. Please excuse the poor coding though - I'm a HW guy, not a SW expert (not=
 even close!). The slew of messages that I have put in the code are just FY=
I for now.&nbsp;These could be split to console output, or logging, or just=
 removed.&nbsp;Whatever you prefer.</div><div><br></div><div>BTW,&nbsp;I'm =
not sure how you use proxy in your code. At least with the PAC file that I =
go through, I get a response back of the format proxy.domain.net:8080;10.10=
.10.10:8080. We may need to parse this (again, just not sure how you use it=
). Also, I have not implemented asynchronous processing. It can be done, bu=
t not sure it buys much, as you really can't proceed until the proxy inform=
ation is available. I also haven't modified the WinHTTP timeout. Again, thi=
s can be done if needed (but the response is typically quite quick).</div><=
div><br></div><div>I agree with your targets - and one further comment ... =
auto-proxy detection should be done every time a connection attempt is to b=
e started (i.e. even when reconnecting), agreed?</div><div><br></div><div>2=
) I can't say too much about automatic logon, but I have seen some example =
code on Microsoft's web site related to using fAutoLogonIfChallenged (more =
details starting from <a href=3D"http://msdn.microsoft.com/en-us/library/aa=
383153(v=3Dvs.85).aspx">http://msdn.microsoft.com/en-us/library/aa383153(v=
=3Dvs.85).aspx</a>). They seem to show this automatically logging on the th=
e proxy server (for HTTP requests), so it may be worth a try.</div><div><br=
></div><div>Thoughts? Hope this helps you out!</div><div><br></div><div>Tak=
e care,</div><div>... Russell</div><div><br></div><div><br></div><div><br>O=
n Mon, 08/08/2011 09:08 AM, Heiko&nbsp;Hund&nbsp;&lt;heiko.hund@...1489...&=
gt; wrote:<br><blockquote style=3D"border-left: 2px solid rgb(00, 00, 204);=
 padding-left: 4px; margin-left: 16px;"><div style=3D"font-family: Arial; f=
ont-size: 10pt;">Hi,<br><br>On Monday 08 August 2011 01:15:02 Russell Morri=
s wrote:<br>&gt; Has anyone had any luck with the auto-proxy function, in p=
articular with<br>&gt; PAC files? It really doesn't seem to be working for =
me ... :-(.<br><br>Are you aware of <a href=3D"https://community.openvpn.ne=
t/openvpn/ticket/24" target=3D"_blank">https://community.openvpn.net/openvp=
n/ticket/24</a> ? This is <br>probably what's causing your trouble... and o=
f course the fact that the <br>current impelmentation does not do proxy aut=
o detection.<br><br>I'll start resolving these issues now as it is somethin=
g the GUI is relying <br>onto as well. Openvpn should even be able to handl=
e per Dial-up and VPN <br>connection proxy settings if things work out.<br>=
<br>&gt; Also, does anyone have a proxy server that requires authentication=
? I<br>&gt; currently use a text file (which does work!), but there are als=
o Windows<br>&gt; functions that should send domain login information autom=
atically. It<br>&gt; would be nice to to that ... :-).<br><br>I like that i=
dea, but t's probably unrelated to auto-proxy. Could you point me <br>to th=
e APIs.<br><br>Heiko<br><font color=3D"#999999">--<br>Heiko Hund | Software=
 Engineer | Phone +49-721-25516-237 | Fax -200<br>Astaro a Sophos Company |=
 Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germany<br>Commercial Registe=
r: Mannheim HRA 702710 | Headquarter Location: Karlsruhe<br> <br>Represente=
d by the General Partner Astaro Verwaltungs GmbH<br>Amalienbadstra=C3=9Fe 4=
1 Bau 52 | 76227 Karlsruhe | Germany <br>Commercial Register: Mannheim HRB =
708248 | Executive Board: Gert Hansen,<br>Markus Hennig, Jan Hichert, G=C3=
=BCnter Junk, Dr. Frank Nellissen<br><br>----------------------------------=
--------------------------------------------<br>BlackBerry&amp;reg; DevCon =
Americas, Oct. 18-20, San Francisco, CA<br>The must-attend event for mobile=
 developers. Connect with experts. <br>Get tools for creating Super Apps. S=
ee the latest technologies.<br>Sessions, hands-on labs, demos &amp; much mo=
re. Register early &amp; save!<br><a href=3D"http://p.sf.net/sfu/rim-blackb=
erry-1" target=3D"_blank">http://p.sf.net/sfu/rim-blackberry-1</a><br>_____=
__________________________________________<br>Openvpn-devel mailing list<br=
><a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">O=
penvpn-devel@lists.sourceforge.net</a><br><a href=3D"https://lists.sourcefo=
rge.net/lists/listinfo/openvpn-devel" target=3D"_blank">https://lists.sourc=
eforge.net/lists/listinfo/openvpn-devel</a><br></font></div></blockquote></=
div></body></html>=

--===axigen=2863102795599554509940116230946434730980=axigen===--

--===axigen=2219995521518047684736865136804335244864=axigen===
Content-Type: application/octet-stream;
	name="AutoProxy.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="AutoProxy.c"

LyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioNCg0KVXRpbGl0eTogQXV0b1Byb3h5IC0gYXV0b21h
dGljYWxseSBkZXRlcm1pbmUgV2luZG93cyBQcm94eSAoZXhhbXBsZSBmb3IgT3BlblZQTikNCkF1
dGhvciA6IFIuIE1vcnJpcw0KVmVzaW9uIDogMS4wMA0KDQpSZWZlcmVuY2UgSW5mb3JtYXRpb246
DQoxKSBDKysgQ2hhcmFjdGVyIENvbnN0YW50cw0KaHR0cDovL21zZG4ubWljcm9zb2Z0LmNvbS9x
dWVyeS9kZXYxMC5xdWVyeT9hcHBJZD1EZXYxMElERUYxJmw9RU4tVVMmaz1rKEwpO2soRGV2TGFu
Zy0lMjJDJTJCJTJCJTIyKSZyZD10cnVlDQoNCjIpIFdpbkhUVFAgRnVuY3Rpb25zOg0KV2luSHR0
cE9wZW4gRnVuY3Rpb24gICAgICAgICAgICAgICAgICAgICAgICAgIDogaHR0cDovL21zZG4ubWlj
cm9zb2Z0LmNvbS9lbi11cy9saWJyYXJ5L2FhMzg0MDk4KHY9dnMuODUpLmFzcHgNCldpbkh0dHBH
ZXRQcm94eUZvclVybCBGdW5jdGlvbiAgICAgICAgICAgICAgICA6IGh0dHA6Ly9tc2RuLm1pY3Jv
c29mdC5jb20vZW4tdXMvbGlicmFyeS9hYTM4NDA5Nyh2PXZzLjg1KS5hc3B4DQoNCjIpIFdpbkhU
VFAgU3RydWN0dXJlczoNCldJTkhUVFBfQ1VSUkVOVF9VU0VSX0lFX1BST1hZX0NPTkZJRyBTdHJ1
Y3R1cmU6IGh0dHA6Ly9tc2RuLm1pY3Jvc29mdC5jb20vZW4tdXMvbGlicmFyeS9hYTM4NDI1MChW
Uy44NSkuYXNweA0KV0lOSFRUUF9BVVRPUFJPWFlfT1BUSU9OUyBTdHJ1Y3R1cmUgICAgICAgICAg
IDogaHR0cDovL21zZG4ubWljcm9zb2Z0LmNvbS9lbi11cy9saWJyYXJ5L2FhMzg0MTIzKHY9dnMu
ODUpLmFzcHgNCldJTkhUVFBfUFJPWFlfSU5GTyBTdHJ1Y3R1cmUgICAgICAgICAgICAgICAgICA6
IGh0dHA6Ly9tc2RuLm1pY3Jvc29mdC5jb20vZW4tdXMvbGlicmFyeS9hYTM4MzkxMih2PXZzLjg1
KS5hc3B4DQoNCioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8NCg0KI2luY2x1ZGUgPFdpbmRv
d3MuaD4NCiNpbmNsdWRlIDx3aW5odHRwLmg+DQojaW5jbHVkZSA8c3RkaW8uaD4NCiNpbmNsdWRl
IDxjb25pby5oPg0KI2luY2x1ZGUgPHN0cmluZy5oPg0KDQovLyBJbmNsdWRlIFdpbkhUVFAgTGli
cmFyeQ0KI3ByYWdtYSBjb21tZW50KGxpYiwgIndpbmh0dHAubGliIikNCg0Kdm9pZCBtYWluKCkN
CnsNCglMUFdTVFIgbHBzelVSTDsJCQkJCQkJCQkJCQkJLy8gTFBXU1RSOiBJbnB1dCBVUkwgKHBv
aW50ZXIgdG8gVW5pY29kZSBzdHJpbmcsIHRvIHNlYXJjaCBmb3IgUHJveHkpDQoJSElOVEVSTkVU
IGhTZXNzaW9uOwkJCQkJCQkJCQkJCS8vIEhJTlRFUk5FVDogU2Vzc2lvbiBIYW5kbGUgKGZvciBI
VFRQIE9wZW4pDQoJV0lOSFRUUF9DVVJSRU5UX1VTRVJfSUVfUFJPWFlfQ09ORklHIElFUHJveHlD
b25maWc7CQkJCS8vIFN0cnVjdHVyZTogSUUgUHJveHkgQ29uZmlndXJhdGlvbiAoZm9yIGN1cnJl
bnQgdXNlcikNCglXSU5IVFRQX0FVVE9QUk9YWV9PUFRJT05TIEF1dG9Qcm94eU9wdGlvbnM7CQkJ
CQkJLy8gU3RydWN0dXJlOiBBdXRvUHJveHkgT3B0aW9ucw0KCVdJTkhUVFBfUFJPWFlfSU5GTyBB
dXRvUHJveHlJbmZvOwkJCQkJCQkJLy8gU3RydWN0dXJlOiBXaW5IVFRQIChBdXRvKVByb3h5IElu
Zm9ybWF0aW9uDQoJQk9PTCBiVVJMUmVzdWx0OwkJCQkJCQkJCQkJCS8vIEJvb2xlYW46IFVSTCBS
ZXN1bHQgKGZyb20gR2V0IEhUVFAgUHJveHkgQ2FsbCkNCglsb25nIGVyck51bTsJCQkJCQkJCQkJ
CQkJLy8gTG9uZzogRXJyb3IgTnVtYmVyIChmcm9tIFdpbkhUVFAgQ2FsbCkNCglMUENXU1RSIGxw
c3pEZWZhdWx0VVJMID0gTCJodHRwOi8vd3d3Lm9wZW52cG4ubmV0IjsJCQkJLy8gTFBDV1NUUjog
RGVmYXVsdCBVUkwNCg0KCS8vIEdldCBpbnB1dCBmcm9tIHVzZXIgZm9yIHNpdGUgdG8gY2hlY2sg
cHJveHkgZm9yIChhcyBwcm94eSBjYW4gYmUgc2l0ZSBkZXBlbmRlbnQpDQoJbHBzelVSTCA9IChM
UFdTVFIpR2xvYmFsQWxsb2MoR01FTV9GSVhFRCwgNTEyKTsNCgl3cHJpbnRmKEwiVVJMIHRvIGNo
ZWNrIFByb3h5IGZvciBbJXNdOiAiLCBscHN6RGVmYXVsdFVSTCk7DQoJX2dldHdzX3MobHBzelVS
TCwgMjU2KTsNCg0KCXByaW50ZigiXG5TdGFydGluZyBQcm94eSBwcm9jZXNzaW5nIC4uLlxuIik7
DQoJaWYgKHdjc2xlbihscHN6VVJMKSA9PSAwKSB7DQoJCXdwcmludGYoTCIgICBFbXB0eSBVUkws
IHVzaW5nIGRlZmF1bHQgZW50cnkgWyVzXVxuIiwgbHBzekRlZmF1bHRVUkwpOw0KCQl3Y3NjcHlf
cyhscHN6VVJMLCAyNTYsIGxwc3pEZWZhdWx0VVJMKTsNCgl9DQoNCgkvLyBSZXRyZWl2ZSBJbnRl
cm5ldCBFeHBsb3JlciBQcm94eSBDb25maWd1cmF0aW9uIChmb3IgQ3VycmVudCBVc2VyKQ0KCVpl
cm9NZW1vcnkoJkF1dG9Qcm94eU9wdGlvbnMsIHNpemVvZihBdXRvUHJveHlPcHRpb25zKSk7DQoJ
WmVyb01lbW9yeSgmQXV0b1Byb3h5SW5mbywgc2l6ZW9mKEF1dG9Qcm94eUluZm8pKTsNCg0KCXBy
aW50ZigiICAgUmV0cmlldmluZyBJbnRlcm5ldCBFeHBsb3JlciBQcm94eSBDb25maWd1cmF0aW9u
IChmb3IgQ3VycmVudCBVc2VyKSAuLi5cbiIpOw0KCWlmIChXaW5IdHRwR2V0SUVQcm94eUNvbmZp
Z0ZvckN1cnJlbnRVc2VyKCZJRVByb3h5Q29uZmlnKSA9PSBUUlVFKSB7DQoNCgkJLy8gU2V0IE9w
dGlvbnMgZm9yIEludGVybmV0IEV4cGxvcmVyID0gQXV0b21hdGljYWxseSBEZXRlY3QgU2V0dGlu
Z3MgKDFzdCBQcmlvcml0eSkNCgkJaWYgKElFUHJveHlDb25maWcuZkF1dG9EZXRlY3QgPT0gVFJV
RSkgew0KCQkJcHJpbnRmKCIgICBJbnRlcm5ldCBFeHBsb3JlciBjYWxscyBmb3IgQXV0b0RldGVj
dFxuIik7DQoJCQlBdXRvUHJveHlPcHRpb25zLmR3RmxhZ3MgPSBXSU5IVFRQX0FVVE9QUk9YWV9B
VVRPX0RFVEVDVDsNCgkJCUF1dG9Qcm94eU9wdGlvbnMuZHdBdXRvRGV0ZWN0RmxhZ3MgPSBXSU5I
VFRQX0FVVE9fREVURUNUX1RZUEVfREhDUCB8IFdJTkhUVFBfQVVUT19ERVRFQ1RfVFlQRV9ETlNf
QTsNCgkJCUF1dG9Qcm94eU9wdGlvbnMuZkF1dG9Mb2dvbklmQ2hhbGxlbmdlZCA9IFRSVUU7DQoN
CgkJLy8gU2V0IE9wdGlvbnMgZm9yIEludGVybmV0IEV4cGxvcmVyID0gVXNlIEF1dG9tYXRpYyBD
b25maWd1cmF0aW9uIFNjcmlwdCAoMm5kIFByaW9yaXR5KQ0KCQl9IGVsc2UgaWYgKElFUHJveHlD
b25maWcubHBzekF1dG9Db25maWdVcmwgIT0gTlVMTCkgew0KCQkJcHJpbnRmKCIgICBJbnRlcm5l
dCBFeHBsb3JlciBjYWxscyBmb3IgQXV0byBDb25maWd1cmF0aW9uIFNjcmlwdFxuIik7DQoJCQlB
dXRvUHJveHlPcHRpb25zLmR3RmxhZ3MgPSBXSU5IVFRQX0FVVE9QUk9YWV9DT05GSUdfVVJMOw0K
CQkJQXV0b1Byb3h5T3B0aW9ucy5scHN6QXV0b0NvbmZpZ1VybCA9IElFUHJveHlDb25maWcubHBz
ekF1dG9Db25maWdVcmw7DQoJCQlBdXRvUHJveHlPcHRpb25zLmZBdXRvTG9nb25JZkNoYWxsZW5n
ZWQgPSBUUlVFOw0KDQoJCS8vIFNldCBPcHRpb25zIGZvciBJbnRlcm5ldCBFeHBsb3JlciA9IFBy
b3h5IFNlcnZlciAoM3JkIFByaW9yaXR5KQ0KCQl9IGVsc2UgaWYgKElFUHJveHlDb25maWcubHBz
elByb3h5ICE9IE5VTEwpIHsNCgkJCXByaW50ZigiICAgSW50ZXJuZXQgRXhwbG9yZXIgY2FsbHMg
Zm9yIChkZWZpbmVkKSBQcm94eSBTZXJ2ZXJcbiIpOw0KCQkJQXV0b1Byb3h5SW5mby5kd0FjY2Vz
c1R5cGUgPSBXSU5IVFRQX0FDQ0VTU19UWVBFX05BTUVEX1BST1hZOw0KCQkJQXV0b1Byb3h5SW5m
by5scHN6UHJveHkgPSBJRVByb3h5Q29uZmlnLmxwc3pQcm94eTsNCgkJCUF1dG9Qcm94eUluZm8u
bHBzelByb3h5QnlwYXNzID0gSUVQcm94eUNvbmZpZy5scHN6UHJveHlCeXBhc3M7DQoNCgkJLy8g
U2V0IE9wdGlvbnMgZm9yIEludGVybmV0IEV4cGxvcmVyID0gTm8gUHJveHkgT3B0aW9ucyBEZWZp
bmVkIChzbyBubyBwcm94eSEpDQoJCX0gZWxzZSB7DQoJCQlwcmludGYoIiAgIEludGVybmV0IEV4
cGxvcmVyIGRvZXMgbm90IGRlZmluZSBhbnkgcHJveHkgb3B0aW9uc1xuIik7DQoJCQlBdXRvUHJv
eHlJbmZvLmR3QWNjZXNzVHlwZSA9IFdJTkhUVFBfQUNDRVNTX1RZUEVfTk9fUFJPWFk7DQoJCX0N
Cg0KCX0gZWxzZSB7DQoJCS8vIFJldHJpZXZpbmcgSW50ZXJuZXQgRXhwbG9yZXIgQ29uZmlndXJh
dGlvbiBmYWlsZWQsIHNvIHRyeSBBdXRvIERldGVjdGlvbiENCgkJcHJpbnRmKCIgICBJbnRlcm5l
dCBFeHBsb3JlciBDb25maWd1cmF0aW9uIFJlYWQgRmFpbGVkIChzbyBhdHRlbXB0IEF1dG8gRGV0
ZWN0aW9uISlcbiIpOw0KCQlBdXRvUHJveHlPcHRpb25zLmR3RmxhZ3MgPSBXSU5IVFRQX0FVVE9Q
Uk9YWV9BVVRPX0RFVEVDVDsNCgkJQXV0b1Byb3h5T3B0aW9ucy5kd0F1dG9EZXRlY3RGbGFncyA9
IFdJTkhUVFBfQVVUT19ERVRFQ1RfVFlQRV9ESENQIHwgV0lOSFRUUF9BVVRPX0RFVEVDVF9UWVBF
X0ROU19BOw0KCX0NCg0KCS8vIE5vdywgcmV0cmVpdmUgUHJveHkgaW5mb3JtYXRpb24gYmFzZWQg
b24gSW50ZXJuZXQgRXhwbG9yZXIgQ29uZmlndXJhdGlvbiAoaWYgYXBwcm9wcmlhdGUpDQoJaWYg
KEF1dG9Qcm94eU9wdGlvbnMuZHdGbGFncyAhPSAwKSB7DQoNCgkJLy8gTmVlZCB0byBjcmVhdGUg
YSB0ZW1wb3JhcnkgV2luSHR0cCBzZXNzaW9uIGhhbmRsZSAtPiBOb3RlOiBwZXJmb3JtYW5jZSBv
ZiBHZXRQcm94eUluZm9Gb3JVcmwgY2FuIGJlIGltcHJvdmVkIGJ5IHNhdmluZyB0aGlzIGhTZXNz
aW9uIGhhbmRsZSBhY3Jvc3MgY2FsbHMgaW5zdGVhZCBvZiBjcmVhdGluZyBhIG5ldyBoYW5kbGUg
ZWFjaCB0aW1lDQoJCXByaW50ZigiICAgT3BlbmluZyBXaW5IVFRQIFNlc3Npb25cbiIpOw0KCQlo
U2Vzc2lvbiA9IFdpbkh0dHBPcGVuKEwiT3BlblZQTiBBdXRvUHJveHkgQ2hlY2siLCBXSU5IVFRQ
X0FDQ0VTU19UWVBFX05PX1BST1hZLCBXSU5IVFRQX05PX1BST1hZX05BTUUsIFdJTkhUVFBfTk9f
UFJPWFlfQllQQVNTLCAwKTsNCg0KCQkvLyBHZXQgUHJveHkgRGV0YWlscyBmb3IgVGFyZ2V0IFVS
TA0KCQlwcmludGYoIiAgICAgIEdldHRpbmcgUHJveHkgRGV0YWlscyBmb3IgVGFyZ2V0IFVSTCAu
Li5cbiIpOw0KCQliVVJMUmVzdWx0ID0gV2luSHR0cEdldFByb3h5Rm9yVXJsKGhTZXNzaW9uLCBs
cHN6VVJMLCAmQXV0b1Byb3h5T3B0aW9ucywgJkF1dG9Qcm94eUluZm8pOw0KDQoJCS8vIEV2YWx1
YXRlIFJlc3VsdHMgZnJvbSBVUkwgU3BlY2lmaWMgUHJveHkgY2hlY2sNCgkJaWYgKGJVUkxSZXN1
bHQgPT0gVFJVRSkgew0KCQkJLy8gU3VjY2Vzc2Z1bCwgcmV0cmlldmUgUHJveHkgZGV0YWlscw0K
CQkJCXByaW50ZigiICAgICAgUHJveHkgUXVlcnkgU3VjY2Vzc2Z1bCwgUmV0cmlldmVkIFByb3h5
IGZvciBVUkwhXG4iKTsNCgkJfSBlbHNlIHsNCg0KCQkJLy8gUHJveHkgcmV0cmVpdmFsIGZhaWxl
ZCwgc28gZ2V0IGVycm9yIG51bWJlciAodG8gZGV0ZXJtaW5lIHdoeSBpdCBmYWlsZWQpIC4uLiBh
bmQgc2V0IGZvciBubyBQcm94eSAoYXMgY2FsbCBmYWlsZWQpDQoJCQlwcmludGYoIiAgICAgIFBy
b3h5IFF1ZXJ5IGZhaWxlZCwgcmV0cmVpdmUgRXJyb3IgQ29kZVxuIik7DQoJCQllcnJOdW0gPSBH
ZXRMYXN0RXJyb3IoKTsNCgkJCUF1dG9Qcm94eUluZm8uZHdBY2Nlc3NUeXBlID0gV0lOSFRUUF9B
Q0NFU1NfVFlQRV9OT19QUk9YWTsNCg0KCQkJLy8gQW5kIGRpc3BsYXkgZXJyb3IgaW5mb3JtYXRp
b24gKHRvIGV4YW1pbmUgd2h5IGl0IGZhaWxlZCkNCgkJCXByaW50ZigiICAgICAgV2luSFRUUEdl
dFByb3h5Rm9yVVJMIEVycm9yOiAiKTsNCgkJCXN3aXRjaCAoZXJyTnVtKSB7DQoJCQkJY2FzZSBF
UlJPUl9XSU5IVFRQX0FVVE9fUFJPWFlfU0VSVklDRV9FUlJPUjoNCgkJCQkJcHJpbnRmKCJFUlJP
Ul9XSU5IVFRQX0FVVE9fUFJPWFlfU0VSVklDRV9FUlJPUlxuIik7DQoJCQkJCWJyZWFrOw0KCQkJ
CWNhc2UgRVJST1JfV0lOSFRUUF9CQURfQVVUT19QUk9YWV9TQ1JJUFQ6DQoJCQkJCXByaW50Zigi
RVJST1JfV0lOSFRUUF9CQURfQVVUT19QUk9YWV9TQ1JJUFRcbiIpOw0KCQkJCQlicmVhazsNCgkJ
CQljYXNlIEVSUk9SX1dJTkhUVFBfSU5DT1JSRUNUX0hBTkRMRV9UWVBFOg0KCQkJCQlwcmludGYo
IkVSUk9SX1dJTkhUVFBfSU5DT1JSRUNUX0hBTkRMRV9UWVBFXG4iKTsNCgkJCQkJYnJlYWs7DQoJ
CQkJY2FzZSBFUlJPUl9XSU5IVFRQX0lOVEVSTkFMX0VSUk9SOg0KCQkJCQlwcmludGYoIkVSUk9S
X1dJTkhUVFBfSU5URVJOQUxfRVJST1JcbiIpOw0KCQkJCQlicmVhazsNCgkJCQljYXNlIEVSUk9S
X1dJTkhUVFBfSU5WQUxJRF9VUkw6DQoJCQkJCXByaW50ZigiRVJST1JfV0lOSFRUUF9JTlZBTElE
X1VSTFxuIik7DQoJCQkJCWJyZWFrOw0KCQkJCWNhc2UgRVJST1JfV0lOSFRUUF9MT0dJTl9GQUlM
VVJFOg0KCQkJCQlwcmludGYoIkVSUk9SX1dJTkhUVFBfTE9HSU5fRkFJTFVSRVxuIik7DQoJCQkJ
CWJyZWFrOw0KCQkJCWNhc2UgRVJST1JfV0lOSFRUUF9PUEVSQVRJT05fQ0FOQ0VMTEVEOg0KCQkJ
CQlwcmludGYoIkVSUk9SX1dJTkhUVFBfT1BFUkFUSU9OX0NBTkNFTExFRFxuIik7DQoJCQkJCWJy
ZWFrOw0KCQkJCWNhc2UgRVJST1JfV0lOSFRUUF9VTkFCTEVfVE9fRE9XTkxPQURfU0NSSVBUOg0K
CQkJCQlwcmludGYoIkVSUk9SX1dJTkhUVFBfVU5BQkxFX1RPX0RPV05MT0FEX1NDUklQVFxuIik7
DQoJCQkJCWJyZWFrOw0KCQkJCWNhc2UgRVJST1JfV0lOSFRUUF9VTlJFQ09HTklaRURfU0NIRU1F
Og0KCQkJCQlwcmludGYoIkVSUk9SX1dJTkhUVFBfVU5SRUNPR05JWkVEX1NDSEVNRVxuIik7DQoJ
CQkJCWJyZWFrOw0KCQkJCWNhc2UgRVJST1JfTk9UX0VOT1VHSF9NRU1PUlk6DQoJCQkJCXByaW50
ZigiRVJST1JfTk9UX0VOT1VHSF9NRU1PUllcbiIpOw0KCQkJCQlicmVhazsNCgkJCX0NCg0KCQl9
DQoNCgkJLy8gQ2xvc2UgV2luSFRUUCBTZXNzaW9uDQoJCXByaW50ZigiICAgQ2xvc2luZyBXaW5I
VFRQIFNlc3Npb25cbiIpOw0KCQlXaW5IdHRwQ2xvc2VIYW5kbGUoaFNlc3Npb24pOw0KCX0NCg0K
CS8vIFByaW50IFN1bW1hcnkgSW5mb3JtYXRpb24gKGkuZS4gUHJveHkgZGV0YWlscykNCglwcmlu
dGYoIlxuUHJveHkgRGV0YWlscyAoZGV0ZXJtaW5lZCBieSByb3V0aW5lKTpcbiIpOw0KCXByaW50
ZigiICAgUHJveHkgVHlwZTogIik7DQoJc3dpdGNoIChBdXRvUHJveHlJbmZvLmR3QWNjZXNzVHlw
ZSkgew0KCQljYXNlIFdJTkhUVFBfQUNDRVNTX1RZUEVfREVGQVVMVF9QUk9YWToNCgkJCXByaW50
ZigiV0lOSFRUUF9BQ0NFU1NfVFlQRV9ERUZBVUxUX1BST1hZXG4iKTsNCgkJCXdwcmludGYoTCIg
ICBQcm94eTogJXNcbiIsIEF1dG9Qcm94eUluZm8ubHBzelByb3h5KTsNCgkJCXdwcmludGYoTCIg
ICBQcm94eSBCeXBhc3M6ICVzXG4iLCBBdXRvUHJveHlJbmZvLmxwc3pQcm94eUJ5cGFzcyk7DQoJ
CQlicmVhazsNCgkJY2FzZSBXSU5IVFRQX0FDQ0VTU19UWVBFX05PX1BST1hZOg0KCQkJcHJpbnRm
KCJXSU5IVFRQX0FDQ0VTU19UWVBFX05PX1BST1hZXG4iKTsNCgkJCWJyZWFrOw0KCQljYXNlIFdJ
TkhUVFBfQUNDRVNTX1RZUEVfTkFNRURfUFJPWFk6DQoJCQlwcmludGYoIldJTkhUVFBfQUNDRVNT
X1RZUEVfTkFNRURfUFJPWFlcbiIpOw0KCQkJd3ByaW50ZihMIiAgIFByb3h5OiAlc1xuIiwgQXV0
b1Byb3h5SW5mby5scHN6UHJveHkpOw0KCQkJd3ByaW50ZihMIiAgIFByb3h5IEJ5cGFzczogJXNc
biIsIEF1dG9Qcm94eUluZm8ubHBzelByb3h5QnlwYXNzKTsNCgkJCWJyZWFrOw0KCX0NCg0KCS8v
IEZyZWUgdXAgTWVtb3J5IEFsbG9jYXRlZCBkdXJpbmcgdGhlIFByb3h5IERldGVjdGlvbiBwcm9j
ZXNzDQoJcHJpbnRmKCJcblByb3h5IERldGVjdGlvbiBjb21wbGV0ZWQhXG4iKTsNCglwcmludGYo
IkZyZWVpbmcgdXAgTWVtb3J5IEFsbG9jYXRlZCBkdXJpbmcgdGhlIFByb3h5IERldGVjdGlvbiBQ
cm9jZXNzIC4uLlxuIik7DQoJaWYgKElFUHJveHlDb25maWcubHBzekF1dG9Db25maWdVcmwgIT0g
TlVMTCkgR2xvYmFsRnJlZShJRVByb3h5Q29uZmlnLmxwc3pBdXRvQ29uZmlnVXJsKTsNCglpZiAo
SUVQcm94eUNvbmZpZy5scHN6UHJveHkgIT0gTlVMTCkgR2xvYmFsRnJlZShJRVByb3h5Q29uZmln
Lmxwc3pQcm94eSk7DQoJaWYgKElFUHJveHlDb25maWcubHBzelByb3h5QnlwYXNzICE9IE5VTEwp
IEdsb2JhbEZyZWUoSUVQcm94eUNvbmZpZy5scHN6UHJveHlCeXBhc3MpOw0KCWlmIChBdXRvUHJv
eHlJbmZvLmxwc3pQcm94eSAhPSBOVUxMKSAgR2xvYmFsRnJlZShBdXRvUHJveHlJbmZvLmxwc3pQ
cm94eSk7DQoJaWYgKEF1dG9Qcm94eUluZm8ubHBzelByb3h5QnlwYXNzICE9IE5VTEwpIEdsb2Jh
bEZyZWUoQXV0b1Byb3h5SW5mby5scHN6UHJveHlCeXBhc3MpOw0KCUdsb2JhbEZyZWUobHBzelVS
TCk7DQoJcHJpbnRmKCJNZW1vcnkgZGVhbGxvY2F0aW9uIHByb2Nlc3NpbmcgY29tcGxldGVkXG5c
biIpOw0KDQoJLy8gQW5kIGV4aXQgKGxldHRpbmcgdGhlIHVzZXIgc2VlIHRoZSBpbmZvIGZpcnN0
KQ0KCXByaW50ZiAoIlxuUHJlc3MgYW55IGtleSB0byBleGl0IC4uLiIpOw0KCV9nZXRjaCgpOw0K
fQ0KDQo=

--===axigen=2219995521518047684736865136804335244864=axigen===--


