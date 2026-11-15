Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A92606A31F
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 21:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=D9Wn3vZR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JZAkkvAk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GAboiIwX;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=FxB27QAm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=H4nU7tf05Mra6Ghkj19Ccv7uI4MmEFfEukZUoRmvHR4=; b=D9Wn3vZRdHHF9jEO6FCjZd6VH7
	T7BBsieczEsaGLhvt7DlRZ1zWViPOd9bvpTnTsxiRltCP3MSA8a4V+LfJRp8ayzxVtdkVITRFoUgx
	3A3kD7kCkbCnBD7o+xAwKAEKpealy6tig2SMMXi+6xh08t+PhLcuu/tFVClm4zHr1Q5Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSi8y-000000003FP-0DQf;
	Sun, 15 Nov 2026 21:52:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSi8w-000000003F9-3mMa
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 21:52:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZBN9lYBkDWyrDtume7jW9/jHSPffjn51E4WSrJeCaak=; b=JZAkkvAknBwjIBA9o+x4XVEibU
 08t+IBlwFSxicE47Dq9y3rCcDM3gPtdKVSTWqPEyd+rfS0v+qILRV5D8LytB0Y1CDwrJdQix3GBCL
 B4aVVi+pjV59c0neQBCjsqJwcLQs4IMkxeeG+3HPp/IJWs+B3MWJAqf3AGijoY55R7wA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZBN9lYBkDWyrDtume7jW9/jHSPffjn51E4WSrJeCaak=; b=GAboiIwXdw3vUGkwmwMkLYgs4Z
 HRbv/dLeHSEDk5wnNxOBx/XmmQm+Rd3AUcTqv8Lp3e13AEphjCQeYiu9nYOmyxGmFj10189CF6Ur3
 k+6O3+Tt4w2pO+PRnRrqQQl5nqRNaH6U+Ba7FFjsEvx7+jqHQiLBB4tu8O/LjW3p4b/0=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSi8w-000000001s7-146I for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 21:52:10 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4bb55cda775so11884315e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 13:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794779524; x=1795384324; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZBN9lYBkDWyrDtume7jW9/jHSPffjn51E4WSrJeCaak=;
 b=FxB27QAmjKXkhKmPZr7NZvTuEm+Wd4Mp6qJhMrVub9rrrFYPWqDjY2T2/doo8qI2qf
 55cxkvsdh7gxAf/wFj160LaaODVx2h3Wsq206376j5g5VpEL9t7cDXhuljDVGEePrKLP
 tXptWHrD7k58DX+wFpReaELewGXAjaCqaEDs1/Le+EWh+D3rk2mL/M5fJp9UmaROvfwr
 PgqSuKWu0rsp/DCLwY5AixkWVchn2t92S4HJRemBOwOeA4wqcWBzzW+YdpSwnj8L9pXj
 Pz9jPVycbLwEXgbzrls8orbbPSQ1KGGiv/2GwQAy+fUTna4MJtbrPbz3K0V3ZPHjZBgL
 j4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794779524; x=1795384324;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZBN9lYBkDWyrDtume7jW9/jHSPffjn51E4WSrJeCaak=;
 b=pN/CRKWVjcVIMBwMWzjLP8ssDRxXWWO/0t9NaqX4ruW2Zo7LlSbeeywz09oOrW+M8/
 N9CiXpK61PEV645XgW4jh8mkYgm6YmOnOguqaVNcTN269d5IeCNGHI/qFE3w/QyUlRXI
 NcDeV0hsa6GatYEvbhj++T4SUDhuS6kQvk0pMayBAiKaW7ngHaa3GqWPshvXR1HHE9Ze
 DeZbVdMQMVGgK0CSX8DvsKNWYYo50BzSfbn2UPLJVdhFv6nMvxYy/a2EFFVBDXEnNHxc
 Un+BjljhSM0smrcVAbnnPbZXrPxhUmveVBqFPnLFfBujZ64m9Yod5Y1RIzXuuh3+RL6T
 RGKQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEH4MrlNl7ICm3ArrgTnSA9v0r5If08E3tajHyXRGdljT+cSDlTJ6ITQr0JqiDvVb7I2a5KQMNpWXIEo6Nl@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9MYNygnf8ZEDntzHYB1IUsffXFcm0g/yT+dyS48lH07dusKmia
 OlWoGhT2ZRpa4p8miyuahY06TGWX2yyI3tHRVBBFAE8yNs/DKpb/Tbl8TlfFou5OaLiKU2kMq7r
 Cq6pFaoVqR6AoUeaSsmE4CFfkzEn0kybyA2vPH6E3lZZajMpZ+mKQIGurtFkDMXHCBQLr
