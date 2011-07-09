Message-ID: <4E17B1F5.6040902@...1147...>
Date: Sat, 09 Jul 2011 03:42:13 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <1309389735487848500@...1315...>
In-Reply-To: <1309389735487848500@...1315...>
Subject: Re: [Openvpn-devel] Sporadic Long Ping Times
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Russell Morris <openvpn@...1315...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Russell Morris wrote:
> Hi,
>
> I have been measuring data throughput and RTT on my OpenVPN link (client to server), and while data throughput has been quite consistent (in the 25-30 Mb/s range), RTT (ping) has shown a strange artifact.
>
> If I run ping continuously (1 second interval), I may see 10 or 20 very consisten runs, at ~ 10 ms ... but then a single point at 200-250 ms. If I let it keep running this keeps happening - not with a consistent pattern, but about this rate.
>
> Has anyone else seen a similar artifact?
>   

ping RTT times over a VPN link can vary quite a bit, as I've noticed, 
esp after a lack of activity for some time. If the spikes happen every 
10 to 20 seconds , however, then I suspect the openvpn pings are getting 
in the way - try changing the 'ping' (or 'keepalive') options to
  ping 20
or
  keepalive 20 120
if the spikes now occur very 20 to 40 seconds then you've found the culprit.

HTH,

JJK


