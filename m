Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A512ACA5FA1
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 21:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Apx+v2EQamarJ7KyvWPTgW3cv2JkcpDV0puiLMSyYE=; b=k0Sg/UUn7P+eWASMJ997pimc1w
	MeolJ3uy3/Y0IxL66D1NTa7oDTt8+Cr3cEV1UMpK4hDoXcNmiXctO2l3qU/HGP6fSJmfI9HLo3B3Z
	4MPKemE0Gkxop4fIE5g1kIdCG7vghj6ir93oQiKNPnbLErGGwA0zLOL0gXap6AKmhKto=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBIdS-0003Hy-VA;
	Mon, 28 Sep 2026 21:11:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBIdR-0003Hs-QF
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 21:11:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tDK54gDywfi7DYNUsN25xQeZIb2Y9rp7Favr+CXzs9I=; b=l7TjLDTcVIkwHpxPl9SJ2KkYBl
 ZPZ0we+OZlJatj10vGO+dOSqd5NUjW/lKQWy1pQOtlQsm1gCEwJnn53Bs/QDyQQV3tev1/gsNPs8Y
 d23KUKamBuE3iiPgb5K7gw+TKQ0ZOL/II/Z9p9FkOrS+QkVB8X9PJrPodzVAWEOPZbao=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tDK54gDywfi7DYNUsN25xQeZIb2Y9rp7Favr+CXzs9I=; b=K
 lBGJgGQJ7CoBkDfr1iahtetoiHfm6pLSlDA5xZynEgF9g0bbt1w3L4LZcknUJpDRixZxX6JR1L6NB
 gtnaxQPdmDLoywcdWKGYiC5cV2o8YdpyYo+vAbnwtdzjWg2Pki42k/fYcIRANU58r8pRQUrj6BJt+
 DdGKUTGP6CBRWyvQ=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBIdR-0007Kx-Kh for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 21:11:42 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-4a00d8bec5aso1221185e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 14:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790629895; x=1791234695; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tDK54gDywfi7DYNUsN25xQeZIb2Y9rp7Favr+CXzs9I=;
 b=Ora3GbbnjC/vLYhx5mIWVKuNRA3e7xw3Gcmnko0TXaLw0TYHk5vqTufe8cS/M9KtI2
 7Z8OvezOlUC7JZAR8F6gIkstZHDOM2EsZNAcvI6q/uYE233LA3P1eEcII2PI4LumFFsW
 O/NfaMZHZPTRgxZ6spOO38n6XrPUoGei9cEUWY9bcRzmKXRqLj/d21MQuPP4zhTIpm7I
 YugrncuKq/ZKvyXPjXOuYZY3Ba55z6COMG23eo2w/waKj4Hlw1z/1mXX64zdOlC5rzoF
 GaM/KWwJYA7cl0XqpMB5jmWNN6nvfFb/VT0sZS/35zm1VvKd0dlZ75zphDDLVbDY/jMS
 qETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790629895; x=1791234695;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tDK54gDywfi7DYNUsN25xQeZIb2Y9rp7Favr+CXzs9I=;
 b=GgO81UK2kXCaylmnrkTXjRgkSkl2jkPRWhtHYSGF+jn0rP7Bj8GG9AGF0jCPbSJWT+
 YZgxWIKqepnhC7xofdRRYFQ3zzC8OGB7fLi4rll1bjx3VjtFID0JcJsgRCN/6vvLeXhJ
 8A7MrFaci8WKqtQntt0qM8PnytbHJmU02T5GmeHbFSz/43kT/klhfeFgGxiXyvlYwwBx
 uHbEh+xay75iMbzr3+RTE3RLo3PN5jjWMDwSzVUOsnFoX5M/6325MknRc0LPU3noKPzq
 n+MMModUYUU7VPCQll4F3JLmeDuvF5hpOAS6NAMF63JPon4t+LRdKnVJnJOBFTDD5Vua
 jexw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwM/tj2V+PoPz8qMRMsn/ZerdAaZ2k2vDpuimYB0AtfVZlynTDw3LqhIzECEeEBWDBoSbYxKF0w6jA2ks+i@lists.sourceforge.net
X-Gm-Message-State: AFuF++lAzk+srCBBKO/rnhDdabEM4vWv3JkMSIIUdxkuByAABypubD2q
 1xBB0bbiga/urBhEFleqQtuTJcpgJGSXwh6HPXHl5WM1WlJgtjzKS6tblP/S161k3hUaqC/qgAF
 TsrmVTaE2PokvJfeF3Csx0RIBBSBWV3Q0k+RJIcS58jn94JuisfTs9QBsron71/Scl7K8
