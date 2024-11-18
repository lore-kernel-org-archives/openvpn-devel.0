Message-ID: <9dc5b9e8-652e-4f6c-b58a-a7d616d085bf@...2181...>
Date: Mon, 18 Nov 2024 10:33:29 +0100
MIME-Version: 1.0
References: <20241116051705.53061-1-shujifurukawa1213@...277...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20241116051705.53061-1-shujifurukawa1213@...277...>
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Hurukawa2121 <shujifurukawa1213@...277...>, openvpn-devel@lists.sourceforge.net

Hi,

On 16/11/2024 06:17, Hurukawa2121 wrote:
> ---
>   Improve shuffling algorithm of connection list
> 
>   This patch implements the Fisher-Yates shuffle algorithm to ensure that all permutations of the connection target list are generated with equal probability, eliminating biases present in the previous shuffling method. In the Fisher-Yates algorithm, there's only one way to obtain each permutation through a series of element swaps, so all permutations occur with equal probability in theory.
>   
>   Signed-off-by: Hurukawa2121 <shujifurukawa1213@...277...>

We'd need a real name here, if possible, as this is a true signature 
telling us that you accepted the project license.

> 
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
>    */
>   static void
>   init_connection_list(struct context *c)
> @@ -478,9 +485,9 @@ init_connection_list(struct context *c)
>       if (c->options.remote_random)
>       {
>           int i;
> -        for (i = 0; i < l->len; ++i)
> +        for (i = l->len - 1; i > 0; --i)

Is the the change above truly needed to achieve what you described in 
the commit message?
It's just changing the direction we iterate over the array, but it 
should not make a real difference, no?

Regards,

>           {
> -            const int j = get_random() % l->len;
> +            const int j = get_random() % (i + 1);
>               if (i != j)
>               {
>                   struct connection_entry *tmp;

-- 
Antonio Quartulli


