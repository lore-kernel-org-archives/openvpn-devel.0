Sender: Trochalakis Christos <yatiohi@...277...>
Date: Wed, 18 Nov 2015 16:48:06 +0200
From: Christos Trochalakis <yatiohi@...2090...>
Message-ID: <20151118144806.GA975@...2091...>
References: <20151118140650.GA1040@...2091...>
	<20151118143704.GR24952@...1296...>
MIME-Version: 1.0
In-Reply-To: <20151118143704.GR24952@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Adjust server-ipv6 documentation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hello Gert,

On Wed, Nov 18, 2015 at 03:37:04PM +0100, Gert Doering wrote:
>Hi,
>
>On Wed, Nov 18, 2015 at 04:06:50PM +0200, Christos Trochalakis wrote:
>>  o --server-ipv6 is incompatible with the 'nopool' option
>>  o ifconfig-ipv6-pool starts at 0x1000 and not 0x10000 since v2.3
>>    c55e9562: Implement IPv6 interface config with non-/64 prefix lengths
>>
>> Signed-off-by: Christos Trochalakis <yatiohi@...2090...>
>
>Uh, yes, in principle, but...
>
>>     * push "tun-ipv6"
>>     * ifconfig-ipv6 2001:db8::1 2001:db8::2
>> -   * if !nopool:
>> -   *   ifconfig-ipv6-pool 2001:db8::1:0/64
>> +   * ifconfig-ipv6-pool 2001:db8::1000/64
>
>... the "if !nopool" should still be there, no?
>

If I understand correctly 'nopool' option is only valid for --server and not
--server-ipv6.


