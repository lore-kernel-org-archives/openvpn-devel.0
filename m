Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BA7CA5FCE
	for <openvpn-devel@archiver.kernel.org>; Sun,  4 Oct 2026 08:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9X1cn3HWlAKOYFrJk/kjofTOmQPJBf7DZyUZtJGyyl0=; b=HGCzYFCVF8jD8NWfH5gxgDjhuV
	5BX9/nzIcOB1xnCQGHZuZhzXdbNLlQdmZYAqNF7TpaLHou0evRJ8SUVwxgqDEtQrEQNcy1MqVfkhG
	Iy/sITam63yGRbpxW53gVtaEL0FSkbN0PrgbP9yenER0QKq7kCHgNS3i+XLugPcAK6Sc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDHtq-0005wL-UZ;
	Sun, 04 Oct 2026 08:48:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDHtp-0005w6-SQ
 for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 08:48:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=zfRkw+0QP8f5eCquX5qlFUQ+ZvbTSOz5ah8SmVxyB+I=; b=HSfVHVeo7PNkzwokQsP+LDlM54
 pmHHFA/nJsezjO1rMGtsoLAT9cX5zuWQi9W7hgutljHKeHOZn3P8VAXZW7l0KYt1sG92r8iX4pBaV
 eBvSSfY4ANbXWj9Bii5/mngeNNGQ2VfK7i2hUBQAmV3QMKtm8e/mhAsfmuzA2YKlKl1Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zfRkw+0QP8f5eCquX5qlFUQ+ZvbTSOz5ah8SmVxyB+I=; b=i
 Fll4E5VOQLwi6z1tHKUDFQile1xFDP42kNxKWhoniy+k+GImrpwAeak3bL+WtSPx7iT6nAZuTrRuI
 r2/jNJmb5xQlImvLc3N9aUARP2vah2VaYk4VRQ38eCXldiXLXwZuXPOpXT73S/R2X44OznwSgB0LW
 yzLXHyrdbf0wG/OI=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDHtp-0001z7-N5 for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 08:48:50 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-4a003bd18e5so4955805e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 04 Oct 2026 01:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791103723; x=1791708523; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zfRkw+0QP8f5eCquX5qlFUQ+ZvbTSOz5ah8SmVxyB+I=;
 b=O38ArFcNYiDc3pknb52PLK4twbKi7tFXOyu/wQweJBfDIY5Cw8riyrhujLrPp+aFIG
 4p/corbqdKyIgHFCDPKsasY5FNUs/lJkiGny92ntJApPary7Pl+zHekTekGYArpo98CG
 5ZntjrnKlLcsEUEy7OIuAd1Q+SSh3+jaU8JkMwIOEFlOEqWqxbDuURjPVOQvEGeUkUxo
 PQKv/3kr1XHHi2Pqk3vXVifnCdgkmNMALdPsbJpDJyCrCE3kZlsZLVn+3tiEowLgsq/e
 +5FLksI1chC4/80ogk+RfcoOvXbwGlORg/qnG8eMNWGL7WThfHi7MIpAbZSVHbcogI+U
 PiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791103723; x=1791708523;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zfRkw+0QP8f5eCquX5qlFUQ+ZvbTSOz5ah8SmVxyB+I=;
 b=f5Y0klQ1Kj+RWO1Z61OXxnsNK7RgsqDu6og4P6Y4vrldYUcHr8NPAUsgb6rTip5yMB
 cTkx15uCiy3dM6eVA7h8ZbO4BC82JM8SLmDLQRKu5X/cI9v/BQJLvOAMV9Ioj+gV/ynW
 qm9g20akiF9MoFb2ujZeoGkeAAe7jw/s0mF/tXKA1SPjFWJUYqtStYP7LGgTQ4cWIYiX
 WG8Cq0EPY2t3MVomZB3Vz+6MSiylDcv06IOC0eRGYSWQRM/kMHo1GzoWfvsC/EypxRzM
 tl58S+HB5IDCs9f6jvwVa8Djllr6m90tZFrLzyhasbmr7X3R3BlUHAgs2OPGLblV6hTq
 OskA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNYcIWi8oIfAeoeIv2Efani9kdQTlNneIhxmYOtNzytO3IEiGRwlwGDBgAaXXHqIgak0DnqF3vyc/6SPn/@lists.sourceforge.net
