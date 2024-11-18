Message-ID: <2214576a-f0db-9a48-7e14-cc7093bee35e@...2108...>
Date: Mon, 18 Nov 2024 11:04:02 +0100
MIME-Version: 1.0
References: <CAC8x_z10PT_ToTzVUKQENA5ZJgJ4EMvBJARphDR5_wdytA2JSw@...278...>
 <b7c9a1ac-3322-4eeb-befd-e19c7f72da6b@...1227...>
 <CAC8x_z3Fwf0r-BuvuOo+Vg0708fsaPGWjg-2pnY3xgM+e4QxDg@...278...>
 <Zzm_gUxTAmFZjm_h@...1296...>
 <CAC8x_z1OtkMeuRCHNOHfg-rcJ3Kcj2uHua3pzK5ZqKJDjPvBjQ@...278...>
 <ZzoQ7jXbImL56HL6@...1296...>
 <CAC8x_z2=DL=t2V5oN_hBMLbYcVMH78XqbTLguxFifjDco+zWyQ@...278...>
 <2dae1148-45d8-4f82-8b65-973b81a18645@...1227...>
 <CAC8x_z25-XQEyk0O34nKFMMj-mXNR2r+WbbaseX70mzzZKT+QA@...278...>
 <ZzrpT6DjykCOJwUB@...1296...>
 <CAC8x_z18gdgGfgSkH4w2hy5KJ8qkbTWXMyjNe592bLGe6ipzsA@...278...>
 <CAFHpkQEYLiq+QGA=gKk-f-3Bi33XWvsS8r5+UEd8GUdmjbE+Ng@...278...>
 <NiEAJIgS9m7ZfNEendx_-DgdcR9mgMT7fRzEQkUbVYLFCz0ypiEj0WQmBGFcUYYPjPds9DYHnsE9C8LCC3TJaA==@protonmail.internalid>
 <CAC8x_z25BWNsGfTbJTk2000D_DHN0tTWBUzSO7USzqwh0VSAGw@...278...>
From: David Sommerseth <dazo+openvpn@...2108...>
Content-Language: en-GB, nb-NO
In-Reply-To: <CAC8x_z25BWNsGfTbJTk2000D_DHN0tTWBUzSO7USzqwh0VSAGw@...278...>
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
To: =?UTF-8?B?16DXqteZINep15jXqNef?= <nsh531@...277...>, =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, =?UTF-8?B?15PXmdeV15XXl9eZINek15LXmdei15XXmdeV16o=?= <cve@...2832...>
Cc: Gert Doering <gert@...1296...>, Antonio Quartulli <antonio@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, SECURITY@...515...


Please stop now.

A client which cannot reach a server because the client side has 
connectivity issues towards the server is not a DoS, it is not a CVE and 
will never be considered a security issue.

First of all, a DoS attack is commonly related to a SERVER becoming 
unresponsive due to traffic to the server causing it to stop responding. 
  Or that one VPN clients misbehaviour (not due to misconfiguration, 
though) results in no other clients being able to connect.

What you have described so far is that you cannot reach the server.  And 
OpenVPN tries to reconnect regularly.  This is the expected behaviour of 
most VPN clients - they try to keep the tunnel running with as little 
user interaction as possible.  The back-off timer is there to also 
needlessly keep trying if there seems to be longer persisting 
connectivity issues.

And just to entertain you a bit more.  This is the logs when using 
OpenVPN 3 Linux:

----------------------------------------------------------------------------
Press CTRL-C to stop the connection

