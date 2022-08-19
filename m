Message-ID: <07fd400b-1031-5b89-ec96-dbf1e98d43f6@...2181...>
Date: Fri, 19 Aug 2022 12:10:48 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220818201505.656149-1-frank@...2641...>
 <20220818201505.656149-2-frank@...2641...>
 <6e140f92-f71f-35e8-cd3b-914949ef24b5@...2181...>
 <52da546c-3890-c073-aea7-a620db92520d@...1227...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <52da546c-3890-c073-aea7-a620db92520d@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] uncrustify: remove newlines after
 return type of function prototype
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
To: Arne Schwabe <arne@...1227...>, Frank Lichtenheld <frank@...2641...>, openvpn-devel@lists.sourceforge.net

Hi,

On 19/08/2022 11:50, Arne Schwabe wrote:
> Am 18.08.22 um 22:43 schrieb Antonio Quartulli:
>> yes! This is what we need!
>>
>> Acked-by: Antonio Quartulli <a@...2181...>
>>
> 
> I am out of the loop here. Could you two explain why we need this? I.e. 
> what is wrong with the current style is and what the plan is to change?
> 
> If often struggle to properly format function with the soft limit of 80 
> without being allowed to put the return type on a separate line. So I am 
> not sure what the improvement of this change is.
> 

We are not changing the style here.

Basically we have originally started using this approach (when we 
discussed the style back with Steffan some years ago):

* prototypes: return type on the same line as the function name (makes 
the first line a bit longer, but normally is not a big deal). Should the 
line be too long to make the name fit within the 100chars limit we have, 
you can still go to a new line, but should really be an exception.

* function definitions: return type on its own line.

Basically it's just a matter of style, not convenience.

Note: this has been like this since a while. Only a few occurrences were 
not respecting this style (and Frank is fixing those in 1/2).

Cheers,

> Arne

-- 
Antonio Quartulli

