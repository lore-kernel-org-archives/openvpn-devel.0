Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F932CCF2E3
	for <openvpn-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kMjdDQJevnMGtIiCOH3uGxc3n5C32flGd1uQXY35N4c=; b=fFtwMXD8phUT5ZBJtaS5t0gc/A
	tRGNDcvVLZFh3GMJNZ6VXzMogZZEJwUi4jF8x/jnwI5ex/AW/No7RoczEI+h1+fLA5z5JTr8tPXuG
	bQ1+kylOi2n7F5Tc9ndecKXh5o/H3cZ+3RjBNAoMbZjslEP8MwCzl4gyIMHdWDkiudsQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xImod-0002Ym-IX;
	Mon, 19 Oct 2026 12:50:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xImob-0002YX-OB
 for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 12:50:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=zCxuaT0PDmynXiwHn8i/n7cGhYQgRItdIh5Rr6JNifc=; b=dEsKB3hrKHQlJXEo9zjEt89SoZ
 +t8Asv/mLIQw2AbcvIu7eqsdO/1SlJBYzX0WLZH/vyKm4Qe3Siu/DsmC8FDwX4Opp6X5QOGOcWa3k
 vhOGZIzlZhzghzKd5G2ExpjeJ9n4drOQ+zXc3M5I7jDwjQsmVO12rBceWBkkSXUeojMk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zCxuaT0PDmynXiwHn8i/n7cGhYQgRItdIh5Rr6JNifc=; b=I
 AmHgjjsJWOe0pChOnwwfPZnoXNcx2NP3Tp8ScDn3aNnjhPy36hkqa3RBUecAAISIIadrH5XgLF0tY
 niVlZtaaAAe1N/g6dY6TWiSlmcScbIhFMPQ10qR6wgdZiQXDfYQGuBUVFukGYHFDtxsQSyOI49cLm
 c7pZP3lvTXq4jpsc=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xImoa-0007Am-Gs for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 12:50:10 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso1579223f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 19 Oct 2026 05:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792414202; x=1793019002; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zCxuaT0PDmynXiwHn8i/n7cGhYQgRItdIh5Rr6JNifc=;
 b=JQc4FVbZGrCzVJt8qQjSgf8TF5Vu1ZD9udZkYO0DEPcMMP/bc5yIXd8gSQ3JWvLccr
 FBvH/nYHHQoVoXoUYGgG38XK13vEWEPwOP7qHrqZ3bvD1etlVHLjjs8UJWTb8RzHiGOc
 k49c4+LR8YQYs4arCen2YgP363STDRtyHROTOKb8N5QFA/pg6rvvNTH0NlrCbZAH4Oei
 hFBEOpGkKITTE5BKItYFEGzw3s/zW7SuDIxQzBv6cipif9hKQ9xbgwVc0NDoCEKQDXjo
 qcOolc/gVGTq79tq3W+4f/3rYgBA06cuzNyeuXTquv+3ZFv43IG7SlJfohqu3Mxg0eqZ
 xcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792414202; x=1793019002;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zCxuaT0PDmynXiwHn8i/n7cGhYQgRItdIh5Rr6JNifc=;
 b=i30144q44PwJHbLjTII4XyzLdvGnLlRKewliNVKI9RkYtBNTgOo+12MYXoe4/HAoY3
 WzD5nc0L5LJfueOV2StRr4Eg+MlILE3hu+NNOCZpElD2nwFa45JwB/lR6BFQXlb7HNIk
 mAHx7XZqk4iNfolfp6wZY4ZKvCdeqcHeCjXvkSLw4+ZGydTZR8osxBmwiDar3aYrEu+P
 LVsoZCXqFcAauS34bzX9b6Gko76I14eOpHRF93G5606bvURNx5+x4iCd4+jotR/lpJub
 hStmF1HrtWamLStgdLG8t1w7yHQElvNDDu1e6WxxkOIZGRRgX53uD7QWtUHRwM6P/z6O
 cK6g==
X-Gm-Message-State: AFq9FYIVEBRMm2WbaYFZc4TXJw0RV4rtNgreYRpc06YurMcltn2EGfch
 6Ds5C+9hDJJNPovsy2Ju+qFOrxg/h43lkZdcrRC8mwODxhqnnJp3CVJwh2egJWZPpaz4EpsPhNE
 AiyEfrxSmjvYHIwDoSiJiAyjgW2vGHC390m41kFdp/15i3NS7hbETUsXpzw5+QxXd6yZR
