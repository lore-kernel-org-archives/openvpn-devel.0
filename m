Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F31FC624D4
	for <openvpn-devel@archiver.kernel.org>; Tue,  1 Sep 2026 14:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rJbRnd6ZKdIIspvSeFrnFZMsB3CwfeGCQ5LdNpJmkhk=; b=FsG/tM4CWNj2gsoeZSmsswoM3b
	L1A/swVs0BFDE53XitPcBex+1pD++6A63kMKLuRQd8Ddw9sr78/znvLJQSqTeExl4Legg2/NlyjSU
	15YgkAtu+WBU0kSbJIefAOO+beYu/0zQTm+Y6eWW1snnmmxlA9eHJG9zl15PObGCy5Jw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1PSp-0000e8-Qf;
	Tue, 01 Sep 2026 14:27:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1PSo-0000e1-Et
 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 14:27:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=SPvh6/5bQMNQeLXMAlgF/3ZklhgPDS+6LeXk/gtcTGI=; b=HTjPWwYo6R/TFRp2uUp6C5Z+Vx
 pLMV4fxHrqv8IqaHhKSWGxb4bUSHVeDQA14dvfJ+ZeIQjRbBHOM+65gqomWBXvG907F9wJr7cKrrS
 tJjiXcgGU6uzZFRDzbjzSK4sM81AOneVI7HNxUviZFhc1hKAhwip5U1OwrGNMzk5DMWQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SPvh6/5bQMNQeLXMAlgF/3ZklhgPDS+6LeXk/gtcTGI=; b=U
 508kJivJJAzDTjIhFve6I1E2mHdGEmgLTMKECVRmZvJ0aH3A+d+QRHWA+jgcC2Fa9wFP961ljX94C
 ZWqVEoWl0rC6VNEEHf8m6H27P3J/Ib2OXp4XOe7v/0U0R59+CP+ugAGLtzmu6Rlyo71/bAgHTmNNL
 tB1SbmDNEaavJ19o=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1PSm-0003io-RL for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 14:27:50 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48431648f33so868841f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 07:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788272862; x=1788877662; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SPvh6/5bQMNQeLXMAlgF/3ZklhgPDS+6LeXk/gtcTGI=;
 b=IIYBTXXb4MrD8sr00EAFWyobcHB3DOOA1uJI07dmW8lgqDodwJj0l0BpxptbIr/beX
 2xUxBvpxk+RX+8fWL3+YMSymDI/fraHbhlUi+e3ZYA3a+9sVwqBGJg9eP5DH+UkIfi2q
 zmxQGvm1pw7chdPQEL1EQ+l4YNxyUBj6wovT7ra5QCoIbPZmjCad5BUVp5w6ZDGdrw14
 gXBA4VFOOoeBAhbR3DVCVLejPqj34OcWTlZg+HlxN2YG3gR+r4riY9mwOKz+evMbvdMx
 cYOThDzL4sF3z5bXFCJ/VHvMhVW+f5jJYzBI/L3k8I9T2FUF3AWtRvdzpUVLreRf7jDG
 te9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788272862; x=1788877662;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SPvh6/5bQMNQeLXMAlgF/3ZklhgPDS+6LeXk/gtcTGI=;
 b=QJLT5McJxvCBBqg/iJKLyJC5ceOjfkdstHUuomHn3PkuL/Gl5UO45mamM9YlZWXn+9
 Y56l4akE1HfLNx7KWS6N2DxyP8dM+lcah7xchK1hBjWM8P1/kngaasxdGWjsZzvCL3bB
 3umwrW7Ppy/mWSiBPJWaPmzGq4SDReESORz+aFK3J11hMyWKQjHAGKPnsAb6AsOeSpMZ
 bkEfrDOwafWJkH8Wz8vBcbDx+8wCclLfeYYlh84Z7wJCdu7GsVcGa7DJBDDqovsaB6cH
 9ghYHRZO+INpdRQD7vttDZWKCzZZ8kTKAZTR8838UOM3YlOiOOWxy0eJgdYyO4oZB8lF
 vYRw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcJ2vFrQeyfmU+GgIZO1ZKCFhnVV+yGsncSEllfo+AmzCKBW7ASbaf5r/Vij4MfqdwoWtlMwim+pK/kO3D@lists.sourceforge.net
