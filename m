Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2245FC5DF81
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=/Dtvqx6j+Jge5Vr6wBdveccKvBzfED5fatMfjZ3EDtg=; b=dNg0c4Re2Gkp43
	lZfktoBqCegJCg/vIbmrjiuZrNv8WJuz5Bcp7MdtQVXJV17ZbBqd0aNa1tLi29yZzSoik8QcwmwhC
	NOfkrIcuW38fFMCtw5GBtsydA4aUtzTxv/E9+kvbtSvD1TN5VohRVS+RYYbezCHt8DyHMehnvrYOT
	3u8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wySm2-0001oH-5l;
	Mon, 24 Aug 2026 11:23:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wySm0-0001oA-P9
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 11:23:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9r986Xz/jC0KQp1alZSeVaAuZitAYwJOYvHu72YnVsM=; b=nVA6ZMRHZu8QVxcOHPe5Gi4Ul7
 isKCyU6V+sO01UcxjoRbRAIuvripLoy3q3dMXpwRs0Bo38+EoaPPfFb6c1GI54lI+USqTlaGKa6bm
 c1fG2LPeduYOXYkdgp2aTW338F4ET394ks/V9cghb4fRvKCe79ahIMk0M3sUGfBiyCuA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9r986Xz/jC0KQp1alZSeVaAuZitAYwJOYvHu72YnVsM=; b=m
 +qAMFZYf2r0E5eEIzAnXrONeurmWda1qOvNh7pjESYHgE2xh+MFR4ZIXK3qIHIohL2rkWJ2LaFs9e
 LtIEQ5ALVuweJygPFth7rYGEoPa7ST+GxMn1JxIu8tLYExOaypZ/zxB5kX7OWbXKvfn+AA5d3C1fW
 TjTiNNlQPZy+TQHw=;
