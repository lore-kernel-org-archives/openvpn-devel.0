Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EB7606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Ag016nbg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kaAJzuKx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AzCfFMdN;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ZG2nUaQG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=sKnXqdWbZoTdB4KdJDSqYGvOnm6OYWvUs1CqRh/RC4g=; b=Ag016nbg2+CI/eYqEuFlYVRjCJ
	JscLwq6QP2lxc0aCiLS5AI8KxfwHB2onEItWa1MPiX7dtrPD87RFZiVNvxRLRCzTj7GnJYXt9zY9a
	8oM5YNHk5mHeBeNyeIefz6dRyEFkgUB9P/CLSV6A/AWHyufiB9/PEp9HvRhPxC9sBM6M=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRTqH-000000002aM-2JK2;
	Thu, 12 Nov 2026 12:23:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRTqG-000000002aF-0KgV
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 12:23:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wm411/cepXguLjXlgInOwqC9a/YOk6toNfbfTzRFK54=; b=kaAJzuKxecnC5AStEgoV+p41De
 5ys45g7D8kiJuUpVI3vUM3citVgytk7prvu7/ZCbBztTuRF5qlLdVTgifazntQHQs81vVqRkDhxwJ
 H0IqWEtJzGkG9qjPcKRYxM2uicUBmS4psCtG1q5cnXMGTlRoa4MWJ86y/txj7tW0wBxM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wm411/cepXguLjXlgInOwqC9a/YOk6toNfbfTzRFK54=; b=AzCfFMdNR4hzhG4+PH1fIvfjay
 ID5qHpPfYrVje6x+3doCz7B4pHjPs26LsWTF1t7noV2uiDTsTWEAAMpqcZZI7fqwtGkaDwRklnsJI
 fwAvGMdYqIex1dLnXVgXFKyZU7GkRCfjs8l8k1iaFQBIF4B28ZnjvUfYgL05ysslSLLk=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRTqF-000000004cs-0u21 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 12:23:48 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so29059965e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 04:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794486221; x=1795091021; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wm411/cepXguLjXlgInOwqC9a/YOk6toNfbfTzRFK54=;
 b=ZG2nUaQG4r5Wqr3uJs9t0OwbJMInZPVX3TNXqdAI29joW8x4tVsl17cwYRlfjfmWJM
 yZj8RDRqxDse4Ie5Zu1NXi85fxKqR/TKT5PtQa2B+IeALv5wCBQz8gVdIOLzY00cCadn
 7NRCWMoDGEItyto5Jc/qsZoAJA+9NDgKPxSyU1GWIouacy7rXee5W+r6Ug5PWxIRcITl
 FNQOtZjrM7Wzxm/MWtoazE0oetici+F4usR4nfl/thadyR/jQAfACGFZYsSts66VAM//
 +DYzPQk1RejFYeebYdskkZ9nTxC0y0RpTpdiW0Jykt1ttLsilE7VKNTQH3xS7iLlbhQc
 Jcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794486221; x=1795091021;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wm411/cepXguLjXlgInOwqC9a/YOk6toNfbfTzRFK54=;
 b=bxu9l0wbD2+Yje1YdWANOgTDhChg02NQBcuPf6pMf8YflBg8l1kSySw7nABNmu3MOy
 WWRo0Ae6BSlWultwiU4QeW59hcL8LjqQuoGojEntmc7BUP6s/EouxIkqrlq6wLawfNl/
 INfSUyoJA9zFeL4KNZO9v1K1uVIi1mPrxF5bhPbtxxGy5qfiWlULzV5T4gNMErqfp6Aa
 fRb+DGGApATuQ6gNdqxMwXJLZ/KOAiVip2W47kpWn76GLjqkNK1LsWl20rmUxedV7KYu
 +5nYvPatB22RnnrbjGL47Fwk98zhWbyIijxc/h1Mq8M3RDD5faEHoFJu1qtm63wXqbgv
 npkQ==
X-Gm-Message-State: APuU4Z+j6n+NyAzjT88F5DofAE1L9fjF+jl6Bdilo+lkXS/0jduJrND1
 DfRA7EIhsHk+7+q8tp4WH3Ya5BSYqBHal4ijtJj5coY7PUwdBL5qGz64gBOUW+urKw1ns/BBtE6
 mWzoy0Ohz9ySaAOiSg5Lkbi9bD+l6p1Bv3RB1bzgjmdLSgaK+IIgq/bePpb6yt+AgLEHSwFA2NU
 5jqxG8Yw==
X-Gm-Gg: AYBFou3pvOWugBwSZPOXpAK/r/+i0OO4GgwPkuqQf6Nprffg4ZdDUu0a8VguPMblYOC
 5sjf/840Vals2Rb70J2TE9snIzDy0DnpxTmCN0P9jjcRBP+Xkf1Uga1dNzU3klrgzo32eCNgWJi
 TgCfK01RRrBy03vZBkn06eHsB63ym9FA221DQ8o3oD8D1hpnLSJuNwEREkACi7pIWuIKmaM8ZBu
 PE6tJHOeFTZSF0tnrtjL/GImnVd1y3A0VFHmFl35Q1sWIgkz4v3skb8mYwXJw0GA+on9kRp6J+X
 SDLUvYVfmp6WfgcfhoEXkGUDW0AOmU+jLqbnPYnd/wn6eGp83EPoEI1Wua1NZIVOzNXE7WQG4tJ
 /hhPlPM9o8qK4luXmPu3iOC9KNnCTbPSwaZ9h9rqybS9YNmImzE+sALUqv4GSnc2z4bcHW40k+U
 sE/5VJNMfTo3726tN9RNuW+vG3s98mFXYnczf4PhDoN5rbabFWMkZuqVeYKFfeGJD6KzoRpsg+R
 CkSA+NZqC/E2LyHvgowjO0+k8pgqarySKN+heetspSNhDTnNq7pDC8bZOK6mquDgQsMTWxqfuqO
 ZwSeENiUzEW8aeH+Es0or20HWTwoKMuCfDIBv6INjaXdu+n3L05o3LUn/Fll47xrQbyRymG1GOe
 EkhCcBCPDcFackZDUOyAZD51MWGx0Pt0qwnDojGAPdPXnLYVAeEO9+cu484/O9lmQIdnOaUKNIy
 2z3IgleqS/FUlXaZyjgGHEujcx9ui14GoPaopI
