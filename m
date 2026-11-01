Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93043606A324
	for <openvpn-devel@archiver.kernel.org>; Sun,  1 Nov 2026 19:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jVgSZl0k;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=llLSS/C0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DsHahSIn;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RAsFLu55
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=exUSY+4b6iR7H2qaLqdlUtw0jRvDoehD81hxAxBxyhQ=; b=jVgSZl0kksFj90P+gq021oBmho
	c4ZnNZpp+2LrE4V/sC4h6YItb1I+xUkyR0bOGiehh0lY588njha95+F6aIzFPR24fRWkLh1dbe6z+
	xptBFiEQhWASuDBhl9SFlsw6uuqqbrqQrJdE9gS/jwBBSk0aJLYItZqzHwno/PXcJxuM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNbEX-000000006ih-0y9G;
	Sun, 01 Nov 2026 19:28:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNbEV-000000006iY-0uPw
 for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 19:28:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mNoKJW86EYpnu9ArIms7WMtyALJBYI3hFdRXAgSfPGE=; b=llLSS/C069tmaXHYkFzw6KyUuD
 KP//QhvEPGv9JXwe/ZbcYECQTod0Y7fGSTjL9o5pMppacCB8Bi5TE+fxHcZU+jiKTxeWzHMVzgaes
 1gm1z9PCuwjFIlbiivL8/pphp11glZJ+FDJYwQXDQgXNxQYZepn+BBg7JQaKf7p3KpJE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mNoKJW86EYpnu9ArIms7WMtyALJBYI3hFdRXAgSfPGE=; b=DsHahSIn3h5bVyfBZGE3eSLzIy
 tvelW51whUSUklj08U2m4mO7abIexy4gVmUVGPCDgEOIkLu9wdjooJoVVPPpVs7cXG0LzooYsXJKm
 FwfWrTUZyoKZhmD7aeu7DcdsSicEESSkKKUCbumKaErAnqbvg4OQG+ZaKLDijXzvZbKc=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNbET-000000001X7-1WEg for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 19:28:47 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso15049445e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 01 Nov 2026 11:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793561319; x=1794166119; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mNoKJW86EYpnu9ArIms7WMtyALJBYI3hFdRXAgSfPGE=;
 b=RAsFLu55ZEbQrtnpVH3t+ZClcWA4NRsvgSg9lnUmH5kbawxWWOTo5CGlzXUOqDSxOx
 0DBtk4rc9c4wpTn0Y4TazprF1KWMmfuURq0E8uo5PeIHZIbp4jv5+imMQhRfdq182rZT
 fhfLLFVpWvnN8fSQHobgufrlZJsRNiRuIf9OlHU6je5qiTdAfwYtXsI9Qe8/tuYwFj1C
 qtAbBUSvnoCXNkFTG6kgeVFiov1DaghUa96rNk3QdW8Lu4sP1KUF3WB2hHA2ZLh3pGKd
 H58ZBVd7E6gYctZXpxXb7rCXCiSWLElPgEezW84RqS8fdXeYEqkCWm9XYnJIxpdAkTG0
 Bhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793561319; x=1794166119;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mNoKJW86EYpnu9ArIms7WMtyALJBYI3hFdRXAgSfPGE=;
 b=w0CSg8ZKmM44ELVanRSEbjhLxLi8tOipSmY+MsnWdSWlLkamEN8Jmwy19wmbgbeI9H
 jCXtqU+GX5dlrOz4NCz+IP5UmNkhBGiEuLlXZzy+QbTU/X8yFaOmZzpd/Po7QHPtEEGD
 HpUG/jeJIMxf5T65NfOJIhPO9Q02Ox58BiRin3JWlo7+h50aLyynylcLBUxt4J5ANkmr
 CyurPGIEI0rYI2Xs8HBqf106h1SiCJqdeCUlOWh/buogJfN81304sQjL1Me+vp1BHco5
 POhOgQuZd95ZuBCEugOne8hHWfmsKcPmdwczCW+LK56a76p1FH/enfvUX3jyjJ3qTkVi
 qDPg==
X-Gm-Message-State: AFq9FYLlxFMJ9OE4jESnEHDeq3wy7706d5+5JzzRznsj/+RfYqo7+1wT
 3ZdCvMmn9Huo3c1mLOpkgmgwhjAYuep7CNo2IGvxTib02X2/0+d+l45nIrV/LOjdHQDY6BEmR4a
 WA/+XI2Ynwqj8IXaqwEMAsFRrEQgDxGtREaGQ+G/Qlp9yFiWjW1o/T52pTUg85JNCLy9JRxDol3
 B1xh5hww==
X-Gm-Gg: AYBFou1t3X2krdCNUxvZl8Q+u5QG0Z+kgghlSpuEyiqQS6O2WUOb7bM+qryNceKiOv+
 YLJH7p+BZzA2xOiTFRYNwg9695glokA8MA4aZpVt/hyLNCdInLWOSqAHbhxv2qa86scOaod590e
 Qgluh8/WQ64uwMdlztZ+gXDbyksPCL8NZqQuNiWm/XiLzxQVL93yFXcFi7Gs79ZxUkcYD8ZFuQH
 NHiD3jh5LdVJYz9ooElKUze302MqcgKcag2He9GyXNZLZj4c0KRBngZdVXscdZ/aJ16U29zwSkW
 4KjoX3PGXnwbjFs9W9KwRD9tDv678RmVk5UR12Q2raCC1l2BR4YamesYU32KWJcfP2EyYjN1vkf
 ymB7M0WJACYmnY+KbGaNhsIQXONMijqIhaG5dWHFVcfudOjtA90UPNloD2auaSfmkIx6gokU8lM
 XJGRcqkhCYP86Om2mKAZoNqjjOe6cU3k2jEUQ3I4kiO92zYC1TCSQt9neQEncy9rBBIbKfQIskl
 5l9r/dsfkMoXatAB/1RitL03E17nFJCSQeP9r+knDqPSV2gGseNPg+CIsxfzpffC3MFH8G4pNVL
 gG8y3tGovJwTdCedwHbk6ar9xTxvh/J4LqwDCaE4UVqyyKXT/W4o5+pmMB9DCnYt1/4C5gWc6jm
 p88pd6bh1uAZ9qaYC/K+BF9O67Q2N8SK0WSpxzLWLEQDjpCRWHHqXd2MIkLxjE8QpQiJHm74uyI
 szn3LfurmDuoMZzw==
X-Received: by 2002:a05:600c:46d1:b0:4a1:825a:56fd with SMTP id
 5b1f17b1804b1-4ac18a88fa6mr196351465e9.32.1793561318530; 
 Sun, 01 Nov 2026 11:28:38 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa813d2950sm288604205e9.8.2026.11.01.11.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 11:28:38 -0800 (PST)
X-Google-Original-From: "Steffan Karger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 1 Nov 2026 19:28:37 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie54c455006782662e3ed51e0db869ce403a66e74
X-Gerrit-Change-Number: 2011
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2011?usp=email>
X-Gerrit-Commit: d61099578ddede400f751b12eda1ccbb6d62beec
References: <gerrit.1792315181000.Ie54c455006782662e3ed51e0db869ce403a66e74@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMzE1MTgxMDAwLkllNTRjNDU1MDA2NzgyNjYyZTNlZDUxZTBkYjg2OWNlNDAzYTY2ZTc0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9cc8ce96129f3b9c22bf4470cc0a274b3498936d-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNbET-000000001X7-1WEg
Subject: [Openvpn-devel] [M] Change in openvpn[master]: sample-keys: add
 tls-crypt-v2 keys and revoked cert
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Steffan Karger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: steffan@karger.me, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Steffan Karger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0146008197747671634=="
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0146008197747671634==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rG4WVaC0DrA="; charset=UTF-8

