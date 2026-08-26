Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0A0C61DBD
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SRo8XjhOc2fZ7wBL/nX3adVf2cslHu15voAbclvJn4o=; b=a4StuedESY1ztjC+Lg1F5FyRdQ
	Zqhm11xmaCQveTFHbLgc4weVeuR5EmBh+SR/782EPDdkSgszC9zebGR40C4wXrdC+HJ66swif9oN9
	tT7Oq3tWRuygD1Kub7azDL7ckQcF6XlKP7HEuz/80MkcdUgR+JS38sKeM2yWGnb7eW58=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzGhv-00040g-Dk;
	Wed, 26 Aug 2026 16:42:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzGhu-00040a-Ki
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 16:42:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=2x2Sq3uvauueVN/r0ohXcZWjUbeG6PyL6B+3XLUnjjs=; b=OdEpZivVP2WLIDJTldp+bibmvp
 eMRQOzJ2RWOzXGVRdlw04SKuEc8sZPUu6AIyH6Z/CSbFtqN6O7AtFr3QyjUi6DpbcyCfP0qlK9o4R
 fdpR0Ejwmt+t0LswaEAlk9srWdi2i1TI+hVUek8pJZuS0uqNurc5ksCb0SLz2QQccB7I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2x2Sq3uvauueVN/r0ohXcZWjUbeG6PyL6B+3XLUnjjs=; b=d
 0/F7mCkGlhe1Bn84UCV0m+RKm+HpeR+y3JgDryQ3TALmP8hqFc/VZ2t+HG3fXk4C0z6aToJwpykcX
 wB5bAOn1aEKW0G+eCiKEAizabo54M/ihq/zArvqb1VMR2IuI6GFQx2uKus1gG3qWo+8RBXUvpqbKl
 o1Tv9msIPj08zLxA=;
