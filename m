Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E651606A5A3
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HjccyMvG;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KIgIFmWS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ynnamyi1;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bBHS8P4H
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=aDNaXB+8hXW8CJiWRuDV/dePIfoMR5PUCxtnhjjP4EY=; b=HjccyMvGdvL70hHyI0ptrUhiXM
	eoYMFCgLyWNr/cZHzRTKdru51z/enHqcZVqSdbcLiNZbPifKFkND958YzaFISclP4C+1mrtBz//sE
	hgfU725mRHiLhRg2kfppQPtsZctciJtsxhovCxOnAKl5ShjMRj2zGfVYuJaU3lvnZuR4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNvvz-0000000025g-3VMW;
	Mon, 02 Nov 2026 17:35:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNvvy-0000000025a-3bYu
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 17:35:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O0OPjSUUhFe+xdqTJ9u1NmSQxqtaTy6CXGDxoiAwtR8=; b=KIgIFmWSUOW5Ucwb210qVwJJik
 V6twNXhmWrFho8u0L0fgnkMXgoSwrqkXIATOEt7NGsd5nN/x8pEsi2InO+eQttkjwxaDy+I5d0cXP
 OqjkI2Dch3Ti6SAIllEE5A/awIxTdZDEePmynt2n22PuA9R6d4W0I0EZDepdnipCq1u4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O0OPjSUUhFe+xdqTJ9u1NmSQxqtaTy6CXGDxoiAwtR8=; b=Ynnamyi17OE7Fqe0e7QFJ5sN0f
 o9wQeWaoKlAegquIX6rhhpccKtbREpPh2IKfKME01o6x+fGZ+AhhTB/4XYriB2GLeNmCvyqQyPdwV
 0lLZA6Pj2aXheDfYeZowtm3YxO4BmgyPAtwHG0/GIwFfFtpClQVDflsvC/ni+i1e9fcI=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNvvt-000000006p1-2ppn for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 17:35:02 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so26719305e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 09:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793640891; x=1794245691; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=O0OPjSUUhFe+xdqTJ9u1NmSQxqtaTy6CXGDxoiAwtR8=;
 b=bBHS8P4HBcQlYVgke53/Ukcc+7fPZHH+A5v/6D3JowXVf5GC4YfSxJHQ1V4GtZOsdD
 RS1iF6jt0FeQmi3EktPyUqu5ARmk3FW1dc+cPNWAma2qgt8uoZoAv13IeyBUo5deH7Z1
 CNhmgX/mkoLMCh7rOcOPOFkOVowGvumABWrpVajygqIaysd9aXwAkP683gPEpcq9jxiq
 A8SA6fl3gZs2vG+N19Omola0mox6tJxow/KeDoiFArJSTQOZF2EEUPGgA3BTqm7dD4gV
 gA60CT86QfumiaDIbWzpRP5rkegvZe50VtP9uZhqF64v67bZhg16oqZGp6KhSGC1K1ZB
 lJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793640891; x=1794245691;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=O0OPjSUUhFe+xdqTJ9u1NmSQxqtaTy6CXGDxoiAwtR8=;
 b=ia85qv09eHfuYP4/v2ihBMrQpsr31c7A0/b5o6DcnQjBXAPycKsVzfl6qC61D8oR/Q
 5x1sqN+JrWAEO/fwQ2IMldVAJ3QQJ7K/rIl7GDEGIMDRieMzntH0357iz9pgO8U0Eg/n
 E4STdf9g0evoh9dgL04d84DS+8ZNg1gRQsytIZt2gcKIMaDbuspDqG3OiUSQEQ9WZR4T
 J9fzi2hRLmyYM5fqKq/C89PmYUSgJ+O/7Nbp9+q4ev68ya6Le5JZ5UJ8OSbPhhyB/1JW
 u3HHEfAGx1l+FllqHV47GBnrNClvht8EpoWzklwRIRa+PmMW8EBgBlgUZmOwqm3cn7Xj
 dTkg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwRM7blgpbS2AYjmm1Cg0iWEOq35nfhlB3dO6Tmlgyo3P8ekMdwgtQGpz8IJGIFLcsQBXOIfMD0sdC/4+Z4@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKRQlhbdpvqAUQDewj0FVwwne46cafK5I1iPe5PlLA4EvoTW/4b
 jcCDSOkZTSH0toq3YOiUGCog8b42fwJrGvIiV/Fmf3LvScR11I4I/CHozwp7X3a4xwL8IQEyDAH
 zXYY81SRVlrbBUgcW2uNZrlHqJu/3+WWRNHbogngtNY9LND38M3LC/yJw02u2f6A3tWYD
