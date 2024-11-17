MIME-Version: 1.0
References: <CAC8x_z10PT_ToTzVUKQENA5ZJgJ4EMvBJARphDR5_wdytA2JSw@...278...>
 <b7c9a1ac-3322-4eeb-befd-e19c7f72da6b@...1227...>
 <CAC8x_z3Fwf0r-BuvuOo+Vg0708fsaPGWjg-2pnY3xgM+e4QxDg@...278...>
In-Reply-To: <CAC8x_z3Fwf0r-BuvuOo+Vg0708fsaPGWjg-2pnY3xgM+e4QxDg@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 17 Nov 2024 10:16:39 +0100
Message-ID: <CAFHpkQE6nKGGCSpygjrgjNK1Yv_4YiLBKTQDkAG_0LRB4iba0w@...278...>
Content-Type: multipart/alternative; boundary="000000000000a4b9190627184274"
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
To: =?UTF-8?B?16DXqteZINep15jXqNef?= <nsh531@...277...>
Cc: Arne Schwabe <arne@...1227...>, Antonio Quartulli <antonio@...515...>, openvpn-devel@lists.sourceforge.net, SECURITY@...515...

--000000000000a4b9190627184274
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=E2=80=AA=D0=B2=D1=81, 17 =D0=BD=D0=BE=D1=8F=D0=B1. 2024=E2=80=AF=D0=B3. =
=D0=B2 04:46, =E2=80=AB=D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=D7=9F=E2=80=AC=
=E2=80=8E <nsh531@...277...>:=E2=80=AC

> hi,
> I send logs:
>

it is hard to say what is wrong in the logs sent. from my point of view -
those logs do not indicate any security issue.

please try to explain in details why do you think it is security issue.


