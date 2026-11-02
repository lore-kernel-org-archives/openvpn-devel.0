Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4507D606A337
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WlDgqp7f;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=a/IsW2y2;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hau1ij0h;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ABLHgY3X
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=aBjvrD0OgNTaedJWqfTZS/7UVtgwHTjn6PSZzKa/8a8=; b=WlDgqp7ftYi07eVu1hABaOb++A
	Hv9YAhvgI+zsS2YjS8oiz7pUvMYKkqCQOxlrtoBIamgRPFar87A8qr6VD8oRXlWrumw0CeZ+hKBL7
	kABbHbzlNqfkOHyo54jd1shqnEs2OZXysjlGVBgRFtTKBBiZbSaNA12+90fJwdVw80FU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNt5j-000000006rP-1xbj;
	Mon, 02 Nov 2026 14:32:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNt5i-000000006rI-3QwT
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:32:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lihYfr2F9wvx1Ci/A7GssS1/tzXg3yC4ZujvI8cM3EU=; b=a/IsW2y2nxQ9SglccfEFcgMb+O
 WTsKTADgj8s5Q6uQmLMKxjRr80x8OexS4mFyHZVdwX9clKK+rj5vVKNydPHsWL9mwdy3dn5/uEG81
 Vd6/ylOrVvmFj80eXLjleivnyzCQu90MZ5LcWhVo9bDPvDdXl4xVCVKcWrFsZdZd2exc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lihYfr2F9wvx1Ci/A7GssS1/tzXg3yC4ZujvI8cM3EU=; b=hau1ij0h/SANHd8XIWqCCIeE1C
 yJRcpRKHavTZyi5SK3IZXv53pPhSFh/WvexAOCAymk3uVDEjow/BvQG8Z/EXlD5CxNOqGwNQoD07s
 rNro7uRQ4gY8BdxeGK2u1ETLzVN+l06viC8UMSRwAuAjRMPJtsy4QQ81/TSYd64ogUwg=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNt5h-000000001ka-0Jcn for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:32:54 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so20093595e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 06:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793629966; x=1794234766; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lihYfr2F9wvx1Ci/A7GssS1/tzXg3yC4ZujvI8cM3EU=;
 b=ABLHgY3XaiosYErwUZH4uK5FMDYmtvIN9GT3r5BssVL/Af+wlePmQf3b+xJZCZgJAv
 gTDLKAdrwdYbn5sA8AvzD11HzjAsNXdzssi4HooihfxKrbQSHh9CJySgqpkRovgJzCos
 J9HigW7rC5Dj7O7QPzZlzQFymUkqlIDhEnKycsJPOlJIp8uGT3nfRqo00sEC9Z2fgpD0
 gGRf9I7BJiaWqGMo6rNV2ZsesduPG+8m2i47jEzryi5z/kJO8YyTHUehzSy0SmzEzZ9u
 l/t3CWDpvkICkzCUZvFjueVLKdjRcTDNkUzITb5oAEqFgyI7mYAiwMvRPUpuFy4NXYp5
 zPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793629966; x=1794234766;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lihYfr2F9wvx1Ci/A7GssS1/tzXg3yC4ZujvI8cM3EU=;
 b=psHZNdFd9oi7FR2+8c6DRKLZkypy+7pPWVd0YXwCsJaJe3zzs/SOJUWOiANsQ76JX9
 EGdD09ZWRZnUeS0UOrq45zJ1qYBigdkSLgpphwD5aOjc42cZMg4jPoHJxH3FxeRvRJJR
 RCCZJhGcJVZXklpzp4I5gXh5+w5zbt6nt9IpVJ8Pkgl6tMHKN79+nHUC67ngIfFtSDNJ
 oHL2M0pSSYM1syORmNjosWWttM5HFfuUcwc6W/e0AElWOlX5oeCFu81mWOXRJ1PSz35X
 6M4Jd/BHHswuibC5qbblMQ5GRr/xlHV98dpESvSOpC0bvHYL+kP/kwAw0kQsb0MR7vsJ
 rFiA==
X-Gm-Message-State: AFq9FYIaMBL36vl9Akuw7QF2fzz2fF/z4ujXaCx7eW5eRI6Tzy8LOxum
 9HznGB4m7ioIosBrIwN1Anv8tEPgdghMLTHrSPa7Kxy4Z9b/iVNCkSwQI9QuIPm45rRv8LgExyr
 U1IIfS+0ie9gIOSsEGDCzyNoPLAVviBwBDkHY3nvUNPCEzlZmGrzgvgUz6BdsuD2wyAlXNxCFYq
 9/2i+7+w==