--rG4WVaC0DrA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2011?usp=3Demail

to review the following change=2E
=


Change subject: sample-keys: add tls-crypt-v2 keys and revoked cert
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

sample-keys: add=
 tls-crypt-v2 keys and revoked cert

To facilitate both manual tests as wel=
l as the upcoming connection test
suite=2E

Change-Id: Ie54c455006782662e3e=
d51e0db869ce403a66e74
Signed-off-by: Steffan Karger <steffan@karger=2Eme>
-=
--
M sample/sample-keys/README
A sample/sample-keys/ca=2Ecrl
A sample/sampl=
e-keys/client-revoked=2Ecrt
A sample/sample-keys/client-revoked=2Ekey
M sam=
ple/sample-keys/gen-sample-keys=2Esh
A sample/sample-keys/tc2-client=2Ekey
=
A sample/sample-keys/tc2=2Ekey
7 files changed, 178 insertions(+), 0 deleti=
ons(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/11/2011/1

diff --git a/sample/sample-keys/README b/sample/sample-keys/RE=
ADME
index 66dd945=2E=2E4095534 100644
--- a/sample/sample-keys/README
+++ =
b/sample/sample-keys/README
@@ -17,3 +17,5 @@
                        passw=
ord =3D "password"
 client-ec=2E{crt,key} -- sample elliptic curve client k=
ey/cert
 server-ec=2E{crt,key} -- sample elliptic curve server key/cert
+tc=
2=2Ekey             -- sample tls-crypt-v2 server key
+tc2-client=2Ekey    =
  -- sample tls-crypt-v2 client key, for use with tc2=2Ekey
diff --git a/sa=
mple/sample-keys/ca=2Ecrl b/sample/sample-keys/ca=2Ecrl
new file mode 10064=
4
index 0000000=2E=2E6a00a41
--- /dev/null
+++ b/sample/sample-keys/ca=2Ecr=
l
@@ -0,0 +1,21 @@
+-----BEGIN X509 CRL-----
+MIIDcjCCAVoCAQEwDQYJKoZIhvcNA=
QELBQAwZjELMAkGA1UEBhMCS0cxCzAJBgNV
+BAgMAk5BMRAwDgYDVQQHDAdCSVNIS0VLMRUwEw=
YDVQQKDAxPcGVuVlBOLVRFU1Qx
+ITAfBgkqhkiG9w0BCQEWEm1lQG15aG9zdC5teWRvbWFpbhc=
NMjYxMDE2MjE1MTE0
+WhcNMzYxMDEzMjE1MTE0WjAUMBICAQgXDTI2MTAxNjIxNDYzOVqggakw=
gaYwgaMG
+A1UdIwSBmzCBmIAUc7G41oqVaxLgdHzFV1WYlFuseF6haqRoMGYxCzAJBgNVBAYT
=
+AktHMQswCQYDVQQIDAJOQTEQMA4GA1UEBwwHQklTSEtFSzEVMBMGA1UECgwMT3Bl
+blZQTi1U=
RVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW6CFG9Q
+uNNGbnI0WbwAM918r=
hLrJ0YGMA0GCSqGSIb3DQEBCwUAA4ICAQBnOXQjAUEi3AAX
+8O6Z9jEH+PK0YbHm5fAKi2db+u=
7iFc1oB8usI+pSFYP3ZYHMAtjdDPxk2GvlfXcU
+pCYuPSN3FF3eaTl53xIF7dn3w2279vbN4b+=
g1Z0kr5Uba5T18HFrUA5/LnM+f/1x
+y7162j4LjVEy6lIvG7byvPF/mwmfaG9DTkcuAV0ChZnk=
LhT7yX0CL3xJUMDl2717
+5aFR09/FQnvPqIbUgWH55CTeXkPsVh+ivHzQBIiqHJ/e9A6qZeKPJ=
D7qaTPmRDAS
+mufLvCJKUUs2zdSmXAM0E3P9znNolIepsr9daGNRGkRoOhM5EEHZ2cUUy1rftG=
d5
+BBZrTf/A8DpCfXoL2mMBUl499DRgPefhJXZLmjjAp4F7t8hWZIam40f4qKk/suoO
+MyWgK=
+pBnHZqijIXCoYnUYNNpem6I2YW0gWLayqaxEndA28WKtuR6jeWPt7ErTtg
+m9YvveBhxy+2QX=
WJgFBoiEKskK2wad9qXt+h08Bi70G+KOK7GDm+UkA0D5yMulnW
+A0qll22u8ASmmIeohg65VU8=
2d6jJy/OqikxSPEQ+Ya9zPmr/ASGrX2nChrPGmeUC
+UFUTlIhUuamVLkuvOQu/meWhS/XKf3uS=
MXilXtcI7lmt1wTnFAFLBeZzQxgyn8kY
+5u/LWT5Fvd0BKM7/Omah55B/YBTiTA=3D=3D
+---=
--END X509 CRL-----
diff --git a/sample/sample-keys/client-revoked=2Ecrt b/=
sample/sample-keys/client-revoked=2Ecrt
new file mode 100644
index 0000000=
=2E=2Ec0677ef
--- /dev/null
+++ b/sample/sample-keys/client-revoked=2Ecrt
@=
@ -0,0 +1,103 @@
+Certificate:
+    Data:
+        Version: 3 (0x2)
+      =
  Serial Number: 8 (0x8)
+        Signature Algorithm: sha256WithRSAEncrypt=
ion
+        Issuer: C=3DKG, ST=3DNA, L=3DBISHKEK, O=3DOpenVPN-TEST/emailAd=
dress=3Dme@myhost=2Emydomain
+        Validity
+            Not Before: Oct=
 16 21:46:39 2026 GMT
+            Not After : Oct 13 21:46:39 2036 GMT
+  =
      Subject: C=3DKG, ST=3DNA, O=3DOpenVPN-TEST, CN=3Dclient-revoked/email=
Address=3Dme@myhost=2Emydomain
+        Subject Public Key Info:
+         =
   Public Key Algorithm: rsaEncryption
+                Public-Key: (2048 b=
it)
+                Modulus:
+                    00:83:ce:d2:5e:8f:cd:c3:=
fa:ea:b8:f0:3d:3b:59:
+                    e8:e6:6a:b9:04:ce:53:5c:04:49:71=
:cc:98:c7:dc:
+                    d7:a8:38:08:dd:f4:62:c6:f4:34:1c:c0:b7:7=
5:50:
+                    45:e3:7f:62:35:86:0e:a9:b1:b3:9a:52:b8:dd:1e:
+ =
                   e4:68:86:4f:86:f8:8d:f2:e1:42:eb:74:37:37:43:
+         =
           65:11:bf:a0:b9:3f:95:f7:c8:cb:f5:82:10:49:79:
+                 =
   8a:1a:59:c0:c1:7b:97:90:22:08:c2:35:6b:3d:93:
+                    df:e2=
:c8:2a:4d:f1:84:67:78:1d:45:5a:8c:8e:93:
+                    f6:9e:0b:8d:c=
d:6a:37:bf:4a:49:fb:a6:51:e5:d0:
+                    00:e3:1f:d9:b9:f8:7a:=
42:ed:94:9f:9f:43:5e:28:
+                    6f:90:f1:d1:be:6a:9c:64:2e:e2=
:b9:67:ab:1a:b1:
+                    ee:39:e6:d4:88:86:f6:90:79:af:6b:28:1=
4:3b:27:
+                    58:64:80:e1:0a:65:ea:a8:d1:f6:f4:2c:95:26:90:=

+                    46:cd:47:66:f1:24:80:3d:43:1d:c3:ba:77:a4:33:
+      =
              5f:a6:7f:d9:bc:eb:bc:a3:fb:8f:f2:e3:4a:18:18:
+              =
      4d:88:b0:ae:89:d2:5c:e3:86:b3:6b:5a:f9:21:3c:
+                    74=
:4e:4f:5b:1e:3f:98:fd:bc:27:88:ca:07:47:c7:
+                    01:cd
+   =
             Exponent: 65537 (0x10001)
+        X509v3 extensions:
+       =
     X509v3 Basic Constraints: 
+                CA:FALSE
+            X509=
v3 Subject Key Identifier: 
+                EA:78:19:C4:E5:92:EF:31:82:FF:=
32:15:A5:3E:9D:93:27:9F:DA:8A
+            X509v3 Authority Key Identifier:=
 
+                keyid:73:B1:B8:D6:8A:95:6B:12:E0:74:7C:C5:57:55:98:94:5B=
:AC:78:5E
+                DirName:/C=3DKG/ST=3DNA/L=3DBISHKEK/O=3DOpenVPN-=
TEST/emailAddress=3Dme@myhost=2Emydomain
+                serial:6F:50:B8:D=
3:46:6E:72:34:59:BC:00:33:DD:7C:AE:12:EB:27:46:06
+    Signature Algorithm:=
 sha256WithRSAEncryption
+    Signature Value:
+        7f:67:77:df:20:da:f=
9:25:f8:f3:5b:57:40:4d:bb:5f:99:0a:
+        6f:ad:89:11:12:15:3d:22:0f:f8:=
bd:06:d1:ea:95:09:a9:9b:
+        88:60:81:60:eb:89:cc:06:b0:08:5e:b3:7c:e4=
:5c:d8:bf:f5:
+        f9:11:0d:70:90:c4:56:f5:d2:b6:16:bf:98:ef:f8:0b:5e:3=
1:
+        9f:e3:4f:c4:6d:4e:0a:3d:6b:9c:a1:25:84:2d:b6:85:c7:01:
+       =
 d0:65:85:a8:07:63:37:d5:64:d4:b4:7f:94:14:ce:10:d1:b7:
+        ff:9c:84:a=
d:0a:b7:6b:2a:da:ff:cf:3d:ac:ff:84:6d:83:49:
+        7f:01:47:40:7a:c6:54:=
9c:93:60:b8:ae:d3:b7:24:a1:0e:8e:
+        a4:20:70:e7:76:f6:1f:2c:81:81:ca=
:04:4b:b0:7c:58:ec:89:
+        a8:ef:24:d9:67:27:2b:f3:d3:c6:58:cf:a5:9f:5=
5:ef:bb:a7:
+        00:b0:5f:a0:ee:81:0f:e2:f4:65:0b:b2:fc:84:fd:26:c4:56:=

+        d6:f1:e9:f8:6b:d7:b4:af:05:55:87:26:50:2f:50:7b:a7:cc:
+        e=
4:e3:fe:60:53:75:77:7e:d4:c0:8b:74:e1:aa:9f:71:1b:78:
+        93:ad:a3:3e:=
0e:c0:e1:9f:52:d6:83:9f:93:84:4a:fe:92:a6:
+        f5:6d:47:ad:5b:c7:8a:f5=
:48:24:14:fd:60:2f:68:22:ce:d6:
+        de:be:13:56:62:36:ff:31:a0:58:05:e=
4:e9:31:b3:f2:b3:5d:
+        37:b2:a4:6f:3f:7f:99:6a:b6:b9:64:a0:29:d7:80:=
b6:63:27:
+        0a:4b:48:d1:7b:d1:56:d4:b1:e7:5c:74:ef:2d:6a:99:f0:23:
+=
        4a:3f:4e:b3:a3:5e:e8:3a:dc:7e:be:81:4c:1a:6f:50:de:65:
+        1a:=
0c:fe:25:d3:7c:45:68:fb:49:69:de:15:d2:ca:76:15:bf:
+        ba:ad:23:d1:c7=
:04:39:2f:e6:c7:0a:f8:cd:05:86:07:4a:24:
+        64:c3:89:cf:12:d2:e7:26:f=
2:5a:0f:5e:85:33:77:cc:7e:58:
+        dc:5e:ad:39:20:c0:22:ed:8f:2e:21:ab:=
2d:e4:e5:21:7c:ad:
+        98:a4:5b:10:40:c8:bd:24:4d:d7:be:45:c0:cf:58:21=
:91:28:
+        1e:25:10:35:67:92:57:0e:bf:13:4e:59:d2:0d:3b:45:8a:17:
+  =
      6e:93:85:71:f6:2c:22:1b:01:cf:1d:13:0e:1f:bb:d2:28:37:
+        10:ea=
:af:c3:58:2f:2c:27:0b:f7:12:0d:94:36:60:89:67:79:
+        3f:95:d8:b5:33:e=
9:1a:53:0d:86:7f:6f:4b:d7:e2:40:9c:19:
+        ea:3f:55:49:b3:e4:04:fb
+--=
---BEGIN CERTIFICATE-----
+MIIFIjCCAwqgAwIBAgIBCDANBgkqhkiG9w0BAQsFADBmMQsw=
CQYDVQQGEwJLRzEL
+MAkGA1UECAwCTkExEDAOBgNVBAcMB0JJU0hLRUsxFTATBgNVBAoMDE9wZ=
W5WUE4t
+VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTI2MTAx
+=
NjIxNDYzOVoXDTM2MTAxMzIxNDYzOVowbTELMAkGA1UEBhMCS0cxCzAJBgNVBAgM
+Ak5BMRUwE=
wYDVQQKDAxPcGVuVlBOLVRFU1QxFzAVBgNVBAMMDmNsaWVudC1yZXZv
+a2VkMSEwHwYJKoZIhv=
cNAQkBFhJtZUBteWhvc3QubXlkb21haW4wggEiMA0GCSqG
+SIb3DQEBAQUAA4IBDwAwggEKAoI=
BAQCDztJej83D+uq48D07WejmarkEzlNcBElx
+zJjH3NeoOAjd9GLG9DQcwLd1UEXjf2I1hg6p=
sbOaUrjdHuRohk+G+I3y4ULrdDc3
+Q2URv6C5P5X3yMv1ghBJeYoaWcDBe5eQIgjCNWs9k9/iy=
CpN8YRneB1FWoyOk/ae
+C43Naje/Skn7plHl0ADjH9m5+HpC7ZSfn0NeKG+Q8dG+apxkLuK5Z6=
sase455tSI
+hvaQea9rKBQ7J1hkgOEKZeqo0fb0LJUmkEbNR2bxJIA9Qx3DunekM1+mf9m867y=
j
++4/y40oYGE2IsK6J0lzjhrNrWvkhPHROT1seP5j9vCeIygdHxwHNAgMBAAGjgdMw
+gdAwCQ=
YDVR0TBAIwADAdBgNVHQ4EFgQU6ngZxOWS7zGC/zIVpT6dkyef2oowgaMG
+A1UdIwSBmzCBmIA=
Uc7G41oqVaxLgdHzFV1WYlFuseF6haqRoMGYxCzAJBgNVBAYT
+AktHMQswCQYDVQQIDAJOQTEQ=
MA4GA1UEBwwHQklTSEtFSzEVMBMGA1UECgwMT3Bl
+blZQTi1URVNUMSEwHwYJKoZIhvcNAQkBF=
hJtZUBteWhvc3QubXlkb21haW6CFG9Q
+uNNGbnI0WbwAM918rhLrJ0YGMA0GCSqGSIb3DQEBCw=
UAA4ICAQB/Z3ffINr5Jfjz
+W1dATbtfmQpvrYkREhU9Ig/4vQbR6pUJqZuIYIFg64nMBrAIXrN=
85FzYv/X5EQ1w
+kMRW9dK2Fr+Y7/gLXjGf40/EbU4KPWucoSWELbaFxwHQZYWoB2M31WTUtH+U=
FM4Q
+0bf/nIStCrdrKtr/zz2s/4Rtg0l/AUdAesZUnJNguK7TtyShDo6kIHDndvYfLIGB
+ygR=
LsHxY7Imo7yTZZycr89PGWM+ln1Xvu6cAsF+g7oEP4vRlC7L8hP0mxFbW8en4
+a9e0rwVVhyZQ=
L1B7p8zk4/5gU3V3ftTAi3Thqp9xG3iTraM+DsDhn1LWg5+ThEr+
+kqb1bUetW8eK9UgkFP1gL=
2giztbevhNWYjb/MaBYBeTpMbPys103sqRvP3+Zara5
+ZKAp14C2YycKS0jRe9FW1LHnXHTvLW=
qZ8CNKP06zo17oOtx+voFMGm9Q3mUaDP4l
+03xFaPtJad4V0sp2Fb+6rSPRxwQ5L+bHCvjNBYY=
HSiRkw4nPEtLnJvJaD16FM3fM
+fljcXq05IMAi7Y8uIast5OUhfK2YpFsQQMi9JE3XvkXAz1gh=
kSgeJRA1Z5JXDr8T
+TlnSDTtFihduk4Vx9iwiGwHPHRMOH7vSKDcQ6q/DWC8sJwv3Eg2UNmCJZ=
3k/ldi1
+M+kaUw2Gf29L1+JAnBnqP1VJs+QE+w=3D=3D
+-----END CERTIFICATE-----
di=
ff --git a/sample/sample-keys/client-revoked=2Ekey b/sample/sample-keys/cli=
ent-revoked=2Ekey
new file mode 100644
index 0000000=2E=2E83f9086
--- /dev/=
null
+++ b/sample/sample-keys/client-revoked=2Ekey
@@ -0,0 +1,28 @@
+-----B=
EGIN PRIVATE KEY-----
+MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCD=
ztJej83D+uq4
+8D07WejmarkEzlNcBElxzJjH3NeoOAjd9GLG9DQcwLd1UEXjf2I1hg6psbOaU=
rjd
+HuRohk+G+I3y4ULrdDc3Q2URv6C5P5X3yMv1ghBJeYoaWcDBe5eQIgjCNWs9k9/i
+yCpN=
8YRneB1FWoyOk/aeC43Naje/Skn7plHl0ADjH9m5+HpC7ZSfn0NeKG+Q8dG+
+apxkLuK5Z6sas=
e455tSIhvaQea9rKBQ7J1hkgOEKZeqo0fb0LJUmkEbNR2bxJIA9
+Qx3DunekM1+mf9m867yj+4=
/y40oYGE2IsK6J0lzjhrNrWvkhPHROT1seP5j9vCeI
+ygdHxwHNAgMBAAECggEABMlBDtF6d4w=
YM1x34LyYTiugacoDMWNvdkwnXRSKGS/l
+tIeQAajy7ntZ/g7K5uKkgoyKYkOTYb5wu4jIYvpD=
j4Ndhi0DVNDsw1s1Y5JZh/iE
+3dFDBLhzFnPtHZ1WOEBgZcmylzjA2uTQe6foj1l+hRJRv8e0t=
GWvjhgdz1B000OW
+OmJC9M6neHghuhUAShfqHbDkXOd9w/HnQCu9TyWqV/D7h63dP3PfSgM1q5=
o5CrHZ
+2VVynpq3W4KPkPC4IsdKrmvE+Y6bwhFgU48rUSBmzpNGGhRcI3JkpButzRE7ZD2O
+u=
ljFZbkt5LeCH0nIb09YPVTFjRpaQ95mktU70IeQEQKBgQC5GkohgCnIj+1rYKXq
+7O1dD5RrFO=
5NGNdvwsQpcFF6kdcWKquGO9Ts392VOMsYDctxZX3x2LOaDhB8KkYl
+5lqh+uIULZxPYvb+SMI=
BnkcV1z7mnCu7dOltgJKdMkeHGwpCXUne8NtoC4wWd7Ao
+iEoK1pMWp9VLZMB5pZsg+eYvEQKB=
gQC2St1gSYG48ZbUoQzP0Qs/bl7ojTrQzNp9
+TIUvDvnxI5OLDN3HIn9xgDa9eSYr6CTvTNJ42=
uL8CSu2I4HwQDMYBNMUfqJRVKoy
+mVzKQBsLNKzBZlzO8GnJQw5hZJoZRBz5FJiQjz9y7pSD9n=
KObeMarXDRE2BkwYw2
+KLJrll6e/QKBgFLhy6m+enccwyFecEyF9C7ESB++iompAuY/Hpizezh=
XzyhUyOLd
+LZU3FD+5426M1riayk8dSiZD/+uo/ioAQDrhXJPObHw7gv8PUxdoaMoFzFt0ODzC=

+t7bZaEzM86wyVmCq5uXVkVjAOuTgiNdNV2IM/GWblu0gWvLdTV3xp7kRAoGBAK+g
+CRBPQW+=
RMiPA1bsSR6fhCgc6qcOo2YeGRXpFD4DHKcr5pmHIVshfIl4Bbkk26v6y
+IMTW/YCcxURBiVqS=
P6eQXlyMdI2u6Bq/rqocgPGW2imqGRg2f3Sr6hri9aQJ/2/p
+6+K6YAK24NcShOO78uUs3FhSN=
rhb0F4Nb3g/8wFxAoGAKATiB4J12yBiDgMI8dLH
+uCOA7BuB9G/sOWFCWlY1gQaca6fgKvkbKi=
v6SOH9g7D72s9RJXXXrnM/Cy6hG4+t
+7YMAhEPG8dxZCwkEIGxk761aq7a6iiHnvYeXHWrSbuc=
XGQfiX/x4NB8lbXtaPBxH
+zrsv83SJbTUdHnaq0YJOIoc=3D
+-----END PRIVATE KEY----=
-
diff --git a/sample/sample-keys/gen-sample-keys=2Esh b/sample/sample-keys=
/gen-sample-keys=2Esh
index fa5f697=2E=2E16010b2 100755
--- a/sample/sample=
-keys/gen-sample-keys=2Esh
+++ b/sample/sample-keys/gen-sample-keys=2Esh
@@=
 -18,6 +18,11 @@
 top_builddir=3D"${top_builddir:-$(dirname ${0})/=2E=2E/=
=2E=2E}"
 ${top_builddir}/src/openvpn/openvpn --genkey tls-auth ta=2Ekey
 
