Message-ID: <601664cb-18ee-4bb1-acc2-3d6b7b9c0e75@...2181...>
Date: Mon, 18 Nov 2024 14:17:16 +0100
MIME-Version: 1.0
References: <20241116051705.53061-1-shujifurukawa1213@...277...>
 <9dc5b9e8-652e-4f6c-b58a-a7d616d085bf@...2181...>
 <CA+WVei3qZDr4nhPhiL3diZQyEzMBJAbb=+4dJWgxyVX04-NChg@...278...>
 <40bb96bf-436a-470d-95a8-e32dda9362b5@...2181...>
 <CA+WVei21Q+u9cuemG-u1H_XXcDACFgSoLwB51-KnCOkgC4riVQ@...278...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <CA+WVei21Q+u9cuemG-u1H_XXcDACFgSoLwB51-KnCOkgC4riVQ@...278...>
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

don't forget to keep the mailing list in CC.
Your reply went to me only :)

If you click "Reply All" you will retain all recipients.

On 18/11/2024 13:18, 古川修慈 wrote:
> Thanks for your reply :)
> 
>  >
>  > Technically yes.
> I understand. I'll resend later.
> 
>> 
>> Thanks for the link.
>  > As mentioned in my earlier comment below, I was trying to figure out if
>  > reverting the looping direction could make any difference.
>  >
>  > Not sure if you have seen that question?
> 
> I'm sorry for misunderstanding your question earlier.
> 
> It’s not just about changing the direction of the iteration over the array.
> I also updated the following lines of code:
>  >
>  > -            const int j = get_random() % l->len;
>  > +            const int j = get_random() % (i + 1);
> This difference is crucial.

Absolutely!
My comment was only for the first line.

> 
>  >
>  > In any case, I just made an attempt by myself, and indeed keeping the
>  > original direction still yields the same effectiveness:
>  >
>  > http://tpcg.io/_L5Q0WX <http://tpcg.io/_L5Q0WX>
> Yes, your observation seems correct.
> This article <https://stackoverflow.com/questions/68064254/correctness- 
> of-fisher-yates-shuffle-executed-backward> summarizes the difference 
> between fisher_yates_shuffling and fisher_yates_shuffling2.
> 

Thanks for the pointer.
In any case you can also read here that what I proposed is just a 
variation of the original algorithm:

https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle#The_%22inside-out%22_algorithm

But the original version was proposed the way you wrote it.
For our specific case they are equivalent.

> In my opinion, fisher_yates_shuffling is easier to understand than 
> fisher_yates_shuffling2 because it simply ensures that we randomly 
> select an element only from the unshuffled portion.
> On the other hand, iterating from the beginning makes it harder to 
> understand why it produces a uniform permutation.
> That’s why I recommend iterating in the reverse direction.
> 

I don't really have a strong opinion, but if the Fisher Yates algorithm 
is described this way, I think it makes sense to follow that.

Feel free to resend your patch (possibly adding a "v2" in the subject so 
we understand that this is a new patch, i.e. "[PATCH v2]")

Regards,



-- 
Antonio Quartulli