X-Gm-Gg: AYBFou0nIygGyjqlukGX1mjM2r1yhXkmRrjjdu8xa2B9gT83ZHqMTUsi4m411AffU0k
 KVI1Z/USlMvLbpWyzY8vX5QmPxrcf0iItcuh1q+HRfnjnXQYwWbB8oLJgQ8KOMPVeDjHINT5hV6
 0fL2thNISh9rw3+l8tRETg/VxDTh5NuhAUOJWR9WmqrEa+OhskXGIO5+OuO4DTQeXc53H+SOHf1
 kCkuXJvzSXC54cT6TqqFc9Dy5CPtsUiN87OOB0s9sh0nKPDxM8VzB3D6TvxxjAzVaReNSJwKpJt
 dWQm3+bwZJnhQkFfOvvj5axMUaVtzbrluzV4ub2dHcdiMW7ug275PLBufHwiYFz7IfAER8bdboa
 4hrJp9HXovPg6WZSLFBiO0bX8LMuLVbzN86IpFtvSylcanHOm+baGzm1Wd33pn6YVLMkyGjHxp2
 +JefrRm55PxJeNGNJbhDVyMOjua9M+b9J0ep41mU3Bk4rdtwQM7H55f/VGpKKhoQKNzrE/3vet0
 tvthOuCFRqC0/LB9HDtRKEHkauhGR6XHXHEFff59SMZtpWzk8r69Om/9utLS+IkYa6o0c2LVYOy
 DhhIG2aLnT0Fr2RafoxF7MRPdw1ARvtgHJXis1Gku5SNDdeIX5gUcdu7qCmS
X-Received: by 2002:a5d:66c3:0:b0:48c:7d67:8ee5 with SMTP id
 ffacd0b85a97d-48e07f9b9a3mr11114735f8f.43.1792414201475; 
 Mon, 19 Oct 2026 05:50:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1af194bbsm1522875f8f.57.2026.10.19.05.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 05:50:00 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 19 Oct 2026 12:49:59 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6b03ba939387c2a873105f6b6cd5f18efbf4dd4c
X-Gerrit-Change-Number: 2005
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2005?usp=email>
X-Gerrit-Commit: 4562a9e5953eda34ce8540814be797dc1407676f
In-Reply-To: <gerrit.1792255622000.I6b03ba939387c2a873105f6b6cd5f18efbf4dd4c@gerrit.openvpn.net>
References: <gerrit.1792255622000.I6b03ba939387c2a873105f6b6cd5f18efbf4dd4c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU1NjIyMDAwLkk2YjAzYmE5MzkzODdjMmE4NzMxMDVmNmI2Y2Q1ZjE4ZWZiZjRkZDRjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <88ecec3078e81d7ab64c37387f8944abf6948411-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xImoa-0007Am-Gs
Subject: [Openvpn-devel] [S] Change in openvpn[master]: push: Avoid
 conversion warnings in send_push_options
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3916644383964409828=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3916644383964409828==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XNLfmeOvNAQ="; charset=UTF-8

--XNLfmeOvNAQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
005?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by Gert Doering, Code-Review+2 by R=C4=83zvan Cojocaru


Chang=
e subject: push: Avoid conversion warnings in send_push_options
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

push: Avoid conversion=
 warnings in send_push_options

Make sure we have a sane length and convert=
 it to int=2E

Change-Id: I6b03ba939387c2a873105f6b6cd5f18efbf4dd4c
Signed-=
off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>=

Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2005
Message-Id: <2=
0261018154151=2E23586-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-ar=
chive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40021=2Ehtml
Signed-=
off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/push=2Ec
1=
 file changed, 8 insertions(+), 12 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/05/2005/2

diff --git a/src/ope=
nvpn/push=2Ec b/src/openvpn/push=2Ec
index 8dfe0d5=2E=2Ead95a0f 100644
--- =
a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -733,11 +733,6 @@
    =
 }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnosti=