=
+# Generate tls-crypt-v2 server key, and a client key wrapped with that key=

+${top_builddir}/src/openvpn/openvpn --genkey tls-crypt-v2-server tc2=2Eke=
y
+${top_builddir}/src/openvpn/openvpn --tls-crypt-v2 tc2=2Ekey \
+    --ge=
nkey tls-crypt-v2-client tc2-client=2Ekey
+
 # Create required directories =
and files
 mkdir -p sample-ca
 rm -f sample-ca/index=2Etxt
diff --git a/sam=
ple/sample-keys/tc2-client=2Ekey b/sample/sample-keys/tc2-client=2Ekey
new =
file mode 100644
index 0000000=2E=2E8c9a505
--- /dev/null
+++ b/sample/samp=
le-keys/tc2-client=2Ekey
@@ -0,0 +1,14 @@
+-----BEGIN OpenVPN tls-crypt-v2 =
client key-----
+Lm43KRMlWHXMynOOGVmEQs51QjN7LhcqlhZ9XRzincFN+0iSpp1mfOUnB/=
oKXbKq
+PyH1sToo0zjJKQ1Bkb/cprcORcQSW1vcIDnlTdbVnLlbciaGQ6ipr58zEeV65hSq
+l=
5jtQynh+nojbdhHfx5b8W05dxZUbYdLzzqABQrl/ti2QX4u1jwzxTx43NrUbEWr
+a6ftgZFQ7k=
kzYTFMVJmciPYnwqnzguPRSJGXoptXaYAtX1qz8ON46zft1Nr9Ss/O
+uEAi4LYT3VIdKN0T6Yu=
ld4+pKamYCA0fkz/VmhPYeWN00349k5b9VLFfBqyRlUZX
+FF4nZEgatKn+re+VMKg9DASfqxmg=
Iz1+QMNAlpytZ+22742Xhr/WnjLdRo5f1it7
+UhxqTfWqxnTvNLyVCE2jBQqzsHRfsVIej58dd=
ZCOn45T7nwJD/r4GSLVJobO8TST
+FzGUKlfURZ5X+lrMVpkFJhMZchfsXps4976YydBCmb5QKX=
DbYbcPW4Gfd4NZkNPo
+EWo4pjIk9wge5mAntay1elQOMoTkbBGJxUdzzZ7eEND9JH0VJixic2w=
q4ZJwoGlp
+zMNvlRklj18FtH7RcHpC68cJX5DH7mY+jpWFruYnE1+SHXpSQkYse6vdtg8zurMC=

