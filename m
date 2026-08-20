Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD68FC5DF82
	for <openvpn-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hYwoMe7gjY+tMSNwuh1dOftJikL6CfYNoGhxVuQ5F3Q=; b=SHz0jQKxTQHR78SOZRYMjTjLiN
	MeoQkNfAqouBh3b9Lnp/KEngFGjUdJiSVe+oNMo/n+e7lY/y3YjNVSI28bVww00M1jWyyb1q/VBSC
	H1GyUHERZGSf5l05F8iRYFNKqoPVaYwAOeMMzjBLUzDNzQ884x0vzLcFhxY++qRlyF9Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wx0Wt-0001Qt-Dw;
	Thu, 20 Aug 2026 11:01:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wx0Wr-0001Qf-WE
 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 11:01:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=xz0ECwITI2vJ/Stvd4Cp8i3cGqkMA3nrmH6a/NUXA0Y=; b=Az5Z3fuHuFEKCvpYHE1DxnYAQC
 qBqtJsypEQmm4vvyEChtsChYB508lXh7w/rPF4fg1Va67uCbRG7YlchigqBY9CBe+xjE1wAd518j6
 l9Xz4N2k1yJZkHLv2wv3pBUHK6EuBBKgJdalxHCAB3f4vkbR9Q5gCQmASYZbjC3dxZ3o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xz0ECwITI2vJ/Stvd4Cp8i3cGqkMA3nrmH6a/NUXA0Y=; b=P
 V8psQ5auL4FWMmNJ6RumcnGGljWcCZICGdrT+9vWkbUabVCNhrdpIuoTDqZ3tevCr52BvkqNU1vA0
 nxRZtLsfxinze5X8Rjn0QPdhcGFFcUjOezo4lOkHIK6MKxlBeZBVQnSXqZ2LBKGbEQN+2YSplSWMr
 /gJ93+l1wxbGjOwk=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wx0Wr-00054X-O3 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 11:01:50 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47fd66a094eso761220f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 04:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787223703; x=1787828503; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xz0ECwITI2vJ/Stvd4Cp8i3cGqkMA3nrmH6a/NUXA0Y=;
 b=LJrQAItr1XDxVpnVs9bvbVvGON3eJYYZk30+Pq2vHJovu2jCJFdl/+nUNyseot2oBC
 No9CclZ1nnPha49tPn21w2ris9/3q7H4rQUsblTOvKYO8JNSrjLK5bs98PJxB/67xEy1
 ylTxxD2lNkFPSgTugYo6MtL/8TqmY7IgCIv0XJWfnA1iAO9q013XWRdPqmafdNVncEFB
 mSTlw13BE7CUXMkYKs/GApYQMNSE4WXqONMkjd5vw4YqMbER8KrnVV/S6oHVaf6wAgY9
 PFshxtivZaMua+Tojl/2GxkIC+4WNZOIcrA1Hm9v1IUp8Yhs2a6tWObE3628YBcKyvIg
 Fpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787223703; x=1787828503;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xz0ECwITI2vJ/Stvd4Cp8i3cGqkMA3nrmH6a/NUXA0Y=;
 b=pq25mNEOhVCTwGyJulKmRbe//iMpdp/A0tgi1y7XFwU6DvX7Qnm0aPICmgZP9iCYLE
 YKxZ8CfS9Djt2V3rKMdvp7N96Rhq+rVk+nKYjfG7MT4A9D7a2cMXPc7LHZg/qJoCqBXR
 mT4V+/NhQivNmM9dacnniXu1PUN3VZymVIubawiXrhJ2guNQlQeOwh/pLopWeHdjKkAn
 Hcq4tWX1c79DXtCFPQ+WVd0T5xIeG0b6n83/i/i2+/mjavtY3TzyvTLFwL7LJLGYUZru
 DPOunnUUo07kmmoE77ybYp3qLLqo4OcKLBS+8Sio4o35hmo+d0Xs4cDTkW+eMShkmAiw
 eRwg==
X-Gm-Message-State: AOJu0YwUU8ziSeUIw4DlkUGmU+7QbCUal3QgdqMmE2mPP19IcqBPwyRE
 unrjrNIkxTUR1pVV9ktpPJIoSiRPt57m7IyY1UxvfUnXKhj8nYCa4TGBRgAlzo1LSyZAxGlXVbP
 jURqCKOmRdpw7Rfn0zUE81s4QB826CzO5MGsjnFo38DGgdJpKxe+gbbbHPyI4Jrf+gmTj
