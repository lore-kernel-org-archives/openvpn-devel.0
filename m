Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34960606A31A
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mseWo3ky;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Y8FElrW+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aJ8ZsafV;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=gGpzQCF8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/Dxav9tqoSdS+6I9cdkERzGIF9tpKZg1oteUrbqgmvA=; b=mseWo3ky4kc6aodspIgLFW+fp1
	LTMDOmImdVNZRBJQvBR/PjqZ2Ssj3rk73rZ6Z8pZu+5+7olAQHuX/5Xl/WxX6tKWxJsphVlAJ08u2
	P5LyVdZ3CGULmvjeaYw6IMMB5jlsuK95VXXYf8BxeUgdGoOdKnnuInPFO6v/mSumSGD8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMs7Y-000000005iC-3pyB;
	Fri, 30 Oct 2026 19:18:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMs7V-000000005i4-337s
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 19:18:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qFODCIZb0hmj4TrLL285AXSEafHx13MiO/lT5KKHhgY=; b=Y8FElrW+YQXhkGjvyUTUDPMHbu
 WYxbxYpUN11p9zRVa7G+FXYM0MXvBh0FlU9tsL63WmUmndk7AnEhF3nhoCeH7pH/53p+X+Uzuaqcv
 uaALuEuEZ8Dz2TuMMW1LfTE9T3ZYaaqTFGrIBinsqRP7qEGG3ALHJYTXLDk4x88ZN8IM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qFODCIZb0hmj4TrLL285AXSEafHx13MiO/lT5KKHhgY=; b=aJ8ZsafVhqAGi7I6tkrO2vCn2c
 F6OQafmyon34khBPb+pjKjJz9Xg/pFTi0gl9aTRcwlwBGjfj2o1ctin25x9EJlQvQVEOw8XCtVtpg
 rwe70iInRRzFGERNGVqFlc9p5hARgAQVMDuDRyaaq/gI9Yr9xI9dsFP68pupgwaa3RFA=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMs7T-000000006bP-3wTi for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 19:18:33 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so8794785e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 12:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793387905; x=1793992705; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qFODCIZb0hmj4TrLL285AXSEafHx13MiO/lT5KKHhgY=;
 b=gGpzQCF8dFd5xD/U5dmp6VMnUFFiow7Awt4YZfWesj0/eny8mnx3CBHrBsipARaBnV
 JR/mhe8Wv5akycAqbn1G6/qUxzVu9xS/p3+bSIDQDEArUJJoE5mMYC0FoWWLex7HNeUk
 4UcPGNdbaZxPUWUXCH6sCFq0aAiB3ISSJhHs80/+NPMB045q5INUMR60vyuY4TCKp+Xf
 cuoiuusOL8ck+XWR67JqlDubH6+h1q7mH3eU+PSDzOjTZC4sSUSPBifjhGlSh69wzZvt
 WIVVPFgvQGmnhTgJFhVGy76OW+wGrm0HDq6ZbLQalTvnHF1Ydr/yAx7JyAbTmLqIz4RZ
 FtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793387905; x=1793992705;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qFODCIZb0hmj4TrLL285AXSEafHx13MiO/lT5KKHhgY=;
 b=kfyUcdWDjajwTVSASHgAuLtCnyEV6p+KKSJi3c1Tk1Gk7bbv8ICk6nVOrSPCfDs9DU
 V5XVBpnb71csoepINOyghVsLlW/cd1bI4nbfyWFPu/+5FCuCS+WWrqXrlMXCg9AFSzE3
 KLb3WzaXHiWg9t4rBR9c8nBnc3XuSqCWM2yoZ1P+F3b7JhYQjdQ7xuFg+uMV26H9qSt3
 3KHHDU/vyeMx5KTEXfIHdzlsrB/aFZbF04DRv5L7qU3R+6u6nIm3VMJ7nV/kcgG0poO7
 S07OcEulsE8RvftJCha981auRJBMnL5dq/Bs1a4bJ0iuXDCdaotZE/oNbtiD09aVbFaz
 EX/A==
X-Gm-Message-State: AFq9FYIRhnw4KuX+BqgfT41uUWbn+6Vd/zUmd9S/6VQot4pqjOxBMBqV
 zc9et1WPRGA4Xz/mGP0jCnN3siy4kM19jgrzAn+OMUt9sKMpqx2jpXoXXK3V9uqJ+q+f56iDUEZ
 7sTV48o3QqpnlB+nWFs55/dBo0b/AIkSY/L88XeU3+hltUjUz/5l73c7LuUfDrg97qJuVNQE1P3
 SUD+qiYA==
