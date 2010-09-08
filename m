Message-ID: <4C87A3FE.9080807@...1147...>
Date: Wed, 08 Sep 2010 16:55:58 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
Subject: [Openvpn-devel] shaper broken in openvpn 2.1.1 linux clients?
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
To: openvpn-devel@lists.sourceforge.net

hi all,

is the option
  shaper 100000
broken in openvpn 2.1.1 on linux? If I add this option to a client 
config I get very erratic behaviour when running iperf:
- performance is absolute crap
- after iperf has finished the link remain active doing something but is 
not responding; after about 20 seconds I can ping the remote end again.

Same host, same client, different openvpn version (2.0.9) and I get 
exactly the behaviour that I expected ie
  shaper 100000
gives me 100 KB/s upload speed using iperf.

thanks for any input,

JJK


