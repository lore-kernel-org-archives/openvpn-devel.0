Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDEFC61DB9
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MGJPCL811VyYfD2WqencBNwLRmysJ4T3suzHMItIMwI=; b=hH2h6uwICqC1Fj758o5ddKVIGL
	i2vN20FbB1+lCqv2LLE4qIhJxbsaYfd50hcgiTGgSoHi5pXiDVXDhX4Z9Z33B/tA9RsaurevY1TOB
	NH/jlzzPjuXmX89y2fKJXMOURTW78Wsxz/eh5sNbFMf2RJomg7n8dwfyytEYM+TOWCgc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wztrc-00063A-W0;
	Fri, 28 Aug 2026 10:31:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wztrb-000633-KT
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 10:31:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=gbg3T8Eo5MRSLmye5j7RccusagEied8NKtBoYEx0KHU=; b=jNUJsrGBMl0pFZBTE3pJR2ghGN
 Ms4EyGnmpj+1QWWCK7FWnzVJUI8UKUS58zW6mwx3lLaEEfU188Xfb7XjgBoGizH862zxoNfmNlL71
 mhyXqTsGxGVYxU5U0bDUFWZDNrqX4Zn0a+ZxSGYfhrRUAL3fJSFUMO3CaMqB28PWrVxU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gbg3T8Eo5MRSLmye5j7RccusagEied8NKtBoYEx0KHU=; b=N
 06Cu1077x/WVTcNIOA1ZpgMsWEm4PeO+s8C9bS15ZHg9sycmGdLQVwTa4yH7ZB6aMMu9jU5iiwfQg
 rtNV5OUvDPSfduCwE6BjkvioATxPLmP6izqR6DpS7xLJbM+MFYs96EUKtq5hVfvm5wKJTAfJ1kj1V
 vCL2sfguF6vkv63E=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wztrY-0007xF-V1 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 10:31:11 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so4218165e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 03:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787913062; x=1788517862; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gbg3T8Eo5MRSLmye5j7RccusagEied8NKtBoYEx0KHU=;
 b=M8Psu3zxAMdrtSYHCfbtqcEsmG8JgBlkmPJ5zjpo+Bg0TADPG66j9gIjJG87lNeaOO
 PYM1E8WLoJcjgWZa6Brd6S/DGezHX4BM+QRFj2aVDnDpasMEhn/v5HmA/UrD6ZFWoieW
 EIfaVhZcYhR4dxu8q198KOpw2l+cRfiMMzsafhyjBMpBaFQn/LQOUeIC3ApBZVr55SKm
 XcRu1cBEtXGUiGkUB1gfvk8Dr/ehbvffLYmCXEj4QtBZ/1crNb5mnU9mNgmemK9+1i1I
 Ah04RMLfCFdvORSxO68cGi83Ua1Sno8TC+u0EAk/Ugaq0oRx7OItIc40fcJv38B52DRI
 hFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787913062; x=1788517862;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gbg3T8Eo5MRSLmye5j7RccusagEied8NKtBoYEx0KHU=;
 b=s/2sS4lZQyeOZA6sFePUSJ4h4d0IzQP4Snd0weJ8OkcPDlw3hw8Bux6/TwpBsWAZMw
 T91RGGN5v6shUls0qaiIZu4YUCt4Z4f7YhX0XadjRo0iNY3rHYOn61eSnFbnIKcjPdkv
 Kl2UyPDUYGEIYjCM09GBDLiRYcMaQBqVdAdwmy6Q6+TqP7PEAlSRbSxHVN/mRskWsLXG
 I5KVD9dHGLBRadWqL8tivK1CCPsKY4+GLlVdU49E47kS0RfmhXWiVzyrOHiSleP73bTm
 nURG5Wzi+eYPtCAlBGU6IW4iOnORvSvFlA9MXoKrFhhpeYXllddWpgrQbY5UmIQU2+zA
 SzlQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1qyiYQdDifhJ4QbW2D6qO5ZdcYc4DsgjOgjN19xYxKqhVNZMRSfm7rIu4B8LOrQAhorU7qhzqd7SVCM7g@lists.sourceforge.net
