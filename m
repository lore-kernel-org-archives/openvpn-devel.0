Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA5D606D809
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fktMwgPp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZCckSchT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=T+kN25K2;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cUtZuZc/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Zf2S9Zw35CkAqske0I8DBtNFCJuFgJC/tidDIg+tAOQ=; b=fktMwgPptfS+g/TrYfVqRG14ph
	UR0bUkok5S8qyN/7+IFYB+/35qkzmuPRlv93Rjpejq/rBILUo8FkOeG/shMhZ2Pl473uRtB//VZmv
	70FG7nVnpLmVp6X4X0fMBnDRHFz75DgWMIBfUGConbtftsFBwKJwXKW7BAgM3NQaVcbQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOGqW-000000006OB-1LHF;
	Tue, 03 Nov 2026 15:54:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOGqV-000000006O5-3gQM
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:54:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YSVkT9hNPijqk8WaosVh/cIcEC6I5qbpUrXGBoljxcc=; b=ZCckSchTpUvMUxC3Uc6RCjPpdt
 CO/5PMeB5F4Hngfc45GhlQjDYcuZORi+subSNNbr0VgV7gJyRVkG1F0qOFE5/w5pixL5ADBj4FapX
 qnrsoGwPcpLPgaf6s87xWVTEgITKNSctxjgUvyrLYL1LfGgSFQ4df3Cf6rPjy7hFCPoI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YSVkT9hNPijqk8WaosVh/cIcEC6I5qbpUrXGBoljxcc=; b=T+kN25K23b4vmX2CdybMsdoaKV
 5RydTgINV3RFBj9gtilYXr3SGMdgapCz32Rfscnx8+xw/ziC/MdnLOJzjluM/C+zSZsYTTZk80hAF
 jDJWYSu3bZMD2AchbPULtBnnB9nHvtvhH7no+TsoGIidMc3RjdHibHdddtwGi8rvrTG0=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOGqS-000000006yy-3GVU for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:54:47 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so28178005e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 07:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793721278; x=1794326078; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YSVkT9hNPijqk8WaosVh/cIcEC6I5qbpUrXGBoljxcc=;
 b=cUtZuZc/WPxWJZZbVj8HFSsY6Mu2DbKEQq6yIyeTP78jXxdtfvPbscfRe1q2NA6pTw
 A85TNZrr41gjQEUiwcDBNQPncVW8J8BugIfGBQ7KIeBMOZNRS44ZiDkVc4/0Aq3P48q4
 c1CnQA+xBuUDaYOk6quk6WF0FjgW5KqckKrDYtzEBMaKaHDCm7Qs9ZOPO9CR4p5HMtg9
 IQd3txERUzO403LGtZBKEpXREUSL2YA1FeCHKmfc3lJhHnmGJ7MaqsrKa2M5RC0K6dyU
 DniZlK63ksz6wFJxnE9WLwk2yk3ELmzhoTlKTtFLPSfreu/KNfOIqJaihu/FHcXJJ3Yv
 tdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793721278; x=1794326078;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YSVkT9hNPijqk8WaosVh/cIcEC6I5qbpUrXGBoljxcc=;
 b=An+PatabhGqI74Hu8QNbww++kDTK04WQ/qawJ2oB3tGTxXT0fmf5ndiR7NSs9pH7fV
 09AQPDSMiRn0HFN2nCO+kVn8ey1QM49n3cuSmmHrjIJEhgm60EOVa0sp2tWorZcfOpEC
 r7b+UQZpipJbjrotxBATHxQcUb1rB1pMj/C6V+Do3aN6RxdY0ukrtZ7ONqWrltxXNTIk
 CE7/g+ZeDFZa0+MKs2sAAvZYlPZGS/bnPRcTUbZdtcPz8m3JE/bu+SQ93egk8hEOeipz
 aoIFY1zp85S2fSEH+Twyulh/MB7rmJv8wK6OLv5AB59mh6KJ1H0lSC2AbmEGaeq/5rXA
 cY2g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzidOVB2jD7/3z4zW5LrjXvtOo/0uWeKIogLb3iOUg+UV81ygSbx94IXbdnDeGBHap7B0m7YjClFK9fD3aC@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/p6TVVjrYKP/aa4eibH6ZN4LaLujVrwJUs4ncsYGUu+N2twBJc
 HHW05sFfdbwmDLsp3KTc6254TWN1wFWfi0PjHH35adX4PAaYvE2K9eDOUFSn64Q7TKlKrHzdT0U
 Ehu/ILo8QU2A9eGPdJ1RBwoORRjD2IwaZz/BqznPW/jzuf4CQeC1nNQY1FGPU31an/mfS
X-Gm-Gg: AYBFou2bB5gxKnXq6v5LW9rtkZiZJDFgeALdSz0dbSfETuax9HU/+VD5tivt97ysUS4
 iklOVeZOlAwYv23QgIhgpLH2sUpak3b5L3REnb6b25lKsU1uOw9fJMFVma3Gq2sslIBlALZN9lO
 J9UNptbAUPrpg41f8BnjMHZm8uY/xYT8rN2CK1M/edk+d3ajgmoqlqA38wnT9Q5TgDbQcai2Erm
 /9JY/dMGhT1qFjIRBfYPGmtXzhzH69RzNr3sG6VJckYaWy//TxFgZ2VT2DLOU6elhR7aCKChO/E
 /ffJhY4R9XLhsMseelTpZsbQirMIgiMSgefqCXI0os0h7RNpn0avpuaK/QUT7H/hiQMlz8h9nFa
 FVX6UCsBxR2n71P91sXmdClv0/Zqpy5VxodL9MZJK1V0qL6XFe1f3Y2tEw28oMe3W7FP28KxYAv
 hgnXcfcKicmD60Lf6c3KIoI1qGct6r58IMQr2yo+wUXp69ZQREL10dEaSMwVHSx0q7WpOWf9Gnq
 e1zKka+hBwSFy3vr4NQbnJtLjeHhNpUdtPPh8sdGr07tGnwkLNcCWJ3UI7FKhfNzbPLCRQIHBoq
 H9GWYU84rkzSFsflUMKI1y8p53QKJZHJjMBJZ9rKf1+vAmUMB7PuS3sss/JBWpgwFX55cCdddlC
 j7ZJMoFPN920nFJzQyms/MGrctouk81zXyXhUeNNfdFBUXPL8UEQ+8TMzss1+l1YjjoSROxk5S0
 gJgSJAe7orl0UkKw==
X-Received: by 2002:a05:600c:4e02:b0:4a3:59c9:a758 with SMTP id
 5b1f17b1804b1-4ac19705e02mr292189005e9.32.1793721277987; 
 Tue, 03 Nov 2026 07:54:37 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09ad35fdsm241010995e9.2.2026.11.03.07.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 07:54:37 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 15:54:37 +0000
To: Steffan Karger <steffan@karger.me>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie54c455006782662e3ed51e0db869ce403a66e74
X-Gerrit-Change-Number: 2011
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2011?usp=email>
X-Gerrit-Commit: 8f253fd8fa95defd937343d4dc2c87fc9b5f687c
In-Reply-To: <gerrit.1792315181000.Ie54c455006782662e3ed51e0db869ce403a66e74@gerrit.openvpn.net>
References: <gerrit.1792315181000.Ie54c455006782662e3ed51e0db869ce403a66e74@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMzE1MTgxMDAwLkllNTRjNDU1MDA2NzgyNjYyZTNlZDUxZTBkYjg2OWNlNDAzYTY2ZTc0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <81bc1f52b19163e7bbb16ebf0f7f9698dd5467fc-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOGqS-000000006yy-3GVU
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3118790243141515618=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3118790243141515618==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XBoCBbCnQY4="; charset=UTF-8

