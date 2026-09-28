Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6A0CA5FA2
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 21:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DvNEghKJ+7Ki1o3LosI9WOA09IAwN88IOgPDO0mDX6Q=; b=ZG/l3bXT64VELLkNSPYmu23cDL
	gFeNxRrHQHK9vCczKpsaZkYYYxI97bnP7lzCxSEZcQaz3ZcWfEHqcmHhUEKKXwRT+WoawZJfHeLiy
	yuC/J2TOR3/75DnS3MyTHnKaJAvFL7zbgkqe9tA/3qgw0P1JxvrYc14gq/kBacR5Zj5k=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBIdT-0000h5-EY;
	Mon, 28 Sep 2026 21:11:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBIdR-0000gn-Fe
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 21:11:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=sMqiiL2joEyRSWCLVPxVwADD8M3BJoH5UTk2V75vYFo=; b=DesI1rEvTzOMgFNUrLIxN6Ux6U
 +AJOWDyqPIBHNNEuSJ8bCouSjLd3foogyerT0yfGiSxE1F4s5QQYp3UquRcl+Phyqmy7SH/MRXBNj
 hUP99EaffJ1IaIYNlt0ZEG3SQkfu4gYzHLCmPAyiGffhzWsrqrzsryXX6X1hfhVH3+JE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sMqiiL2joEyRSWCLVPxVwADD8M3BJoH5UTk2V75vYFo=; b=Q
 Oed+DCIRI7S+cEr3PmxypnDVOmI857cF+Xr0KoqBNNihI9YiqaMIwAZMxDCPjplcm7/IRwy7mQ7jr
 rPoAWxT2igetdHY6QpUqTcH6uIE3AOSsJ/fH4Farng+msmiF4xlU9inxs2Dh11wypP8dkHzzfWlav
 okVSnbF2qQboJ9nk=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBIdR-0004lT-5P for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 21:11:42 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ffde3cec6so11319315e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 14:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790629894; x=1791234694; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sMqiiL2joEyRSWCLVPxVwADD8M3BJoH5UTk2V75vYFo=;
 b=fb+GtN1PjssPvpdBHlGhWia3V7mZuMZFi6EC+zqIWRHjOMAjXv0wk6HTLKq5UTqnAY
 P1DCm7gi5XLHyK5czDJz44D8gf43crmVBcVhrDQE+Gq1Y+xNg2YpNmv0rYLWAQQW1MyD
 qD1RW38L7S6FKW8qOfAMfBUalWpZZaYfB5ljKrULG+pR4P1BJMf1t/hiGWe6Lkh9oPJ8
 sK+ylMqQGPuOZgIioLqtHj3B4h4y844+ROKbppqIjmKvVO6cGctvJKSUBpPXiWsCjtEg
 R5cYtvLi1o7kfwoJJA0hGnYPxrMHIv8N1zyja48w8yYeMqVBeipjOHxsXRO2HPIJ5HJD
 BqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790629894; x=1791234694;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sMqiiL2joEyRSWCLVPxVwADD8M3BJoH5UTk2V75vYFo=;
 b=nFQqN+RwSy5l2KXz+YggvUTT+5WlJX5EjPvPZmh767mxlXVwH5k0rMx8s9cMN8MHUX
 ZJIjv5eG4Bc4tAYt5y8uOpvhZpHH5/H0m5lSqx1+fliKEHTb5W1jGiHKuB72FI5Zt2Up
 3tANfJJesvi6w3KdosP110KNDoE6Qq7KSaCXcBR9m5e0leXF3dq50RWFcAfTu5Uc4n4o
 xKrB6JOaU63xb2PW/uU5ln1+rXDzdAGpjuvkNv2q+bod3jVCljLiVo5ZUkoxMqvwJuIw
 t2Q6F1lVmhMowCBOyVtmoNYkicIJKBW+kMbHaesinr9V0wxIpRoYfmaYPDqW4eTKajAf
 XYTA==
X-Gm-Message-State: AFuF++nheImb1SoCYkAUcQKr1KVlrF4D/zwGPgwezuPn2ZsCibfi3iYl
 2B2E4C6hSmX7Lp7+bhI6g4VNcA/mNF5v5TLTVf+AQnYJj20BQjxs63VypO15DX5TW9mZqlBgM6s
 RSas+Th/tar5ntNN2qp0kwJzgYmY9FAgX70R02NwUWLJskNdjHqlnYQKN1ojBXnwAygxs
