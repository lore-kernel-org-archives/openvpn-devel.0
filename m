References: <20201118145413.26134-1-huangya90@...277...>
 <6d6e3f68-60a8-73a5-611d-7cb84076e573@...515...>
 <CAAUX2SUd1NDj-UWe+p6Dp=QdL-0bt_0ApzpipXzZ=CUjoFjePQ@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <44180a2d-7bb6-b270-a77e-4a6842736165@...2181...>
Date: Thu, 19 Nov 2020 08:49:45 +0100
MIME-Version: 1.0
In-Reply-To: <CAAUX2SUd1NDj-UWe+p6Dp=QdL-0bt_0ApzpipXzZ=CUjoFjePQ@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] ovpn-dco: nestns-test.sh - fix the issue that
 veth is not created successfully
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Tony He <huangya90@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Tony,

On 19/11/2020 02:26, Tony He wrote:
> Hi Antonio,
>
> To confirm, I installed a Ubuntu 20.04 VM and saw it supports these two
> formates.
>
Thanks a lot for checking - this is what I imagined too.
The ip tool has introduced several shortcuts over time to make it more
user friendly.

Nonetheless, your patch has been applied so that our script can work on
older distros too.

Best Regards,



-- 
Antonio Quartulli

