Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5D0606B71B
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HZXusbxD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Da8hKFH6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XHWsOwDR;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bIZbQ3ez
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=umP/KEpyuqG+TwDWPioklUzdiOf6aWmgp8ppOwuRMGg=; b=HZXusbxD7nmUsIuZQz8BYOBn9p
	DmdCEMJQa5xzP/6vG4QXZx7Y7ZixV0++4UPfUUXuwZfP5zBu4qG3akLcB3DSt7qQZCrr5+jOioxuC
	7XgpBMF18X8vVtb5650cn6AoZIT+MI4I5kAdlHO9NcfRM17ZrtFyg2sMVgUjuCInEXGQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUVTS-0000000087X-0Tsq;
	Fri, 20 Nov 2026 20:44:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUVTQ-0000000087C-026v
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 20:44:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IGmcjiJ9ce02oi6NWQjRc6FhOSWsXcwmR9w7645KDTQ=; b=Da8hKFH6cevQJIa7AaXV27oDYd
 BiICkJEnQjtwYm7tjCPOvkEju/+sjYWSA+hHV2EGXf0LHLYscvF+tkPFq5LEYt/u5GfJNUEwTQnDE
 lpVkyqMmB9YAga5PK1dR0GgObzmYLYrviR0PiDeaExxFwRXRtjvaNCTS35h78nwoMSlQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IGmcjiJ9ce02oi6NWQjRc6FhOSWsXcwmR9w7645KDTQ=; b=XHWsOwDRAbX6L9OWtL9bbTiskX
 QsqM/oD9NKTSCl4COO7EPWDZhJLC3eqHCqNyTuLQyU9J84T7vEix39M/VfMc00UF/9HvAMKOCTNn5
 qgNB8/DKV3X1jToEyXkGfhe3mKYkux4l+m8X745AlgxU9lRZvC0JGaloOH0sH3TFmpqg=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUVTO-000000003TF-491Q for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 20:44:43 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-49a92144733so721606f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 12:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795207476; x=1795812276; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IGmcjiJ9ce02oi6NWQjRc6FhOSWsXcwmR9w7645KDTQ=;
 b=bIZbQ3ezLzsDVxGpfjwd8fKaA88HdAlciZntGtIYArwrDy4U+8jLllGgrxnvV3F2Oc
 uQb/GNlYefPKFFG8oDP+v0eME4MO+SyBeJyKi0BP6qfW2Kk1DnyXW5Z4FPJDF47lAajf
 cXyuEdPlmLgZ8sTruv6Cv4zSMW/yZw4ogXP3OhlNmJxogUHq1pdJJdj9PuGKV/A2VPeE
 gPYfOQqw/ENc3IJ7HSnNs2G0rH+UGOxxms1iovXze5w1TRok7dxEyRqnP06gt8hL896v
 rYFlSn9uPf5EM7zxya3/mlJJiMnwMoGcusU86lYyfiD7Ma0MSWLZGqlGewdHo9Cy1Y9W
 bE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795207476; x=1795812276;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IGmcjiJ9ce02oi6NWQjRc6FhOSWsXcwmR9w7645KDTQ=;
 b=BUtkmtVArLiW+J7ez+CY7muTEyftrFplNQXjqHoIWx0QCXtqdTykw8TD0Ubm60Tex5
 1IVIoPPVja5fuI/U3r61hkVg0ZrIJuZAJk2dJBhcZURXTXyBtJ5b7Ih1hC1SjECSfLBa
 JYPSIDPdQcwyH5BJNNWq6Ji8Q+qPI3xwYsxXNro184+ydyPhiHVtKnUTJNJfTW6rEesm
 9Cmj7JFFvnKBEVpdumbJLaa3Matj/kMa1mSzzgcrr6Rr7raHvsWaBKRoiWpzKa++xz8c
 X/uFUhJFEWVSw5HPtxIe4cgW6W9t75rpqbSvuRVbduDhq3UjpJ55BBMPZtVw2syuYGjF
 Rirg==