--XBoCBbCnQY4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2011?usp=3Demail )

Change subject: sample-keys: add tls-crypt-=
v2 keys and revoked cert
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

sample-keys: add tls-crypt-v2 keys and revoked cert

To facil=
itate both manual tests as well as the upcoming connection test
suite=2E

C=
hange-Id: Ie54c455006782662e3ed51e0db869ce403a66e74
Signed-off-by: Steffan =
Karger <steffan@karger=2Eme>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2011
Message-Id: <20261102131424=2E2166=
1-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-=
devel@lists=2Esourceforge=2Enet/msg40431=2Ehtml
Signed-off-by: Gert Doering=
 <gert@greenie=2Emuc=2Ede>
---
M sample/sample-keys/README
A sample/sample-=
keys/ca=2Ecrl
A sample/sample-keys/client-revoked=2Ecrt
A sample/sample-key=
s/client-revoked=2Ekey
M sample/sample-keys/gen-sample-keys=2Esh
A sample/s=
ample-keys/tc2-client=2Ekey
A sample/sample-keys/tc2=2Ekey
7 files changed,=
 178 insertions(+), 0 deletions(-)




diff --git a/sample/sample-keys/READ=
ME b/sample/sample-keys/README
index 66dd945=2E=2E4095534 100644
--- a/samp=
le/sample-keys/README
+++ b/sample/sample-keys/README
@@ -17,3 +17,5 @@
   =
                     password =3D "password"
 client-ec=2E{crt,key} -- samp=
le elliptic curve client key/cert
 server-ec=2E{crt,key} -- sample elliptic=
 curve server key/cert
+tc2=2Ekey             -- sample tls-crypt-v2 server=
 key
+tc2-client=2Ekey      -- sample tls-crypt-v2 client key, for use with=
 tc2=2Ekey
diff --git a/sample/sample-keys/ca=2Ecrl b/sample/sample-keys/ca=
=2Ecrl
new file mode 100644
index 0000000=2E=2E6a00a41
--- /dev/null
+++ b/=
sample/sample-keys/ca=2Ecrl
@@ -0,0 +1,21 @@
+-----BEGIN X509 CRL-----
+MII=
DcjCCAVoCAQEwDQYJKoZIhvcNAQELBQAwZjELMAkGA1UEBhMCS0cxCzAJBgNV
+BAgMAk5BMRAw=
DgYDVQQHDAdCSVNIS0VLMRUwEwYDVQQKDAxPcGVuVlBOLVRFU1Qx
+ITAfBgkqhkiG9w0BCQEWE=
m1lQG15aG9zdC5teWRvbWFpbhcNMjYxMDE2MjE1MTE0
+WhcNMzYxMDEzMjE1MTE0WjAUMBICAQ=
gXDTI2MTAxNjIxNDYzOVqggakwgaYwgaMG
+A1UdIwSBmzCBmIAUc7G41oqVaxLgdHzFV1WYlFu=
seF6haqRoMGYxCzAJBgNVBAYT
+AktHMQswCQYDVQQIDAJOQTEQMA4GA1UEBwwHQklTSEtFSzEV=
MBMGA1UECgwMT3Bl
+blZQTi1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21ha=
W6CFG9Q
+uNNGbnI0WbwAM918rhLrJ0YGMA0GCSqGSIb3DQEBCwUAA4ICAQBnOXQjAUEi3AAX
+=
8O6Z9jEH+PK0YbHm5fAKi2db+u7iFc1oB8usI+pSFYP3ZYHMAtjdDPxk2GvlfXcU
+pCYuPSN3F=
F3eaTl53xIF7dn3w2279vbN4b+g1Z0kr5Uba5T18HFrUA5/LnM+f/1x
+y7162j4LjVEy6lIvG7=
byvPF/mwmfaG9DTkcuAV0ChZnkLhT7yX0CL3xJUMDl2717
+5aFR09/FQnvPqIbUgWH55CTeXkP=
sVh+ivHzQBIiqHJ/e9A6qZeKPJD7qaTPmRDAS
+mufLvCJKUUs2zdSmXAM0E3P9znNolIepsr9d=
aGNRGkRoOhM5EEHZ2cUUy1rftGd5
+BBZrTf/A8DpCfXoL2mMBUl499DRgPefhJXZLmjjAp4F7t=
8hWZIam40f4qKk/suoO
+MyWgK+pBnHZqijIXCoYnUYNNpem6I2YW0gWLayqaxEndA28WKtuR6j=
eWPt7ErTtg
+m9YvveBhxy+2QXWJgFBoiEKskK2wad9qXt+h08Bi70G+KOK7GDm+UkA0D5yMuln=
W
+A0qll22u8ASmmIeohg65VU82d6jJy/OqikxSPEQ+Ya9zPmr/ASGrX2nChrPGmeUC
+UFUTlI=
hUuamVLkuvOQu/meWhS/XKf3uSMXilXtcI7lmt1wTnFAFLBeZzQxgyn8kY
+5u/LWT5Fvd0BKM7=
/Omah55B/YBTiTA=3D=3D
+-----END X509 CRL-----
diff --git a/sample/sample-ke=
ys/client-revoked=2Ecrt b/sample/sample-keys/client-revoked=2Ecrt
new file =
mode 100644
index 0000000=2E=2E45e78a0
--- /dev/null
+++ b/sample/sample-ke=
ys/client-revoked=2Ecrt
@@ -0,0 +1,103 @@
+Certificate:
+    Data:
+       =
 Version: 3 (0x2)
+        Serial Number: 8 (0x8)
+        Signature Algori=
thm: sha256WithRSAEncryption
+        Issuer: C=3DKG, ST=3DNA, L=3DBISHKEK,=
 O=3DOpenVPN-TEST/emailAddress=3Dme@myhost=2Emydomain
+        Validity
+  =
          Not Before: Oct 16 21:46:39 2026 GMT
+            Not After : Oct=
 13 21:46:39 2036 GMT
+        Subject: C=3DKG, ST=3DNA, O=3DOpenVPN-TEST, =
CN=3Dclient-revoked/emailAddress=3Dme@myhost=2Emydomain
+        Subject Pu=
blic Key Info:
+            Public Key Algorithm: rsaEncryption
+          =
      Public-Key: (2048 bit)
+                Modulus:
+                   =
 00:83:ce:d2:5e:8f:cd:c3:fa:ea:b8:f0:3d:3b:59:
+                    e8:e6:6=
a:b9:04:ce:53:5c:04:49:71:cc:98:c7:dc:
+                    d7:a8:38:08:dd:=
f4:62:c6:f4:34:1c:c0:b7:75:50:
+                    45:e3:7f:62:35:86:0e:a9=
:b1:b3:9a:52:b8:dd:1e:
+                    e4:68:86:4f:86:f8:8d:f2:e1:42:e=
b:74:37:37:43:
+                    65:11:bf:a0:b9:3f:95:f7:c8:cb:f5:82:10:=
49:79:
+                    8a:1a:59:c0:c1:7b:97:90:22:08:c2:35:6b:3d:93:
+=
                    df:e2:c8:2a:4d:f1:84:67:78:1d:45:5a:8c:8e:93:
+        =
            f6:9e:0b:8d:cd:6a:37:bf:4a:49:fb:a6:51:e5:d0:
+                =
    00:e3:1f:d9:b9:f8:7a:42:ed:94:9f:9f:43:5e:28:
