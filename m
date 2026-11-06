Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA19606A326
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YxMe12Q7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FzAvuU/Y;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KmaQr/gi;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HwA52gc1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=JisYEVYk3gtNEtiLNF6u1zF4MvT4h4Vq98rxQ4LV12w=; b=YxMe12Q78oC0sy4P9hSDBfzEiB
	NPFr9ir9Rd5QLhyT1YS+zcFBAghtI3VjMQv8oqLA3lah6LjbLr9hVS6F9ts71RmFG7GjhzlaL7v/c
	6xbgTGqcOH82AweBP4HdmFG741xJ0XUD32l3JpwLecZYDQ1vQEUwrox3fChNfLzDoE0M=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPJbq-000000007nq-3Ts1;
	Fri, 06 Nov 2026 13:03:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPJbZ-000000007lC-1rc0
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 13:03:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EuYZ5vXIgUp0229X4kyDc1XHbyKFUg/hHN5ylHMiN34=; b=FzAvuU/Yuh+gx328L4qtea9XaT
 nGjImT2oPUJGmKPY31A1Y5vqV4fH+/Ks9jBQfpHCOSYR36Vn7RUB5wSin0jIWfcB79KgH83wOJR7b
 6GComZFynIf8+EVOHX1uM8ew31eeu05u4TeaR88yJ7+lndP2eQrv2p098NjF1CTYIiPY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EuYZ5vXIgUp0229X4kyDc1XHbyKFUg/hHN5ylHMiN34=; b=KmaQr/gigLiXfo4bB88wMDfcPJ
 97JAjWFqg4zT3H4ohiaJ6HhFP7SGRn2MEXFdVEkWJO8kAYOv4gR7OuJmoOJEdupL+nxmheo4XCj4l
 NLmWe+UVil9sCmqA2vtFGTy46ktQot5R2CFVyLrqgie5z5yx7Q5La4wMncYhm2pNWqPM=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPJbO-0000000063H-45lc for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 13:03:32 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a35db1f202so4877495e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 05:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793970204; x=1794575004; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EuYZ5vXIgUp0229X4kyDc1XHbyKFUg/hHN5ylHMiN34=;
 b=HwA52gc19eIHJGNbL8t9R3a+KPf/j7He5a+WOgy9/bWLiz8Xht/T0eokc01CBxbi14
 BQai7/+FqRxmmWEJ52U0h/wu3xCvE8+ykIdxTJV5/UFyPeHWRRFHUsxkusl2jJfUugJT
 t3wPOZ6AZSCLx3WvVdDLYgvhLsIW+8gXvAK3lQNEIXHsgqj9o3eH2zvw7pcpep98LxQN
 nmuyrAifDcrpqHuPMeOt1RufeoO9BJZHSlIona9oT/b/S6KTSqLVrOgt8DXC2hJV/Ln7
 ISV1cjROiuCiLtcPPjgYImvSyhYykmXQPgJRooJWK/9ePARE5wDSAbzq8vO1Va5qy1BO
 gJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793970204; x=1794575004;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EuYZ5vXIgUp0229X4kyDc1XHbyKFUg/hHN5ylHMiN34=;
 b=QoosMJMXwCA1G1fvRAa33YWRLsDzk8ZNOVjCYtIF2UDoFoJQ9HskeF3XIeH4bQurst
 5jTZJD3oHIr+tG1Vi+RUIrQY8x6tUb+rtJ2GGyB5a9CJ0YDW1OtvIAJ5QGRZ+UrOMO87
 hA7CRDZCR7Cd53MhnhUuDW9js0OZkzu/oS36eAnaZziyQBGr2Qudgdu5PfB9O7MbMfpW
 4pkasSwn2q6SIuL4mCSDgd2JLvg2DIN9+ArNe1cxe1j5hX8HD/6Op4YnUWarO8oVWYFE
 7by1KrX8FtdcVq5VMI51zM4YE1dz457yJVo4NYzgLSlGj6uxByuU0SxXCd0gAdjgxVZN
 gcYg==
X-Gm-Message-State: APuU4Z8EpZ3Pu4f20ecVIYGbj/h+mV9LbX+gwXGKAfzFfbrXAiUR7cFu
 85uOc6JAIUda0vwmrtjbww+dM3mt6oFp1RumhaToIDRi/IYbzPElqaAJDwPlOYnppXvr205SOp5
 lFSmmA8Owf1UedB/IedfdIIL4SCpukRoFuFLZDQQW9LeuVZK7JGS5rG7H99pdFnr240LGRqGZy5
 q0w/LuYw==
X-Gm-Gg: AYBFou1ahgQxZG3G2pLqGMd4JvATmszU5LZM+IBsbOgz8nDRo1XHqlFOp/OayeCVoBR
 X9OTg8yveihyJQlJeivWJkq9BJakX7qg9HWZnVdt/QCzALdIP9WHDdMZHQtSrhMKcP8jIfkSiDl
 hIHQCpE/MQMlUF4c8+KTZhoZAQ9irzPST0+LyVFKR/xShn2ESBtSpdmzwqLDfkU6wFghGkUl4co
 ItQ+nnyDfaFchNrjXvq3j4ioLDyFzJ7mVOtbBUtmvdOgfpJN104cPVI6INYqMd8ee6NHh4qdHAP
 JEoSzlGb29eyoI2/2QEqdinC79ZVYPvtTkfkxZ7gV2BPo0RJ5/m263pJDSXYbgfuTuglvGaivhH
 NGSa7akYsehhDpZvG/lB9KzEeqPoZixc/nUnyMz8Adt7hXSkjS4geZmHXbUHEX+4/eVXv+neuzA
 XSjAel6FcrmV6IwFCMijUrnQAjwj6NeN+vr51BMLL5NMTFj6VwKJEiD1J6y8t/RE4fmK6GQTuV/
 1BodZRx3vICnEHH1wY6s5bJn10urscsREIuublooWjYDcEA/vm33VmMTbyiuKO3hK67qovTUizK
 Han3ObcZq+SG1h0HAxXgK8XucTIIjHIGmrqzv9Bm/Gd9WzTClK71C4PfWYpXd69IJNPQ0GPgmtO
 4QIFNiIQqluiRlEDBI4IMnva8CdnKxlpNVxNRieyMKy13qvboAhJtwVeMFiGDCu7dIdKsVtHgN1
 togww0jnWLj8I6Og==
