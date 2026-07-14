Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8D9C43458
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yS/qtk5XveBNdpaC9U8ooE5yD6GyQRrbTvtpiuREzb4=; b=cHY+d4rVF7mcHZi+29p4OkZsPQ
	9LeoGTX35W/mfJk6oZ+6qnmfJla/a0I7DqMO5nhZvdymLbbT0IjwRVeWaHOTs2frZFrSRWyupTcvT
	ZquBuKxF0yr0We4DsggbLRz/1IfBehXNs59raoDdAIhSVcPOxru1EWsfhQXljfmu944M=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjbwW-0005vy-BI;
	Tue, 14 Jul 2026 12:08:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjbwV-0005vs-NX
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 12:08:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=kB+t9yfD8zovVyyIYX1nvrEpHVnWWTn0tOWsWZjhjko=; b=boNPXa3Fi0txuGSfuXCISuFUeU
 4YWmNf5ujTZfuC5imRqZXzV+Ur2K6kUo6fufg1Kw3ZFZzEMalRJd2EZS1VkdHcB8mWaf40s16bL2x
 uPxvH+frOU2toRZIjQJ7T1oOQidi2fBN6YNBkfECG/LVP4vIIrVFoJItW/WgPVeqHT3o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kB+t9yfD8zovVyyIYX1nvrEpHVnWWTn0tOWsWZjhjko=; b=j
 hxbHA8qpJJjFAIdHeMNnsGIamHd6/6PYNyMqV7TYQfOBTntlVLIHGvjmg6MLJpnB5T26RPfO4JlcT
 ju3+m0i+IKDaQydYwZmFcCRjbJ6tR9hhegszktzebBgFMTN6ChoS7pu7CydIIMVeSNTmtZnGLi7FS
 FB1BQPdw/jGtHCcw=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjbwR-0007eb-MT for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 12:08:53 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-471eeac43bfso4158113f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 05:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784030920; x=1784635720; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kB+t9yfD8zovVyyIYX1nvrEpHVnWWTn0tOWsWZjhjko=;
 b=Mnxvu+A0B/8xx5L+O1lELb3UsBPgQX38uvrQzmeIYZaMHaWQ44ynJo4+5LRk6IH/4D
 8ZY/pxFSejOPTEyw305zBGKmnEzZKo9dxRCn8e7MlIi1dNO2bJMmcRxuBawnXBRzIUNP
 7B0JH5vbBwh0PosaCShIOwsrPpcUIRItCA5hDXEbcPJAadC/FzNIaR8COuHoAjd9Qm7M
 ycaN9vqj8FRF/plSTCt4Jn6kB39XdindnRBW3JPkDk9YAZIUv5ocEl1RKOpInCJT7rbM
 Xz+bzZxgmd76NtQieKdEUhEB8vI9SzWfosVnAY0RLWsjeykjbdRl2RbmhGWNRLEPvAX6
 S3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784030920; x=1784635720;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kB+t9yfD8zovVyyIYX1nvrEpHVnWWTn0tOWsWZjhjko=;
 b=pqwcXyBSWIzslx/T0Z+L+fsphFNTQH73/Lujzkc6NZC9PlKxRePmkZnw4j1k7R645M
 Y02vmdL3V6wkdmUANE4m7CuGWPSS7gPaoWVyu+weICDUqYAXMKDcYVgXMcPKYvuAN2JH
 6/aYcXNnVpcfE+c0eljsfP7QteR2elwhVYyWexhHyEaBgleFfk5DkUoXh05Tp2KYUE1Z
 5J0Eijbc8DbhiyKPpbn9uxgi3uZ9cnkHD4YJ75Ib9FxGiu9r32VydjFw0jZan1C50Im2
 6xamUgGVnSEyHRkZZJW8siAsiENSHbYjqXiVQFbqQrZ8GWsMbE4b628Jgo9NGMnydjTb
 UjxQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp47Dbn59TQxFIsIgHINpxqGQg1OCmjfJEJHO7biTLkCUMxba2h1GprEPYhNdEqm9r3Bp/OeLz2DJ6u+uwR@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxXdn6cBGQle5VlfAYdz7m1YBwFmRzeXDcgQv0fNd2s0753Kdd4
 F9Bf5zI+d6ZN7bvGxH3UuquLPUugeIMbkn5XisoQ2iNFPvPMhVz+rGcoMquf+wSZMCulcpjZ2kz
 Zs3cDee6D2tfPxrzOEq0jcXT5j4dT9uMWLfe4CgQRd8+1GUhKXqzlVnmr+n+T+rp+e8TKSG1GT1
 B1HsIJog==
