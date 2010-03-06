From: Stefan Monnier <monnier@...1268...>
Message-ID: <jwvbpf2z28q.fsf-monnier+inbox@...1269...>
References: <6c75f86b.6552e8f7.4b8bad61.2e7bd@...1309...>
	<4B8BB647.2020804@...1114...>
	<23627cf8.610acd4b.4b8bc540.d2023@...1309...>
	<eba800c91003011101v61fb1415l68146f00916b1c7@...278...>
	<7cd17813.52db77fa.4b901800.4e59d@...1309...>
	<jwvwrxq1nk3.fsf-monnier+gmane.network.openvpn.devel@...1269...>
	<1267826523966369500@...1315...>
Date: Sat, 06 Mar 2010 00:19:03 -0500
In-Reply-To: <1267826523966369500@...1315...> (openvpn@...1315...'s message
	of "Fri, 05 Mar 2010 16:02:03 -0600")
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Openvpn 2.1.1 bad tcp performance but good
	pingwhen -l 1472 (with packet size = MTU)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: openvpn@...1315...
Cc: openvpn-devel@lists.sourceforge.net

> That's a very good suggestion! I just tried this with OpenVPN-ALS
> (adito), and while the average performance is slightly lower (java
> vs. compiled code?), the throughput inconsistency is not there, rather
> it's only the case with OpenVPN!

IIUC OpenVPN-ALS is not comparable in that it works in a completely
different way which means it can't tunnel just any IP packets.
So, it doesn't suffer from "TCP-over-TCP" problems.


        Stefan

