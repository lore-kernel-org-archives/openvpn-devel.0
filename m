MIME-Version: 1.0
References: <CAC8x_z0gMKW1b33J3HGL-9pQnXgpf9O6pRu+M2=xP03JyJMm6g@...278...>
 <ZzZvEOjQ4PQ3gF-2@...1296...>
 <CAC8x_z3reFPQWPNuoB-GjqkQtEgcgGapHWKUVt=OXvMoW6NCFg@...278...>
 <7df02e11-336f-4738-8221-65d1dcde0659@...515...>
 <CAC8x_z1gynaP2NHBr8HF0asnZs_ZUmGQSaFxsnbdjCuukhrS0Q@...278...>
 <197129c7-73dd-470e-9a94-7abd1b8ae19a@...1227...>
 <CAC8x_z3CdbCPnpUis7URYbQohjBy4i0z1DD75qSWPdjbWuy3XA@...278...>
 <1cc349fa-cfe3-4b83-aa1e-d941ef9e5509@...2722...>
 <CAC8x_z1VvtHiB_Op7oD7xRTpVSUvefd3j1S=GKQYrxYTm4kscA@...278...>
 <9CbaYxoBHtEVLK-grSiz5jF3BIbqX9Sitzeet8RqF8GXL7Hv4BHdtdCAVEcBKdnM61OROzbjTALjF7NlvuuMJT-hHau7GUySueWeNzV0DaU=@protonmail.com>
In-Reply-To: <9CbaYxoBHtEVLK-grSiz5jF3BIbqX9Sitzeet8RqF8GXL7Hv4BHdtdCAVEcBKdnM61OROzbjTALjF7NlvuuMJT-hHau7GUySueWeNzV0DaU=@protonmail.com>
From: =?UTF-8?B?16DXqteZINep15jXqNef?= <nsh531@...277...>
Date: Sun, 17 Nov 2024 06:33:33 +0200
Message-ID: <CAC8x_z0U6ZpPpduqmCnEXJN=aFrajMCnFmzX5U58+Y3ToCmyNw@...278...>
Content-Type: multipart/alternative; boundary="000000000000209e610627144e8c"
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
To: tincantech <tincantech@...2282...>
Cc: Johan Draaisma <johan@...2722...>, Antonio Quartulli <antonio@...515...>, Openvpn-devel@lists.sourceforge.net, SECURITY@...515...