X-Gm-Gg: AYBFou23Msc1ybE2JGBhxQTPENSrhHwfOtNBYK4r7JgfrxYBisB+jLyfEEI1WoQIUe7
 dd9jTjm+bbidNctEfxd+Jvli4zsL49bvog+z6TjZY0LS7qnHpw29L98zzsbgetuioOaOvRcVJN/
 Ry8pIf04JaXBqfb1mPjpkaCTdDNm/7d5oe9jx/9c+K+/hRBlukpVph+DLK/OhZSGf7rvZiVkeTt
 Iz0PNENQ9J4JonAXs6fyK965MI8TOmIxjqDPF4TWcfoq/ZWBdh9U+bBO6dVUsdJpVuuL/HYRQqN
 cTXjfw3IAiGpHFyxvQS8r7F+UDp/EVBv3iBwvPw+ijNq8BZ7G18+39shSB5vMDLX0cHV0sjGvP0
 5kGq1NbDViAA3CUmzZXVYlNCbHqGt/pjGo2u0M00jIlAWUVhVqeEm9tHgsim9rGxxG0LzTjw41F
 dBOTyoMAeOm8zChw6MaCXjtTeMYZKdTnNTqOKvfYW+ZZN5R1c+SIuWm5H/02a6jiWA9cC6Ooa+N
 rp5QT2XV+wzkb1+SVclmgnFioaOQxh2Vp12r5zLK4iCU3tliWZ224j/fC75XiI7hbaQHLvAeLlB
 DFHbjMtAE4qJeoaaoaNwF7QioZlVUVIJZ8d1qYuexeGNw64130fc8+xX+crtZ6jVj3PNH6fEWy8
 PZVKF0hkXgXaOOP18E8JAYnBwzMwp6PZteW1rjpmOyGt3Ah3nLVhfDZ8xpfv6NCIBO8qVAOOn6D
 d7SrnDH26Y/uq6DeM7n5e+QrRqoeSDvO4nPfw=
X-Received: by 2002:a05:600c:19c8:b0:4a3:59c9:a743 with SMTP id
 5b1f17b1804b1-4ac1913ef8fmr238900315e9.27.1793629966329; 
 Mon, 02 Nov 2026 06:32:46 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ad414e298bsm127184125e9.2.2026.11.02.06.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 06:32:45 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 14:32:45 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I80b9969f555d670bc101635318d245d1b2de8ec5
X-Gerrit-Change-Number: 2092
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2092?usp=email>
X-Gerrit-Commit: 3faa767fb16e36723313613e772899157472becc
References: <gerrit.1793629964000.I80b9969f555d670bc101635318d245d1b2de8ec5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjI5OTY0MDAwLkk4MGI5OTY5ZjU1NWQ2NzBiYzEwMTYzNTMxOGQyNDVkMWIyZGU4ZWM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fbd98a023f2d6fca5e5a05373c11bab975438de8-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNt5h-000000001ka-0Jcn
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tun: free gc arena
 in windows_set_mtu()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8673990424700862428=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8673990424700862428==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hOozO5Bt83Q="; charset=UTF-8

--hOozO5Bt83Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2092?usp=3Demail

to review the following change=2E
=


Change subject: tun: free gc arena in windows_set_mtu()
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

tun: free gc arena in window=
s_set_mtu()

The arena used for strerror_win32() was never freed=2E

Broken=
 since 0213f80e ("Set the correct mtu on windows based systems")=2E

Change=
-Id: I80b9969f555d670bc101635318d245d1b2de8ec5
Signed-off-by: Razvan Cojoca=
ru <razvanc@mailbox=2Eorg>
---
M src/openvpn/tun=2Ec
1 file changed, 1 inse=
rtion(+), 0 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/92/2092/1

diff --git a/src/openvpn/tun=2Ec b/src/openv=
pn/tun=2Ec
index fdd13ae=2E=2E988cb6e 100644
--- a/src/openvpn/tun=2Ec
+++ =
b/src/openvpn/tun=2Ec
@@ -5236,6 +5236,7 @@
         msg(M_INFO, "%s MTU se=
t to %d on interface %d using SetIpInterfaceEntry()", family_name,
        =
     mtu, iface_index);
     }
+    gc_free(&gc);
 }
 
 

-- 
To view, visi=
t https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2092?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I80b9969f555d670bc101635318d245d1b2=
de8ec5
Gerrit-Change-Number: 2092
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83z=
van Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--hOozO5Bt83Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2092?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">tun: free gc arena in windows_set_mtu()<br><br>The aren=
a used for strerror_win32() was never freed=2E<br><br>Broken since 0213f80e=
 (&quot;Set the correct mtu on windows based systems&quot;)=2E<br><br>Chang=
e-Id: I80b9969f555d670bc101635318d245d1b2de8ec5<br>Signed-off-by: Razvan Co=
jocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/tun=2Ec<br>1 f=
ile changed, 1 insertion(+), 0 deletions(-)<br><br></pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/92/2092/1</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>=
index fdd13ae=2E=2E988cb6e 100644</span><br><span>--- a/src/openvpn/tun=2Ec=
</span><br><span>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -5236,6 +5236=
,7 @@</span><br><span>         msg(M_INFO, &quot;%s MTU set to %d on interf=
ace %d using SetIpInterfaceEntry()&quot;, family_name,</span><br><span>    =
         mtu, iface_index);</span><br><span>     }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span> }</sp=
an><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2092?usp=3Demail">change 2092</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2092?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn=
 </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Id: I80b9969f555d670bc101635318d245d1b2de=
8ec5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2092 </div>
=
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ope=
nvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--hOozO5Bt83Q=--


--===============8673990424700862428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8673990424700862428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8673990424700862428==--