X-Gm-Gg: AYBFou1OwCD3U/q6ldwoINyBcoHtEQAlM4OM3uf6bPtrQR8h4/czAnzsmOvzBuAgtxq
 R0I0lohWk6N1vlrkj05wc47ohhQj0myG2gYPwmyVF4kkp/vVZ6zP6hf6EY4pM615kGmedBXqezv
 N0W4d6F6dIh5S6PkyzqhBMoBGnW8QLnStv18Ol+kxDtEKM1+6U6NvEjeX9HLGttO6x0Ef2jtMXx
 NYOyZ7vxtKzbeB3NVuAH3rOU+/nukAmsQ6W7m38TU6bYmePEv4DUL4zOrDpEmKEhPPjtSG+64M4
 tmfeyTXvxkLE93GBaaTo5BkuqK6M4uFJhhOfLNzdMeFE0ZOx8RmyxcQZOpRtcPKYNGm9IUTEGiY
 h5/mwBJ2M/2Grc8FESqtK4goFr9JmS78/IYEahTfpZRIdSnlwvawXBBZgB1A2w+Gwd7r1IAckXB
 3jlDwbUH7HKu8BBCF7suF0qwzouaxYKn69DNGPHr/xEGxhmUk5sUPGYPCbjJ+sgUyhjCuggrBn/
 8+LyZBeDWlE4hyd+pLz8fUXzkcPAG8OdFDfTUdnuL4EcOgrnmJxmLzpF0bqYKjcV3u/XjL43/Na
 ewsRKg2NteTMh/KNQF+I1a4+5sXiUywXDUKE2PMpKbiQVeMitWDHCgqfxFW7
X-Received: by 2002:a05:600c:4ecf:b0:4a0:108:3b54 with SMTP id
 5b1f17b1804b1-4a001e8c316mr72730775e9.32.1790629894295; 
 Mon, 28 Sep 2026 14:11:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cfa66e5sm24558895e9.11.2026.09.28.14.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 14:11:33 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 21:11:32 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3b835558451414d8a4e8058114643555be69d391
X-Gerrit-Change-Number: 1957
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1957?usp=email>
X-Gerrit-Commit: fe1162561c67e036e03bf07276d67d1b05d42cda
In-Reply-To: <gerrit.1790604535000.I3b835558451414d8a4e8058114643555be69d391@gerrit.openvpn.net>
References: <gerrit.1790604535000.I3b835558451414d8a4e8058114643555be69d391@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjA0NTM1MDAwLkkzYjgzNTU1ODQ1MTQxNGQ4YTRlODA1ODExNDY0MzU1NWJlNjlkMzkxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c6e63486d8d7b9bf8a021abb202c8fc62efde26b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBIdR-0004lT-5P
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6970503898071384309=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6970503898071384309==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RisEX9EYH1Y="; charset=UTF-8

--RisEX9EYH1Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1957?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by plaisthos


Change subject: cppcheck: Fix handling of likely() on Window=
s
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

cppcheck: =
Fix handling of likely() on Windows

Since we do not force __GNUC__ to unde=
fined on Windows
(since we want to support MinGW) cppcheck might stumble
up=
on __builtin_expect()=2E When running with gnu=2Ecfg (which
we do not want =
to do for Windows code) then that has an
existing override=2E But for our W=
indows checks we need to
add our own override=2E

This caused false-positiv=
es in buffer code=2E

Change-Id: I3b835558451414d8a4e8058114643555be69d391
=
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1957
Message-Id: <20260928141559=2E11880-1-gert@greenie=2Em=
uc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esource=
forge=2Enet/msg39555=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
A dev-tools/openvpn-cppcheck-windows=2Ecfg
M dev-tools/run-cppch=
eck=2Esh
2 files changed, 11 insertions(+), 1 deletion(-)


  git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/57/1957/2

diff --git a=
/dev-tools/openvpn-cppcheck-windows=2Ecfg b/dev-tools/openvpn-cppcheck-wind=
ows=2Ecfg
new file mode 100644
index 0000000=2E=2E9ac7282
--- /dev/null
+++=
 b/dev-tools/openvpn-cppcheck-windows=2Ecfg
@@ -0,0 +1,10 @@
+<?xml version=
 =3D"1=2E0"?>
+<!-- Only used for the Windows run=2E Can't be in openvpn-cp=
pcheck-library=2Ecfg
+     because it conflicts with gnu=2Ecfg=2E -->
+<def=
>
+  <!-- MinGW uses GCC, so we need to handle GCC builtins=2E gnu=2Ecfg ha=
s these,
+       but we do not load it for Windows=2E Without this cppcheck=
 does not
+       understand our likely()/unlikely() macros=2E -->
+  <defi=
ne name=3D"__builtin_expect(X,Y)" value=3D"(X)" />
+  <define name=3D"__bui=
ltin_expect_with_probability(exp,c,probability)" value=3D"(exp)" />
+</def>=