--000000000000209e610627144e8c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the tip!

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=90=D7=
=B3, 17 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-6:24 =D7=9E=D7=90=D7=AA =
=E2=80=AAtincantech=E2=80=AC=E2=80=8F <=E2=80=AA
tincantech@...2282...=E2=80=AC=E2=80=8F>:=E2=80=AC

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> Hi nsh531@...277...
>
> It is common procedure to keep security concerns to the security@ mailing
> list.
>
> To have your concerns expertly reviewed, it is advisable to follow standa=
rd
> security and disclosure procedures.
>
> While this thread is, no doubt, amusing .. it is unnecessary noise on this
> list.
>
> Please ensure that you know who you are sending your emails to, in future.
>
> Peace and light
> tct
>
> Sent with Proton Mail secure email.
>
> On Sunday, 17 November 2024 at 03:48, =D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=
=A8=D7=9F <nsh531@...277...> wrote:
>
> > Hi' i sent fully logs :
> >
> >
> > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=90=
=D7=B3, 17 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-3:03 =D7=9E=D7=90=D7=
=AA =E2=80=AAJohan Draaisma=E2=80=AC=E2=80=8F <=E2=80=AA
> johan@...2722...=E2=80=AC=E2=80=8F>:=E2=80=AC
> >
> > > Hello Natanel/Netanel,
> > >
> > > We still don't see the issue, exponential backoff is how this type of
> situation is handled in other common protocols too, it is a not a security
> vulnerability. And just in case someone messes with the client side and
> tries endlessly reconnecting much faster in an attempt to stress the
> server, we also have other defenses in place.
> > >
> > > You also appear to be confusing server-side behavior with client-side
> behavior. What you are writing is that when the client is having a problem
> with the TLS handshake, that the server automatically restarts, as in, the
> process stops and is restarted. That is simply not true. If it were true =
it
> would mean failed TLS handshakes from one client would affect all other
> connected clients too, and that's something we don't see happening. But if
> you have proof that says otherwise, show it to us with verbatim log lines,
> and a way to reproduce it that includes version of client and server
> software used (and please, supported versions only, not versions from 8
> years ago), client and server configurations, and the steps to reach this
> supposedly problematic state. My guess however is that you are
> misinterpreting the message that the client is going to do a restart of t=
he
> connection, which would likely be visible in the server logs, and would be
> expected and normal.
> > >
> > > Yes, there is theoretical potential to exhaust server resources from
> repeatedly hammering the server with failing connections, as is the case
> with many network programs. But we have various defenses in place for tha=
t.
> Currently with the description given I don't believe you have found
> something that broke through those defenses. But I could be wrong. But if
> so, I want to see proof, not just a story. You write that the server is
> automatically restarting in response to multiple failed TLS handshakes.
> Show us the evidence please.
> > >
> > > Until then, we don't have anything to go on, sorry.
> > >
> > > Kind regards,
> > > Johan Draaisma
> > >
> > > On 16-11-2024 17:22, =D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=D7=9F wrot=
e:
> > >
> > > > Hi,
> > > > it's same on 2.6 version:
> > > >
> > > > Subject: Possible DoS Vulnerability - OpenVPN Server Showing
> Repeated TLS Handshake Failures
> > > >
> > > > Dear OpenVPN Security Team,
> > > >
> > > > I am writing to report a potential vulnerability to
> Denial-of-Service (DoS) attacks that I have observed in an OpenVPN server=
's
> logs. The server is exhibiting consistent TLS handshake failures, resulti=
ng
> in repeated process restarts. While the exact cause isn't immediately
> apparent, the symptoms strongly suggest a vulnerability to an attack vect=
or
> that overwhelms the server with unsuccessful connection attempts.
> > > >
> > > > The logs demonstrate repeated errors of the form: "TLS key
> negotiation failed to occur within 5 seconds (check your network
> connectivity)" and "TLS handshake failed," followed by automatic server
> restarts. The server appears to be attempting to mitigate by increasing t=
he
> restart delay with each failure, but this is only a temporary workaround,
> and the underlying issue persists.
> > > >
> > > > The observed behavior is highly suggestive of a DoS attack, where an
> attacker is attempting to exhaust server resources by triggering multiple
> failed TLS handshakes. This, along with the server automatically restarti=
ng
> in response, suggests a DoS mitigation procedure is in place that can only
> temporarily avoid service outages.
> > > >
> > > > While I do not have direct access to the server configuration or the
> full scope of logs, I believe the behavior described poses a significant
> security risk. I have attached the partial log file demonstrating the
> repeated errors.
> > > >
> > > > I would greatly appreciate it if you could investigate this
> potential vulnerability and provide any guidance or recommendations for
> strengthening the server's resilience against this type of attack. If
> further information is needed, please do not hesitate to ask.
> > > >
> > > > Sincerely,
> > > >
> > > > Netanel
> > > >
> > > >
> > > >
> > > >
> > > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =
=D7=95=D7=B3, 15 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-17:30 =D7=9E=D7=
=90=D7=AA =E2=80=AAArne Schwabe=E2=80=AC=E2=80=8F <=E2=80=AA
> arne@...1227...=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > >
> > > > > Am 15.11.24 um 13:56 schrieb =D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=
=A8=D7=9F:
> > > > > > I pentested openvpn 2.4 on client and I need to write cve on TLS
> Key
> > > > > > Negotiation Timeout Leading to DoS on 2.4 version
> > > > >
> > > > >
> > > > > You are free to publish your finding but they do not qualify for a
> CVE
> > > > > for two reasons
> > > > >
> > > > > - currently only proven that an EOL version affected
> > > > > - the reported behaviour is expected behaviour and we do not see
> any
> > > > > security problems/implication in that behaviour, so no security
> problem,
> > > > > no CVE.
> > > >
> > > >
> > > >
> > > > --
> >
> >
> >
> > --
> -----BEGIN PGP SIGNATURE-----
> Version: ProtonMail
>
> wsBzBAEBCAAnBYJnOW/aCZBPl5z2a5C4nRYhBAm8PURno41yecVVVU+XnPZr
> kLidAADJqgf/fP+US1O0sV88Ui7MjEiaOUPyneyB5A1REmGnON+8Wr1rYngi
> EZ+fN/t+ro1F5oVN3r+Y+DrrxQY6sy3C1p62CjcVcu3ogeHtPvpzprcpq6QV
> GNl0hp5jg58T7yUyKFD4XPQJoiRBRr4TPnjP8Xa6O3D1KvcU0n22Xa3R/FxC
> pCIjeFgcSkqnjrCCmVqQ7cyS4WZ42Sfq1a/ijsq/RWoUX04Afuatyr0qB3fE
> EdVUZuzPic0HTA/zrxbnj2Bnv3J05euWROPzVmqpMGqVokKXboN8/N/AyPQb
> NZGlV8tierETQvnt/5x6fCM87psCF0K73S8YTbQ/dLfS+7wL2PLlGg=3D=3D
> =3Dc6Lz
> -----END PGP SIGNATURE-----
>


