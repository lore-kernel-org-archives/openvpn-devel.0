Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA66606A330
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WMIXKDP5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=d+8UpPg9;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YCs2gRF8;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PqFG9sg9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=m1LgxABpH3R1KyPfHq1USvpVE8XXvktqQdVZDtRMOLk=; b=WMIXKDP5IJIYQQ124hJLAbWjCC
	HdR14efCRy34kEgG1a2M8abVmRdnmh/MU5q9NfTesjNEac+hGBbsj1cJ2+Fx3oAnMXV67Br9aqFew
	oWI6JrRhZQlrid0C1ahY2HpXEB8LLZa1AnR1YzhAhaVKgvhb56zkkWgqmvkJwoQLm1lg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNt2m-000000000th-2Sp8;
	Mon, 02 Nov 2026 14:29:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNt2l-000000000ta-2SX6
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:29:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZxSy3jtxVxQFme4c5aI/W/3vsxw6hcnjjZ9SY/N1zzQ=; b=d+8UpPg9xIL2yztXuwESQgQtfU
 cFnOFPlUzoPceqfPhuSzIFp3Be2MzPLoaAqCQMpOCWKS0+esRuMHHdB2EfiB8fqmfdFWNkQK/l1oA
 D0hZ+UwUxdKr6tIqYjD9ZQVoqIXSTf0/XnK6xNbQgKQsRyDPyWejCfuYV62CkJvMMjlQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZxSy3jtxVxQFme4c5aI/W/3vsxw6hcnjjZ9SY/N1zzQ=; b=YCs2gRF8CDIziVtS+QejvWvlBj
 yePonstbHNbly6t6acF+uFypMJt21laaq7C6oHGDPiavrWN2RkxX1bt7WG+TlbklWzaYo4mgsnyx9
 w7U0IeyobFOv3SP8wzjXi7cscf3NU6PSJhTyZROdiEBr4UB9a+ghfLVeBKgJL4JuHIUg=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNt2k-000000001cG-3urv for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:29:51 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48afbd2c386so1797652f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 06:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793629784; x=1794234584; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZxSy3jtxVxQFme4c5aI/W/3vsxw6hcnjjZ9SY/N1zzQ=;
 b=PqFG9sg9zmHnOR67GerZSkjpBUksTMxJaDdoXc1OcM3ZS/VSTxcnc9uNEgfW34d/n6
 Q6dJX0X+PY1DggY3ofQ6CUrqB4WtnKN0QR+WwVv6ccxwNwd4ttUqlTnE6/95b3vFo44K
 CgPmvl35QKSAccT60X6IaMLWWjNn3jwJRuH6F3lcee856fWocvF0z6bYm9DRvudpSgSm
 EEle40zbNE4ypKglVs4juFjaD+oGGhfRS8BJBAgqIuS4IRP+d+Tb1dvz8ke3PfQ4tIJK
 Y6bD8SJHpCIrVtPrJEq37btigSp8gdig++vpVhyOaLqjBCWhzgmICAFtHfyGWeATD/Hr
 B+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793629784; x=1794234584;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZxSy3jtxVxQFme4c5aI/W/3vsxw6hcnjjZ9SY/N1zzQ=;
 b=PFdpfFbrz3AfX3qYOwAJVWsJP1IehjmThWl/hUXSoxQVB9Ns1qRs76zaYs8wvQCf8w
 3ZEJa3dyryVNI0ao1CX+dhDdZdpdPLBgW3cX6T9ahkWdWoOZBnuCohGdZvADpifUQ5LG
 vjq0RBzr9/BHNMsPafdYXZT5kz2iQ9xHXPYFnGz7KyF/0TvmRwVbB5tig7zSqKH1409b
 wtP6cU7vBzsyczvS9Pzgja8mlRG+SKDkrOcrUAUz8uh8OQ5nD/A59JhGyer7WaQHwjQB
 ZsHevBMRhjoPScnycYxXqqInWycjqi5/lUCaD8+YaZ5JfqP7J11FX5w17m7oJRxbJhuW
 EuEQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzzU6tm7oVH66lKXAXWkKGMutHDbNPiHMb3wUjZUmZZNSfipGqcGA1Zb6p8rKg68xcSPbhLxNhLgUEK54mu@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9rFALOVFy+XB3i4IlDj7wi1mWGMjvLrcEFJ7be6r6SMG6HuBrD
 4iJSupD1JQIAqL6tXf7XHZPkoM533adk120jjfesuzyKw1yINL+jNRwFJ71sGduXRuu+xPTfMSa
 XYwav32VPe++6CoKbPhuRirIEq+zhRW3pJCwuDx/k1fCYbZYFrKw+xcBd+Hz5YsL5q3/I