X-Gm-Gg: AR+sD10Qto7TB5ScK8CuvQoTvymrEA3Mnn0FDq5KS03kvLHNB60s56axKooJm8E7U9V
 Eo7OjUMVyA6/Dn6j8Ah2pJjwXCBeFYfo07w5p7KufiV8STZRuOClWrDatZnHUv2m/QE99ruehA5
 9cmAtprdg8V8J9gZsF7/xhJuhRWzezFz4XPciIruUohkWQL/2uUBLKztdVB6vGCaBAPyETeo1AX
 rtkKZSxMZVpwHtTwm3mT1t7ybjVKRU0OWn35MIfd2KIIcPmAwn+HUnsxmq9TKyCP1NASa/LSqhx
 hs5jvjpA6mHnvUefAMuvWuB6EklDZ/N7/203gUtligaSFX72WadbKmI96Bjr64J6JhpSzHBSSQd
 KWoRh+dH9uWpI3sJ+wLVyBdRoYxZzpuIPqQtONNNLsYCojvy8LTApIzC7Me+IYXMQfhrlxpuSs9
 /YUNBezulQqN9q1TPGIQ32miS6BkEqP5ihpmrL9xCbjXSniOL3PjOvK99d6H4DctEUNLEbhsPsW
 YEIHOX7VRI5u/IGfmUjk4Zg/ATtntirE9vOJeLvT2H+6MyxWb98VEYLwFderv/n7NO/KAuhD7Tj
 yD+WI4n2Tia4rArmsWPss3+B2iGJduxtdzKnmS4NlRtcOW6FDU4=
X-Received: by 2002:a05:600c:8b27:b0:499:7024:9d4a with SMTP id
 5b1f17b1804b1-499aa16a958mr232635445e9.8.1787223702659; 
 Thu, 20 Aug 2026 04:01:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa1755b2sm138459755e9.11.2026.08.20.04.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 04:01:41 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 20 Aug 2026 11:01:37 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ibb80db0547dcc0935964c9bd40222c27aac80439
X-Gerrit-Change-Number: 1848
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1848?usp=email>
X-Gerrit-Commit: 34661b1e1e06df3d6bbfdb85a33db87b33a79034
In-Reply-To: <gerrit.1787144531000.Ibb80db0547dcc0935964c9bd40222c27aac80439@gerrit.openvpn.net>
References: <gerrit.1787144531000.Ibb80db0547dcc0935964c9bd40222c27aac80439@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MTQ0NTMxMDAwLkliYjgwZGIwNTQ3ZGNjMDkzNTk2NGM5YmQ0MDIyMmMyN2FhYzgwNDM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4976a9a29997dc685fd6e1288232dd9fe19346c8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wx0Wr-00054X-O3
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: .clang-format:
 Convert deprecated setting KeepEmptyLinesAtTheStartOfB...
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0193647858586291294=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0193647858586291294==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WnKKVl/B4dM="; charset=UTF-8

--WnKKVl/B4dM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1848?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: =2Eclang-format: Convert deprecated setting Ke=
epEmptyLinesAtTheStartOfBlocks
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

=2Eclang-format: Convert deprecated setting KeepEmptyLi=
nesAtTheStartOfBlocks

Convert to new KeepEmptyLines settings=2E This adds
=
AtStartOfFile setting and applies it=2E

Change-Id: Ibb80db0547dcc0935964c9=
bd40222c27aac80439
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Eco=
m>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1848
Message-Id: <20260820101226=2E9581-1-=
gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-deve=
l@lists=2Esourceforge=2Enet/msg38551=2Ehtml
Signed-off-by: Gert Doering <ge=
rt@greenie=2Emuc=2Ede>
---
M =2Eclang-format
M src/openvpn/crypto_mbedtls=
=2Eh
M src/openvpnserv/validate=2Eh
3 files changed, 4 insertions(+), 3 del=
etions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/48/1848/3

diff --git a/=2Eclang-format b/=2Eclang-format
index 4774d1e=
=2E=2E0823739 100644
--- a/=2Eclang-format
+++ b/=2Eclang-format
@@ -32,7 +=
32,10 @@
 IndentWidth: '4'
 IndentWrappedFunctionNames: false
 InsertBraces=
: true
-KeepEmptyLinesAtTheStartOfBlocks: false
+KeepEmptyLines:
+  AtEndOf=
File: false
+  AtStartOfBlock: false
+  AtStartOfFile: false
 MaxEmptyLines=