2024-11-18 09:59:19.854568 [STATUS] (StatusMajor.CONNECTION, 
StatusMinor.CFG_OK) 
config_path=/net/openvpn/v3/configuration/4c2bba36x2151x4291xb7acx360000375d2a
2024-11-18 09:59:19.854636 [LOG] Starting connection
2024-11-18 09:59:19.854694 [LOG] Using DNS resolver scope: global
2024-11-18 09:59:19.862369 [LOG] [Connect] DCO flag: disabled
2024-11-18 09:59:19.862479 [STATUS] (StatusMajor.CONNECTION, 
StatusMinor.CONN_CONNECTING)
2024-11-18 09:59:19.862548 [LOG] [Core] OpenVPN core v3.10.1 linux 
x86_64 64-bit OVPN-DCO
2024-11-18 09:59:19.862596 [LOG] [Core] Frame=512/2112/512 mssfix-ctrl=1250
2024-11-18 09:59:19.862636 [LOG] Resolving
2024-11-18 09:59:19.866525 [LOG] [Core] Contacting 103.6.170.21:1194 via UDP
2024-11-18 09:59:19.866638 [LOG] Waiting for server response
2024-11-18 09:59:19.878505 [LOG] [Core] Connecting to 
[103.6.170.21]:1194 (103.6.170.21) via UDP
2024-11-18 09:59:29.861733 [LOG] [Core] Server poll timeout, trying next 
remote entry...
2024-11-18 09:59:29.861875 [LOG] Resolving
2024-11-18 09:59:29.865648 [LOG] [Core] Contacting 103.6.170.21:1194 via UDP
2024-11-18 09:59:29.865769 [LOG] Waiting for server response
2024-11-18 09:59:29.876299 [LOG] [Core] Connecting to 
[103.6.170.21]:1194 (103.6.170.21) via UDP
2024-11-18 09:59:39.862254 [LOG] [Core] Server poll timeout, trying next 
remote entry...
2024-11-18 09:59:39.862347 [LOG] Resolving
2024-11-18 09:59:39.866157 [LOG] [Core] Contacting 103.6.170.21:1194 via UDP
2024-11-18 09:59:39.866262 [LOG] Waiting for server response
2024-11-18 09:59:39.877288 [LOG] [Core] Connecting to 
[103.6.170.21]:1194 (103.6.170.21) via UDP
2024-11-18 09:59:49.862757 [LOG] [Core] Server poll timeout, trying next 
remote entry...
2024-11-18 09:59:49.862852 [LOG] Resolving
2024-11-18 09:59:49.866514 [LOG] [Core] Contacting 103.6.170.21:1194 via UDP
2024-11-18 09:59:49.866614 [LOG] Waiting for server response
2024-11-18 09:59:49.875998 [LOG] [Core] Connecting to 
[103.6.170.21]:1194 (103.6.170.21) via UDP
2024-11-18 09:59:59.863047 [LOG] [Core] Server poll timeout, trying next 
remote entry...
2024-11-18 09:59:59.863179 [LOG] Resolving
2024-11-18 09:59:59.866699 [LOG] [Core] Contacting 103.6.170.21:1194 via UDP
2024-11-18 09:59:59.866798 [LOG] Waiting for server response
2024-11-18 09:59:59.876724 [LOG] [Core] Connecting to 
[103.6.170.21]:1194 (103.6.170.21) via UDP
2024-11-18 10:00:09.863146 [LOG] [Core] Server poll timeout, trying next 
remote entry...
2024-11-18 10:00:09.863242 [LOG] Resolving
2024-11-18 10:00:09.867305 [LOG] [Core] Contacting 103.6.170.21:1194 via UDP
2024-11-18 10:00:09.867406 [LOG] Waiting for server response
2024-11-18 10:00:09.879292 [LOG] [Core] Connecting to 
[103.6.170.21]:1194 (103.6.170.21) via UDP
2024-11-18 10:00:19.863499 [LOG] [Core] Server poll timeout, trying next 
remote entry...
2024-11-18 10:00:19.863623 [LOG] Resolving
2024-11-18 10:00:19.867758 [LOG] [Core] Contacting 103.6.170.21:1194 via UDP
2024-11-18 10:00:19.867845 [LOG] Waiting for server response
2024-11-18 10:00:19.879066 [LOG] [Core] Connecting to 
[103.6.170.21]:1194 (103.6.170.21) via UDP
^C
Disconnecting...
Connection statistics:
                     BYTES_OUT: 2814
                   PACKETS_OUT: 67
                   N_RECONNECT: 6
----------------------------------------------------------------------------

This needs to stop.  This is not a CVE.  This is an OpenVPN server which 
doesn't respond on port 1194/udp.

If you want to keep some kind of credibility with any security teams, 
you need to back down and spend time looking for real issues and 
document it far better.  And you will need to provide the server side 
perspective as well, not just the client side.

Once again: Clients not being able to connect to the server because of 
network connectivity issues is not a CVE.


This case is closed.


-- 
kind regards,

David Sommerseth
OpenVPN Inc



On 18/11/2024 08:37, נתי שטרן wrote:
> What can I do to assign a CVE?
>   I attached the CVE team of ISRAEL CERT  to conversation
> 
> tnx
> 
> ‫בתאריך יום ב׳, 18 בנוב׳ 2024 ב-9:29 מאת ‪Илья Шипицин‬‏ 
> <‪chipitsine@...277... <mailto:chipitsine@...277...>‬‏>:‬
> 
>     As many details as possible. Configuration file usually helps.
> 
>     Other than that also server side logs are nice to have. As well as
>     the detailed repro steps
> 
>     On Mon, Nov 18, 2024, 08:27 נתי שטרן <nsh531@...277...
>     <mailto:nsh531@...277...>> wrote:
> 
>         Do you want the configuration file?
> 
>         ‫בתאריך יום ב׳, 18 בנוב׳ 2024 ב-9:14 מאת ‪Gert Doering‬‏
>         <‪gert@...1296... <mailto:gert@...1296...>‬‏>:‬
> 
>             Hi,
> 
>             On Mon, Nov 18, 2024 at 09:09:57AM +0200, ?????? ???????? wrote:
>              > I don't have access to server logs, I sent you the client
>             logs as well as
>              > the line pointing to the DoS:
>              > TLS Error: TLS key negotiation failed to occur within 5
>             seconds
>              > SIGUSR1[soft,tls-error] received, process restarting
> 
>             What makes you think it's a DoS that can be fixed by a code
>             change?
> 
>             If you break the network, programs will not be able to
>             connect - and there
>             is nothing "a patch to the software" will be able to fix.
> 
>             gert
>             -- 
>             "If was one thing all people took for granted, was
>             conviction that if you
>               feed honest figures into a computer, honest figures come
>             out. Never doubted
>               it myself till I met a computer with a sense of humor."
>                                           Robert A. Heinlein, The Moon
>             is a Harsh Mistress
> 
>             Gert Doering - Munich, Germany gert@...1296...
>             <mailto:gert@...1296...>
> 
> 
> 
>         -- 
>         <https://netanel.ml>
>         _______________________________________________
>         Openvpn-devel mailing list
>         Openvpn-devel@lists.sourceforge.net
>         <mailto:Openvpn-devel@lists.sourceforge.net>
>         https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>         <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>
> 
> 
> 
> -- 
> <https://netanel.ml>




