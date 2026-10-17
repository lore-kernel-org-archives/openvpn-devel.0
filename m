Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49522CCF2CF
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 16:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=D0D0ER+mYfR33pebnEPA5L14Ggu708NqXJLDijWBWyA=; b=e7RRuA7RlaZ6Lx
	0W+TjIyvso5z8LMkc64nmG9AI5vRJcj8v5sbY42WuydiEuHRxU0akLbXTz1f0df+w617Pg66KDd69
	iDGQWlFlGVpTVxmhqMImh+mlnoaIMzlZbp/Jc46wojL2vezTEE1i3VWAaMVjWjJcDgXdeojSXDTS6
	eQE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xI7ZD-0003JY-EN;
	Sat, 17 Oct 2026 16:47:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xI7Z7-0003JP-GS
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 16:47:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JeFWOxExgz0JddFhpylwgC1leDPfQe/7XhSpzleTnPs=; b=VyBB9p2LPTfy5YS85TQHCbDV6c
 y6d76Pq2KZgg1WCvz3SheswjuCD8M7hHFTde3tyIcZbP/y/Gq1YI6CWc7BUlS4CHvtMEuCLIuZeia
 +Ck7WWrMMI+ZH2e9Ud+S3vCY8B3OUebQBiIA5m7IYNr86euPatLATuljM88ZLTuQPpWw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JeFWOxExgz0JddFhpylwgC1leDPfQe/7XhSpzleTnPs=; b=G
 khhPHZGVdFQdtbUjJYIgI7rH+8buWyQf8J5AspWih1snr7H91O2vk0URJw5wguFY8SSxAhz9qHarE
 9mcmDiQpcH2Ip08z/wYq3f4CVC+OdQIW27FP4OqJ91y/0+5+2t8YMVcwxmWg7dU7n9+knHclKWSmu
 5WwYT7OR3u7b/hds=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xI7Z3-0006zM-D8 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 16:47:22 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48dfaa3fa12so1212401f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 09:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792255635; x=1792860435; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JeFWOxExgz0JddFhpylwgC1leDPfQe/7XhSpzleTnPs=;
 b=c8f+6dWah+wElQr8IylPlCBLb+1iVBDYI6hJINYl7jNZbMLjjt1/5n6NhXGkZpPh17
 Ftu9mU++sqMtg2HwuWqHCvYHxfR99eRHDGE/Q9bof4LXvYFIKy+o3JnASqivIq26uBch
 5ZSsl8XbEuQ64HxEqtEXfVcd24ohJkJVX5v8tkB0LgLa2d7ademu7YqROKrihhvXANGf
 B29VhdscGWPT8bbBHFWsjO97zkl0+uqlafQPhzvIhGceOGJt3f0XFoF0hRI8PR19+nzd
 Z8B7J92/ESOZMjM7/AiY6YTGxdc/JYTeURha1DWDBF9mgucHdqBacrrz+I1RKI1nEzgs
 NJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792255635; x=1792860435;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JeFWOxExgz0JddFhpylwgC1leDPfQe/7XhSpzleTnPs=;
 b=EcrN6vosa6rqbTZMgBUI4Fdb9Bn3mvfBOMrC4u4h0uOAjgNV2iSC23jXqBIaEsGSAd
 bOtSDHizaW9hmOlE9HTsz4YXBbRklQ75YAip7FWGkKv5/So8yb4ZwP7jZU6XkpzVowrA
 6wmurVbHyzCcdVbBcJDrnkydE45uh+TySbBmwgKkpZbhaQQ4puvylLwCMn5sbyrFKL7Z
 mK4vjwogGcFaQqBjYWq+hu+HHACAv2IbOASqQzDGitHqeLQbmiEz0elT6iU62Artc4u+
 RQaE3W3YJDqQc3zOlWA6eONjd/xLsvQgzC7sg6memJr9x1pcBmu62/0L/TwCthpiifZK
 n55w==
X-Gm-Message-State: AFq9FYJO4+cOuN0qIcsyOfRKqSbkxrCavVHRGNPVdhN4MYgD2T+cu67Y
 CPDk6kWjbR9AxNdM7kYTQhzt39qwbGqyWvvD2zTFS5UoqTQPFyfvd7i5UYN3+IGdkHnQvbeC5gM
 ywhSuLKJD62adZJSZvB2tsh7EaBXgouJ/L7N2URv5vi3jF2cPk3ORDiYBKDuzoL5JlxOl0mRrJA
 AyiBcFrg==
