Message-ID: <0d08e6e1-28b1-43db-b5bb-84ca4135f32f@...1227...>
Date: Mon, 18 Nov 2024 10:46:27 +0100
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
 <CAC8x_z25BWNsGfTbJTk2000D_DHN0tTWBUzSO7USzqwh0VSAGw@...278...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Gert Doering <gert@...1296...>, Antonio Quartulli <antonio@...515...>, SECURITY@...515...

Am 18.11.24 um 08:37 schrieb נתי שטרן:
> What can I do to assign a CVE?
>   I attached the CVE team of ISRAEL CERT  to conversation

Report something that is considered a vulnerability.

For the CVE team included in the CC:

The reporter has submitted logs around the

TLS Error: TLS key negotiation failed to occur within 5 seconds
SIGUSR1[soft,tls-error] received, process restarting

from the client that indicate a normal connection problem together with 
exponential backoff. He claims this is a server side DoS. The OpenVPN 
team strongly disagrees based on the logs and lack of any other evidence.

Arne

