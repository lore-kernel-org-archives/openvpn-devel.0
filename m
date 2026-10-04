Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D863CA5FEC
	for <openvpn-devel@archiver.kernel.org>; Sun,  4 Oct 2026 08:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oVlGh/g+ckm2/8pd5xGO6XzqB5+c1ur8p3NuiApoirY=; b=BHrohldjiF9nEYxg8oi+RbkjUj
	aO2HhP+6J6zZJyp+OBdjFkU0Q2Nel62fsSbIl3YAgqRkFM98UXvEn7pokfdX3ZES9Jv0Z9ncwaSzy
	Bv6zWhtK/4oZ2UOwT2JJTVzinniTezk8SQ0+LjQ1xn5fM67DETY96ilJ6j3sEIs3BP8E=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDHtx-00045R-0e;
	Sun, 04 Oct 2026 08:48:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDHts-00043H-Dx
 for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 08:48:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=r1o1rPlt5SY7GDZMP5Fu35hKG5xZP45GBBCDXZfPE08=; b=G572ws2piw4oyFhypjtHQ1fW6c
 ngRZ7kr1qWkMiZvvbwsl5NiYjo23nAcAebdvqSGOKDblYzH+kQKYz0rGpJ8QJ/LzvzszFcvR9k0NV
 gaYP7oHPNT4lFzS8jlh06X27R//lIlbQjwvdQ7ecIV0+TIVhR84V7PCI+0DF/S41RUik=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=r1o1rPlt5SY7GDZMP5Fu35hKG5xZP45GBBCDXZfPE08=; b=S
 +x7OwjlliTpYQgqVH7CISGJRrZ8b1WJIvG9wOvNWgU+wfiA17Bi/GQNiCIzygOTELtsl5n5LfRHOO
 ufFj1e5FCLz0dcGjIyf/Zysy9giyVnNVsAWb+tyoC/sguB3QjzfUpEFWcc1Dav5OTSANwT12eMrK3
 j9frTRawmCEe28Ro=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDHto-0001z5-GO for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 08:48:49 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cd5462b69so5402825e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 04 Oct 2026 01:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791103722; x=1791708522; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=r1o1rPlt5SY7GDZMP5Fu35hKG5xZP45GBBCDXZfPE08=;
 b=DzxOlolM3MpL9Whqy5KJmPCIAw30Q0hGeWv6TKJaCqncmr1HUNpftPaFPhE8AWF5Qc
 wFepqmhk5k6OQ3nwRliT8QCEJG+1/t3ipoyuSDhOvDoYkdSUvG3sT1M1ITERdpey5I9L
 2lVNNqtyeh0eR37o+Zk7sP5x+mSN3yteUpFi5A4OgR+HD6cQe08ckTSjfraF6Qyt5g+O
 KXZbIFynyX1gdEFuGm5AGVdXPByub0fn83y0A1d2cZ2C9Q5/rpmtJq4yHhdXGC32DB6p
 KpzhLxZ6fIqNyFPNg6k6GdZqS42fPyDl9TBZcN0VKWrLpNQsAsHo3wJxgYIOlyCsRf0J
 hnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791103722; x=1791708522;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=r1o1rPlt5SY7GDZMP5Fu35hKG5xZP45GBBCDXZfPE08=;
 b=1pdOL1mrz1T0cjaRk1l83U6CQ+aLtvpDK7pqrcoO2/GIb71+guOevadlD/lQRxq3SN
 ad12D3GdUzYXVqfiMnYFT+ytGBAtqU9++6XJ7Bh/vepBEr3hGMm0mVWtTRmTFcGSd/Yy
 lWvakKBs8DulVwzBAxduOCmwPJQWP3wDyUQd0PZ/SwpGT3UMU2BnNJcG/ZAxaSpn7IJJ
 YhOIV91Tg23qqF7aBcQgGYeXkJ8WRGuFUl5uVNAoAHEvirhOqhvPc5AjCZlRFv4p5swY
 hR/GfvCwlUg4GNPyrf3mWDqeoLE2cqQPqrmZNMWXc7o600fTIzeTtk66rJPcWvi8ioAJ
 WO0Q==
X-Gm-Message-State: AFuF++l9oDfmzCp5ktVr/NA7zAmfCqc9ZOXSDT2GndednWqn2T42Qvlj
 6jlDquuPMmq5O4hdmeTW2FijkWBAivzkwA6MAfUCyvJqLVcCfmCbA3zJOFWhWwuaDMUi96m1AMM
 qc8fO95tkvM7JHHr1F008Okf7eG7Khzhwwe6g9bOhY/mT+KpY3QO1GW9Y3SbGT4zmSW2V
