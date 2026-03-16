Message-ID: <fff53190-2aa8-462b-ac69-c945c91094f5@...1227...>
Date: Mon, 16 Mar 2026 13:01:13 +0100
MIME-Version: 1.0
References: <20260315184337.1541272-1-luca.boccassi@...277...>
 <20260315230620.1594780-1-luca.boccassi@...277...>
 <20260315230620.1594780-4-luca.boccassi@...277...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20260315230620.1594780-4-luca.boccassi@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2 3/3] Ensure the management channel
 can take passwords up to the max length
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
To: luca.boccassi@...277..., openvpn-devel@lists.sourceforge.net

Am 16.03.26 um 00:05 schrieb luca.boccassi@...277...:
> From: Luca Boccassi <luca.boccassi@...277...>
> 
> These hardcoded limits are different than the password size limit.
> Use the macro to ensure a password can always fit via the management
> channel, otherwise when long passwords are used (e.g.: tokens) they
> will be silently dropped.

> index 3d8b5059..4fafdc52 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -51,10 +51,10 @@
>   #define MAX_PARMS 16
>   
>   /*
> - * Max size of options line and parameter.
> + * Max size of options line and parameter. Ensure a password can fit.
>    */
> -#define OPTION_PARM_SIZE 256
> -#define OPTION_LINE_SIZE 256
> +#define OPTION_PARM_SIZE USER_PASS_LEN
> +#define OPTION_LINE_SIZE USER_PASS_LEN
>   
>   extern const char title_string[];
>   

You are changing quite fundamental limit in the parser without any 
regards to anything outside your own use case. You will need a lot more 
convincing to get something like that accepted.

Arne

