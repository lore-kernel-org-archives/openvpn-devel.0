References: <20200909120707.8663-1-gert@...1296...>
 <20200909122223.9222-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <f550e368-a634-e4ee-5f3a-59a84c095ae3@...2181...>
Date: Mon, 14 Sep 2020 09:44:21 +0200
MIME-Version: 1.0
In-Reply-To: <20200909122223.9222-1-gert@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3] socks.c: fix alen for DOMAIN type
 addresses, bump up buffer sizes
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 09/09/2020 14:22, Gert Doering wrote:
> diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
> index 57f0cee2..d43d84a8 100644
> --- a/src/openvpn/socks.c
> +++ b/src/openvpn/socks.c
> @@ -312,7 +312,7 @@ recv_socks_reply(socket_descriptor_t sd,
>      char atyp = '\0';
>      int alen = 0;
>      int len = 0;
> -    char buf[22];
> +    char buf[270];		/* 4 + alen(max 256) + 2 */
>      const int timeout_sec = 5;
>  
>      if (addr != NULL)
> @@ -381,7 +381,10 @@ recv_socks_reply(socket_descriptor_t sd,
>                      break;
>  
>                  case '\x03':    /* DOMAINNAME */
> -                    alen = (unsigned char) c;
> +                    /* RFC 1928, section 5: 1 byte length, <n> bytes name,
> +                     * so the total "address length" is (length+1)
> +                     */
> +                    alen = (unsigned char) c +1;

since you are touching this line...how about making it straight?
1) why casting to unsigned char? "alen" is int.
2) please add a space after the '+' operator.

Regards,


-- 
Antonio Quartulli

