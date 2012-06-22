Message-ID: <4FE4A29E.8070000@...1737...>
Date: Fri, 22 Jun 2012 17:51:42 +0100
From: Ed W <lists@...1737...>
MIME-Version: 1.0
References: <CALb=60Z=zh1dWx5B1oum9D7GBgGhEXi0v1S1fFCD8DhtAyw6WA@...278...>
	<4FE447A5.4010604@...515...>
In-Reply-To: <4FE447A5.4010604@...515...>
Subject: Re: [Openvpn-devel] [PATCH] OCC ping
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

On 22/06/2012 11:23, Samuli Sepp=E4nen wrote:
> First, is the primary purpose of the patch to save power on the mobile
> clients? If so, wouldn't it be simpler to just have the client
> disconnect when it notices that the connection is not being used and
> reconnect dynamically when there's usage?

That appears to stop you sending stuff from the server to the client and=20
also breaks long running connections?

eg client connects to IMAP server, issues IDLE and waits for the mail=20
server to tell it that some new message has arrived in some folder.  If=20
the connection isn't there then you can't hear a "new mail" response.=20=20
Equally if there is no new mail for 30 mins then you want to keep the=20
radio idle for as much time as possible


Just for reference turning on the radio in a mobile device is a=20
massively power hungry step.  You can go from hours of battery life to=20
days of battery life if you can move from rapid wake ups (60s or less),=20
to less rapid wakeups (5-30 mins)

However, note to implementors.  Most NAT devices close down UDP mappings=20
in 90s or less.  Most TCP NAT mappings are kept open for much longer -=20
don't have the numbers in front of me, but I will guess at 10-30 mins=20
being a lower bound for most setups (many firewalls being massively=20
longer than that, eg 60min+).  Therefore with a UDP VPN you will likely=20
need 60sec (worst case 90secs) keep alive packets to keep NAT pin holes=20
open.  Keeping these packets tiny (\r\n) and not responding=20
unnecessarily is helpful... (halves the bandwidth)

Cheers

Ed W