++Y5RbK1J5u3Ts/BKD8CzJGO0S/4jAOFGrQNUuk0GlAAT9NtyCNbUPob9Ssd2kfT0
+R6csdyW=
DN2aZRQNPapdLJhHuY/kWfnKIhwEr
+-----END OpenVPN tls-crypt-v2 client key----=
-
diff --git a/sample/sample-keys/tc2=2Ekey b/sample/sample-keys/tc2=2Ekey
=
new file mode 100644
index 0000000=2E=2E6f1440c
--- /dev/null
+++ b/sample/=
sample-keys/tc2=2Ekey
@@ -0,0 +1,5 @@
+-----BEGIN OpenVPN tls-crypt-v2 serv=
er key-----
+Ia2XWSUJAgWX7bpHu1qXCkmiDO2ZM/YasZs3e4uayasgjblLO7n9BRIJg5LEzO=
7R
+ugilb3ETPFPBr7zNMLW4/Td745emPvCpKyHabwsZeXih8cNQHgwyjCpEdL/a7xHH
+hHGYM=
nGPbh9jnly9YbTc8ar/ZxOnTQjTHdosJaeTKMk=3D
+-----END OpenVPN tls-crypt-v2 se=
rver key-----

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2011?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: ne=
wchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie5=
4c455006782662e3ed51e0db869ce403a66e74
Gerrit-Change-Number: 2011
Gerrit-Pa=
tchSet: 1
Gerrit-Owner: Steffan Karger <steffan@karger=2Eme>
Gerrit-Reviewe=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>

