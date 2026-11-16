Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324A9606A329
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=m1yp0JqG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=e/EZjyaU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=J7G72nUT;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=fn1eRrZr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=yDYo4Gs/UDE3DjuaSp34AJ1eSUfjk8KHp+dQuXGJup4=; b=m1yp0JqGvfrRxslI39oDAv1//s
	+2LIgENyh+jObmVF0R2S9n5Cz16n+/S07OuPc1bvinoptH6tJjn8HN0qTZEv/fMR+fgh2qQDx5B35
	+3T5Ye0SYN0gc3srI6LvrvTkEYwPtdvTcbnXj/NFC6idfPxH/5IvbRzS2iCqaQ9/SmzY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSs4N-0000000028f-2PWQ;
	Mon, 16 Nov 2026 08:28:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSs4M-0000000028R-0x13
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 08:28:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xFdIWWJs95npGjO2BRx05tKaJj13UjMcIcJS8hoci3A=; b=e/EZjyaU9653zuUzgx7/+HN5D5
 z2UNRbYMHNOLwesBbO19M+hlHJtnfzH11+kT8LZS3WYLepoP/BoUSPDrfoWMg0KXm5+EShLzUqeL5
 ZGzldZsfzCsNbfy69ERds+YtEWHKV55nQYLrf6s7uT2z3le5ATR0qVad7Wvr+J+rrMwI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xFdIWWJs95npGjO2BRx05tKaJj13UjMcIcJS8hoci3A=; b=J7G72nUTUQwFWcAEQRMBqdXdZ+
 tGEKsfgcD11bUu4DiMdxrKMnJtBrEWB6P9i8bGlcIMFjjA6Yn4411yHmkD2kFSpTj4+npsOnscWTR
 80wVjVbqb2jmbKzVt4DyhjxdSC17min6u30nxP11LFuhDuxNHO2vyUJ2SjIAL3ZqQFYY=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSs4L-000000004N3-2e86 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 08:28:06 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso3448823f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 00:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794817679; x=1795422479; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xFdIWWJs95npGjO2BRx05tKaJj13UjMcIcJS8hoci3A=;
 b=fn1eRrZrLliWpsTk1KGEhuWGjN8EEqvZVYiRJdxxlrHjCYU6N+adhGqoaObE4MU920
 Uqdc1xhFns+G2OrTt4tRmfmAZzdvra3PZ8yoLPH8F2UksLZJnknBpyc6z+OlXFdp1hn/
 lVJfs2saklpZtiwythzjcHFES2i8vDOwT93DwewYbgynN+qSILlodLyIXxGusa55RExs
 sJI0dtrHZot3dJOW59AY8sXO8/Js7MH+Jq+WBycqz9L+IOxddvM/dqpBzv4uotLUH0Tc
 6DOiq8B8pFXTZ1IdDeIQ/NQ971lkvZQLHTM6im8/b7yUXLzZgSugqvVvytvIOExRvogX
 yTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794817679; x=1795422479;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xFdIWWJs95npGjO2BRx05tKaJj13UjMcIcJS8hoci3A=;
 b=VTVnB0DNp/V1UPd1gYPtwA4Owc7nPuvHACN///n6gIldOu//ZcwBl9MxVwPVgRNoKR
 lhhKa03RkWeKFMHCivNFys+0mHP5ZcyL1+KIf/d2m+l0Yixzwmpnj6G3dWcCjmYkQPp3
 mPMyw/q19Ik1XrGv19+VET06DVM90cgg0Bv8VeU9hpNJlnSXJ9syRs09JQKWjsF2pqJz
 2CzJg7OBp/PEzLb43k+5WNIFvi/Zrr0nhL7ceBhUSOG4yUidCnz9UCkWrUBhcE2J6zMs
 oioCHwddyshLT95Mcq+5xhcnyyFZWOUdOdpEwaPweTKYLBP4iVYuotNBgdDTQJuQ+rCR
 vK6w==
X-Gm-Message-State: APuU4Z/a3ytMJwLM6664UPhJsEKma8wIa/dPAJP20VyO1M78c3YLVvsH
 JX1tP7PMwi5vewCF72IcYyCVJu7gqU+ugLvH8/1RU7PBrkn/IzxcOBqw9Ze9MeKFpI0Hy7ZiyNW
 s0KdTYFrRkCYEZk2IfzXEXd3HUIzP3u2XIS7tTBKreuKhtD4HL2Y8CExDMUQ7ontgWApU1vG5fM
 ZUnvZ4CA==