+                    6f:9=
0:f1:d1:be:6a:9c:64:2e:e2:b9:67:ab:1a:b1:
+                    ee:39:e6:d4:=
88:86:f6:90:79:af:6b:28:14:3b:27:
+                    58:64:80:e1:0a:65:ea=
:a8:d1:f6:f4:2c:95:26:90:
+                    46:cd:47:66:f1:24:80:3d:43:1=
d:c3:ba:77:a4:33:
+                    5f:a6:7f:d9:bc:eb:bc:a3:fb:8f:f2:e3:=
4a:18:18:
+                    4d:88:b0:ae:89:d2:5c:e3:86:b3:6b:5a:f9:21:3c=
:
+                    74:4e:4f:5b:1e:3f:98:fd:bc:27:88:ca:07:47:c7:
+     =
               01:cd
+                Exponent: 65537 (0x10001)
+        X5=
09v3 extensions:
+            X509v3 Basic Constraints:
+                CA=
:FALSE
+            X509v3 Subject Key Identifier:
+                EA:78:1=
9:C4:E5:92:EF:31:82:FF:32:15:A5:3E:9D:93:27:9F:DA:8A
+            X509v3 Au=
thority Key Identifier:
+                keyid:73:B1:B8:D6:8A:95:6B:12:E0:7=
4:7C:C5:57:55:98:94:5B:AC:78:5E
+                DirName:/C=3DKG/ST=3DNA/L=
=3DBISHKEK/O=3DOpenVPN-TEST/emailAddress=3Dme@myhost=2Emydomain
+          =
      serial:6F:50:B8:D3:46:6E:72:34:59:BC:00:33:DD:7C:AE:12:EB:27:46:06
+ =
   Signature Algorithm: sha256WithRSAEncryption
+    Signature Value:
+    =
    7f:67:77:df:20:da:f9:25:f8:f3:5b:57:40:4d:bb:5f:99:0a:
+        6f:ad:8=
9:11:12:15:3d:22:0f:f8:bd:06:d1:ea:95:09:a9:9b:
+        88:60:81:60:eb:89:=
cc:06:b0:08:5e:b3:7c:e4:5c:d8:bf:f5:
+        f9:11:0d:70:90:c4:56:f5:d2:b6=
:16:bf:98:ef:f8:0b:5e:31:
+        9f:e3:4f:c4:6d:4e:0a:3d:6b:9c:a1:25:84:2=
d:b6:85:c7:01:
+        d0:65:85:a8:07:63:37:d5:64:d4:b4:7f:94:14:ce:10:d1:=
b7:
+        ff:9c:84:ad:0a:b7:6b:2a:da:ff:cf:3d:ac:ff:84:6d:83:49:
+      =
  7f:01:47:40:7a:c6:54:9c:93:60:b8:ae:d3:b7:24:a1:0e:8e:
+        a4:20:70:=
e7:76:f6:1f:2c:81:81:ca:04:4b:b0:7c:58:ec:89:
+        a8:ef:24:d9:67:27:2b=
:f3:d3:c6:58:cf:a5:9f:55:ef:bb:a7:
+        00:b0:5f:a0:ee:81:0f:e2:f4:65:0=
b:b2:fc:84:fd:26:c4:56:
+        d6:f1:e9:f8:6b:d7:b4:af:05:55:87:26:50:2f:=
50:7b:a7:cc:
+        e4:e3:fe:60:53:75:77:7e:d4:c0:8b:74:e1:aa:9f:71:1b:78=
:
+        93:ad:a3:3e:0e:c0:e1:9f:52:d6:83:9f:93:84:4a:fe:92:a6:
+        =
f5:6d:47:ad:5b:c7:8a:f5:48:24:14:fd:60:2f:68:22:ce:d6:
+        de:be:13:56=
:62:36:ff:31:a0:58:05:e4:e9:31:b3:f2:b3:5d:
+        37:b2:a4:6f:3f:7f:99:6=
a:b6:b9:64:a0:29:d7:80:b6:63:27:
+        0a:4b:48:d1:7b:d1:56:d4:b1:e7:5c:=
74:ef:2d:6a:99:f0:23:
+        4a:3f:4e:b3:a3:5e:e8:3a:dc:7e:be:81:4c:1a:6f=
:50:de:65:
+        1a:0c:fe:25:d3:7c:45:68:fb:49:69:de:15:d2:ca:76:15:bf:
=
+        ba:ad:23:d1:c7:04:39:2f:e6:c7:0a:f8:cd:05:86:07:4a:24:
+        64=
:c3:89:cf:12:d2:e7:26:f2:5a:0f:5e:85:33:77:cc:7e:58:
+        dc:5e:ad:39:2=
0:c0:22:ed:8f:2e:21:ab:2d:e4:e5:21:7c:ad:
+        98:a4:5b:10:40:c8:bd:24:=
4d:d7:be:45:c0:cf:58:21:91:28:
+        1e:25:10:35:67:92:57:0e:bf:13:4e:59=
:d2:0d:3b:45:8a:17:
+        6e:93:85:71:f6:2c:22:1b:01:cf:1d:13:0e:1f:bb:d=
2:28:37:
+        10:ea:af:c3:58:2f:2c:27:0b:f7:12:0d:94:36:60:89:67:79:
+ =
       3f:95:d8:b5:33:e9:1a:53:0d:86:7f:6f:4b:d7:e2:40:9c:19:
+        ea:3=
f:55:49:b3:e4:04:fb
+-----BEGIN CERTIFICATE-----
+MIIFIjCCAwqgAwIBAgIBCDANB=
gkqhkiG9w0BAQsFADBmMQswCQYDVQQGEwJLRzEL
+MAkGA1UECAwCTkExEDAOBgNVBAcMB0JJU0=
hLRUsxFTATBgNVBAoMDE9wZW5WUE4t
+VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm1=
5ZG9tYWluMB4XDTI2MTAx
+NjIxNDYzOVoXDTM2MTAxMzIxNDYzOVowbTELMAkGA1UEBhMCS0cx=
CzAJBgNVBAgM
+Ak5BMRUwEwYDVQQKDAxPcGVuVlBOLVRFU1QxFzAVBgNVBAMMDmNsaWVudC1yZ=
XZv
+a2VkMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wggEiMA0GCSqG
+SIb3=
DQEBAQUAA4IBDwAwggEKAoIBAQCDztJej83D+uq48D07WejmarkEzlNcBElx
+zJjH3NeoOAjd9=
GLG9DQcwLd1UEXjf2I1hg6psbOaUrjdHuRohk+G+I3y4ULrdDc3
+Q2URv6C5P5X3yMv1ghBJeY=
oaWcDBe5eQIgjCNWs9k9/iyCpN8YRneB1FWoyOk/ae
+C43Naje/Skn7plHl0ADjH9m5+HpC7ZS=
fn0NeKG+Q8dG+apxkLuK5Z6sase455tSI
+hvaQea9rKBQ7J1hkgOEKZeqo0fb0LJUmkEbNR2bx=
JIA9Qx3DunekM1+mf9m867yj
++4/y40oYGE2IsK6J0lzjhrNrWvkhPHROT1seP5j9vCeIygdHx=
wHNAgMBAAGjgdMw
+gdAwCQYDVR0TBAIwADAdBgNVHQ4EFgQU6ngZxOWS7zGC/zIVpT6dkyef2o=
owgaMG
+A1UdIwSBmzCBmIAUc7G41oqVaxLgdHzFV1WYlFuseF6haqRoMGYxCzAJBgNVBAYT
+A=
ktHMQswCQYDVQQIDAJOQTEQMA4GA1UEBwwHQklTSEtFSzEVMBMGA1UECgwMT3Bl
+blZQTi1URV=
NUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW6CFG9Q
+uNNGbnI0WbwAM918rhL=
rJ0YGMA0GCSqGSIb3DQEBCwUAA4ICAQB/Z3ffINr5Jfjz
+W1dATbtfmQpvrYkREhU9Ig/4vQbR=
6pUJqZuIYIFg64nMBrAIXrN85FzYv/X5EQ1w
+kMRW9dK2Fr+Y7/gLXjGf40/EbU4KPWucoSWEL=
baFxwHQZYWoB2M31WTUtH+UFM4Q
+0bf/nIStCrdrKtr/zz2s/4Rtg0l/AUdAesZUnJNguK7Tty=
ShDo6kIHDndvYfLIGB
+ygRLsHxY7Imo7yTZZycr89PGWM+ln1Xvu6cAsF+g7oEP4vRlC7L8hP0=
mxFbW8en4
+a9e0rwVVhyZQL1B7p8zk4/5gU3V3ftTAi3Thqp9xG3iTraM+DsDhn1LWg5+ThEr+=

