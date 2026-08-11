Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067EFC5B572
	for <openvpn-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=pszPFz3ahGZFdtuhj+I5jU09eEcJEoZ/Kt98IxYFsfE=; b=Tx8jSH7SXRWHCW
	6pCHQ+/w4PIgfUU3sjF6wAtz3spLxNZFjGdpRegeYEuNHsmBu6AVelp7wmtqXKTCbxCUxuv++NEl2
	I5oxYbP6NGyAr7NMCH+v+Yt3xySAm4NjvfBO4oLbW2xIjuwW/yLO65Mb1hPjrHtBEnWIDukFNxqJQ
	DO0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wtpKK-00062L-Db;
	Tue, 11 Aug 2026 16:27:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wtpK2-000622-Au
 for openvpn-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 16:27:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2hHrrlRIXmR3JR+VxZ78Io3rpVlUlKrEPVUAVb4af7Q=; b=J0DdJTu/bOfyWO208T/Mre72yy
 irkKafLy/vSxEFgxxzJDy9fb3vzSCoqhKPRs2tTVpdJKvJpxVXdKo/QZrKwQfFsySaWX9BVghl05T
 zyz+NNGAHIezT/L1lKh3lbIvUjfoL1XIesmgxaXD0ixXwHtOBr7onLKNbNuQhWTyC0xU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2hHrrlRIXmR3JR+VxZ78Io3rpVlUlKrEPVUAVb4af7Q=; b=G
 MjNX8Q9EcOxoGfSx0T+MlNYiXx0szq+NiXj0AP85n3QZXP1yUvzGU/BMlIzbFJnRP2+kJJavlQcZZ
 8pV9Z5VN4CYqyaXS8KEaTO/ntzrHo6fsWB0GrLkgljtVs3yjm5i9W63GQ65hrZR7US6b8WD2Ol1jK
 S6Ci1tCNJ945/VGc=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wtpK0-0008Qe-3T for openvpn-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 16:27:26 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so29337315e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 11 Aug 2026 09:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786465637; x=1787070437; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2hHrrlRIXmR3JR+VxZ78Io3rpVlUlKrEPVUAVb4af7Q=;
 b=JZjqH5yCGBjSX7nvqLWskftLnNNUJTQXjBn/6Uxv0XXz+wIZnaD2P3hni7T1HyCks6
 DV4pP6cl4R6IFbCJnilh1zLCqAMmDXmEZuHnB/oxGDT2THx9dtt7fpKdcYuO8n1e+BOo
 +vWU5g8m0StfzjB0EOi4OGKhbh+ofWzWr8Wz9unKn6oaqeAwfSvlJc0Zo9xvJguKiXZZ
 /bzTqvbEIFYYobpUMQjnUa6TRQj0aXZgasS01LQLRvDlWLdAW8hzk61YH2VJhb1ucTlP
 Lv1Y/+iRJ643V75orzVndSrQLykUoCIlVSXcmudMnwqS4yewwQB9Epwd8OYP1bf7Xc1m
 Rgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786465637; x=1787070437;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2hHrrlRIXmR3JR+VxZ78Io3rpVlUlKrEPVUAVb4af7Q=;
 b=bko5DFcxqqDiuKZ+O0TilivN2Hufrde1n3TItOGm4QOPKmh1zGzlRy6h94K6774qIP
 17T3MG6vmNGEiW3P0qnzOHrEx9PgBwaN9dbiaknuL7ATkDJ3P6QJ3HIjyUqiOPJiYMB8
 YTzyizaIy7sOfHUfn8/N5gdfW9pRRss1exTC/hxlD+Jep1zpNW7SG8MJXQD1R5HxuMvR
 BhK09IiCJK6sTimEJE0z+UsEtamnhUNzGYxuEIOCQg/qUwz+Z6FKdja4yg1O4DtQsda6
 dAeHyRDUPvC/5oxhXLP19fAYPiTTAoE8r19+FhmXeDciuwE6z78o/HQoZGie/vepV4/3
 jqyQ==
X-Gm-Message-State: AOJu0YxAolRfpy6+KRLZyVB27Vh15qOqEAw9U9VL8qP0Rq/hp53hgg06
 CMgvkje5kRC/8l19/G1U0jgs6zZpqJHp+2HfMCrMeq5LXI7edScOZmIau6TGmY3gAsOkXq4sCjt
 pjcyu7M/K3LxtVUQawc1x6naS6iePgdZNXQTLRRFWLeINfz+uN0fC1FNHDeop2qI+q5IkjNvoMN
 Dx7NxL0A==
