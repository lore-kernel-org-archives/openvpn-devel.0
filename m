MIME-Version: 1.0
From: Tony He <huangya90@...277...>
Date: Sat, 2 Apr 2022 17:40:32 +0800
Message-ID: <CAAUX2SXYyxz-A_cWsf+ZuCyPkHz_O+D+fdZNS2p_7qV6fDR4EA@...278...>
Subject: [Openvpn-devel] [ovpn-dco] How to benchmark kernel crypto
 performance?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <antonio@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi Antonio,

I am porting ovpn-dco to embedded ARMv8 device with hardware crypto
engine. However the performance is not very good.
It's about 130-140Mbps. I expect more. The SDK already provides kernel
CryptoAPI(CFI) interface  to access the crypto engine.
I want to know if the crypto operation is the bottleneck. Do you know
how to benchmark crypto performance in the kernel space?
Any advice is welcome. Thank you!

Tony

