Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335F7606A338
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RNtmyK4y;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Mo57Go0n;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=m9pbPE38;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=gumNbSLK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=syZ7Pldv9Obb0Bb0gw7SqgK/oPUozxdHrvNh6NSUntc=; b=RNtmyK4yAn+8n1pHvZgW2eannp
	fX+b5G+LX9GJzQSFB4kOeJCUpq+MhVYyrma5QtlXTbqcFVsa5eZJUFvCqaVEEG8FQNi2E3kmxyYX8
	ayMcu7dgLRN6hK6fxALSj7SuDOqhpcVj/SdAwiQ8xE23ETreJNVkJReuGlg1UaGV7+48=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOeGz-000000004mE-3k6n;
	Wed, 04 Nov 2026 16:55:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOeGy-000000004m8-1WGf
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:55:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HVidVtPAg2mwTfLIPV9tlvzaWS9dJ6fATSkh3XAgtFI=; b=Mo57Go0nflPfZWNKFj7WQh2chR
 Hc9lN1NYjQug5L6qMsOjHPzc2/HuYJBJ60z1z8s7+AoKJ0g6QRFwPEp1FLrQSfd2fQsdYIw6PcdZ8
 TaL1dDuChx6MM5jYUJHFgQOKu06TtNfYBiW+x+eC0Qkcx6gG8zgrN0aaL7IVimIM4oS4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HVidVtPAg2mwTfLIPV9tlvzaWS9dJ6fATSkh3XAgtFI=; b=m9pbPE38T7G3mOKK0hSIlA4tb2
 MEhZrdjdC22985MkzNxHlDzhiJtkpe8Z+JdC5sM2aJlJG0KPqZw+YAVYjWoXoOQGW6V4N4KRfmNZl
 ZMTNWuSs2bKj4YKRbTfiaZJVv2/x1GTEDGPk4omup4TzVLNQmNGDItDkwXUTwsEwU+ig=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOeGv-000000007H0-1w7t for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:55:40 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so239959f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 08:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793811331; x=1794416131; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HVidVtPAg2mwTfLIPV9tlvzaWS9dJ6fATSkh3XAgtFI=;
 b=gumNbSLKtlt0Z5wNfsHKhE7UKTgQYksJjb+ZrAUcD+/g4U1rCcdw4DxjAwCMQFobCN
 wvS7d68iGakMHelusVwNrV3JLUk4uN1Jca9qw0xyBVr4rq6c6qbdUYBWjSTGA+lq7Ga3
 2wO95W7xc1K/JQaBGY8zovFtJCp2eLiKmUNI0U/YHC0aPMqTE2wOunXIvPCqJ+DBMQfz
 sjTQcQgACFJiintQadUYCKNDwwgtOl9WMI78VHybQF9ah3lXsjP3whRmBjLlLWwdGeHw
 NV9aoPGhurs7446WKKSIrktKEDvn384zyYvO6FJwiboN5q/654osytCqRpqAzXR2w5Cc
 VaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793811331; x=1794416131;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HVidVtPAg2mwTfLIPV9tlvzaWS9dJ6fATSkh3XAgtFI=;
 b=OPr03KO8D0g6r1VSyRTUsi7orEfc5f8Us9yKYYi4DJDmMJOdTDo1zPpaKeMGoG+JTD
 /76KCGyAeN+w57PQDIbnrKBbPCb+QmO/otrACbOY3KszmK1VP4Qh3W1eFqeM5XHVwQQv
 PqOvvJHZY1tIetF6TYikkoHHGpI0HyregrGfbegB6d3phDLz+Is3ZA94n142O7eyxI3N
 ZYWkh4vtjDF2kZj56gN7qiI2aNOeVrs0GSa3qhfa6w5GJQwlPeSIGJIDXXis+JrMmLUa
 zOKA8crn+LAineRYVNVzDfBaZ0VtiFj9G+Y0IXEMd1B8wJy2kIdCknj1ElzFQRY/h3hn
 q5ow==
