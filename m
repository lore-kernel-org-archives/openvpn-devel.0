Message-ID: <cb108ad5-3999-722a-65ef-36ef18f5bd75@...2181...>
Date: Sun, 3 Apr 2022 10:05:23 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <CAAUX2SXYyxz-A_cWsf+ZuCyPkHz_O+D+fdZNS2p_7qV6fDR4EA@...278...>
 <CAAUX2SW-ZR3WcCLsoY=m-b5rKFpyXF51M43k_c7rjYDzTLphKw@...278...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <CAAUX2SW-ZR3WcCLsoY=m-b5rKFpyXF51M43k_c7rjYDzTLphKw@...278...>
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Tony He <huangya90@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hey Tony,
On 03/04/2022 04:44, Tony He wrote:
>> Any advice is welcome. Thank you!

Debugging/profiling the fast path is never easy, but your method is 
definitely a reasonable approach.

Glad you already found the bottleneck.

An alternative is using the perf kernel tool, which tells you the amount 
of time spent in the various routines.


-- 
Antonio Quartulli

