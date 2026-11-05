Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CCB606A326
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=nEpsZp3b;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=a6u5MkK4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FMb3ETLi;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ard3qVgT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hkcvLqKtSPLOyELVxWlxjaKbehyGdaK6R6AqaoqfPYY=; b=nEpsZp3br/a2xoosFuW6nWIxGD
	jSMq7NP2Bk9pXFi2T/XsFGr5eh+ek4fiKc36qmX6IC/NR9B91mkzjAHpaDtJUtnt+RrljjNRx4y8+
	PZ8e4L4RmzVSh5ARu7XsGXVwbkM8zf1Dchs+uEyHhmrZ4AkDVIXesAjCaY80HMuAYRes=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xP0fr-000000001v4-1tDj;
	Thu, 05 Nov 2026 16:50:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xP0fq-000000001ux-2FCc
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 16:50:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8DBWhx0fzckKRq1T4wFysKCRYkmbcmWXVeLbutPC4BM=; b=a6u5MkK4tQLC/qPeBlouOA7/XB
 40UFy0qw5ytkLOB2BX24Jvk8nuY3sGlNrCaLy8RiuVzzpItDdqwKfKSEyKVbEqjFtcpBqJQziqEhv
 Ag5eQTQS29TcwebxUq8t7MDe58UO51/9tfVfkbDBPyXiHXQItHfPuJwAPgR6V1/B8v6A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8DBWhx0fzckKRq1T4wFysKCRYkmbcmWXVeLbutPC4BM=; b=FMb3ETLiu4xu7HF2YvdgSr7dux
 OqF+3ppkCKHlgt6LtmYU/I9Kl3ljR1wCaKHj3BwJvW31ZjuZf2sFKuUxK1JSCglFvhAlZXDGOhi5K
 UB1WF9jEF92Wuv1+SzebuLgC9NaSe7/8rVXng4ZpiP/ut0yW/GGHYqWWrkiJxmlIEHDs=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xP0fo-0000000078I-3XTq for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 16:50:50 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so16425835e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 08:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793897442; x=1794502242; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8DBWhx0fzckKRq1T4wFysKCRYkmbcmWXVeLbutPC4BM=;
 b=ard3qVgTT/c8TYDDrhEEir3tnJzRBAwIyOrczZ6mx8fFqxdCV0I6QnMOX3z8HjNmcS
 390z2oKkxisuNkrB+9D6/9e5sDnqXK4YHV7tFvT+0UWJgl8EiW31MN1yi9oVFHsGu+gT
 N+i6jqZZXsR3g1wIi/q7dPb0/bLckibonGlSfECWXIzOpwMEcTS92PgJsOOqhZOxYBRX
 kt/SDaqWdYDuSVzrAnCveJvtqt8mww1upPDjLhAAzyBaenyQJ7Felv7CHH+DKEQroU6q
 emYmzAZwk+ZWCM+RsJ5KiHSYHqcgU625NggTu+0JzNxt9hmGk/jo8TtKcTR5YJcQhd+9
 YN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793897442; x=1794502242;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8DBWhx0fzckKRq1T4wFysKCRYkmbcmWXVeLbutPC4BM=;
 b=OK45g7I6djkPs1hWehGXgXuSJIjU9ndPqFB3AgnkgguW7opb2TzLNLn/PdI3RbQBK0
 fdG1/DENd2eZfVLDnMHrPvPAY8yVCtcCUBzM0V28pVPzC/8o9uFdkdiFc5pV+p+6KcFw
 mNqfNwBIPu47Z3Z5V70WTbcnNlxnZuudj4CgX7PmQhFiU/VVtQgbzy4WESGjLFUlM4iU
 7cWPh6bxwQzXF8TGcYoP/w2UdiZItjOE1FWQa1pWx8yBkhcRL9287kl3A5vdkmY6jKY0
 PHwULVPZThFufhT1AArDSp6nakywnznSG9UGsppxJKUdARrOIHB/2PSZ5e/WeYV98Kus
 Ms5w==
