Date: Fri, 11 Aug 2023 20:41:03 +0200 (CEST)
Message-Id: <202308111841.37BIf3aC095200@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230811121503.4159089-1-arne@...1227...>
References: <20230811121503.4159089-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: show extra info for OpenSSL
 errors
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

Thanks, Selva for having an extra eye :-) - I asked for the feature, and
it works beautifully for me, but what do I understand about OpenSSL
internals...  ("unsigned long" fixed on the fly).

Tried on FreeBSD 14 with OpenSSL 3 and a broken provider (which is what
triggered the whole thing):

$ src/openvpn/openvpn --providers legacyXX
2023-08-11 20:19:53 OpenSSL: error:12800067:DSO support routines::could not load the shared library:filename(/usr/lib/ossl-modules/legacyXX.so): /usr/lib/ossl-modules/legacyXX.so: Undefined symbol "ossl_md4_functions"

.. and on Linux with OpenSSL 1.1.1t, passing a wrong passphrase:

2023-08-11 20:17:24 OpenSSL: error:06065064:digital envelope routines:EVP_DecryptFinal_ex:bad decrypt:
2023-08-11 20:17:24 OpenSSL: error:23077074:PKCS12 routines:PKCS12_pbe_crypt:pkcs12 cipherfinal error:
2023-08-11 20:17:24 OpenSSL: error:2306A075:PKCS12 routines:PKCS12_item_decrypt_d2i:pkcs12 pbe crypt error:
2023-08-11 20:17:24 OpenSSL: error:0907B00D:PEM routines:PEM_read_bio_PrivateKey:ASN1 lib:
2023-08-11 20:17:24 Cannot load private key file [[INLINE]]

(which looks to be "the same what it printed before", so at least it
does not break anything)

With 3.0 it prints, in the same situation...

2023-08-11 20:24:01 OpenSSL: error:1C800064:Provider routines::bad decrypt:
2023-08-11 20:24:01 OpenSSL: error:11800074:PKCS12 routines::pkcs12 cipherfinal error:maybe wrong password

.. or

2023-08-11 20:23:21 OpenSSL: error:0308010C:digital envelope routines::unsupported:Global default library context, Algorithm (DES-CBC : 10), Properties ()

(ahem...)

So, very nice.


For extra sanity checking pushed to GHA first, to get more OpenSSL/OS
combinations tested.


Your patch has been applied to the master and release/2.6 branch.

commit 0f8485f2870277fb7ccdb4097380e35dc35b064e (master)
commit 101499a43d222dcefbf5c6fc6f8b71a4f5d1f533 (release/2.6)
Author: Arne Schwabe
Date:   Fri Aug 11 14:15:03 2023 +0200

     show extra info for OpenSSL errors

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20230811121503.4159089-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26929.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


