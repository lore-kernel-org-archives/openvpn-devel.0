Message-ID: <7cc6b966-b915-1e65-dcd6-05c50f842a23@...2181...>
Date: Mon, 18 Jul 2022 22:31:59 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-9-a@...2181...> <4973410.uatBhfvki3@...2664...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <4973410.uatBhfvki3@...2664...>
Subject: Re: [Openvpn-devel] [PATCH 08/25] dco: allow user to disable it at
 runtime
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
To: Heiko Hund <heiko@...2662...>, openvpn-devel@lists.sourceforge.net

Hi,

On 05/07/2022 14:32, Heiko Hund wrote:
> On Freitag, 24. Juni 2022 10:37:52 CEST Antonio Quartulli wrote:
>> +    else if (streq(p[0], "disable-dco") || streq(p[0], "dco-disable"))
> 
> Don't think we need to be backwards compatible here, or do we?

There's nothing to be backwards compatible with.
Thanks for highlighting this.

I am removing "dco-disable" in v2.

Cheers,

> 
> 
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

-- 
Antonio Quartulli

