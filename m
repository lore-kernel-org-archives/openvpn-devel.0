Message-ID: <82df15bb-dcbd-43d9-b47f-fbc80c2b14f2@...2181...>
Date: Mon, 18 Nov 2024 16:11:36 +0100
MIME-Version: 1.0
References: <20241118142019.31045-1-shujifurukawa1213@...277...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20241118142019.31045-1-shujifurukawa1213@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] Improve shuffling algorithm of
 connection list
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
To: Hurukawa2121 <shujifurukawa1213@...277...>, openvpn-devel@lists.sourceforge.net

Thanks for resending the patch!

On 18/11/2024 15:20, Hurukawa2121 wrote:
> ---

However, please note that anything you write should go *before* these 
three dashes, otherwise the text is ignored by git on commit.

Anyway, no need to resend the patch for this.
Probably Gert can easily fix this before moving forward with your patch.

>   Improve shuffling algorithm of connection list
> 
>   This patch implements the Fisher-Yates shuffle algorithm to ensure that all permutations of the connection target list are generated with equal probability, eliminating biases present in the previous shuffling method. In the Fisher-Yates algorithm, there's only one way to obtain each permutation through a series of element swaps, so all permutations occur with equal probability in theory.

Also one single loooong line in the commit message is absolutely not 
acceptable.
Better to split the text in lines no longer than 72 chars.
Technically Gert can fix this too upon commit.

But please do remember these details for your next patch.

> 
>   Signed-off-by: Shuji Furukawa <shujifurukawa1213@...277...>

>   src/openvpn/init.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 9371024e..c4fb5cd7 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -467,7 +467,14 @@ ce_management_query_remote(struct context *c)
>   #endif /* ENABLE_MANAGEMENT */
>   
>   /*
> - * Initialize and possibly randomize connection list.
> + * Initialize and randomize the connection list.
> + *
> + * Applies the Fisher-Yates shuffle algorithm to ensure all permutations are equally probable,
> + * thereby eliminating shuffling bias in the previous method.
> + *
> + * The algorithm randomly selects an element from the unshuffled portion and places it at position i.
> + * There's only one way to obtain each permutation through these swaps.
> + * This guarantees that each permutation occurs with equal probability in theory.

Same goes for comments (and any other line of code):
maximum line length is 80 chars..

This said, the patch looks good to me and I can apply my

Acked-by: Antonio Quartulli <antonio@...2726...>

However, I live it to Gert if he wants a new patch with these layout 
errors fixed or not.

Regards,



>    */
>   static void
>   init_connection_list(struct context *c)
> @@ -478,9 +485,9 @@ init_connection_list(struct context *c)
>       if (c->options.remote_random)
>       {
>           int i;
> -        for (i = 0; i < l->len; ++i)
> +        for (i = l->len - 1; i > 0; --i)
>           {
> -            const int j = get_random() % l->len;
> +            const int j = get_random() % (i + 1);
>               if (i != j)
>               {
>                   struct connection_entry *tmp;

-- 
Antonio Quartulli


