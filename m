Message-ID: <86ed17d1-c5d8-024a-1b06-9b07aa1d15ce@...2181...>
Date: Mon, 14 Mar 2022 18:22:53 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20220314162048.22955-1-a@...2181...>
 <404808391.276382.1647276886162@...2642...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <404808391.276382.1647276886162@...2642...>
Subject: Re: [Openvpn-devel] [PATCH] remove unused sitnl.h file
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
To: Frank Lichtenheld <frank@...2641...>, openvpn-devel@lists.sourceforge.net

Hi,

On 14/03/2022 17:54, Frank Lichtenheld wrote:
> 
> 
>> Antonio Quartulli <a@...2181...> hat am 14.03.2022 17:20 geschrieben:
>>
>>   
>> sitnl.h must have slipped in when implementing the networking AI and the
>> SITNL backend. However it is unused and should simply be removed.
> 
> We have an AI? ;)
> (I assume this should read API?)

Yes, indeed, it should be API.

Regards,


-- 
Antonio Quartulli

