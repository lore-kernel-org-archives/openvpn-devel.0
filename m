Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BDB606D82D
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LAGS8nNh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YPDIpizO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OptD36ns;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cS9FnLLf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=spf/jc/pEu3lxWODrhMkxVxJRDd0/7/X2h/tpGtf2sY=; b=LAGS8nNhn/FxSLUVxnaKHuxIUG
	M7GkW3SRm6yFAHlMa/Dit4c80TKJ6oVmRF6nhceA7W+ux6qtJoJEIu+mbg+YhnpRe3YIIgifFA1Wx
	HXcF5XBEaSqqQYEcKcvqkWzdkXRHeDz507IzGuYPVCcsxAKOGjfL3WAUdBHgMqqlZ4Lw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOHBp-000000007q3-1VlK;
	Tue, 03 Nov 2026 16:16:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOHBo-000000007pr-1c9I
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:16:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EzsUHPvuDy7sbruv1MU4pJQzrS2Ygk2ntD75O0zNKgk=; b=YPDIpizOYbjReyegl92yLjBu8D
 4aKcJP6kOSnWseiyUxnqdp48IFpGNxxRuoCdFrFtkKL10WWsD1RC4L4aiBZV3BE9rny2YEoF78Qn7
 1YX0eIxEGJ57C8XfXyaSr/l9zNPfDfOjXSXSbh92W9+Zkb1EkFvI22wihC1X/O/pRcsk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EzsUHPvuDy7sbruv1MU4pJQzrS2Ygk2ntD75O0zNKgk=; b=OptD36ns08Nn1FmIihNWocSDt9
 xtsKMmMQugWKY212FUNN0C04z0vyF0sLtcd3Xzqfg+sJimgcWY/g5bqxgzX4iowuCwHLXWbwxo7Eg
 7lyZ2umyyTXLcRw/MKMmJdQddykT/vjkL31DT2P0Vb7CLD3T2oEHEW+Bmhobay+wBl/g=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOHBl-0000000015O-2aOF for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:16:48 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48e6eb21a8fso1832728f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 08:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793722599; x=1794327399; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EzsUHPvuDy7sbruv1MU4pJQzrS2Ygk2ntD75O0zNKgk=;
 b=cS9FnLLfEsStEgtFeepwG6I/LSFwNMCYzJdzqdp0ht5LGkoSmVBMhPXJunbSH9S5yN
 +eeOFUP98eZLQWe/FTYQIKg/6XP0D0gDgQS48Ewp+1rpWSzMp8fthsHqJXVKoQrGM8/U
 3foH19HKJ/oQBItp1w7fo0QLj3AN7OlD2vugb4rY4ffJQqSAVyWv1MVGxveK844seBIk
 16m6wQ3uMhNLIMjJ57j+R6lN44sT1y7b9g61VkTp1E4MwEJeA/4C8pZOYCKZQx2vC6sZ
 W7USa0xfJ25tJPqIKItkaSaxuWfCBgE4OMLTR1aF6l5b+AzFjJJarTo+klWwtKEV3fm9
 cqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793722599; x=1794327399;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EzsUHPvuDy7sbruv1MU4pJQzrS2Ygk2ntD75O0zNKgk=;
 b=H0+cHWJ9KF544UOk5VxdT9U87P7xyfVWUGheltZviFqPVGek4HaFU2wIR+9LDq1VnG
 ngHd6EcN/ky3GuYB1tIzRYelUlsRRTN1L/1qnoKOsteqG75jwc99M9j0RZ5CHSgWZdYi
 eduWibb3bCp9dTdiG1S4cXwKJLipI6tFwSLoX05TtDteaXRX4xP+Q51SN0CFdibAF9XX
 W09aWVrDeGLrz/RG5BLMUN+Pga0fMEKMEaU60qcpbm3A5OxXo+wtsEK54DHvTa3ZA31F
 dM+ZCkT5oA5lWYH6pdXjREqCDZZ02kiTgBD4JM58xfRxulqIwPrPXe6e5UytXOgHgT47
 2YYg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxzo/+aRqQdVa827xFG4VIvVvhAe2hCMB6ZjrsPQAh2UWhr/lJXalJoTL/K6JKgcYbwJA4uv+Kb1U7ZY3vW@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9MOxqVQuRnElttnAA+icU/uajZQgQBfjpRK7VQsM8j28ZyJCE6
 S7KmkAbNYK951c+jaD2uaz/nv9be9CuaDddnLJanUDTrIb+N5YM0/aHpQBrpGmPA3/qg78+9FnF
 28291EeBXvLI0mEIyzq4172NtedOUUxHb3ArAiSNlcHDvkClahjKe8g5zHZcXbASYkTOM
