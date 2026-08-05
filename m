Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F84C55184
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 01:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=gM6pn7y4BHd+Vv6TMzRtVlgBhAflxWZCEpLVQP3XQ0s=; b=OhfFhyH6V5nj+y
	ixk+usN6ZK05DDDzbJMCQod17YYo55Gc0GOmf+aW17D6oC35P+7OQML+qiorTIvLJWImMhMXY4vGE
	uzyBq+T90rJBfner4cGmauMxRhBaMAlpcYCZaqjGo82w7MckZqwwU+O5aLtEwyk0FOklfraSSwHRZ
	UOo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrQPw-0006J9-Ak;
	Wed, 05 Aug 2026 01:27:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrQPu-0006Ir-Gp
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 01:27:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1AwOmO6i85CP64Th5Kx/Evc5etOhepIgi8dlizN2nts=; b=NBSkp7k+XZZIxbqgY+ZQ5uPfSA
 EzWnsgN6Jfldxlm1QKLKqzkrVYvr5i7eGDYeW/C+jALbvNtvn44w50RTse/txOf+Cvc+JrYuqiKN7
 Nimx7DNeQNJ8EKxB+dwqucmqelKhjkIAUv4ju5hqbqAbzZuzA8gqEbjx0HS7D6V9ov+c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1AwOmO6i85CP64Th5Kx/Evc5etOhepIgi8dlizN2nts=; b=I
 CaywpgtH4QbeBNCZji+u48qQSNTYmzaVcb0VlCEE6TVLhYkANkIklcA9zGo9E/w9zLTZAbpxSaIJ7
 YC5zbcj5XN1BNcqNQuswZxwF3ff2RCYi8qwMSUPO5MAqUqUl6sPUAwfTlvIJbqCqenynL83aUqnNc
 glArlAWxRP09LDuw=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrQPt-00083K-Vz for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 01:27:35 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47fdd674e17so225453f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 04 Aug 2026 18:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785893247; x=1786498047; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1AwOmO6i85CP64Th5Kx/Evc5etOhepIgi8dlizN2nts=;
 b=F5+pbdh7pKh+W1bX21nj2xXjppHojpT6aXBWC3Z/2HD1lFyCa5o37Jhds3JdG8bwLw
 a+8jwR5aZetfQ4RqVpojOBIUMN7fgCabC/jf4fzwZStrP29xoYoAIRJc/DclHxatOZCh
 HhvhBvc7UUpv54LoGqITnrqiuSz9R+zLXjOb7yWYiKZXCxs7K72zh06CoiLPj7x+hW28
 8jrv0rHgFdMcU3AG5JriSHBaGmKriRYBS8jlWwwgMcamSx4XWUpW7uyJVZnE6UgCXdts
 FUNGR6Pf/oVO+b99jZmjO79tu7DTRuPGXrD1hUfOs+yaPV7JegTs6/z5lUQO/Ig6f9hn
 t7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785893247; x=1786498047;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1AwOmO6i85CP64Th5Kx/Evc5etOhepIgi8dlizN2nts=;
 b=NXHKzwMKLViaI8OiUNS8O/yLtSGKcKFF7n4Hu60N2hrVCQIlGBgtPigIVbAQdbl4sz
 SDWg2UEm3C5bptaGtBI2LW7upBeWXlbQWm4aWBd9Rm6MrAx7Mgr4jRWFAfb8W/XU3T7p
 /A1yKO+kxmSfpCZUhsNWvApMHqISZSCyKdKuFqSFb1KfwvNpdzbi4HxQqefImqA0XJlq
 A4vjLZKkUq+hFL2VNQ21a2rOFWzLSH7ePJwkbKZd1amVPkBDe+94Q8TRAw4SKq5Mt0RL
 xoejePCNMHYnna6iciB1ZKRDiPu0SRknutCgyDNl1JEQ2tzrLwOoBM8XDP21N69dAr0e
 4tzA==
X-Gm-Message-State: AOJu0YyXsv/cfUBOC6h1PMMy8xX4L9iAdNmU1j2o1CRuzLU38wYCUJ08
 YpPagBtARvTN0RuDURxkymuvOFhyVAujyumPJdzGFwP5Hs6LhLSnncO7EoTSvsKw8m06u1kX/gA
 FWFuvEuKRR4fvxW3x0tE4is6vU6t3wEdJOqX8GnpD7cRCqnSa4UIXbm8SXew+mt1whfL12jV1DO
 eIT6TxIg==
