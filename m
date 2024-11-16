Message-ID: <b7c9a1ac-3322-4eeb-befd-e19c7f72da6b@...1227...>
Date: Sun, 17 Nov 2024 00:50:52 +0100
MIME-Version: 1.0
References: <CAC8x_z10PT_ToTzVUKQENA5ZJgJ4EMvBJARphDR5_wdytA2JSw@...278...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAC8x_z10PT_ToTzVUKQENA5ZJgJ4EMvBJARphDR5_wdytA2JSw@...278...>
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
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?16DXqteZINep15jXqNef?= <nsh531@...277...>, openvpn-devel@lists.sourceforge.net, SECURITY@...515..., Antonio Quartulli <antonio@...515...>


Am 16.11.2024 um 20:22 schrieb נתי שטרן:
>
> Dear OpenVPN Security Team,
>
> This report describes a potential vulnerability impacting OpenVPN, 
> version 2.6, exhibiting behavior indicative of denial-of-service (DoS) 
> conditions. The observed behavior strongly suggests a susceptibility 
> to attacks that exhaust server resources through repeated failed TLS 
> handshakes, causing frequent process restarts.
>
This is statement is not true. There is no indication of a server 
exhaustion in what you writing.


> Observed Behavior: Consistent TLS handshake failures, resulting in 
> automatic server restarts, are observed. Log entries indicate 
> escalating restart delays (initially 80 seconds, then consistently 300 
> seconds), demonstrating the server's attempt to mitigate this pattern 
> but without success.
>
As already explained to you, that is called exponentional backoff, it is 
documented in the documentation under the --connect-retry option.
> Evidence: The attached log file (openvpn_log.txt - replace this with 
> the actual filename if you're sending it as an attachment) details 
> these repeated failures. Key entries include:
>
Attachment missing but doesn't matter because the behaviour is intended 
and expected behaviour.


>     Repeated "TLS key negotiation failed to occur within 5 seconds 
> (check your network connectivity)" errors.
>
You have a quite tight connect timeout. Normal timeout is 60s and not 5s.


>     Corresponding "TLS handshake failed" errors.
>
>     SIGUSR1[soft,tls-error] signals, triggering server restarts.
>
> Reproducibility: While we can't definitively prove reproducibility 
> without controlled testing, the consistent pattern, occurring even 
> over extended periods with incrementally increasing retry timeouts 
> strongly suggest either network unreliability combined with server 
> inadequacies to handle such errors gracefully, or a clear, repeatable 
> exploitation approach capable of inducing sustained stress on OpenVPN 
> instances without actual service outage

Your argumentation makes no sense to make. A client doing exponential 
backoff is not an indication that the server is overloaded. Hint: Look 
what happens if TCP makes a connection attempt, SYN packets will show a 
similar pattern of exponential backoff.

> .
>
> Suspected Vulnerabilities: The observed behaviour suggests at least 
> one of the following:
YOu are doing a wild guess and that wild guess is wrong. Please stop 
trying to hallucinate a vulnerability where none exists.
> .
>
> Mitigating Factors: The self-mitigation measures already apparent in 
> the server configuration include automatic restart after timeout. 
> These automatic retries, combined with increasingly long durations for 
> the forced pauses before restarting (80, then repeatedly 300 seconds) 
> suggest attempts to alleviate this behaviour. They fail consistently.
>
This conclusion is wrong as said before.


> Analysis: The consistent failure rate combined with increased server 
> pause intervals indicates that a self-mitigation measure implemented 
> by the OpenVPN server processes appears not fully effective at 
> recovering this. The frequency, and repetition, is far more aligned 
> with possible DoS exploit capabilities and repeated attack attempts, 
> far more than what could be considered a networking error of sorts 
> only, regardless of network configuration changes attempted.
>
> Client Configuration: The attached OpenVPN client configuration file 
> (openvpn_config.txt - again, use the correct filename) is provided for 
> context
You are confusing a client behaviour with a server behaviour.
> .
>
> Additional Notes: The frequent WARNING: normally if you use --mssfix 
> and/or --fragment, you should also set --tun-mtu 1500 (currently it is 
> 1450) messages suggest potential MTU/MSS issues, which may be 
> unrelated to this main security risk issue or be an intrinsic cause 
> instead. This would require extensive and highly targeted tests to 
> validate the implication. Further investigation will be required.
>
> We request your attention and an evaluation of this matter to 
> establish if it constitutes a vulnerability eligible for CVE assignment.

THE ANWSER IS STILL NO. You don't even describing a bug or anything 
else. You are reporting the indented and desired behaviour. That is not 
CVE or even bug worthy in the slightest.

Please have a proper evaluation and stop some throwing some random 
nonsense over and over again at our mailing list when you already been 
told that this is INDENTED behaviour.

Arne


