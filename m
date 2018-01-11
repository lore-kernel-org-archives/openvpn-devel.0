References: <1514540857-19290-1-git-send-email-steffan.karger@...1435...>
 <201801091431.w09EVeSP070386@...2054...>
 <c2b39501-3ec7-0c62-f1c6-96da33c46173@...1435...>
 <20180111140152.GP69387@...1296...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <a4b2a94e-6d88-9d90-357a-3ce691c0996b@...1435...>
Date: Thu, 11 Jan 2018 15:42:44 +0100
MIME-Version: 1.0
In-Reply-To: <20180111140152.GP69387@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH applied] Re: travis: use clang's
 -fsanitize=address to catch more bugs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On 11-01-18 15:01, Gert Doering wrote:
> On Thu, Jan 11, 2018 at 02:55:37PM +0100, Steffan Karger wrote:
>> On 09-01-18 15:31, Gert Doering wrote:
>>> ACK, makes sense.
>>>
>>> Your patch has been applied to the master branch.
>>
>> Thanks.  Can you also cherry-pick this one to release/2.4?  Because
>> there the clang builds are now screaming bloody murder (and sometimes
>> failing) because of ccache too.
> 
> Uh.  Which one?  *this* one is about -fsanitize-address...?
> 
> I assume you want this one:
> 
> commit 0c1b9864184e609b68c2bb317ee57317ae12a026
> Author: Ilya Shipitsin <chipitsine@...277...>
> Date:   Fri Jan 5 00:37:10 2018 +0500
> 
>     travis-ci: add brew cache, remove ccache
>     
> 
> 
> right?

Uh, right.  Though this one is useful too ;-)

-Steffan