X-Gm-Gg: AR+sD13N5QHWLi0A01SZkJZBTlhLtjrZlBfLfr6IlhoXGFZLPnUoIJuPM/lkshvLaZj
 FL0G8Cu8JuUqpk/JU/BhecYb2gaHPFbLQyLVjdYF0iP7365IR/G8/CLGmzoLbvst3J1EIUsnMqU
 ZNMbhK2TDk8tAScXe/TPtoUHYGq6eMVPf10KoK0WfSxa7+Aix1s96DfjKpdDdxP7odemen4wIyh
 hN6Lxw0175GpPbESLcnLBQWbdO9grUXwv0UiqkNsr1Vbygm9GLTPyPumkSF8TC7DmKZ6F8hjBi0
 /bq9IdvbJLmf6PF2MCgFZtEFYL1/A/eSa7wnBxqOn1AWq6DV6n9+C/OCDREQTVqSekwdCLdgNYo
 gyMJfY4waIcnVyRabM+bUNOnJJ0SZwwtSsw5LtPupoJXzwclvArnCxJiDIVQJjPnP6r+uCj4Zww
 KaGLGuKu+5/M+Ghj0zkwBrskJvvEnxO2JPTf6RNJd/EIvSxbwPMugr5UdYdbnyFhTKm6KeVH/EG
 5bpG36d2x/qy1J6bQccolbm9X/O6S6XRT0nJF1vsjvV9x8aK4D5ZjUsZ550T2Nlpiacl3P0nIQm
 RJdLYRymcX1HoiNftX9STnxako30D6s0Pi1Xe9aDxYFF16eax04=
X-Received: by 2002:a05:6000:46cb:b0:47f:5369:bba with SMTP id
 ffacd0b85a97d-47fec532867mr3771450f8f.15.1785893247381; 
 Tue, 04 Aug 2026 18:27:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47febf7e5bdsm4440014f8f.0.2026.08.04.18.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 18:27:27 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 5 Aug 2026 01:27:26 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icc0721fd4a910110507d06b4e941e9e6dbb11e9f
X-Gerrit-Change-Number: 1836
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1836?usp=email>
X-Gerrit-Commit: 9c799a5e6b94f273ffc6c70a84ef21a89a53df60
References: <gerrit.1785893242000.Icc0721fd4a910110507d06b4e941e9e6dbb11e9f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1ODkzMjQyMDAwLkljYzA3MjFmZDRhOTEwMTEwNTA3ZDA2YjRlOTQxZTllNmRiYjExZTlmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7686265870f545233e896ad63cbaa2098ff218ba-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrQPt-00083K-Vz
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: reject a pushed
 epoch data format tag with a non-AEAD cipher
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0706780517747256825=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0706780517747256825==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8e+z57TRicQ="; charset=UTF-8

--8e+z57TRicQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1836?usp=3Demail

to review the following change=2E


Chang=
e subject: ssl: reject a pushed epoch data format tag with a non-AEAD ciphe=
r
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl: rejec=
t a pushed epoch data format tag with a non-AEAD cipher

The epoch data key=
 format is defined for AEAD ciphers only=2E Both places
that enable it loca=
lly verify this - multi=2Ec when picking the cipher to
push and ssl_ncp=2Ec=
 for p2p NCP - but the pulling side imports the
"aead-epoch" protocol flag =
without validating it against the cipher that
was actually negotiated=2E

A=
 peer pushing "protocol-flags aead-epoch" together with a non-AEAD
cipher t=
herefore makes us reach the M_FATAL in init_key_contexts() and
terminate th=
e process=2E This can be triggered whenever a non-AEAD cipher
is part of ou=
r own --data-ciphers, which is not unusual in
configurations kept compatibl=
e with old peers, e=2Eg=2E

  data-ciphers AES-256-GCM:AES-256-CBC

Validat=
e the combination in do_deferred_options(), next to the existing
data v2 ch=
eck, so that the mismatch is reported as an OPTIONS ERROR and
the connectio=
n is restarted=2E Turn the now unreachable M_FATAL in
init_key_contexts() i=
nto a session error as well, so that no future code
path can promote this t=
o a process exit=2E

Change-Id: Icc0721fd4a910110507d06b4e941e9e6dbb11e9f
S=
igned-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
---
M src/openvpn=
/init=2Ec
M src/openvpn/ssl=2Ec
2 files changed, 18 insertions(+), 2 deleti=
ons(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/36/1836/1

diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index=
 0236886=2E=2E84de986 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/i=
nit=2Ec
@@ -2711,6 +2711,18 @@
         return false;
     }
 
+    /* The =
epoch data format is defined for AEAD ciphers only=2E A peer may push
+    =
 * the tag along with a non-AEAD cipher, so this has to be checked here
+  =
   * rather than trusted */
+    if (epoch_data && !cipher_kt_mode_aead(c->=
options=2Eciphername))
+    {
+        msg(D_PUSH_ERRORS,
+            "OPT=
IONS ERROR: Epoch key data format tag requires an AEAD "
+            "ciph=
er, but '%s' was negotiated=2E",
+            c->options=2Eciphername);
+  =
      return false;
+    }
+
 
     if (found & OPT_P_PUSH_MTU)
     {
diff=
 --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 08ca306=2E=2E1380b=
9f 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1415,10 +=
1415,14 @@
     {
         if (!cipher_kt_mode_aead(key_type->cipher))
    =
     {
-            msg(M_FATAL,
-                "AEAD cipher (currently %=
s) "
+            /* The pulled options are validated in do_deferred_option=
s(), so
+             * reaching this point means a code path escaped that =
check=2E Fail
+             * the session instead of the whole process */
+=
            msg(D_TLS_ERRORS,
+                "TLS Error: AEAD cipher (cur=
rently %s) "
                 "required for epoch data format=2E",
        =
         cipher_kt_name(key_type->cipher));
+            return false;
    =
     }
         init_epoch_keys(ks, multi, key_type, server, key2);
     }
