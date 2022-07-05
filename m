Message-ID: <7bb3541f-1536-7010-66ad-f9f086b403b9@...2181...>
Date: Tue, 5 Jul 2022 20:47:54 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-22-a@...2181...> <5014411.ky3J9OlI6s@...2664...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <5014411.ky3J9OlI6s@...2664...>
Subject: Re: [Openvpn-devel] [PATCH 21/25] do_open_tun: restyle "can
 preserve TUN" check
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

On 05/07/2022 14:31, Heiko Hund wrote:
> On Freitag, 24. Juni 2022 10:38:05 CEST Antonio Quartulli wrote:
>> The current condition checking if the TUN interface was preserved is
>> dependant on the platform being Android or not. This makes the code
>> reasonably ugly, especially because uncrustify can't indent properly.
>>
>> On top of that, we will require an extra condition only for windows+DCO,
>> which will make the check even uglier.
>>
>> For this reason, factor out the check in a separate function which can
>> keep the ifdefs craziness well hidden, while do_open_tun becomes
>> (a bit) cleaner.
>>
>> Signed-off-by: Antonio Quartulli <a@...2181...>
> 
> Looks mighty, but is rather trivial. Two things:

Can also be reviewed with "git show -w" to highlight the real changes. 
Most of the diff is reindenting.

> 
> I think the code could benefit from factoring out the call to run_up_down()
> and block_outside_dns into two simple functions. Currently it's pretty much
> duplicated in the if and else branch. Besides that:

meat for another patch ;)

> 
> Acked-by: Heiko Hund <heiko@...2662...>

Thanks!

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

