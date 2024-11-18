Message-ID: <40bb96bf-436a-470d-95a8-e32dda9362b5@...2181...>
Date: Mon, 18 Nov 2024 11:51:36 +0100
MIME-Version: 1.0
References: <20241116051705.53061-1-shujifurukawa1213@...277...>
 <9dc5b9e8-652e-4f6c-b58a-a7d616d085bf@...2181...>
 <CA+WVei3qZDr4nhPhiL3diZQyEzMBJAbb=+4dJWgxyVX04-NChg@...278...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <CA+WVei3qZDr4nhPhiL3diZQyEzMBJAbb=+4dJWgxyVX04-NChg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Improve shuffling algorithm of
 connection list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?5Y+k5bed5L+u5oWI?= <shujifurukawa1213@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Thanks for your reply!
Please keep the mailing list in CC while replying.

See below:

On 18/11/2024 11:40, 古川修慈 wrote:
>  > We'd need a real name here, if possible, as this is a true signature
>  > telling us that you accepted the project license.
> Thanks for your feedback.
> My real name is Shuji Furukawa.
> Do I have to resend the patch?

Technically yes.

> 
>  > Is the the change above truly needed to achieve what you described in 
> the commit message?
>  > It's just changing the direction we iterate over the array, but it 
> should not make a real difference, no?
> You can run this simple simulation <http://tpcg.io/5SPPET> to understand 
> how effective this patch is.

Thanks for the link.
As mentioned in my earlier comment below, I was trying to figure out if 
reverting the looping direction could make any difference.

Not sure if you have seen that question?

In any case, I just made an attempt by myself, and indeed keeping the 
original direction still yields the same effectiveness:

http://tpcg.io/_L5Q0WX

Regards,


-- 
Antonio Quartulli