X-Gm-Gg: AYBFou2HuCjEWSkwhQkDkBdWFE5Ly/K0bEQX3gvZauJsE8g9XQx6IW7Lxd9Hfaz2933
 IghOT0vByMtlCs9Gr8GFZkmYxrOSSKAsVSpa29GkwxFKrQVJEe8/w+Z5pZg0he7VTzBfTlbgdOg
 TLeQwnqMwaMiT938bRCSzHMqCJRRTL0uDQPK7AzUW5OmsKLV4yTeSNb5Tl4y1ESlgnJZEVIXGH5
 j3Oq406wBp5WnzF44JSVza0nUoGjitrVM2/Axzxi2CLeWZjJ6uXFbAdTOBB+9Dslxa0og61hPJ6
 XK6dmoY/RhzpAED5VaOxdBSoGmM4EndNfHbrEjvGl8iXjqnXKKT/A6tmfrMGAEfV2hp7iQKhSSr
 Tydj/z27i4Iu5macPwXwG0chjpMCSoW3203h8qOZH3YszMthkboqHOac+stTAfg/ce7fHnMHBts
 3/oJ7MNIVo3zPHDaLY1j+84tWBWjUV9fTj89aJyWbxH3G+rN3H/YpG5djp/PwJG1nan8kjW5YJb
 pLrqRBiACqGkdfuUkB0zC5IIOyGCUHIaw178fhUmEqTjJFC6+pS6JN8x1M6u8g6w+FyT4a03sAm
 rC6oxdKWlYv9CExF7HT2ZuIqB6FGleygP7PaDJkbo5xKmPda01jza5KYTiaYbcux8gtoKJfTOc4
 BApt3SA4VOKX3UgyLdeTi51rNPqd4IOcviIuoNQnufgduM4iQuVKH9V2ZC5s0tbh77wb5A0ny8G
 N9HHR0D6fAU6jMGRU=
X-Received: by 2002:a05:600c:5903:b0:4bb:60b3:7ea9 with SMTP id
 5b1f17b1804b1-4bb60b38023mr101498245e9.0.1794779523426; 
 Sun, 15 Nov 2026 13:52:03 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5d22394esm19128935f8f.3.2026.11.15.13.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 13:52:02 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 21:52:02 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib8a47751bb0d559083d1a50aab82c06fb0dad110
X-Gerrit-Change-Number: 2184
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2184?usp=email>
X-Gerrit-Commit: 59e30622405b59197d32d839cf5185521a0b1088
In-Reply-To: <gerrit.1794653707000.Ib8a47751bb0d559083d1a50aab82c06fb0dad110@gerrit.openvpn.net>
References: <gerrit.1794653707000.Ib8a47751bb0d559083d1a50aab82c06fb0dad110@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NjUzNzA3MDAwLkliOGE0Nzc1MWJiMGQ1NTkwODNkMWE1MGFhYjgyYzA2ZmIwZGFkMTEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <28d0168ddb26069b8c5222e0b15f3ec3c3b7e310-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSi8w-000000001s7-146I
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: auth-pam: Include
 dlfcn.h for dlerror()
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5876080421878896086=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5876080421878896086==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kprIrZ6z1Os="; charset=UTF-8

--kprIrZ6z1Os=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2184?usp=3Demail )

Change subject: auth-pam: Include dlfcn=2Eh=
 for dlerror()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


auth-pam: Include dlfcn=2Eh for dlerror()

With --enable-pam-dlopen, auth=
-pam=2Ec calls dlerror() without a
declaration=2E Broken since ce8271f5=2E
=

Change-Id: Ib8a47751bb0d559083d1a50aab82c06fb0dad110
Signed-off-by: Razvan=
 Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Gert Doering <gert@greenie=2Emu=
c=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2184
Message=
-Id: <20261115170015=2E10294-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2E=
mail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41375=2Ehtml
=
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/plugins/aut=
h-pam/auth-pam=2Ec
1 file changed, 1 insertion(+), 0 deletions(-)




diff =
--git a/src/plugins/auth-pam/auth-pam=2Ec b/src/plugins/auth-pam/auth-pam=
=2Ec
index 0cd201d=2E=2E72c047d 100644
--- a/src/plugins/auth-pam/auth-pam=
=2Ec
+++ b/src/plugins/auth-pam/auth-pam=2Ec
@@ -32,6 +32,7 @@
 #include <s=
ecurity/pam_appl=2Eh>
 
 #ifdef USE_PAM_DLOPEN
+#include <dlfcn=2Eh>
 #incl=
ude "pamdl=2Eh"
 #endif
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2184?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: Ib8a47751bb0d559083d1a50aab82c06fb0dad110
Gerrit-Change-Number: 2184
=
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eor=
g>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Review=
er: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>

--kprIrZ6z1Os=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2184?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">auth-pam: Include dlfcn=2Eh for dl=
error()<br><br>With --enable-pam-dlopen, auth-pam=2Ec calls dlerror() witho=
ut a<br>declaration=2E Broken since ce8271f5=2E<br><br>Change-Id: Ib8a47751=
bb0d559083d1a50aab82c06fb0dad110<br>Signed-off-by: Razvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede=
&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2184<br>Mess=
age-Id: &lt;20261115170015=2E10294-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: ht=
tps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg4=
1375=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<=
br>---<br>M src/plugins/auth-pam/auth-pam=2Ec<br>1 file changed, 1 insertio=
n(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/plugins/auth-pam/aut=
h-pam=2Ec b/src/plugins/auth-pam/auth-pam=2Ec</span><br><span>index 0cd201d=
=2E=2E72c047d 100644</span><br><span>--- a/src/plugins/auth-pam/auth-pam=2E=
c</span><br><span>+++ b/src/plugins/auth-pam/auth-pam=2Ec</span><br><span>@=
@ -32,6 +32,7 @@</span><br><span> #include &lt;security/pam_appl=2Eh&gt;</s=
pan><br><span> </span><br><span> #ifdef USE_PAM_DLOPEN</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &lt;dlfcn=2Eh&gt;</span><br><sp=
an> #include &quot;pamdl=2Eh&quot;</span><br><span> #endif</span><br></pre>=
<p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/218=
4?usp=3Demail">change 2184</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2184?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: Ib8a47751bb0d559083d1a50aab82c06fb0dad110 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 2184 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-=
Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=

</body></html>
--kprIrZ6z1Os=--


--===============5876080421878896086==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5876080421878896086==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5876080421878896086==--

