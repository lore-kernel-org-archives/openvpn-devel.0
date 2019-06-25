References: <20190613134834.5709-1-arne@...1227...>
 <20190613134834.5709-6-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <3d81eb6d-3378-7bf6-8c38-c8dce42f8333@...2080...>
Date: Tue, 25 Jun 2019 22:31:03 +0200
MIME-Version: 1.0
In-Reply-To: <20190613134834.5709-6-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v4 7/7] Implement unit tests for
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

On 13/06/2019 15:48, Arne Schwabe wrote:
> From: Arne Schwabe <arne@...515...>
> 
> Patch V2: adapt unit tests to other V2 patches
> Patch V4: Resolve rebase conflicts
> ---
>  tests/unit_tests/openvpn/Makefile.am       |  20 +-
>  tests/unit_tests/openvpn/test_auth_token.c | 375 +++++++++++++++++++++
>  2 files changed, 394 insertions(+), 1 deletion(-)
>  create mode 100644 tests/unit_tests/openvpn/test_auth_token.c
> 

Looks reasonable.  But needs to be rebased on top of latest git master; I suspect 
this is due to sitnl patches arriving in master.  I had to "force" this into
submission, so I might have missed a few things - as I do get these errors:

-------------------------------------------------------------
.../openvpn/tests/unit_tests/openvpn/../../../src/openvpn/auth_token.c:201: undefined reference to `openvpn_base64_decode'
.../openvpn/tests/unit_tests/openvpn/../../../src/openvpn/auth_token.c:205: undefined reference to `openvpn_base64_decode'
.../openvpn/tests/unit_tests/openvpn/../../../src/openvpn/auth_token.c:254: undefined reference to `openvpn_base64_encode'
auth_token_testdriver-test_auth_token.o: In function `verify_auth_token':
.../OpenVPN/openvpn/tests/unit_tests/openvpn/../../../src/openvpn/auth_token.c:299: undefined reference to `openvpn_base64_decode'
-------------------------------------------------------------

In addition comes the warnings I've already reported in a prior patch.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


