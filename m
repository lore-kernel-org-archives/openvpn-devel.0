MIME-Version: 1.0
References: <CAC8x_z10PT_ToTzVUKQENA5ZJgJ4EMvBJARphDR5_wdytA2JSw@...278...>
 <b7c9a1ac-3322-4eeb-befd-e19c7f72da6b@...1227...>
In-Reply-To: <b7c9a1ac-3322-4eeb-befd-e19c7f72da6b@...1227...>
From: =?UTF-8?B?16DXqteZINep15jXqNef?= <nsh531@...277...>
Date: Sun, 17 Nov 2024 05:45:16 +0200
Message-ID: <CAC8x_z3Fwf0r-BuvuOo+Vg0708fsaPGWjg-2pnY3xgM+e4QxDg@...278...>
Content-Type: multipart/mixed; boundary="00000000000092f200062713a1d0"
Subject: Re: [Openvpn-devel] Subject: Potential OpenVPN Vulnerability
 Report: Repeated TLS Handshake Failures Leading to Denial-of-Service
 Conditions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net, SECURITY@...515..., Antonio Quartulli <antonio@...515...>

--00000000000092f200062713a1d0
Content-Type: multipart/alternative; boundary="00000000000092f1ff062713a1ce"

--00000000000092f1ff062713a1ce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hi,
I send logs:


greetings,
Netanel

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=90=D7=
=B3, 17 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-1:50 =D7=9E=D7=90=D7=AA =
=E2=80=AAArne Schwabe=E2=80=AC=E2=80=8F <=E2=80=AAarne@...1227...
=E2=80=AC=E2=80=8F>:=E2=80=AC

