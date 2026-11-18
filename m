Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82842606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=j0ZqQ41b;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BEk264LQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PT5OcFvg;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=br+ejqEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=QMUpQ/+dhl4n8K/alwIBKvY+2gCiUXjXbgZqGBgl7dk=; b=j0ZqQ41bcTgLZATkY56Ys7/qrL
	6qClhGtdprfW+AkCf1tmd1k5gRscMLFZkEA5BNCBWpxcsA+N8Gj9L9sBVtN8UHimoIB3i1GB/Ljl7
	bp8P/TUZaTHjwAaHBiyvwIc6GbWpjCm/RCj8/c3U0OwYoc18k0lnjoNcvWOPLBGzZNtM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTb8k-000000000jp-383B;
	Wed, 18 Nov 2026 08:35:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTb8c-000000000j4-41UE
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 08:35:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UAVwVxLw4AP2YB2Sk+n5htGag5nNeGAzD7lfqVo4CRM=; b=BEk264LQ9rb18CayNVzQI2taCv
 98fb7Z4IkgcrbwzTpIZeaOfgvqqD6LQDx9zuCfqmEYQICJD0SdYm0j2KnnFN01zL7PzS1dlEN+rL0
 mWr1/KMgbut3n+Oa5kW/XH+iY0BbRMI1WidbsYvqaQDhNt+tF6sPrd38xr6N4qSJIyhA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UAVwVxLw4AP2YB2Sk+n5htGag5nNeGAzD7lfqVo4CRM=; b=PT5OcFvgP87QZx/tapFIqpqze5
 TTtiSNxKE57C/URtqpuZqiSScaNMImYRabGmW3LIzhLPtiokIpYUE11YGgCHICIsVMy1JPzEJptEG
 4hnEGPiZ9mg+2zm0f7GHYlc1BUfcp8hU0SqYgdUQmAQ+9FgFKx20O4/uV3ORCI+e69Eo=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTb8b-000000006u4-0woe for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 08:35:30 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so336889f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 00:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794990923; x=1795595723; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UAVwVxLw4AP2YB2Sk+n5htGag5nNeGAzD7lfqVo4CRM=;
 b=br+ejqEMA1MKG0BNpd5djsmH+W+J6QOLD5gvkwTOJ33euIpRlANAEIXk+omnoZREYm
 KgKbpXCzuCdRpdg7UZwLTXaqRhooO2PtVqSKL12JOs4s8rw9XxhhpzORBPI2KsJ1L0po
 Mk1G06VL8Xiz3KgNEtsQ2z/kFmR4KvpB8R971PJI2JcHHXrfrcTwdmfpynbhqlLsAhBZ
 Vt8Cd59YNlJpoymNy7TR3HJZ8i3/PDFJQXtXdanV+24kmFMrXzoFnM1Qajl9x5n5ssFo
 3crjw5OdyONOJBLxr3iT5ZLmSNeQVLA8E9E+ME77ThqOAylqmLFljXgwNzyvkRrnqPBB
 eVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794990923; x=1795595723;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UAVwVxLw4AP2YB2Sk+n5htGag5nNeGAzD7lfqVo4CRM=;
 b=M/GC7d5ugtGYlaFjXaGhH8oTha62WyT6q0D9iduthZaO+bcCcQ4wfg0pTVG69K9iKM
 IRufO5Ev4REFwW+E7KpxdjJ9pFnBuSslXtqqPPYT6ioZjKmvjP12R7OdBj0D45pipaZb
 YGasFxEmPjChFp4cKq8QCdLACnlBM0mleSd6fcAZOD3AABJS+9t6Upeq7ZttZBJrc65f
 ZHLJBZaktOzh35bjQaPlKRvnDeURo+f9EmE/shoYKAQbMtbPx6RuBWkjaV3y/hjGD2qY
 kxhX4sM3aMGOslt6VwbU32E+9oTKq48z+yat5QHpWd9yHEnQ71cPXPiOK/6NpmbNQ82f
 0Usg==
X-Gm-Message-State: APuU4Z8q7kzjeMm/qx8mZvolTUpRbkmsfGzASR9LcMvCJJOK2sdTXN6h
 8nQ9GvqczwGIoVdkfGKXnKH1v7DV0JNeAycozWqZcQC/eL7R54FgAY0ThZMbP4Rl1jvpis9Cnhi
 dUbwvcmHLj/WE4yqzbLMngi18GHytqj2jb7H5kIrbK97uLJRSZNqF3ZMIxBIk8MjoExA0jlPp7u
 2FSMWulQ==
