Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A88A606A31D
	for <openvpn-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fRB5dsYw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mv/1XiAZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hSXxSpQ6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=V4iSUd3x
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=czvm2GMZTiegazSa8c1ZoThX+kOxbHocuGPpgyOTu+8=; b=fRB5dsYwi5nuHZ4Gtu7Xt+7rQ0
	69OsfWmm0XmTsbJ3T8/+gLugjuAusqTjIOvjgs5/IsmYdPkoMb3KAHAbUJSg1wFLbGOFkRWpUzdAX
	Abb63qXlG6zlA8YU/P+UdE0s8Yq4TU/TY9lGUqICvkdZOUbMtRYgmHjs7p04UeEzmrDk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJqnW-000000005Uy-0SRQ;
	Thu, 22 Oct 2026 11:17:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xJqnC-000000005UI-2XpP
 for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 11:17:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jVbXxy7v1Zq0jzucGqZpy4gwBKJt7xpl1sWXBQG2bX4=; b=mv/1XiAZ8Pae3N+x7S65XAINpl
 812xwmemtfmMTry02I0wNZ83S8jobu70sL0C/gohY0AYnrSulIZTEBOizwtrto1bUQ3+HXLq2d+ld
 WNWTeF2yr3nvad4yikPtXpb+/pOkZ/J11oUR9cRJmfTzKbqihnlN9s0P5zSJMcPTSuCA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jVbXxy7v1Zq0jzucGqZpy4gwBKJt7xpl1sWXBQG2bX4=; b=hSXxSpQ6+8clCr+ro9dmuQ2G0X
 3cy86B67zfrc4cSMzuiAAs7l/dE3he+GIr+eDYKZnUCAsBG2DapoEA6gd0Eyq3l9hY5m0IGkc1tAN
 Szx5MsPc0m/qyRgx1+4Ma/6QWMCy1qjXXKXbTYPnCxaw7OLy8HOIBcWsQzvQVsK/N30A=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJqmx-0000000076n-24Fg for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 11:16:52 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a16aaf2067so20009055e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 04:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792667805; x=1793272605; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jVbXxy7v1Zq0jzucGqZpy4gwBKJt7xpl1sWXBQG2bX4=;
 b=V4iSUd3xa2W8H/JgiraxVHEctwTxyHL48Uvr4H8QAuc5ElyzTdeZWjVh0C2I5ktmEP
 UgYyoxk7BqU3ANzCKilODsHSmFBY5xyflhpG9DVMjttSVJKb4sNKghzbKDTQ5o4VQM3X
 TBzFx01qnAarA9A5+KZQmBbbYF/pMZW52Y++qKfbVR5dHhc8g78s01txKY9l2xPQQ9lD
 iJL6DmdDjhBBLPWhZe4VFXDSoADdL1dAUmzI0RQXrySYaI0+WDgrWCOhxAAfWGdQ6OAf
 ZbQJP+YSxMS2Awm1vUZiCPXzK5k4CFSWpSlDquNK3L/GQSpV+bbBHqr5PCAMwQId79ht
 Pc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792667805; x=1793272605;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jVbXxy7v1Zq0jzucGqZpy4gwBKJt7xpl1sWXBQG2bX4=;
 b=GRolkQ8A+3zchuDCuKAvvV7ngH12Opq/ffLO9L4ch/dsex/whmShffyC8/pN4n7Y4F
 EI8GkA5QejSLXMDJXcc42UHSd6+YnHkjKdJkbbWOcHAiFlymmU1soCYO0W7NqDx4hV1I
 qH+9ueKcALvy6983rQ/bOsSbhHkFIfuTCmv0tPj9vir5RPPiBwX9XpY+P0Kt3klYsaz9
 /w/6AlfMrNal8OjxCy0/fBLUKIuVymVNNpzRNaSEGkesHJpnPFputdbL9fNPZ0bSXB5d
 3Hzh4530vdqM+Zkfj4n6Ho5aQR7V4RjpEprmfLXVZ/7t6Ytl6vZKvwK+TphDQflnZ53s
 JFCQ==
