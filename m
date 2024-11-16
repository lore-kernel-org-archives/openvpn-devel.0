MIME-Version: 1.0
From: =?UTF-8?B?16DXqteZINep15jXqNef?= <nsh531@...277...>
Date: Sat, 16 Nov 2024 21:22:25 +0200
Message-ID: <CAC8x_z10PT_ToTzVUKQENA5ZJgJ4EMvBJARphDR5_wdytA2JSw@...278...>
Content-Type: multipart/alternative; boundary="00000000000023206906270c9b50"
Subject: [Openvpn-devel] Subject: Potential OpenVPN Vulnerability Report:
 Repeated TLS Handshake Failures Leading to Denial-of-Service Conditions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net, SECURITY@...515..., Antonio Quartulli <antonio@...515...>

--00000000000023206906270c9b50
Content-Type: text/plain; charset="UTF-8"

Dear OpenVPN Security Team,

This report describes a potential vulnerability impacting OpenVPN, version
2.6, exhibiting behavior indicative of denial-of-service (DoS) conditions.
The observed behavior strongly suggests a susceptibility to attacks that
exhaust server resources through repeated failed TLS handshakes, causing
frequent process restarts.

Observed Behavior: Consistent TLS handshake failures, resulting in
automatic server restarts, are observed. Log entries indicate escalating
restart delays (initially 80 seconds, then consistently 300 seconds),
demonstrating the server's attempt to mitigate this pattern but without
success.

Evidence: The attached log file (openvpn_log.txt - replace this with the
actual filename if you're sending it as an attachment) details these
repeated failures. Key entries include:

    Repeated "TLS key negotiation failed to occur within 5 seconds (check
your network connectivity)" errors.

    Corresponding "TLS handshake failed" errors.

    SIGUSR1[soft,tls-error] signals, triggering server restarts.

Reproducibility: While we can't definitively prove reproducibility without
controlled testing, the consistent pattern, occurring even over extended
periods with incrementally increasing retry timeouts strongly suggest
either network unreliability combined with server inadequacies to handle
such errors gracefully, or a clear, repeatable exploitation approach
capable of inducing sustained stress on OpenVPN instances without actual
service outage.

Suspected Vulnerabilities: The observed behaviour suggests at least one of
the following:

    Inefficient TLS Handshake Handling: The server may not efficiently
handle numerous failed handshake attempts, leading to resource exhaustion
under sustained pressure.

    Vulnerability to a DoS Attack: The server might be susceptible to a DoS
attack where a malicious actor triggers numerous connection attempts that
consistently fail.

Mitigating Factors: The self-mitigation measures already apparent in the
server configuration include automatic restart after timeout. These
automatic retries, combined with increasingly long durations for the forced
pauses before restarting (80, then repeatedly 300 seconds) suggest attempts
to alleviate this behaviour. They fail consistently.

Analysis: The consistent failure rate combined with increased server pause
intervals indicates that a self-mitigation measure implemented by the
OpenVPN server processes appears not fully effective at recovering this.
The frequency, and repetition, is far more aligned with possible DoS
exploit capabilities and repeated attack attempts, far more than what could
be considered a networking error of sorts only, regardless of network
configuration changes attempted.

Client Configuration: The attached OpenVPN client configuration file
(openvpn_config.txt - again, use the correct filename) is provided for
context.

Additional Notes: The frequent WARNING: normally if you use --mssfix and/or
--fragment, you should also set --tun-mtu 1500 (currently it is 1450)
messages suggest potential MTU/MSS issues, which may be unrelated to this
main security risk issue or be an intrinsic cause instead. This would
require extensive and highly targeted tests to validate the implication.
Further investigation will be required.

We request your attention and an evaluation of this matter to establish if
it constitutes a vulnerability eligible for CVE assignment.

Sincerely,

Netanel

-- 
<https://netanel.ml>