--rG4WVaC0DrA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Steffan Karger would like Arn=
e Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2011?usp=3Demail">View Change</a></p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">sample-keys: add tls-crypt-v2 keys and revoked cert<br><br>To=
 facilitate both manual tests as well as the upcoming connection test<br>su=
ite=2E<br><br>Change-Id: Ie54c455006782662e3ed51e0db869ce403a66e74<br>Signe=
d-off-by: Steffan Karger &lt;steffan@karger=2Eme&gt;<br>---<br>M sample/sam=
ple-keys/README<br>A sample/sample-keys/ca=2Ecrl<br>A sample/sample-keys/cl=
ient-revoked=2Ecrt<br>A sample/sample-keys/client-revoked=2Ekey<br>M sample=
/sample-keys/gen-sample-keys=2Esh<br>A sample/sample-keys/tc2-client=2Ekey<=
br>A sample/sample-keys/tc2=2Ekey<br>7 files changed, 178 insertions(+), 0 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/11/2011/1</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/sample/sample-=
keys/README b/sample/sample-keys/README</span><br><span>index 66dd945=2E=2E=
4095534 100644</span><br><span>--- a/sample/sample-keys/README</span><br><s=
pan>+++ b/sample/sample-keys/README</span><br><span>@@ -17,3 +17,5 @@</span=
><br><span>                        password =3D &quot;password&quot;</span>=
<br><span> client-ec=2E{crt,key} -- sample elliptic curve client key/cert</=
span><br><span> server-ec=2E{crt,key} -- sample elliptic curve server key/c=
ert</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tc2=2Ekey       =
      -- sample tls-crypt-v2 server key</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+tc2-client=2Ekey      -- sample tls-crypt-v2 client key=
, for use with tc2=2Ekey</span><br><span>diff --git a/sample/sample-keys/ca=
=2Ecrl b/sample/sample-keys/ca=2Ecrl</span><br><span>new file mode 100644</=
span><br><span>index 0000000=2E=2E6a00a41</span><br><span>--- /dev/null</sp=
an><br><span>+++ b/sample/sample-keys/ca=2Ecrl</span><br><span>@@ -0,0 +1,2=
1 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+-----BEGIN X509=
 CRL-----</span><br><span style=3D"color: hsl(120, 100%, 40%);">+MIIDcjCCAV=
oCAQEwDQYJKoZIhvcNAQELBQAwZjELMAkGA1UEBhMCS0cxCzAJBgNV</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+BAgMAk5BMRAwDgYDVQQHDAdCSVNIS0VLMRUwEwYD=
VQQKDAxPcGVuVlBOLVRFU1Qx</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ITAfBgkqhkiG9w0BCQEWEm1lQG15aG9zdC5teWRvbWFpbhcNMjYxMDE2MjE1MTE0</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+WhcNMzYxMDEzMjE1MTE0WjAUM=
BICAQgXDTI2MTAxNjIxNDYzOVqggakwgaYwgaMG</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+A1UdIwSBmzCBmIAUc7G41oqVaxLgdHzFV1WYlFuseF6haqRoMGYxCzA=
JBgNVBAYT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+AktHMQswCQ=
YDVQQIDAJOQTEQMA4GA1UEBwwHQklTSEtFSzEVMBMGA1UECgwMT3Bl</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+blZQTi1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBt=
eWhvc3QubXlkb21haW6CFG9Q</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+uNNGbnI0WbwAM918rhLrJ0YGMA0GCSqGSIb3DQEBCwUAA4ICAQBnOXQjAUEi3AAX</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+8O6Z9jEH+PK0YbHm5fAKi2db+=
u7iFc1oB8usI+pSFYP3ZYHMAtjdDPxk2GvlfXcU</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+pCYuPSN3FF3eaTl53xIF7dn3w2279vbN4b+g1Z0kr5Uba5T18HFrUA5=
/LnM+f/1x</span><br><span style=3D"color: hsl(120, 100%, 40%);">+y7162j4LjV=
Ey6lIvG7byvPF/mwmfaG9DTkcuAV0ChZnkLhT7yX0CL3xJUMDl2717</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+5aFR09/FQnvPqIbUgWH55CTeXkPsVh+ivHzQBIiq=
HJ/e9A6qZeKPJD7qaTPmRDAS</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+mufLvCJKUUs2zdSmXAM0E3P9znNolIepsr9daGNRGkRoOhM5EEHZ2cUUy1rftGd5</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+BBZrTf/A8DpCfXoL2mMBUl499=
DRgPefhJXZLmjjAp4F7t8hWZIam40f4qKk/suoO</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+MyWgK+pBnHZqijIXCoYnUYNNpem6I2YW0gWLayqaxEndA28WKtuR6je=
WPt7ErTtg</span><br><span style=3D"color: hsl(120, 100%, 40%);">+m9YvveBhxy=
+2QXWJgFBoiEKskK2wad9qXt+h08Bi70G+KOK7GDm+UkA0D5yMulnW</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+A0qll22u8ASmmIeohg65VU82d6jJy/OqikxSPEQ+=
Ya9zPmr/ASGrX2nChrPGmeUC</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+UFUTlIhUuamVLkuvOQu/meWhS/XKf3uSMXilXtcI7lmt1wTnFAFLBeZzQxgyn8kY</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+5u/LWT5Fvd0BKM7/Omah55B/Y=
BTiTA=3D=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+-----END=
 X509 CRL-----</span><br><span>diff --git a/sample/sample-keys/client-revok=