>
>
> greetings,
> Netanel
>
> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=90=
=D7=B3, 17 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-1:50 =D7=9E=D7=90=D7=
=AA =E2=80=AAArne Schwabe=E2=80=AC=E2=80=8F <=E2=80=AA
> arne@...1227...=E2=80=AC=E2=80=8F>:=E2=80=AC
>
>>
>> Am 16.11.2024 um 20:22 schrieb =D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=D7=
=9F:
>> >
>> > Dear OpenVPN Security Team,
>> >
>> > This report describes a potential vulnerability impacting OpenVPN,
>> > version 2.6, exhibiting behavior indicative of denial-of-service (DoS)
>> > conditions. The observed behavior strongly suggests a susceptibility
>> > to attacks that exhaust server resources through repeated failed TLS
>> > handshakes, causing frequent process restarts.
>> >
>> This is statement is not true. There is no indication of a server
>> exhaustion in what you writing.
>>
>>
>> > Observed Behavior: Consistent TLS handshake failures, resulting in
>> > automatic server restarts, are observed. Log entries indicate
>> > escalating restart delays (initially 80 seconds, then consistently 300
>> > seconds), demonstrating the server's attempt to mitigate this pattern
>> > but without success.
>> >
>> As already explained to you, that is called exponentional backoff, it is
>> documented in the documentation under the --connect-retry option.
>> > Evidence: The attached log file (openvpn_log.txt - replace this with
>> > the actual filename if you're sending it as an attachment) details
>> > these repeated failures. Key entries include:
>> >
>> Attachment missing but doesn't matter because the behaviour is intended
>> and expected behaviour.
>>
>>
>> >     Repeated "TLS key negotiation failed to occur within 5 seconds
>> > (check your network connectivity)" errors.
>> >
>> You have a quite tight connect timeout. Normal timeout is 60s and not 5s.
>>
>>
>> >     Corresponding "TLS handshake failed" errors.
>> >
>> >     SIGUSR1[soft,tls-error] signals, triggering server restarts.
>> >
>> > Reproducibility: While we can't definitively prove reproducibility
>> > without controlled testing, the consistent pattern, occurring even
>> > over extended periods with incrementally increasing retry timeouts
>> > strongly suggest either network unreliability combined with server
>> > inadequacies to handle such errors gracefully, or a clear, repeatable
>> > exploitation approach capable of inducing sustained stress on OpenVPN
>> > instances without actual service outage
>>
>> Your argumentation makes no sense to make. A client doing exponential
>> backoff is not an indication that the server is overloaded. Hint: Look
>> what happens if TCP makes a connection attempt, SYN packets will show a
>> similar pattern of exponential backoff.
>>
>> > .
>> >
>> > Suspected Vulnerabilities: The observed behaviour suggests at least
>> > one of the following:
>> YOu are doing a wild guess and that wild guess is wrong. Please stop
>> trying to hallucinate a vulnerability where none exists.
>> > .
>> >
>> > Mitigating Factors: The self-mitigation measures already apparent in
>> > the server configuration include automatic restart after timeout.
>> > These automatic retries, combined with increasingly long durations for
>> > the forced pauses before restarting (80, then repeatedly 300 seconds)
>> > suggest attempts to alleviate this behaviour. They fail consistently.
>> >
>> This conclusion is wrong as said before.
>>
>>
>> > Analysis: The consistent failure rate combined with increased server
>> > pause intervals indicates that a self-mitigation measure implemented
>> > by the OpenVPN server processes appears not fully effective at
>> > recovering this. The frequency, and repetition, is far more aligned
>> > with possible DoS exploit capabilities and repeated attack attempts,
>> > far more than what could be considered a networking error of sorts
>> > only, regardless of network configuration changes attempted.
>> >
>> > Client Configuration: The attached OpenVPN client configuration file
>> > (openvpn_config.txt - again, use the correct filename) is provided for
>> > context
>> You are confusing a client behaviour with a server behaviour.
>> > .
>> >
>> > Additional Notes: The frequent WARNING: normally if you use --mssfix
>> > and/or --fragment, you should also set --tun-mtu 1500 (currently it is
>> > 1450) messages suggest potential MTU/MSS issues, which may be
>> > unrelated to this main security risk issue or be an intrinsic cause
>> > instead. This would require extensive and highly targeted tests to
>> > validate the implication. Further investigation will be required.
>> >
>> > We request your attention and an evaluation of this matter to
>> > establish if it constitutes a vulnerability eligible for CVE assignmen=
t.
>>
>> THE ANWSER IS STILL NO. You don't even describing a bug or anything
>> else. You are reporting the indented and desired behaviour. That is not
>> CVE or even bug worthy in the slightest.
>>
>> Please have a proper evaluation and stop some throwing some random
>> nonsense over and over again at our mailing list when you already been
>> told that this is INDENTED behaviour.
>>
>> Arne
>>
>>
>
> --
> <https://netanel.ml>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000a4b9190627184274
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">=E2=80=AA=D0=B2=D1=81, 17 =D0=BD=D0=
=BE=D1=8F=D0=B1. 2024=E2=80=AF=D0=B3. =D0=B2 04:46, =E2=80=AB=D7=A0=D7=AA=
=D7=99 =D7=A9=D7=98=D7=A8=D7=9F=E2=80=AC=E2=80=8E &lt;<a href=3D"mailto:nsh=
531@...277...">nsh531@...277...</a>&gt;:=E2=80=AC<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex"><div dir=3D"rtl"><div dir=3D"ltr">hi,</di=
v><div dir=3D"ltr">I send logs:</div></div></blockquote><div><br></div><div=
>it is hard to say what is wrong in the logs sent. from my point of view - =
those logs do not indicate any security issue.</div><div><br></div><div>ple=
ase try to explain in details why do you think it is security issue.</div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"rtl"><div dir=3D"ltr">=C2=A0</div><div dir=3D"ltr"><br></div><div dir=
=3D"ltr">greetings,</div><div dir=3D"ltr">Netanel<br></div></div><br><div c=
lass=3D"gmail_quote"><div dir=3D"rtl" class=3D"gmail_attr">=E2=80=AB=D7=91=
=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=90=D7=B3, 17 =D7=91=
=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-1:50 =D7=9E=D7=90=D7=AA =E2=80=AAArne =
Schwabe=E2=80=AC=E2=80=8F &lt;=E2=80=AA<a href=3D"mailto:arne@...1227..." t=
arget=3D"_blank">arne@...1227...</a>=E2=80=AC=E2=80=8F&gt;:=E2=80=AC<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
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
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div></div>

--000000000000a4b9190627184274--

