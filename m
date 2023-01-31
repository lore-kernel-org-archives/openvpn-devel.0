Date: Tue, 31 Jan 2023 11:52:57 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y9jzCa6k5YPndTTT@...2685...>
References: <20230130172936.3444840-1-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20230130172936.3444840-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] Fix unaligned access in auth-token
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Jan 30, 2023 at 06:29:32PM +0100, Arne Schwabe wrote:
> The undefined behaviour USAN clang checker found this. The optimiser
> of clang/gcc will optimise the memcpy away in the auth_token case and output
> excactly the same assembly on amd64/arm64 but it is still better to not rely
> on undefined behaviour.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/auth_token.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
> index 7b963a9c5..e4486eb08 100644
> --- a/src/openvpn/auth_token.c
> +++ b/src/openvpn/auth_token.c
> @@ -324,8 +324,14 @@ verify_auth_token(struct user_pass *up, struct tls_multi *multi,
>      const uint8_t *tstamp_initial = sessid + AUTH_TOKEN_SESSION_ID_LEN;
>      const uint8_t *tstamp = tstamp_initial + sizeof(int64_t);
>  
> -    uint64_t timestamp = ntohll(*((uint64_t *) (tstamp)));
> -    uint64_t timestamp_initial = ntohll(*((uint64_t *) (tstamp_initial)));
> +    /* tstamp, tstamp_initial might not be aligned to an uint64, use memcpy
> +     * to avoid unaligned access */
> +    uint64_t timestamp = 0, timestamp_initial = 0;
> +    memcpy(&timestamp, tstamp, sizeof(uint64_t));
> +    timestamp = ntohll(timestamp);
> +
> +    memcpy(&timestamp_initial, tstamp_initial, sizeof(uint64_t));
> +    timestamp_initial = ntohll(timestamp_initial);
>  
>      hmac_ctx_t *ctx = multi->opt.auth_token_key.hmac;
>      if (check_hmac_token(ctx, b64decoded, up->username))

Acked-By: Frank Lichtenheld <frank@...2641...>

Trivial enough.

Regards,
-- 
  Frank Lichtenheld