X-Gm-Gg: AYBFou1X0gevlMBKVPF0DzX7Xtmp0y5s4Lk+/KjfKoZCXnT4+iCup/3JNtX/eoGzrr8
 Ykeq2mW74sTKuoJXK0iYGs72dRVaQv4ffIRCcGZ0UnrFnFpqoa8PdD1UPDi+yDvN14IGr9raupK
 4AxPqdv1KHSgFYCJxHdBBsiaC8CXsQ5BO81yh13zWa1n6duzncx3P9c0nlfzRX4/iazjnV2dRyG
 ID+ldFFngl2WDQVQv/iVpWwPeJAKZflKKH+V+NZcIdnOQv4ZURFa0qHIXk6CcSv73KR6LJf4JJ6
 RDTvN8cEqk+Xl0v5xfy8FBrDOP9QL5DslwPP2WPbfbOWPx5GKIHRltHIr22oXGKs8iIzbiM0Kwj
 ilcZeZq5AnklgBLlrD9nlbHk1U7lbEQbRT7k9ILKxnMZ0Y3YqUm2YB+DOLzoV1hdueWB2jupwSP
 xZOjUg17LfHbif2bEperg8LocVZhGXrWHinoag8+/eJKTlNlF4SXkfrtHwRtagBim3Yo/XI16Ib
 ep8v0z4upcw98gRI76efQ9rz+TPSVO5VZZcnvsjWerN1oaoH+DB/kw15zpSy8MD0b9iTICGSPGi
 MHE1bAXDcQWKLAOLaG3tNOu22cAZztuIfBVxzakF87Z7rmBW/FFGc7KVZ3kn3FlsswwIX00f9kv
 E6loYo9FG+96rJTABDPmdL17+Wtrk3shz4ino6QTvFxDZ49GAxxa7ygarxErhg0xBTWAZZneNC8
 rEJ7U1a7zyY+056Q0=
X-Received: by 2002:a05:6000:2587:b0:48d:dec7:974c with SMTP id
 ffacd0b85a97d-48e6e2bbfd3mr31092029f8f.7.1793722598545; 
 Tue, 03 Nov 2026 08:16:38 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b959c1sm25686842f8f.45.2026.11.03.08.16.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 08:16:38 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 16:16:37 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5953dd4e58cbcf8b2c9b38adcbe747223bc4eb6b
X-Gerrit-Change-Number: 2102
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2102?usp=email>
X-Gerrit-Commit: 4deabc2e666a8930608fa85690651bf86a1ac5c1
In-Reply-To: <gerrit.1793693265000.I5953dd4e58cbcf8b2c9b38adcbe747223bc4eb6b@gerrit.openvpn.net>
References: <gerrit.1793693265000.I5953dd4e58cbcf8b2c9b38adcbe747223bc4eb6b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjkzMjY1MDAwLkk1OTUzZGQ0ZTU4Y2JjZjhiMmM5YjM4YWRjYmU3NDcyMjNiYzRlYjZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4b06be010636b67251deb3e89cba2cea37df00e3-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOHBl-0000000015O-2aOF
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: route: fix AIX IPv6
 route delete error message
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5080937650822034065=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5080937650822034065==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZB2pTefsEdc="; charset=UTF-8

