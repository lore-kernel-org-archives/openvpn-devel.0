Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2950A606A326
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=T+i/F6nw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MDPvQIyC;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MIPVZGTV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=7JeST4wCydxqCwpbJwSwFaybhr2eGtnPzyOYX9GYtoA=; b=T+i/F6nwFQiogw
	gBqIlpVwsmssVHS4YUwFpzjeN919M/GNsd4wdABpWSBe///RTVDHRodZ8QQK84Uva3nZ661o/2ryD
	UIm+inun6r46pkuEAOG9kJHVwSbnP8/6CqxWv9I8aQ9Hc+pQ4+WKc6xzLTynRheJZh5GDte5n39pe
	Pj8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNrrt-000000003sA-3XvU;
	Mon, 02 Nov 2026 13:14:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xNrrt-000000003s0-0aRt for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:14:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vCWzhv6T3OvFf1bxtFEVJuLkLcYHxr/gnvMF2NnUVOs=; b=MDPvQIyCdxTxQy9FS5QMDfc+P0
 5a2Mn5R07hgK9SnmyIfCg56AToFKs536KjwLxec0RWWKvo3Atqdf/B7GxK5uW+sDvwkdRTtBPxGqt
 O2ZoHD64PYJLq+lyXPq3ntbZv8oxw3BFxrPitHS0ewzod9d6Bn6ubCLuYK/unTPy0J4I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vCWzhv6T3OvFf1bxtFEVJuLkLcYHxr/gnvMF2NnUVOs=; b=MIPVZGTVwp01MSWQ63rrJ9R112
 8sfJJTQK+BAB10foOxy17O4ubT4c/YetoD00WXhnzWjRHUwzK4d3EyABH4GwTH7SgJX3zFde+rKQS
 C7aS7UfzTqg1P/VWgOFyzqSCqzirDrup2t3l38oWlDYyl1xpz03Ns5nKcU+5NM2K+/GE=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNrrr-0000000081D-3Ftn for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:14:33 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A2DEPNm021676
 for <openvpn-devel@lists.sourceforge.net>; Mon, 2 Nov 2026 14:14:25 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A2DEPR2021675
 for openvpn-devel@lists.sourceforge.net; Mon, 2 Nov 2026 14:14:25 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  2 Nov 2026 14:14:19 +0100
Message-ID: <20261102131424.21661-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1792315181000.Ie54c455006782662e3ed51e0db869ce403a66e74@gerrit.openvpn.net>
References: <gerrit.1792315181000.Ie54c455006782662e3ed51e0db869ce403a66e74@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xNrrr-0000000081D-3Ftn
Subject: [Openvpn-devel] [PATCH v1] sample-keys: add tls-crypt-v2 keys and
 revoked cert
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Steffan Karger <steffan@karger.me>

To facilitate both manual tests as well as the upcoming connection test
suite.

Change-Id: Ie54c455006782662e3ed51e0db869ce403a66e74
Signed-off-by: Steffan Karger <steffan@karger.me>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2011
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2011
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/sample/sample-keys/README b/sample/sample-keys/README
index 66dd945..4095534 100644
--- a/sample/sample-keys/README
+++ b/sample/sample-keys/README
@@ -17,3 +17,5 @@
                        password = "password"
 client-ec.{crt,key} -- sample elliptic curve client key/cert
 server-ec.{crt,key} -- sample elliptic curve server key/cert
