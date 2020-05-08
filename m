References: <20200508212356.18522-1-a@...2181...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <44e59dab-49dc-a27d-d6b9-139ad2e1d377@...2181...>
Date: Fri, 8 May 2020 23:25:30 +0200
MIME-Version: 1.0
In-Reply-To: <20200508212356.18522-1-a@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] get rid of TAG_FILE_INLINE constant
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

I managed to totally revert the name of the constant in the commit
subject and commit message..

may somebody fix this upon merge? :-)

It should be: INLINE_FILE_TAG

Cheers,

On 08/05/2020 23:23, Antonio Quartulli wrote:
> Now that the whole inline logic has been converted to using bool flags,
> the TAG_FILE_INLINE constant is not useful anymore.
> 
> Get rid of the constant as it's now unused and to prevent any future
> developer from mistakenly use it again.
> 
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
> 
> to be applied after all other fixes, as they remove the few last usages
> of this constant.
> 
> 
>  src/openvpn/common.h | 6 ------
>  src/openvpn/crypto.c | 2 +-
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/src/openvpn/common.h b/src/openvpn/common.h
> index 4e6f4809..623b3e0d 100644
> --- a/src/openvpn/common.h
> +++ b/src/openvpn/common.h
> @@ -88,12 +88,6 @@ typedef unsigned long ptr_type;
>   */
>  #define PUSH_REQUEST_INTERVAL 5
>  
> -/*
> - * A sort of pseudo-filename for data provided inline within
> - * the configuration file.
> - */
> -#define INLINE_FILE_TAG "[[INLINE]]"
> -
>  /*
>   * Script security warning
>   */
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index 672aa14a..f1a52d8c 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -1189,7 +1189,7 @@ print_key_filename(const char *str, bool is_inline)
>  {
>      if (is_inline)
>      {
> -        return INLINE_FILE_TAG;
> +        return "[[INLINE]]";
>      }
>  
>      return np(str);
> 

-- 
Antonio Quartulli

