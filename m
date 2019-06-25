References: <20190613134834.5709-1-arne@...1227...>
 <20190613134834.5709-3-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <324fcf27-5a5a-62a7-f77d-cd279f46c712@...2080...>
Date: Tue, 25 Jun 2019 22:08:31 +0200
MIME-Version: 1.0
In-Reply-To: <20190613134834.5709-3-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v4 4/7] Rewrite auth-token-gen to be
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

On 13/06/2019 15:48, Arne Schwabe wrote:
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
> ---
>  doc/openvpn.8            |  25 ++++
>  src/openvpn/Makefile.am  |   1 +
>  src/openvpn/auth_token.c | 272 +++++++++++++++++++++++++++++++++++++++
>  src/openvpn/auth_token.h | 116 +++++++++++++++++
>  src/openvpn/init.c       |  30 ++++-
>  src/openvpn/openvpn.h    |   1 +
>  src/openvpn/options.c    |  22 +++-
>  src/openvpn/options.h    |   4 +
>  src/openvpn/push.c       |  70 ++++++++--
>  src/openvpn/push.h       |   8 ++
>  src/openvpn/ssl.c        |   7 +-
>  src/openvpn/ssl_common.h |  36 ++++--
>  src/openvpn/ssl_verify.c | 182 ++++++++++++--------------
>  13 files changed, 639 insertions(+), 135 deletions(-)
>  create mode 100644 src/openvpn/auth_token.c
>  create mode 100644 src/openvpn/auth_token.h
> 

Not as heavy tested as in last round, but changes has been applied as 
indicated.  Thank you!  Unfortunately, some compiler warnings are appearing:

------------------------------------------------------------
auth_token.c: In function ‘generate_auth_token’:
auth_token.c:115:9: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
         initial_timestamp = *((uint64_t *)(old_tstamp_decode));
         ^
auth_token.c: In function ‘verify_auth_token’:
auth_token.c:233:9: warning: format ‘%lld’ expects argument of type ‘long long int’, but argument 3 has type ‘uint64_t’ [-Wformat=]
         msg(M_WARN, "Initial timestamp (%lld) in token from client earlier than "
         ^
auth_token.c:233:9: warning: format ‘%lld’ expects argument of type ‘long long int’, but argument 4 has type ‘uint64_t’ [-Wformat=]
------------------------------------------------------------


The first one (dereferencing type-punned pointer) seems to only show up with
gcc-4.8.5 and 6.3.1.  Below are warnings reported by both gcc-7.3.1 and 8.3.1,
which are also a bit more verbose, with a few additional twists.

------------------------------------------------------------
auth_token.c: In function ‘verify_auth_token’:
auth_token.c:233:21: warning: format ‘%lld’ expects argument of type ‘long long int’, but argument 3 has type ‘uint64_t’ {aka ‘long unsigned int’} [-Wformat=]
         msg(M_WARN, "Initial timestamp (%lld) in token from client earlier than "
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
auth_token.c:235:13:
             timestamp_initial, timestamp);
             ~~~~~~~~~~~~~~~~~
error.h:151:67: note: in definition of macro ‘msg’
 #define msg(flags, ...) do { if (msg_test(flags)) {x_msg((flags), __VA_ARGS__);} EXIT_FATAL(flags); } while (false)
                                                                   ^~~~~~~~~~~
auth_token.c:233:44: note: format string is defined here
         msg(M_WARN, "Initial timestamp (%lld) in token from client earlier than "
                                         ~~~^
                                         %ld
In file included from buffer.h:28,
                 from auth_token.c:10:
auth_token.c:233:21: warning: format ‘%lld’ expects argument of type ‘long long int’, but argument 4 has type ‘uint64_t’ {aka ‘long unsigned int’} [-Wformat=]
         msg(M_WARN, "Initial timestamp (%lld) in token from client earlier than "
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
auth_token.c:235:32:
             timestamp_initial, timestamp);
                                ~~~~~~~~~
error.h:151:67: note: in definition of macro ‘msg’
 #define msg(flags, ...) do { if (msg_test(flags)) {x_msg((flags), __VA_ARGS__);} EXIT_FATAL(flags); } while (false)
                                                                   ^~~~~~~~~~~
auth_token.c:234:36: note: format string is defined here
             "current timestamp (%lld). Broken/unsynchronised clock?",
                                 ~~~^
                                 %ld
------------------------------------------------------------

Other than these issues, things looks good and would normally get an ACK.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


