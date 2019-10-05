References: <20190917123321.15993-1-arne@...1227...>
 <201910011127.x91BRNXp096178@...2054...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <4f40f361-00aa-3c6d-adb3-f0c7df66e4d7@...1227...>
Date: Sat, 5 Oct 2019 22:57:34 +0200
MIME-Version: 1.0
In-Reply-To: <201910011127.x91BRNXp096178@...2054...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Implement unit tests for
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
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Am 01.10.19 um 13:27 schrieb Gert Doering:
> Your patch has been applied to the master branch.
> 
> Did client side tests, see the unit tests pass on linux and freebsd...
> 
> ..
> [ RUN      ] auth_token_test_timeout
> [       OK ] auth_token_test_timeout
> [==========] 8 test(s) run.
> [  PASSED  ] 8 test(s).
> PASS: auth_token_testdriver
> 
> The "Fox Crypto B.V." copyright notice in a *new* C source looks a bit
> funky, though.
> 

Part of the tests are rewritten test from the tls_crypt test suite (but
too different to make sense to have a common file), so I copied the
copyright too.

Arne