--00000000000023206906270c9b50
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"rtl"><div><br>Dear OpenVPN Security Team,<br><br>This report de=
scribes a potential vulnerability impacting OpenVPN, version 2.6, exhibitin=
g behavior indicative of denial-of-service (DoS) conditions. The observed b=
ehavior strongly suggests a susceptibility to attacks that exhaust server r=
esources through repeated failed TLS handshakes, causing frequent process r=
estarts.<br><br>Observed Behavior: Consistent TLS handshake failures, resul=
ting in automatic server restarts, are observed. Log entries indicate escal=
ating restart delays (initially 80 seconds, then consistently 300 seconds),=
 demonstrating the server&#39;s attempt to mitigate this pattern but withou=
t success.<br><br>Evidence: The attached log file (openvpn_log.txt - replac=
e this with the actual filename if you&#39;re sending it as an attachment) =
details these repeated failures. Key entries include:<br><br>=C2=A0 =C2=A0 =
Repeated &quot;TLS key negotiation failed to occur within 5 seconds (check =
your network connectivity)&quot; errors.<br><br>=C2=A0 =C2=A0 Corresponding=
 &quot;TLS handshake failed&quot; errors.<br><br>=C2=A0 =C2=A0 SIGUSR1[soft=
,tls-error] signals, triggering server restarts.<br><br>Reproducibility: Wh=
ile we can&#39;t definitively prove reproducibility without controlled test=
ing, the consistent pattern, occurring even over extended periods with incr=
ementally increasing retry timeouts strongly suggest either network unrelia=
bility combined with server inadequacies to handle such errors gracefully, =
or a clear, repeatable exploitation approach capable of inducing sustained =
stress on OpenVPN instances without actual service outage.<br><br>Suspected=
 Vulnerabilities: The observed behaviour suggests at least one of the follo=
wing:<br><br>=C2=A0 =C2=A0 Inefficient TLS Handshake Handling: The server m=
ay not efficiently handle numerous failed handshake attempts, leading to re=
source exhaustion under sustained pressure.<br><br>=C2=A0 =C2=A0 Vulnerabil=
ity to a DoS Attack: The server might be susceptible to a DoS attack where =
a malicious actor triggers numerous connection attempts that consistently f=
ail.<br><br>Mitigating Factors: The self-mitigation measures already appare=
nt in the server configuration include automatic restart after timeout. The=
se automatic retries, combined with increasingly long durations for the for=
ced pauses before restarting (80, then repeatedly 300 seconds) suggest atte=
mpts to alleviate this behaviour. They fail consistently.<br><br>Analysis: =
The consistent failure rate combined with increased server pause intervals =
indicates that a self-mitigation measure implemented by the OpenVPN server =
processes appears not fully effective at recovering this. The frequency, an=
d repetition, is far more aligned with possible DoS exploit capabilities an=
d repeated attack attempts, far more than what could be considered a networ=
king error of sorts only, regardless of network configuration changes attem=
pted.<br><br>Client Configuration: The attached OpenVPN client configuratio=
n file (openvpn_config.txt - again, use the correct filename) is provided f=
or context.<br><br>Additional Notes: The frequent WARNING: normally if you =
use --mssfix and/or --fragment, you should also set --tun-mtu 1500 (current=
ly it is 1450) messages suggest potential MTU/MSS issues, which may be unre=
lated to this main security risk issue or be an intrinsic cause instead. Th=
is would require extensive and highly targeted tests to validate the implic=
ation. Further investigation will be required.<br><br>We request your atten=
tion and an evaluation of this matter to establish if it constitutes a vuln=
erability eligible for CVE assignment.<br><br>Sincerely,<br><br>Netanel</di=
v><div><br></div><span class=3D"gmail_signature_prefix">-- </span><br><div =
dir=3D"rtl" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><d=
iv dir=3D"rtl"><a href=3D"https://netanel.ml" target=3D"_blank"><img width=
=3D"200" height=3D"51" src=3D"https://ci3.googleusercontent.com/mail-sig/AI=
orK4y1ahZg0mqH5UnDCjKIkW6FTSni5R5bezS1idSRECO6GXQ1uH3RgELXk8RqqCoNk3985_jsn=
IQnnclo"></a></div></div></div>

--00000000000023206906270c9b50--