X-Gm-Gg: AZFdTZc3L1HGh0TPF9K17bWmHHEdFKcXkNnBpT2I9dVyTISWwgfJvDHaY3GuSOadFRy
 hNVKT+ZaoG14gF0Wd9q1hl4fzUMGmAqd/zTcwuFcw/2pqZRvNxB2M+LSEnfzx8yU7Ut7xPUNBYO
 lQBca05x4Yojy84WJ0s7iYe75zZ/11L70+v/0akffPfvppHeLEsESdpSqEfXZotUlr/0kAKdbmo
 IBXlwT9vmMEjb5ajtGsP8cfs3mWqsCHpezvNz8IzQUQTymdV316Cgp5SlnCcauZBFGIoG9HQi+H
 kWptiMCRg9PbcXpPmsSpP6FiMfL1FbqJffoRlTJPghbXnRsIzn2NldYv7vtnH+1bxj1G0mSyJxV
 bo0mBvLNwDKSeIJRvOUlnvpX5w8VXkmuvgjlCP++5AvvAChB5LqDFXCqyJbytB35oVMacLBH/by
 LK1tin/6jWn+7spcAk1J2XiD+Av3v6d1TiKmdW7CEFmpfYKFUo67S2Ykb6DyjwUm22xZZfdh6rN
 6sZlKBHVfEhWr7xwN4p68jMPmn6WHvdDX4ratYFcMeDkNHeUmtkrRJ2EJFv2BMorYz2K5iTTbdC
 6dcx37f2OyBmUMznvZXZ7zfphjH4hRa29SAgoZAGGoyQsrWrHHyxfZYrrWfhoGIevg+YTrQ45NX
 zB+t1cDwyA3XYW1IflBjJfaYDGANCMfs7ubx+Oc4dcZPCnCgQg6s9rWK0NOGDzalnoft/JZikBf
 zL6CkBRxLuVKnhncM=
X-Received: by 2002:a05:6000:29d0:b0:499:1c0d:4568 with SMTP id
 ffacd0b85a97d-4a63ca2f4d7mr2257068f8f.48.1794990922493; 
 Wed, 18 Nov 2026 00:35:22 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a656095e98sm3122660f8f.42.2026.11.18.00.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 00:35:22 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 08:35:21 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie5336121e8a48e5a63b509d6a30349be42d311f9
X-Gerrit-Change-Number: 2216
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2216?usp=email>
X-Gerrit-Commit: 8e7f261193afc791050c8d50f259d1a5f4a6c5a1
References: <gerrit.1794990920000.Ie5336121e8a48e5a63b509d6a30349be42d311f9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTkwOTIwMDAwLkllNTMzNjEyMWU4YTQ4ZTVhNjNiNTA5ZDZhMzAzNDliZTQyZDMxMWY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <15d9ffc92296c8c0d5ee8940703a48aceb4b3399-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTb8b-000000006u4-0woe
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_openssl: don't
 log inline CRL contents
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0080572308612859372=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0080572308612859372==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vgt2z7RO2Hg="; charset=UTF-8

--vgt2z7RO2Hg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2216?usp=3Demail

to review the following change=2E
=


Change subject: ssl_openssl: don't log inline CRL contents
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl_openssl: don't log in=
line CRL contents

With an inline <crl-verify>, crl_file holds the PEM data=
, and the
"CRL: loaded" message printed all of it=2E Use print_key_filename=
() as
the other CRL messages do=2E

Change-Id: Ie5336121e8a48e5a63b509d6a30=
349be42d311f9
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M =
src/openvpn/ssl_openssl=2Ec
1 file changed, 2 insertions(+), 1 deletion(-)
=



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/16/22=
16/1

diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2E=
c
index b95de8e=2E=2E7fdb3c5 100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b=
/src/openvpn/ssl_openssl=2Ec
@@ -1415,7 +1415,8 @@
         }
         num_=
crls_loaded++;
     }
-    msg(M_INFO, "CRL: loaded %d CRLs from file %s", =
num_crls_loaded, crl_file);
+    msg(M_INFO, "CRL: loaded %d CRLs from file=
 %s", num_crls_loaded,
+        print_key_filename(crl_file, crl_inline));
=
     ssl_ctx->crls =3D crls;
     BIO_free(in);
 }

-- 
To view, visit http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2216?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: Ie5336121e8a48e5a63b509d6a30349be42d311f9=

Gerrit-Change-Number: 2216
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Co=
jocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--vgt2z7RO2Hg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2216?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">ssl_openssl: don&#39;t log inline CRL contents<br><br>W=
ith an inline &lt;crl-verify&gt;, crl_file holds the PEM data, and the<br>&=
quot;CRL: loaded&quot; message printed all of it=2E Use print_key_filename(=
) as<br>the other CRL messages do=2E<br><br>Change-Id: Ie5336121e8a48e5a63b=
509d6a30349be42d311f9<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt;<br>---<br>M src/openvpn/ssl_openssl=2Ec<br>1 file changed, 2 ins=
ertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/16/2216/1</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec</span><br><span>i=
ndex b95de8e=2E=2E7fdb3c5 100644</span><br><span>--- a/src/openvpn/ssl_open=
ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_openssl=2Ec</span><br><span>@=
@ -1415,7 +1415,8 @@</span><br><span>         }</span><br><span>         nu=
m_crls_loaded++;</span><br><span>     }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    msg(M_INFO, &quot;CRL: loaded %d CRLs from file %s&qu=
ot;, num_crls_loaded, crl_file);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    msg(M_INFO, &quot;CRL: loaded %d CRLs from file %s&quot;, =
num_crls_loaded,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     print_key_filename(crl_file, crl_inline));</span><br><span>     ssl_ct=
x-&gt;crls =3D crls;</span><br><span>     BIO_free(in);</span><br><span> }<=
/span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2216?usp=3Demail">change 2216</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2216?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: ope=
nvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: Ie5336121e8a48e5a63b509d6a30349be=
42d311f9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2216 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>

</body></html>
--vgt2z7RO2Hg=--


--===============0080572308612859372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0080572308612859372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0080572308612859372==--