=

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1836?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit=
-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icc0721fd4a910110=
507d06b4e941e9e6dbb11e9f
Gerrit-Change-Number: 1836
Gerrit-PatchSet: 1
Gerr=
it-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--8e+z57TRicQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ordex would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1836?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">ss=
l: reject a pushed epoch data format tag with a non-AEAD cipher<br><br>The =
epoch data key format is defined for AEAD ciphers only=2E Both places<br>th=
at enable it locally verify this - multi=2Ec when picking the cipher to<br>=
push and ssl_ncp=2Ec for p2p NCP - but the pulling side imports the<br>&quo=
t;aead-epoch&quot; protocol flag without validating it against the cipher t=
hat<br>was actually negotiated=2E<br><br>A peer pushing &quot;protocol-flag=
s aead-epoch&quot; together with a non-AEAD<br>cipher therefore makes us re=
ach the M_FATAL in init_key_contexts() and<br>terminate the process=2E This=
 can be triggered whenever a non-AEAD cipher<br>is part of our own --data-c=
iphers, which is not unusual in<br>configurations kept compatible with old =
peers, e=2Eg=2E<br><br>  data-ciphers AES-256-GCM:AES-256-CBC<br><br>Valida=
te the combination in do_deferred_options(), next to the existing<br>data v=
2 check, so that the mismatch is reported as an OPTIONS ERROR and<br>the co=
nnection is restarted=2E Turn the now unreachable M_FATAL in<br>init_key_co=
ntexts() into a session error as well, so that no future code<br>path can p=
romote this to a process exit=2E<br><br>Change-Id: Icc0721fd4a910110507d06b=
4e941e9e6dbb11e9f<br>Signed-off-by: Antonio Quartulli &lt;antonio@mandelbit=
=2Ecom&gt;<br>---<br>M src/openvpn/init=2Ec<br>M src/openvpn/ssl=2Ec<br>2 f=
iles changed, 18 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/36/1836/1</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><=
span>index 0236886=2E=2E84de986 100644</span><br><span>--- a/src/openvpn/in=
it=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -2711,=
6 +2711,18 @@</span><br><span>         return false;</span><br><span>     }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* The epoch data format is defined for AEAD ciphers only=2E A peer may =
push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the tag =
along with a non-AEAD cipher, so this has to be checked here</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * rather than trusted */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (epoch_data &amp;=
&amp; !cipher_kt_mode_aead(c-&gt;options=2Eciphername))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        msg(D_PUSH_ERRORS,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            &quot;OPTIONS ERROR: Epoch key dat=
a format tag requires an AEAD &quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            &quot;cipher, but &#39;%s&#39; was negotiated=
=2E&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   c-&gt;options=2Eciphername);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> </span><br><span>     if (found &amp; OPT_P_PUSH_MTU)</sp=
an><br><span>     {</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/=
openvpn/ssl=2Ec</span><br><span>index 08ca306=2E=2E1380b9f 100644</span><br=
><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec<=
/span><br><span>@@ -1415,10 +1415,14 @@</span><br><span>     {</span><br><s=
pan>         if (!cipher_kt_mode_aead(key_type-&gt;cipher))</span><br><span=
>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  msg(M_FATAL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         &quot;AEAD cipher (currently %s) &quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            /* The pulled options are validate=
d in do_deferred_options(), so</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+             * reaching this point means a code path escaped tha=
t check=2E Fail</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
         * the session instead of the whole process */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            msg(D_TLS_ERRORS,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                &quot;TLS Erro=
r: AEAD cipher (currently %s) &quot;</span><br><span>                 &quot=
;required for epoch data format=2E&quot;,</span><br><span>                 =
cipher_kt_name(key_type-&gt;cipher));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            return false;</span><br><span>         }</spa=
n><br><span>         init_epoch_keys(ks, multi, key_type, server, key2);</s=
pan><br><span>     }</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1836?usp=3Demail">change =
1836</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1836?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"=
display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> =
Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id:=
 Icc0721fd4a910110507d06b4e941e9e6dbb11e9f </div>
<div style=3D"display:non=
e"> Gerrit-Change-Number: 1836 </div>
<div style=3D"display:none"> Gerrit-P=
atchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;anto=
nio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--8e+z57TRicQ=--


--===============0706780517747256825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0706780517747256825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0706780517747256825==--

