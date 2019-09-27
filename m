References: <20190816184446.GQ1349@...1296...>
 <20190917121004.13685-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <759ea36a-a01c-3671-b256-e4de371090ad@...2080...>
Date: Sat, 28 Sep 2019 00:18:27 +0200
MIME-Version: 1.0
In-Reply-To: <20190917121004.13685-1-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v7 4/7] Rewrite auth-token-gen to be
 based on HMAC based tokens
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 17/09/2019 14:10, Arne Schwabe wrote:
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
> Patch V6: Rebase on master
> Patch V7: fix compiling with --disable-server
> ---
>  doc/openvpn.8            |  25 ++++
>  src/openvpn/Makefile.am  |   1 +
>  src/openvpn/auth_token.c | 273 +++++++++++++++++++++++++++++++++++++++
>  src/openvpn/auth_token.h | 116 +++++++++++++++++
>  src/openvpn/init.c       |  34 ++++-
>  src/openvpn/openvpn.h    |   1 +
>  src/openvpn/options.c    |  22 +++-
>  src/openvpn/options.h    |   4 +
>  src/openvpn/push.c       |  70 ++++++++--
>  src/openvpn/push.h       |   8 ++
>  src/openvpn/ssl.c        |   7 +-
>  src/openvpn/ssl_common.h |  36 ++++--
>  src/openvpn/ssl_verify.c | 184 ++++++++++++--------------
>  13 files changed, 646 insertions(+), 135 deletions(-)
>  create mode 100644 src/openvpn/auth_token.c
>  create mode 100644 src/openvpn/auth_token.h

This looks good.  The changes was a bit bigger than expected, but it this (and
the rest of the patches) passes compiling on our buildbot rig - including
--disable-server.

Acked-By: David Sommerseth <davids@...515...>


-- 
kind regards,

David Sommerseth
OpenVPN Inc