X-Gm-Gg: AR+sD11YjIAZ9vRsHPq0ruMnp1G3vToVKge8wlZQeITbWzM9+Nj7Qk52LUaXRwG7+iC
 5chxB5KkvU0bo0VHVcG87mn+Vury7LtU60ayxvtR+mMMC+4Kf5tBDg+AaXHGZ1dZbmG0Oq0J5Qz
 TF9FimK52O7QWthhGp5mB+eN8vaQCO7+GGDXY1vK/8MUq5Ak+sgEyUEx1YC4mVcpN42NMWOu6BC
 MuATZwdH8AgkGwP7D66sAE7p4M3WhnzMUYMPBPniYzdrklSVQS3n8J2qhm4AljOIW6BliWd4Puz
 uwpVXeJqAfXjyznkWRGwpkfGKFLVRiyZcNRDd1ZxF7hs6qhKg/3W3P3DE0NSmiBZyv7f+HXR8fq
 LWIc7WnlqQFjkE96UjhRDvJKOuPqWw9aaanxugHvXaOVVnFcIAX8vGWHtFl1nJkF3K3FsXcUc8o
 /ANHf3xnPHV2rASkPXWHEfyX6z0Nzv/QcggUuCUEiF0mVt5fhfcDOBpfjp+76rdYMw17i6h+gK8
 KJQ6koRIIaj1DUb28Bce3xzBzVI3OEKH0G6BEUGlTgyezs1fCSUJx/2K6PnqAqnoCClYsrNiCn6
 SjzTEFgCE1+jFDUnkd9dBtQFOwbT/oFFVSxUDLjr2/jIoANImy1IUE1AfOnZVA==
X-Received: by 2002:a05:600c:8595:b0:499:518d:ebd6 with SMTP id
 5b1f17b1804b1-4997846c98fmr76982105e9.17.1786465637277; 
 Tue, 11 Aug 2026 09:27:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49977e86b55sm89058625e9.4.2026.08.11.09.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 09:27:16 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 11 Aug 2026 16:27:16 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2bd5259de702fce5d4ef6926c1dee7c6e6e597d7
X-Gerrit-Change-Number: 1841
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1841?usp=email>
X-Gerrit-Commit: a7bb5c3aaef57413d7ae219097a91730a1e462bb
References: <gerrit.1786465628000.I2bd5259de702fce5d4ef6926c1dee7c6e6e597d7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2NDY1NjI4MDAwLkkyYmQ1MjU5ZGU3MDJmY2U1ZDRlZjY5MjZjMWRlZTdjNmU2ZTU5N2Q3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <05f25704f37160025f5970a7a8a5be2ff72ed42e-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wtpK0-0008Qe-3T
Subject: [Openvpn-devel] [S] Change in openvpn[master]: otime: Remove
 openvpn_time()
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
Content-Type: multipart/mixed; boundary="===============0516549696759325651=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0516549696759325651==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QGfwgSOzerg="; charset=UTF-8

--QGfwgSOzerg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1841?usp=3Demail

to review the following change=2E


Chang=
e subject: otime: Remove openvpn_time()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

otime: Remove openvpn_time()

Using this funct=
ion seems to be more complicated
than just using now directly=2E

Suggested=
 by Arne in review of cppcheck fixes=2E

Change-Id: I2bd5259de702fce5d4ef69=
26c1dee7c6e6e597d7
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Eco=
m>
---
M src/openvpn/otime=2Eh
M src/openvpn/pkcs11=2Ec
M src/openvpn/push=
=2Ec
3 files changed, 3 insertions(+), 15 deletions(-)



  git pull ssh://=
gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/1841/1

diff --git a/s=
rc/openvpn/otime=2Eh b/src/openvpn/otime=2Eh
index f02cc31=2E=2Ed14f01e 100=
644
--- a/src/openvpn/otime=2Eh
+++ b/src/openvpn/otime=2Eh
@@ -93,17 +93,6=
 @@
 #endif
 }
 