X-Gm-Message-State: APuU4Z/3qHGG7h6VrGS8Kb3G0JWLw0iS1+K/Y7YJgAIupMyYmyA/LBKd
 RbVb0Gu3ZERp6C7zUnJXaXAavODxJJmWg2EErgktBhTa0VGhrkb8XtoCyxp2SGzJ1gC57HeMMY4
 oU+aeL4kMwgFiwz3gnbShu0RsSVSVNlB2NUAjUpc/ZaRs4pvRU2uduYu5oZus5puEdcpp42qNKx
 5UK1U0WQ==
X-Gm-Gg: AZFdTZfmcfovMKGM1PifIPvR6OLMRZ0qglMSYWUTK99mFxOSak2FNFMizzOM/peeeoH
 sd6NcKhUcTu0a0z2ucPx/aOHHpl26ZJUiLnLwddSnuFGtqTdH7sSTmGd5h0PLKEc2t2KwHXsEMn
 sPTQShA1Fzm+hLjAhFFGzKUX1DxNZBxHHSD3GFBAGtSlv/D0FfDpQuxvXLHah0wPciNXtHxB3yB
 B5ATABd9dnMrQWQoMFPn46EIREkwKoN92UqqLALxFZGeP9rT1MeCmDvaShH/3hS72Krs8rl8vqB
 17Gn8hhZFGVIg/oF5SBSbmQWxx8hC8cMhUNk3zYJQ7s7u937i8Cib0fxdGL9GTcybrmyV2te9ng
 JNb/QKZJrCI4a7Zh+V6mBWlgki9RlyvZbFSUNkvNbKvs/11a0dzg/qPRNhYXjGLLC+BhEefyJsU
 yVDvPIUgYS6ybAfHdqwolYhPTNH/3yr0W7dks3Sl3Qv2uEPtyQ4ivI1GYXUPZFPFcffYTweOQvj
 tcOcprdmckZH9dnTcP1FIDx58AHznMcgov1uL9wgp+p2QtitNAH3mMklJ+1IprMdAN+j/pGVIEQ
 hhvXwVKyIfRXcVLuW1GHE3s+OlY0aTSOuGXm+/QldvlvmzbLCeYTbqu1WMrderFp9c7bCB+4IOg
 /WXtnAAE0X1njsSz5/SXJwS4DcEyBlXi7hBcOqUq+DwYS2AydE6fTBOG7ATuYj9J6yATgOUIMDn
 /KIrBpzwusmokMguA=
X-Received: by 2002:a05:6000:4312:b0:4a7:2673:ad2e with SMTP id
 ffacd0b85a97d-4abacfea57emr9699700f8f.1.1795207476272; 
 Fri, 20 Nov 2026 12:44:36 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab5ffcad11sm7693858f8f.0.2026.11.20.12.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:44:35 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 20:44:35 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia359824eea8780805a59d19146740afe3630fa0c
X-Gerrit-Change-Number: 2233
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2233?usp=email>
X-Gerrit-Commit: d3aaef4478dd675f0ee2f65d8aa5ce0805a797b6
References: <gerrit.1795207472000.Ia359824eea8780805a59d19146740afe3630fa0c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MjA3NDcyMDAwLklhMzU5ODI0ZWVhODc4MDgwNWE1OWQxOTE0Njc0MGFmZTM2MzBmYTBjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <79b2659b6e56327fe2bab338ac1870f55a0fbc38-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUVTO-000000003TF-491Q
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: don't
 use stale data for NRPT exclude rules
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@ist.eigentlich.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5559370934024377324=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5559370934024377324==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LXpQegHwaYU="; charset=UTF-8

--LXpQegHwaYU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2233?usp=3Demail

to review the following change=2E
=


Change subject: openvpnserv: don't use stale data for NRPT exclude rules
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: =
don't use stale data for NRPT exclude rules

If the last interface GetNrptE=
xcludeData() looked at was not usable, its
entry was left with the domains =
set, and SetNrptExcludeRules() created
a rule from it=2E Clear the unused e=
ntry when done=2E

