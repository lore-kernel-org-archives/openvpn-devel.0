Message-ID: <fa27e92c-5192-4f37-8a90-129ab90b592a@...1227...>
Date: Tue, 17 Mar 2026 01:06:27 +0100
MIME-Version: 1.0
References: <20260316224531.315912-1-luca.boccassi@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20260316224531.315912-1-luca.boccassi@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Fix password usage with ENABLE_PKCS11
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


Am 16.03.2026 um 23:43 schrieb luca.boccassi@...277...:
> From: Luca Boccassi <luca.boccassi@...277...>
>
> With ENABLE_PKCS11 USER_PASS_LEN is set to 4096 bytes.
>
> But if a user specifies a large password, as allowed by the limit,
> there are two places in the client that fail to handle it:
>
> - in the TLS handling functions a single read/write is done into/out of
>    the TLS layer, using a fixed size buffer at 2048 bytes, so the rest
>    of the password is truncated
> - in the management protocol when processing a "password" field another
>    fixed buffer at 256 bytes is used, so the rest of the password is
>    truncated
>
> Use int_max(xyz, USER_PASS_LEN) to define these buffers. In normal builds
> the current hardcoded values will stay the same, as they are higher.
> In ENABLE_PKCS11 builds the 4096 value will be higher which will allow
> longer passwords to work when communicating to the server and in the
> management protocol.
>
> Testing new client/old server shows no issues with a password that follows
> the existing 2048 bytes limit. In order to use a > 2048 bytes password,
> the server needs to be updated to this change too, otherwise it will truncate
> it, but that is the same as status quo: only passwords < 2048 bytes work, so
> there should be no regression.
>
> This enables the use case where JIT use-once tokens are used as passwords.
>
> Signed-off-by: Luca Boccassi <luca.boccassi@...277...>
> ---
> Alternative to:
>
> https://sourceforge.net/p/openvpn/mailman/openvpn-devel/thread/20260315230620.1594780-1-luca.boccassi%40gmail.com/#msg59309452
>
> Instead of hardcoding larger buffers, simply use USER_PASS_LEN, so that
> builds without ENABLE_PKCS11 are not affected.
>
> With these small changes, it is possible to successfully
> connect to an Azure VPN endpoint using the OpenVPN 2.7 client,
> using a dummy username, an Entra token as password and the
> server-secret from the azvpn XML config that users get as tls-auth
> key.
>
>   src/openvpn/common.h        | 2 +-
>   src/openvpn/manage.c        | 2 +-
>   src/openvpn/options.h       | 4 ++--
>   src/openvpn/options_parse.c | 2 +-
>   4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/src/openvpn/common.h b/src/openvpn/common.h
> index aa7b7217..e1096b98 100644
> --- a/src/openvpn/common.h
> +++ b/src/openvpn/common.h
> @@ -67,7 +67,7 @@ typedef unsigned long ptr_type;
>    * maximum size of a single TLS message (cleartext).
>    * This parameter must be >= PUSH_BUNDLE_SIZE
>    */
> -#define TLS_CHANNEL_BUF_SIZE 2048
> +#define TLS_CHANNEL_BUF_SIZE max_int(2048, USER_PASS_LEN) "

This would still mean that builds that use ENABLE_PKCS11 are 
potientially incompatible with builds without that flag and with older 
version.

Arne


