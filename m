Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC8D606A319
	for <openvpn-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BC0Tokn4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jR5ZhdlE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=J5NUPEi8;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=AMP/ScgP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2BVJlyN00/mpBjI8olV0laKOxHqmRaU1ee42wXiTYHo=; b=BC0Tokn4XPGbLx8opA3x7p5enP
	Cf++Q5eiLaoKOXNgeeS+XrlfPbLnAMLYOM4yC56kajfITSC14BmtIIotDb7JkU/EQy9IyAJR/+JfE
	xQQI7diMtqzs8R4F+IfnW6aWQ+6Y+mT/suQIENgdygkjO4m2B7sdRCSkbC74m27YgEnA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJotK-000000000sR-20LQ;
	Thu, 22 Oct 2026 09:15:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xJotJ-000000000sI-21l9
 for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 09:15:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yWKN9RPNnwjY/uQZvu7X7FPInmer1PpnlOujLIDmDJg=; b=jR5ZhdlEMgw9T68gru0t774bBk
 156KE73wIRL+xECduY8gr1EjFsVc6Vcs7ozFnp2l5WxLXYCqgLWNiHR+0d8pf2e27619u6lvPyKLV
 naRyuvssWkcDrNi9CicdCRrBGa3c6pGBAomkwkgVeUSVvqk9GUEN/1MMny/6lgVa07EU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yWKN9RPNnwjY/uQZvu7X7FPInmer1PpnlOujLIDmDJg=; b=J5NUPEi8QhuG8yjTIGYmxFoRU2
 4Mg3lKYaRQ4Wc4nFU8vfGBgaITKDp7DISN0IeAP1w+aikvvyjyHPqcsloeOTnMtQZgU3fp/2I18CI
 aRtDTWznHFQ2a1mAjox/ccJEtL17KQi8TfXpV2NVnYVJPQYNNIJLUHz5jxatNG77I3AQ=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJotD-000000003wW-0bSW for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 09:15:13 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso2559605e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 02:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792660504; x=1793265304; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yWKN9RPNnwjY/uQZvu7X7FPInmer1PpnlOujLIDmDJg=;
 b=AMP/ScgPZQmJKxff3hM34MyQ8VYmXRWQsyY1p9nHW3a97BXRIhuc+r0pJIRpoD7ywy
 LhY6qONyvj9RcM8HZXDe4WQb1Sh9QFIakTcsVgzbDBEYfARQe89KPF5CfzuJFbLMqBEc
 UCZZsElmmOSTMzMTwmIs8apZQUJHNZL6dc6lWy3uvGfupMeXQwC9MVPE6lTfaQtcB/+0
 jFlSAj8hZY7PBnYU5g4+6ykA+bH/pR7H9Ptex1vtAgLETw/LhdI+CzfbMUfzWa4/uscG
 DaOIVC8by2r2GmID7yYTxM50iOXfDd59wqlWMoGiOqDXjVRTA26Ql0mQ0EK4lrISjsCW
 ZoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792660504; x=1793265304;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yWKN9RPNnwjY/uQZvu7X7FPInmer1PpnlOujLIDmDJg=;
 b=ywY3HGgVGzhVy3dCGix/qg5IJQSn26Z5SfxAZj+cmDxESK2RL/I1/HP7+0eRB0aHy/
 BDYpn5NC0vAEBPFjv3KW/omHIn3qblEHrdal0bBDFtARlqtiSoUzntApTek5/c/kcNFm
 G6TI+mOhm5SaftCbTKh7UZGyPy+HlyqhUGsXc2niTOH/VcpBVBYp8nnrYcyl7Qv21NRX
 UZfAaScQtjDybg+AG+d5dZjWfFvD5ZYwwFyU+ATVK0bRj44SByyPRf2rmGrwgSDJTI+J
 Nz08GpDqAOmOZ32JyoYaC/YMpL815jSoKUphLUYhhgCukH+fHAYavWCVi3Ign6Y3i7ap
 AgSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/x9cjFZ3+MiqODEMvxZHUn6zm2k7SWlJwc2mbLn9ozskytX8HK/DtCETixI3b/XdFcJB/j3GxCkbV78Pg@lists.sourceforge.net
X-Gm-Message-State: AFq9FYK6/HUf+WZx6eXB8xn8cV2dW7f/aUklkmfWT1plqdOQqLNeCQl3
 Se5dc/S+TQLkgQluQdHbviMMxy2hxMgmCkmWpykkQFbq04oTAVPYc51fwGmVr3k/DGyHs1a6lDh
 Gs+p95KKsAsoV0PnmrPHqsQ6843DGlllb/3zqlTH7sD5qyNbp+o7MzWGc2GcOMw8lNtFd