X-Gm-Gg: AYBFou1ZXxdikOwX8/69QHxbk6JgzBwa9LHJhRuZ8dJpG76ft226Lrqmcdclcj2jqPv
 1MD6QR3oWgVTdyHY4ZXzqx0jKsC16dLLAlKN8+jrxpSGeYlIm0feSoMfXrtpKu3kUgHT8qGnKZc
 1Trofl0z4ERsHzCk+aHVqFc6IJbHQDuYA5gAPEGxy+tE+mCnbXKjUYJ7a7uVmdA6x1ld2Gb0+Dt
 re7zojMJfoNxeRIwEwmoSChsNxpGZV6AcKnF9yRnG0bWUBuiU4DNcoyMVGX7tRfPaf/yN8Rn2PV
 7RnWm2jVXH3UhiSIl5W+q/DWGyJ0zp7shCrxHb/U6kpVTjX+pn+3nK1apmcEpRLkRbJc+i7y82x
 Z9AE93wDnX6J/UqH6NEb6/IEdcQQAXuXBxz31yoz0FVL0l35NQYTEpLS6SGs0fczRVgyAVHr9NU
 ApA0VjdLxzQ6zojflmSbhUHA2HUvgxC+JjNUVaZMD4wxdGpkKcOysgWAq6rA9sEvRWDjQigkSPG
 J/GGmjfwVR8u1sS/l4J5MOGvZLuFiTfQckz6FcwkyfVfn5ROxchR2c7GyiZw3rFRPaeLE0Yfjc2
 3zmAsstm/HohO8qMnpxo7TJ3b4b221+h5yaXEoaMa8g41xn2zYx3OF2ZamT4
X-Received: by 2002:a05:600c:4e49:b0:49d:29ab:540b with SMTP id
 5b1f17b1804b1-49fe66cec31mr236061635e9.15.1790629895032; 
 Mon, 28 Sep 2026 14:11:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cfa66e5sm24560735e9.11.2026.09.28.14.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 14:11:34 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 21:11:34 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3b835558451414d8a4e8058114643555be69d391
X-Gerrit-Change-Number: 1957
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1957?usp=email>
X-Gerrit-Commit: fe1162561c67e036e03bf07276d67d1b05d42cda
In-Reply-To: <gerrit.1790604535000.I3b835558451414d8a4e8058114643555be69d391@gerrit.openvpn.net>
References: <gerrit.1790604535000.I3b835558451414d8a4e8058114643555be69d391@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjA0NTM1MDAwLkkzYjgzNTU1ODQ1MTQxNGQ4YTRlODA1ODExNDY0MzU1NWJlNjlkMzkxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c6e63486d8d7b9bf8a021abb202c8fc62efde26b-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBIdR-0007Kx-Kh
Subject: [Openvpn-devel] [S] Change in openvpn[master]: cppcheck: Fix
 handling of likely() on Windows
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0829957565518353612=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0829957565518353612==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="b6+x+7iRIx8="; charset=UTF-8

--b6+x+7iRIx8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1957?usp=3Demail )

Change subject: cppcheck: Fix handling of likely() =
on Windows
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

c=
ppcheck: Fix handling of likely() on Windows

Since we do not force __GNUC_=
_ to undefined on Windows
(since we want to support MinGW) cppcheck might s=
tumble
upon __builtin_expect()=2E When running with gnu=2Ecfg (which
we do =
not want to do for Windows code) then that has an
existing override=2E But =
for our Windows checks we need to
add our own override=2E

This caused fals=
e-positives in buffer code=2E

Change-Id: I3b835558451414d8a4e8058114643555=
be69d391
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-b=
y: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1957
Message-Id: <20260928141559=2E11880-1-gert@gr=
eenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg39555=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
A dev-tools/openvpn-cppcheck-windows=2Ecfg
M dev-tools/=
run-cppcheck=2Esh
2 files changed, 11 insertions(+), 1 deletion(-)




diff=
 --git a/dev-tools/openvpn-cppcheck-windows=2Ecfg b/dev-tools/openvpn-cppch=
eck-windows=2Ecfg
new file mode 100644
index 0000000=2E=2E9ac7282
--- /dev/=
null
+++ b/dev-tools/openvpn-cppcheck-windows=2Ecfg
@@ -0,0 +1,10 @@
+<?xml=
 version =3D"1=2E0"?>
+<!-- Only used for the Windows run=2E Can't be in op=
envpn-cppcheck-library=2Ecfg
+     because it conflicts with gnu=2Ecfg=2E -=
->
+<def>
+  <!-- MinGW uses GCC, so we need to handle GCC builtins=2E gnu=
=2Ecfg has these,
+       but we do not load it for Windows=2E Without this=
 cppcheck does not
+       understand our likely()/unlikely() macros=2E -->=

