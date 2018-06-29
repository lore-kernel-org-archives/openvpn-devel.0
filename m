Date: Fri, 29 Jun 2018 14:41:55 +0200 (CEST)
Message-Id: <201806291241.w5TCftxr017630@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20171126154912.13283-1-steffan@...1856...>
References: <20171126154912.13283-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: openssl: add missing #include
 statements
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

"Looks sane", and tested against the same set of OS/OpenSSL combinations
as 1/2 ("--version" and t_client tests).

Compilation with -DOPENSSL_API_COMPAT=0x10100000L still does not work
(quite a few linker errors), but those seem to be unrelated to missing
includes, and more related to "these are macros we shouldn't be using
anymore"...  namely EVP_CIPHER_CTX_init(), EVP_CIPHER_CTX_cleanup(), 
SSL_library_init(), SSL_load_error_strings(), OpenSSL_add_all_algorithms(),
EVP_cleanup(), ERR_free_strings(), X509_get_notBefore(), X509_get_notAfter()
and SSL_CTX_set_ecdh_auto().

Without said define, OpenSSL 1.1.0 is also fine, but this smells like
"a bit more work needed".

Your patch has been applied to the master branch.

commit 1987498271abadf042d8bb3feee1fe0d877a9d55
Author: Steffan Karger
Date:   Sun Nov 26 16:49:12 2017 +0100

     openssl: add missing #include statements

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20171126154912.13283-1-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15936.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