X-Gm-Message-State: AFuF++k/K+OlExzRoUU59TONaXFSd1xpKRSDFQSpLoYDyp5Sdq4BfZXB
 KHtPZ0LmEGz7iSb7TuWVmg2EZUVYKB1NB1NvYmUGQcNwzhDgfkBqD9ijE+hu4YJ8SWmxSViSJTu
 z8s+aFaF3MS89hyIYZyCR1dvvVqTwll1B/+NCT4KT/O3wEUYwDQ7/zlU8c6hriLoD+zf/
X-Gm-Gg: AYBFou3jPb4jYvX3yyFXKCxf6TLtkrBEgsj2zYrRgZcUUfr8OWXlHvneo7ZxTTHDACp
 uDvsEGC8KCBA/jre7D8kacmAfc+alTFl5aBXxcXJMHHEc+74TmjenLh4B0Lnsqb9mUdCxhrGMpM
 76vr+7qzbijRomKW95OLrQf+gvGOrn0Pq1YWWzXbdElo9QKZrkg5HDrfzkGUBrW4tK9dYYt6iEl
 BtsOWOrkfpuA6uHB1NqwZriTtqkZOXATZu6/DRV22Jhyx75aar6+O9XR82GYDewU0AC6xv076Nq
 Hcf3Nz4WUSa0sNP2t2Q1wgP8EMGpTtLR13melYpAqAzTdSgaCpxy07tku6OwGj+MFu5bMMMUHZG
 a3H8i7NQtEFBB3uqxLEIkGQNe4Po0g4LHg9m/vy3COXwKXu4/HaqrS9WbrBQMyzR+td/FhjX1MU
 dpqSj1R7U3s3EMoir6PVH7fj/yzYAE+PHnwMD5qxRKnsJ2uOMSM0jxjtxvG1B2cx2K3ylfS828e
 B8ZnjpK3azQaWDe3L5Lp/T9EkcEtCNRGdy+5t01VZo8Ul2hCMcRHl9TYGQnIPADrX9mwDlwb7HY
 Z2UOrj8WuoMn6OZdL3PzCqi+MKwyaU84Sxfk1YiETeIo6nDNNxCNm5MZQTEF
X-Received: by 2002:a05:600c:8b6c:b0:49f:ec98:f030 with SMTP id
 5b1f17b1804b1-4a0276b3e15mr128150445e9.33.1791103722627; 
 Sun, 04 Oct 2026 01:48:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0280bfafasm251457775e9.8.2026.10.04.01.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 01:48:42 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 4 Oct 2026 08:48:41 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I6693b5aa2988102f5e7884a65119ebfc87dd07e1
X-Gerrit-Change-Number: 1954
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1954?usp=email>
X-Gerrit-Commit: 7f1dfa99fd1e7e609abeff7f331face61dbcbeaa
In-Reply-To: <gerrit.1790354422000.I6693b5aa2988102f5e7884a65119ebfc87dd07e1@gerrit.openvpn.net>
References: <gerrit.1790354422000.I6693b5aa2988102f5e7884a65119ebfc87dd07e1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzU0NDIyMDAwLkk2NjkzYjVhYTI5ODgxMDJmNWU3ODg0YTY1MTE5ZWJmYzg3ZGQwN2UxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d3086f8e4a7538bd1721a6985b55ef45f704d786-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDHtp-0001z7-N5
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix various issues
 found by cppcheck 2.21.0
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4647091496617850451=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4647091496617850451==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MzmifVp1q+E="; charset=UTF-8