ed=2Ecrt b/sample/sample-keys/client-revoked=2Ecrt</span><br><span>new file=
 mode 100644</span><br><span>index 0000000=2E=2Ec0677ef</span><br><span>---=
 /dev/null</span><br><span>+++ b/sample/sample-keys/client-revoked=2Ecrt</s=
pan><br><span>@@ -0,0 +1,103 @@</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+Certificate:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    Data:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   Version: 3 (0x2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        Serial Number: 8 (0x8)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        Signature Algorithm: sha256WithRSAEncryption</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        Issuer: C=3DKG, ST=3DNA=
, L=3DBISHKEK, O=3DOpenVPN-TEST/emailAddress=3Dme@myhost=2Emydomain</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        Validity</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            Not Before: Oct 16=
 21:46:39 2026 GMT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           Not After : Oct 13 21:46:39 2036 GMT</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        Subject: C=3DKG, ST=3DNA, O=3DOpenVPN-T=
EST, CN=3Dclient-revoked/emailAddress=3Dme@myhost=2Emydomain</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        Subject Public Key Info:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            Public Ke=
y Algorithm: rsaEncryption</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                Public-Key: (2048 bit)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                Modulus:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                    00:83:ce:d2:5e:8f:cd:c3:=
fa:ea:b8:f0:3d:3b:59:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                    e8:e6:6a:b9:04:ce:53:5c:04:49:71:cc:98:c7:dc:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                    d7:a8:3=
8:08:dd:f4:62:c6:f4:34:1c:c0:b7:75:50:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    45:e3:7f:62:35:86:0e:a9:b1:b3:9a:52:=
b8:dd:1e:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
          e4:68:86:4f:86:f8:8d:f2:e1:42:eb:74:37:37:43:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    65:11:bf:a0:b9:3f:9=
5:f7:c8:cb:f5:82:10:49:79:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    8a:1a:59:c0:c1:7b:97:90:22:08:c2:35:6b:3d:93:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    df=
:e2:c8:2a:4d:f1:84:67:78:1d:45:5a:8c:8e:93:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                    f6:9e:0b:8d:cd:6a:37:bf:4a:49:f=
b:a6:51:e5:d0:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               00:e3:1f:d9:b9:f8:7a:42:ed:94:9f:9f:43:5e:28:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    6f:90:f1:d1:be=
:6a:9c:64:2e:e2:b9:67:ab:1a:b1:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    ee:39:e6:d4:88:86:f6:90:79:af:6b:28:14:3b:2=
7:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   58:64:80:e1:0a:65:ea:a8:d1:f6:f4:2c:95:26:90:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    46:cd:47:66:f1:24:80:3d:43=
:1d:c3:ba:77:a4:33:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    5f:a6:7f:d9:bc:eb:bc:a3:fb:8f:f2:e3:4a:18:18:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    4d:88:b0:=
ae:89:d2:5c:e3:86:b3:6b:5a:f9:21:3c:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    74:4e:4f:5b:1e:3f:98:fd:bc:27:88:ca:07=
:47:c7:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        01:cd</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          Exponent: 65537 (0x10001)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        X509v3 extensions:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            X509v3 Basic Constraints: </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                CA:FALSE</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            X509v3 Subject K=
ey Identifier: </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            EA:78:19:C4:E5:92:EF:31:82:FF:32:15:A5:3E:9D:93:27:9F:DA:8A</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            X509v3 Auth=
ority Key Identifier: </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                keyid:73:B1:B8:D6:8A:95:6B:12:E0:74:7C:C5:57:55:98:94:5B=
:AC:78:5E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      DirName:/C=3DKG/ST=3DNA/L=3DBISHKEK/O=3DOpenVPN-TEST/emailAddress=3Dm=
e@myhost=2Emydomain</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                serial:6F:50:B8:D3:46:6E:72:34:59:BC:00:33:DD:7C:AE:12:EB:2=
7:46:06</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Signatur=
e Algorithm: sha256WithRSAEncryption</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    Signature Value:</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        7f:67:77:df:20:da:f9:25:f8:f3:5b:57:40:4d:bb:5f:9=
9:0a:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        6f:ad:=
89:11:12:15:3d:22:0f:f8:bd:06:d1:ea:95:09:a9:9b:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        88:60:81:60:eb:89:cc:06:b0:08:5e:b3:7c=
:e4:5c:d8:bf:f5:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     f9:11:0d:70:90:c4:56:f5:d2:b6:16:bf:98:ef:f8:0b:5e:31:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        9f:e3:4f:c4:6d:4e:0a:3d:6b:=
9c:a1:25:84:2d:b6:85:c7:01:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        d0:65:85:a8:07:63:37:d5:64:d4:b4:7f:94:14:ce:10:d1:b7:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        ff:9c:84:ad:0a:b=
7:6b:2a:da:ff:cf:3d:ac:ff:84:6d:83:49:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        7f:01:47:40:7a:c6:54:9c:93:60:b8:ae:d3:b7:24:a1:=
0e:8e:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        a4:20=
:70:e7:76:f6:1f:2c:81:81:ca:04:4b:b0:7c:58:ec:89:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        a8:ef:24:d9:67:27:2b:f3:d3:c6:58:cf:a=
5:9f:55:ef:bb:a7:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      00:b0:5f:a0:ee:81:0f:e2:f4:65:0b:b2:fc:84:fd:26:c4:56:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        d6:f1:e9:f8:6b:d7:b4:af:05=
:55:87:26:50:2f:50:7b:a7:cc:</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        e4:e3:fe:60:53:75:77:7e:d4:c0:8b:74:e1:aa:9f:71:1b:78:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        93:ad:a3:3e:0e:=
c0:e1:9f:52:d6:83:9f:93:84:4a:fe:92:a6:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        f5:6d:47:ad:5b:c7:8a:f5:48:24:14:fd:60:2f:68:22=
:ce:d6:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        de:b=
e:13:56:62:36:ff:31:a0:58:05:e4:e9:31:b3:f2:b3:5d:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        37:b2:a4:6f:3f:7f:99:6a:b6:b9:64:a0:=
29:d7:80:b6:63:27:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       0a:4b:48:d1:7b:d1:56:d4:b1:e7:5c:74:ef:2d:6a:99:f0:23:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        4a:3f:4e:b3:a3:5e:e8:3a:d=
c:7e:be:81:4c:1a:6f:50:de:65:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        1a:0c:fe:25:d3:7c:45:68:fb:49:69:de:15:d2:ca:76:15:bf:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        ba:ad:23:d1:c7=
:04:39:2f:e6:c7:0a:f8:cd:05:86:07:4a:24:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        64:c3:89:cf:12:d2:e7:26:f2:5a:0f:5e:85:33:77:c=
c:7e:58:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dc:=
5e:ad:39:20:c0:22:ed:8f:2e:21:ab:2d:e4:e5:21:7c:ad:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        98:a4:5b:10:40:c8:bd:24:4d:d7:be:=
45:c0:cf:58:21:91:28:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        1e:25:10:35:67:92:57:0e:bf:13:4e:59:d2:0d:3b:45:8a:17:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        6e:93:85:71:f6:2c:22:1=
b:01:cf:1d:13:0e:1f:bb:d2:28:37:</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        10:ea:af:c3:58:2f:2c:27:0b:f7:12:0d:94:36:60:89:67:79:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        3f:95:d8:b5=
:33:e9:1a:53:0d:86:7f:6f:4b:d7:e2:40:9c:19:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        ea:3f:55:49:b3:e4:04:fb</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+-----BEGIN CERTIFICATE-----</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+MIIFIjCCAwqgAwIBAgIBCDANBgkqhki=
G9w0BAQsFADBmMQswCQYDVQQGEwJLRzEL</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+MAkGA1UECAwCTkExEDAOBgNVBAcMB0JJU0hLRUsxFTATBgNVBAoMDE9wZW5WU=
E4t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+VEVTVDEhMB8GCSqG=
SIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTI2MTAx</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+NjIxNDYzOVoXDTM2MTAxMzIxNDYzOVowbTELMAkGA1UEBh=
MCS0cxCzAJBgNVBAgM</span><br><span style=3D"color: hsl(120, 100%, 40%);">+A=
k5BMRUwEwYDVQQKDAxPcGVuVlBOLVRFU1QxFzAVBgNVBAMMDmNsaWVudC1yZXZv</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+a2VkMSEwHwYJKoZIhvcNAQkBFhJtZUB=
teWhvc3QubXlkb21haW4wggEiMA0GCSqG</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+SIb3DQEBAQUAA4IBDwAwggEKAoIBAQCDztJej83D+uq48D07WejmarkEzlNcB=
Elx</span><br><span style=3D"color: hsl(120, 100%, 40%);">+zJjH3NeoOAjd9GLG=
9DQcwLd1UEXjf2I1hg6psbOaUrjdHuRohk+G+I3y4ULrdDc3</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+Q2URv6C5P5X3yMv1ghBJeYoaWcDBe5eQIgjCNWs9k9/iyC=
pN8YRneB1FWoyOk/ae</span><br><span style=3D"color: hsl(120, 100%, 40%);">+C=
43Naje/Skn7plHl0ADjH9m5+HpC7ZSfn0NeKG+Q8dG+apxkLuK5Z6sase455tSI</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+hvaQea9rKBQ7J1hkgOEKZeqo0fb0LJU=
mkEbNR2bxJIA9Qx3DunekM1+mf9m867yj</span><br><span style=3D"color: hsl(120, =
100%, 40%);">++4/y40oYGE2IsK6J0lzjhrNrWvkhPHROT1seP5j9vCeIygdHxwHNAgMBAAGjg=
dMw</span><br><span style=3D"color: hsl(120, 100%, 40%);">+gdAwCQYDVR0TBAIw=
ADAdBgNVHQ4EFgQU6ngZxOWS7zGC/zIVpT6dkyef2oowgaMG</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+A1UdIwSBmzCBmIAUc7G41oqVaxLgdHzFV1WYlFuseF6haq=
RoMGYxCzAJBgNVBAYT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+A=
ktHMQswCQYDVQQIDAJOQTEQMA4GA1UEBwwHQklTSEtFSzEVMBMGA1UECgwMT3Bl</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+blZQTi1URVNUMSEwHwYJKoZIhvcNAQk=
BFhJtZUBteWhvc3QubXlkb21haW6CFG9Q</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+uNNGbnI0WbwAM918rhLrJ0YGMA0GCSqGSIb3DQEBCwUAA4ICAQB/Z3ffINr5J=
fjz</span><br><span style=3D"color: hsl(120, 100%, 40%);">+W1dATbtfmQpvrYkR=
EhU9Ig/4vQbR6pUJqZuIYIFg64nMBrAIXrN85FzYv/X5EQ1w</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+kMRW9dK2Fr+Y7/gLXjGf40/EbU4KPWucoSWELbaFxwHQZY=
WoB2M31WTUtH+UFM4Q</span><br><span style=3D"color: hsl(120, 100%, 40%);">+0=
bf/nIStCrdrKtr/zz2s/4Rtg0l/AUdAesZUnJNguK7TtyShDo6kIHDndvYfLIGB</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ygRLsHxY7Imo7yTZZycr89PGWM+ln1X=
vu6cAsF+g7oEP4vRlC7L8hP0mxFbW8en4</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+a9e0rwVVhyZQL1B7p8zk4/5gU3V3ftTAi3Thqp9xG3iTraM+DsDhn1LWg5+Th=
Er+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+kqb1bUetW8eK9Ugk=
FP1gL2giztbevhNWYjb/MaBYBeTpMbPys103sqRvP3+Zara5</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ZKAp14C2YycKS0jRe9FW1LHnXHTvLWqZ8CNKP06zo17oOt=
x+voFMGm9Q3mUaDP4l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+0=
3xFaPtJad4V0sp2Fb+6rSPRxwQ5L+bHCvjNBYYHSiRkw4nPEtLnJvJaD16FM3fM</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+fljcXq05IMAi7Y8uIast5OUhfK2YpFs=
QQMi9JE3XvkXAz1ghkSgeJRA1Z5JXDr8T</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+TlnSDTtFihduk4Vx9iwiGwHPHRMOH7vSKDcQ6q/DWC8sJwv3Eg2UNmCJZ3k/l=
di1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+M+kaUw2Gf29L1+JA=
nBnqP1VJs+QE+w=3D=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+-----END CERTIFICATE-----</span><br><span>diff --git a/sample/sample-keys/=
client-revoked=2Ekey b/sample/sample-keys/client-revoked=2Ekey</span><br><s=
pan>new file mode 100644</span><br><span>index 0000000=2E=2E83f9086</span><=
br><span>--- /dev/null</span><br><span>+++ b/sample/sample-keys/client-revo=
ked=2Ekey</span><br><span>@@ -0,0 +1,28 @@</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+-----BEGIN PRIVATE KEY-----</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEA=
AoIBAQCDztJej83D+uq4</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+8D07WejmarkEzlNcBElxzJjH3NeoOAjd9GLG9DQcwLd1UEXjf2I1hg6psbOaUrjd</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+HuRohk+G+I3y4ULrdDc3Q2URv6C5P=
5X3yMv1ghBJeYoaWcDBe5eQIgjCNWs9k9/i</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+yCpN8YRneB1FWoyOk/aeC43Naje/Skn7plHl0ADjH9m5+HpC7ZSfn0NeKG+=
Q8dG+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+apxkLuK5Z6sase=
455tSIhvaQea9rKBQ7J1hkgOEKZeqo0fb0LJUmkEbNR2bxJIA9</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+Qx3DunekM1+mf9m867yj+4/y40oYGE2IsK6J0lzjhrNr=
WvkhPHROT1seP5j9vCeI</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ygdHxwHNAgMBAAECggEABMlBDtF6d4wYM1x34LyYTiugacoDMWNvdkwnXRSKGS/l</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+tIeQAajy7ntZ/g7K5uKkgoyKYkOTY=
b5wu4jIYvpDj4Ndhi0DVNDsw1s1Y5JZh/iE</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+3dFDBLhzFnPtHZ1WOEBgZcmylzjA2uTQe6foj1l+hRJRv8e0tGWvjhgdz1B=
000OW</span><br><span style=3D"color: hsl(120, 100%, 40%);">+OmJC9M6neHghuh=
UAShfqHbDkXOd9w/HnQCu9TyWqV/D7h63dP3PfSgM1q5o5CrHZ</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+2VVynpq3W4KPkPC4IsdKrmvE+Y6bwhFgU48rUSBmzpNG=
GhRcI3JkpButzRE7ZD2O</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+uljFZbkt5LeCH0nIb09YPVTFjRpaQ95mktU70IeQEQKBgQC5GkohgCnIj+1rYKXq</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+7O1dD5RrFO5NGNdvwsQpcFF6kdcWK=
quGO9Ts392VOMsYDctxZX3x2LOaDhB8KkYl</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+5lqh+uIULZxPYvb+SMIBnkcV1z7mnCu7dOltgJKdMkeHGwpCXUne8NtoC4w=
Wd7Ao</span><br><span style=3D"color: hsl(120, 100%, 40%);">+iEoK1pMWp9VLZM=
B5pZsg+eYvEQKBgQC2St1gSYG48ZbUoQzP0Qs/bl7ojTrQzNp9</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+TIUvDvnxI5OLDN3HIn9xgDa9eSYr6CTvTNJ42uL8CSu2=
I4HwQDMYBNMUfqJRVKoy</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+mVzKQBsLNKzBZlzO8GnJQw5hZJoZRBz5FJiQjz9y7pSD9nKObeMarXDRE2BkwYw2</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+KLJrll6e/QKBgFLhy6m+enccwyFec=
EyF9C7ESB++iompAuY/HpizezhXzyhUyOLd</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+LZU3FD+5426M1riayk8dSiZD/+uo/ioAQDrhXJPObHw7gv8PUxdoaMoFzFt=
0ODzC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+t7bZaEzM86wyVm=
Cq5uXVkVjAOuTgiNdNV2IM/GWblu0gWvLdTV3xp7kRAoGBAK+g</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+CRBPQW+RMiPA1bsSR6fhCgc6qcOo2YeGRXpFD4DHKcr5=
pmHIVshfIl4Bbkk26v6y</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+IMTW/YCcxURBiVqSP6eQXlyMdI2u6Bq/rqocgPGW2imqGRg2f3Sr6hri9aQJ/2/p</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+6+K6YAK24NcShOO78uUs3FhSNrhb0=
F4Nb3g/8wFxAoGAKATiB4J12yBiDgMI8dLH</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+uCOA7BuB9G/sOWFCWlY1gQaca6fgKvkbKiv6SOH9g7D72s9RJXXXrnM/Cy6=
hG4+t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+7YMAhEPG8dxZCw=
kEIGxk761aq7a6iiHnvYeXHWrSbucXGQfiX/x4NB8lbXtaPBxH</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+zrsv83SJbTUdHnaq0YJOIoc=3D</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+-----END PRIVATE KEY-----</span><br><=
span>diff --git a/sample/sample-keys/gen-sample-keys=2Esh b/sample/sample-k=
eys/gen-sample-keys=2Esh</span><br><span>index fa5f697=2E=2E16010b2 100755<=
/span><br><span>--- a/sample/sample-keys/gen-sample-keys=2Esh</span><br><sp=
an>+++ b/sample/sample-keys/gen-sample-keys=2Esh</span><br><span>@@ -18,6 +=
18,11 @@</span><br><span> top_builddir=3D&quot;${top_builddir:-$(dirname ${=
0})/=2E=2E/=2E=2E}&quot;</span><br><span> ${top_builddir}/src/openvpn/openv=
pn --genkey tls-auth ta=2Ekey</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+# Generate tls-crypt-v2 server key, and a clien=
t key wrapped with that key</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+${top_builddir}/src/openvpn/openvpn --genkey tls-crypt-v2-server tc=
2=2Ekey</span><br><span style=3D"color: hsl(120, 100%, 40%);">+${top_buildd=
ir}/src/openvpn/openvpn --tls-crypt-v2 tc2=2Ekey \</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    --genkey tls-crypt-v2-client tc2-client=
=2Ekey</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> # Create required directories and files</span><br><span> mkdir -p samp=
le-ca</span><br><span> rm -f sample-ca/index=2Etxt</span><br><span>diff --g=
it a/sample/sample-keys/tc2-client=2Ekey b/sample/sample-keys/tc2-client=2E=
key</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=
=2E8c9a505</span><br><span>--- /dev/null</span><br><span>+++ b/sample/sampl=
e-keys/tc2-client=2Ekey</span><br><span>@@ -0,0 +1,14 @@</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+-----BEGIN OpenVPN tls-crypt-v2 client=
 key-----</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Lm43KRMlWH=
