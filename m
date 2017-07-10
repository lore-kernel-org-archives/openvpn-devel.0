MIME-Version: 1.0
Date: Mon, 10 Jul 2017 18:42:34 +1000
From: Steven Haigh <netwiz@...2277...>
In-Reply-To: <20170707140108.31612-1-a@...2181...>
References: <20170707140108.31612-1-a@...2181...>
Message-ID: <8be4bbbc48eb356b862fb93d6ffdff3a@...2277...>
Subject: Re: [Openvpn-devel] [PATCH] management: preserve wait_for_push
 field when asking for user/pass
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

For what its worth, further testing has shown that this works fine with 
~8 hours connection and 'reneg-sec 1800'

More than happy to call this resolved.

On 2017-07-08 00:01, Antonio Quartulli wrote:
> With the introduction of the wait_for_push field in the auth_user_pass
> structure, we have to make sure that such field is not accidentally
> erased when the management asks the user for user/pass.
> 
> Erasing such field would mess up the logic introduced by
> ("Ignore auth-nocache for auth-user-pass if auth-token is pushed").
> 
> Thanks to David Sommerseth for the preliminary analysis and debugging.
> 
> Reported-by: Steven Haigh <netwiz@...2277...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> Tested-by: Steven Haigh <netwiz@...2277...>
> ---
>  src/openvpn/manage.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
> index c2e8dc72..e850e0a4 100644
> --- a/src/openvpn/manage.c
> +++ b/src/openvpn/manage.c
> @@ -3504,7 +3504,9 @@ management_query_user_pass(struct management 
> *man,
>           */
>          if (ret)
>          {
> -            man->connection.up_query.nocache = up->nocache; /*
> preserve caller's nocache setting */
> +            /* preserve caller's settings */
> +            man->connection.up_query.nocache = up->nocache;
> +            man->connection.up_query.wait_for_push = 
> up->wait_for_push;
>              *up = man->connection.up_query;
>          }
>          secure_memzero(&man->connection.up_query,
> sizeof(man->connection.up_query));

-- 
Steven Haigh

? netwiz@...2277...     ? http://www.crc.id.au
? +61 (3) 9001 6090    ? 0412 935 897