X-Gm-Gg: AYBFou0ZOcrUn23pwMV0U1Wk5Yamrn2s5OmdDmlXVqgKakCLZSKQIcsZOCdyp7/a/o8
 ftMm28QKb/1+oE35CcM25NRh6f0nqsVVfKfd4OetUjNXApJVS21AjW5jwu7UMaVMv5lSbOgNUtG
 nqE0z7237thchr1S8vywdDFEQ9B9mYIXiVbPeF+jSOhBuUEDBvSvXmnjtlINaaVt4zuiMZOrTSK
 dBhvJ0eU/mRWRVSJrh5oU7L+NDYZMHGlesOc/ki8gOtfPFr4Sg0yOkB/01R8lCHN8gXA5u+BjH0
 hedc2N9QOX8oky5dKYFqoGTSjkVsu7fBtmVGK6aWQc6t2tBWQ5yN5yObbg7sr2R6KTSNjLoJB1u
 RlFKCZY7ka6ZtKr4H9zOnAAQ5c7zZdOeBwPfJYT6lxy+vKxYNYa5IDWpcf+KHyw3dVM17o97eM6
 sbbfBkYtv2xTucA1qNLVbA4vMdjiGJbJxvxuVIB7NpiS4uixDJiqGE8WRCWYo5/jALogDlhnVUC
 7ttgbzt+ckVjyR0S8mksK9nByqshVVNerOXhs+biw++fuyiGqKMrMfkJ0uoRpq5JRadCJM3XjxZ
 llZv1LzkxlnMazoRwH9YPI+bkIehNQYAjIecJGn2UJ89MiR7B+wCnMLXCzShaMZe61j6OZQ=
X-Received: by 2002:a05:600c:b85:b0:4a0:313:3a12 with SMTP id
 5b1f17b1804b1-4a02759b47amr120713195e9.20.1791103721762; 
 Sun, 04 Oct 2026 01:48:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0316b2524sm278747295e9.1.2026.10.04.01.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 01:48:41 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 4 Oct 2026 08:48:40 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I6693b5aa2988102f5e7884a65119ebfc87dd07e1
X-Gerrit-Change-Number: 1954
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1954?usp=email>
X-Gerrit-Commit: 7f1dfa99fd1e7e609abeff7f331face61dbcbeaa
In-Reply-To: <gerrit.1790354422000.I6693b5aa2988102f5e7884a65119ebfc87dd07e1@gerrit.openvpn.net>
References: <gerrit.1790354422000.I6693b5aa2988102f5e7884a65119ebfc87dd07e1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzU0NDIyMDAwLkk2NjkzYjVhYTI5ODgxMDJmNWU3ODg0YTY1MTE5ZWJmYzg3ZGQwN2UxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d3086f8e4a7538bd1721a6985b55ef45f704d786-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDHto-0001z5-GO
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8378148894657537404=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8378148894657537404==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="t3CKxJdWAb8="; charset=UTF-8

--t3CKxJdWAb8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#4) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
954?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by Gert Doering


Change subject: Fix various issues found by =
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


  git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/54/1954/4

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

Gerrit-MessageType: newpatchset
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6693b5aa2988102f5e7884=
a65119ebfc87dd07e1
Gerrit-Change-Number: 1954
Gerrit-PatchSet: 4
Gerrit-Own=
er: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Gert Doeri=
ng <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>

--t3CKxJdWAb8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #4</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1954?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Fix va=
rious issues found by cppcheck 2=2E21=2E0<br><br>- Fix several constVariabl=
ePointer issues that<br>  were newly reported<br>- Fix one unreadVariable i=
ssue that was newly<br>  reported<br>- Remove --showtime=3Dsummary from cpp=
check args<br>  again, it is now much more verbose<br><br>Change-Id: I6693b=
5aa2988102f5e7884a65119ebfc87dd07e1<br>Signed-off-by: Frank Lichtenheld &lt=
;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Em=
uc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1954<=
br>Message-Id: &lt;20261003175529=2E6360-1-gert@greenie=2Emuc=2Ede&gt;<br>U=
RL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Ene=
t/msg39671=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt;<br>---<br>M dev-tools/run-cppcheck=2Esh<br>M src/openvpn/dco=2Ec<br>M=
 src/openvpn/mudp=2Ec<br>M src/openvpn/pkcs11_openssl=2Ec<br>M src/openvpn/=