X-Gm-Gg: AYBFou3tFRm+dj8lLXq1FYVrdjtMjnQpIjh0ItPebHnf1yem1SdJedXgE/oLDMXx1E2
 +n4CmBK6k7MQgPPyTkZIZcumOa0Eubn4CiKHyAjmTGRtAhyvBal5wBLDkeX4OPHFqipvpdbbOaE
 12yR6ZWPo/Yg57SLBtqVwK6cVSi1zBZaMG3pPPj3a1U8usbzKn1LWe2A2bLy5beZgTbW/B6sPQl
 j+KaQAySav8vYoDVWWdP2rjEnJV6IU35yLW2hrRRN66vtxL95j/JsbBuFOCj4EgUVeOc9Chvqu7
 9pAh5+UXZz+eH4bjHHBWTwdzj2bPHsXdobQWXkLnuJie+D5Xx296vdrKMe9EPnVnk66zisUHQFz
 IRtpEFZr56XkPYRfZ7zIKar9PsNNjM/H6HLqqY/zw724zIjgY5KTN1fzRqz/e0BDl4vVBOxDY83
 s4EqF/jMTo846g0jZRPPYde8e75yDPkYrTKyexD/cZVVdINBGFDxPiDFh7yda1ptobPyswlxR9W
 niLSwl18pvCGDmepKcKqtsOH78g00Sg0YaVoFB0G1s1dXg+k4vva/lFFkGLUgcvlSlNwnz0y9VQ
 ZjdemrFSxnib9/HH9GJhf4SAjwl+3v+9FWdLblKt3u/78zi1266zWe1gKQXRXlrPYaLyeybCHRs
 E/W6Q37tptlhallsLHN0/0D+/69zvlubC00d3DSqJVnsL78z7LN68yGjR52zirPU50Km8tkDBtD
 +LPEho8MBxi78QrfCzXG13t9PkG4QH7l6xw/c=
X-Received: by 2002:a05:600c:698d:b0:4a1:d97e:cd60 with SMTP id
 5b1f17b1804b1-4ac185bd1e2mr248173905e9.16.1793640891047; 
 Mon, 02 Nov 2026 09:34:51 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8bd8esm21214378f8f.42.2026.11.02.09.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 09:34:50 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 17:34:50 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb
X-Gerrit-Change-Number: 2085
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2085?usp=email>
X-Gerrit-Commit: 4e3fd977fc79e61635162117fde2513ebfda93d8
In-Reply-To: <gerrit.1793619070000.Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb@gerrit.openvpn.net>
References: <gerrit.1793619070000.Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE5MDcwMDAwLkliOTE2NGUxYzhmNWUwMmEyMjUzYmJiM2IyMzYzYTRmOWYzMWM4YmRiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e5453949b5ec03899c81eb38fda99b621e1523ec-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNvvt-000000006p1-2ppn
Subject: [Openvpn-devel] [S] Change in openvpn[master]: init: check
 parameters for NULL before strlen() in send_cc_message
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4022648025342007561=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4022648025342007561==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="B5g+5aP/i2Q="; charset=UTF-8

--B5g+5aP/i2Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2085?usp=3Demail )

Change subject: init: check parameters for =
NULL before strlen() in send_cc_message
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

init: check parameters for NULL before strlen(=
) in send_cc_message

management_callback_send_cc_message() called strlen(p=
arameters) before
its own NULL check=2E Only count parameters and the separ=
ator when set,
and drop the cppcheck suppression for it=2E

Change-Id: Ib91=
64e1c8f5e02a2253bbb3b2363a4f9f31c8bdb
Signed-off-by: Razvan Cojocaru <razva=
nc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2085
Message-Id: <20261=
102135736=2E27372-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archiv=
e=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40437=2Ehtml
Signed-off-=
by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M dev-tools/cppcheck-suppres=
sions=2Exml
M src/openvpn/init=2Ec
2 files changed, 5 insertions(+), 7 dele=
tions(-)




diff --git a/dev-tools/cppcheck-suppressions=2Exml b/dev-tools=
/cppcheck-suppressions=2Exml
index 33337cf=2E=2E926ecde 100644
--- a/dev-to=
ols/cppcheck-suppressions=2Exml
+++ b/dev-tools/cppcheck-suppressions=2Exml=

