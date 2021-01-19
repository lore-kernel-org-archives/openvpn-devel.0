From: tincanteksup <tincanteksup@...277...>
References: <99e4c953-c5e0-bdf2-7268-c7987952aaed@...277...>
Message-ID: <4c488349-5b75-e04a-f776-6b498b25b776@...277...>
Date: Tue, 19 Jan 2021 21:02:16 +0000
MIME-Version: 1.0
In-Reply-To: <99e4c953-c5e0-bdf2-7268-c7987952aaed@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] Man sections: typo (No patch)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Just FTR.



diff --git a/doc/man-sections/tls-options.rst 
b/doc/man-sections/tls-options.rst
index 5dd20013..28cf6f1e 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -422,13 +422,13 @@ certificates and keys: 
https://github.com/OpenVPN/easy-rsa
    :code:`DEFAULT:!EXP:!LOW:!MEDIUM:!kDH:!kECDH:!DSS:!PSK:!SRP:!kRSA` when
    using OpenSSL.

-  The default for `--tls-ciphersuites` is to use the crypto library's
-  default.
-
  --tls-ciphersuites l
    Same as ``--tls-cipher`` but for TLS 1.3 and up. mbed TLS has no
    TLS 1.3 support yet and only the ``--tls-cipher`` setting is used.

+  The default for `--tls-ciphersuites` is to use the crypto library's
+  default.
+
  --tls-client
    Enable TLS and assume client role during TLS handshake.