X-Gm-Message-State: APuU4Z/NX1f7yb+UWoHT4fynJPwc8ZlGCYhBW+t6LlxzGWOzh5JV1V0U
 GUGcneqr6OWPMdCgUks+xHIcoG6RZCUeEMS3puzUZqz6Vn1Xct8leWTUkGMHTq8D6vnKCQiQ7gK
 nmqvNVXrayEHtsXD0IVWz27BlokbLHhbQTqqlyQXrh+jsxBrRGuJG/XM31ZSQ4u7j06Kz
X-Gm-Gg: AYBFou2Oi2Uh4UkTuWqNVEguSVM6EBlQhJGYFpqY4E0g6EnW/TNi6lq04oRvJ6OiMtv
 i62XKCyjdxn5pYLkv7eX+ya7mjzF3VGPJeTRNmei8ubBWEkrwSs1UNhjJrKbPyPBeL1JQpITz4T
 Y4FeyKa1/eCR2m023bp8hbN1OaRsTQOEPp9qUqlno2Tl1IuG96CCxeHQDE/fSwqYLtMtBz4pOgC
 ugEbbz3iZG/+1K6WsSKQmffdGVWFVmQ3ZZsG1rivvcEiv2rxeIdwEeqgY8/Hbcx+8HLAQIxXMkM
 JSAGE5LxornHmYoH1NgupGgOg+1Ykl47jdTUb6qH8rg6CnPEZhPgZ8gmx+umGyTZpdzkxiZquNL
 tn/SzpvGCn1JFjKiNM12XxOujoXd2qNN3zERMmLzMEp+zgoJKupfWW3SD0kIfX7rruuygodmoxo
 J30ioaKT/FPLtYM/P2ZmZI2RxO3noBHm7eYml3uA0W1JugwEMKe64qcTx3Kc8ZNE/dsc5WUP6B/
 GubkJt6xBrR7o4kVqajAoVVmaiLUHwPgKwa3dzMOhBL7AyqqruPl4f57G3Bqdg24Dx4u7hy4yf4
 qMPo+PKARYnvYoc+DV5/fEiZfcEWHM8GsZun20QchqALFe4+7yrdhSLSc+3R2yAeRKwzIfzNOl0
 zFQSUeir0LeTUp9lwtOc7dGKLfxnL2h4C2VVr212G2EPVBVf4MJ2CG5yUcp0bJbTJpYIsFARUnW
 XhXkCmTbXF1sErOClhT1Q2sBh8P28Q1s0q5S8=
X-Received: by 2002:a05:6000:4311:b0:48c:4f94:222f with SMTP id
 ffacd0b85a97d-48e6e2eb446mr35085373f8f.17.1793811330726; 
 Wed, 04 Nov 2026 08:55:30 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fece99d67sm4860771f8f.24.2026.11.04.08.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:55:30 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 16:55:28 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I2d677eeb6ae9186ede2aeb3c2e0c12d25c935fcd
X-Gerrit-Change-Number: 2127
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2127?usp=email>
X-Gerrit-Commit: 6649526a4da30e3234ec3386133c50b9c5e83a17
In-Reply-To: <gerrit.1793781422000.I2d677eeb6ae9186ede2aeb3c2e0c12d25c935fcd@gerrit.openvpn.net>
References: <gerrit.1793781422000.I2d677eeb6ae9186ede2aeb3c2e0c12d25c935fcd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzgxNDIyMDAwLkkyZDY3N2VlYjZhZTkxODZlZGUyYWViM2MyZTBjMTJkMjVjOTM1ZmNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <762bf20b26d5e609422ed76ed7cba2a299af26ae-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOeGv-000000007H0-1w7t
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tun: return NULL
 when the second adapter info query fails
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
Content-Type: multipart/mixed; boundary="===============1402918881438183928=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1402918881438183928==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BUgFEOAc0NA="; charset=UTF-8

--BUgFEOAc0NA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2127?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: tun: return NULL whe=
n the second adapter info query fails
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

tun: return NULL when the second adapter info que=
ry fails

get_per_adapter_info() and get_interface_info_list() returned the=