+tc2.key             -- sample tls-crypt-v2 server key
+tc2-client.key      -- sample tls-crypt-v2 client key, for use with tc2.key
diff --git a/sample/sample-keys/ca.crl b/sample/sample-keys/ca.crl
new file mode 100644
index 0000000..6a00a41
--- /dev/null
+++ b/sample/sample-keys/ca.crl
@@ -0,0 +1,21 @@
+-----BEGIN X509 CRL-----
+MIIDcjCCAVoCAQEwDQYJKoZIhvcNAQELBQAwZjELMAkGA1UEBhMCS0cxCzAJBgNV
+BAgMAk5BMRAwDgYDVQQHDAdCSVNIS0VLMRUwEwYDVQQKDAxPcGVuVlBOLVRFU1Qx
+ITAfBgkqhkiG9w0BCQEWEm1lQG15aG9zdC5teWRvbWFpbhcNMjYxMDE2MjE1MTE0
+WhcNMzYxMDEzMjE1MTE0WjAUMBICAQgXDTI2MTAxNjIxNDYzOVqggakwgaYwgaMG
+A1UdIwSBmzCBmIAUc7G41oqVaxLgdHzFV1WYlFuseF6haqRoMGYxCzAJBgNVBAYT
+AktHMQswCQYDVQQIDAJOQTEQMA4GA1UEBwwHQklTSEtFSzEVMBMGA1UECgwMT3Bl
+blZQTi1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW6CFG9Q
+uNNGbnI0WbwAM918rhLrJ0YGMA0GCSqGSIb3DQEBCwUAA4ICAQBnOXQjAUEi3AAX
+8O6Z9jEH+PK0YbHm5fAKi2db+u7iFc1oB8usI+pSFYP3ZYHMAtjdDPxk2GvlfXcU
+pCYuPSN3FF3eaTl53xIF7dn3w2279vbN4b+g1Z0kr5Uba5T18HFrUA5/LnM+f/1x
+y7162j4LjVEy6lIvG7byvPF/mwmfaG9DTkcuAV0ChZnkLhT7yX0CL3xJUMDl2717
+5aFR09/FQnvPqIbUgWH55CTeXkPsVh+ivHzQBIiqHJ/e9A6qZeKPJD7qaTPmRDAS
+mufLvCJKUUs2zdSmXAM0E3P9znNolIepsr9daGNRGkRoOhM5EEHZ2cUUy1rftGd5
+BBZrTf/A8DpCfXoL2mMBUl499DRgPefhJXZLmjjAp4F7t8hWZIam40f4qKk/suoO
+MyWgK+pBnHZqijIXCoYnUYNNpem6I2YW0gWLayqaxEndA28WKtuR6jeWPt7ErTtg
+m9YvveBhxy+2QXWJgFBoiEKskK2wad9qXt+h08Bi70G+KOK7GDm+UkA0D5yMulnW
+A0qll22u8ASmmIeohg65VU82d6jJy/OqikxSPEQ+Ya9zPmr/ASGrX2nChrPGmeUC
+UFUTlIhUuamVLkuvOQu/meWhS/XKf3uSMXilXtcI7lmt1wTnFAFLBeZzQxgyn8kY
+5u/LWT5Fvd0BKM7/Omah55B/YBTiTA==
+-----END X509 CRL-----
diff --git a/sample/sample-keys/client-revoked.crt b/sample/sample-keys/client-revoked.crt
new file mode 100644
index 0000000..c0677ef
--- /dev/null
+++ b/sample/sample-keys/client-revoked.crt
@@ -0,0 +1,103 @@
+Certificate:
+    Data:
+        Version: 3 (0x2)
+        Serial Number: 8 (0x8)
+        Signature Algorithm: sha256WithRSAEncryption
+        Issuer: C=KG, ST=NA, L=BISHKEK, O=OpenVPN-TEST/emailAddress=me@myhost.mydomain
+        Validity
+            Not Before: Oct 16 21:46:39 2026 GMT
+            Not After : Oct 13 21:46:39 2036 GMT
+        Subject: C=KG, ST=NA, O=OpenVPN-TEST, CN=client-revoked/emailAddress=me@myhost.mydomain
+        Subject Public Key Info:
+            Public Key Algorithm: rsaEncryption
+                Public-Key: (2048 bit)
+                Modulus:
+                    00:83:ce:d2:5e:8f:cd:c3:fa:ea:b8:f0:3d:3b:59:
+                    e8:e6:6a:b9:04:ce:53:5c:04:49:71:cc:98:c7:dc:
+                    d7:a8:38:08:dd:f4:62:c6:f4:34:1c:c0:b7:75:50:
+                    45:e3:7f:62:35:86:0e:a9:b1:b3:9a:52:b8:dd:1e:
+                    e4:68:86:4f:86:f8:8d:f2:e1:42:eb:74:37:37:43:
+                    65:11:bf:a0:b9:3f:95:f7:c8:cb:f5:82:10:49:79:
+                    8a:1a:59:c0:c1:7b:97:90:22:08:c2:35:6b:3d:93:
+                    df:e2:c8:2a:4d:f1:84:67:78:1d:45:5a:8c:8e:93:
+                    f6:9e:0b:8d:cd:6a:37:bf:4a:49:fb:a6:51:e5:d0:
+                    00:e3:1f:d9:b9:f8:7a:42:ed:94:9f:9f:43:5e:28:
+                    6f:90:f1:d1:be:6a:9c:64:2e:e2:b9:67:ab:1a:b1:
+                    ee:39:e6:d4:88:86:f6:90:79:af:6b:28:14:3b:27:
+                    58:64:80:e1:0a:65:ea:a8:d1:f6:f4:2c:95:26:90:
+                    46:cd:47:66:f1:24:80:3d:43:1d:c3:ba:77:a4:33:
+                    5f:a6:7f:d9:bc:eb:bc:a3:fb:8f:f2:e3:4a:18:18:
+                    4d:88:b0:ae:89:d2:5c:e3:86:b3:6b:5a:f9:21:3c:
+                    74:4e:4f:5b:1e:3f:98:fd:bc:27:88:ca:07:47:c7:
+                    01:cd
+                Exponent: 65537 (0x10001)
+        X509v3 extensions:
+            X509v3 Basic Constraints: 
+                CA:FALSE
+            X509v3 Subject Key Identifier: 
+                EA:78:19:C4:E5:92:EF:31:82:FF:32:15:A5:3E:9D:93:27:9F:DA:8A
+            X509v3 Authority Key Identifier: 
+                keyid:73:B1:B8:D6:8A:95:6B:12:E0:74:7C:C5:57:55:98:94:5B:AC:78:5E
+                DirName:/C=KG/ST=NA/L=BISHKEK/O=OpenVPN-TEST/emailAddress=me@myhost.mydomain
+                serial:6F:50:B8:D3:46:6E:72:34:59:BC:00:33:DD:7C:AE:12:EB:27:46:06
+    Signature Algorithm: sha256WithRSAEncryption
+    Signature Value:
+        7f:67:77:df:20:da:f9:25:f8:f3:5b:57:40:4d:bb:5f:99:0a:
+        6f:ad:89:11:12:15:3d:22:0f:f8:bd:06:d1:ea:95:09:a9:9b:
+        88:60:81:60:eb:89:cc:06:b0:08:5e:b3:7c:e4:5c:d8:bf:f5:
+        f9:11:0d:70:90:c4:56:f5:d2:b6:16:bf:98:ef:f8:0b:5e:31:
+        9f:e3:4f:c4:6d:4e:0a:3d:6b:9c:a1:25:84:2d:b6:85:c7:01:
+        d0:65:85:a8:07:63:37:d5:64:d4:b4:7f:94:14:ce:10:d1:b7:
+        ff:9c:84:ad:0a:b7:6b:2a:da:ff:cf:3d:ac:ff:84:6d:83:49:
+        7f:01:47:40:7a:c6:54:9c:93:60:b8:ae:d3:b7:24:a1:0e:8e:
+        a4:20:70:e7:76:f6:1f:2c:81:81:ca:04:4b:b0:7c:58:ec:89:
+        a8:ef:24:d9:67:27:2b:f3:d3:c6:58:cf:a5:9f:55:ef:bb:a7:
+        00:b0:5f:a0:ee:81:0f:e2:f4:65:0b:b2:fc:84:fd:26:c4:56:
+        d6:f1:e9:f8:6b:d7:b4:af:05:55:87:26:50:2f:50:7b:a7:cc:
+        e4:e3:fe:60:53:75:77:7e:d4:c0:8b:74:e1:aa:9f:71:1b:78:
+        93:ad:a3:3e:0e:c0:e1:9f:52:d6:83:9f:93:84:4a:fe:92:a6:
+        f5:6d:47:ad:5b:c7:8a:f5:48:24:14:fd:60:2f:68:22:ce:d6:
+        de:be:13:56:62:36:ff:31:a0:58:05:e4:e9:31:b3:f2:b3:5d:
+        37:b2:a4:6f:3f:7f:99:6a:b6:b9:64:a0:29:d7:80:b6:63:27:
+        0a:4b:48:d1:7b:d1:56:d4:b1:e7:5c:74:ef:2d:6a:99:f0:23:
+        4a:3f:4e:b3:a3:5e:e8:3a:dc:7e:be:81:4c:1a:6f:50:de:65:
+        1a:0c:fe:25:d3:7c:45:68:fb:49:69:de:15:d2:ca:76:15:bf:
+        ba:ad:23:d1:c7:04:39:2f:e6:c7:0a:f8:cd:05:86:07:4a:24:
+        64:c3:89:cf:12:d2:e7:26:f2:5a:0f:5e:85:33:77:cc:7e:58:
+        dc:5e:ad:39:20:c0:22:ed:8f:2e:21:ab:2d:e4:e5:21:7c:ad:
+        98:a4:5b:10:40:c8:bd:24:4d:d7:be:45:c0:cf:58:21:91:28:
+        1e:25:10:35:67:92:57:0e:bf:13:4e:59:d2:0d:3b:45:8a:17:
+        6e:93:85:71:f6:2c:22:1b:01:cf:1d:13:0e:1f:bb:d2:28:37:
+        10:ea:af:c3:58:2f:2c:27:0b:f7:12:0d:94:36:60:89:67:79:
+        3f:95:d8:b5:33:e9:1a:53:0d:86:7f:6f:4b:d7:e2:40:9c:19:
+        ea:3f:55:49:b3:e4:04:fb
+-----BEGIN CERTIFICATE-----
+MIIFIjCCAwqgAwIBAgIBCDANBgkqhkiG9w0BAQsFADBmMQswCQYDVQQGEwJLRzEL
+MAkGA1UECAwCTkExEDAOBgNVBAcMB0JJU0hLRUsxFTATBgNVBAoMDE9wZW5WUE4t
+VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTI2MTAx
+NjIxNDYzOVoXDTM2MTAxMzIxNDYzOVowbTELMAkGA1UEBhMCS0cxCzAJBgNVBAgM
+Ak5BMRUwEwYDVQQKDAxPcGVuVlBOLVRFU1QxFzAVBgNVBAMMDmNsaWVudC1yZXZv
+a2VkMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wggEiMA0GCSqG
+SIb3DQEBAQUAA4IBDwAwggEKAoIBAQCDztJej83D+uq48D07WejmarkEzlNcBElx
+zJjH3NeoOAjd9GLG9DQcwLd1UEXjf2I1hg6psbOaUrjdHuRohk+G+I3y4ULrdDc3
+Q2URv6C5P5X3yMv1ghBJeYoaWcDBe5eQIgjCNWs9k9/iyCpN8YRneB1FWoyOk/ae
+C43Naje/Skn7plHl0ADjH9m5+HpC7ZSfn0NeKG+Q8dG+apxkLuK5Z6sase455tSI
+hvaQea9rKBQ7J1hkgOEKZeqo0fb0LJUmkEbNR2bxJIA9Qx3DunekM1+mf9m867yj
++4/y40oYGE2IsK6J0lzjhrNrWvkhPHROT1seP5j9vCeIygdHxwHNAgMBAAGjgdMw
+gdAwCQYDVR0TBAIwADAdBgNVHQ4EFgQU6ngZxOWS7zGC/zIVpT6dkyef2oowgaMG
+A1UdIwSBmzCBmIAUc7G41oqVaxLgdHzFV1WYlFuseF6haqRoMGYxCzAJBgNVBAYT
+AktHMQswCQYDVQQIDAJOQTEQMA4GA1UEBwwHQklTSEtFSzEVMBMGA1UECgwMT3Bl
+blZQTi1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW6CFG9Q
+uNNGbnI0WbwAM918rhLrJ0YGMA0GCSqGSIb3DQEBCwUAA4ICAQB/Z3ffINr5Jfjz
+W1dATbtfmQpvrYkREhU9Ig/4vQbR6pUJqZuIYIFg64nMBrAIXrN85FzYv/X5EQ1w
+kMRW9dK2Fr+Y7/gLXjGf40/EbU4KPWucoSWELbaFxwHQZYWoB2M31WTUtH+UFM4Q
+0bf/nIStCrdrKtr/zz2s/4Rtg0l/AUdAesZUnJNguK7TtyShDo6kIHDndvYfLIGB
+ygRLsHxY7Imo7yTZZycr89PGWM+ln1Xvu6cAsF+g7oEP4vRlC7L8hP0mxFbW8en4
+a9e0rwVVhyZQL1B7p8zk4/5gU3V3ftTAi3Thqp9xG3iTraM+DsDhn1LWg5+ThEr+
+kqb1bUetW8eK9UgkFP1gL2giztbevhNWYjb/MaBYBeTpMbPys103sqRvP3+Zara5
+ZKAp14C2YycKS0jRe9FW1LHnXHTvLWqZ8CNKP06zo17oOtx+voFMGm9Q3mUaDP4l
+03xFaPtJad4V0sp2Fb+6rSPRxwQ5L+bHCvjNBYYHSiRkw4nPEtLnJvJaD16FM3fM
+fljcXq05IMAi7Y8uIast5OUhfK2YpFsQQMi9JE3XvkXAz1ghkSgeJRA1Z5JXDr8T
+TlnSDTtFihduk4Vx9iwiGwHPHRMOH7vSKDcQ6q/DWC8sJwv3Eg2UNmCJZ3k/ldi1
+M+kaUw2Gf29L1+JAnBnqP1VJs+QE+w==
+-----END CERTIFICATE-----
diff --git a/sample/sample-keys/client-revoked.key b/sample/sample-keys/client-revoked.key
new file mode 100644
index 0000000..83f9086
--- /dev/null
+++ b/sample/sample-keys/client-revoked.key
@@ -0,0 +1,28 @@
+-----BEGIN PRIVATE KEY-----
+MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCDztJej83D+uq4
+8D07WejmarkEzlNcBElxzJjH3NeoOAjd9GLG9DQcwLd1UEXjf2I1hg6psbOaUrjd
+HuRohk+G+I3y4ULrdDc3Q2URv6C5P5X3yMv1ghBJeYoaWcDBe5eQIgjCNWs9k9/i
+yCpN8YRneB1FWoyOk/aeC43Naje/Skn7plHl0ADjH9m5+HpC7ZSfn0NeKG+Q8dG+
+apxkLuK5Z6sase455tSIhvaQea9rKBQ7J1hkgOEKZeqo0fb0LJUmkEbNR2bxJIA9
+Qx3DunekM1+mf9m867yj+4/y40oYGE2IsK6J0lzjhrNrWvkhPHROT1seP5j9vCeI
+ygdHxwHNAgMBAAECggEABMlBDtF6d4wYM1x34LyYTiugacoDMWNvdkwnXRSKGS/l
+tIeQAajy7ntZ/g7K5uKkgoyKYkOTYb5wu4jIYvpDj4Ndhi0DVNDsw1s1Y5JZh/iE
+3dFDBLhzFnPtHZ1WOEBgZcmylzjA2uTQe6foj1l+hRJRv8e0tGWvjhgdz1B000OW
+OmJC9M6neHghuhUAShfqHbDkXOd9w/HnQCu9TyWqV/D7h63dP3PfSgM1q5o5CrHZ
+2VVynpq3W4KPkPC4IsdKrmvE+Y6bwhFgU48rUSBmzpNGGhRcI3JkpButzRE7ZD2O
+uljFZbkt5LeCH0nIb09YPVTFjRpaQ95mktU70IeQEQKBgQC5GkohgCnIj+1rYKXq
+7O1dD5RrFO5NGNdvwsQpcFF6kdcWKquGO9Ts392VOMsYDctxZX3x2LOaDhB8KkYl
+5lqh+uIULZxPYvb+SMIBnkcV1z7mnCu7dOltgJKdMkeHGwpCXUne8NtoC4wWd7Ao
+iEoK1pMWp9VLZMB5pZsg+eYvEQKBgQC2St1gSYG48ZbUoQzP0Qs/bl7ojTrQzNp9
+TIUvDvnxI5OLDN3HIn9xgDa9eSYr6CTvTNJ42uL8CSu2I4HwQDMYBNMUfqJRVKoy
+mVzKQBsLNKzBZlzO8GnJQw5hZJoZRBz5FJiQjz9y7pSD9nKObeMarXDRE2BkwYw2
+KLJrll6e/QKBgFLhy6m+enccwyFecEyF9C7ESB++iompAuY/HpizezhXzyhUyOLd
+LZU3FD+5426M1riayk8dSiZD/+uo/ioAQDrhXJPObHw7gv8PUxdoaMoFzFt0ODzC
+t7bZaEzM86wyVmCq5uXVkVjAOuTgiNdNV2IM/GWblu0gWvLdTV3xp7kRAoGBAK+g
+CRBPQW+RMiPA1bsSR6fhCgc6qcOo2YeGRXpFD4DHKcr5pmHIVshfIl4Bbkk26v6y
+IMTW/YCcxURBiVqSP6eQXlyMdI2u6Bq/rqocgPGW2imqGRg2f3Sr6hri9aQJ/2/p
+6+K6YAK24NcShOO78uUs3FhSNrhb0F4Nb3g/8wFxAoGAKATiB4J12yBiDgMI8dLH
+uCOA7BuB9G/sOWFCWlY1gQaca6fgKvkbKiv6SOH9g7D72s9RJXXXrnM/Cy6hG4+t
+7YMAhEPG8dxZCwkEIGxk761aq7a6iiHnvYeXHWrSbucXGQfiX/x4NB8lbXtaPBxH
+zrsv83SJbTUdHnaq0YJOIoc=
+-----END PRIVATE KEY-----
diff --git a/sample/sample-keys/gen-sample-keys.sh b/sample/sample-keys/gen-sample-keys.sh
index fa5f697..16010b2 100755
--- a/sample/sample-keys/gen-sample-keys.sh
+++ b/sample/sample-keys/gen-sample-keys.sh
@@ -18,6 +18,11 @@
 top_builddir="${top_builddir:-$(dirname ${0})/../..}"
 ${top_builddir}/src/openvpn/openvpn --genkey tls-auth ta.key
 