X-Gm-Message-State: AFuF++nnpXPtgVTuzpK4TImbSwtNmsFijPq1rHgtGn5FrPZ2LLmvCejB
 OcdRVMYOm5dVDKzRbIOpqIr80He16r85ATpnf8TOn7LhVBLPqenJYayhbuJk36gwyyxVytxllDp
 n7hAZzmHJX6ZDsod173sTw3cEGwTDM6ATkJ0WTRdCm0JpIg8VHkJvBYp5K/VEYBlJTbXH
X-Gm-Gg: AR+sD101h4BAsJqEND8jq3dSvidkxMeJFvlUsVKLAdKL305Is11OljUbZV1UwcrIixJ
 NUl0mc5hjCewtB0Wa9YIE4BniEMKJ/I/PpJI9FZmLmtzNy8lL18q6IU+qyQb2+VSxum9fzr6RUw
 25iYop0mjeRiesppRzK4aZDI7mt2enGg2J++4tRk1A1j6T8DzGKciTlf/Xhq4DRptOUju28C6bu
 N55RgisWDF9gqos6AkWWcP7QkMD5PQ9u63HnxkQydDhvb8ZKmxKToIAQLNBH7gycuuf7x56Tdoi
 OZj3MquEWcLDY7UuqpfItz7HdsDlQmUn375+elN9mVJEvxFjwOQtIpcj+sqB1OMQxyrF6+eWae/
 jWp88f5jHgiYCK93mnttPb5GAS0oWDEgoI5vdAAIMf+tmMQLmkJlUALUBi0KdGdGp0FszL62yk6
 KJ5+WcVxyJ6w0JxPM21XPgfj7LnhSYdp7Uqoa+HFbeGiphy+uhs1FqT7u2iqM+HTrzoui9gWiKF
 29VSh34gpINOoQR+eYnWADzbMAB/qebbZkHvm3JrL85dOvSjrUUJGeNp5GMmeCgNKg/EnOt2ghL
 NrSv7MrK8nVCogcMhNbXk1O1bPl1UqM4WmEUsjfwuxe57Xgp54s=
X-Received: by 2002:a05:600c:c494:b0:499:8aff:59b6 with SMTP id
 5b1f17b1804b1-49b91c486c3mr68859855e9.14.1787913062144; 
 Fri, 28 Aug 2026 03:31:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4c3211e1sm119941995e9.9.2026.08.28.03.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 03:31:01 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 28 Aug 2026 10:31:01 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: Ib7d9aa61fd878d7e025e9d1050c563dd114eb438
X-Gerrit-Change-Number: 1854
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1854?usp=email>
X-Gerrit-Commit: e9b9f6c0b61a3aaaa4c696ac3c091c4ee580a305
In-Reply-To: <gerrit.1787327336000.Ib7d9aa61fd878d7e025e9d1050c563dd114eb438@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ib7d9aa61fd878d7e025e9d1050c563dd114eb438@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkliN2Q5YWE2MWZkODc4ZDdlMDI1ZTlkMTA1MGM1NjNkZDExNGViNDM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d30e366febdd680fe4ab49b86779d5c7f3ac7a70-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wztrY-0007xF-V1
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Factor out
 lookup_session_by_mda_key_id into its own method
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4761095577536133249=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4761095577536133249==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yKIhdrvBnqM="; charset=UTF-8

--yKIhdrvBnqM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1854?usp=3Demail )

Change subject: Factor out lookup_session_by_mda_ke=
y_id into its own method
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

Factor out lookup_session_by_mda_key_id into its own method

=
This makes the code a bit easier to read and also allows reusing
the functi=
on later=2E

Change-Id: Ib7d9aa61fd878d7e025e9d1050c563dd114eb438
Signed-of=
f-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
854
Message-Id: <20260826185309=2E18083-1-gert@greenie=2Emuc=2Ede>
URL: htt=
ps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38=
736=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/=
openvpn/multi=2Ec
1 file changed, 20 insertions(+), 10 deletions(-)




dif=
f --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index d8dd99b=2E=2E=
46ff1ba 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -=
4014,6 +4014,24 @@
     }
 }
 
+static struct tls_session *
+lookup_session=
_by_mda_key_id(struct tls_multi *multi,
+                             const=
 unsigned int mda_key_id)