X-Gm-Gg: AYBFou2BwV7PfZOF0TC03G5Ik2OwFCWYIZPYdOSOdBh7F13e4p5a7MXaIqdiHaPLWmO
 JMp2zq6fI7/29iGS3pqHQnEFBFwC8ZjEA0UP0OFCqx5MsUUy955zbTU5MPA6BtMKXNAhaNIkv0z
 t5GBnUX+xTQC9FeevcV6Joy9qaDFPxBYeHBYXqBAcQTZzrYHM+imRU3DxAe65s8ZEKvf0SOQwOH
 7npvrKpB5YGGfCN4TN/HSiQE8aa/51cZuXuSyBYPGeechiogVqSmOh4L3ECohBC1RWE5604xYbG
 yYxwTKtg9lbOWlSxCcS6b/e2dBE7TWPaJy/73q0g6cA5/anPkvZ+J0YMYdzvLkVYLShS+bhyqoZ
 X33SajFs9xtZv+Od1cWfbwPwfjwgxAvWn8D3xyZblbLqoi7laDMn2jp/vUYzP80iaE+fsBXoSKn
 h/Jf/4h5Wl92oQXp1k+o+95AOUFON+2wZb50JvAG2r50J3KyPrzJK5fVWQpXU+9pXS+1DZ5iprR
 3zvZyPeib/97GUsuUjVkXqpY5K22deFaPzEFSoHsyi2bospGHeh4xDdjbqLvIslUs1dJMfpIRHh
 qVSp9sROtOY1MWpeL3vmAL9WBWZt5IG/5Kkrez2LbY2VwdBWGU7OHi5eCNAeNp2XowJ0fD2XUPR
 oUzYUTCoQpbvcFf+cJ4x1tRwdzUiy3+xbu8wHAps2jBp6W52i3fenYEqibWTKNuo=
X-Received: by 2002:a05:600c:1c2a:b0:4a1:e57b:667c with SMTP id
 5b1f17b1804b1-4a1fdd4fe80mr108819425e9.26.1792660504464; 
 Thu, 22 Oct 2026 02:15:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a203b42befsm53357025e9.8.2026.10.22.02.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 02:15:04 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 22 Oct 2026 09:15:03 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I230654e770c0556976a9bf4aaae9bcbea79b31e9
X-Gerrit-Change-Number: 2026
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2026?usp=email>
X-Gerrit-Commit: a51224225e495d09d6d200c30c0c6c4a8fffb3d3
In-Reply-To: <gerrit.1792504491000.I230654e770c0556976a9bf4aaae9bcbea79b31e9@gerrit.openvpn.net>
References: <gerrit.1792504491000.I230654e770c0556976a9bf4aaae9bcbea79b31e9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNTA0NDkxMDAwLkkyMzA2NTRlNzcwYzA1NTY5NzZhOWJmNGFhYWU5YmNiZWE3OWIzMWU5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <72f4ecb6299284dd76d6276775798c2fea19fef6-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xJotD-000000003wW-0bSW
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8730031512344492857=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8730031512344492857==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JqoW4rJOMHo="; charset=UTF-8

--JqoW4rJOMHo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2026?usp=3Demail )

Change subject: configure: Output compiler =
version
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




diff --git a/co=
nfigure=2Eac b/configure=2Eac
index 8bf2c8a=2E=2Ee31a7ff 100644
--- a/confi=
gure=2Eac
+++ b/configure=2Eac
@@ -381,6 +381,10 @@
 fi
 
 AC_PROG_CC
+# AC=
_PROG_CC doesn't output any useful information
+AC_MSG_CHECKING([compiler v=
ersion])
+CC_version=3D$($CC --version | head -n1)
+AC_MSG_RESULT([$CC_vers=
ion])
 AC_PROG_CPP
 AC_PROG_INSTALL
 AC_PROG_LN_S

-- 
To view, visit https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2026?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: I230654e770c0556976a9bf4aaae9bcbea79b31e9
Ger=
rit-Change-Number: 2026
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--JqoW4rJOMHo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2026?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">configure: Output compiler version=
<br><br>CMake does this and it is really useful when looking at<br>logs in =
buildbot, so one does know which compiler was<br>used=2E<br><br>Change-Id: =
I230654e770c0556976a9bf4aaae9bcbea79b31e9<br>Signed-off-by: Frank Lichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2026<br>Message-Id: &lt;20261022081514=2E2882-1-gert@greenie=2Emuc=2Ede=
&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcef=
orge=2Enet/msg40086=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M configure=2Eac<br>1 file changed, 4 insertions(=
+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/configure=2Eac b/configure=
=2Eac</span><br><span>index 8bf2c8a=2E=2Ee31a7ff 100644</span><br><span>---=
 a/configure=2Eac</span><br><span>+++ b/configure=2Eac</span><br><span>@@ -=
381,6 +381,10 @@</span><br><span> fi</span><br><span> </span><br><span> AC_=
PROG_CC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# AC_PROG_CC=
 doesn&#39;t output any useful information</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+AC_MSG_CHECKING([compiler version])</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+CC_version=3D$($CC --version | head =
-n1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+AC_MSG_RESULT([=
$CC_version])</span><br><span> AC_PROG_CPP</span><br><span> AC_PROG_INSTALL=
</span><br><span> AC_PROG_LN_S</span><br></pre><p>To view, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2026?usp=3Demail">change 2026</=
a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div =
itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2026?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2306=
54e770c0556976a9bf4aaae9bcbea79b31e9 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 2026 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--JqoW4rJOMHo=--


--===============8730031512344492857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8730031512344492857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8730031512344492857==--

