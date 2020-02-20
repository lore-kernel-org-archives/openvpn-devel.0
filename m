References: <20200217144339.3273-1-arne@...1227...>
 <20200217144339.3273-5-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <fd2c9df9-5b3b-28c3-9493-6c998ae489ad@...2080...>
Date: Thu, 20 Feb 2020 18:31:58 +0100
MIME-Version: 1.0
In-Reply-To: <20200217144339.3273-5-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v4 4/5] Move NCP related function into a
 seperate file and add unit tests
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 17/02/2020 15:43, Arne Schwabe wrote:
> This allows unit test the NCP functions. The ssl.c file has too
> many dependencies to make unit testing of it viable.
> 
> Patch V2: Removing the include "ssl_ncp.h" from options.c for V2 of
>           implement dynamic NCP forces a new version of this patch to
>           add the #include in this patch. Merge VS studio file changes
>           for ssl_ncp.[ch] into this patch
> 
> Patch V3: Regenerate for changes in earlier patches, apply Lev's changes
>           to Visual Studio project file
> 
> Patch V4: Regenerate to also have the changes of earlier patches.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/Makefile.am              |   1 +
>  src/openvpn/init.c                   |   1 +
>  src/openvpn/multi.c                  |   1 +
>  src/openvpn/openvpn.vcxproj          |   2 +
>  src/openvpn/openvpn.vcxproj.filters  |   8 +-
>  src/openvpn/options.c                |   1 +
>  src/openvpn/push.c                   |   1 +
>  src/openvpn/ssl.c                    | 176 +-------------------
>  src/openvpn/ssl.h                    |  65 --------
>  src/openvpn/ssl_ncp.c                | 231 +++++++++++++++++++++++++++
>  src/openvpn/ssl_ncp.h                | 101 ++++++++++++
>  tests/unit_tests/openvpn/Makefile.am |  18 ++-
>  tests/unit_tests/openvpn/test_ncp.c  | 179 +++++++++++++++++++++
>  13 files changed, 544 insertions(+), 241 deletions(-)
>  create mode 100644 src/openvpn/ssl_ncp.c
>  create mode 100644 src/openvpn/ssl_ncp.h
>  create mode 100644 tests/unit_tests/openvpn/test_ncp.c
> 
Sorry, but this gets a NAK from me.

$ ./tests/unit_tests/openvpn/ncp_testdriver
[==========] Running 4 test(s).
[ RUN      ] test_check_ncp_ciphers_list
Unsupported cipher in --ncp-ciphers: AES-256-GCM
Unsupported cipher in --ncp-ciphers: AES-128-GCM
[  ERROR   ] --- tls_check_ncp_cipher_list(aes_ciphers)
[   LINE   ] --- test_ncp.c:50: error: Failure!
[  FAILED  ] test_check_ncp_ciphers_list
[ RUN      ] test_extract_client_ciphers
[       OK ] test_extract_client_ciphers
[ RUN      ] test_poor_man
[       OK ] test_poor_man
[ RUN      ] test_ncp_best
[       OK ] test_ncp_best
[==========] 4 test(s) run.
[  PASSED  ] 3 test(s).
[  FAILED  ] 1 test(s), listed below:
[  FAILED  ] test_check_ncp_ciphers_list

 1 FAILED TEST(S)

We can't have any failing tests ;-)

This is tested on RHEL-7.7 (openssl-1.0.2k-19) which I also do know have
AES-GCM support.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