X-Gm-Gg: AZFdTZeS9VTQi+2QACSU08Senxd6IsnlYBwr3Tovf7mwzgG9mKjdlGnF81h49HMrrsy
 WOV7zHVBJxOqe2S2pcwVdHh1T2MSnYtZRFqKA7cWP7x5VR688s+E61skfAQpr/BqebSmEhzZjLv
 Oabbcw4gsQc5L9iHX+yuanueX1jEUTMCVspLnnbTP9gEJmSmBt8AAY+EU+ICv862dqnQwG5HHc0
 R2aFckLpFW3EZ2FLnHnhMGrKinwepXCyi+11tLEvD0OAOi2RFAIQZEGQNo7qSHQy+xviiJlOYTx
 5+69Azjfjz4h+tGtfeMX/OvasGppNBjdC0+ASDoC8e8nhQjzkbr1RztUSPmYG+OYJ82JwXfuDiy
 6Ou6t3keppYIS7KDJ3OIE/Txnh408Vsh4ugptfDKKNMdDAblASsJtszs81Ny9q94gTbMPmEGpJb
 dfXLhojfrPZGC2Yn8ASUCbuYznoaiXH5gtdXjSbykTdcdlk+A2J2B4u5ED1ytHWm22wJXwEi3sY
 +PowUaNAouqASeebqiAVp9TYr13tgci3kxF0/FIX1Rzj8EixwCmpUmOOZDZSjU1VxmRB/l0Wzi2
 42kk3tZKAdM0HiuGXTJZ8LS+7GhXgeymo+nuku/xfr5+s4v9yOFEdfwCZ0MRcWD7QpozhAKiZ47
 m0mWr6cVqMA1wqvplskKf0AI1emQS0VWZqXkrl0izjT39L43HpEcsEQyTakP+Uh13n9j/Seul0F
 Js1ifcjtPYf3TeDuF2
X-Received: by 2002:a05:6000:18af:b0:48c:69b3:610f with SMTP id
 ffacd0b85a97d-49c712ac6ecmr20318405f8f.26.1794817678946; 
 Mon, 16 Nov 2026 00:27:58 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c60f8e794sm20043524f8f.59.2026.11.16.00.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 00:27:58 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 08:27:58 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I4c0d6971bec0f65f6cb7911475385986d2dfddfc
X-Gerrit-Change-Number: 2187
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2187?usp=email>
X-Gerrit-Commit: f99a8fbc9bc9d683dbe436c834fb4dcad427ea27
References: <gerrit.1794817677000.I4c0d6971bec0f65f6cb7911475385986d2dfddfc@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODE3Njc3MDAwLkk0YzBkNjk3MWJlYzBmNjVmNmNiNzkxMTQ3NTM4NTk4NmQyZGZkZGZjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c1ba6d86e67d3a5b56b87d40fe74f5a4ad4b587b-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSs4L-000000004N3-2e86
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: pool: drop unneeded
 casts in in6_addr_low32()
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
Content-Type: multipart/mixed; boundary="===============2889741584377339917=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2889741584377339917==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Hddt7vFYp2Y="; charset=UTF-8

--Hddt7vFYp2Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2187?usp=3Demail

to review the following change=2E
=


Change subject: pool: drop unneeded casts in in6_addr_low32()
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

pool: drop unneeded ca=
sts in in6_addr_low32()

Only the << 24 shift can overflow int; the others =
fit=2E

Change-Id: I4c0d6971bec0f65f6cb7911475385986d2dfddfc
Signed-off-by:=
 Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/pool=2Ec
1 file =
changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/87/2187/1

diff --git a/src/openvpn/poo=
l=2Ec b/src/openvpn/pool=2Ec
index eafd553=2E=2E0b64317 100644
--- a/src/op=
envpn/pool=2Ec
+++ b/src/openvpn/pool=2Ec
@@ -45,8 +45,8 @@
 static inline =
uint32_t
 in6_addr_low32(const struct in6_addr *a)
 {
-    return ((uint32_=
t)a->s6_addr[12] << 24) | ((uint32_t)a->s6_addr[13] << 16)
-           | ((=
uint32_t)a->s6_addr[14] << 8) | a->s6_addr[15];
+    return ((uint32_t)a->s=
6_addr[12] << 24) | (a->s6_addr[13] << 16)
+           | (a->s6_addr[14] <<=
 8) | a->s6_addr[15];
 }
 
 static void

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2187?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: I4c0d6971bec0f65f6cb7911475385986d2dfddfc
Gerrit-Ch=
ange-Number: 2187
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--Hddt7vFYp2Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2187?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">pool: drop unneeded casts in in6_addr_low32()<br><br>On=
ly the &lt;&lt; 24 shift can overflow int; the others fit=2E<br><br>Change-=
Id: I4c0d6971bec0f65f6cb7911475385986d2dfddfc<br>Signed-off-by: Razvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/pool=2Ec<br>1 fi=
le changed, 2 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/87/2187/1</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/pool=2Ec b/src/openvpn/pool=2Ec</span><br><spa=
n>index eafd553=2E=2E0b64317 100644</span><br><span>--- a/src/openvpn/pool=
=2Ec</span><br><span>+++ b/src/openvpn/pool=2Ec</span><br><span>@@ -45,8 +4=
5,8 @@</span><br><span> static inline uint32_t</span><br><span> in6_addr_lo=
w32(const struct in6_addr *a)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    return ((uint32_t)a-&gt;s6_addr[12] &lt;&lt;=
 24) | ((uint32_t)a-&gt;s6_addr[13] &lt;&lt; 16)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-           | ((uint32_t)a-&gt;s6_addr[14] &lt;&l=
t; 8) | a-&gt;s6_addr[15];</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return ((uint32_t)a-&gt;s6_addr[12] &lt;&lt; 24) | (a-&gt;s6_add=
r[13] &lt;&lt; 16)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
          | (a-&gt;s6_addr[14] &lt;&lt; 8) | a-&gt;s6_addr[15];</span><br><=
span> }</span><br><span> </span><br><span> static void</span><br></pre><p>T=
o view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2187?us=
p=3Demail">change 2187</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2187?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I4c0d6971bec0f65f6cb7911475385986d2dfddfc </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2187 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--Hddt7vFYp2Y=--


--===============2889741584377339917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2889741584377339917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2889741584377339917==--