X-Gm-Gg: AfdE7clubOuG95uTY6xY4bpBjNCqu2dz8Ns7N8Rr+8Tg6GLVdIkFpBDKRUbV3Tb2dFN
 0vSc+EsdPspjarmFrGB5SsEyaOY2vTSp6aj4D7oG6XSfuGUueQ3bBcCYiZILmL5gS+tYwaKVlVw
 FfRX+8nHWHg5LbyBYkOMWdhN4gOZ6ZenTfqAJ4lyr90vhNSyydj8zs2Vn3KRk08B8qeV/oTNAhK
 ra6+Onomkwi5/O+V1UWDvbMCln2ZSzzqOfwW6XI4AEgO5Vdgt9hW1+oEpxVPeP0TX1Jqmg+IB/j
 xY/bhQq7xn/0VH6ZbN7lAARM6SyMHVDCgzeRRW7241qv2omjkIkVmtf9B5JJHMhrERMKWanTInz
 4GEUaEpjfH5sY0S03W3TAyD3ajIguVH4CeY0hVvklXyhNAxPFByKv+MH0QT9Bo/kzDlcKHuxGI4
 ZedkOmBE6nfwn8zvT70o+yBV4YqxhL4A+wc3Rqm4S4wi34nOm0g980WEh4Brnqntdfs/5ZCF+jE
 MOwN1b8ovr1o8xmHEH1D+UJNbJ5jP4PsGl3/6XZZasM4HpnVxH7JCRAi2iu5vJLNVR9x6Qt+GPa
 YIrbwWE4vMuKUw==
X-Received: by 2002:a05:6000:3cb:b0:475:f0c2:75ab with SMTP id
 ffacd0b85a97d-47f2dd0af95mr15693590f8f.60.1784030919962; 
 Tue, 14 Jul 2026 05:08:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4635a9cesm7689365f8f.14.2026.07.14.05.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 05:08:38 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 12:08:37 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e
X-Gerrit-Change-Number: 1723
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1723?usp=email>
X-Gerrit-Commit: b418167638991954a02dc17e3c4e4b5953a07e88
X-Gerrit-Comment-Date: Tue, 14 Jul 2026 12:08:37 +0000
In-Reply-To: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
References: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzZDUyYzZkMDA4NTAyMjkzYzNlYzU3YWQyMmQxYzYxM2RjZDFhOTRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a62bc1ed1ceeb51e73159406ac982b45769d78df-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjbwR-0007eb-MT
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Extract
 multi_check_dest_addr_allowed from multi_process_float
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4854147058307188255=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4854147058307188255==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="D5hMRn5JJUs="; charset=UTF-8

--D5hMRn5JJUs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1723?usp=3Demail )

Change subject: Extract multi_check_dest_addr=
_allowed from multi_process_float
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(3 comments)

File src/openvpn/multi=
=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723/comment/846b7077_46f7=
e2b0?usp=3Demail :
PS3, Line 3078:  * Reasons for disallowing a specific ad=
ress are that a client might be
> "address"
Done


http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1723/comment/6023b641_07da7bae?usp=3Demail :
PS3, Line 3=
079:  * already using that address=2E In that case the method need to decid=
e
> "needs"
Done


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723/comment/3=
9ac9edd_ffee1eaa?usp=3Demail :
PS3, Line 3080:  * if the this instance can =
kick out the other instance=2E
> "the this" -> "this"
Done



-- 
To view, =
visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I3d52c6d008502293c3ec57ad22d1c613dc=
d1a94e
Gerrit-Change-Number: 1723
Gerrit-PatchSet: 3
Gerrit-Owner: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichten=
held=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment=
-Date: Tue, 14 Jul 2026 12:08:37 +0000
Gerrit-HasComments: Yes
Gerrit-Has-L=
abels: No
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--D5hMRn5JJUs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1723?usp=3Demail">View Change</a></p><p>3 comments:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723/=
comment/846b7077_46f7e2b0?usp=3Demail">Patch Set #3, Line 3078:</a> <code s=
tyle=3D"font-family:monospace,monospace"> * Reasons for disallowing a speci=
fic adress are that a client might be</code></p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;address&q=
uot;</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1723/comment/6023b641_07da7bae?usp=3Demail">Patch Set #3=
, Line 3079:</a> <code style=3D"font-family:monospace,monospace"> * already=
 using that address=2E In that case the method need to decide</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">&quot;needs&quot;</blockquote></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723/comment/39ac9edd_ffee1eaa?usp=
=3Demail">Patch Set #3, Line 3080:</a> <code style=3D"font-family:monospace=
,monospace"> * if the this instance can kick out the other instance=2E</cod=
e></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; =
padding: 0 10px;">&quot;the this&quot; -&gt; &quot;this&quot;</blockquote><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail">change 1723</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I3d52c6d008502293c3ec5=
7ad22d1c613dcd1a94e </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1723 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div =
style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue,=
 14 Jul 2026 12:08:37 +0000 </div>
<div style=3D"display:none"> Gerrit-HasC=
omments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </di=
v>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>

</body></html>
--D5hMRn5JJUs=--


--===============4854147058307188255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4854147058307188255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4854147058307188255==--