Received: from mail-ej1-f43.google.com ([209.85.218.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wySlw-0006yz-LS for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 11:23:26 +0000
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c15e592da74so463081166b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 04:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787570598; x=1788175398; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9r986Xz/jC0KQp1alZSeVaAuZitAYwJOYvHu72YnVsM=;
 b=dPxlvdlVoMaPIBqYKAG7SE7I/JI4X5wK+g+GVtc/DnwDHD9zwKgpc6ssXtK4amqDHc
 ZywX8phe1ikUo4torsCDJPZ+Box/1IBvS3tQlACuGX/HagxvuN5N29ps3t/o4HwW9hiA
 lrcHR4Qxs6UGASAvtbQZIK23jP2DGhXD28mYCAkMpogR0u4ujLl3ko5vA9K92jLNfPUn
 b+sS/04gG34NIpSeUOyFR1K+AM7RF8IyBMiaMC6D9dpVlR6ar/5JAo149qyHXn57znZa
 YajFPGjHvDR5zl7yQ1uBMXRRksSi162LJkIPcFuQNpqVdPNUDf23hO99GLhpsGD4sfh5
 pvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570598; x=1788175398;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9r986Xz/jC0KQp1alZSeVaAuZitAYwJOYvHu72YnVsM=;
 b=owVdPBkE1Afj8YSRssCrQDd50WIRtgzuZRfmzqhfnLQhMlwKwVB1jI0EnOYnTPLAFp
 11NNMsg0jn6V741fzutirKWAH9eb+Ka1emXmji6BBXCOss2siztKE1BkzWWwOb9bhha+
 w5Q5u9u6Gz/p/5p/ESSjBS96LWy9twtunhNCDV1XsF8bUrOBDKWTkW4xe4jDkdL/b6xe
 ex8nN24vCGLkT6PUs2uzdmapv6yjZk+Hwt69nPfykg7NkhObG4U3hHxQEfy0UH69Bp6d
 eGdZLxPn+Tq1I8WwpkWiJnlzNsA4U4QzMxnFWe/xthO4e/pxWF3jxeLWo5fXCPIRbU6S
 RPyg==
X-Gm-Message-State: AFuF++mThLZPxITC7/YsLB7lm865MQOuVD4fGZfoO9nOdE/351/rbWH/
 hHv+alq08uTwpSVgpXc+NmC8yROrbn8Haxk118PK5YacJgtrAeCrNebaojlxTYWOhx34StMwkxR
 46zI71bNh0UM+xZE6O7MTrVgMc1ANj2xZWbAIgo7jch6HkMvDUBMK25yoeRSjTEKSS6Dug/GyzP
 Gk7gfnAA==
X-Gm-Gg: AR+sD12isoy/HOO/7AC9hYkjh7kP9efmXwVeucJcJ+5HTRRx2TG0iZCWxetpmzuNQJ8
 MVfGDqpWdTFv9SmluaGZnlE8kX5YD6jAMOHD6EDoefH4K4ono3icWyWV3hBofWWR4zCcTxs3JHq
 gcwXxGB6A65C7bOG8MkPFOgsWwRyob59gkSLa5yeMZkcxea386megx7U+crqBNEr5VJZf7t1G6I
 88FkS1zIHAaqeMWesVJZjVdwWS6OlQTG1adNlW+4WK004+P7jqWK1mos9poy2KtjYJMzyXczMox
 S2e609SoBhSuwH3FXcAvy6NOXm84BDH2mvZJzAX3xxw7qHHGysES98D+QpX9e8ZZ7spL/37aacL
 hdm9l6fzxf5lPRujcL3G8D30isTNubw7dlXJnaA93qC8ovPhm9vZhU0zOYBGu6uNiOuTyz8cQvl
 sh1/+mAKT/WL0e/d+YldYC5HlJpgRw3iBQT8FqsrwuZ3mISTPpkGt1/ypR07wdXXNJsGk96b+CH
 wLgPbHLqfUHeENWrnoT6Yqg0VrxQyHYNqKdpE8Oo+8KtZo23tZPH52qJ9QE8T6WfMxwAneTdqPi
 q7xQfRhMkFxlEIIzeXcCmv+gFUm2HW/m6Hq+qvswmY0HmP/p4CnWhgT4/zCqng==
X-Received: by 2002:a17:907:c48b:b0:c19:6104:e5e4 with SMTP id
 a640c23a62f3a-c249264c882mr2187916866b.20.1787570597849; 
 Mon, 24 Aug 2026 04:23:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24d6f203acsm185993766b.24.2026.08.24.04.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 04:23:17 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 11:23:17 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I395cc722d53201d775c20ae3cf9d50149bfc90ed
X-Gerrit-Change-Number: 1863
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1863?usp=email>
X-Gerrit-Commit: 8a2da4f9d45f55ba898c82bf430135f28ee802fa
References: <gerrit.1787570563000.I395cc722d53201d775c20ae3cf9d50149bfc90ed@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NTcwNTYzMDAwLkkzOTVjYzcyMmQ1MzIwMWQ3NzVjMjBhZTNjZjlkNTAxNDliZmM5MGVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5ade8cdc5b2e01f3ac7a8773a079d9599393b81b-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wySlw-0006yz-LS
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco_win: Remove
 unused dco_start_tun declaration
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4651368034198429826=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4651368034198429826==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TuxRTUEkU9E="; charset=UTF-8

--TuxRTUEkU9E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1863?usp=3Demail

to review the following change=2E


Chang=
e subject: dco_win: Remove unused dco_start_tun declaration
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco_win: Remove unused dco_s=
tart_tun declaration

This function was removed in commit
1625d927fc79e2926=
015ded06a01fd8e460a4bc7, but the
declaration and the non-Windows definition=
 were
left behind=2E

Identified by cppcheck=2E

Change-Id: I395cc722d53201=
d775c20ae3cf9d50149bfc90ed
Signed-off-by: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
---
M src/openvpn/dco_win=2Eh
1 file changed, 0 insertions(+), 1=
0 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/63/1863/1

diff --git a/src/openvpn/dco_win=2Eh b/src/openvpn/dco=
_win=2Eh
index ac3ce33=2E=2Ea92e5ad 100644
--- a/src/openvpn/dco_win=2Eh
++=
+ b/src/openvpn/dco_win=2Eh
@@ -65,8 +65,6 @@
 void dco_p2p_new_peer(HANDLE=
 handle, OVERLAPPED *ov, struct link_socket *sock,
                       s=
truct signal_info *sig_info);
 
-void dco_start_tun(struct tuntap *tt);
-
 =
bool dco_win_supports_multipeer(void);
 
 void dco_win_add_iroute_ipv4(dco_=
context_t *dco, in_addr_t dst, unsigned int netbits,
@@ -79,13 +77,5 @@
 
 =
void dco_win_del_iroute_ipv6(dco_context_t *dco, struct in6_addr dst, unsig=
ned int netbits);
 
-#else  /* if defined(ENABLE_DCO) && defined(_WIN32) */=

-
-static inline void
-dco_start_tun(struct tuntap *tt)
-{
-    ASSERT(fal=
se);
-}
-
 #endif /* defined(_WIN32) */
 #endif /* ifndef DCO_H */

-- 
To =
view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1863?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I395cc722d53201d775c20ae3cf=
9d50149bfc90ed
Gerrit-Change-Number: 1863
Gerrit-PatchSet: 1
Gerrit-Owner: =
flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--TuxRTUEkU9E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1863?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">dco_win: Remove unused dco_start_tun declaration<br><br>This function =
was removed in commit<br>1625d927fc79e2926015ded06a01fd8e460a4bc7, but the<=
br>declaration and the non-Windows definition were<br>left behind=2E<br><br=
>Identified by cppcheck=2E<br><br>Change-Id: I395cc722d53201d775c20ae3cf9d5=
0149bfc90ed<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom=
&gt;<br>---<br>M src/openvpn/dco_win=2Eh<br>1 file changed, 0 insertions(+)=
, 10 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/63/1863/1</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/dco_win=2Eh b/src/openvpn/dco_win=2Eh</span><br><span>index ac3ce33=2E=
=2Ea92e5ad 100644</span><br><span>--- a/src/openvpn/dco_win=2Eh</span><br><=
span>+++ b/src/openvpn/dco_win=2Eh</span><br><span>@@ -65,8 +65,6 @@</span>=
<br><span> void dco_p2p_new_peer(HANDLE handle, OVERLAPPED *ov, struct link=
_socket *sock,</span><br><span>                       struct signal_info *s=
ig_info);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-void dco_start_tun(struct tuntap *tt);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span> bool dco_win_supports_multipeer(vo=
id);</span><br><span> </span><br><span> void dco_win_add_iroute_ipv4(dco_co=
ntext_t *dco, in_addr_t dst, unsigned int netbits,</span><br><span>@@ -79,1=
3 +77,5 @@</span><br><span> </span><br><span> void dco_win_del_iroute_ipv6(=
dco_context_t *dco, struct in6_addr dst, unsigned int netbits);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* if de=
fined(ENABLE_DCO) &amp;&amp; defined(_WIN32) */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-dco_start_tun(struct tuntap *tt)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASS=
ERT(false);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #endif /* de=
fined(_WIN32) */</span><br><span> #endif /* ifndef DCO_H */</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1863?usp=3Demail">change 1863</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1863?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: ope=
nvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: I395cc722d53201d775c20ae3cf9d5014=
9bfc90ed </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1863 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>

</body></html>
--TuxRTUEkU9E=--


--===============4651368034198429826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4651368034198429826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4651368034198429826==--