+{
+    if (multi->session[TM_INITIAL]=2Ekey[KS_P=
RIMARY]=2Emda_key_id =3D=3D mda_key_id)
+    {
+        return &multi->sess=
ion[TM_INITIAL];
+    }
+    else if (multi->session[TM_ACTIVE]=2Ekey[KS_PR=
IMARY]=2Emda_key_id =3D=3D mda_key_id)
+    {
+        return &multi->sessi=
on[TM_ACTIVE];
+    }
+    else
+    {
+        return NULL;
+    }
+}
+
 s=
tatic bool
 management_client_pending_auth(void *arg, const unsigned long c=
id, const unsigned int mda_key_id,
                                const ch=
ar *extra, unsigned int timeout)
@@ -4024,17 +4042,9 @@
     if (mi)
     {=

         struct tls_multi *multi =3D mi->context=2Ec2=2Etls_multi;
-      =
  struct tls_session *session;
+        struct tls_session *session =3D loo=
kup_session_by_mda_key_id(multi, mda_key_id);
 
-        if (multi->session=
[TM_INITIAL]=2Ekey[KS_PRIMARY]=2Emda_key_id =3D=3D mda_key_id)
-        {
-=
            session =3D &multi->session[TM_INITIAL];
-        }
-        el=
se if (multi->session[TM_ACTIVE]=2Ekey[KS_PRIMARY]=2Emda_key_id =3D=3D mda_=
key_id)
-        {
-            session =3D &multi->session[TM_ACTIVE];
-  =
      }
-        else
+        if (!session)
         {
             return=
 false;
         }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1854?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib7=
d9aa61fd878d7e025e9d1050c563dd114eb438
Gerrit-Change-Number: 1854
Gerrit-Pa=
tchSet: 9
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revie=
wer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>

--yKIhdrvBnqM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1854?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Factor out lookup_session_by_mda_key_id in=
to its own method<br><br>This makes the code a bit easier to read and also =
allows reusing<br>the function later=2E<br><br>Change-Id: Ib7d9aa61fd878d7e=
025e9d1050c563dd114eb438<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2E=
org&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>G=
errit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1854<br>Message-Id: &=
lt;20260826185309=2E18083-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38736=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M src/openvpn/multi=2Ec<br>1 file changed, 20 insertions(+), 10 deletions(=
-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=
=2Ec</span><br><span>index d8dd99b=2E=2E46ff1ba 100644</span><br><span>--- =
a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><=
br><span>@@ -4014,6 +4014,24 @@</span><br><span>     }</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic struct tls_session *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+lookup_session_by_mda_key_id(struct tls_multi *multi,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                             const u=
nsigned int mda_key_id)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (multi-=
&gt;session[TM_INITIAL]=2Ekey[KS_PRIMARY]=2Emda_key_id =3D=3D mda_key_id)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return &amp;multi-&gt;sessi=
on[TM_INITIAL];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (multi=
-&gt;session[TM_ACTIVE]=2Ekey[KS_PRIMARY]=2Emda_key_id =3D=3D mda_key_id)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return &amp;multi-&gt;sessi=
on[TM_ACTIVE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> static bool</span><br><span> management_client_pending_=
auth(void *arg, const unsigned long cid, const unsigned int mda_key_id,</sp=
an><br><span>                                const char *extra, unsigned in=
t timeout)</span><br><span>@@ -4024,17 +4042,9 @@</span><br><span>     if (=
mi)</span><br><span>     {</span><br><span>         struct tls_multi *multi=
 =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        struct tls_session *session;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct tls_session *session =3D l=
ookup_session_by_mda_key_id(multi, mda_key_id);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (multi-&gt;session[T=
M_INITIAL]=2Ekey[KS_PRIMARY]=2Emda_key_id =3D=3D mda_key_id)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            session =3D &amp;multi-&gt;session[T=
M_INITIAL];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else if (multi=
-&gt;session[TM_ACTIVE]=2Ekey[KS_PRIMARY]=2Emda_key_id =3D=3D mda_key_id)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            session =3D &amp;multi-=
&gt;session[TM_ACTIVE];</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        el=
se</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!sess=
ion)</span><br><span>         {</span><br><span>             return false;<=
/span><br><span>         }</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1854?usp=3Demail">c=
hange 1854</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1854?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Ib7d9aa61fd878d7e025e9d1050c563dd114eb438 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1854 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>

</body></html>
--yKIhdrvBnqM=--


--===============4761095577536133249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4761095577536133249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4761095577536133249==--

