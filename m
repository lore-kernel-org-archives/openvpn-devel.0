References: <20190510121114.30468-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <9b117603-189a-b5da-b3e4-c7f22c7bc363@...2080...>
Date: Fri, 7 Jun 2019 18:54:00 +0200
MIME-Version: 1.0
In-Reply-To: <20190510121114.30468-1-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v3 0/7] Auth token patches v3
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

On 10/05/2019 14:11, Arne Schwabe wrote:
> This is the v3 of the patch series. I choose to resend all of the patches
> so they all cleanly apply. Since the patches depend on the changes suggested
> to --genkey, I made them part of the patch series. The other patches have
> been updated to incoperate the feedback.
> 
> Arne Schwabe (7):
>   Write key to stdout if filename is not given
>   Implement --genkey type keyfile syntax and migrate tls-crypt-v2
>   Add pem_read_key_file variant that allows a random key
>   Rewrite auth-token-gen to be based on HMAC based tokens
>   Implement a permanent session id in auth-token
>   Sent indication that a session is expired to clients
>   Implement unit tests for auth-gen-token
> 
>  doc/openvpn.8                              | 141 ++++++--
>  src/openvpn/Makefile.am                    |   1 +
>  src/openvpn/auth_token.c                   | 387 +++++++++++++++++++++
>  src/openvpn/auth_token.h                   | 129 +++++++
>  src/openvpn/crypto.c                       |  35 +-
>  src/openvpn/crypto.h                       |  15 +
>  src/openvpn/init.c                         |  90 +++--
>  src/openvpn/manage.c                       |   4 +-
>  src/openvpn/openvpn.h                      |   1 +
>  src/openvpn/options.c                      | 103 ++++--
>  src/openvpn/options.h                      |  19 +-
>  src/openvpn/push.c                         |  70 +++-
>  src/openvpn/push.h                         |   8 +
>  src/openvpn/ssl.c                          |  13 +-
>  src/openvpn/ssl_common.h                   |  56 +--
>  src/openvpn/ssl_verify.c                   | 213 ++++++------
>  src/openvpn/ssl_verify.h                   |  15 +-
>  src/openvpn/tls_crypt.c                    |  13 +-
>  tests/unit_tests/openvpn/Makefile.am       |  18 +-
>  tests/unit_tests/openvpn/test_auth_token.c | 375 ++++++++++++++++++++
>  20 files changed, 1457 insertions(+), 249 deletions(-)
>  create mode 100644 src/openvpn/auth_token.c
>  create mode 100644 src/openvpn/auth_token.h
>  create mode 100644 tests/unit_tests/openvpn/test_auth_token.c

I've focused on functional testing in the beginning.  And here's a summary so
far of my feedback:


* The --help screen is inaccurate in regards to --auth-gen-token and --genkey
  entries.

* Using --genkey with --secret now sends the key to stdout instead of the
  given --secret file.  I don't recall if we discussed this and if this was
  considered expected.

* When starting a server with --auth-gen-token-secret, there is no (afaict)
  indications in the log file such a file is used

* In the log file when the server sends PUSH_REPLY there's a formatting issue,
  where you will find: [...], auth-tokenSESS_ID,[....].  This happens on both
  server and client.

* The configuration below ends up going into username/password auth loop on
  each renegotiation after the auth-token has expired:

  - server
    # ./src/openvpn/openvpn --dev tun --ca sample/sample-keys/ca.crt  \
                            --cert sample/sample-keys/server.crt      \
                            --key sample/sample-keys/server.key       \
                            --dh sample/sample-keys/dh2048.pem        \
                            --server 10.8.0.0 255.255.255.0 --verb 4  \
                            --script-security 3                       \
                            --auth-user-pass-verify ./auth.sh via-env \
                            --auth-gen-token 60 external-auth         \
                            --auth-gen-token-secret auth-token.key    \
                            --reneg-sec 30 --tran-window 15           \
                            --hand-window 20 --keepalive 10 20

  - client
    # ./src/openvpn/openvpn --dev tun --client --auth-user-pass       \
                            --remote $REMOTE_IP                       \
                            --ca sample/sample-keys/ca.crt            \
                            --key sample/sample-keys/client.key       \
                            --cert sample/sample-keys/client.crt      \
                            --verb 4 --explicit-exit-notify           \
                            --auth-nocache

   - auth.sh script:
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   #!/bin/bash
   echo "----------------------------------------------------"
   echo "session_state: $session_state"
   echo "username: $username"
   echo "password: $password"
   echo "session_id: $session_id"
   ret=1
   if [ "$session_state" = "Authenticated" ]; then
   	   ret=0;
   elif [ "$username" = "testuser" ]; then
   	   if [ "$password" = "foobaraaa" ]; then
		   ret=0
	   fi
   fi

   if [ $ret -eq 0 ]; then
	   echo "Authentication successful"
   else
	   echo "Authentication failed"
   fi
   echo "----------------------------------------------------"
   exit $ret
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   What happens:
   - Server starts
   - Client starts and connects, auth with username/password (state: Initial)
   - 30 seconds, reneg happens
   - Client re-auth with token (state: Authenticated)
   - 30 seconds, reneg happens
   - Client re-auth with token (state: Expired)
   - 30 seconds, reneg happens
   - Client re-auth with token (state: Expired)
   - Client restarts with username/password auth (state: Initial)
   - 30 seconds, reneg happens
   - Client restarts with username/password auth (state: Initial)
   - 30 seconds, reneg happens
   - Client restarts with username/password auth (state: Initial)
   ....


I'll run more tests and review patches too, but here's something to dive into
at least.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