--=20
<https://netanel.ml>

--000000000000209e610627144e8c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"rtl">Thanks for the tip!=C2=A0</div><br><div class=3D"gmail_quo=
te"><div dir=3D"rtl" class=3D"gmail_attr">=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=
=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=90=D7=B3, 17 =D7=91=D7=A0=D7=95=D7=91=
=D7=B3 2024 =D7=91-6:24 =D7=9E=D7=90=D7=AA =E2=80=AAtincantech=E2=80=AC=E2=
=80=8F &lt;=E2=80=AA<a href=3D"mailto:tincantech@...2282...">tincantech@...493...=
2282...</a>=E2=80=AC=E2=80=8F&gt;:=E2=80=AC<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">-----BEGIN PGP SIGNED MESSAGE-----<br>
Hash: SHA256<br>
<br>
Hi <a href=3D"mailto:nsh531@...277..." target=3D"_blank">nsh531@...277...</=
a><br>
<br>
It is common procedure to keep security concerns to the security@ mailing l=
ist.<br>
<br>
To have your concerns expertly reviewed, it is advisable to follow standard=
<br>
security and disclosure procedures.<br>
<br>
While this thread is, no doubt, amusing .. it is unnecessary noise on this =
list.<br>
<br>
Please ensure that you know who you are sending your emails to, in future.<=
br>
<br>
Peace and light<br>
tct<br>
<br>
Sent with Proton Mail secure email.<br>
<br>
On Sunday, 17 November 2024 at 03:48, =D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=
=D7=9F &lt;<a href=3D"mailto:nsh531@...277..." target=3D"_blank">nsh531@...493...=
277...</a>&gt; wrote:<br>
<br>
&gt; Hi&#39; i sent fully logs :<br>
&gt; <br>
&gt; <br>
&gt; =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=
=90=D7=B3, 17 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-3:03 =D7=9E=D7=90=
=D7=AA =E2=80=AAJohan Draaisma=E2=80=AC=E2=80=8F &lt;=E2=80=AA<a href=3D"ma=
ilto:johan@...2722..." target=3D"_blank">johan@...2722...</a>=E2=80=AC=E2=
=80=8F&gt;:=E2=80=AC<br>
&gt; <br>
&gt; &gt; Hello Natanel/Netanel,<br>
&gt; &gt; <br>
&gt; &gt; We still don&#39;t see the issue, exponential backoff is how this=
 type of situation is handled in other common protocols too, it is a not a =
security vulnerability. And just in case someone messes with the client sid=
e and tries endlessly reconnecting much faster in an attempt to stress the =
server, we also have other defenses in place.<br>
&gt; &gt; <br>
&gt; &gt; You also appear to be confusing server-side behavior with client-=
side behavior. What you are writing is that when the client is having a pro=
blem with the TLS handshake, that the server automatically restarts, as in,=
 the process stops and is restarted. That is simply not true. If it were tr=
ue it would mean failed TLS handshakes from one client would affect all oth=
er connected clients too, and that&#39;s something we don&#39;t see happeni=
ng. But if you have proof that says otherwise, show it to us with verbatim =
log lines, and a way to reproduce it that includes version of client and se=
rver software used (and please, supported versions only, not versions from =
8 years ago), client and server configurations, and the steps to reach this=
 supposedly problematic state. My guess however is that you are misinterpre=
ting the message that the client is going to do a restart of the connection=
, which would likely be visible in the server logs, and would be expected a=
nd normal.<br>
&gt; &gt; <br>
&gt; &gt; Yes, there is theoretical potential to exhaust server resources f=
rom repeatedly hammering the server with failing connections, as is the cas=
e with many network programs. But we have various defenses in place for tha=
t. Currently with the description given I don&#39;t believe you have found =
something that broke through those defenses. But I could be wrong. But if s=
o, I want to see proof, not just a story. You write that the server is auto=
matically restarting in response to multiple failed TLS handshakes. Show us=
 the evidence please.<br>
&gt; &gt; <br>
&gt; &gt; Until then, we don&#39;t have anything to go on, sorry.<br>
&gt; &gt; <br>
&gt; &gt; Kind regards,<br>
&gt; &gt; Johan Draaisma<br>
&gt; &gt; <br>
&gt; &gt; On 16-11-2024 17:22, =D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=D7=9F =
wrote:<br>
&gt; &gt; <br>
&gt; &gt; &gt; Hi,<br>
&gt; &gt; &gt; it&#39;s same on 2.6 version:<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Subject: Possible DoS Vulnerability - OpenVPN Server Showing=
 Repeated TLS Handshake Failures<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Dear OpenVPN Security Team,<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; I am writing to report a potential vulnerability to Denial-o=