+kqb1bUetW8eK9UgkFP1gL2giztbevhNWYjb/MaBYBeTpMbPys103sqRvP3+Zara5
+ZKAp14C=
2YycKS0jRe9FW1LHnXHTvLWqZ8CNKP06zo17oOtx+voFMGm9Q3mUaDP4l
+03xFaPtJad4V0sp2=
Fb+6rSPRxwQ5L+bHCvjNBYYHSiRkw4nPEtLnJvJaD16FM3fM
+fljcXq05IMAi7Y8uIast5OUhf=
K2YpFsQQMi9JE3XvkXAz1ghkSgeJRA1Z5JXDr8T
+TlnSDTtFihduk4Vx9iwiGwHPHRMOH7vSKD=
cQ6q/DWC8sJwv3Eg2UNmCJZ3k/ldi1
+M+kaUw2Gf29L1+JAnBnqP1VJs+QE+w=3D=3D
+-----=
END CERTIFICATE-----
diff --git a/sample/sample-keys/client-revoked=2Ekey b=
/sample/sample-keys/client-revoked=2Ekey
new file mode 100644
index 0000000=
=2E=2E83f9086
--- /dev/null
+++ b/sample/sample-keys/client-revoked=2Ekey
@=
@ -0,0 +1,28 @@
+-----BEGIN PRIVATE KEY-----
+MIIEvQIBADANBgkqhkiG9w0BAQEFA=
ASCBKcwggSjAgEAAoIBAQCDztJej83D+uq4
+8D07WejmarkEzlNcBElxzJjH3NeoOAjd9GLG9D=
QcwLd1UEXjf2I1hg6psbOaUrjd
+HuRohk+G+I3y4ULrdDc3Q2URv6C5P5X3yMv1ghBJeYoaWcD=
Be5eQIgjCNWs9k9/i
+yCpN8YRneB1FWoyOk/aeC43Naje/Skn7plHl0ADjH9m5+HpC7ZSfn0Ne=
KG+Q8dG+
+apxkLuK5Z6sase455tSIhvaQea9rKBQ7J1hkgOEKZeqo0fb0LJUmkEbNR2bxJIA9
=
+Qx3DunekM1+mf9m867yj+4/y40oYGE2IsK6J0lzjhrNrWvkhPHROT1seP5j9vCeI
+ygdHxwHN=
AgMBAAECggEABMlBDtF6d4wYM1x34LyYTiugacoDMWNvdkwnXRSKGS/l
+tIeQAajy7ntZ/g7K5=
uKkgoyKYkOTYb5wu4jIYvpDj4Ndhi0DVNDsw1s1Y5JZh/iE
+3dFDBLhzFnPtHZ1WOEBgZcmylz=
jA2uTQe6foj1l+hRJRv8e0tGWvjhgdz1B000OW
+OmJC9M6neHghuhUAShfqHbDkXOd9w/HnQCu=
9TyWqV/D7h63dP3PfSgM1q5o5CrHZ
+2VVynpq3W4KPkPC4IsdKrmvE+Y6bwhFgU48rUSBmzpNG=
GhRcI3JkpButzRE7ZD2O
+uljFZbkt5LeCH0nIb09YPVTFjRpaQ95mktU70IeQEQKBgQC5Gkohg=
CnIj+1rYKXq
+7O1dD5RrFO5NGNdvwsQpcFF6kdcWKquGO9Ts392VOMsYDctxZX3x2LOaDhB8Kk=
Yl
+5lqh+uIULZxPYvb+SMIBnkcV1z7mnCu7dOltgJKdMkeHGwpCXUne8NtoC4wWd7Ao
+iEoK1=
pMWp9VLZMB5pZsg+eYvEQKBgQC2St1gSYG48ZbUoQzP0Qs/bl7ojTrQzNp9
+TIUvDvnxI5OLDN=
3HIn9xgDa9eSYr6CTvTNJ42uL8CSu2I4HwQDMYBNMUfqJRVKoy
+mVzKQBsLNKzBZlzO8GnJQw5=
hZJoZRBz5FJiQjz9y7pSD9nKObeMarXDRE2BkwYw2
+KLJrll6e/QKBgFLhy6m+enccwyFecEyF=
9C7ESB++iompAuY/HpizezhXzyhUyOLd
+LZU3FD+5426M1riayk8dSiZD/+uo/ioAQDrhXJPOb=
Hw7gv8PUxdoaMoFzFt0ODzC
+t7bZaEzM86wyVmCq5uXVkVjAOuTgiNdNV2IM/GWblu0gWvLdTV=
3xp7kRAoGBAK+g
+CRBPQW+RMiPA1bsSR6fhCgc6qcOo2YeGRXpFD4DHKcr5pmHIVshfIl4Bbkk=
26v6y
+IMTW/YCcxURBiVqSP6eQXlyMdI2u6Bq/rqocgPGW2imqGRg2f3Sr6hri9aQJ/2/p
+6+=
K6YAK24NcShOO78uUs3FhSNrhb0F4Nb3g/8wFxAoGAKATiB4J12yBiDgMI8dLH
+uCOA7BuB9G/=
sOWFCWlY1gQaca6fgKvkbKiv6SOH9g7D72s9RJXXXrnM/Cy6hG4+t
+7YMAhEPG8dxZCwkEIGxk=
761aq7a6iiHnvYeXHWrSbucXGQfiX/x4NB8lbXtaPBxH
+zrsv83SJbTUdHnaq0YJOIoc=3D
+-=
----END PRIVATE KEY-----
diff --git a/sample/sample-keys/gen-sample-keys=2E=
sh b/sample/sample-keys/gen-sample-keys=2Esh
index e914fd2=2E=2Ee975f36 100=
755
--- a/sample/sample-keys/gen-sample-keys=2Esh
+++ b/sample/sample-keys/=
gen-sample-keys=2Esh
@@ -18,6 +18,11 @@
 top_builddir=3D"${top_builddir:-$(=
dirname ${0})/=2E=2E/=2E=2E}"
 ${top_builddir}/src/openvpn/openvpn --genkey=
 tls-auth ta=2Ekey
 
+# Generate tls-crypt-v2 server key, and a client key =
wrapped with that key
+${top_builddir}/src/openvpn/openvpn --genkey tls-cry=
pt-v2-server tc2=2Ekey
+${top_builddir}/src/openvpn/openvpn --tls-crypt-v2 =
tc2=2Ekey \
+    --genkey tls-crypt-v2-client tc2-client=2Ekey
+
 # Create =
required directories and files
 mkdir -p sample-ca
 rm -f sample-ca/index=