X-Gm-Gg: AYBFou1YxnsX2CTVmEEeSxOQLZ7fPcgqrSnMrRnOHipnfPitsnNroV9YNvUDfxmALF0
 WQ5L/1o1UpvBav1ll/1PPoT9AYqY/uClILA9B3MoxNclTigsQOndb6Lt3utCVJI1zQ7Nk3li7jC
 B8OfgyU/t7k//QeenUx0bsXpPQmd73jIxulEd0ZLivlw0VW7oeWuOib1B3+b8FlhVKDtS9CAFUW
 iHoLfdSpEUiNnbXQS8Dl1tupDf0pMmA8uOJiBgd8U142UXZzaEEHqpkkPdwHnTRiVI9BmkWG4U3
 sbBX/OU6Ld4GjsLYganulWIBwcCa9C5i1NEUonaqnjnBDyEzdSrN4Keo2HvBPpR1iT53GaxICUN
 3DHIdRVCCoJ86uXcR5cAFKHdwatC6y8sM2OSRVv0KJVX5oAmj1sT51ltdy2Ky931wDFlUK9OCSg
 1XwI5rScl451o/l61CTw90cfndI//Pu6MfdmWPI43nUc+M7SqrvuSFQt/FU4Q5htmm3h4iOxs3b
 1OUXQtloTtRqQ+pLvhL+q72ICb/XYDCrTrZSSYLLvcijwamlGABfAUlQ5JrCeqaYIJzbjnWGv7s
 gaOTFsWJ1fDDX/8Dn4AfYg74WBvZm3XS+EWr05WIPfkw1cvj/tYBpVQzTY1eAmOR/Z/NT92VYiK
 rXZsmjvkHnx7BVi1s7ShRYKrl+3VKrqJ+oxCTDXCR68ZQOhcYgQQnYeb3chgxnY/kZOJPu9Z5Uo
 frviQpLynHJsnC7FE=
X-Received: by 2002:a05:600c:a00b:b0:4a2:180b:3153 with SMTP id
 5b1f17b1804b1-4ac185bcc7dmr82633365e9.14.1793387905230; 
 Fri, 30 Oct 2026 12:18:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac0950d533sm45355465e9.3.2026.10.30.12.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 12:18:24 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 19:18:23 +0000
To: Heiko Hund <heiko@openvpn.net>, Lev Stipakov <lstipakov@gmail.com>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ifa4497963989c2d6ba68d75942d368c112ac6f67
X-Gerrit-Change-Number: 2038
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2038?usp=email>
X-Gerrit-Commit: 2509ba899f8753f7f1d74812214f2847f9e7daaa
In-Reply-To: <gerrit.1793045668000.Ifa4497963989c2d6ba68d75942d368c112ac6f67@gerrit.openvpn.net>
References: <gerrit.1793045668000.Ifa4497963989c2d6ba68d75942d368c112ac6f67@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDQ1NjY4MDAwLklmYTQ0OTc5NjM5ODljMmQ2YmE2OGQ3NTk0MmQzNjhjMTEyYWM2ZjY3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d78813ae485bde4af9d4084e743932958d3bb632-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMs7T-000000006bP-3wTi
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: win32: pass the
 buffer size in bytes to get_openvpn_reg_value()
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3819812135265815631=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3819812135265815631==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GgWVf0/9mPc="; charset=UTF-8

--GgWVf0/9mPc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Heiko Hund=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2038?usp=
=3Demail )

The following approvals got outdated and were removed:
Code-Rev=
iew+2 by Frank Lichtenheld


Change subject: win32: pass the buffer size in=
 bytes to get_openvpn_reg_value()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

win32: pass the buffer size in bytes to get_openvpn_=
reg_value()

get_openvpn_reg_value() expects the size of the value buffer i=
n bytes,
as documented and as RegGetValueW() expects it=2E All callers pass=
ed the
number of characters instead, so only half of the buffer was used=2E=


Pass sizeof() of the buffers instead of _countof()=2E

Change-Id: Ifa4497=
963989c2d6ba68d75942d368c112ac6f67
Signed-off-by: Heiko Hund <heiko@ist=2Ee=
igentlich=2Enet>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2038
Message-Id: <202610=
27130054=2E2283-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40198=2Ehtml
Signed-off-b=
y: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/win32=2Ec
1 fil=
e changed, 3 insertions(+), 3 deletions(-)


  git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/38/2038/2

diff --git a/src/openvpn/wi=
n32=2Ec b/src/openvpn/win32=2Ec
index fde6412=2E=2E3af58ed 100644
--- a/src=
/openvpn/win32=2Ec
+++ b/src/openvpn/win32=2Ec
@@ -1491,7 +1491,7 @@
 set_o=