X-Gm-Message-State: AFq9FYKK3OKDSrgCNwOao+N+5fyTaSHvgwPdsrDydk5/uQRt8+nPgAT5
 HsOLHYG+eL18EDsqO7ClJHQXo0nhdMCjIhXyZfjgyAIjYBJg6y73Juz0/nZmfzM24jEkkgZPWGd
 HgunVtyr4UPXeF2kXd/1MY2P3nmBRt+YZaW6quGW21rOvfM+3cq+ljCmBBDemRb2/aD9JPVc2GN
 aCmc6k4w==
X-Gm-Gg: AYBFou0y9T6w6q/P0/ScUkcoaWspehceWNioeBe2NxYW8iImiS2mfruMkN1iwEy98Qo
 q3snt2xDbMwl2aqFFsxx4AJ+4xnaH+FD2Lw5SCZtKxoo4WQNSaRd7CGHkWSTdAgMFMey5iCStq0
 h+nVAaqE8UQQCSWoC255tGNK5ov+KtIOjrWQetqI5LaSbPGaZYWdee5HZgmK8yZbHO/WDl+X/Zf
 RCeinK5ArNBuZg1bU9iG+8MWQk/dPqnjnAracDKb18yEOHyBZKywEfrItNGvT9QqZ6UuJliApkm
 BsNgmemn9m5eQ7sa1f+6f2Ytwew6lfXOeE+j6luUzfVJcB9meUcbxDJymu4guac8WcVIsgZLsqX
 vtgRSFAaH17gL7lOhJOJvIYAIb5zOBoN5fNbh5fbYQeI8kLhnlSL8bwrfYItBhcQjaAapwEmtyk
 QZBeA32DNVqjgnVq3aYzH4vtzTPyVHlYqkbQqU+mTlMIeZTy7UCpsw7p7kJfs1P41CsbNio1NMF
 mGL1NwXvj+vTHhnifoKM8jlsFE9S5YDLZsCOmpAsZ8JdspAuz3tW45YDSbLJeWJodenuTbExtzO
 mTmsw/w9Gk56W6nY59fn5md3VChm9RsfrmuBDNMpznI9cSSBfNZML1nYtTBIo4GI3YG/iCQaTIG
 ezA4+Rvptz+FyvsL1rpT5STb0eIc+krqhpc2d1NnbKQ==
X-Received: by 2002:a05:600c:4708:b0:4a1:fa21:fd90 with SMTP id
 5b1f17b1804b1-4a1fdaef9a6mr100349765e9.9.1792667804675; 
 Thu, 22 Oct 2026 04:16:44 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2581f0d4sm11910008f8f.13.2026.10.22.04.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 04:16:44 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 22 Oct 2026 11:16:44 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I20d367dd8251bf39856ae521f380cfdc8df64177
X-Gerrit-Change-Number: 2028
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2028?usp=email>
X-Gerrit-Commit: 7c0460a0682aeec8dac618cb8bb053a6d90b8a5b
References: <gerrit.1792667802000.I20d367dd8251bf39856ae521f380cfdc8df64177@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNjY3ODAyMDAwLkkyMGQzNjdkZDgyNTFiZjM5ODU2YWU1MjFmMzgwY2ZkYzhkZjY0MTc3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <93bc61d0a961ba93307048fd028487667e016048-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xJqmx-0000000076n-24Fg
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure: Call
 AC_PROG_CC before AC_USE_SYSTEM_EXTENSIONS
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
Content-Type: multipart/mixed; boundary="===============2130560122730704931=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2130560122730704931==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QLyfk6Yx+G8="; charset=UTF-8

--QLyfk6Yx+G8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2028?usp=3Demail

to review the following change=2E
=


Change subject: configure: Call AC_PROG_CC before AC_USE_SYSTEM_EXTENSION=
S
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

configure:=
 Call AC_PROG_CC before AC_USE_SYSTEM_EXTENSIONS

AC_USE_SYSTEM_EXTENSIONS =
requires AC_PROG_CC, so the later explicit
call expanded it a second time a=
nd repeated the C standard checks
as "(cached)"=2E

