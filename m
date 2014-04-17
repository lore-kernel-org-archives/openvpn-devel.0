Message-ID: <534F898A.3060607@...515...>
Date: Thu, 17 Apr 2014 01:58:02 -0600
From: James Yonan <james@...515...>
MIME-Version: 1.0
References: <1396001222-5033-1-git-send-email-arne@...1227...>	<CAA1AbxJCv9ff7XHv1GKtCPuB-Hc5Lv33ufPfqcTraNpFnJf7fw@...278...>
	<20140330134619.GT16637@...1296...>
In-Reply-To: <20140330134619.GT16637@...1296...>
Content-Type: multipart/mixed; boundary="------------080703070507050605040305"
Subject: Re: [Openvpn-devel] [PATCH] Fix man page and OSCP script:
 tls_serial_{n} is decimal
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080703070507050605040305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 30/03/2014 07:46, Gert Doering wrote:
> Hi,
>
> On Sun, Mar 30, 2014 at 12:48:37AM +0100, Steffan Karger wrote:
>> 3 - Change OpenSSL builds to use hax representation
>
> I tend toward this one - user visible behaviour shouldn't change (unless
> unavoidable) depending on SSL library used.
>
> So for me this boils down to "how many users are relying on the current
> behaviour, which is not what the docs say it should be"?

If we keep the current behavior (PolarSSL serial numbers are hex while 
OpenSSL are decimal) then we should at least mark the serial number when 
it's hex, so client software can distinguish it.

This very simple patch does that.

James

--------------080703070507050605040305
Content-Type: text/plain; charset=UTF-8; x-mac-type="0"; x-mac-creator="0";
	name="0001-tls_serial_-n-value-should-be-distinguishable-as-hex.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-tls_serial_-n-value-should-be-distinguishable-as-hex.pa";
	filename*1="tch"

From a8f0d219d4edd1e95520cc40d27a0cd79cace2c2 Mon Sep 17 00:00:00 2001
From: James Yonan <james@...515...>
Date: Wed, 16 Apr 2014 21:29:42 -0600
Subject: [PATCH] tls_serial_{n} value should be distinguishable as hex or
 decimal.

To accomplish this, prepend 'x' before hex serial numbers, so they
can be distinguished from decimal serial numbers.  For example:

  tls_serial_1 = "x4D:9B:7C:94"

is equivalent to:

  tls_serial_1 = "1302035604"

Currently, only PolarSSL generates hex serial numbers while
OpenSSL returns decimal serial numbers.

RFC 5280, published in 2008, decrees that serial numbers can be
up to 20 bytes long, hence it is necessary to support SSL
libraries that return the serial number as a hex string.

Signed-off-by: James Yonan <james@...515...>
---
 src/openvpn/ssl_verify_polarssl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
index 1b2990c..4367eb1 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -127,11 +127,12 @@ char *
 backend_x509_get_serial (x509_crt *cert, struct gc_arena *gc)
 {
   char *buf = NULL;
-  size_t len = cert->serial.len * 3 + 1;
+  size_t len = cert->serial.len * 3;
 
-  buf = gc_malloc(len, true, gc);
+  buf = gc_malloc(len+1, true, gc);
 
-  if(x509_serial_gets(buf, len-1, &cert->serial) < 0)
+  buf[0] = 'x';
+  if(x509_serial_gets(buf+1, len, &cert->serial) < 0)
     buf = NULL;
 
   return buf;
-- 
1.8.5.3


--------------080703070507050605040305--

