Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01178606A33D
	for <openvpn-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WZOtL1Sh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=i9m0Fsr8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lTsaX+m/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SQh0yExA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Lfpt6h4s8E10m7m31+gDtmgfMHGanXqQYI9fZglyzFU=; b=WZOtL1Shm4vxz5qNDZYBWSBJoG
	6nExr1bhUVzR+MAVpcApS2HxmQaIAwwBeXWEMAXHpfSyYumzqBwkLEtBs2q9aJam1BCExpFL6yaYV
	pZOC/n+BMy7Nj3wJmCi1+Q3yPhd2EkeuLA4HpIHsl+ZWufWZGhEK4xZ6dE8J+QRjn4so=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJotM-000000003v1-2xXG;
	Thu, 22 Oct 2026 09:15:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xJotJ-000000003un-21me
 for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 09:15:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OLwmMY3qMk4l6PJiPBOkFubu3AE4VhtnRG00F5oBFBM=; b=i9m0Fsr88wS9Hk1JbZviOTdZ5e
 0XSqPH52rPQoDfp73DW/w3JOa/fK2tLOFt4xP/D+grxUZvdtoIjKZTNQWnLN4eD3bPnFBpLscH/7X
 m9fIPzeoNMWWn5QwH4VwDdt/+rHA++bf6cwMwo70n0MqITymxv7QuGG0wPiwdEouSGX8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OLwmMY3qMk4l6PJiPBOkFubu3AE4VhtnRG00F5oBFBM=; b=lTsaX+m/2R46OwmAKVQOEE+GJ5
 ojEdE2b/jeWDePTx7PdX/U0UpUv+Zsez6G7un+CpZPCVqKKToLRJNFAT9eLprkCUeNRIrN/NAwKcS
 XpORpzQqlyaP+HmBM90F/QpQUgcGBOT+376tFwx7+sd6p/46c6zakf+8OjTWKFZ516ug=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJotC-000000003wU-1zz5 for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 09:15:13 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48bbb06e746so967008f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 02:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792660504; x=1793265304; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OLwmMY3qMk4l6PJiPBOkFubu3AE4VhtnRG00F5oBFBM=;
 b=SQh0yExA6/N+pOBN34tT9CubjFQwVP2Dugi4TatF6MuNrBHomeQsDxcDNu8GK+Zwtu
 T6ObHGobGy9yksiE8nuFNuIO9rkR5uDP0fBZp0tF18+CHxt78Jjh95Rezfxdztyi0Xk/
 1KAZh0xpnXMx8OsSlCFPO6lwAtJJuA3nPzav0inGkeJ6BQjDn31jsAohQgUUfbMCg6PV
 G14Yo3WZQffNobxpcOMMBuWLfhgjy1nknITZboFGKvru2SFzbiETCz+5kQOrCQykvEZd
 h5qEwWNljfiUU3S0sZbQDWQanOkd55NS2Jzw4sXFhd9sZlI2VRaCSCfadAdtRONRTMJc
 G3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792660504; x=1793265304;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OLwmMY3qMk4l6PJiPBOkFubu3AE4VhtnRG00F5oBFBM=;
 b=E6zoKqSyBPlDEQnWSOTynfwDr9Ao9OYk93OHHuyhpECBXWjfpjE/19M2D6AS6QyMFI
 U4DyiSzMHjDz6lFY6SFfAj+QcPv5seK4Cg9TEL8Rla5wU+pbqRt9BAFeY37gSSnodpab
 cedkjIwCQ84Syc/Ap1qsIfiBcORKAxvMILa53PRBZtHec5ljsgj8ln97Z/DJrtovrx7j
 Ghg8/aBKbcc+NejyJR8YZuA2nJ+ql2ja74tJs1UaKisXs5m36bRHa4EULv1mLUEu7gqz
 mAaeMvCqq6RX/YtuQ0x465JEZGdD1X6cqD1bj0ef7+IDHojqt6voa93dxOfNj/oIAXy8
 yo3A==
X-Gm-Message-State: AFq9FYLOILXsF4y7+oCWTiwv8T62YNNkz/HcpnZJcquQoAz9kWq1TZzc
 Ulv84OewCKzWLVKu+oEk2Erb+I9wGowc7crrNuk5hADE3yDFBieDzNAyCeGOfvrOAiNE1IIHDzB
 ijOlaoc0E3ZhH8weVWkLhSvRr2uU8OjMJWP6MbxSbqru9InIAz5WY7HBxeJ71sIe5xGIF
X-Gm-Gg: AYBFou2YLAUew2hVbhad5YE7bEjdHlYWLvQNsU3SKQSU5Y74iag0WxeD4qTCOc8PNu1
 zKgESf4CkS6C9ZID4PZ0neCbuW60NyojcgSO8oLK7V8GEjgzMRcybfwrRQcDfp2FIAIIRO56kZm
 P4ApVuYvb5ng8VzKEqxNa8IuC85yq4lkNXqzA8+kMGa5pTuCjL74/s42B/TwtHu6z0Z1CA0/J6u
 Wtagoc0fpyklFqwMn7uMVGeOq/AGCNviubBK1nhsLj9pxoMv1oAx8QZr2dHj2bSBpb1YJKSYs8J
 XXcWhgQa5TaTGwRPXgiNPpTEfGYCnQ9ZTqjmz1Ls84+zV+QNkB/W2RhdNbhnqy6zrlmMA0zpUva
 nbdQtBkLQcx4OyArTO+S1nNPpIvRFF6MCybgaL3BtSO7Q8+46zepd+3mT3ytmf3op2gYKiz9flG
 vvRRqKVWj+xVl+Q6qmanAod+NM7s4+01yiWaR7G52NbbuGUhEmyUQKAzf+VCGjGKT69Vpo4IQf2
 hroIAtLwooVzPIO5+6DjiGPKJDGiSSfq2RRIiJ7v3fFZ1x+N8uD8EH5VdTMCANNMtXhOEDIIMn0
 sdEZYhIYIJfFtzORjyifX7MbbXVUW5WlmEqSIXC1cPV+pNYvqg8Xm0Kkp7iXEwRcSU1TvR7x7gH
 nUZUyHPoecTnnTS6jy09w8jG50CrwCKLhSKXOykalJg==