X-Gm-Message-State: APuU4Z/KSJ8qzzBBkn8q3s+r0islupB5M0BpRdiDVHnOH5QVsRRlb11B
 WwfFp7FhY/97x1iRLTqqZhs7hy9hx8nC3wrQ898zIr7PPnsz6pYi/LMenRd9TG6p1P+tB3pFTES
 gPqqQhrUgu3Mxe+WSnwTZciZJve6xm1/rTfOPOilDPGchNwrnE4Qnu4GX4h4lOViwKa9g
X-Gm-Gg: AYBFou1xN34beREGAVB6keVoLZajWEqz3fQl3IqFjiDqCTWpYCmBKewtTkT0+mcoXhq
 UgRrgb02xkjajAM6v5bNSZgYTMsLvmnI2EiOWc/9XzOiBs6uG+zcFOm7TFDF8JPyuKHw5Q6M7P2
 m0ldfnogwUpinQbuCbfU833tBwoF0OMSmYk2p+g7J4+D0KjEbk+DdISRh57kUUs7/PHziBdA84r
 cGXu7nk9/e/2Y98OQzi6i614fX5uxi1q44IKCsFbD9wn3l8u1bnYkYmMmtzPxjlH50SAS/ObOK9
 UbMV6Rr5GCb0XWKRyHiYohGWAez25ZUfsmzWrd9/f1cXH0W77jlAZ1QhriwtM/TfhWKGYIyf7fJ
 Uf6MMgpGZ45qU02rYnO3tTRvCDGgZQlzhQ/6MVWi9t/ciKv+fIVwUhsJTXZVN8wVVs9gNL77iYV
 Wy4/v/Vpgs0zS3VMPt2Y4M6gaeOvJhHbvdFnf0N/oC4rSPmBwqNGivTJ2UYuZLtisgjR5yKI74B
 p8e/fFTVvYdMDCQhaYfco+2+lReA0KsI4EX0xEoDj4RXGzBYUU82Dxi/tU2tMz5w1ejtpgtPpRX
 0K7K+QvL36Z99ADuxxIYMiIx6ntzTUnOaj1wNh+pruIgoTbDUsChwbkXtV3STZN0PyZPPs1RPCk
 FLzObQXH8VCEchhyaLh7gyoZxRhrqcyy8i1VEIUCoK7OVQjclG0X4h8/5s2HUUXUoRbTIoxwYSF
 ZltYJ9JMZlZNtl9g==
X-Received: by 2002:adf:e189:0:b0:492:3176:3d78 with SMTP id
 ffacd0b85a97d-492765a3125mr340265f8f.17.1793897442048; 
 Thu, 05 Nov 2026 08:50:42 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fec9cd43bsm10757050f8f.14.2026.11.05.08.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 08:50:41 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 16:50:40 +0000
To: Hansaem Wi <hansaemw@gmail.com>, Steffan Karger <steffan@karger.me>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I4d35f54402460c5866aeba26216ac1b2d2f8ebdc
X-Gerrit-Change-Number: 2075
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2075?usp=email>
X-Gerrit-Commit: da6659452a34b5c94b20f55cbeb96b9ba70885ad
In-Reply-To: <gerrit.1793496732000.I4d35f54402460c5866aeba26216ac1b2d2f8ebdc@gerrit.openvpn.net>
References: <gerrit.1793496732000.I4d35f54402460c5866aeba26216ac1b2d2f8ebdc@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDk2NzMyMDAwLkk0ZDM1ZjU0NDAyNDYwYzU4NjZhZWJhMjYyMTZhYzFiMmQyZjhlYmRjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9f97c0dc7538ee66e12f1fca3101d301720226c3-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xP0fo-0000000078I-3XTq
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl: Wipe the key
 source material in key_state_free()
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============9100233549771155161=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9100233549771155161==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nx2nMD07dKI="; charset=UTF-8

--nx2nMD07dKI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Hansaem Wi=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2075?usp=
=3Demail )

The following approvals got outdated and were removed:
Code-Rev=
iew+2 by Steffan Karger


Change subject: ssl: Wipe the key source material=
 in key_state_free()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

ssl: Wipe the key source material in key_state_free()