X-Received: by 2002:a05:600c:3b01:b0:4a2:a3b:7aa8 with SMTP id
 5b1f17b1804b1-4ba09344326mr98601395e9.3.1794486220451; 
 Thu, 12 Nov 2026 04:23:40 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e267dcdsm62970325e9.11.2026.11.12.04.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 04:23:40 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 12:23:39 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie87632ae3503f4c74b327186e6952f66ada66640
X-Gerrit-Change-Number: 2178
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2178?usp=email>
X-Gerrit-Commit: 7b3750941fae3ea385d73250bc8b599700c20a1c
References: <gerrit.1794486217000.Ie87632ae3503f4c74b327186e6952f66ada66640@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDg2MjE3MDAwLkllODc2MzJhZTM1MDNmNGM3NGIzMjcxODZlNjk1MmY2NmFkYTY2NjQwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a61c1fe6db241c224416784b6521b3cffff7209b-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRTqF-000000004cs-0u21
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: xkey_digest: free
 the EVP_MD when EVP_Digest() fails
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
Content-Type: multipart/mixed; boundary="===============0599376182499925979=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0599376182499925979==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jWPfFR7GGdk="; charset=UTF-8

--jWPfFR7GGdk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2178?usp=3Demail

to review the following change=2E
=


Change subject: xkey_digest: free the EVP_MD when EVP_Digest() fails
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

xkey_digest: fre=
e the EVP_MD when EVP_Digest() fails

The error path returned without EVP_M=
D_free()=2E

Change-Id: Ie87632ae3503f4c74b327186e6952f66ada66640
Signed-of=
f-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/xkey_helper=
=2Ec
1 file changed, 3 insertions(+), 2 deletions(-)



  git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/78/2178/1

diff --git a/src=
/openvpn/xkey_helper=2Ec b/src/openvpn/xkey_helper=2Ec
index 6908cbb=2E=2Ef=
b088a8 100644
--- a/src/openvpn/xkey_helper=2Ec
+++ b/src/openvpn/xkey_help=
er=2Ec
@@ -71,12 +71,13 @@
     }
 
     unsigned int len =3D (unsigned int=
)*buflen;
-    if (EVP_Digest(src, srclen, buf, &len, md, NULL) !=3D 1)
+  =
  int ret =3D EVP_Digest(src, srclen, buf, &len, md, NULL);
+    EVP_MD_fre=
e(md);
+    if (ret !=3D 1)
     {
         msg(M_WARN, "WARN: xkey_digest:=
 EVP_Digest failed");
         return 0;
     }
-    EVP_MD_free(md);
 
   =
  *buflen =3D len;
     return 1;

-- 
To view, visit https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2178?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: Ie87632ae3503f4c74b327186e6952f66ada66640
Gerrit-Change-Nu=
mber: 2178
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--jWPfFR7GGdk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2178?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">xkey_digest: free the EVP_MD when EVP_Digest() fails<br=
><br>The error path returned without EVP_MD_free()=2E<br><br>Change-Id: Ie8=
7632ae3503f4c74b327186e6952f66ada66640<br>Signed-off-by: Razvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/xkey_helper=2Ec<br>1 fi=
le changed, 3 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/78/2178/1</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/xkey_helper=2Ec b/src/openvpn/xkey_helper=2Ec<=
/span><br><span>index 6908cbb=2E=2Efb088a8 100644</span><br><span>--- a/src=
/openvpn/xkey_helper=2Ec</span><br><span>+++ b/src/openvpn/xkey_helper=2Ec<=
/span><br><span>@@ -71,12 +71,13 @@</span><br><span>     }</span><br><span>=
 </span><br><span>     unsigned int len =3D (unsigned int)*buflen;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (EVP_Digest(src, srclen=
, buf, &amp;len, md, NULL) !=3D 1)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int ret =3D EVP_Digest(src, srclen, buf, &amp;len, md, N=
ULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    EVP_MD_fre=
e(md);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret !=
=3D 1)</span><br><span>     {</span><br><span>         msg(M_WARN, &quot;WA=
RN: xkey_digest: EVP_Digest failed&quot;);</span><br><span>         return =
0;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    EVP_MD_free(md);</span><br><span> </span><br><span>     *buflen =3D=
 len;</span><br><span>     return 1;</span><br></pre><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2178?usp=3Demail">change =
2178</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2178?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Ie87632ae3503f4c74b327186e6952f66ada66640 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2178 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--jWPfFR7GGdk=--


--===============0599376182499925979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0599376182499925979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0599376182499925979==--