--MzmifVp1q+E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1954?usp=3Demail )

Change subject: Fix various issues found by=
 cppcheck 2=2E21=2E0
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Fix various issues found by cppcheck 2=2E21=2E0

- Fix several cons=
tVariablePointer issues that
  were newly reported
- Fix one unreadVariable=
 issue that was newly
  reported
- Remove --showtime=3Dsummary from cppchec=
k args
  again, it is now much more verbose

Change-Id: I6693b5aa2988102f5e=
7884a65119ebfc87dd07e1
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1954
Message-Id: <20261003175529=2E636=
0-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-=
devel@lists=2Esourceforge=2Enet/msg39671=2Ehtml
Signed-off-by: Gert Doering=
 <gert@greenie=2Emuc=2Ede>
---
M dev-tools/run-cppcheck=2Esh
M src/openvpn/=
dco=2Ec
M src/openvpn/mudp=2Ec
M src/openvpn/pkcs11_openssl=2Ec
M src/openv=
pn/socks=2Ec
M tests/unit_tests/openvpn/siphash_openssl=2Ec
6 files changed=
, 5 insertions(+), 8 deletions(-)




diff --git a/dev-tools/run-cppcheck=
=2Esh b/dev-tools/run-cppcheck=2Esh
index ad012ac=2E=2E3c71c83 100755
--- a=
/dev-tools/run-cppcheck=2Esh
+++ b/dev-tools/run-cppcheck=2Esh
@@ -33,7 +33=
,7 @@
  --suppress-xml=3D${SCRIPT_DIR}/cppcheck-suppressions=2Exml --inline=
-suppr \
  --cppcheck-build-dir=3D${CPPCHECK_DIR} \
  --check-level=3D${CPP=
CHECK_CHECK_LEVEL} --max-configs=3D10 \
- --error-exitcode=3D1 --showtime=
=3Dsummary"
+ --error-exitcode=3D1"
 
 set -x
 
diff --git a/src/openvpn/dc=
o=2Ec b/src/openvpn/dco=2Ec
index 6d88f6f=2E=2E9fc0e3b 100644
--- a/src/ope=
nvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -534,7 +534,7 @@
     ASSERT(sock=
->info=2Econnection_established);
 
     struct sockaddr *remoteaddr =3D &s=
ock->info=2Elsa->actual=2Edest=2Eaddr=2Esa;
-    struct tls_multi *multi =
=3D c->c2=2Etls_multi;
+    const struct tls_multi *multi =3D c->c2=2Etls_m=
ulti;
 #ifdef TARGET_FREEBSD
     /* In Linux in P2P mode the kernel automa=
tically removes an existing peer
      * when adding a new peer=2E FreeBSD =
needs to explicitly be told to do that */
diff --git a/src/openvpn/mudp=2Ec=
 b/src/openvpn/mudp=2Ec
index 4794b7e=2E=2E2b08ada 100644
--- a/src/openvpn=
/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -316,10 +316,9 @@
 multi_get_instan=
