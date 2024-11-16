MIME-Version: 1.0
References: <CAC8x_z0gMKW1b33J3HGL-9pQnXgpf9O6pRu+M2=xP03JyJMm6g@...278...>
 <ZzZvEOjQ4PQ3gF-2@...1296...>
 <CAC8x_z3reFPQWPNuoB-GjqkQtEgcgGapHWKUVt=OXvMoW6NCFg@...278...>
 <7df02e11-336f-4738-8221-65d1dcde0659@...515...>
 <CAC8x_z1gynaP2NHBr8HF0asnZs_ZUmGQSaFxsnbdjCuukhrS0Q@...278...>
 <197129c7-73dd-470e-9a94-7abd1b8ae19a@...1227...>
In-Reply-To: <197129c7-73dd-470e-9a94-7abd1b8ae19a@...1227...>
From: =?UTF-8?B?16DXqteZINep15jXqNef?= <nsh531@...277...>
Date: Sat, 16 Nov 2024 18:22:07 +0200
Message-ID: <CAC8x_z3CdbCPnpUis7URYbQohjBy4i0z1DD75qSWPdjbWuy3XA@...278...>
Content-Type: multipart/alternative; boundary="0000000000005531d906270a16d9"
Subject: Re: [Openvpn-devel] Subject: OpenVPN Client Vulnerability - TLS Key
 Negotiation Timeout Leading to DoS (Black Box Pentest)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, Openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <antonio@...515...>, SECURITY@...515...

--0000000000005531d906270a16d9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
it's same on 2.6 version:

Subject: Possible DoS Vulnerability - OpenVPN Server Showing Repeated TLS
Handshake Failures

Dear OpenVPN Security Team,

I am writing to report a potential vulnerability to Denial-of-Service (DoS)
attacks that I have observed in an OpenVPN server's logs. The server is
exhibiting consistent TLS handshake failures, resulting in repeated process
restarts. While the exact cause isn't immediately apparent, the symptoms
strongly suggest a vulnerability to an attack vector that overwhelms the
server with unsuccessful connection attempts.

The logs demonstrate repeated errors of the form: "TLS key negotiation
failed to occur within 5 seconds (check your network connectivity)" and
"TLS handshake failed," followed by automatic server restarts. The server
appears to be attempting to mitigate by increasing the restart delay with
each failure, but this is only a temporary workaround, and the underlying
issue persists.

The observed behavior is highly suggestive of a DoS attack, where an
attacker is attempting to exhaust server resources by triggering multiple
failed TLS handshakes. This, along with the server automatically restarting
in response, suggests a DoS mitigation procedure is in place that can only
temporarily avoid service outages.

While I do not have direct access to the server configuration or the full
scope of logs, I believe the behavior described poses a significant
security risk. I have attached the partial log file demonstrating the
repeated errors.

I would greatly appreciate it if you could investigate this potential
vulnerability and provide any guidance or recommendations for strengthening
the server's resilience against this type of attack. If further information
is needed, please do not hesitate to ask.

Sincerely,

Netanel



=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=95=D7=
=B3, 15 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-17:30 =D7=9E=D7=90=D7=AA=
 =E2=80=AAArne Schwabe=E2=80=AC=E2=80=8F <=E2=80=AAarne@...1227...
=E2=80=AC=E2=80=8F>:=E2=80=AC

> Am 15.11.24 um 13:56 schrieb =D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=D7=9F:
> > I pentested openvpn 2.4 on client and I need to write cve on TLS Key
> > Negotiation Timeout Leading to DoS on 2.4 version
>
>
> You are free to publish your finding but they do not qualify for a CVE
> for two reasons
>
> - currently only proven that an EOL version affected
> - the reported behaviour is expected behaviour and we do not see any
> security problems/implication in that behaviour, so no security problem,
> no CVE.
>


--=20
<https://netanel.ml>

--0000000000005531d906270a16d9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"rtl"><div dir=3D"ltr">Hi,</div><div dir=3D"ltr">it&#39;s same o=
n 2.6 version:</div><div dir=3D"ltr"><span class=3D"gmail-router-outlet-wra=
pper gmail-ng-tns-c3206557060-0"><p class=3D"gmail-ng-star-inserted"><span>=
<span class=3D"gmail-ng-star-inserted">Subject: Possible DoS Vulnerability =
- OpenVPN Server Showing Repeated TLS Handshake Failures</span></span></p><=
p class=3D"gmail-ng-star-inserted"><span><span class=3D"gmail-ng-star-inser=
ted">Dear OpenVPN Security Team,</span></span></p><p class=3D"gmail-ng-star=
-inserted"><span><span class=3D"gmail-ng-star-inserted">I
 am writing to report a potential vulnerability to Denial-of-Service=20