X-Gm-Gg: AYBFou0D41m7PpLf7qKqFUZJcV26ywRbpKzcLj7w6W7bgBzf+F3krPXu+T7MBdCc7vw
 07vBbtHEhGW4Sj6rNoeS9jwNH1hqv5Qri9JV3ht42WU0CnFCl1XsVL5wzJ6K677WYJ3xsrCJ7AX
 QaVL3Zd82rIsrFPaeR/jH3hjSd/5uYKaZcQ4bvoyBqbSbaN1jS+m5gD4MTtzk/xOsaJ9ERkulIh
 v6uMEXp7oW+rkbGIijWKqQKDPV3caumludwmNuEEqu5rC8tfbN8wD5/jDKT2Ew8y30VermQlSAJ
 DYU1n1KT9YhvwZ4cgR6anuUBNIcjkBIsga0/z51i+uPdfCrOOyquGmQd/FPiAjXjo4YFEHYJ/HJ
 o5ZvupfsQVLvGcCedmWVDk5XxEL/2vnOWMw9zj7kDPkJARcTVfBJOpN7fl85TEekxmk6nmmtWnb
 IOOsjQPxex4T4oxb5UD47Ai/CxiI7MZgoDwQID68pts5xLPFeF3ocx8MHITW/896KfC3kPPvgFD
 WTALHLVPxjW6LjZtmnNTFJUNWz3fl/OrJ55EYdIVkwJMi8I5QWiObjBeAznYSoR4Tf/Y+nGJTMl
 4fGH8tSh9EYEW7Fn7rr9LAQMQ9zAG1NLHIaIi00XkIRsDBHyi6Sqs1P1Tc9RJFBonwowzTZgo6B
 TE1aJr9ceGlg2eiXT4r7pdTFE1Wa2e7396KAevUqpio83Ii0g8m7ys0/hpqyFTVD2T6v8KhbW4n
 HOF5t8rw55WKs/SQ==
X-Received: by 2002:adf:e003:0:20b0:48b:5e2:52dd with SMTP id
 ffacd0b85a97d-48e6e2f66e4mr17152788f8f.11.1793629783938; 
 Mon, 02 Nov 2026 06:29:43 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba4ac6sm21654857f8f.52.2026.11.02.06.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 06:29:43 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 14:29:42 +0000
To: Hansaem Wi <hansaemw@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I6b42785de99ee1e6b555d8c5e61ebe2ae784510e
X-Gerrit-Change-Number: 2077
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2077?usp=email>
X-Gerrit-Commit: 21c8a682755c425c0830d25cc33643545d479514
In-Reply-To: <gerrit.1793496782000.I6b42785de99ee1e6b555d8c5e61ebe2ae784510e@gerrit.openvpn.net>
References: <gerrit.1793496782000.I6b42785de99ee1e6b555d8c5e61ebe2ae784510e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDk2NzgyMDAwLkk2YjQyNzg1ZGU5OWVlMWU2YjU1NWQ4YzVlNjFlYmUyYWU3ODQ1MTBlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <102b920930caf915a893f2941467592748bdd022-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNt2k-000000001cG-3urv
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: crypto_openssl:
 Clear PEM decoded key data before freeing it
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, hansaemw@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============9134435477826480448=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9134435477826480448==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="k99LAuDT+4I="; charset=UTF-8

--k99LAuDT+4I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2077?usp=3Demail )

Change subject: crypto_openssl: Clear PEM d=
ecoded key data before freeing it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

crypto_openssl: Clear PEM decoded key data before fr=
eeing it