X-Gm-Message-State: AFuF++lgISwxucp3mT0kQcjb0pHG4+YZj3gnNdQFAfJRjrvEYwTcM120
 AyItl/sTS4JwiLRyyDK1lvC2RZpiu6oftdxVzFricATzUVXbbNtskRQ4acojOm0kNrmOHCIy/vI
 WTFQWkXUDPkqzoHkVVn82RhwA/sN4CWS/76TD22m1Ifb8orAkJkxm2nA+/uyVWRf0zxnm
X-Gm-Gg: AYBFou3uCK2WJFSW4IY7dCbpZ2NLyrV/xrPw6qLzZ4wYUr3FHJuv4RJug/38z6qSBFX
 37HSm0vWhBVWRshRWStPpxlx9mJBnMbhmhwo2Stz7VTBVDugOw+6yP5mhatHoXGMul/ME7daSCJ
 xUMlKFv/TBWmomnsjlVrHNyAO9zl1AGYg3A0JjKT1PT2NG5+T72K8A5lXVYSzcOBN+2VdWqYJqX
 wZqn2pRFFavHHnjRyMUEqw9jWSMYP6Ck+jMhIo2fXYca65SfIEeh+55Jj+9BduhM2UuNOSV/dgN
 vjA6adU57Kd/oz4bxeeREzfCIlhRPmnzSk97xYwVzO7dNWx3GRFfUVsIkehAhD7ZsWcb1NwdoLq
 WvLKd23iUpWiufPgXJjsQ+aoef3FtfJHuC7HJt3CYB10quePZ8OcWgSgH0WXn7vdwkeoupHyvb1
 ivxiP3xnnRIJF64M1YTKyusHCt6eun+3zFvKWQr6m3W+HXR9n6sgl50gCHbO0I+7Gm1/qCeB0xb
 xtAwj1Bm64X4Zm23nvSLZAECLq97afFK/cvyfR66GgersbX6InxVCkmvRWJPfNr2f0WoBUGMKbS
 jAe4uD2djsakDaBHuMChSgl86pL5NDYv18ElIBjxiZ3zd/fNXr0=
X-Received: by 2002:a05:6000:4902:b0:482:fbb6:1b29 with SMTP id
 ffacd0b85a97d-484421cf298mr12403790f8f.10.1788272861904; 
 Tue, 01 Sep 2026 07:27:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48442c4259esm4838645f8f.7.2026.09.01.07.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 07:27:41 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 1 Sep 2026 14:27:41 +0000
To: d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1a181d65ad0d5e3765f57373a6ee223ede909dea
X-Gerrit-Change-Number: 1888
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1888?usp=email>
X-Gerrit-Commit: c5308c026f837215f6f7eccad82b5c3601a7b418
In-Reply-To: <gerrit.1788192180000.I1a181d65ad0d5e3765f57373a6ee223ede909dea@gerrit.openvpn.net>
References: <gerrit.1788192180000.I1a181d65ad0d5e3765f57373a6ee223ede909dea@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MTkyMTgwMDAwLkkxYTE4MWQ2NWFkMGQ1ZTM3NjVmNTczNzNhNmVlMjIzZWRlOTA5ZGVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a728b1c5d19a7a737c59db38e39a2a5f96ea74aa-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1PSm-0003io-RL
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: fix
 off-by-one input validation
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2772467492594421579=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2772467492594421579==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ilnm+CLmhfg="; charset=UTF-8

--ilnm+CLmhfg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1888?usp=3Demail )

Change subject: openvpnserv: fix off-by-one input v=
alidation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

o=
penvpnserv: fix off-by-one input validation

Code checked for a hypothetica=
l third trailing NUL character,
instead of the second=2E Could read one ext=
ra octet beyond the buffer if
it is used up by the data completely=2E