Change-Id: Ia359824eea8780805a59d19146740afe3630fa0c
Sig=
ned-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
---
M src/openvpnserv=
/interactive=2Ec
1 file changed, 6 insertions(+), 1 deletion(-)



  git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/33/2233/1

diff =
--git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
i=
ndex 354fe09=2E=2E24705a9 100644
--- a/src/openvpnserv/interactive=2Ec
+++ =
b/src/openvpnserv/interactive=2Ec
@@ -2521,13 +2521,13 @@
 {
     HKEY v4_i=
tfs =3D INVALID_HANDLE_VALUE;
     HKEY v6_itfs =3D INVALID_HANDLE_VALUE;
+=
    size_t i =3D 0;
 
     if (!GetInterfacesKey(AF_INET, &v4_itfs) || !Get=
InterfacesKey(AF_INET6, &v6_itfs))
     {
         goto out;
     }
 
-    =
size_t i =3D 0;
     DWORD enum_index =3D 0;
     while (i < data_size)
   =
  {
@@ -2627,6 +2627,11 @@
     }
 
 out:
+    /* Clear data left by an int=
erface that was not usable */
+    if (i < data_size)
+    {
+        ZeroM=
emory(&data[i], sizeof(data[i]));
+    }
     RegCloseKey(v6_itfs);
     Re=
gCloseKey(v4_itfs);
 }

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2233?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: Ia359824eea8780805a59d19146740afe3630fa0c
Gerrit-Change-Number: 2233
=
Gerrit-PatchSet: 1
Gerrit-Owner: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
=
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>

--LXpQegHwaYU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Heiko Hund would like Arne Sc=
hwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2233?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">openvpnserv: don&#39;t use stale data for NRPT exclude rules<br><=
br>If the last interface GetNrptExcludeData() looked at was not usable, its=
<br>entry was left with the domains set, and SetNrptExcludeRules() created<=
br>a rule from it=2E Clear the unused entry when done=2E<br><br>Change-Id: =
Ia359824eea8780805a59d19146740afe3630fa0c<br>Signed-off-by: Heiko Hund &lt;=
heiko@ist=2Eeigentlich=2Enet&gt;<br>---<br>M src/openvpnserv/interactive=2E=
c<br>1 file changed, 6 insertions(+), 1 deletion(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/33/223=
3/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/=
interactive=2Ec</span><br><span>index 354fe09=2E=2E24705a9 100644</span><br=
><span>--- a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/open=
vpnserv/interactive=2Ec</span><br><span>@@ -2521,13 +2521,13 @@</span><br><=
span> {</span><br><span>     HKEY v4_itfs =3D INVALID_HANDLE_VALUE;</span><=
br><span>     HKEY v6_itfs =3D INVALID_HANDLE_VALUE;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    size_t i =3D 0;</span><br><span> </sp=
an><br><span>     if (!GetInterfacesKey(AF_INET, &amp;v4_itfs) || !GetInter=
facesKey(AF_INET6, &amp;v6_itfs))</span><br><span>     {</span><br><span>  =
       goto out;</span><br><span>     }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    size_t i =3D 0;</span><br><span>   =
  DWORD enum_index =3D 0;</span><br><span>     while (i &lt; data_size)</sp=
an><br><span>     {</span><br><span>@@ -2627,6 +2627,11 @@</span><br><span>=
     }</span><br><span> </span><br><span> out:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* Clear data left by an interface that was =
not usable */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (i &lt; data_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ZeroMe=
mory(&amp;data[i], sizeof(data[i]));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span>     RegCloseKey(v6_itfs);</span><br=
><span>     RegCloseKey(v4_itfs);</span><br><span> }</span><br></pre><p>To =
view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2233?usp=
=3Demail">change 2233</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2233?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ia359824eea8780805a59d19146740afe3630fa0c </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2233 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</=
body></html>
--LXpQegHwaYU=--


--===============5559370934024377324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5559370934024377324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5559370934024377324==--

