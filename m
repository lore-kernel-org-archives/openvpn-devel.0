From: Bernhard Weisshuhn <bkw@...286...>
Message-ID: <20040929181558.GF27626@...286...>
Mime-Version: 1.0
Subject: [Openvpn-devel] [PATCH] check crl issuer
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Sep 29 12:34:01 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

I just submitted the following on sourceforge, but since I'm not sure if
it gets read frequently, here it is again:

The option crl-verify can bite you, if you use more than one CA to
issue certificates (like we do: Server-CA for gateways, User-CA for
workstations), since it only checks the serial of the presented certificate
against the serials in the crl, without taking the issuer into account,
which can make perfectly valid certificates look revoked.

The attached trivial patch spits out a warning and ignores the crl, if it
was from another issuer. Should be non-intrusive enough to be considered
for 2.0 imho.

The nicer thing to do would be to be able to use multiple CRLs and have
openvpn check against the correct one. But I guess that's a little late for
2.0...

Keep up the good work!
bkw



Patch against cvs branch BETA20:

Index: ssl.c
===================================================================
RCS file: /cvsroot/openvpn/openvpn/ssl.c,v
retrieving revision 1.38.2.21
diff -u -r1.38.2.21 ssl.c
--- ssl.c	19 Aug 2004 03:28:10 -0000	1.38.2.21
+++ ssl.c	29 Sep 2004 18:03:45 -0000
@@ -479,6 +479,12 @@
 	goto end;
       }
 
+      if (X509_NAME_cmp(X509_CRL_get_issuer(crl), X509_get_issuer_name(ctx->current_cert)) != 0) {
+	msg (M_WARN, "CRL: CRL %s is from a different issuer than the issuer of certificate %s", opt->crl_file, subject);
+	retval = 1;
+	goto end;
+      }
+
       n = sk_num(X509_CRL_get_REVOKED(crl));
 
       for (i = 0; i < n; i++) {