allocated but unfilled buffer when the second GetPerAdapterInfo() or
GetIn=
terfaceInfo() call failed, so callers read uninitialized data=2E
Return NUL=
L, as get_adapter_info_list() already does=2E All callers
check for it=2E

=
Change-Id: I2d677eeb6ae9186ede2aeb3c2e0c12d25c935fcd
Signed-off-by: Razvan =
Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichten=
held=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2127
Mes=
sage-Id: <20261104124842=2E18381-1-gert@greenie=2Emuc=2Ede>
URL: https://lo=
re=2Ekernel=2Eorg/openvpn-devel/20261104124842=2E18381-1-gert@greenie=2Emuc=
=2Ede
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openv=
pn/tun=2Ec
1 file changed, 2 insertions(+), 0 deletions(-)


  git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/27/2127/2

diff --git =
a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index 225d8b1=2E=2E7637dc0 1006=
44
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -4129,6 +4129,7 @=
@
             {
                 msg(M_INFO, "GetPerAdapterInfo #2 failed =
(status=3D%lu) : %s", status,
                     strerror_win32(status, g=
c));
+                pi =3D NULL;
             }
         }
     }
@@ -415=
8,6 +4159,7 @@
         {
             msg(M_INFO, "GetInterfaceInfo #2 fai=
led (status=3D%lu) : %s", status,
                 strerror_win32(status, g=
c));
+            ii =3D NULL;
         }
     }
     return ii;

-- 
To vi=
ew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2127?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2d677eeb6ae9186ede2aeb3c=
2e0c12d25c935fcd
Gerrit-Change-Number: 2127
Gerrit-PatchSet: 2
Gerrit-Owner=
: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@li=
chtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>

--BUgFEOAc0NA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2127?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">tun: return NULL when the second adapter info query fails<br><br>get_pe=
r_adapter_info() and get_interface_info_list() returned the<br>allocated bu=
t unfilled buffer when the second GetPerAdapterInfo() or<br>GetInterfaceInf=
o() call failed, so callers read uninitialized data=2E<br>Return NULL, as g=
et_adapter_info_list() already does=2E All callers<br>check for it=2E<br><b=
r>Change-Id: I2d677eeb6ae9186ede2aeb3c2e0c12d25c935fcd<br>Signed-off-by: Ra=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld =
&lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2127<br>Message-Id: &lt;20261104124842=2E18381-1-gert@greeni=
e=2Emuc=2Ede&gt;<br>URL: https://lore=2Ekernel=2Eorg/openvpn-devel/20261104=
124842=2E18381-1-gert@greenie=2Emuc=2Ede<br>Signed-off-by: Gert Doering &lt=
;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/tun=2Ec<br>1 file chan=
ged, 2 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/27/2127/2</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index 2=
25d8b1=2E=2E7637dc0 100644</span><br><span>--- a/src/openvpn/tun=2Ec</span>=
<br><span>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -4129,6 +4129,7 @@</=
span><br><span>             {</span><br><span>                 msg(M_INFO, =
&quot;GetPerAdapterInfo #2 failed (status=3D%lu) : %s&quot;, status,</span>=
<br><span>                     strerror_win32(status, gc));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                pi =3D NULL;</span>=
<br><span>             }</span><br><span>         }</span><br><span>     }<=
/span><br><span>@@ -4158,6 +4159,7 @@</span><br><span>         {</span><br>=
<span>             msg(M_INFO, &quot;GetInterfaceInfo #2 failed (status=3D%=
lu) : %s&quot;, status,</span><br><span>                 strerror_win32(sta=
tus, gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   ii =3D NULL;</span><br><span>         }</span><br><span>     }</span><br=
><span>     return ii;</span><br></pre><p>To view, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2127?usp=3Demail">change 2127</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2127?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2d677eeb=
6ae9186ede2aeb3c2e0c12d25c935fcd </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 2127 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt=
;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--BUgFEOAc0NA=--


--===============1402918881438183928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1402918881438183928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1402918881438183928==--