-static inline time_t
-openvpn_time(time_t *t)
-{
-    upd=
ate_time();
-    if (t)
-    {
-        *t =3D now;
-    }
-    return now;=

-}
-
 static inline void
 tv_clear(struct timeval *tv)
 {
diff --git a/src=
/openvpn/pkcs11=2Ec b/src/openvpn/pkcs11=2Ec
index cfcd372=2E=2E8b06fd0 100=
644
--- a/src/openvpn/pkcs11=2Ec
+++ b/src/openvpn/pkcs11=2Ec
@@ -42,7 +42,=
8 @@
 static time_t
 __mytime(void)
 {
-    return openvpn_time(NULL);
+   =
 update_time();
+    return now;
 }
 
 #if !defined(_WIN32)
diff --git a/sr=
c/openvpn/push=2Ec b/src/openvpn/push=2Ec
index ce2baf2=2E=2E97f352e 100644=

--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -999,9 +999,7 @@
=
     else if (tls_authentication_status(c->c2=2Etls_multi) =3D=3D TLS_AUTHE=
NTICATION_SUCCEEDED
              && c->c2=2Etls_multi->multi_state >=3D CA=
S_CONNECT_DONE)
     {
-        time_t now;
-
-        openvpn_time(&now);
=
+        update_time();
         if (c->c2=2Esent_push_reply_expiry > now)
=
         {
             ret =3D PUSH_MSG_ALREADY_REPLIED;

-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1841?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I2bd5259de702fce5d4ef6926c1dee7c6e6e=
597d7
Gerrit-Change-Number: 1841
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--QGfwgSOzerg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1841?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">otime: Remove openvpn_time()<br><br>Using this function seems to be mo=
re complicated<br>than just using now directly=2E<br><br>Suggested by Arne =
in review of cppcheck fixes=2E<br><br>Change-Id: I2bd5259de702fce5d4ef6926c=
1dee7c6e6e597d7<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt;<br>---<br>M src/openvpn/otime=2Eh<br>M src/openvpn/pkcs11=2Ec<br=
>M src/openvpn/push=2Ec<br>3 files changed, 3 insertions(+), 15 deletions(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/41/1841/1</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/src/openvpn/otime=2Eh b/s=
rc/openvpn/otime=2Eh</span><br><span>index f02cc31=2E=2Ed14f01e 100644</spa=
n><br><span>--- a/src/openvpn/otime=2Eh</span><br><span>+++ b/src/openvpn/o=
time=2Eh</span><br><span>@@ -93,17 +93,6 @@</span><br><span> #endif</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-static inline time_t</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-openvpn_time(time_t *t)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    update_=
time();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (t)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        *t =3D now;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return now;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span> static inline void</span><br><span> tv_clear(struct timeval *tv)</s=
pan><br><span> {</span><br><span>diff --git a/src/openvpn/pkcs11=2Ec b/src/=
openvpn/pkcs11=2Ec</span><br><span>index cfcd372=2E=2E8b06fd0 100644</span>=
<br><span>--- a/src/openvpn/pkcs11=2Ec</span><br><span>+++ b/src/openvpn/pk=
cs11=2Ec</span><br><span>@@ -42,7 +42,8 @@</span><br><span> static time_t</=
span><br><span> __mytime(void)</span><br><span> {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    return openvpn_time(NULL);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    update_time();</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return now;</span><br><span> }</s=
pan><br><span> </span><br><span> #if !defined(_WIN32)</span><br><span>diff =
--git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>index c=
e2baf2=2E=2E97f352e 100644</span><br><span>--- a/src/openvpn/push=2Ec</span=
><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -999,9 +999,7 @@</=
span><br><span>     else if (tls_authentication_status(c-&gt;c2=2Etls_multi=
) =3D=3D TLS_AUTHENTICATION_SUCCEEDED</span><br><span>              &amp;&a=
mp; c-&gt;c2=2Etls_multi-&gt;multi_state &gt;=3D CAS_CONNECT_DONE)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 time_t now;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        openvpn_time(&amp;now)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        update_tim=
e();</span><br><span>         if (c-&gt;c2=2Esent_push_reply_expiry &gt; no=
w)</span><br><span>         {</span><br><span>             ret =3D PUSH_MSG=
_ALREADY_REPLIED;</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1841?usp=3Demail">change 184=
1</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1841?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2=
bd5259de702fce5d4ef6926c1dee7c6e6e597d7 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1841 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;=
frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--QGfwgSOzerg=--


--===============0516549696759325651==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0516549696759325651==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0516549696759325651==--