ce_udp_real(struct multi_context *m, struct mroute_addr *real)
 {
     stru=
ct hash *hash =3D m->hash;
-    struct hash_element *he;
     const uint64_=
t hv =3D hash_value(hash, real);
     struct hash_bucket *bucket =3D hash_b=
ucket(hash, hv);
-    he =3D hash_lookup_fast(hash, bucket, real, hv);
+   =
 const struct hash_element *he =3D hash_lookup_fast(hash, bucket, real, hv)=
;
     if (he)
     {
         return he->value;
diff --git a/src/openvpn/p=
kcs11_openssl=2Ec b/src/openvpn/pkcs11_openssl=2Ec
index 69c5a50=2E=2E24dce=
84 100644
--- a/src/openvpn/pkcs11_openssl=2Ec
+++ b/src/openvpn/pkcs11_ope=
nssl=2Ec
@@ -184,7 +184,6 @@
         {
             tbs =3D buf;
         =
    tbslen =3D (size_t)buflen;
-            sigalg=2Eop =3D "Sign";
       =
  }
         else
         {
diff --git a/src/openvpn/socks=2Ec b/src/openv=
pn/socks=2Ec
index 19f3d54=2E=2E65ecb3c 100644
--- a/src/openvpn/socks=2Ec
=
+++ b/src/openvpn/socks=2Ec
@@ -323,8 +323,7 @@
         return port;
     =
}
 
-    struct servent *service;
-    service =3D getservbyname(servname, =
NULL);
+    const struct servent *service =3D getservbyname(servname, NULL)=
;
     if (service)
     {
         return service->s_port;
diff --git a/te=
sts/unit_tests/openvpn/siphash_openssl=2Ec b/tests/unit_tests/openvpn/sipha=
sh_openssl=2Ec
index c301f2d=2E=2E99a7763 100644
--- a/tests/unit_tests/ope=
nvpn/siphash_openssl=2Ec
+++ b/tests/unit_tests/openvpn/siphash_openssl=2Ec=

@@ -101,7 +101,7 @@
 bool
 siphash_openssl_available(void *sip_context)
 {=

-    struct siphash_context *sip =3D sip_context;
+    const struct siphas=
h_context *sip =3D sip_context;
 
     return (bool)(sip->mac);
 }

-- 
To =
view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1954?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6693b5aa2988102f5e7884a6511=
9ebfc87dd07e1
Gerrit-Change-Number: 1954
Gerrit-PatchSet: 4
Gerrit-Owner: F=
rank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Gert Doering <g=
ert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--MzmifVp1q+E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1954?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Fix various issues found by cppche=
ck 2=2E21=2E0<br><br>- Fix several constVariablePointer issues that<br>  we=
re newly reported<br>- Fix one unreadVariable issue that was newly<br>  rep=
orted<br>- Remove --showtime=3Dsummary from cppcheck args<br>  again, it is=
 now much more verbose<br><br>Change-Id: I6693b5aa2988102f5e7884a65119ebfc8=
7dd07e1<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1954<br>Message-Id: &lt;202610031=
75529=2E6360-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archi=
ve=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39671=2Ehtml<br>Signed-=
off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M dev-tools/=
run-cppcheck=2Esh<br>M src/openvpn/dco=2Ec<br>M src/openvpn/mudp=2Ec<br>M s=
rc/openvpn/pkcs11_openssl=2Ec<br>M src/openvpn/socks=2Ec<br>M tests/unit_te=
sts/openvpn/siphash_openssl=2Ec<br>6 files changed, 5 insertions(+), 8 dele=
tions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/dev-tools/run-cppcheck=2Esh b/dev-to=
ols/run-cppcheck=2Esh</span><br><span>index ad012ac=2E=2E3c71c83 100755</sp=
an><br><span>--- a/dev-tools/run-cppcheck=2Esh</span><br><span>+++ b/dev-to=
ols/run-cppcheck=2Esh</span><br><span>@@ -33,7 +33,7 @@</span><br><span>  -=
-suppress-xml=3D${SCRIPT_DIR}/cppcheck-suppressions=2Exml --inline-suppr \<=
/span><br><span>  --cppcheck-build-dir=3D${CPPCHECK_DIR} \</span><br><span>=
  --check-level=3D${CPPCHECK_CHECK_LEVEL} --max-configs=3D10 \</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- --error-exitcode=3D1 --showtime=
=3Dsummary&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ --=
error-exitcode=3D1&quot;</span><br><span> </span><br><span> set -x</span><b=
r><span> </span><br><span>diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dc=
o=2Ec</span><br><span>index 6d88f6f=2E=2E9fc0e3b 100644</span><br><span>---=
 a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</span><br>=
<span>@@ -534,7 +534,7 @@</span><br><span>     ASSERT(sock-&gt;info=2Econne=
ction_established);</span><br><span> </span><br><span>     struct sockaddr =
*remoteaddr =3D &amp;sock-&gt;info=2Elsa-&gt;actual=2Edest=2Eaddr=2Esa;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct tls_multi *mul=
ti =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span>=
<br><span> #ifdef TARGET_FREEBSD</span><br><span>     /* In Linux in P2P mo=
de the kernel automatically removes an existing peer</span><br><span>      =
* when adding a new peer=2E FreeBSD needs to explicitly be told to do that =
*/</span><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec=
</span><br><span>index 4794b7e=2E=2E2b08ada 100644</span><br><span>--- a/sr=
c/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><sp=
an>@@ -316,10 +316,9 @@</span><br><span> multi_get_instance_udp_real(struct=
 multi_context *m, struct mroute_addr *real)</span><br><span> {</span><br><=
span>     struct hash *hash =3D m-&gt;hash;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    struct hash_element *he;</span><br><span>     con=
st uint64_t hv =3D hash_value(hash, real);</span><br><span>     struct hash=
_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    he =3D hash_lookup_fast(hash, bucket, real, hv);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct hash=
_element *he =3D hash_lookup_fast(hash, bucket, real, hv);</span><br><span>=
     if (he)</span><br><span>     {</span><br><span>         return he-&gt;=
value;</span><br><span>diff --git a/src/openvpn/pkcs11_openssl=2Ec b/src/op=
envpn/pkcs11_openssl=2Ec</span><br><span>index 69c5a50=2E=2E24dce84 100644<=
/span><br><span>--- a/src/openvpn/pkcs11_openssl=2Ec</span><br><span>+++ b/=
src/openvpn/pkcs11_openssl=2Ec</span><br><span>@@ -184,7 +184,6 @@</span><b=
r><span>         {</span><br><span>             tbs =3D buf;</span><br><spa=
n>             tbslen =3D (size_t)buflen;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            sigalg=2Eop =3D &quot;Sign&quot;;</span><br=
><span>         }</span><br><span>         else</span><br><span>         {<=
/span><br><span>diff --git a/src/openvpn/socks=2Ec b/src/openvpn/socks=2Ec<=
/span><br><span>index 19f3d54=2E=2E65ecb3c 100644</span><br><span>--- a/src=
/openvpn/socks=2Ec</span><br><span>+++ b/src/openvpn/socks=2Ec</span><br><s=
pan>@@ -323,8 +323,7 @@</span><br><span>         return port;</span><br><sp=
an>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    struct servent *service;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    service =3D getservbyname(servname, NULL);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const struct servent *service =
=3D getservbyname(servname, NULL);</span><br><span>     if (service)</span>=
<br><span>     {</span><br><span>         return service-&gt;s_port;</span>=
<br><span>diff --git a/tests/unit_tests/openvpn/siphash_openssl=2Ec b/tests=
/unit_tests/openvpn/siphash_openssl=2Ec</span><br><span>index c301f2d=2E=2E=
99a7763 100644</span><br><span>--- a/tests/unit_tests/openvpn/siphash_opens=
sl=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/siphash_openssl=2Ec</=
span><br><span>@@ -101,7 +101,7 @@</span><br><span> bool</span><br><span> s=
iphash_openssl_available(void *sip_context)</span><br><span> {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    struct siphash_context *sip =
=3D sip_context;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const struct siphash_context *sip =3D sip_context;</span><br><span> </span=
><br><span>     return (bool)(sip-&gt;mac);</span><br><span> }</span><br></=
pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1954?usp=3Demail">change 1954</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1954?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: I6693b5aa2988102f5e7884a65119ebfc87dd07e1 </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1954 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> =
Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Em=
uc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=


</body></html>
--MzmifVp1q+E=--


--===============4647091496617850451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4647091496617850451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4647091496617850451==--