penssl_env_vars(void)
 {
     WCHAR install_path[MAX_PATH] =3D { 0 };
-    =
if (!get_openvpn_reg_value(NULL, install_path, _countof(install_path)))
+  =
  if (!get_openvpn_reg_value(NULL, install_path, sizeof(install_path)))
   =
  {
         const WCHAR *ssl_fallback_dir =3D L"C:\\Windows\\System32";
  =
       /* if we cannot find installation path from the registry,
@@ -1585,8=
 +1585,8 @@
 
     /* Attempt to retrieve the trusted plugin directory path=
 from the registry,
      * using installation path as a fallback */
-    i=
f (!get_openvpn_reg_value(L"plugin_dir", plugin_dir, _countof(plugin_dir))
=
-        && !get_openvpn_reg_value(NULL, plugin_dir, _countof(plugin_dir)))=

+    if (!get_openvpn_reg_value(L"plugin_dir", plugin_dir, sizeof(plugin_d=
ir))
+        && !get_openvpn_reg_value(NULL, plugin_dir, sizeof(plugin_dir=
)))
     {
         msg(M_WARN, "Installation path could not be determined=
=2E");
     }

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2038?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: ne=
wpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
fa4497963989c2d6ba68d75942d368c112ac6f67
Gerrit-Change-Number: 2038
Gerrit-=
PatchSet: 2
Gerrit-Owner: Heiko Hund <heiko@openvpn=2Enet>
Gerrit-Reviewer:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Lev Stipakov <lstipakov@gmail=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--GgWVf0/9mPc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Heik=
o Hund=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2038?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">win32: p=
ass the buffer size in bytes to get_openvpn_reg_value()<br><br>get_openvpn_=
reg_value() expects the size of the value buffer in bytes,<br>as documented=
 and as RegGetValueW() expects it=2E All callers passed the<br>number of ch=
aracters instead, so only half of the buffer was used=2E<br><br>Pass sizeof=
() of the buffers instead of _countof()=2E<br><br>Change-Id: Ifa4497963989c=
2d6ba68d75942d368c112ac6f67<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eei=
gentlich=2Enet&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ec=
om&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2038<br>Me=
ssage-Id: &lt;20261027130054=2E2283-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: h=
ttps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg=
40198=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;=
<br>---<br>M src/openvpn/win32=2Ec<br>1 file changed, 3 insertions(+), 3 de=
letions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/38/2038/2</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/win3=
2=2Ec b/src/openvpn/win32=2Ec</span><br><span>index fde6412=2E=2E3af58ed 10=
0644</span><br><span>--- a/src/openvpn/win32=2Ec</span><br><span>+++ b/src/=
openvpn/win32=2Ec</span><br><span>@@ -1491,7 +1491,7 @@</span><br><span> se=
t_openssl_env_vars(void)</span><br><span> {</span><br><span>     WCHAR inst=
all_path[MAX_PATH] =3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (!get_openvpn_reg_value(NULL, install_path, _countof(install=
_path)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ge=
t_openvpn_reg_value(NULL, install_path, sizeof(install_path)))</span><br><s=
pan>     {</span><br><span>         const WCHAR *ssl_fallback_dir =3D L&quo=
t;C:\\Windows\\System32&quot;;</span><br><span>         /* if we cannot fin=
d installation path from the registry,</span><br><span>@@ -1585,8 +1585,8 @=
@</span><br><span> </span><br><span>     /* Attempt to retrieve the trusted=
 plugin directory path from the registry,</span><br><span>      * using ins=
tallation path as a fallback */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    if (!get_openvpn_reg_value(L&quot;plugin_dir&quot;, plugin_di=
r, _countof(plugin_dir))</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        &amp;&amp; !get_openvpn_reg_value(NULL, plugin_dir, _countof(plu=
gin_dir)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!=
get_openvpn_reg_value(L&quot;plugin_dir&quot;, plugin_dir, sizeof(plugin_di=
r))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&am=
p; !get_openvpn_reg_value(NULL, plugin_dir, sizeof(plugin_dir)))</span><br>=
<span>     {</span><br><span>         msg(M_WARN, &quot;Installation path c=
ould not be determined=2E&quot;);</span><br><span>     }</span><br></pre><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2038?=
usp=3Demail">change 2038</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2038?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchs=
et </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: Ifa4497963989c2d6ba68d75942d368c112ac6f67 </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 2038 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerr=
it-Owner: Heiko Hund &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;=
frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>

</body></html>
--GgWVf0/9mPc=--


--===============3819812135265815631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3819812135265815631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3819812135265815631==--

