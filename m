References: <324fcf27-5a5a-62a7-f77d-cd279f46c712@...2080...>
 <20190808145129.1142-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <f5258f61-c751-00a8-df92-5089bea2cb9e@...2080...>
Date: Fri, 16 Aug 2019 19:13:14 +0200
MIME-Version: 1.0
In-Reply-To: <20190808145129.1142-1-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v6 4/7] Rewrite auth-token-gen to be
 based on HMAC based tokens
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 08/08/2019 16:51, Arne Schwabe wrote:
> The previous auth-token implementation had a serious problem, especially when
> paired with an unpatched OpenVPN client that keeps trying the auth-token
> (commit e61b401a).
> 
> The auth-token-gen implementation forgot the auth-token on reconnect, this
> lead to reconnect with auth-token never working.
> 
> This new implementation implements the auth-token in a stateles variant. By
> using HMAC to sign the auth-token the server can verify if a token has been
> authenticated and by checking the embedded timestamp in the token it can
> also verify that the auth-token is still valid.
> 
> Using the new config directive auth-gen-token-secret instead of
> extending auth-gen-token (--auth-gen-token [lifetime] [secret-key]) was
> chosen to allow inlinening the secret key.
> 
> Patch V2: cleaned up code, use refactored read_pem_key_file function
> Patch V3: clarify some design decision in the commit message
> Patch V4: Use ephermal_generate_key
> Patch V5: Use C99 PRIu64 instead of %lld int printf like statement,
>           fix strict aliasing
> ---
>  doc/openvpn.8            |  25 ++++
>  src/openvpn/Makefile.am  |   1 +
>  src/openvpn/auth_token.c | 273 +++++++++++++++++++++++++++++++++++++++
>  src/openvpn/auth_token.h | 116 +++++++++++++++++
>  src/openvpn/init.c       |  30 ++++-
>  src/openvpn/openvpn.h    |   1 +
>  src/openvpn/options.c    |  22 +++-
>  src/openvpn/options.h    |   4 +
>  src/openvpn/push.c       |  70 ++++++++--
>  src/openvpn/push.h       |   8 ++
>  src/openvpn/ssl.c        |   7 +-
>  src/openvpn/ssl_common.h |  36 ++++--
>  src/openvpn/ssl_verify.c | 182 +++++++++++---------------
>  13 files changed, 640 insertions(+), 135 deletions(-)
>  create mode 100644 src/openvpn/auth_token.c
>  create mode 100644 src/openvpn/auth_token.h
> 

Hi,

Thanks a lot.  This now only leaves the following warning when using gcc-4.8.5
and gcc-6.3.1 (both on RHEL 7.7)

------------------------------------------------------------
auth_token.c: In function ‘generate_auth_token’:
auth_token.c:115:9: warning: dereferencing type-punned pointer will break
strict-aliasing rules [-Wstrict-aliasing]
         initial_timestamp = *((uint64_t *)(old_tstamp_decode));
         ^
------------------------------------------------------------

This warning is not present when compiling with gcc-7.3.1, gcc-8.3.1,
clang-3.4.2 nor clang-5.0.1.  So I'm blaming buggy/confused older GCC
compilers for this one.

Since I've tested and reviewed the rest in earlier rounds and the change from
previous version i sjust changing %lld to PRIu64, I'm giving
this my ...

Acked-By: David Sommerseth <davids@...515...>


-- 
kind regards,

David Sommerseth
OpenVPN Inc