X-Received: by 2002:a05:600c:1391:b0:4a6:44b:2593 with SMTP id
 5b1f17b1804b1-4b6dfd97b6cmr40480465e9.29.1793970204259; 
 Fri, 06 Nov 2026 05:03:24 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b6e24012c3sm53649675e9.13.2026.11.06.05.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 05:03:23 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 13:03:23 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ied9e36d45b30a88610cafee668ecefa98b29eddc
X-Gerrit-Change-Number: 2146
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2146?usp=email>
X-Gerrit-Commit: 8b7e241ff25b9ebe71c56cdf0a3b4d7424cf252b
References: <gerrit.1793970201000.Ied9e36d45b30a88610cafee668ecefa98b29eddc@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzOTcwMjAxMDAwLkllZDllMzZkNDViMzBhODg2MTBjYWZlZTY2OGVjZWZhOThiMjllZGRjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0ae62f22f500c1d71b0732e6cd1ebdb228dcb4c7-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPJbO-0000000063H-45lc
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: reflect_filter:
 zero the rate limiter on allocation
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6108510741774891673=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6108510741774891673==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="R4Lgvouw8SA="; charset=UTF-8

--R4Lgvouw8SA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2146?usp=3Demail

to review the following change=2E
=


Change subject: reflect_filter: zero the rate limiter on allocation
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

reflect_filter: =
zero the rate limiter on allocation

initial_rate_limit_init() allocates wi=
th ALLOC_OBJ, which does not
clear, and then assigns every field but warnin=
g_displayed=2E That one is
read on the path that warns about --connect-freq=
-initial being hit, so
whether the warning appears at all is down to whatev=
er the heap handed
us=2E

Use ALLOC_OBJ_CLEAR, which is also what keeps a f=
ield added later from
starting out undefined=2E

Change-Id: Ied9e36d45b30a8=
8610cafee668ecefa98b29eddc
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
=
---
M src/openvpn/reflect_filter=2Ec
1 file changed, 1 insertion(+), 1 dele=
tion(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/46/2146/1

diff --git a/src/openvpn/reflect_filter=2Ec b/src/openvpn/ref=
lect_filter=2Ec
index e5226e4=2E=2E6059e44 100644
--- a/src/openvpn/reflect=
_filter=2Ec
+++ b/src/openvpn/reflect_filter=2Ec
@@ -89,7 +89,7 @@
     str=
uct initial_packet_rate_limit *irl;
 
 
-    ALLOC_OBJ(irl, struct initial_=
packet_rate_limit);
+    ALLOC_OBJ_CLEAR(irl, struct initial_packet_rate_li=
mit);
 
     irl->max_per_period =3D max_per_period;
     irl->period_lengt=
h =3D period_length;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2146?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: Ied9e36d45b30a88610cafee668ecefa98b29eddc
Gerrit-Change-Number: 2146
Ge=
rrit-PatchSet: 1
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-=
Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>

--R4Lgvouw8SA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Lev Stipakov would like Arne =
Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2146?usp=3Demail">View Change</a></p><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">reflect_filter: zero the rate limiter on allocation<br><br>init=
ial_rate_limit_init() allocates with ALLOC_OBJ, which does not<br>clear, an=
d then assigns every field but warning_displayed=2E That one is<br>read on =
the path that warns about --connect-freq-initial being hit, so<br>whether t=
he warning appears at all is down to whatever the heap handed<br>us=2E<br><=
br>Use ALLOC_OBJ_CLEAR, which is also what keeps a field added later from<b=
r>starting out undefined=2E<br><br>Change-Id: Ied9e36d45b30a88610cafee668ec=
efa98b29eddc<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>--=
-<br>M src/openvpn/reflect_filter=2Ec<br>1 file changed, 1 insertion(+), 1 =
deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/46/2146/1</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ref=
lect_filter=2Ec b/src/openvpn/reflect_filter=2Ec</span><br><span>index e522=
6e4=2E=2E6059e44 100644</span><br><span>--- a/src/openvpn/reflect_filter=2E=
c</span><br><span>+++ b/src/openvpn/reflect_filter=2Ec</span><br><span>@@ -=
89,7 +89,7 @@</span><br><span>     struct initial_packet_rate_limit *irl;</=
span><br><span> </span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    ALLOC_OBJ(irl, struct initial_packet_rate_limit);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(irl, str=
uct initial_packet_rate_limit);</span><br><span> </span><br><span>     irl-=
&gt;max_per_period =3D max_per_period;</span><br><span>     irl-&gt;period_=
length =3D period_length;</span><br></pre><p>To view, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2146?usp=3Demail">change 2146</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div items=
cope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2146?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ied9e36=
d45b30a88610cafee668ecefa98b29eddc </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 2146 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Lev Stipakov &lt;lstip=
akov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: A=
rne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--R4Lgvouw8SA=--


--===============6108510741774891673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6108510741774891673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6108510741774891673==--