X-Received: by 2002:adf:f8cc:0:b0:48c:6d9d:9f90 with SMTP id
 ffacd0b85a97d-48e264e1a6bmr7619481f8f.26.1792660503641; 
 Thu, 22 Oct 2026 02:15:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2581f0e2sm10180086f8f.15.2026.10.22.02.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 02:15:03 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 22 Oct 2026 09:15:00 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I230654e770c0556976a9bf4aaae9bcbea79b31e9
X-Gerrit-Change-Number: 2026
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2026?usp=email>
X-Gerrit-Commit: a51224225e495d09d6d200c30c0c6c4a8fffb3d3
In-Reply-To: <gerrit.1792504491000.I230654e770c0556976a9bf4aaae9bcbea79b31e9@gerrit.openvpn.net>
References: <gerrit.1792504491000.I230654e770c0556976a9bf4aaae9bcbea79b31e9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNTA0NDkxMDAwLkkyMzA2NTRlNzcwYzA1NTY5NzZhOWJmNGFhYWU5YmNiZWE3OWIzMWU5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <72f4ecb6299284dd76d6276775798c2fea19fef6-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xJotC-000000003wU-1zz5
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: configure: Output
 compiler version
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1476825372858973437=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1476825372858973437==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Fpyi67W/wO8="; charset=UTF-8

--Fpyi67W/wO8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
026?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by Arne Schwabe


Change subject: configure: Output compiler v=
ersion
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

conf=
igure: Output compiler version

CMake does this and it is really useful whe=
n looking at
logs in buildbot, so one does know which compiler was
used=2E
=

Change-Id: I230654e770c0556976a9bf4aaae9bcbea79b31e9
Signed-off-by: Frank =
Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2026
=
Message-Id: <20261022081514=2E2882-1-gert@greenie=2Emuc=2Ede>
URL: https://=
www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40086=
=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M configu=
re=2Eac
1 file changed, 4 insertions(+), 0 deletions(-)


  git pull ssh://=
gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/26/2026/2

diff --git a/c=
onfigure=2Eac b/configure=2Eac
index 8bf2c8a=2E=2Ee31a7ff 100644
--- a/conf=
igure=2Eac
+++ b/configure=2Eac
@@ -381,6 +381,10 @@
 fi
 
 AC_PROG_CC
+# A=
C_PROG_CC doesn't output any useful information
+AC_MSG_CHECKING([compiler =
version])
+CC_version=3D$($CC --version | head -n1)
+AC_MSG_RESULT([$CC_ver=
sion])
 AC_PROG_CPP
 AC_PROG_INSTALL
 AC_PROG_LN_S

-- 
To view, visit http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2026?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I230654e770c0556976a9bf4aaae9bcbea79b31=
e9
Gerrit-Change-Number: 2026
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eor=
g>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--Fpyi67W/wO8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2026?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by Arne Schwabe</p><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">config=
ure: Output compiler version<br><br>CMake does this and it is really useful=
 when looking at<br>logs in buildbot, so one does know which compiler was<b=
r>used=2E<br><br>Change-Id: I230654e770c0556976a9bf4aaae9bcbea79b31e9<br>Si=
gned-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2026<br>Message-Id: &lt;20261022081514=2E28=
82-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg40086=2Ehtml<br>Signed-off-by: Ge=
rt Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M configure=2Eac<br>1 =
file changed, 4 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/26/2026/2</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/configure=2Eac b/configure=2Eac</span><br><span>index 8b=
f2c8a=2E=2Ee31a7ff 100644</span><br><span>--- a/configure=2Eac</span><br><s=
pan>+++ b/configure=2Eac</span><br><span>@@ -381,6 +381,10 @@</span><br><sp=
an> fi</span><br><span> </span><br><span> AC_PROG_CC</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# AC_PROG_CC doesn&#39;t output any usefu=
l information</span><br><span style=3D"color: hsl(120, 100%, 40%);">+AC_MSG=
_CHECKING([compiler version])</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+CC_version=3D$($CC --version | head -n1)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+AC_MSG_RESULT([$CC_version])</span><br><span=
> AC_PROG_CPP</span><br><span> AC_PROG_INSTALL</span><br><span> AC_PROG_LN_=
S</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2026?usp=3Demail">change 2026</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2026?usp=3Demail"/><meta itemprop=3D"name" co=
ntent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Me=
ssageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I230654e770c0556976a9bf4aaae9b=
cbea79b31e9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2026 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D=
"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>

</body></html>
--Fpyi67W/wO8=--


--===============1476825372858973437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1476825372858973437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1476825372858973437==--

