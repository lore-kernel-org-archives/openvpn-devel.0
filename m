Date: Thu, 16 Mar 2023 10:53:29 +0100 (CET)
Message-Id: <202303160953.32G9rTV8067067@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230315013516.1256700-4-selva.nair@...277...>
References: <20230315013516.1256700-4-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Refactor
 SSL_CTX_use_CryptoAPI_certificate()
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Stared-at-code, looks all reasonable.

Tested on local MinGW->W10 build (of cryptoapi_testdriver.exe) and GHA
(to get all 32/64 bit and OpenSSL 1/3 combinations built), everything
passes.

Your patch has been applied to the master and release/2.6 branch.

commit 0ad5f4d6c44daedca00dc399a5f914ac5850caa0 (master)
commit 5c2154ca49a591afd8faa8e535a67b149ddbd354 (release/2.6)
Author: Selva Nair
Date:   Tue Mar 14 21:35:15 2023 -0400

     Refactor SSL_CTX_use_CryptoAPI_certificate()

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230315013516.1256700-4-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26414.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


