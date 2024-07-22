Date: Mon, 22 Jul 2024 19:45:41 +0200 (CEST)
Message-Id: <202407221745.46MHjfsX023421@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240719131141.75324-1-frank@...2641...>
References: <20240719131141.75324-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add Ubuntu 24.04 runner to
 Github Actions
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

I tried to apply it to release/2.6 as well, but the mbedtls builds 
fail (on 24.04) with error messages like this:

crypto_backend.h:352:6: note: previous declaration of `cipher_ctx_init' with type `void(cipher_ctx_t *, const uint8_t *, const char *, int)' {aka `void(mbedtls_cipher_context_t *, const unsigned char *, const char *, int)'}

so it seems we need some mbedtls compat backport first, or stop building
2.6 + 24.04 + mbedtls.

Details: https://github.com/cron2/openvpn/actions/runs/10041826490/job/27750800767

(looking more closely, 24.04 + ossl 3 fails as well, with
"configure: error: PKCS11 enabled but libpkcs11-helper is missing")

commit 856065b2eb37286c389550593472bf180bc5be9d (master)
Author: Arne Schwabe
Date:   Fri Jul 19 15:11:41 2024 +0200

     Add Ubuntu 24.04 runner to Github Actions

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240719131141.75324-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28942.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


