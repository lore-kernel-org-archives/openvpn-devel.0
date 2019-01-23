Message-ID: <289bfe02fdabee00b91b555e7e5759f9.squirrel@...2260...>
In-Reply-To: <1cfa91c6-2c77-1d82-812b-269c941eba4d@...2489...>
References: <1cfa91c6-2c77-1d82-812b-269c941eba4d@...2489...>
Date: Wed, 23 Jan 2019 04:51:04 +0100
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Fix various spelling mistakes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Jonathan Tooker <jonathan@...2489...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

> diff --git a/src/openvpn/console.h b/src/openvpn/console.h
> index 0ffd6683..62beacae 100644
> --- a/src/openvpn/console.h
> +++ b/src/openvpn/console.h
> @@ -33,9 +33,9 @@
>   */
> struct _query_user {
>      char *prompt;             /**< Prompt to present to the user */
> -    size_t prompt_len;        /**< Lenght of the prompt string */
> +    size_t prompt_len;        /**< Length of the prompt string */
>      char *response;           /**< The user's response */
> -    size_t response_len;      /**< Lenght the of the user reposone */
> +    size_t response_len;      /**< Length the of the user reposone */
                                                             ^^^^^^^^
response

Regards,
Simon


