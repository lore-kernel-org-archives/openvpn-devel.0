References: <CAAUX2SXYyxz-A_cWsf+ZuCyPkHz_O+D+fdZNS2p_7qV6fDR4EA@...278...>
From: Jan Just Keijser <jan.just.keijser@...277...>
Message-ID: <581cf124-143b-690c-37d2-72fb2bd0e39a@...277...>
Date: Tue, 5 Apr 2022 13:26:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAAUX2SXYyxz-A_cWsf+ZuCyPkHz_O+D+fdZNS2p_7qV6fDR4EA@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [ovpn-dco] How to benchmark kernel crypto
 performance?
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
To: Tony He <huangya90@...277...>, Antonio Quartulli <antonio@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

hi Tony,

On 02/04/22 11:40, Tony He wrote:
> Hi Antonio,
>
> I am porting ovpn-dco to embedded ARMv8 device with hardware crypto
> engine. However the performance is not very good.
> It's about 130-140Mbps. I expect more. The SDK already provides kernel
> CryptoAPI(CFI) interface  to access the crypto engine.
> I want to know if the crypto operation is the bottleneck. Do you know
> how to benchmark crypto performance in the kernel space?
> Any advice is welcome. Thank you!
>
a quick & dirty way to test the hardware crypto engine is to use the 
Linux cryptodev engine in combination with openssl ; it's a bit tricky 
to get it working but it *is* a nice way to test hardware crypto.

* https://github.com/cryptodev-linux/cryptodev-linux.git
* do a custom openssl build with
     ./Configure -DHAVE_CRYPTODEV -DUSE_CRYPTODEV_DIGESTS enable-engine 
enable-dso enable-devcryptoeng <platform>
* run openssl speed using
   ./openssl speed -elapsed -engine devcrypto -evp aes-128-cbc

and compare the results with "-engine devcrypto" removed.

HTH,

JJK




