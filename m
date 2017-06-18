References: <CAA1AbxLbVut1Z8pWF78kD=vy3rx5mxDf8MyDSR4BpxfbXoQZiQ@...278...>
	<20170612134330.20971-1-logout@...260...>
	<20170612134330.20971-9-logout@...260...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <b7ff5d37-3a94-bcb4-6d3b-9c5bb29e2e32@...1856...>
Date: Sun, 18 Jun 2017 09:27:41 +0200
MIME-Version: 1.0
In-Reply-To: <20170612134330.20971-9-logout@...260...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 8/8] OpenSSL: force meth->name as
 non-const when we free() it
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


On 12-06-17 15:43, logout@...260... wrote:
> From: Emmanuel Deloget <logout@...260...>
> 
> We are in control of meth->name (we string_alloc() it in RSA_meth_new())
> so we know that we can free() it when it's no longer needed. Yet we have
> to force the value to be non-const to avoid a compiler warning -- due to
> the fact that OpenSSL defines the value as a const char*, regardless of
> its origin.
> ---
>  src/openvpn/openssl_compat.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
> index 71ecfc06..69db6fb5 100644
> --- a/src/openvpn/openssl_compat.h
> +++ b/src/openvpn/openssl_compat.h
> @@ -493,7 +493,12 @@ RSA_meth_free(RSA_METHOD *meth)
>  {
>      if (meth)
>      {
> -        free(meth->name);
> +        /* OpenSSL defines meth->name to be a const pointer, yet we
> +         * feed it with an allocated string (from RSA_meth_new()).
> +         * Thus we are allowed to free it here. In order to avoid a
> +         * ‘free’ discards ‘const’ warning, we force the pointer to
> +         * be a non-const value. */
> +        free((char *)meth->name);
>          free(meth);
>      }
>  }
> 

Silences the warning and explains why the code does what it does, which
I agree is the correct way to work around OpenSSL API funkyness.

ACK

-Steffan