socks=2Ec<br>M tests/unit_tests/openvpn/siphash_openssl=2Ec<br>6 files chan=
ged, 5 insertions(+), 8 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/54/1954/4</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh</span><=
br><span>index ad012ac=2E=2E3c71c83 100755</span><br><span>--- a/dev-tools/=
run-cppcheck=2Esh</span><br><span>+++ b/dev-tools/run-cppcheck=2Esh</span><=
br><span>@@ -33,7 +33,7 @@</span><br><span>  --suppress-xml=3D${SCRIPT_DIR}=
/cppcheck-suppressions=2Exml --inline-suppr \</span><br><span>  --cppcheck-=
build-dir=3D${CPPCHECK_DIR} \</span><br><span>  --check-level=3D${CPPCHECK_=
CHECK_LEVEL} --max-configs=3D10 \</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- --error-exitcode=3D1 --showtime=3Dsummary&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ --error-exitcode=3D1&quot;</span>=
<br><span> </span><br><span> set -x</span><br><span> </span><br><span>diff =
--git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</span><br><span>index 6d8=
8f6f=2E=2E9fc0e3b 100644</span><br><span>--- a/src/openvpn/dco=2Ec</span><b=
r><span>+++ b/src/openvpn/dco=2Ec</span><br><span>@@ -534,7 +534,7 @@</span=
><br><span>     ASSERT(sock-&gt;info=2Econnection_established);</span><br><=
span> </span><br><span>     struct sockaddr *remoteaddr =3D &amp;sock-&gt;i=
nfo=2Elsa-&gt;actual=2Edest=2Eaddr=2Esa;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct tls_m=
ulti *multi =3D c-&gt;c2=2Etls_multi;</span><br><span> #ifdef TARGET_FREEBS=
D</span><br><span>     /* In Linux in P2P mode the kernel automatically rem=
oves an existing peer</span><br><span>      * when adding a new peer=2E Fre=
eBSD needs to explicitly be told to do that */</span><br><span>diff --git a=
/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 4794b7e=
=2E=2E2b08ada 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><=
span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -316,10 +316,9 @@</span>=
<br><span> multi_get_instance_udp_real(struct multi_context *m, struct mrou=
te_addr *real)</span><br><span> {</span><br><span>     struct hash *hash =
=3D m-&gt;hash;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
ruct hash_element *he;</span><br><span>     const uint64_t hv =3D hash_valu=
e(hash, real);</span><br><span>     struct hash_bucket *bucket =3D hash_buc=
ket(hash, hv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    he =
=3D hash_lookup_fast(hash, bucket, real, hv);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const struct hash_element *he =3D hash_lookup=
_fast(hash, bucket, real, hv);</span><br><span>     if (he)</span><br><span=
>     {</span><br><span>         return he-&gt;value;</span><br><span>diff =
--git a/src/openvpn/pkcs11_openssl=2Ec b/src/openvpn/pkcs11_openssl=2Ec</sp=
an><br><span>index 69c5a50=2E=2E24dce84 100644</span><br><span>--- a/src/op=
envpn/pkcs11_openssl=2Ec</span><br><span>+++ b/src/openvpn/pkcs11_openssl=
=2Ec</span><br><span>@@ -184,7 +184,6 @@</span><br><span>         {</span><=
br><span>             tbs =3D buf;</span><br><span>             tbslen =3D =
(size_t)buflen;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      sigalg=2Eop =3D &quot;Sign&quot;;</span><br><span>         }</span><b=
r><span>         else</span><br><span>         {</span><br><span>diff --git=
 a/src/openvpn/socks=2Ec b/src/openvpn/socks=2Ec</span><br><span>index 19f3=
d54=2E=2E65ecb3c 100644</span><br><span>--- a/src/openvpn/socks=2Ec</span><=
br><span>+++ b/src/openvpn/socks=2Ec</span><br><span>@@ -323,8 +323,7 @@</s=
pan><br><span>         return port;</span><br><span>     }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct servent *=
service;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    service =
=3D getservbyname(servname, NULL);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const struct servent *service =3D getservbyname(servname=
, NULL);</span><br><span>     if (service)</span><br><span>     {</span><br=
><span>         return service-&gt;s_port;</span><br><span>diff --git a/tes=
ts/unit_tests/openvpn/siphash_openssl=2Ec b/tests/unit_tests/openvpn/siphas=
h_openssl=2Ec</span><br><span>index c301f2d=2E=2E99a7763 100644</span><br><=
span>--- a/tests/unit_tests/openvpn/siphash_openssl=2Ec</span><br><span>+++=
 b/tests/unit_tests/openvpn/siphash_openssl=2Ec</span><br><span>@@ -101,7 +=
101,7 @@</span><br><span> bool</span><br><span> siphash_openssl_available(v=
oid *sip_context)</span><br><span> {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    struct siphash_context *sip =3D sip_context;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const struct siphash_contex=
t *sip =3D sip_context;</span><br><span> </span><br><span>     return (bool=
)(sip-&gt;mac);</span><br><span> }</span><br></pre><p>To view, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1954?usp=3Demail">change 19=
54</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1954?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I6693b5aa2988102f5e7884a65119ebfc87dd07e1 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1954 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Li=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--t3CKxJdWAb8=--


--===============8378148894657537404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8378148894657537404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8378148894657537404==--