(DoS) attacks that I have observed in an OpenVPN server&#39;s logs.  The=20
server is exhibiting consistent TLS handshake failures, resulting in=20
repeated process restarts.  While the exact cause isn&#39;t immediately=20
apparent, the symptoms strongly suggest a vulnerability to an attack=20
vector that overwhelms the server with unsuccessful connection attempts.</s=
pan></span></p><p class=3D"gmail-ng-star-inserted"><span><span class=3D"gma=
il-ng-star-inserted">The
 logs demonstrate repeated errors of the form: &quot;TLS key negotiation=20
failed to occur within 5 seconds (check your network connectivity)&quot; an=
d=20
&quot;TLS handshake failed,&quot; followed by automatic server restarts.  T=
he=20
server appears to be attempting to mitigate by increasing the restart=20
delay with each failure, but this is only a temporary workaround, and=20
the underlying issue persists.</span></span></p><p class=3D"gmail-ng-star-i=
nserted"><span><span class=3D"gmail-ng-star-inserted">The
 observed behavior is highly suggestive of a DoS attack, where an=20
attacker is attempting to exhaust server resources by triggering=20
multiple failed TLS handshakes. This, along with the server=20
automatically restarting in response, suggests a DoS mitigation=20
procedure is in place that can only temporarily avoid service outages.</spa=
n></span></p><p class=3D"gmail-ng-star-inserted"><span><span class=3D"gmail=
-ng-star-inserted">While
 I do not have direct access to the server configuration or the full=20
scope of logs,  I believe the behavior described poses a significant=20
security risk.  I have attached the partial log file demonstrating the=20
repeated errors.</span></span></p><p class=3D"gmail-ng-star-inserted"><span=
><span class=3D"gmail-ng-star-inserted">I
 would greatly appreciate it if you could investigate this potential=20
vulnerability and provide any guidance or recommendations for=20
strengthening the server&#39;s resilience against this type of attack.  If=
=20
further information is needed, please do not hesitate to ask.</span></span>=
</p><p class=3D"gmail-ng-star-inserted"><span><span class=3D"gmail-ng-star-=
inserted">Sincerely,</span></span></p><p class=3D"gmail-ng-star-inserted"><=
span><span class=3D"gmail-ng-star-inserted">Netanel</span></span></p><p cla=
ss=3D"gmail-ng-star-inserted"><span><span class=3D"gmail-ng-star-inserted">=
<br></span></span></p></span></div></div><br><div class=3D"gmail_quote"><di=
v dir=3D"rtl" class=3D"gmail_attr">=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=
=D7=9A =D7=99=D7=95=D7=9D =D7=95=D7=B3, 15 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2=
024 =D7=91-17:30 =D7=9E=D7=90=D7=AA =E2=80=AAArne Schwabe=E2=80=AC=E2=80=8F=
 &lt;=E2=80=AA<a href=3D"mailto:arne@...1227...">arne@...1227...</a>=E2=80=
=AC=E2=80=8F&gt;:=E2=80=AC<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Am 15.11.24 um 13:56 schrieb =D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=
=A8=D7=9F:<br>
&gt; I pentested=C2=A0openvpn 2.4 on client and I need to write cve on TLS =
Key <br>
&gt; Negotiation Timeout Leading to DoS on 2.4=C2=A0version<br>
<br>
<br>
You are free to publish your finding but they do not qualify for a CVE <br>
for two reasons<br>
<br>
- currently only proven that an EOL version affected<br>
- the reported behaviour is expected behaviour and we do not see any <br>
security problems/implication in that behaviour, so no security problem, <b=
r>
no CVE.<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"rtl" class=3D"gmail_signature"><d=
iv dir=3D"rtl"><a href=3D"https://netanel.ml" target=3D"_blank"><img width=
=3D"200" height=3D"51" src=3D"https://ci3.googleusercontent.com/mail-sig/AI=
orK4y1ahZg0mqH5UnDCjKIkW6FTSni5R5bezS1idSRECO6GXQ1uH3RgELXk8RqqCoNk3985_jsn=
IQnnclo"></a></div></div>

--0000000000005531d906270a16d9--