=2Etxt
diff --git a/sample/sample-keys/tc2-client=2Ekey b/sample/sample-key=
s/tc2-client=2Ekey
new file mode 100644
index 0000000=2E=2E8c9a505
--- /dev=
/null
+++ b/sample/sample-keys/tc2-client=2Ekey
@@ -0,0 +1,14 @@
+-----BEGI=
N OpenVPN tls-crypt-v2 client key-----
+Lm43KRMlWHXMynOOGVmEQs51QjN7LhcqlhZ=
9XRzincFN+0iSpp1mfOUnB/oKXbKq
+PyH1sToo0zjJKQ1Bkb/cprcORcQSW1vcIDnlTdbVnLlb=
ciaGQ6ipr58zEeV65hSq
+l5jtQynh+nojbdhHfx5b8W05dxZUbYdLzzqABQrl/ti2QX4u1jwzx=
Tx43NrUbEWr
+a6ftgZFQ7kkzYTFMVJmciPYnwqnzguPRSJGXoptXaYAtX1qz8ON46zft1Nr9Ss=
/O
+uEAi4LYT3VIdKN0T6Yuld4+pKamYCA0fkz/VmhPYeWN00349k5b9VLFfBqyRlUZX
+FF4nZ=
EgatKn+re+VMKg9DASfqxmgIz1+QMNAlpytZ+22742Xhr/WnjLdRo5f1it7
+UhxqTfWqxnTvNL=
yVCE2jBQqzsHRfsVIej58ddZCOn45T7nwJD/r4GSLVJobO8TST
+FzGUKlfURZ5X+lrMVpkFJhM=
ZchfsXps4976YydBCmb5QKXDbYbcPW4Gfd4NZkNPo
+EWo4pjIk9wge5mAntay1elQOMoTkbBGJ=
xUdzzZ7eEND9JH0VJixic2wq4ZJwoGlp
+zMNvlRklj18FtH7RcHpC68cJX5DH7mY+jpWFruYnE=
1+SHXpSQkYse6vdtg8zurMC
++Y5RbK1J5u3Ts/BKD8CzJGO0S/4jAOFGrQNUuk0GlAAT9NtyCN=
bUPob9Ssd2kfT0
+R6csdyWDN2aZRQNPapdLJhHuY/kWfnKIhwEr
+-----END OpenVPN tls-=
crypt-v2 client key-----
diff --git a/sample/sample-keys/tc2=2Ekey b/sample=
/sample-keys/tc2=2Ekey
new file mode 100644
index 0000000=2E=2E6f1440c
--- =
/dev/null
+++ b/sample/sample-keys/tc2=2Ekey
@@ -0,0 +1,5 @@
+-----BEGIN Op=
enVPN tls-crypt-v2 server key-----
+Ia2XWSUJAgWX7bpHu1qXCkmiDO2ZM/YasZs3e4u=
ayasgjblLO7n9BRIJg5LEzO7R
+ugilb3ETPFPBr7zNMLW4/Td745emPvCpKyHabwsZeXih8cNQ=
HgwyjCpEdL/a7xHH
+hHGYMnGPbh9jnly9YbTc8ar/ZxOnTQjTHdosJaeTKMk=3D
+-----END =
OpenVPN tls-crypt-v2 server key-----

-- 
To view, visit https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2011?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: Ie54c455006782662e3ed51e0db869ce403a66e74
Gerrit-Change-Nu=
mber: 2011
Gerrit-PatchSet: 2
Gerrit-Owner: Steffan Karger <steffan@karger=
=2Eme>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Re=
viewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>

--XBoCBbCnQY4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2011?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">sample-keys: add tls-crypt-v2 keys=
 and revoked cert<br><br>To facilitate both manual tests as well as the upc=