>
> Am 16.11.2024 um 20:22 schrieb =D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=D7=
=9F:
> >
> > Dear OpenVPN Security Team,
> >
> > This report describes a potential vulnerability impacting OpenVPN,
> > version 2.6, exhibiting behavior indicative of denial-of-service (DoS)
> > conditions. The observed behavior strongly suggests a susceptibility
> > to attacks that exhaust server resources through repeated failed TLS
> > handshakes, causing frequent process restarts.
> >
> This is statement is not true. There is no indication of a server
> exhaustion in what you writing.
>
>
> > Observed Behavior: Consistent TLS handshake failures, resulting in
> > automatic server restarts, are observed. Log entries indicate
> > escalating restart delays (initially 80 seconds, then consistently 300
> > seconds), demonstrating the server's attempt to mitigate this pattern
> > but without success.
> >
> As already explained to you, that is called exponentional backoff, it is
> documented in the documentation under the --connect-retry option.
> > Evidence: The attached log file (openvpn_log.txt - replace this with
> > the actual filename if you're sending it as an attachment) details
> > these repeated failures. Key entries include:
> >
> Attachment missing but doesn't matter because the behaviour is intended
> and expected behaviour.
>
>
> >     Repeated "TLS key negotiation failed to occur within 5 seconds
> > (check your network connectivity)" errors.
> >
> You have a quite tight connect timeout. Normal timeout is 60s and not 5s.
>
>
> >     Corresponding "TLS handshake failed" errors.
> >
> >     SIGUSR1[soft,tls-error] signals, triggering server restarts.
> >
> > Reproducibility: While we can't definitively prove reproducibility
> > without controlled testing, the consistent pattern, occurring even
> > over extended periods with incrementally increasing retry timeouts
> > strongly suggest either network unreliability combined with server
> > inadequacies to handle such errors gracefully, or a clear, repeatable
> > exploitation approach capable of inducing sustained stress on OpenVPN
> > instances without actual service outage
>
> Your argumentation makes no sense to make. A client doing exponential
> backoff is not an indication that the server is overloaded. Hint: Look
> what happens if TCP makes a connection attempt, SYN packets will show a
> similar pattern of exponential backoff.
>
> > .
> >
> > Suspected Vulnerabilities: The observed behaviour suggests at least
> > one of the following:
> YOu are doing a wild guess and that wild guess is wrong. Please stop
> trying to hallucinate a vulnerability where none exists.
> > .
> >
> > Mitigating Factors: The self-mitigation measures already apparent in
> > the server configuration include automatic restart after timeout.
> > These automatic retries, combined with increasingly long durations for
> > the forced pauses before restarting (80, then repeatedly 300 seconds)
> > suggest attempts to alleviate this behaviour. They fail consistently.
> >
> This conclusion is wrong as said before.
>
>
> > Analysis: The consistent failure rate combined with increased server
> > pause intervals indicates that a self-mitigation measure implemented
> > by the OpenVPN server processes appears not fully effective at
> > recovering this. The frequency, and repetition, is far more aligned
> > with possible DoS exploit capabilities and repeated attack attempts,
> > far more than what could be considered a networking error of sorts
> > only, regardless of network configuration changes attempted.
> >
> > Client Configuration: The attached OpenVPN client configuration file
> > (openvpn_config.txt - again, use the correct filename) is provided for
> > context
> You are confusing a client behaviour with a server behaviour.
> > .
> >
> > Additional Notes: The frequent WARNING: normally if you use --mssfix
> > and/or --fragment, you should also set --tun-mtu 1500 (currently it is
> > 1450) messages suggest potential MTU/MSS issues, which may be
> > unrelated to this main security risk issue or be an intrinsic cause
> > instead. This would require extensive and highly targeted tests to
> > validate the implication. Further investigation will be required.
> >
> > We request your attention and an evaluation of this matter to
> > establish if it constitutes a vulnerability eligible for CVE assignment.
>
> THE ANWSER IS STILL NO. You don't even describing a bug or anything
> else. You are reporting the indented and desired behaviour. That is not
> CVE or even bug worthy in the slightest.
>
> Please have a proper evaluation and stop some throwing some random
> nonsense over and over again at our mailing list when you already been
> told that this is INDENTED behaviour.
>
> Arne
>
>

--=20
<https://netanel.ml>

--00000000000092f1ff062713a1ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"rtl"><div dir=3D"ltr">hi,</div><div dir=3D"ltr">I send logs:</d=
iv><div dir=3D"ltr">=C2=A0</div><div dir=3D"ltr"><br></div><div dir=3D"ltr"=
>greetings,</div><div dir=3D"ltr">Netanel<br></div></div><br><div class=3D"=
gmail_quote"><div dir=3D"rtl" class=3D"gmail_attr">=E2=80=AB=D7=91=D7=AA=D7=
=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=90=D7=B3, 17 =D7=91=D7=A0=D7=
=95=D7=91=D7=B3 2024 =D7=91-1:50 =D7=9E=D7=90=D7=AA =E2=80=AAArne Schwabe=
=E2=80=AC=E2=80=8F &lt;=E2=80=AA<a href=3D"mailto:arne@...1227...">arne@...493...=
1227...</a>=E2=80=AC=E2=80=8F&gt;:=E2=80=AC<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"><br>
Am 16.11.2024 um 20:22 schrieb =D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=D7=9F:=
<br>
&gt;<br>
&gt; Dear OpenVPN Security Team,<br>
&gt;<br>
&gt; This report describes a potential vulnerability impacting OpenVPN, <br>
&gt; version 2.6, exhibiting behavior indicative of denial-of-service (DoS)=
 <br>
&gt; conditions. The observed behavior strongly suggests a susceptibility <=
br>
&gt; to attacks that exhaust server resources through repeated failed TLS <=
br>
&gt; handshakes, causing frequent process restarts.<br>
&gt;<br>
This is statement is not true. There is no indication of a server <br>
exhaustion in what you writing.<br>
<br>
<br>
&gt; Observed Behavior: Consistent TLS handshake failures, resulting in <br>
&gt; automatic server restarts, are observed. Log entries indicate <br>
&gt; escalating restart delays (initially 80 seconds, then consistently 300=
 <br>
&gt; seconds), demonstrating the server&#39;s attempt to mitigate this patt=
ern <br>
&gt; but without success.<br>
&gt;<br>
As already explained to you, that is called exponentional backoff, it is <b=
r>
documented in the documentation under the --connect-retry option.<br>
&gt; Evidence: The attached log file (openvpn_log.txt - replace this with <=
br>
&gt; the actual filename if you&#39;re sending it as an attachment) details=
 <br>
&gt; these repeated failures. Key entries include:<br>
&gt;<br>
Attachment missing but doesn&#39;t matter because the behaviour is intended=
 <br>
and expected behaviour.<br>
<br>
<br>
&gt; =C2=A0 =C2=A0 Repeated &quot;TLS key negotiation failed to occur withi=
n 5 seconds <br>
&gt; (check your network connectivity)&quot; errors.<br>
&gt;<br>
You have a quite tight connect timeout. Normal timeout is 60s and not 5s.<b=
r>
<br>
<br>
&gt; =C2=A0 =C2=A0 Corresponding &quot;TLS handshake failed&quot; errors.<b=
r>
&gt;<br>
&gt; =C2=A0 =C2=A0 SIGUSR1[soft,tls-error] signals, triggering server resta=
rts.<br>
&gt;<br>
&gt; Reproducibility: While we can&#39;t definitively prove reproducibility=
 <br>
&gt; without controlled testing, the consistent pattern, occurring even <br>
&gt; over extended periods with incrementally increasing retry timeouts <br>
&gt; strongly suggest either network unreliability combined with server <br>
&gt; inadequacies to handle such errors gracefully, or a clear, repeatable =
<br>
&gt; exploitation approach capable of inducing sustained stress on OpenVPN =
<br>
&gt; instances without actual service outage<br>
<br>
Your argumentation makes no sense to make. A client doing exponential <br>
backoff is not an indication that the server is overloaded. Hint: Look <br>
what happens if TCP makes a connection attempt, SYN packets will show a <br>
similar pattern of exponential backoff.<br>
<br>
&gt; .<br>
&gt;<br>
&gt; Suspected Vulnerabilities: The observed behaviour suggests at least <b=
r>
&gt; one of the following:<br>
YOu are doing a wild guess and that wild guess is wrong. Please stop <br>
trying to hallucinate a vulnerability where none exists.<br>
&gt; .<br>
&gt;<br>
&gt; Mitigating Factors: The self-mitigation measures already apparent in <=
br>
&gt; the server configuration include automatic restart after timeout. <br>
&gt; These automatic retries, combined with increasingly long durations for=
 <br>
&gt; the forced pauses before restarting (80, then repeatedly 300 seconds) =
<br>
&gt; suggest attempts to alleviate this behaviour. They fail consistently.<=
br>
&gt;<br>
This conclusion is wrong as said before.<br>
<br>
<br>
&gt; Analysis: The consistent failure rate combined with increased server <=
br>
&gt; pause intervals indicates that a self-mitigation measure implemented <=
br>
&gt; by the OpenVPN server processes appears not fully effective at <br>
&gt; recovering this. The frequency, and repetition, is far more aligned <b=
r>
&gt; with possible DoS exploit capabilities and repeated attack attempts, <=
br>
&gt; far more than what could be considered a networking error of sorts <br>
&gt; only, regardless of network configuration changes attempted.<br>
&gt;<br>
&gt; Client Configuration: The attached OpenVPN client configuration file <=
br>
&gt; (openvpn_config.txt - again, use the correct filename) is provided for=
 <br>
&gt; context<br>
You are confusing a client behaviour with a server behaviour.<br>
&gt; .<br>
&gt;<br>
&gt; Additional Notes: The frequent WARNING: normally if you use --mssfix <=
br>
&gt; and/or --fragment, you should also set --tun-mtu 1500 (currently it is=
 <br>
&gt; 1450) messages suggest potential MTU/MSS issues, which may be <br>
&gt; unrelated to this main security risk issue or be an intrinsic cause <b=
r>
&gt; instead. This would require extensive and highly targeted tests to <br>
&gt; validate the implication. Further investigation will be required.<br>
&gt;<br>
&gt; We request your attention and an evaluation of this matter to <br>
&gt; establish if it constitutes a vulnerability eligible for CVE assignmen=
t.<br>
<br>
THE ANWSER IS STILL NO. You don&#39;t even describing a bug or anything <br>
else. You are reporting the indented and desired behaviour. That is not <br>
CVE or even bug worthy in the slightest.<br>
<br>
Please have a proper evaluation and stop some throwing some random <br>
nonsense over and over again at our mailing list when you already been <br>
told that this is INDENTED behaviour.<br>
<br>
Arne<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"rtl" class=3D"gmail_signature"><d=
iv dir=3D"rtl"><a href=3D"https://netanel.ml" target=3D"_blank"><img width=
=3D"200" height=3D"51" src=3D"https://ci3.googleusercontent.com/mail-sig/AI=
orK4y1ahZg0mqH5UnDCjKIkW6FTSni5R5bezS1idSRECO6GXQ1uH3RgELXk8RqqCoNk3985_jsn=
IQnnclo"></a></div></div>

--00000000000092f1ff062713a1ce--

--00000000000092f200062713a1d0
Content-Type: text/plain; charset="US-ASCII"; name="test.txt"
Content-Disposition: attachment; filename="test.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m3l1y2mn0>
X-Attachment-Id: f_m3l1y2mn0

U3VuIE5vdiAxNyAwNTo0MjoyMyAyMDI0IE9wZW5WUE4gMi40LjEyIHg4Nl82NC1wYy1saW51eC1n
bnUgW1NTTCAoT3BlblNTTCldIFtMWk9dIFtMWjRdIFtFUE9MTF0gW1BLQ1MxMV0gW01IL1BLVElO
Rk9dIFtBRUFEXSBidWlsdCBvbiBKdW4gMjcgMjAyNApTdW4gTm92IDE3IDA1OjQyOjIzIDIwMjQg
bGlicmFyeSB2ZXJzaW9uczogT3BlblNTTCAxLjEuMWYgIDMxIE1hciAyMDIwLCBMWk8gMi4xMApT
dW4gTm92IDE3IDA1OjQyOjIzIDIwMjQgT3V0Z29pbmcgQ29udHJvbCBDaGFubmVsIEF1dGhlbnRp
Y2F0aW9uOiBVc2luZyAyNTYgYml0IG1lc3NhZ2UgaGFzaCAnU0hBMjU2JyBmb3IgSE1BQyBhdXRo
ZW50aWNhdGlvbgpTdW4gTm92IDE3IDA1OjQyOjIzIDIwMjQgSW5jb21pbmcgQ29udHJvbCBDaGFu
bmVsIEF1dGhlbnRpY2F0aW9uOiBVc2luZyAyNTYgYml0IG1lc3NhZ2UgaGFzaCAnU0hBMjU2JyBm
b3IgSE1BQyBhdXRoZW50aWNhdGlvbgpTdW4gTm92IDE3IDA1OjQyOjIzIDIwMjQgV0FSTklORzog
bm9ybWFsbHkgaWYgeW91IHVzZSAtLW1zc2ZpeCBhbmQvb3IgLS1mcmFnbWVudCwgeW91IHNob3Vs
ZCBhbHNvIHNldCAtLXR1bi1tdHUgMTUwMCAoY3VycmVudGx5IGl0IGlzIDE0NTApClN1biBOb3Yg
MTcgMDU6NDI6MjMgMjAyNCBUQ1AvVURQOiBQcmVzZXJ2aW5nIHJlY2VudGx5IHVzZWQgcmVtb3Rl
IGFkZHJlc3M6IFtBRl9JTkVUXTEwMy42LjE3MC4yMToxMTk0ClN1biBOb3YgMTcgMDU6NDI6MjMg
MjAyNCBTb2NrZXQgQnVmZmVyczogUj1bMjEyOTkyLT4yMTI5OTJdIFM9WzIxMjk5Mi0+MjEyOTky
XQpTdW4gTm92IDE3IDA1OjQyOjIzIDIwMjQgVURQIGxpbmsgbG9jYWw6IChub3QgYm91bmQpClN1
biBOb3YgMTcgMDU6NDI6MjMgMjAyNCBVRFAgbGluayByZW1vdGU6IFtBRl9JTkVUXTEwMy42LjE3
MC4yMToxMTk0ClN1biBOb3YgMTcgMDU6NDI6MjggMjAyNCBUTFMgRXJyb3I6IFRMUyBrZXkgbmVn
b3RpYXRpb24gZmFpbGVkIHRvIG9jY3VyIHdpdGhpbiA1IHNlY29uZHMgKGNoZWNrIHlvdXIgbmV0
d29yayBjb25uZWN0aXZpdHkpClN1biBOb3YgMTcgMDU6NDI6MjggMjAyNCBUTFMgRXJyb3I6IFRM
UyBoYW5kc2hha2UgZmFpbGVkClN1biBOb3YgMTcgMDU6NDI6MjggMjAyNCBTSUdVU1IxW3NvZnQs
dGxzLWVycm9yXSByZWNlaXZlZCwgcHJvY2VzcyByZXN0YXJ0aW5nClN1biBOb3YgMTcgMDU6NDI6
MjggMjAyNCBSZXN0YXJ0IHBhdXNlLCA1IHNlY29uZChzKQpTdW4gTm92IDE3IDA1OjQyOjMzIDIw
MjQgV0FSTklORzogbm9ybWFsbHkgaWYgeW91IHVzZSAtLW1zc2ZpeCBhbmQvb3IgLS1mcmFnbWVu
dCwgeW91IHNob3VsZCBhbHNvIHNldCAtLXR1bi1tdHUgMTUwMCAoY3VycmVudGx5IGl0IGlzIDE0
NTApClN1biBOb3YgMTcgMDU6NDI6MzMgMjAyNCBUQ1AvVURQOiBQcmVzZXJ2aW5nIHJlY2VudGx5
IHVzZWQgcmVtb3RlIGFkZHJlc3M6IFtBRl9JTkVUXTEwMy42LjE3MC4yMToxMTk0ClN1biBOb3Yg
MTcgMDU6NDI6MzMgMjAyNCBTb2NrZXQgQnVmZmVyczogUj1bMjEyOTkyLT4yMTI5OTJdIFM9WzIx
Mjk5Mi0+MjEyOTkyXQpTdW4gTm92IDE3IDA1OjQyOjMzIDIwMjQgVURQIGxpbmsgbG9jYWw6IChu
b3QgYm91bmQpClN1biBOb3YgMTcgMDU6NDI6MzMgMjAyNCBVRFAgbGluayByZW1vdGU6IFtBRl9J
TkVUXTEwMy42LjE3MC4yMToxMTk0ClN1biBOb3YgMTcgMDU6NDI6MzggMjAyNCBUTFMgRXJyb3I6
IFRMUyBrZXkgbmVnb3RpYXRpb24gZmFpbGVkIHRvIG9jY3VyIHdpdGhpbiA1IHNlY29uZHMgKGNo
ZWNrIHlvdXIgbmV0d29yayBjb25uZWN0aXZpdHkpClN1biBOb3YgMTcgMDU6NDI6MzggMjAyNCBU
TFMgRXJyb3I6IFRMUyBoYW5kc2hha2UgZmFpbGVkClN1biBOb3YgMTcgMDU6NDI6MzggMjAyNCBT
SUdVU1IxW3NvZnQsdGxzLWVycm9yXSByZWNlaXZlZCwgcHJvY2VzcyByZXN0YXJ0aW5nClN1biBO
b3YgMTcgMDU6NDI6MzggMjAyNCBSZXN0YXJ0IHBhdXNlLCA1IHNlY29uZChzKQpTdW4gTm92IDE3
IDA1OjQyOjQzIDIwMjQgV0FSTklORzogbm9ybWFsbHkgaWYgeW91IHVzZSAtLW1zc2ZpeCBhbmQv
b3IgLS1mcmFnbWVudCwgeW91IHNob3VsZCBhbHNvIHNldCAtLXR1bi1tdHUgMTUwMCAoY3VycmVu
dGx5IGl0IGlzIDE0NTApClN1biBOb3YgMTcgMDU6NDI6NDMgMjAyNCBUQ1AvVURQOiBQcmVzZXJ2
aW5nIHJlY2VudGx5IHVzZWQgcmVtb3RlIGFkZHJlc3M6IFtBRl9JTkVUXTEwMy42LjE3MC4yMTox
MTk0ClN1biBOb3YgMTcgMDU6NDI6NDMgMjAyNCBTb2NrZXQgQnVmZmVyczogUj1bMjEyOTkyLT4y
MTI5OTJdIFM9WzIxMjk5Mi0+MjEyOTkyXQpTdW4gTm92IDE3IDA1OjQyOjQzIDIwMjQgVURQIGxp
bmsgbG9jYWw6IChub3QgYm91bmQpClN1biBOb3YgMTcgMDU6NDI6NDMgMjAyNCBVRFAgbGluayBy
ZW1vdGU6IFtBRl9JTkVUXTEwMy42LjE3MC4yMToxMTk0ClN1biBOb3YgMTcgMDU6NDI6NDggMjAy
NCBUTFMgRXJyb3I6IFRMUyBrZXkgbmVnb3RpYXRpb24gZmFpbGVkIHRvIG9jY3VyIHdpdGhpbiA1
IHNlY29uZHMgKGNoZWNrIHlvdXIgbmV0d29yayBjb25uZWN0aXZpdHkpClN1biBOb3YgMTcgMDU6
NDI6NDggMjAyNCBUTFMgRXJyb3I6IFRMUyBoYW5kc2hha2UgZmFpbGVkClN1biBOb3YgMTcgMDU6
NDI6NDggMjAyNCBTSUdVU1IxW3NvZnQsdGxzLWVycm9yXSByZWNlaXZlZCwgcHJvY2VzcyByZXN0
YXJ0aW5nClN1biBOb3YgMTcgMDU6NDI6NDggMjAyNCBSZXN0YXJ0IHBhdXNlLCA1IHNlY29uZChz
KQpTdW4gTm92IDE3IDA1OjQyOjUzIDIwMjQgV0FSTklORzogbm9ybWFsbHkgaWYgeW91IHVzZSAt
LW1zc2ZpeCBhbmQvb3IgLS1mcmFnbWVudCwgeW91IHNob3VsZCBhbHNvIHNldCAtLXR1bi1tdHUg
MTUwMCAoY3VycmVudGx5IGl0IGlzIDE0NTApClN1biBOb3YgMTcgMDU6NDI6NTMgMjAyNCBUQ1Av
VURQOiBQcmVzZXJ2aW5nIHJlY2VudGx5IHVzZWQgcmVtb3RlIGFkZHJlc3M6IFtBRl9JTkVUXTEw
My42LjE3MC4yMToxMTk0ClN1biBOb3YgMTcgMDU6NDI6NTMgMjAyNCBTb2NrZXQgQnVmZmVyczog
Uj1bMjEyOTkyLT4yMTI5OTJdIFM9WzIxMjk5Mi0+MjEyOTkyXQpTdW4gTm92IDE3IDA1OjQyOjUz
IDIwMjQgVURQIGxpbmsgbG9jYWw6IChub3QgYm91bmQpClN1biBOb3YgMTcgMDU6NDI6NTMgMjAy
NCBVRFAgbGluayByZW1vdGU6IFtBRl9JTkVUXTEwMy42LjE3MC4yMToxMTk0ClN1biBOb3YgMTcg
MDU6NDI6NTggMjAyNCBUTFMgRXJyb3I6IFRMUyBrZXkgbmVnb3RpYXRpb24gZmFpbGVkIHRvIG9j
Y3VyIHdpdGhpbiA1IHNlY29uZHMgKGNoZWNrIHlvdXIgbmV0d29yayBjb25uZWN0aXZpdHkpClN1
biBOb3YgMTcgMDU6NDI6NTggMjAyNCBUTFMgRXJyb3I6IFRMUyBoYW5kc2hha2UgZmFpbGVkClN1
biBOb3YgMTcgMDU6NDI6NTggMjAyNCBTSUdVU1IxW3NvZnQsdGxzLWVycm9yXSByZWNlaXZlZCwg
cHJvY2VzcyByZXN0YXJ0aW5nClN1biBOb3YgMTcgMDU6NDI6NTggMjAyNCBSZXN0YXJ0IHBhdXNl
LCA1IHNlY29uZChzKQpTdW4gTm92IDE3IDA1OjQzOjAzIDIwMjQgV0FSTklORzogbm9ybWFsbHkg
aWYgeW91IHVzZSAtLW1zc2ZpeCBhbmQvb3IgLS1mcmFnbWVudCwgeW91IHNob3VsZCBhbHNvIHNl
dCAtLXR1bi1tdHUgMTUwMCAoY3VycmVudGx5IGl0IGlzIDE0NTApClN1biBOb3YgMTcgMDU6NDM6
MDMgMjAyNCBUQ1AvVURQOiBQcmVzZXJ2aW5nIHJlY2VudGx5IHVzZWQgcmVtb3RlIGFkZHJlc3M6
IFtBRl9JTkVUXTEwMy42LjE3MC4yMToxMTk0ClN1biBOb3YgMTcgMDU6NDM6MDMgMjAyNCBTb2Nr
ZXQgQnVmZmVyczogUj1bMjEyOTkyLT4yMTI5OTJdIFM9WzIxMjk5Mi0+MjEyOTkyXQpTdW4gTm92
IDE3IDA1OjQzOjAzIDIwMjQgVURQIGxpbmsgbG9jYWw6IChub3QgYm91bmQpClN1biBOb3YgMTcg
MDU6NDM6MDMgMjAyNCBVRFAgbGluayByZW1vdGU6IFtBRl9JTkVUXTEwMy42LjE3MC4yMToxMTk0
ClN1biBOb3YgMTcgMDU6NDM6MDggMjAyNCBUTFMgRXJyb3I6IFRMUyBrZXkgbmVnb3RpYXRpb24g
ZmFpbGVkIHRvIG9jY3VyIHdpdGhpbiA1IHNlY29uZHMgKGNoZWNrIHlvdXIgbmV0d29yayBjb25u
ZWN0aXZpdHkpClN1biBOb3YgMTcgMDU6NDM6MDggMjAyNCBUTFMgRXJyb3I6IFRMUyBoYW5kc2hh
a2UgZmFpbGVkClN1biBOb3YgMTcgMDU6NDM6MDggMjAyNCBTSUdVU1IxW3NvZnQsdGxzLWVycm9y
XSByZWNlaXZlZCwgcHJvY2VzcyByZXN0YXJ0aW5nClN1biBOb3YgMTcgMDU6NDM6MDggMjAyNCBS
ZXN0YXJ0IHBhdXNlLCAxMCBzZWNvbmQocykKU3VuIE5vdiAxNyAwNTo0MzoxOCAyMDI0IFdBUk5J
Tkc6IG5vcm1hbGx5IGlmIHlvdSB1c2UgLS1tc3NmaXggYW5kL29yIC0tZnJhZ21lbnQsIHlvdSBz
aG91bGQgYWxzbyBzZXQgLS10dW4tbXR1IDE1MDAgKGN1cnJlbnRseSBpdCBpcyAxNDUwKQpTdW4g
Tm92IDE3IDA1OjQzOjE4IDIwMjQgVENQL1VEUDogUHJlc2VydmluZyByZWNlbnRseSB1c2VkIHJl
bW90ZSBhZGRyZXNzOiBbQUZfSU5FVF0xMDMuNi4xNzAuMjE6MTE5NApTdW4gTm92IDE3IDA1OjQz
OjE4IDIwMjQgU29ja2V0IEJ1ZmZlcnM6IFI9WzIxMjk5Mi0+MjEyOTkyXSBTPVsyMTI5OTItPjIx
Mjk5Ml0KU3VuIE5vdiAxNyAwNTo0MzoxOCAyMDI0IFVEUCBsaW5rIGxvY2FsOiAobm90IGJvdW5k
KQpTdW4gTm92IDE3IDA1OjQzOjE4IDIwMjQgVURQIGxpbmsgcmVtb3RlOiBbQUZfSU5FVF0xMDMu
Ni4xNzAuMjE6MTE5NApTdW4gTm92IDE3IDA1OjQzOjIzIDIwMjQgVExTIEVycm9yOiBUTFMga2V5
IG5lZ290aWF0aW9uIGZhaWxlZCB0byBvY2N1ciB3aXRoaW4gNSBzZWNvbmRzIChjaGVjayB5b3Vy
IG5ldHdvcmsgY29ubmVjdGl2aXR5KQpTdW4gTm92IDE3IDA1OjQzOjIzIDIwMjQgVExTIEVycm9y
OiBUTFMgaGFuZHNoYWtlIGZhaWxlZApTdW4gTm92IDE3IDA1OjQzOjIzIDIwMjQgU0lHVVNSMVtz
b2Z0LHRscy1lcnJvcl0gcmVjZWl2ZWQsIHByb2Nlc3MgcmVzdGFydGluZwpTdW4gTm92IDE3IDA1
OjQzOjIzIDIwMjQgUmVzdGFydCBwYXVzZSwgMjAgc2Vjb25kKHMpCg==
--00000000000092f200062713a1d0--

