Message-ID: <9c25be83-47c2-f392-8468-861fc889687f@...2181...>
Date: Mon, 4 Jul 2022 10:33:21 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-16-a@...2181...>
 <YsKlBU1KKqbSE/Ch@...2678...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <YsKlBU1KKqbSE/Ch@...2678...>
Subject: Re: [Openvpn-devel] [PATCH 15/25] dco: add documentation for
 ovpn-dco-linux
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 04/07/2022 10:29, Frank Lichtenheld wrote:
> On Fri, Jun 24, 2022 at 10:37:59AM +0200, Antonio Quartulli wrote:
> [...]
>> +Current implementation limitations
>> +-------------------
>> +- --persistent-tun not tested/supported
>> +- fallback to non-dco in client mode missing
>> +- IPv6 mapped IPv4 addresses need Linux 5.4.189+/5.10.110+/5.12+ to work
>> +- Some incompatible options may not properly fallback to non-dco
>> +- TCP performance with ovpn-dco can still exhibit bad behaviour and drop to a
>> +  few megabits per seconds
> 
> Any way of qualifying this? Should one not use TCP mode at all currently? Or is
> this rare? Any workarounds?

Good point. It was fairly rare, but we never dug in too much.
However, no extra tests were performed after ovpn-dco got quite 
refactored, so the problem may have gone.

More tests would be needed to confirm the issue.

Cheers,

-- 
Antonio Quartulli

