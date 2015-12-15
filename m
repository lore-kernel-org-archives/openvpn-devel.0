From: David Sommerseth <openvpn@...2080...>
References: <1450123758-31641-1-git-send-email-steffan@...1856...>
Message-ID: <566F5B01.8020109@...2080...>
Date: Tue, 15 Dec 2015 01:12:49 +0100
MIME-Version: 1.0
In-Reply-To: <1450123758-31641-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Warn user if their certificate has
 expired
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net


On 14/12/15 21:09, Steffan Karger wrote:
> Previously, client certificate expiry warnings would only visible in the
> server log, and server certificate expiry warnings in the client log.
> Both after a (failed) connection attempt.  This patch adds a warning to
> log when a users own certificate has expired (or is not yet valid) to ease
> problem diagnosis / error reporting.
> 
> Note that this is just a warning, since on some systems (notably embedded
> devices) there might be no correct time available.
> 
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>  src/openvpn/ssl.c          |  3 +++
>  src/openvpn/ssl_backend.h  |  9 +++++++++
>  src/openvpn/ssl_openssl.c  | 27 +++++++++++++++++++++++++++
>  src/openvpn/ssl_polarssl.c | 14 ++++++++++++++
>  4 files changed, 53 insertions(+)
> 
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 887bd75..665fdd7 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
[...snip...]
>  
>  void
> +tls_ctx_check_cert_time (const struct tls_root_ctx *ctx)
> +{
> +  int ret;
> +  const X509 *cert = SSL_CTX_get0_certificate(ctx->ctx);

Hi,

Just tried to build openvpn on one of my laptops (Scientific Linux 7.1,
openssl-1.0.1e-42.el7).  And it explodes when reaching the
SSL_CTX_get0_certificate(), it seems that support arrived in OpenSSL 1.0.2?
Could that be right?  Haven't had brainpower yet to dig deeper.

I will retry a build on my work laptop too (RHEL 7.2) tomorrow, to see if this
is an issue there too.


-- 
kind regards,

David Sommerseth

-- 
kind regards,

David Sommerseth