Change-Id: I20d367dd825=
1bf39856ae521f380cfdc8df64177
Signed-off-by: Razvan Cojocaru <razvanc@mailb=
ox=2Eorg>
---
M configure=2Eac
1 file changed, 5 insertions(+), 5 deletions=
(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/2=
8/2028/1

diff --git a/configure=2Eac b/configure=2Eac
index e31a7ff=2E=2E0=
ac61b4 100644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -45,6 +45,11 @@
=
 AM_INIT_AUTOMAKE(foreign subdir-objects 1=2E16) dnl NB: Do not [quote] thi=
s parameter=2E
 AM_SILENT_RULES([yes])
 AC_CANONICAL_HOST
+AC_PROG_CC
+# AC=
_PROG_CC doesn't output any useful information
+AC_MSG_CHECKING([compiler v=
ersion])
+CC_version=3D$($CC --version | head -n1)
+AC_MSG_RESULT([$CC_vers=
ion])
 AC_USE_SYSTEM_EXTENSIONS
 
 AM_EXTRA_RECURSIVE_TARGETS([build-tests]=
)
@@ -380,11 +385,6 @@
 	pkg_config_found=3D"(${PKG_CONFIG})"
 fi
 
-AC_PRO=
G_CC
-# AC_PROG_CC doesn't output any useful information
-AC_MSG_CHECKING([=
compiler version])
-CC_version=3D$($CC --version | head -n1)
-AC_MSG_RESULT=
([$CC_version])
 AC_PROG_CPP
 AC_PROG_INSTALL
 AC_PROG_LN_S

-- 
To view, v=
isit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2028?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: I20d367dd8251bf39856ae521f380cfd=
c8df64177
Gerrit-Change-Number: 2028
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>

--QLyfk6Yx+G8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2028?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">configure: Call AC_PROG_CC before AC_USE_SYSTEM_EXTENSI=
ONS<br><br>AC_USE_SYSTEM_EXTENSIONS requires AC_PROG_CC, so the later expli=
cit<br>call expanded it a second time and repeated the C standard checks<br=
>as &quot;(cached)&quot;=2E<br><br>Change-Id: I20d367dd8251bf39856ae521f380=
cfdc8df64177<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
;<br>---<br>M configure=2Eac<br>1 file changed, 5 insertions(+), 5 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/28/2028/1</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/configure=2Eac b/confi=
gure=2Eac</span><br><span>index e31a7ff=2E=2E0ac61b4 100644</span><br><span=
>--- a/configure=2Eac</span><br><span>+++ b/configure=2Eac</span><br><span>=
@@ -45,6 +45,11 @@</span><br><span> AM_INIT_AUTOMAKE(foreign subdir-objects=
 1=2E16) dnl NB: Do not [quote] this parameter=2E</span><br><span> AM_SILEN=
T_RULES([yes])</span><br><span> AC_CANONICAL_HOST</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+AC_PROG_CC</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+# AC_PROG_CC doesn&#39;t output any useful information=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+AC_MSG_CHECKING([co=
mpiler version])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CC_=
version=3D$($CC --version | head -n1)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+AC_MSG_RESULT([$CC_version])</span><br><span> AC_USE_SYST=
EM_EXTENSIONS</span><br><span> </span><br><span> AM_EXTRA_RECURSIVE_TARGETS=
([build-tests])</span><br><span>@@ -380,11 +385,6 @@</span><br><span> 	pkg_=
config_found=3D&quot;(${PKG_CONFIG})&quot;</span><br><span> fi</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-AC_PROG_CC</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-# AC_PROG_CC doesn&#39;t ou=
tput any useful information</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-AC_MSG_CHECKING([compiler version])</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-CC_version=3D$($CC --version | head -n1)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-AC_MSG_RESULT([$CC_version])</span><=
br><span> AC_PROG_CPP</span><br><span> AC_PROG_INSTALL</span><br><span> AC_=
PROG_LN_S</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2028?usp=3Demail">change 2028</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2028?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> G=
errit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Pro=
ject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Id: I20d367dd8251bf39856ae52=
1f380cfdc8df64177 </div>
<div style=3D"display:none"> Gerrit-Change-Number:=
 2028 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div st=
yle=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>

</body></html>
--QLyfk6Yx+G8=--


--===============2130560122730704931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2130560122730704931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2130560122730704931==--