c push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static boo=
l
 send_push_options(struct context *c, struct buffer *buf, struct push_lis=
t *push_list, int safe_cap,
                   bool *push_sent, bool *multi=
_push)
@@ -748,8 +743,13 @@
     {
         if (e->enable)
         {
-    =
        const int l =3D strlen(e->option);
-            if (BLEN(buf) + l >=
=3D safe_cap)
+            const size_t l =3D strlen(e->option);
+         =
   if (!buf_size_valid(l))
+            {
+                msg(M_WARN, "--p=
ush option is too long");
+                return false;
+            }
+  =
          if (BLEN(buf) + (int)l >=3D safe_cap)
             {
            =
     buf_printf(buf, ",push-continuation 2");
                 {
@@ -764,7 =
+764,7 @@
                     buf_printf(buf, "%s", push_reply_cmd);
     =
            }
             }
-            if (BLEN(buf) + l >=3D safe_cap)
=
+            if (BLEN(buf) + (int)l >=3D safe_cap)
             {
         =
        msg(M_WARN, "--push option is too long");
                 return f=
alse;
@@ -776,10 +776,6 @@
     return true;
 }
 
-#if defined(__GNUC__) ||=
 defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 send_push_=
reply_auth_token(struct tls_multi *multi)
 {

-- 
To view, visit https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2005?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I6b03ba939387c2a873105f6b6cd5f18efbf4dd4c
Ge=
rrit-Change-Number: 2005
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-R=
eviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>

--XNLfmeOvNAQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2005?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by Gert Doering, Code-Review+2 by R=C4=
=83zvan Cojocaru</p><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">push: Avoid conversion warnings in send_p=
ush_options<br><br>Make sure we have a sane length and convert it to int=2E=
<br><br>Change-Id: I6b03ba939387c2a873105f6b6cd5f18efbf4dd4c<br>Signed-off-=
by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan C=
ojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Gert Doering &lt;gert@gr=
eenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2005<br>Message-Id: &lt;20261018154151=2E23586-1-gert@greenie=2Emuc=2Ed=
e&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esource=
forge=2Enet/msg40021=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/push=2Ec<br>1 file changed, 8 inser=
tions(+), 12 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/05/2005/2</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>index 8dfe0d5=
=2E=2Ead95a0f 100644</span><br><span>--- a/src/openvpn/push=2Ec</span><br><=
span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -733,11 +733,6 @@</span>=
<br><span>     }</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span> static bool</span><br><span> send_push_options(struct=
 context *c, struct buffer *buf, struct push_list *push_list, int safe_cap,=
</span><br><span>                   bool *push_sent, bool *multi_push)</spa=
n><br><span>@@ -748,8 +743,13 @@</span><br><span>     {</span><br><span>   =
      if (e-&gt;enable)</span><br><span>         {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            const int l =3D strlen(e-&gt;optio=
n);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (BL=
EN(buf) + l &gt;=3D safe_cap)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            const size_t l =3D strlen(e-&gt;option);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            if (!buf_size_valid(=
l))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(M_=
WARN, &quot;--push option is too long&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (BLEN(buf) + (int)l &gt;=3D sa=
fe_cap)</span><br><span>             {</span><br><span>                 buf=
_printf(buf, &quot;,push-continuation 2&quot;);</span><br><span>           =
      {</span><br><span>@@ -764,7 +764,7 @@</span><br><span>               =
      buf_printf(buf, &quot;%s&quot;, push_reply_cmd);</span><br><span>    =
             }</span><br><span>             }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            if (BLEN(buf) + l &gt;=3D safe_cap)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (BLEN(bu=
f) + (int)l &gt;=3D safe_cap)</span><br><span>             {</span><br><spa=
n>                 msg(M_WARN, &quot;--push option is too long&quot;);</spa=
n><br><span>                 return false;</span><br><span>@@ -776,10 +776,=
6 @@</span><br><span>     return true;</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__)=
 || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span> void</span><br><span> send_push_reply_auth_token(struct tls_multi =
*multi)</span><br><span> {</span><br></pre><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2005?usp=3Demail">change 2005</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2005?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6=
b03ba939387c2a873105f6b6cd5f18efbf4dd4c </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2005 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2E=
de&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>

</body></html>
--XNLfmeOvNAQ=--


--===============3916644383964409828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3916644383964409828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3916644383964409828==--

