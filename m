References: <1509192147.3021.6.camel@...2316...>
 <1509192205.3021.7.camel@...2316...>
 <CAFHpkQHXWrXn42B1xr0YuPvQUrOSvUqQU6h8RkP_EgP_iBP5Qw@...278...>
 <1509289652.3116.11.camel@...2316...>
 <72a75ffb-67df-0986-7b64-9080254cc084@...2181...>
 <1509292633.3116.16.camel@...2316...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <d2079a55-a8c4-95be-4385-75d164a9f8c5@...1856...>
Date: Wed, 1 Nov 2017 19:24:02 +0100
MIME-Version: 1.0
In-Reply-To: <1509292633.3116.16.camel@...2316...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/1] openssl: add engine method for
 loading the key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 29-10-17 16:57, James Bottomley wrote:
> On Sun, 2017-10-29 at 23:15 +0800, Antonio Quartulli wrote:
>> James,
>>
>> could you please resend a full patch, so to have a better overview of
>> the whole change?
> 
> Sure thing.  It's below.

Feature makes sense, so feature-ACK.  An early question though:

> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -969,4 +969,59 @@ hmac_ctx_final(HMAC_CTX *ctx, uint8_t *dst)
>      HMAC_Final(ctx, dst, &in_hmac_len);
>  }
>  
> +#ifdef HAVE_OPENSSL_ENGINE
> +static int
> +ui_read(UI *ui, UI_STRING *uis)
> +{
> +    SSL_CTX *ctx = UI_get0_user_data(ui);
> +
> +    if (UI_get_string_type(uis) == UIT_PROMPT) {
> +        pem_password_cb *cb = SSL_CTX_get_default_passwd_cb(ctx);
> +        void *d = SSL_CTX_get_default_passwd_cb_userdata(ctx);
> +        char password[64];
> +
> +        cb(password, sizeof(password), 0, d);
> +        UI_set_result(ui, uis, password);
> +
> +        return 1;
> +    }
> +    return 0;
> +}
> +#endif

This looks like it should use our user query wrappers from (e.g.)
console.h.  David, you're the expert here, what should James use to
query for passwords?

-Steffan