X-Gm-Gg: AYBFou3KOGbNffDWBPL8k7lUWJrOLtkkbofje2XWswiTL91LWq0K5Wfin9mCXMTF61i
 wnMGp7u4HCe607wjk2G761kdU4AaBSStbja4lGzCz4It6CtlEv2GP3tfoNklPdGCCMtCY3A9jM1
 ypHF5U4BNT0A0DvjkE9l9NRJQTj1T0SuZPmVWuqh1e4KsnJtvARbj0oyJeL2Y/pYDJr+C3YgcDG
 EF5cZVAajspZDIWazDLUdmBnyMAmulwQOb/8LeUrn+G9XKNlvUTWPCYZEh0NJx9K15D2gwFpFbq
 3Vs0IyuaUosmFgu6BoJ6bvOqpLUZYpsXlfb7T9XXWedi+xlo9skMbqGnCxSmmbhm11su6UKXznK
 PBeIOzx6pNCozT1VpuXSby/5b+iUK8gCKeKDjY7rDKk63pgpT6kknU55Bp0Dm45PQoDi8Y2LHJ7
 4azJgG2q25PrrsaZ/GIdK0ZGQ4dVegmry4jdU5V8NLHjqaHxbx/I8oujrUD/jX8l2DbSrub15dP
 uSg2pIxeoNuuziUbS3NNBY/8sHAv/R9MnmfnEujQ4JQx06SQTO7YrlFp2pLUXW+5Ajijif4Rwz9
 pWkvyntgeG+dKxO311ASrn0VWEpe3mIjU3lpnth6GPJMvwpwNCTrmj1zFcA3/w==
X-Received: by 2002:a05:600c:3484:b0:4a0:34a:588c with SMTP id
 5b1f17b1804b1-4a1d7605e04mr66686935e9.14.1792255634687; 
 Sat, 17 Oct 2026 09:47:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1ce02d619sm93103155e9.3.2026.10.17.09.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 09:47:14 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 16:47:13 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I0245175f2884d56838990f53cee6381b981b79c1
X-Gerrit-Change-Number: 2004
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2004?usp=email>
X-Gerrit-Commit: a7b30d8b6adb00967b43c8c5c5036db3d0cbbd86
References: <gerrit.1792255622000.I0245175f2884d56838990f53cee6381b981b79c1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU1NjIyMDAwLkkwMjQ1MTc1ZjI4ODRkNTY4Mzg5OTBmNTNjZWU2MzgxYjk4MWI3OWMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <36530848251c3b8650b025b70a3186b4d3360f9f-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xI7Z3-0006zM-D8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: misc: Avoid
 conversion warnings in parse_auth_challenge
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6239024255402643564=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6239024255402643564==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RfBifsF0esU="; charset=UTF-8

--RfBifsF0esU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2004?usp=3Demail

to review the following change=2E
=


Change subject: misc: Avoid conversion warnings in parse_auth_challenge
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

misc: Avoid c=
onversion warnings in parse_auth_challenge

Make sure we have a sane length=
 and convert it int=2E

Change-Id: I0245175f2884d56838990f53cee6381b981b79c=
1
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/open=
vpn/misc=2Ec
1 file changed, 13 insertions(+), 18 deletions(-)



  git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/04/2004/1

diff -=
-git a/src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec
index 0e4669a=2E=2Eb420a=
ac 100644
--- a/src/openvpn/misc=2Ec
+++ b/src/openvpn/misc=2Ec
@@ -72,11 +=
72,6 @@
 #endif
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma =
GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
=
-
 #ifdef ENABLE_MANAGEMENT
 /* Get username/password from the management i=
nterface */
 static bool
@@ -127,19 +122,23 @@
 parse_auth_challenge(const =
char *auth_challenge, struct gc_arena *gc)
 {
     ASSERT(auth_challenge);
=
+    const size_t len =3D strlen(auth_challenge);
+    if (!buf_size_valid(=
len))
+    {
+        return NULL;
+    }
 
-    struct auth_challenge_info=
 *ac;
-    const int len =3D strlen(auth_challenge);
-    char *work =3D (c=
har *)gc_malloc(len + 1, false, gc);
-    const char *cp;
+    const int wo=
rk_len =3D (int)len + 1;
+    char *work =3D (char *)gc_malloc(work_len, fa=
lse, gc);
 
     struct buffer b;
     buf_set_read(&b, (const uint8_t *)au=
th_challenge, len);
 
+    struct auth_challenge_info *ac;
     ALLOC_OBJ_C=
LEAR_GC(ac, struct auth_challenge_info, gc);
 
     /* parse prefix */
-   =
 if (!buf_parse(&b, ':', work, len))
+    if (!buf_parse(&b, ':', work, wor=
k_len))
     {
         return NULL;
     }
@@ -149,11 +148,11 @@
     }
 
=
     /* parse flags */
-    if (!buf_parse(&b, ':', work, len))
+    if (!b=
uf_parse(&b, ':', work, work_len))
     {
         return NULL;
     }
-   =
 for (cp =3D work; *cp !=3D '\0'; ++cp)
+    for (const char *cp =3D work; =
*cp !=3D '\0'; ++cp)
     {
         const char c =3D *cp;
         if (c =
=3D=3D 'E')
@@ -167,14 +166,14 @@
     }
 
     /* parse state ID */