--ZB2pTefsEdc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2102?usp=3Demail )

Change subject: route: fix AIX IPv6 route d=
elete error message
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

route: fix AIX IPv6 route delete error message

delete_route_ipv6()=
 reported a failed delete as "route add command
failed"=2E

Broken since b4=
b92ae5 ("implement adding/deleting routes on AIX, for
IPv4 and IPv6")=2E

C=
hange-Id: I5953dd4e58cbcf8b2c9b38adcbe747223bc4eb6b
Signed-off-by: Razvan C=
ojocaru <razvanc@mailbox=2Eorg>
Acked-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2102
Message-=
Id: <20261103080936=2E8152-1-gert@greenie=2Emuc=2Ede>
URL: https://lore=2Ek=
ernel=2Eorg/openvpn-devel/20261103080936=2E8152-1-gert@greenie=2Emuc=2Ede
S=
igned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/rout=
e=2Ec
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/src/op=
envpn/route=2Ec b/src/openvpn/route=2Ec
index e8de2d5=2E=2E152d0d2 100644
-=
-- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -2309,7 +2309,7 @=
@
 
     argv_printf(&argv, "%s delete -inet6 %s/%d %s", ROUTE_PATH, networ=
k, r6->netbits, gateway);
     argv_msg(D_ROUTE, &argv);
-    openvpn_execv=
e_check(&argv, es, 0, "ERROR: AIX route add command failed");
+    openvpn_=
execve_check(&argv, es, 0, "ERROR: AIX route delete command failed");
 
 #e=
lif defined(TARGET_ANDROID)
     msg(D_ROUTE_DEBUG, "Deleting routes on And=
roid is not possible/not "

-- 
To view, visit https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2102?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I5953dd4e58cbcf8b2c9b38adcbe747223bc4eb6b
Gerrit-Change-Number: 2102=

Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revie=
wer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>

--ZB2pTefsEdc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2102?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">route: fix AIX IPv6 route delete e=
rror message<br><br>delete_route_ipv6() reported a failed delete as &quot;r=
oute add command<br>failed&quot;=2E<br><br>Broken since b4b92ae5 (&quot;imp=
lement adding/deleting routes on AIX, for<br>IPv4 and IPv6&quot;)=2E<br><br=
>Change-Id: I5953dd4e58cbcf8b2c9b38adcbe747223bc4eb6b<br>Signed-off-by: Raz=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2102<br>Message-Id: &lt;20261103080936=2E8152-1-gert@greenie=2Emuc=
=2Ede&gt;<br>URL: https://lore=2Ekernel=2Eorg/openvpn-devel/20261103080936=
=2E8152-1-gert@greenie=2Emuc=2Ede<br>Signed-off-by: Gert Doering &lt;gert@g=
reenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/route=2Ec<br>1 file changed, =
1 insertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/rou=
te=2Ec b/src/openvpn/route=2Ec</span><br><span>index e8de2d5=2E=2E152d0d2 1=
00644</span><br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src=
/openvpn/route=2Ec</span><br><span>@@ -2309,7 +2309,7 @@</span><br><span> <=
/span><br><span>     argv_printf(&amp;argv, &quot;%s delete -inet6 %s/%d %s=
&quot;, ROUTE_PATH, network, r6-&gt;netbits, gateway);</span><br><span>    =
 argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: AIX route =
add command failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: AIX route de=
lete command failed&quot;);</span><br><span> </span><br><span> #elif define=
d(TARGET_ANDROID)</span><br><span>     msg(D_ROUTE_DEBUG, &quot;Deleting ro=
utes on Android is not possible/not &quot;</span><br></pre><p>To view, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2102?usp=3Demail">c=
hange 2102</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2102=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: I5953dd4e58cbcf8b2c9b38adcbe747223bc4eb6b </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 2102 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zv=
an Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--ZB2pTefsEdc=--


--===============5080937650822034065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5080937650822034065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5080937650822034065==--