diff --git a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh
ind=
ex 4c4ba2c=2E=2Ead012ac 100755
--- a/dev-tools/run-cppcheck=2Esh
+++ b/dev-=
tools/run-cppcheck=2Esh
@@ -49,7 +49,7 @@
     tests/unit_tests/plugins/ ||=
 ret=3D$?
 cppcheck $COMMON_ARGS \
     --platform=3Dwin64 \
-    --library=
=3Dwindows=2Ecfg \
+    --library=3Dwindows=2Ecfg --library=3D${SCRIPT_DIR}=
/openvpn-cppcheck-windows=2Ecfg \
     -D_WIN32 \
     -UTARGET_LINUX -UTAR=
GET_FREEBSD -UTARGET_OPENBSD -UTARGET_NETBSD \
     -UTARGET_DARWIN -UTARGE=
T_ANDROID -UTARGET_SOLARIS -UTARGET_DRAGONFLY \

-- 
To view, visit http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1957?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I3b835558451414d8a4e8058114643555be69d391
Ge=
rrit-Change-Number: 1957
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--RisEX9EYH1Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1957?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">cppcheck: Fix handling=
 of likely() on Windows<br><br>Since we do not force __GNUC__ to undefined =
on Windows<br>(since we want to support MinGW) cppcheck might stumble<br>up=
on __builtin_expect()=2E When running with gnu=2Ecfg (which<br>we do not wa=
nt to do for Windows code) then that has an<br>existing override=2E But for=
 our Windows checks we need to<br>add our own override=2E<br><br>This cause=
d false-positives in buffer code=2E<br><br>Change-Id: I3b835558451414d8a4e8=
058114643555be69d391<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<=
br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1957<br>Message-I=
d: &lt;20260928141559=2E11880-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https:/=
/www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39555=
=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>-=
--<br>A dev-tools/openvpn-cppcheck-windows=2Ecfg<br>M dev-tools/run-cppchec=
k=2Esh<br>2 files changed, 11 insertions(+), 1 deletion(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/57/1957/2</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/dev-tools/openvpn-cppcheck-windows=2Ecfg b/=
dev-tools/openvpn-cppcheck-windows=2Ecfg</span><br><span>new file mode 1006=
44</span><br><span>index 0000000=2E=2E9ac7282</span><br><span>--- /dev/null=
</span><br><span>+++ b/dev-tools/openvpn-cppcheck-windows=2Ecfg</span><br><=
span>@@ -0,0 +1,10 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+&lt;?xml version =3D&quot;1=2E0&quot;?&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+&lt;!-- Only used for the Windows run=2E Can&#39;t=
 be in openvpn-cppcheck-library=2Ecfg</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     because it conflicts with gnu=2Ecfg=2E --&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+&lt;def&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- MinGW uses GCC, so we ne=
ed to handle GCC builtins=2E gnu=2Ecfg has these,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+       but we do not load it for Windows=2E W=
ithout this cppcheck does not</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+       understand our likely()/unlikely() macros=2E --&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;define name=3D&quot;=
__builtin_expect(X,Y)&quot; value=3D&quot;(X)&quot; /&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  &lt;define name=3D&quot;__builtin_e=
xpect_with_probability(exp,c,probability)&quot; value=3D&quot;(exp)&quot; /=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+&lt;/def&gt;</s=
pan><br><span>diff --git a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppc=
heck=2Esh</span><br><span>index 4c4ba2c=2E=2Ead012ac 100755</span><br><span=
>--- a/dev-tools/run-cppcheck=2Esh</span><br><span>+++ b/dev-tools/run-cppc=
heck=2Esh</span><br><span>@@ -49,7 +49,7 @@</span><br><span>     tests/unit=
_tests/plugins/ || ret=3D$?</span><br><span> cppcheck $COMMON_ARGS \</span>=
<br><span>     --platform=3Dwin64 \</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    --library=3Dwindows=2Ecfg \</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    --library=3Dwindows=2Ecfg --library=3D${SCRIP=
T_DIR}/openvpn-cppcheck-windows=2Ecfg \</span><br><span>     -D_WIN32 \</sp=
an><br><span>     -UTARGET_LINUX -UTARGET_FREEBSD -UTARGET_OPENBSD -UTARGET=
_NETBSD \</span><br><span>     -UTARGET_DARWIN -UTARGET_ANDROID -UTARGET_SO=
LARIS -UTARGET_DRAGONFLY \</span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1957?usp=3Demail">change 1957</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1957?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"=
display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3b835=
558451414d8a4e8058114643555be69d391 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1957 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>

</body></html>
--RisEX9EYH1Y=--


--===============6970503898071384309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6970503898071384309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6970503898071384309==--