ks->key_src =
holds the pre_master and random values that the peers
exchange in key metho=
d 2=2E It is wiped after the data channel keys have
been generated and on t=
he error paths of key_method_2_read() and
key_method_2_write()=2E When a ke=
y state is freed before the keys are
generated, for example because an --au=
th-user-pass-verify script or a
client-connect script rejects the client, k=
ey_state_free() frees it
with plain free() and the key material stays in fr=
eed memory, on the
server and on the client=2E

Wipe it with secure_memzero=
() before freeing it=2E

Assisted-by: Claude Code:claude-opus-5-5
Change-Id=
: I4d35f54402460c5866aeba26216ac1b2d2f8ebdc
Signed-off-by: Hansaem Wi <hans=
aemw@gmail=2Ecom>
Acked-by: Steffan Karger <steffan@karger=2Eme>
Gerrit URL=
: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2075
Message-Id: <202611050937=
20=2E11781-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom=
/openvpn-devel@lists=2Esourceforge=2Enet/msg40746=2Ehtml
Signed-off-by: Ger=
t Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/ssl=2Ec
1 file change=
d, 4 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/75/2075/2

diff --git a/src/openvpn/ssl=2Ec b/=
src/openvpn/ssl=2Ec
index b701c0a=2E=2E420daef 100644
--- a/src/openvpn/ssl=
=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -930,6 +930,10 @@
 
     free(ks->rec_ack=
);
     free(ks->lru_acks);
+    if (ks->key_src)
+    {
+        secure_me=
mzero(ks->key_src, sizeof(*ks->key_src));
+    }
     free(ks->key_src);
 
=
     packet_id_free(&ks->crypto_options=2Epacket_id);

-- 
To view, visit h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2075?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I4d35f54402460c5866aeba26216ac1b2d2f=
8ebdc
Gerrit-Change-Number: 2075
Gerrit-PatchSet: 2
Gerrit-Owner: Hansaem W=
i <hansaemw@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--nx2nMD07dKI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Hans=
aem Wi=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2075?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by Steffan Karger</p><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">ssl: Wipe t=
he key source material in key_state_free()<br><br>ks-&gt;key_src holds the =
pre_master and random values that the peers<br>exchange in key method 2=2E =
It is wiped after the data channel keys have<br>been generated and on the e=
rror paths of key_method_2_read() and<br>key_method_2_write()=2E When a key=
 state is freed before the keys are<br>generated, for example because an --=
auth-user-pass-verify script or a<br>client-connect script rejects the clie=
nt, key_state_free() frees it<br>with plain free() and the key material sta=
ys in freed memory, on the<br>server and on the client=2E<br><br>Wipe it wi=
th secure_memzero() before freeing it=2E<br><br>Assisted-by: Claude Code:cl=
aude-opus-5-5<br>Change-Id: I4d35f54402460c5866aeba26216ac1b2d2f8ebdc<br>Si=
gned-off-by: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt;<br>Acked-by: Steffan K=
arger &lt;steffan@karger=2Eme&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2075<br>Message-Id: &lt;20261105093720=2E11781-1-gert@gr=
eenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg40746=2Ehtml<br>Signed-off-by: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>1 file ch=
anged, 4 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/75/2075/2</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index=
 b701c0a=2E=2E420daef 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</spa=
n><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -930,6 +930,10 @@<=
/span><br><span> </span><br><span>     free(ks-&gt;rec_ack);</span><br><spa=
n>     free(ks-&gt;lru_acks);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (ks-&gt;key_src)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        secure_memzero(ks-&gt;key_src, sizeof(*ks-&gt;key_src));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     fre=
e(ks-&gt;key_src);</span><br><span> </span><br><span>     packet_id_free(&a=
mp;ks-&gt;crypto_options=2Epacket_id);</span><br></pre><p>To view, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2075?usp=3Demail">chang=
e 2075</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2075?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I4d35f54402460c5866aeba26216ac1b2d2f8ebdc </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2075 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Hansaem =
Wi &lt;hansaemw@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Steffan Karger &lt;steffan@karger=2Eme&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--nx2nMD07dKI=--


--===============9100233549771155161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9100233549771155161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9100233549771155161==--