ToKeep: '2'
 PointerAlignment: Right
 ReflowComments: true
diff --git a/src=
/openvpn/crypto_mbedtls=2Eh b/src/openvpn/crypto_mbedtls=2Eh
index 04346a9=
=2E=2E5c3b670 100644
--- a/src/openvpn/crypto_mbedtls=2Eh
+++ b/src/openvpn=
/crypto_mbedtls=2Eh
@@ -1,4 +1,3 @@
-
 /*
  *  OpenVPN -- An application to=
 securely tunnel IP networks
  *             over a single TCP/UDP port, wi=
th support for SSL/TLS-based
diff --git a/src/openvpnserv/validate=2Eh b/sr=
c/openvpnserv/validate=2Eh
index 12150f1=2E=2E2da41dc 100644
--- a/src/open=
vpnserv/validate=2Eh
+++ b/src/openvpnserv/validate=2Eh
@@ -1,4 +1,3 @@
-
 =
/*
  *  OpenVPN -- An application to securely tunnel IP networks
  *       =
      over a single TCP/UDP port, with support for SSL/TLS-based

-- 
To vi=
ew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1848?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibb80db0547dcc0935964c9bd=
40222c27aac80439
Gerrit-Change-Number: 1848
Gerrit-PatchSet: 3
Gerrit-Owner=
: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--WnKKVl/B4dM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1848?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">=2Eclang-format: Convert=
 deprecated setting KeepEmptyLinesAtTheStartOfBlocks<br><br>Convert to new =
KeepEmptyLines settings=2E This adds<br>AtStartOfFile setting and applies i=
t=2E<br><br>Change-Id: Ibb80db0547dcc0935964c9bd40222c27aac80439<br>Signed-=
off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razv=
an Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1848<br>Message-Id: &lt;20260820101226=2E9581-1-ge=
rt@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-=
devel@lists=2Esourceforge=2Enet/msg38551=2Ehtml<br>Signed-off-by: Gert Doer=
ing &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M =2Eclang-format<br>M src/op=
envpn/crypto_mbedtls=2Eh<br>M src/openvpnserv/validate=2Eh<br>3 files chang=
ed, 4 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/48/1848/3</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/=2Eclang-format b/=2Eclang-format</span><br><span>index 4774d1e=2E=
=2E0823739 100644</span><br><span>--- a/=2Eclang-format</span><br><span>+++=
 b/=2Eclang-format</span><br><span>@@ -32,7 +32,10 @@</span><br><span> Inde=
ntWidth: &#39;4&#39;</span><br><span> IndentWrappedFunctionNames: false</sp=
an><br><span> InsertBraces: true</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-KeepEmptyLinesAtTheStartOfBlocks: false</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+KeepEmptyLines:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  AtEndOfFile: false</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  AtStartOfBlock: false</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  AtStartOfFile: false</span><br><span> M=
axEmptyLinesToKeep: &#39;2&#39;</span><br><span> PointerAlignment: Right</s=
pan><br><span> ReflowComments: true</span><br><span>diff --git a/src/openvp=
n/crypto_mbedtls=2Eh b/src/openvpn/crypto_mbedtls=2Eh</span><br><span>index=
 04346a9=2E=2E5c3b670 100644</span><br><span>--- a/src/openvpn/crypto_mbedt=
ls=2Eh</span><br><span>+++ b/src/openvpn/crypto_mbedtls=2Eh</span><br><span=
>@@ -1,4 +1,3 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> /*</span><br><span>  *  OpenVPN -- An application to securely =
tunnel IP networks</span><br><span>  *             over a single TCP/UDP po=
rt, with support for SSL/TLS-based</span><br><span>diff --git a/src/openvpn=
serv/validate=2Eh b/src/openvpnserv/validate=2Eh</span><br><span>index 1215=
0f1=2E=2E2da41dc 100644</span><br><span>--- a/src/openvpnserv/validate=2Eh<=
/span><br><span>+++ b/src/openvpnserv/validate=2Eh</span><br><span>@@ -1,4 =
+1,3 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an> /*</span><br><span>  *  OpenVPN -- An application to securely tunnel IP=
 networks</span><br><span>  *             over a single TCP/UDP port, with =
support for SSL/TLS-based</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1848?usp=3Demail">ch=
ange 1848</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1848?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: Ibb80db0547dcc0935964c9bd40222c27aac80439 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1848 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--WnKKVl/B4dM=--


--===============0193647858586291294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0193647858586291294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0193647858586291294==--