-    i=
f (!buf_parse(&b, ':', work, len))
+    if (!buf_parse(&b, ':', work, work_=
len))
     {
         return NULL;
     }
     ac->state_id =3D string_allo=
c(work, gc);
 
     /* parse user name */
-    if (!buf_parse(&b, ':', work=
, len))
+    if (!buf_parse(&b, ':', work, work_len))
     {
         retur=
n NULL;
     }
@@ -189,10 +188,6 @@
 
 #endif /* ifdef ENABLE_MANAGEMENT */=

 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop=

-#endif
-
 /*
  * Get and store a username/password
  */

-- 
To view, vis=
it https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2004?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I0245175f2884d56838990f53cee6381b9=
81b79c1
Gerrit-Change-Number: 2004
Gerrit-PatchSet: 1
Gerrit-Owner: Frank L=
ichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--RfBifsF0esU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2004?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">misc: Avoid conversion warnings in parse_auth_challenge<br=
><br>Make sure we have a sane length and convert it int=2E<br><br>Change-Id=
: I0245175f2884d56838990f53cee6381b981b79c1<br>Signed-off-by: Frank Lichten=
held &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/misc=2Ec<br>1 =
file changed, 13 insertions(+), 18 deletions(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/04/2004/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec</span><br>=
<span>index 0e4669a=2E=2Eb420aac 100644</span><br><span>--- a/src/openvpn/m=
isc=2Ec</span><br><span>+++ b/src/openvpn/misc=2Ec</span><br><span>@@ -72,1=
1 +72,6 @@</span><br><span> #endif</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || =
defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pr=
agma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br>=
<span> /* Get username/password from the management interface */</span><br>=
<span> static bool</span><br><span>@@ -127,19 +122,23 @@</span><br><span> p=
arse_auth_challenge(const char *auth_challenge, struct gc_arena *gc)</span>=
<br><span> {</span><br><span>     ASSERT(auth_challenge);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const size_t len =3D strlen(auth_=
challenge);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!buf_size_valid(len))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struc=
t auth_challenge_info *ac;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    const int len =3D strlen(auth_challenge);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    char *work =3D (char *)gc_malloc(len + 1, =
false, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const =
char *cp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
int work_len =3D (int)len + 1;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    char *work =3D (char *)gc_malloc(work_len, false, gc);</span=
><br><span> </span><br><span>     struct buffer b;</span><br><span>     buf=
_set_read(&amp;b, (const uint8_t *)auth_challenge, len);</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct auth_chal=
lenge_info *ac;</span><br><span>     ALLOC_OBJ_CLEAR_GC(ac, struct auth_cha=
llenge_info, gc);</span><br><span> </span><br><span>     /* parse prefix */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!buf_parse(&a=
mp;b, &#39;:&#39;, work, len))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (!buf_parse(&amp;b, &#39;:&#39;, work, work_len))</span><=
br><span>     {</span><br><span>         return NULL;</span><br><span>     =
}</span><br><span>@@ -149,11 +148,11 @@</span><br><span>     }</span><br><s=
pan> </span><br><span>     /* parse flags */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (!buf_parse(&amp;b, &#39;:&#39;, work, len))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_parse(&=
amp;b, &#39;:&#39;, work, work_len))</span><br><span>     {</span><br><span=
>         return NULL;</span><br><span>     }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    for (cp =3D work; *cp !=3D &#39;\0&#39;; ++cp)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (const char =
*cp =3D work; *cp !=3D &#39;\0&#39;; ++cp)</span><br><span>     {</span><br=
><span>         const char c =3D *cp;</span><br><span>         if (c =3D=3D=
 &#39;E&#39;)</span><br><span>@@ -167,14 +166,14 @@</span><br><span>     }<=
/span><br><span> </span><br><span>     /* parse state ID */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (!buf_parse(&amp;b, &#39;:&#39=
;, work, len))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (!buf_parse(&amp;b, &#39;:&#39;, work, work_len))</span><br><span>     {<=
/span><br><span>         return NULL;</span><br><span>     }</span><br><spa=
n>     ac-&gt;state_id =3D string_alloc(work, gc);</span><br><span> </span>=
<br><span>     /* parse user name */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (!buf_parse(&amp;b, &#39;:&#39;, work, len))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_parse(&amp;b, &=
#39;:&#39;, work, work_len))</span><br><span>     {</span><br><span>       =
  return NULL;</span><br><span>     }</span><br><span>@@ -189,10 +188,6 @@<=
/span><br><span> </span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if def=
ined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span> /*</span><br><span>  * Get and store a username/pass=
word</span><br><span>  */</span><br></pre><p>To view, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2004?usp=3Demail">change 2004</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div items=
cope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2004?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I024517=
5f2884d56838990f53cee6381b981b79c1 </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 2004 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;=
frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--RfBifsF0esU=--


--===============6239024255402643564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6239024255402643564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6239024255402643564==--

