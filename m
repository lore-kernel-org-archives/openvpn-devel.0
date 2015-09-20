References: <55DB4C39.9040105@...2010...>
	<55DDBBE2.9010205@...1114...> <55F7EFD0.1040501@...2010...>
	<CAA1Abx+EBkkGhSLBnGonHdLur4g3w4cm44U_nDP7UhMuNxXrUg@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <55FE9852.5040600@...1856...>
Date: Sun, 20 Sep 2015 13:28:18 +0200
MIME-Version: 1.0
In-Reply-To: <CAA1Abx+EBkkGhSLBnGonHdLur4g3w4cm44U_nDP7UhMuNxXrUg@...278...>
Subject: Re: [Openvpn-devel] Log cert serial no if it is revoked
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Boris Lytochkin <lytboris@...2010...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>


On 15-09-15 23:49, Steffan Karger wrote:
> I agree that the functionality makes, but need to look at the code.  I'm
> currently on a long holiday and haven't had enough spare cycles to spend
> on openvpn. After I get back (next week), this will be part of my backlog :)

I looked at the code this morning, and tested with both OpenSSL and 
PolarSSL.  The functionality makes sense.  The serial formatting is a 
bit confusing ("serial 12" is actually serial 0x12, or 18 in dec), but 
this matches 'openssl crl -text' output, and putting 0x in front will 
make the longer AA:BB:CC formatting look weird...  So I guess I'm fine 
with this.

Regarding

@@ -609,7 +610,7 @@ x509_verify_crl(const char *crl_file, X509 
*peer_cert, const char *subject)
    for (i = 0; i < n; i++) {
      revoked = (X509_REVOKED 
*)sk_X509_REVOKED_value(X509_CRL_get_REVOKED(crl), i);
      if (ASN1_INTEGER_cmp(revoked->serialNumber, 
X509_get_serialNumber(peer_cert)) == 0) {
-      msg (D_HANDSHAKE, "CRL CHECK FAILED: %s is REVOKED",subject);
+      msg (D_HANDSHAKE, "CRL CHECK FAILED: %s (serial %s) is REVOKED", 
subject, backend_x509_get_serial_hex(peer_cert, &gc));
        goto end;
      }
    }

and

@@ -394,7 +395,7 @@ x509_verify_crl(const char *crl_file, x509_crt 
*cert, const char *subject)

    if (0 != x509_crt_revoked(cert, &crl))
      {
-      msg (D_HANDSHAKE, "CRL CHECK FAILED: %s is REVOKED", subject);
+      msg (D_HANDSHAKE, "CRL CHECK FAILED: %s (serial %s) is REVOKED", 
subject, backend_x509_get_serial_hex(cert, &gc));
        goto end;
      }

backend_x509_get_serial_hex() may return NULL, and passing NULL as a 
string format specifier to printf() results in undefined behaviour.  So 
please add a NULL check before passing the string to msg().

Finally, when you send a v2 of this patch, could you use 'git 
format-patch' to create a patch file with a clear commit message 
explaining why this change is useful? (Your original email probably 
suffices).

-Steffan

