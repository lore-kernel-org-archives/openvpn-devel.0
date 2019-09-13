References: <d81eb6d-3378-7bf6-8c38-c8dce42f8333@...2080...>
 <20190808145412.1321-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <4ae4ef50-efbe-c744-7133-7f926052be0a@...2080...>
Date: Fri, 13 Sep 2019 18:26:52 +0200
MIME-Version: 1.0
In-Reply-To: <20190808145412.1321-1-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v6 7/7] Implement unit tests for
 auth-gen-token
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
Cc: Arne Schwabe <arne@...515...>

On 08/08/2019 16:54, Arne Schwabe wrote:
> From: Arne Schwabe <arne@...515...>
> 
> Patch V2: adapt unit tests to other V2 patches
> Patch V4: Resolve rebase conflicts
> Patch V5: Add \ lost in rebase that broke compilation
> ---
>  tests/unit_tests/openvpn/Makefile.am       |  18 +-
>  tests/unit_tests/openvpn/test_auth_token.c | 375 +++++++++++++++++++++
>  2 files changed, 392 insertions(+), 1 deletion(-)
>  create mode 100644 tests/unit_tests/openvpn/test_auth_token.c

Code generally looks good.  But I do have some nitpicks here though.

* Many of the lines break our 80 chars per line rule
* The "dummy" functions added at the end of the test_auth_token.c file should
  be declared higher up and not after the main() function.

And finally ... the unit test doesn't pass for me :/

------------------------------------------------------
[==========] Running 8 test(s).
[ RUN      ] auth_token_basic_test
[       OK ] auth_token_basic_test
[ RUN      ] auth_token_fail_invalid_key
--auth-token-gen: HMAC on token from client failed (test user name)
[       OK ] auth_token_fail_invalid_key
[ RUN      ] auth_token_test_known_keys
[       OK ] auth_token_test_known_keys
[ RUN      ] auth_token_test_empty_user
[  ERROR   ] --- 0x3 != 0x7
[   LINE   ] --- test_auth_token.c:265: error: Failure!
[  FAILED  ] auth_token_test_empty_user
[ RUN      ] auth_token_test_env
[       OK ] auth_token_test_env
[ RUN      ] auth_token_test_random_keys
[       OK ] auth_token_test_random_keys
[ RUN      ] auth_token_test_key_load
--auth-token-gen: HMAC on token from client failed (test user name)
[       OK ] auth_token_test_key_load
[ RUN      ] auth_token_test_timeout
[       OK ] auth_token_test_timeout
[==========] 8 test(s) run.
[  PASSED  ] 7 test(s).
[  FAILED  ] 1 test(s), listed below:
[  FAILED  ] auth_token_test_empty_user

 1 FAILED TEST(S)
------------------------------------------------------

Seems like the verify_auth_token() call doesn't add
AUTH_TOKEN_VALID_EMPTYUSER flag.  I didn't dive deep enough to try to
understand why.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