Disc=
overed and reported by BreachX Zero Day Labs, using Typhon AI Mil v2=2E
Con=
tributing Researcher: Vivek Parikh=2E

Reported-by: Vivek Parikh <vivek=2Ep=
arikh@breachx=2Eai>
Tested-by: Vivek Parikh <vivek=2Eparikh@breachx=2Eai>
C=
VE: 2026-78221
Change-Id: I1a181d65ad0d5e3765f57373a6ee223ede909dea
Signed-=
off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Acked-by: Razvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Acked-by: Arne Schwabe <arne@rfc2549=2Eorg>
Gerrit=
 URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1888
Message-Id: <20260831=
184732=2E3417-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2E=
com/openvpn-devel@lists=2Esourceforge=2Enet/msg38856=2Ehtml
Signed-off-by: =
Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpnserv/interactive=2E=
c
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/src/openvp=
nserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index 0c6e23f=2E=2E=
d2288b9 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/=
interactive=2Ec
@@ -2959,7 +2959,7 @@
         const char *rdom =3D msg->re=
solve_domains;
         size_t rdom_size =3D sizeof(msg->resolve_domains);
=
         size_t rdom_len =3D strlen(rdom);
-        if (rdom_len && (rdom_l=
en + 1 >=3D rdom_size || rdom[rdom_len + 2] !=3D 0))
+        if (rdom_len =
&& (rdom_len + 1 >=3D rdom_size || rdom[rdom_len + 1] !=3D 0))
         {
 =
            return ERROR_MESSAGE_DATA;
         }

-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1888?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I1a181d65ad0d5e3765f57373a6ee223ede909dea
Gerri=
t-Change-Number: 1888
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@greenie=
=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: d12fk <heiko@openvpn=
=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--ilnm+CLmhfg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1888?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">openvpnserv: fix off-by-one input validati=
on<br><br>Code checked for a hypothetical third trailing NUL character,<br>=
instead of the second=2E Could read one extra octet beyond the buffer if<br=
>it is used up by the data completely=2E<br><br>Discovered and reported by =
BreachX Zero Day Labs, using Typhon AI Mil v2=2E<br>Contributing Researcher=
: Vivek Parikh=2E<br><br>Reported-by: Vivek Parikh &lt;vivek=2Eparikh@breac=
hx=2Eai&gt;<br>Tested-by: Vivek Parikh &lt;vivek=2Eparikh@breachx=2Eai&gt;<=
br>CVE: 2026-78221<br>Change-Id: I1a181d65ad0d5e3765f57373a6ee223ede909dea<=
br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>Acked-=
by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Arne Schwabe=
 &lt;arne@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1888<br>Message-Id: &lt;20260831184732=2E3417-1-gert@greenie=2Em=
uc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2E=
sourceforge=2Enet/msg38856=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@g=
reenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpnserv/interactive=2Ec<br>1 file=
 changed, 1 insertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><spa=
n>index 0c6e23f=2E=2Ed2288b9 100644</span><br><span>--- a/src/openvpnserv/i=
nteractive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span>=
<br><span>@@ -2959,7 +2959,7 @@</span><br><span>         const char *rdom =
=3D msg-&gt;resolve_domains;</span><br><span>         size_t rdom_size =3D =
sizeof(msg-&gt;resolve_domains);</span><br><span>         size_t rdom_len =
=3D strlen(rdom);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (rdom_len &amp;&amp; (rdom_len + 1 &gt;=3D rdom_size || rdom[rdom_le=
n + 2] !=3D 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (rdom_len &amp;&amp; (rdom_len + 1 &gt;=3D rdom_size || rdom[rdom_le=
n + 1] !=3D 0))</span><br><span>         {</span><br><span>             ret=
urn ERROR_MESSAGE_DATA;</span><br><span>         }</span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1888?usp=3Demail">change 1888</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1888?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: I1a181d65ad0d5e3765f57373a6ee223ede909dea </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1888 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> =
Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@ma=
ilbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: d12fk &lt;he=
iko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></ht=
ml>
--ilnm+CLmhfg=--


--===============2772467492594421579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2772467492594421579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2772467492594421579==--