+  <define name=3D"__builtin_expect(X,Y)" value=3D"(X)" />
+  <define name=
=3D"__builtin_expect_with_probability(exp,c,probability)" value=3D"(exp)" /=
>
+</def>
diff --git a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=
=2Esh
index 4c4ba2c=2E=2Ead012ac 100755
--- a/dev-tools/run-cppcheck=2Esh
+=
++ b/dev-tools/run-cppcheck=2Esh
@@ -49,7 +49,7 @@
     tests/unit_tests/pl=
ugins/ || ret=3D$?
 cppcheck $COMMON_ARGS \
     --platform=3Dwin64 \
-    =
--library=3Dwindows=2Ecfg \
+    --library=3Dwindows=2Ecfg --library=3D${SC=
RIPT_DIR}/openvpn-cppcheck-windows=2Ecfg \
     -D_WIN32 \
     -UTARGET_LI=
NUX -UTARGET_FREEBSD -UTARGET_OPENBSD -UTARGET_NETBSD \
     -UTARGET_DARWI=
N -UTARGET_ANDROID -UTARGET_SOLARIS -UTARGET_DRAGONFLY \

-- 
To view, visi=
t http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1957?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I3b835558451414d8a4e8058114643555be69d39=
1
Gerrit-Change-Number: 1957
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--b6+x+7iRIx8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1957?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">cppcheck: Fix handling of likely() on Wind=
ows<br><br>Since we do not force __GNUC__ to undefined on Windows<br>(since=
 we want to support MinGW) cppcheck might stumble<br>upon __builtin_expect(=
)=2E When running with gnu=2Ecfg (which<br>we do not want to do for Windows=
 code) then that has an<br>existing override=2E But for our Windows checks =
we need to<br>add our own override=2E<br><br>This caused false-positives in=
 buffer code=2E<br><br>Change-Id: I3b835558451414d8a4e8058114643555be69d391=
<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Ack=
ed-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1957<br>Message-Id: &lt;2026092814155=
9=2E11880-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39555=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>A dev-tools/op=
envpn-cppcheck-windows=2Ecfg<br>M dev-tools/run-cppcheck=2Esh<br>2 files ch=
anged, 11 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/dev-to=
ols/openvpn-cppcheck-windows=2Ecfg b/dev-tools/openvpn-cppcheck-windows=2Ec=
fg</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E=
9ac7282</span><br><span>--- /dev/null</span><br><span>+++ b/dev-tools/openv=
pn-cppcheck-windows=2Ecfg</span><br><span>@@ -0,0 +1,10 @@</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+&lt;?xml version =3D&quot;1=2E0&quot=
;?&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+&lt;!-- Only =
used for the Windows run=2E Can&#39;t be in openvpn-cppcheck-library=2Ecfg<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     because it conf=
licts with gnu=2Ecfg=2E --&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+&lt;def&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  &lt;!-- MinGW uses GCC, so we need to handle GCC builtins=2E gnu=2Ecfg=
 has these,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       b=
ut we do not load it for Windows=2E Without this cppcheck does not</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+       understand our likely=
()/unlikely() macros=2E --&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  &lt;define name=3D&quot;__builtin_expect(X,Y)&quot; value=3D&q=
uot;(X)&quot; /&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  &lt;define name=3D&quot;__builtin_expect_with_probability(exp,c,probabili=
ty)&quot; value=3D&quot;(exp)&quot; /&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+&lt;/def&gt;</span><br><span>diff --git a/dev-tools/r=
un-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh</span><br><span>index 4c4ba2=
c=2E=2Ead012ac 100755</span><br><span>--- a/dev-tools/run-cppcheck=2Esh</sp=
an><br><span>+++ b/dev-tools/run-cppcheck=2Esh</span><br><span>@@ -49,7 +49=
,7 @@</span><br><span>     tests/unit_tests/plugins/ || ret=3D$?</span><br>=
<span> cppcheck $COMMON_ARGS \</span><br><span>     --platform=3Dwin64 \</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    --library=3Dwindows=
=2Ecfg \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    --libra=
ry=3Dwindows=2Ecfg --library=3D${SCRIPT_DIR}/openvpn-cppcheck-windows=2Ecfg=
 \</span><br><span>     -D_WIN32 \</span><br><span>     -UTARGET_LINUX -UTA=
RGET_FREEBSD -UTARGET_OPENBSD -UTARGET_NETBSD \</span><br><span>     -UTARG=
ET_DARWIN -UTARGET_ANDROID -UTARGET_SOLARIS -UTARGET_DRAGONFLY \</span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1957?usp=3Demail">change 1957</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1957?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: I3b835558451414d8a4e8058114643555be69d391 </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1957 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> =
Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--b6+x+7iRIx8=--


--===============0829957565518353612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0829957565518353612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0829957565518353612==--

