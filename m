Date: Thu, 11 Oct 2018 20:52:02 +0200 (CEST)
Message-Id: <201810111852.w9BIq2fv021980@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181010153624.27957-1-arne@...1227...>
References: <20181010153624.27957-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add better support for showing
 TLS 1.3 ciphersuites in --show-tls
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

Your patch has been applied to the master and release/2.4 branch
(long term compatibility).

I had to fix one minor bit - it prints 

  For TLS 1.3 and newer (--tls-ciphersuite):

but that option is called "--tls-ciphersuites"...

I am not really able to make sense of it, though.  If I try to specify
a TLS 1.3 ciphersuite, to see if it has any effect, all I get is errors
in the log ("no valid translation"), and no effect...  so maybe something
with the --tls-ciphersuites patch is wrong, and this one is only 
exposing it?

Arne, Steffan, could you have a look?  This is "master" with OpenSSL 1.1.1:

   $ src/openvpn/openvpn --verb 4 --tls-ciphersuites TLS_AES_256_GCM_SHA384 --show-tls --tls-cipher TLS-DHE-RSA-WITH-AES-256-CBC-SHA256
   Available TLS Ciphers, listed in order of preference:

   For TLS 1.3 and newer (--tls-ciphersuite):

   Thu Oct 11 20:32:44 2018 us=310005 No valid translation found for TLS cipher 'TLS_AES_256_GCM_SHA384'
   TLS_AES_256_GCM_SHA384
   TLS_CHACHA20_POLY1305_SHA256
   TLS_AES_128_GCM_SHA256

   For TLS 1.2 and older (--tls-cipher):

   TLS-DHE-RSA-WITH-AES-256-CBC-SHA256


.. so "--tls-cipher" is definitely sticking, while "--tls-ciphersuites"
leads to a confusing warning (if --verb is high enough), listing the very 
same cipher(suite) in the next line...?


commit 7aeabadd69fca0071152c42d58fee0b565f01eb3 (master)
commit e8467c8648f699b221004a9f15d48b8e558049f0 (release/2.4)
Author: Arne Schwabe
Date:   Wed Oct 10 17:36:24 2018 +0200

     Add better support for showing TLS 1.3 ciphersuites in --show-tls

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <20181010153624.27957-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17723.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


