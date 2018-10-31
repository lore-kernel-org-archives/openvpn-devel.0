References: <87a06f64-26df-d1f2-3039-08f8addfaa3b@...277...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <af320fbc-24f3-fe4b-3de2-770ec11b2fbe@...1435...>
Date: Wed, 31 Oct 2018 09:12:25 +0100
MIME-Version: 1.0
In-Reply-To: <87a06f64-26df-d1f2-3039-08f8addfaa3b@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Correct error message for
 --tls-crypt-v2-genkey client
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

On 31-10-18 00:20, tincanteksup wrote:
> Correct error message for --tls-crypt-v2-genkey client
> 
> Signed-off-by: Richard Bonhomme <tincanteksup@...277...>
> ---
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 882337b2..39e8ca5f 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -1087,7 +1087,7 @@ do_genkey(const struct options *options)
>          {
>              if (!options->tls_crypt_v2_file)
>              {
> -                msg(M_USAGE, "--tls-crypt-v2-gen-client-key requires a
> server key to be set via --tls-crypt-v2");
> +                msg(M_USAGE, "--tls-crypt-v2-genkey requires a server
> key to be set via --tls-crypt-v2 to create a client key");
>              }
> 
> 
> tls_crypt_v2_write_client_key_file(options->tls_crypt_v2_genkey_file,

This is a remnant of one of the earlier patch versions, where the option
was named differently.  Thanks for spotting and supplying the fix.

Acked-by: Steffan Karger <steffan.karger@...1435...>

-Steffan