+# Generate tls-crypt-v2 server key, and a client key wrapped with that key
+${top_builddir}/src/openvpn/openvpn --genkey tls-crypt-v2-server tc2.key
+${top_builddir}/src/openvpn/openvpn --tls-crypt-v2 tc2.key \
+    --genkey tls-crypt-v2-client tc2-client.key
+
 # Create required directories and files
 mkdir -p sample-ca
 rm -f sample-ca/index.txt
diff --git a/sample/sample-keys/tc2-client.key b/sample/sample-keys/tc2-client.key
new file mode 100644
index 0000000..8c9a505
--- /dev/null
+++ b/sample/sample-keys/tc2-client.key
@@ -0,0 +1,14 @@
+-----BEGIN OpenVPN tls-crypt-v2 client key-----
+Lm43KRMlWHXMynOOGVmEQs51QjN7LhcqlhZ9XRzincFN+0iSpp1mfOUnB/oKXbKq
+PyH1sToo0zjJKQ1Bkb/cprcORcQSW1vcIDnlTdbVnLlbciaGQ6ipr58zEeV65hSq
+l5jtQynh+nojbdhHfx5b8W05dxZUbYdLzzqABQrl/ti2QX4u1jwzxTx43NrUbEWr
+a6ftgZFQ7kkzYTFMVJmciPYnwqnzguPRSJGXoptXaYAtX1qz8ON46zft1Nr9Ss/O
+uEAi4LYT3VIdKN0T6Yuld4+pKamYCA0fkz/VmhPYeWN00349k5b9VLFfBqyRlUZX
+FF4nZEgatKn+re+VMKg9DASfqxmgIz1+QMNAlpytZ+22742Xhr/WnjLdRo5f1it7
+UhxqTfWqxnTvNLyVCE2jBQqzsHRfsVIej58ddZCOn45T7nwJD/r4GSLVJobO8TST
+FzGUKlfURZ5X+lrMVpkFJhMZchfsXps4976YydBCmb5QKXDbYbcPW4Gfd4NZkNPo
+EWo4pjIk9wge5mAntay1elQOMoTkbBGJxUdzzZ7eEND9JH0VJixic2wq4ZJwoGlp
+zMNvlRklj18FtH7RcHpC68cJX5DH7mY+jpWFruYnE1+SHXpSQkYse6vdtg8zurMC
++Y5RbK1J5u3Ts/BKD8CzJGO0S/4jAOFGrQNUuk0GlAAT9NtyCNbUPob9Ssd2kfT0
+R6csdyWDN2aZRQNPapdLJhHuY/kWfnKIhwEr
+-----END OpenVPN tls-crypt-v2 client key-----
diff --git a/sample/sample-keys/tc2.key b/sample/sample-keys/tc2.key
new file mode 100644
index 0000000..6f1440c
--- /dev/null
+++ b/sample/sample-keys/tc2.key
@@ -0,0 +1,5 @@
+-----BEGIN OpenVPN tls-crypt-v2 server key-----
+Ia2XWSUJAgWX7bpHu1qXCkmiDO2ZM/YasZs3e4uayasgjblLO7n9BRIJg5LEzO7R
+ugilb3ETPFPBr7zNMLW4/Td745emPvCpKyHabwsZeXih8cNQHgwyjCpEdL/a7xHH
+hHGYMnGPbh9jnly9YbTc8ar/ZxOnTQjTHdosJaeTKMk=
+-----END OpenVPN tls-crypt-v2 server key-----


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