oming connection test<br>suite=2E<br><br>Change-Id: Ie54c455006782662e3ed51=
e0db869ce403a66e74<br>Signed-off-by: Steffan Karger &lt;steffan@karger=2Eme=
&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2011<br>Message-Id: &lt;20261102131424=2E2=
1661-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom=
/openvpn-devel@lists=2Esourceforge=2Enet/msg40431=2Ehtml<br>Signed-off-by: =
Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M sample/sample-keys=
/README<br>A sample/sample-keys/ca=2Ecrl<br>A sample/sample-keys/client-rev=
oked=2Ecrt<br>A sample/sample-keys/client-revoked=2Ekey<br>M sample/sample-=
keys/gen-sample-keys=2Esh<br>A sample/sample-keys/tc2-client=2Ekey<br>A sam=
ple/sample-keys/tc2=2Ekey<br>7 files changed, 178 insertions(+), 0 deletion=
s(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/sample/sample-keys/README b/sample/sampl=
e-keys/README</span><br><span>index 66dd945=2E=2E4095534 100644</span><br><=
span>--- a/sample/sample-keys/README</span><br><span>+++ b/sample/sample-ke=
ys/README</span><br><span>@@ -17,3 +17,5 @@</span><br><span>               =
         password =3D &quot;password&quot;</span><br><span> client-ec=2E{cr=
t,key} -- sample elliptic curve client key/cert</span><br><span> server-ec=
=2E{crt,key} -- sample elliptic curve server key/cert</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+tc2=2Ekey             -- sample tls-crypt=
-v2 server key</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tc2-c=
lient=2Ekey      -- sample tls-crypt-v2 client key, for use with tc2=2Ekey<=
/span><br><span>diff --git a/sample/sample-keys/ca=2Ecrl b/sample/sample-ke=
ys/ca=2Ecrl</span><br><span>new file mode 100644</span><br><span>index 0000=
000=2E=2E6a00a41</span><br><span>--- /dev/null</span><br><span>+++ b/sample=
/sample-keys/ca=2Ecrl</span><br><span>@@ -0,0 +1,21 @@</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+-----BEGIN X509 CRL-----</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+MIIDcjCCAVoCAQEwDQYJKoZIhvcNAQELBQA=
wZjELMAkGA1UEBhMCS0cxCzAJBgNV</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+BAgMAk5BMRAwDgYDVQQHDAdCSVNIS0VLMRUwEwYDVQQKDAxPcGVuVlBOLVRFU1Qx<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ITAfBgkqhkiG9w0BCQEW=
Em1lQG15aG9zdC5teWRvbWFpbhcNMjYxMDE2MjE1MTE0</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+WhcNMzYxMDEzMjE1MTE0WjAUMBICAQgXDTI2MTAxNjIxNDYzOV=
qggakwgaYwgaMG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+A1UdI=
wSBmzCBmIAUc7G41oqVaxLgdHzFV1WYlFuseF6haqRoMGYxCzAJBgNVBAYT</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+AktHMQswCQYDVQQIDAJOQTEQMA4GA1UEBww=
HQklTSEtFSzEVMBMGA1UECgwMT3Bl</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+blZQTi1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW6CFG9Q<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+uNNGbnI0WbwAM918rhLr=
J0YGMA0GCSqGSIb3DQEBCwUAA4ICAQBnOXQjAUEi3AAX</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+8O6Z9jEH+PK0YbHm5fAKi2db+u7iFc1oB8usI+pSFYP3ZYHMAt=
jdDPxk2GvlfXcU</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pCYuP=
SN3FF3eaTl53xIF7dn3w2279vbN4b+g1Z0kr5Uba5T18HFrUA5/LnM+f/1x</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+y7162j4LjVEy6lIvG7byvPF/mwmfaG9DTkc=
uAV0ChZnkLhT7yX0CL3xJUMDl2717</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+5aFR09/FQnvPqIbUgWH55CTeXkPsVh+ivHzQBIiqHJ/e9A6qZeKPJD7qaTPmRDAS<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+mufLvCJKUUs2zdSmXAM0=
E3P9znNolIepsr9daGNRGkRoOhM5EEHZ2cUUy1rftGd5</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+BBZrTf/A8DpCfXoL2mMBUl499DRgPefhJXZLmjjAp4F7t8hWZI=
am40f4qKk/suoO</span><br><span style=3D"color: hsl(120, 100%, 40%);">+MyWgK=
+pBnHZqijIXCoYnUYNNpem6I2YW0gWLayqaxEndA28WKtuR6jeWPt7ErTtg</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+m9YvveBhxy+2QXWJgFBoiEKskK2wad9qXt+=
h08Bi70G+KOK7GDm+UkA0D5yMulnW</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+A0qll22u8ASmmIeohg65VU82d6jJy/OqikxSPEQ+Ya9zPmr/ASGrX2nChrPGmeUC<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+UFUTlIhUuamVLkuvOQu/=
meWhS/XKf3uSMXilXtcI7lmt1wTnFAFLBeZzQxgyn8kY</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+5u/LWT5Fvd0BKM7/Omah55B/YBTiTA=3D=3D</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+-----END X509 CRL-----</span><br>=
<span>diff --git a/sample/sample-keys/client-revoked=2Ecrt b/sample/sample-=
keys/client-revoked=2Ecrt</span><br><span>new file mode 100644</span><br><s=
pan>index 0000000=2E=2E45e78a0</span><br><span>--- /dev/null</span><br><spa=
n>+++ b/sample/sample-keys/client-revoked=2Ecrt</span><br><span>@@ -0,0 +1,=
103 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Certificate:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Data:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        Version: 3 (0x2)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        Serial Number: 8 =
(0x8)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Signat=
ure Algorithm: sha256WithRSAEncryption</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        Issuer: C=3DKG, ST=3DNA, L=3DBISHKEK, O=3DOpenVP=
N-TEST/emailAddress=3Dme@myhost=2Emydomain</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        Validity</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            Not Before: Oct 16 21:46:39 2026 GMT</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            Not After : Oc=
t 13 21:46:39 2036 GMT</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        Subject: C=3DKG, ST=3DNA, O=3DOpenVPN-TEST, CN=3Dclient-revoked/=
emailAddress=3Dme@myhost=2Emydomain</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        Subject Public Key Info:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            Public Key Algorithm: rsaEncryptio=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                Pu=
blic-Key: (2048 bit)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                Modulus:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    00:83:ce:d2:5e:8f:cd:c3:fa:ea:b8:f0:3d:3b:59:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    e8:=
e6:6a:b9:04:ce:53:5c:04:49:71:cc:98:c7:dc:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    d7:a8:38:08:dd:f4:62:c6:f4:34:1c=
:c0:b7:75:50:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              45:e3:7f:62:35:86:0e:a9:b1:b3:9a:52:b8:dd:1e:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                    e4:68:86:4f:86:=
f8:8d:f2:e1:42:eb:74:37:37:43:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                    65:11:bf:a0:b9:3f:95:f7:c8:cb:f5:82:10:49:79=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
  8a:1a:59:c0:c1:7b:97:90:22:08:c2:35:6b:3d:93:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    df:e2:c8:2a:4d:f1:84:67:78:=
1d:45:5a:8c:8e:93:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   f6:9e:0b:8d:cd:6a:37:bf:4a:49:fb:a6:51:e5:d0:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    00:e3:1f:d=
9:b9:f8:7a:42:ed:94:9f:9f:43:5e:28:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    6f:90:f1:d1:be:6a:9c:64:2e:e2:b9:67:ab:=
1a:b1:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       ee:39:e6:d4:88:86:f6:90:79:af:6b:28:14:3b:27:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    58:64:80:e1:0a:65:ea:=
a8:d1:f6:f4:2c:95:26:90:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    46:cd:47:66:f1:24:80:3d:43:1d:c3:ba:77:a4:33:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    5f:a=
6:7f:d9:bc:eb:bc:a3:fb:8f:f2:e3:4a:18:18:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    4d:88:b0:ae:89:d2:5c:e3:86:b3:6b:=
5a:f9:21:3c:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             74:4e:4f:5b:1e:3f:98:fd:bc:27:88:ca:07:47:c7:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    01:cd</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                Exponent: 6553=
7 (0x10001)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
X509v3 extensions:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           X509v3 Basic Constraints:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                CA:FALSE</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            X509v3 Subject Key Identifier:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                EA:78:19:C4:E5=
:92:EF:31:82:FF:32:15:A5:3E:9D:93:27:9F:DA:8A</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            X509v3 Authority Key Identifier:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                keyid:73=
:B1:B8:D6:8A:95:6B:12:E0:74:7C:C5:57:55:98:94:5B:AC:78:5E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                DirName:/C=3DKG/ST=3D=
NA/L=3DBISHKEK/O=3DOpenVPN-TEST/emailAddress=3Dme@myhost=2Emydomain</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                serial:6F:5=
0:B8:D3:46:6E:72:34:59:BC:00:33:DD:7C:AE:12:EB:27:46:06</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    Signature Algorithm: sha256WithRSAE=
ncryption</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Signat=
ure Value:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        7=
f:67:77:df:20:da:f9:25:f8:f3:5b:57:40:4d:bb:5f:99:0a:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        6f:ad:89:11:12:15:3d:22:0f:f8:bd:=
06:d1:ea:95:09:a9:9b:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        88:60:81:60:eb:89:cc:06:b0:08:5e:b3:7c:e4:5c:d8:bf:f5:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        f9:11:0d:70:90:c4:56:f=
5:d2:b6:16:bf:98:ef:f8:0b:5e:31:</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        9f:e3:4f:c4:6d:4e:0a:3d:6b:9c:a1:25:84:2d:b6:85:c7:01:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        d0:65:85:a8=
:07:63:37:d5:64:d4:b4:7f:94:14:ce:10:d1:b7:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        ff:9c:84:ad:0a:b7:6b:2a:da:ff:cf:3d:ac:ff:8=
4:6d:83:49:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
7f:01:47:40:7a:c6:54:9c:93:60:b8:ae:d3:b7:24:a1:0e:8e:</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        a4:20:70:e7:76:f6:1f:2c:81:81:ca=
:04:4b:b0:7c:58:ec:89:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        a8:ef:24:d9:67:27:2b:f3:d3:c6:58:cf:a5:9f:55:ef:bb:a7:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        00:b0:5f:a0:ee:81:0f:=
e2:f4:65:0b:b2:fc:84:fd:26:c4:56:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        d6:f1:e9:f8:6b:d7:b4:af:05:55:87:26:50:2f:50:7b:a7:cc=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e4:e3:fe:6=
0:53:75:77:7e:d4:c0:8b:74:e1:aa:9f:71:1b:78:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        93:ad:a3:3e:0e:c0:e1:9f:52:d6:83:9f:93:84:=
4a:fe:92:a6:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 f5:6d:47:ad:5b:c7:8a:f5:48:24:14:fd:60:2f:68:22:ce:d6:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        de:be:13:56:62:36:ff:31:a0:58:0=
5:e4:e9:31:b3:f2:b3:5d:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        37:b2:a4:6f:3f:7f:99:6a:b6:b9:64:a0:29:d7:80:b6:63:27:</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        0a:4b:48:d1:7b:d1:56=
:d4:b1:e7:5c:74:ef:2d:6a:99:f0:23:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        4a:3f:4e:b3:a3:5e:e8:3a:dc:7e:be:81:4c:1a:6f:50:de:6=
5:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        1a:0c:fe:=
25:d3:7c:45:68:fb:49:69:de:15:d2:ca:76:15:bf:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        ba:ad:23:d1:c7:04:39:2f:e6:c7:0a:f8:cd:05=
:86:07:4a:24:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  64:c3:89:cf:12:d2:e7:26:f2:5a:0f:5e:85:33:77:cc:7e:58:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        dc:5e:ad:39:20:c0:22:ed:8f:2e:=
21:ab:2d:e4:e5:21:7c:ad:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        98:a4:5b:10:40:c8:bd:24:4d:d7:be:45:c0:cf:58:21:91:28:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        1e:25:10:35:67:92:5=
7:0e:bf:13:4e:59:d2:0d:3b:45:8a:17:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        6e:93:85:71:f6:2c:22:1b:01:cf:1d:13:0e:1f:bb:d2:28:=
37:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        10:ea:af=
:c3:58:2f:2c:27:0b:f7:12:0d:94:36:60:89:67:79:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        3f:95:d8:b5:33:e9:1a:53:0d:86:7f:6f:4b:d=
7:e2:40:9c:19:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   ea:3f:55:49:b3:e4:04:fb</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+-----BEGIN CERTIFICATE-----</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+MIIFIjCCAwqgAwIBAgIBCDANBgkqhkiG9w0BAQsFADBmMQswCQYDVQQGEwJL=
RzEL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+MAkGA1UECAwCTkE=
xEDAOBgNVBAcMB0JJU0hLRUsxFTATBgNVBAoMDE9wZW5WUE4t</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15Z=
G9tYWluMB4XDTI2MTAx</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
NjIxNDYzOVoXDTM2MTAxMzIxNDYzOVowbTELMAkGA1UEBhMCS0cxCzAJBgNVBAgM</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+Ak5BMRUwEwYDVQQKDAxPcGVuVlBOLV=
RFU1QxFzAVBgNVBAMMDmNsaWVudC1yZXZv</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+a2VkMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wggEiMA0G=
CSqG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SIb3DQEBAQUAA4I=
BDwAwggEKAoIBAQCDztJej83D+uq48D07WejmarkEzlNcBElx</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+zJjH3NeoOAjd9GLG9DQcwLd1UEXjf2I1hg6psbOaUrjdH=
uRohk+G+I3y4ULrdDc3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
Q2URv6C5P5X3yMv1ghBJeYoaWcDBe5eQIgjCNWs9k9/iyCpN8YRneB1FWoyOk/ae</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+C43Naje/Skn7plHl0ADjH9m5+HpC7Z=
Sfn0NeKG+Q8dG+apxkLuK5Z6sase455tSI</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+hvaQea9rKBQ7J1hkgOEKZeqo0fb0LJUmkEbNR2bxJIA9Qx3DunekM1+mf9m8=
67yj</span><br><span style=3D"color: hsl(120, 100%, 40%);">++4/y40oYGE2IsK6=
J0lzjhrNrWvkhPHROT1seP5j9vCeIygdHxwHNAgMBAAGjgdMw</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+gdAwCQYDVR0TBAIwADAdBgNVHQ4EFgQU6ngZxOWS7zGC/=
zIVpT6dkyef2oowgaMG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
A1UdIwSBmzCBmIAUc7G41oqVaxLgdHzFV1WYlFuseF6haqRoMGYxCzAJBgNVBAYT</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+AktHMQswCQYDVQQIDAJOQTEQMA4GA1=
UEBwwHQklTSEtFSzEVMBMGA1UECgwMT3Bl</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+blZQTi1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW6C=
FG9Q</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uNNGbnI0WbwAM91=
8rhLrJ0YGMA0GCSqGSIb3DQEBCwUAA4ICAQB/Z3ffINr5Jfjz</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+W1dATbtfmQpvrYkREhU9Ig/4vQbR6pUJqZuIYIFg64nMB=
rAIXrN85FzYv/X5EQ1w</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
kMRW9dK2Fr+Y7/gLXjGf40/EbU4KPWucoSWELbaFxwHQZYWoB2M31WTUtH+UFM4Q</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+0bf/nIStCrdrKtr/zz2s/4Rtg0l/AU=
dAesZUnJNguK7TtyShDo6kIHDndvYfLIGB</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ygRLsHxY7Imo7yTZZycr89PGWM+ln1Xvu6cAsF+g7oEP4vRlC7L8hP0mxFbW=
8en4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+a9e0rwVVhyZQL1B=
7p8zk4/5gU3V3ftTAi3Thqp9xG3iTraM+DsDhn1LWg5+ThEr+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+kqb1bUetW8eK9UgkFP1gL2giztbevhNWYjb/MaBYBeTpM=
bPys103sqRvP3+Zara5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
ZKAp14C2YycKS0jRe9FW1LHnXHTvLWqZ8CNKP06zo17oOtx+voFMGm9Q3mUaDP4l</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+03xFaPtJad4V0sp2Fb+6rSPRxwQ5L+=
bHCvjNBYYHSiRkw4nPEtLnJvJaD16FM3fM</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+fljcXq05IMAi7Y8uIast5OUhfK2YpFsQQMi9JE3XvkXAz1ghkSgeJRA1Z5JX=
Dr8T</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TlnSDTtFihduk4V=
x9iwiGwHPHRMOH7vSKDcQ6q/DWC8sJwv3Eg2UNmCJZ3k/ldi1</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+M+kaUw2Gf29L1+JAnBnqP1VJs+QE+w=3D=3D</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+-----END CERTIFICATE-----</s=
pan><br><span>diff --git a/sample/sample-keys/client-revoked=2Ekey b/sample=
/sample-keys/client-revoked=2Ekey</span><br><span>new file mode 100644</spa=
n><br><span>index 0000000=2E=2E83f9086</span><br><span>--- /dev/null</span>=
<br><span>+++ b/sample/sample-keys/client-revoked=2Ekey</span><br><span>@@ =
-0,0 +1,28 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+-----B=
EGIN PRIVATE KEY-----</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCDztJej83D+uq4</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+8D07WejmarkEzlNcBElxzJjH3Neo=
OAjd9GLG9DQcwLd1UEXjf2I1hg6psbOaUrjd</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+HuRohk+G+I3y4ULrdDc3Q2URv6C5P5X3yMv1ghBJeYoaWcDBe5eQIgjCNW=
s9k9/i</span><br><span style=3D"color: hsl(120, 100%, 40%);">+yCpN8YRneB1FW=
oyOk/aeC43Naje/Skn7plHl0ADjH9m5+HpC7ZSfn0NeKG+Q8dG+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+apxkLuK5Z6sase455tSIhvaQea9rKBQ7J1hkgOEKZ=
eqo0fb0LJUmkEbNR2bxJIA9</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+Qx3DunekM1+mf9m867yj+4/y40oYGE2IsK6J0lzjhrNrWvkhPHROT1seP5j9vCeI</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ygdHxwHNAgMBAAECggEABMlBDt=
F6d4wYM1x34LyYTiugacoDMWNvdkwnXRSKGS/l</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+tIeQAajy7ntZ/g7K5uKkgoyKYkOTYb5wu4jIYvpDj4Ndhi0DVNDsw1s1=
Y5JZh/iE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+3dFDBLhzFnP=
tHZ1WOEBgZcmylzjA2uTQe6foj1l+hRJRv8e0tGWvjhgdz1B000OW</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+OmJC9M6neHghuhUAShfqHbDkXOd9w/HnQCu9TyWqV=
/D7h63dP3PfSgM1q5o5CrHZ</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+2VVynpq3W4KPkPC4IsdKrmvE+Y6bwhFgU48rUSBmzpNGGhRcI3JkpButzRE7ZD2O</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+uljFZbkt5LeCH0nIb09YPVTFjR=
paQ95mktU70IeQEQKBgQC5GkohgCnIj+1rYKXq</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+7O1dD5RrFO5NGNdvwsQpcFF6kdcWKquGO9Ts392VOMsYDctxZX3x2LOa=
DhB8KkYl</span><br><span style=3D"color: hsl(120, 100%, 40%);">+5lqh+uIULZx=
PYvb+SMIBnkcV1z7mnCu7dOltgJKdMkeHGwpCXUne8NtoC4wWd7Ao</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+iEoK1pMWp9VLZMB5pZsg+eYvEQKBgQC2St1gSYG48=
ZbUoQzP0Qs/bl7ojTrQzNp9</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+TIUvDvnxI5OLDN3HIn9xgDa9eSYr6CTvTNJ42uL8CSu2I4HwQDMYBNMUfqJRVKoy</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+mVzKQBsLNKzBZlzO8GnJQw5hZJ=
oZRBz5FJiQjz9y7pSD9nKObeMarXDRE2BkwYw2</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+KLJrll6e/QKBgFLhy6m+enccwyFecEyF9C7ESB++iompAuY/HpizezhX=
zyhUyOLd</span><br><span style=3D"color: hsl(120, 100%, 40%);">+LZU3FD+5426=
M1riayk8dSiZD/+uo/ioAQDrhXJPObHw7gv8PUxdoaMoFzFt0ODzC</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+t7bZaEzM86wyVmCq5uXVkVjAOuTgiNdNV2IM/GWbl=
u0gWvLdTV3xp7kRAoGBAK+g</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+CRBPQW+RMiPA1bsSR6fhCgc6qcOo2YeGRXpFD4DHKcr5pmHIVshfIl4Bbkk26v6y</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+IMTW/YCcxURBiVqSP6eQXlyMdI=
2u6Bq/rqocgPGW2imqGRg2f3Sr6hri9aQJ/2/p</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+6+K6YAK24NcShOO78uUs3FhSNrhb0F4Nb3g/8wFxAoGAKATiB4J12yBi=
DgMI8dLH</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uCOA7BuB9G/=
sOWFCWlY1gQaca6fgKvkbKiv6SOH9g7D72s9RJXXXrnM/Cy6hG4+t</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+7YMAhEPG8dxZCwkEIGxk761aq7a6iiHnvYeXHWrSb=
ucXGQfiX/x4NB8lbXtaPBxH</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+zrsv83SJbTUdHnaq0YJOIoc=3D</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+-----END PRIVATE KEY-----</span><br><span>diff --git a/sample/sa=
mple-keys/gen-sample-keys=2Esh b/sample/sample-keys/gen-sample-keys=2Esh</s=
pan><br><span>index e914fd2=2E=2Ee975f36 100755</span><br><span>--- a/sampl=
e/sample-keys/gen-sample-keys=2Esh</span><br><span>+++ b/sample/sample-keys=
/gen-sample-keys=2Esh</span><br><span>@@ -18,6 +18,11 @@</span><br><span> t=
op_builddir=3D&quot;${top_builddir:-$(dirname ${0})/=2E=2E/=2E=2E}&quot;</s=
pan><br><span> ${top_builddir}/src/openvpn/openvpn --genkey tls-auth ta=2Ek=
ey</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# Generate tls-crypt-v2 server key, and a client key wrapped with that key=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+${top_builddir}/src=
/openvpn/openvpn --genkey tls-crypt-v2-server tc2=2Ekey</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+${top_builddir}/src/openvpn/openvpn --t=
ls-crypt-v2 tc2=2Ekey \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    --genkey tls-crypt-v2-client tc2-client=2Ekey</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> # Create required direc=
tories and files</span><br><span> mkdir -p sample-ca</span><br><span> rm -f=
 sample-ca/index=2Etxt</span><br><span>diff --git a/sample/sample-keys/tc2-=
client=2Ekey b/sample/sample-keys/tc2-client=2Ekey</span><br><span>new file=
 mode 100644</span><br><span>index 0000000=2E=2E8c9a505</span><br><span>---=
 /dev/null</span><br><span>+++ b/sample/sample-keys/tc2-client=2Ekey</span>=
<br><span>@@ -0,0 +1,14 @@</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+-----BEGIN OpenVPN tls-crypt-v2 client key-----</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+Lm43KRMlWHXMynOOGVmEQs51QjN7LhcqlhZ9XRzi=
ncFN+0iSpp1mfOUnB/oKXbKq</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+PyH1sToo0zjJKQ1Bkb/cprcORcQSW1vcIDnlTdbVnLlbciaGQ6ipr58zEeV65hSq</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+l5jtQynh+nojbdhHfx5b8W05d=
xZUbYdLzzqABQrl/ti2QX4u1jwzxTx43NrUbEWr</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+a6ftgZFQ7kkzYTFMVJmciPYnwqnzguPRSJGXoptXaYAtX1qz8ON46zf=
t1Nr9Ss/O</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uEAi4LYT3V=
IdKN0T6Yuld4+pKamYCA0fkz/VmhPYeWN00349k5b9VLFfBqyRlUZX</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+FF4nZEgatKn+re+VMKg9DASfqxmgIz1+QMNAlpyt=
Z+22742Xhr/WnjLdRo5f1it7</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+UhxqTfWqxnTvNLyVCE2jBQqzsHRfsVIej58ddZCOn45T7nwJD/r4GSLVJobO8TST</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+FzGUKlfURZ5X+lrMVpkFJhMZc=
hfsXps4976YydBCmb5QKXDbYbcPW4Gfd4NZkNPo</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+EWo4pjIk9wge5mAntay1elQOMoTkbBGJxUdzzZ7eEND9JH0VJixic2w=
q4ZJwoGlp</span><br><span style=3D"color: hsl(120, 100%, 40%);">+zMNvlRklj1=
8FtH7RcHpC68cJX5DH7mY+jpWFruYnE1+SHXpSQkYse6vdtg8zurMC</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">++Y5RbK1J5u3Ts/BKD8CzJGO0S/4jAOFGrQNUuk0G=
lAAT9NtyCNbUPob9Ssd2kfT0</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+R6csdyWDN2aZRQNPapdLJhHuY/kWfnKIhwEr</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+-----END OpenVPN tls-crypt-v2 client key-----</span><=
br><span>diff --git a/sample/sample-keys/tc2=2Ekey b/sample/sample-keys/tc2=
=2Ekey</span><br><span>new file mode 100644</span><br><span>index 0000000=
=2E=2E6f1440c</span><br><span>--- /dev/null</span><br><span>+++ b/sample/sa=
mple-keys/tc2=2Ekey</span><br><span>@@ -0,0 +1,5 @@</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+-----BEGIN OpenVPN tls-crypt-v2 server ke=
y-----</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Ia2XWSUJAgWX7=
bpHu1qXCkmiDO2ZM/YasZs3e4uayasgjblLO7n9BRIJg5LEzO7R</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ugilb3ETPFPBr7zNMLW4/Td745emPvCpKyHabwsZe=
Xih8cNQHgwyjCpEdL/a7xHH</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+hHGYMnGPbh9jnly9YbTc8ar/ZxOnTQjTHdosJaeTKMk=3D</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+-----END OpenVPN tls-crypt-v2 server key----=
-</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2011?usp=3Demail">change 2011</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2011?usp=3Demail"/><meta itemprop=3D"name" co=
ntent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Me=
ssageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Ie54c455006782662e3ed51e0db869ce403=
a66e74 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2011 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--XBoCBbCnQY4=--


--===============3118790243141515618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3118790243141515618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3118790243141515618==--