XMynOOGVmEQs51QjN7LhcqlhZ9XRzincFN+0iSpp1mfOUnB/oKXbKq</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+PyH1sToo0zjJKQ1Bkb/cprcORcQSW1vcIDnlTdbV=
nLlbciaGQ6ipr58zEeV65hSq</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+l5jtQynh+nojbdhHfx5b8W05dxZUbYdLzzqABQrl/ti2QX4u1jwzxTx43NrUbEWr</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+a6ftgZFQ7kkzYTFMVJmciPYnw=
qnzguPRSJGXoptXaYAtX1qz8ON46zft1Nr9Ss/O</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+uEAi4LYT3VIdKN0T6Yuld4+pKamYCA0fkz/VmhPYeWN00349k5b9VLF=
fBqyRlUZX</span><br><span style=3D"color: hsl(120, 100%, 40%);">+FF4nZEgatK=
n+re+VMKg9DASfqxmgIz1+QMNAlpytZ+22742Xhr/WnjLdRo5f1it7</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+UhxqTfWqxnTvNLyVCE2jBQqzsHRfsVIej58ddZCO=
n45T7nwJD/r4GSLVJobO8TST</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+FzGUKlfURZ5X+lrMVpkFJhMZchfsXps4976YydBCmb5QKXDbYbcPW4Gfd4NZkNPo</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+EWo4pjIk9wge5mAntay1elQOM=
oTkbBGJxUdzzZ7eEND9JH0VJixic2wq4ZJwoGlp</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+zMNvlRklj18FtH7RcHpC68cJX5DH7mY+jpWFruYnE1+SHXpSQkYse6v=
dtg8zurMC</span><br><span style=3D"color: hsl(120, 100%, 40%);">++Y5RbK1J5u=
3Ts/BKD8CzJGO0S/4jAOFGrQNUuk0GlAAT9NtyCNbUPob9Ssd2kfT0</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+R6csdyWDN2aZRQNPapdLJhHuY/kWfnKIhwEr</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+-----END OpenVPN tls-cr=
ypt-v2 client key-----</span><br><span>diff --git a/sample/sample-keys/tc2=
=2Ekey b/sample/sample-keys/tc2=2Ekey</span><br><span>new file mode 100644<=
/span><br><span>index 0000000=2E=2E6f1440c</span><br><span>--- /dev/null</s=
pan><br><span>+++ b/sample/sample-keys/tc2=2Ekey</span><br><span>@@ -0,0 +1=
,5 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+-----BEGIN Ope=
nVPN tls-crypt-v2 server key-----</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+Ia2XWSUJAgWX7bpHu1qXCkmiDO2ZM/YasZs3e4uayasgjblLO7n9BRIJg5LEz=
O7R</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ugilb3ETPFPBr7zN=
MLW4/Td745emPvCpKyHabwsZeXih8cNQHgwyjCpEdL/a7xHH</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+hHGYMnGPbh9jnly9YbTc8ar/ZxOnTQjTHdosJaeTKMk=3D=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+-----END OpenVPN tl=
s-crypt-v2 server key-----</span><br></pre><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2011?usp=3Demail">change 2011</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2011?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie54=
c455006782662e3ed51e0db869ce403a66e74 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 2011 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Steffan Karger &lt;=
steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--rG4WVaC0DrA=--


--===============0146008197747671634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0146008197747671634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0146008197747671634==--