crypto_pem_decode() decodes the tls-crypt-v2 client and server ke=
ys
and the auth-token key, and frees the decoded key bytes it got from
PEM_=
read_bio() with OPENSSL_free()=2E Clear them with OPENSSL_cleanse()
first=
=2E OPENSSL_clear_free() would do both in one call, but LibreSSL
does not p=
rovide it=2E

Assisted-by: Claude Code:claude-opus-5-5
Change-Id: I6b42785d=
e99ee1e6b555d8c5e61ebe2ae784510e
Signed-off-by: Hansaem Wi <hansaemw@gmail=
=2Ecom>
Acked-by: Steffan Karger <steffan@karger=2Eme>
Gerrit URL: https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2077
Message-Id: <20261102131404=2E21605=
-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-d=
evel@lists=2Esourceforge=2Enet/msg40430=2Ehtml
Signed-off-by: Gert Doering =
<gert@greenie=2Emuc=2Ede>
---
M src/openvpn/crypto_openssl=2Ec
1 file chang=
ed, 1 insertion(+), 0 deletions(-)




diff --git a/src/openvpn/crypto_open=
ssl=2Ec b/src/openvpn/crypto_openssl=2Ec
index e6abd8f=2E=2E3c708c2 100644
=
--- a/src/openvpn/crypto_openssl=2Ec
+++ b/src/openvpn/crypto_openssl=2Ec
@=
@ -528,6 +528,7 @@
 cleanup:
     OPENSSL_free(name_read);
     OPENSSL_fre=
e(header_read);
+    OPENSSL_cleanse(data_read, data_read_len);
     OPENSS=
L_free(data_read);
     if (!BIO_free(bio))
     {

-- 
To view, visit http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I6b42785de99ee1e6b555d8c5e61ebe2ae784510e
Ge=
rrit-Change-Number: 2077
Gerrit-PatchSet: 3
Gerrit-Owner: Hansaem Wi <hansa=
emw@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: S=
teffan Karger <steffan@karger=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>

--k99LAuDT+4I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2077?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">crypto_openssl: Clear PEM decoded =
key data before freeing it<br><br>crypto_pem_decode() decodes the tls-crypt=
-v2 client and server keys<br>and the auth-token key, and frees the decoded=
 key bytes it got from<br>PEM_read_bio() with OPENSSL_free()=2E Clear them =
with OPENSSL_cleanse()<br>first=2E OPENSSL_clear_free() would do both in on=
e call, but LibreSSL<br>does not provide it=2E<br><br>Assisted-by: Claude C=
ode:claude-opus-5-5<br>Change-Id: I6b42785de99ee1e6b555d8c5e61ebe2ae784510e=
<br>Signed-off-by: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt;<br>Acked-by: Ste=
ffan Karger &lt;steffan@karger=2Eme&gt;<br>Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2077<br>Message-Id: &lt;20261102131404=2E21605-1-ger=
t@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-d=
evel@lists=2Esourceforge=2Enet/msg40430=2Ehtml<br>Signed-off-by: Gert Doeri=
ng &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/crypto_openssl=
=2Ec<br>1 file changed, 1 insertion(+), 0 deletions(-)<br><br></pre>
<pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/crypto_openssl=2Ec b/src/openvpn/crypto_openssl=2Ec</=
span><br><span>index e6abd8f=2E=2E3c708c2 100644</span><br><span>--- a/src/=
openvpn/crypto_openssl=2Ec</span><br><span>+++ b/src/openvpn/crypto_openssl=
=2Ec</span><br><span>@@ -528,6 +528,7 @@</span><br><span> cleanup:</span><b=
r><span>     OPENSSL_free(name_read);</span><br><span>     OPENSSL_free(hea=
der_read);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OPENS=
SL_cleanse(data_read, data_read_len);</span><br><span>     OPENSSL_free(dat=
a_read);</span><br><span>     if (!BIO_free(bio))</span><br><span>     {</s=
pan><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2077?usp=3Demail">change 2077</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2077?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I6b42785de99ee1e6b555d8c5e61ebe2ae7845=
10e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2077 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doer=
ing &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>

</body></html>
--k99LAuDT+4I=--


--===============9134435477826480448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9134435477826480448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9134435477826480448==--

