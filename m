Message-ID: <5448B3C9.4010403@...1435...>
Date: Thu, 23 Oct 2014 09:52:41 +0200
From: Steffan Karger <steffan.karger@...1435...>
MIME-Version: 1.0
References: <CAGyAFMXhPTamN5tZYr92=re8Bhxky=priWS8UhCU3E_p2D8-mQ@...278...>	<CAGyAFMV6kZzTFwdp21n8GTNa-fbPx_S-TpYjpiC+R862WoMhAA@...278...>	<53B03B43.2040009@...1227...>
	<53BD10EB.9010509@...1227...>	<alpine.DEB.2.02.1408121108120.3669@...1831...>	<CAGyAFMVzDaygh1d-jtZSRXYqq+hm5qphmtEQE8f7eyhpD8Am_w@...278...>	<5436E6E5.8060002@...1856...>
	<CAGyAFMUQnZYLNAeLeAw4SR7zJgmqc1k+mgEwBKwL+TXLAOU2ZA@...278...>
In-Reply-To: <CAGyAFMUQnZYLNAeLeAw4SR7zJgmqc1k+mgEwBKwL+TXLAOU2ZA@...278...>
Subject: Re: [Openvpn-devel] session-id implementation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi Lev,

On 10/21/2014 09:33 AM, Lev Stipakov wrote:
> 
> Thanks for your comments. I have fixed (1) and (2) - well, reusing
> existing code in (2) has fixed also (1).

Thanks! Do you have the patch somewhere for us to look at?

> Regarding (3) - I don't have much experience in crypto thing, so it
> would be nice if someone suggests if we should use another alignment.

From later discussions I get the feeling the alignment was not crypto
related.

Also, alignment for crypto is very platform-specific. e.g. AES-NI
instructions require 128-bit alignment for maximum speed. Though it
depends on the crypto mode and implementation whether the data we supply
it is directly used or not.

The main accelerated crypto mode currently is AES-GCM, and that does not
run the data through the crypto (but rather encrypts counters, and then
XORs the result with the data). So I wouldn't worry too much about that
for now.

-Steffan