Received: from mail-ed1-f42.google.com ([209.85.208.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzGht-0001HD-30 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 16:42:34 +0000
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6a38098734bso2017881a12.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 09:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787762546; x=1788367346; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2x2Sq3uvauueVN/r0ohXcZWjUbeG6PyL6B+3XLUnjjs=;
 b=L8fcAdna//uoVP8qgQJQzv4mKkA14yM4cYBygZbZF3pLB24jM2gv2diiL7k9ZZGFaG
 thu43x/8ERVjI/ZbEyLfNe1tWDdxaSJqwKjMsrNof8xOZVZDHTMuttTbiSXCTrVYX01w
 syUOoC37FPWPAc3qG0Z2cMh2PbCBkucP9M5YeZzo8OHuptQ9Tzhc7DvLnsnozWSWCSYP
 GLjqgafuBflCjpocYx6fJk2hffGlEi5k66aSnBpphO1Z8cNAfWl2wL5+lnidGcSXD1JB
 HIg2LNPt+Jt6+NU+tCHTWSeulTjZ500SVihmzSw7ejjoCx8iGEaKUv++rzUagl7jQt4F
 kT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762546; x=1788367346;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2x2Sq3uvauueVN/r0ohXcZWjUbeG6PyL6B+3XLUnjjs=;
 b=XLyfwPi9MH+NgOkSTlzZ4znwLVM+dxM0RIa2gDc2DPCtnTncU+BrYLD24oxlJJmgHg
 llml288+WSgduAHzYGNTG9WPPPMHd/W48CewkisCnS1sphUbZQteg2OqFUS57cLg/JgV
 YPSLGfLI1zcN793O9JhETddSiL1oiqqMmdMymBI/3Tv/mdCJSr4qGcPq3r09nKtETWVz
 PyWwJe922iGfex5Myo95vlbIEkf/6JY9uAAjj9clQG9y2RDfZETAzbPQcmHmddXgQZf+
 sGtacLunCq/10huCCJWXFKvuFVN4QnRHTAhEpxh9uZPBV4EBPoxOR7F3bhX+Tz9vfRrK
 Bzwg==
X-Gm-Message-State: AFuF++mGt6KTv8/9NkSdi1yBiyYsmchx3qTXXvIEl7/nXQxxJSex9Dsi
 DDUIwHOvVJbp0lOMEITcLrrKS70n4xA7PA9vXrxsmSOIZRKJnCzjHShhdYo7xe9jOhsYRjCDMyW
 POC7zyquxzCfkgPLkaOPkA9RRuwW1/dsBE/+WKv2XKBvk0hEqEK8QwnKS8TeemnUnpj/XU6aCnb
 SHEevVyQ==
X-Gm-Gg: AR+sD13Mi6Z6yfNJSHYaWFjYC2EX5XtIl2sGhlghPsSBthMy4IOaZWvmwFfI17mne+b
 dlOKpV8lxzp2g9SF6Qn+MS/hTQ0xdlFx+oCJW5kKp/6lWcY/jOlyG6yHvk/WRXwFIo6fL6mnXhn
 L0zYuw9+mPN3w3oLEc36tFiiG71vVizvLkmN/P3JZs2G13jUEZjxDsGzBoTZjzEVnZYr2xWAFQv
 jCRnO4k/HOh+iy8wu6ljXUJnBrdIa+dOmSGwssdEjiTC9G4PT1jyD/HxTgA1wMXskK3G1Arb9C1
 v2NY6JrhKRg55lk6Ie1/CNs01fWz33Yrb5/Z5XE701ONrewUcw668XSq9+70HQADThWZXd25if2
 nibwrScWOBwLTmttm1nx4TV8lVuJHK8ixGA5r3msWhmLq4MeN9hnTpv4K+tlaWy11SfjEiWS5QG
 YTMBm52VZPoq0ce9RCetLL7hGgaLL9fbiyDziRWuE+JZEWDKHsykxQ+uJ9nH+AeeRFuMttHaHMR
 892usb53cizfsm2V6jYAxDCZJyja7BjbY5HLUkkEG3KyUCsrbCltlaJWYDktJg2mXDMwMFFhMCQ
 7bVSiz7dPM7k3Kk7TXCbbVEsSNuW4tb8/jQP2Oycv6/YII2FGUs=
X-Received: by 2002:a17:907:3d0f:b0:c1f:983f:d8a with SMTP id
 a640c23a62f3a-c250c36b68emr1087120166b.24.1787762546334; 
 Wed, 26 Aug 2026 09:42:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8d1c80sm3932214a12.10.2026.08.26.09.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:42:25 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 16:42:17 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I42d8785959c24bf688190965e58b9b98251b8557
X-Gerrit-Change-Number: 1856
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1856?usp=email>
X-Gerrit-Commit: ca4f7dab0f5dfe538a1b22aa4b278699c7e91ee0
In-Reply-To: <gerrit.1787327336000.I42d8785959c24bf688190965e58b9b98251b8557@gerrit.openvpn.net>
References: <gerrit.1787327336000.I42d8785959c24bf688190965e58b9b98251b8557@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0MmQ4Nzg1OTU5YzI0YmY2ODgxOTA5NjVlNThiOWI5ODI1MWI4NTU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <07dc804300033949fe3ade4527526379d00f1cfc-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzGht-0001HD-30
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Introduce
 get_key_by_management_key_id helper function
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3884153995754983221=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3884153995754983221==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="e66iuQQBeh0="; charset=UTF-8

--e66iuQQBeh0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1856?usp=3Demail

to look at the new patch set (#7=
)=2E

The following approvals got outdated and were removed:
Code-Review-1 =
by flichtenheld


Change subject: Introduce get_key_by_management_key_id he=
lper function
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Introduce get_key_by_management_key_id helper function

This function all=
ows us to map from a management key id to a key structure
and also allows t=
his function to be reused=2E

Patch v2: add message when key is not found=
=2E
Patch v3: only consider valid keys

Change-Id: I42d8785959c24bf68819096=
5e58b9b98251b8557
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M sr=
c/openvpn/ssl_common=2Eh
M src/openvpn/ssl_verify=2Ec
2 files changed, 32 i=
nsertions(+), 10 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/56/1856/7

diff --git a/src/openvpn/ssl_common=2Eh =
b/src/openvpn/ssl_common=2Eh
index f6392f9=2E=2E6b86bc0 100644
--- a/src/op=
envpn/ssl_common=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -759,4 +759,24 @@
=
     return &multi->session[TM_ACTIVE]=2Ekey[KS_PRIMARY];
 }
 
+#ifdef ENAB=
LE_MANAGEMENT
+/**
+ * Gets the \c key_state object that belongs to the man=
agement key id or
+ * return NULL if not found=2E
+ */
+static inline struc=
t key_state *
+get_key_by_management_key_id(struct tls_multi *multi, unsign=
ed int mda_key_id)
+{
+    for (int i =3D 0; i < KEY_SCAN_SIZE; ++i)
+    {=

+        struct key_state *ks =3D get_key_scan(multi, i);
+        if (ks-=
>mda_key_id =3D=3D mda_key_id && ks->state > S_UNDEF)
+        {
+         =
   return ks;
+        }
+    }
+    return NULL;
+}
+#endif
+
 #endif /* S=
SL_COMMON_H_ */
diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_v=
erify=2Ec
index 063fa5d=2E=2E7375e87 100644
--- a/src/openvpn/ssl_verify=2E=
c
+++ b/src/openvpn/ssl_verify=2Ec
@@ -1249,22 +1249,24 @@
 tls_authenticat=
e_key(struct tls_multi *multi, const unsigned int mda_key_id, const bool au=
th,
                      const char *client_reason)
 {
-    bool ret =3D f=
alse;
+    struct key_state *ks =3D NULL;
     if (multi)
     {
-        i=
nt i;
         auth_set_client_reason(multi, client_reason);
-        for (=
i =3D 0; i < KEY_SCAN_SIZE; ++i)
+        ks =3D get_key_by_management_key_=
id(multi, mda_key_id);
+
+        if (ks)
         {
-            struct ke=
y_state *ks =3D get_key_scan(multi, i);
-            if (ks->mda_key_id =3D=
=3D mda_key_id)
-            {
-                ks->mda_status =3D auth ? A=
CF_SUCCEEDED : ACF_FAILED;
-                ret =3D true;
-            }
+ =
           ks->mda_status =3D auth ? ACF_SUCCEEDED : ACF_FAILED;
+        }=

+        else
+        {
+            msg(D_TLS_DEBUG_LOW, "%s: no key sta=
te found for management key id "
+                                 "%d",
+ =
               __func__, mda_key_id);
         }
     }
-    return ret;
+ =
   return (bool)ks;
 }
 #endif /* ifdef ENABLE_MANAGEMENT */
 

-- 
To view=
, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I42d8785959c24bf688190965e58b=
9b98251b8557
Gerrit-Change-Number: 1856
Gerrit-PatchSet: 7
Gerrit-Owner: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--e66iuQQBeh0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #7</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1856?usp=3Demail">View Change</a></p><p>The following=
 approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Introduce get_key_by_management_key_id helper function<br><br=
>This function allows us to map from a management key id to a key structure=
<br>and also allows this function to be reused=2E<br><br>Patch v2: add mess=
age when key is not found=2E<br>Patch v3: only consider valid keys<br><br>C=
hange-Id: I42d8785959c24bf688190965e58b9b98251b8557<br>Signed-off-by: Arne =
Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/ssl_common=2Eh<b=
r>M src/openvpn/ssl_verify=2Ec<br>2 files changed, 32 insertions(+), 10 del=
etions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/56/1856/7</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_c=
ommon=2Eh b/src/openvpn/ssl_common=2Eh</span><br><span>index f6392f9=2E=2E6=
b86bc0 100644</span><br><span>--- a/src/openvpn/ssl_common=2Eh</span><br><s=
pan>+++ b/src/openvpn/ssl_common=2Eh</span><br><span>@@ -759,4 +759,24 @@</=
span><br><span>     return &amp;multi-&gt;session[TM_ACTIVE]=2Ekey[KS_PRIMA=
RY];</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Gets the \c key_state object that belongs to the management k=
ey id or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * return N=
ULL if not found=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline st=
ruct key_state *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get=
_key_by_management_key_id(struct tls_multi *multi, unsigned int mda_key_id)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; KEY_SCAN=
_SIZE; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct key_sta=
te *ks =3D get_key_scan(multi, i);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (ks-&gt;mda_key_id =3D=3D mda_key_id &amp;&amp; k=
s-&gt;state &gt; S_UNDEF)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        return ks;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> #endif /* SSL_COMMON_H_ */</span><br><spa=
n>diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec</spa=
n><br><span>index 063fa5d=2E=2E7375e87 100644</span><br><span>--- a/src/ope=
nvpn/ssl_verify=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify=2Ec</span>=
<br><span>@@ -1249,22 +1249,24 @@</span><br><span> tls_authenticate_key(str=
uct tls_multi *multi, const unsigned int mda_key_id, const bool auth,</span=
><br><span>                      const char *client_reason)</span><br><span=
> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D f=
alse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct key=
_state *ks =3D NULL;</span><br><span>     if (multi)</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int i;</span>=
<br><span>         auth_set_client_reason(multi, client_reason);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; KEY=
_SCAN_SIZE; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     ks =3D get_key_by_management_key_id(multi, mda_key_id);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (ks)</span><br><span>         {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            struct key_state *ks=
 =3D get_key_scan(multi, i);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            if (ks-&gt;mda_key_id =3D=3D mda_key_id)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                ks-&gt;mda_status =3D auth =
? ACF_SUCCEEDED : ACF_FAILED;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                ret =3D true;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            ks-&gt;mda_status =3D auth ? ACF_SUCCEEDED : ACF_FAIL=
ED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(D_TLS_DEBUG_LOW, &quot;%s=
: no key state found for management key id &quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                 &quot;%d&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
__func__, mda_key_id);</span><br><span>         }</span><br><span>     }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return (bool)ks;</span><=
br><span> }</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br=
><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3Demail">change 1856</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I42d87859=
59c24bf688190965e58b9b98251b8557 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1856 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7=
 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: f=
lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>

</body></html>
--e66iuQQBeh0=--


--===============3884153995754983221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3884153995754983221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3884153995754983221==--