@@ -198,12 +198,6 @@
     <fileName>src/openvpn/dco_freebsd=2Ec</fileName>=

     <symbolName>buf</symbolName>
   </suppress>
-  <!-- IGN: strlen(NULL)=
 is not nice code, but seems to work -->
-  <suppress>
-    <id>nullPointer=
RedundantCheck</id>
-    <fileName>src/openvpn/init=2Ec</fileName>
-    <sy=
mbolName>parameters</symbolName>
-  </suppress>
   <!-- FP: cppcheck doesn'=
t understand ZeroMemory -->
   <suppress>
     <id>redundantAssignment</id>=

diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 24cf532=2E=
=2E6c87865 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ =
-299,7 +299,11 @@
 management_callback_send_cc_message(void *arg, const cha=
r *command, const char *parameters)
 {
     struct context *c =3D (struct c=
ontext *)arg;
-    size_t len =3D strlen(command) + 1 + strlen(parameters) =
+ 1;
+    size_t len =3D strlen(command) + 1;
+    if (parameters)
+    {
+=
        len +=3D 1 + strlen(parameters);
+    }
     if (len > PUSH_BUNDLE_=
SIZE)
     {
         return false;

-- 
To view, visit https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2085?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb
Gerrit-Change-Num=
ber: 2085
Gerrit-PatchSet: 5
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--B5g+5aP/i2Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2085?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">init: check parameters for NULL be=
fore strlen() in send_cc_message<br><br>management_callback_send_cc_message=
() called strlen(parameters) before<br>its own NULL check=2E Only count par=
ameters and the separator when set,<br>and drop the cppcheck suppression fo=
r it=2E<br><br>Change-Id: Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb<br>Sign=
ed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2085<br>Message-Id: &lt;20261102135736=2E27372=
-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/ope=
nvpn-devel@lists=2Esourceforge=2Enet/msg40437=2Ehtml<br>Signed-off-by: Gert=
 Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M dev-tools/cppcheck-sup=
pressions=2Exml<br>M src/openvpn/init=2Ec<br>2 files changed, 5 insertions(=
+), 7 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/dev-tools/cppcheck-suppres=
sions=2Exml b/dev-tools/cppcheck-suppressions=2Exml</span><br><span>index 3=
3337cf=2E=2E926ecde 100644</span><br><span>--- a/dev-tools/cppcheck-suppres=
sions=2Exml</span><br><span>+++ b/dev-tools/cppcheck-suppressions=2Exml</sp=
an><br><span>@@ -198,12 +198,6 @@</span><br><span>     &lt;fileName&gt;src/=
openvpn/dco_freebsd=2Ec&lt;/fileName&gt;</span><br><span>     &lt;symbolNam=
e&gt;buf&lt;/symbolName&gt;</span><br><span>   &lt;/suppress&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-  &lt;!-- IGN: strlen(NULL) is n=
ot nice code, but seems to work --&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  &lt;suppress&gt;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    &lt;id&gt;nullPointerRedundantCheck&lt;/id&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    &lt;fileName&gt;src/openvpn/=
init=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    &lt;symbolName&gt;parameters&lt;/symbolName&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  &lt;/suppress&gt;</span><br><span>   &l=
t;!-- FP: cppcheck doesn&#39;t understand ZeroMemory --&gt;</span><br><span=
>   &lt;suppress&gt;</span><br><span>     &lt;id&gt;redundantAssignment&lt;=
/id&gt;</span><br><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/ini=
t=2Ec</span><br><span>index 24cf532=2E=2E6c87865 100644</span><br><span>---=
 a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><b=
r><span>@@ -299,7 +299,11 @@</span><br><span> management_callback_send_cc_m=
essage(void *arg, const char *command, const char *parameters)</span><br><s=
pan> {</span><br><span>     struct context *c =3D (struct context *)arg;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t len =3D strle=
n(command) + 1 + strlen(parameters) + 1;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    size_t len =3D strlen(command) + 1;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (parameters)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        len +=3D 1 + strlen(parameters);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     =
if (len &gt; PUSH_BUNDLE_SIZE)</span><br><span>     {</span><br><span>     =
    return false;</span><br></pre><p>To view, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2085?usp=3Demail">change 2085</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2085?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib9164e1c8f5e02a22=
53bbb3b2363a4f9f31c8bdb </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2085 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<=
div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--B5g+5aP/i2Q=--


--===============4022648025342007561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4022648025342007561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4022648025342007561==--