f-Service (DoS) attacks that I have observed in an OpenVPN server&#39;s log=
s. The server is exhibiting consistent TLS handshake failures, resulting in=
 repeated process restarts. While the exact cause isn&#39;t immediately app=
arent, the symptoms strongly suggest a vulnerability to an attack vector th=
at overwhelms the server with unsuccessful connection attempts.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; The logs demonstrate repeated errors of the form: &quot;TLS =
key negotiation failed to occur within 5 seconds (check your network connec=
tivity)&quot; and &quot;TLS handshake failed,&quot; followed by automatic s=
erver restarts. The server appears to be attempting to mitigate by increasi=
ng the restart delay with each failure, but this is only a temporary workar=
ound, and the underlying issue persists.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; The observed behavior is highly suggestive of a DoS attack, =
where an attacker is attempting to exhaust server resources by triggering m=
ultiple failed TLS handshakes. This, along with the server automatically re=
starting in response, suggests a DoS mitigation procedure is in place that =
can only temporarily avoid service outages.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; While I do not have direct access to the server configuratio=
n or the full scope of logs, I believe the behavior described poses a signi=
ficant security risk. I have attached the partial log file demonstrating th=
e repeated errors.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; I would greatly appreciate it if you could investigate this =
potential vulnerability and provide any guidance or recommendations for str=
engthening the server&#39;s resilience against this type of attack. If furt=
her information is needed, please do not hesitate to ask.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Sincerely,<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Netanel<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=
=D7=9D =D7=95=D7=B3, 15 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-17:30 =
=D7=9E=D7=90=D7=AA =E2=80=AAArne Schwabe=E2=80=AC=E2=80=8F &lt;=E2=80=AA<a =
href=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1227...</a>=E2=80=
=AC=E2=80=8F&gt;:=E2=80=AC<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Am 15.11.24 um 13:56 schrieb =D7=A0=D7=AA=D7=99 =D7=A9=
=D7=98=D7=A8=D7=9F:<br>
&gt; &gt; &gt; &gt; &gt; I pentested openvpn 2.4 on client and I need to wr=
ite cve on TLS Key<br>
&gt; &gt; &gt; &gt; &gt; Negotiation Timeout Leading to DoS on 2.4 version<=
br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; You are free to publish your finding but they do not qu=
alify for a CVE<br>
&gt; &gt; &gt; &gt; for two reasons<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; - currently only proven that an EOL version affected<br>
&gt; &gt; &gt; &gt; - the reported behaviour is expected behaviour and we d=
o not see any<br>
&gt; &gt; &gt; &gt; security problems/implication in that behaviour, so no =
security problem,<br>
&gt; &gt; &gt; &gt; no CVE.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; --<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; --<br>
-----BEGIN PGP SIGNATURE-----<br>
Version: ProtonMail<br>
<br>
wsBzBAEBCAAnBYJnOW/aCZBPl5z2a5C4nRYhBAm8PURno41yecVVVU+XnPZr<br>
kLidAADJqgf/fP+US1O0sV88Ui7MjEiaOUPyneyB5A1REmGnON+8Wr1rYngi<br>
EZ+fN/t+ro1F5oVN3r+Y+DrrxQY6sy3C1p62CjcVcu3ogeHtPvpzprcpq6QV<br>
GNl0hp5jg58T7yUyKFD4XPQJoiRBRr4TPnjP8Xa6O3D1KvcU0n22Xa3R/FxC<br>
pCIjeFgcSkqnjrCCmVqQ7cyS4WZ42Sfq1a/ijsq/RWoUX04Afuatyr0qB3fE<br>
EdVUZuzPic0HTA/zrxbnj2Bnv3J05euWROPzVmqpMGqVokKXboN8/N/AyPQb<br>
NZGlV8tierETQvnt/5x6fCM87psCF0K73S8YTbQ/dLfS+7wL2PLlGg=3D=3D<br>
=3Dc6Lz<br>
-----END PGP SIGNATURE-----<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"rtl" class=3D"gmail_s=
ignature"><div dir=3D"rtl"><a href=3D"https://netanel.ml" target=3D"_blank"=
><img width=3D"200" height=3D"51" src=3D"https://ci3.googleusercontent.com/=
mail-sig/AIorK4y1ahZg0mqH5UnDCjKIkW6FTSni5R5bezS1idSRECO6GXQ1uH3RgELXk8RqqC=
oNk3985_jsnIQnnclo"></a></div></div>

--000000000000209e610627144e8c--

