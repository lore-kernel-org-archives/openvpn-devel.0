Date: Thu, 25 Jan 2018 12:18:49 +0100 (CET)
Message-Id: <201801251118.w0PBIn3d083413@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1516423974-22159-1-git-send-email-selva.nair@...277...>
References: <1516423974-22159-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: TLS v1.2 support for
 cryptoapicert -- RSA only
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

Your patch has been applied to the master and release/2.4 branch.

I have tested on unix (where it obviously did not make a difference),
compile-tested on my old ubuntu 14.04 build environment (fails with 
CERT_NCRYPT_KEY_SPEC not being defined, because mingw *there* needs 
"_WIN32_WINNT >= 0x0601") and successfully built on a brand new ubuntu 
16.04 build environment, which adds a new "wincrypt.h" file with new 
#if WINAPI_FAMILY_PARTITION fun... :-) 

[short summary: throw away your 14.04 build systems, we have decided to
 break them, and that's what they are: broken!]

There is one thing I'm not sure I understand in the code, which might
warrant a typo-fix patch:

+        msg(M_WARN,"WARNING: cryptoapicert: private key is in a legacy store."
+            " Restricting TLS version to 1.1");
+        if (!SSL_CTX_set_max_proto_version(ssl_ctx, TLS1_1_VERSION))
+        {
+            msg(M_NONFATAL,"ERROR: cryptoapicert: unable to set max TLS version"
+                " to 1.1. Try config option --tls-version-min 1.1");
+            goto err;
+        }

should that be "--tls-version-*max* 1.1"?


commit 51d57d7dad6c6380df7b76bbec1897ea4f98474d (master)
commit 6c54745b8d417a534a6081588b1ecc7ff01fa9f7 (release/2.4)
Author: Selva Nair
Date:   Fri Jan 19 23:52:54 2018 -0500

     TLS v1.2 support for cryptoapicert -- RSA only

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <1516423974-22159-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16288.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


