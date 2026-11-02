Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41013606A327
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Pjeqf9M6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gLHkQVf5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Y1K7Cddf;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dQqMRe+F
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=3YTMYoIVx8If5t3URvLJ6ObkxPxz67qbuUiDetolez4=; b=Pjeqf9M6s7uF+Prqbl73kgqYwU
	DaFy56aaTz2qi/icYO2Xs91Hv2H3Xj7drejFRA5feAsrMJWJSptuOaFEeNUCLGwPa05a9s55NSi89
	oSO1N3rG5gylxGZRqsYZRXPb1UsDXeZI0m/PwXLjLyM7KB53D22VNvZOgjqMwetnnHsM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNqKO-000000007Oo-1GUd;
	Mon, 02 Nov 2026 11:35:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNqKI-000000007Of-367x
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:35:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U3mjO+FIBakg1PxhnK1qKRxyP5RqQbxL/Svt2tqA670=; b=gLHkQVf57xJ0XyjxgRtEiNZItq
 l4/3/8WXqcssnIp30q4v2yUyPiBSReRPawSAyipzt+7zXi6sZylcUNdRD8g0sCEBoi5/N4DIrN9pE
 xnZuQ4GIEKss60MSnreycYxNPYHXwuE5LQeTyr+2IwY+yqKfBBkBYLn0Mcmm6Uo8aKJs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U3mjO+FIBakg1PxhnK1qKRxyP5RqQbxL/Svt2tqA670=; b=Y1K7CddfqPd2NPdMIa4HPQQkyy
 SWMo76kBeUw5Z+OAiXqD1b8AalsRaBpG2u4SjPmfMk0ke5OJ0H23an3JU8HoggE7zz4ffLOMWuO8X
 kRp+Y8wLBSFaBk1N5gtdUHWLqA2vH8F8hxvuZmJHFt2CuL8V/gD4XjeBbovhzv4BV0D0=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNqKH-0000000059g-0ZRu for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:35:46 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso2589943f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 03:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793619338; x=1794224138; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=U3mjO+FIBakg1PxhnK1qKRxyP5RqQbxL/Svt2tqA670=;
 b=dQqMRe+F9yAQ+tWSRbzO3sIEqRSCIxBpZzoACNiW0EYnC1fNFxtXUxk+TXmek4sy20
 4/TRD7Bu29CF9cEbcB9aB3Z+PHsDIZIyJTjlL6qOYj/2SS97ak8blnLck/5f/4VbKyq5
 +qt2BkeZlbZLvnKnu3oBulMwTeME6QxKKfjpS4pIwrK2wP94/QKxOOb+h3jdfESTC/Ml
 IiQHo6RBH6dzbnY6g6hydxJ/IaK2wgp5Vp5pI7QAnVMV2NQh3VRfye79S9SPJsmJ46yZ
 QET5Bs816NgYp3+y+fetgK6/xj8YIw7rhGrdtyARio2smK3rGBzBqs4avrlXfp87CMeu
 5eUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793619338; x=1794224138;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U3mjO+FIBakg1PxhnK1qKRxyP5RqQbxL/Svt2tqA670=;
 b=LnL3cqprJ11iumgPvx/OnGCoyq8c1iW0J7wvLjzse9tD1zhQIiN/D033rWeHSBdcDW
 mrPDlBY0lZep9wXMoyfXPSN1dbb15AvD3SH1JLuqSlStjQgH078al6569UR9zfHmTxna
 8fgFGb4WtA2eb/mHAfWdBwsJqtTDNrmYZprmwjv7dhbMbz86TubbjTEcMQB3Mzr09h35
 oxqEBbv531NuUsXe3xBHoylwGKDlw2u4GOHvzwaoUb1mMwUsZO6vol1a+IJyqrs4M+4e
 tXEQEhp1LhLn5oRc4kMrnpicBShnMISRRT1K6nvwbeAzweHvYamwEhvr31RkNH0kx1IV
 gI4g==
X-Gm-Message-State: APuU4Z/ZXvvtgKfC919TYjofT2hJpth9o+qocwlS6xGvAF9Mf01+fdkY
 y5YJ0eFt11qn8/DMFO8hZ4Mk6AEjvFOShCeLb0gBmzaW7YSpQzponapRkycvhS9sxCQArIWu1X8
 dzNvyW1cnNYAqrfgSiLLF8lu457jxa3JQHNkyEs8KOattKCbZtNTS981pFImX119rCB0CUYM3+e
 fNGD6hNA==
X-Gm-Gg: AYBFou24seUmApgFmMcxOHCaUIWuQQqGxsWxvSYyXTs4hpoX5mEqGAVFKV8u1Ant+j0
 e870yfrpbMoc7azh00PhJjuuwvbUxJib1UcjNtfQHkt42KORsf8IblUoCAohwzn3oxYR0rC5V/C
 NVImo2dp6MOdx050oNHHx3NHeeCeO7TZC0LNE1OYb8lePkuNEzSnzhZHkKEJzoK3q2L0MSx5KbU
 bKOSBRY6eYj8AQ+fo61o9dsOBRvLxB3rfDppEHGWjIE15Fmim5qf1n35APSFgMFXaUFFl40pn1z
 ya8fCHtJOmr7BSwiKU0X2y0Hx8ZD6iSH+n3ocbw0pixaOgo+l7/yyiyhA2ZbcQOnzNkXeHJvGHu
 +JP38A0CqWKTrsGx7AezXvnt2Qm5Me1fubUZzufq3R1WFZ1/6WlpsZogmAMguH26kzX/jzpvcmx
 oMsIR9RF/AGguUaJCrpz3RLH1FJODRAtHzT3XXAyXc256jywVh+iLj73Vuz2T6NXQD6o0b7oWbZ
 DodYw5y5AVLCVOZ/azYOJ7ucenWlUK5A0bmJDWGHLqvU2EGIPbLa+xUrf9ctFX7R6jQ7lqpn808
 qQPt05oTCHzbk0bZrGz7vNcK95cenUPmka7eww+rgZeT5yw1fqj14ig5bJBImZdhjUYj2t48DWB
 rAzrILPjPHgMuoPvuGztjMw7OFMWmzypvFh1NV3mBL/UV5UWRflnWif0hcfUOlTvbXnUk03wGEG
 Nffh6GpmdF7tBucHwIT1AuAFnrHWAY6gEmxUs=
X-Received: by 2002:adf:e003:0:10b0:48e:4e26:146e with SMTP id
 ffacd0b85a97d-48e6e533fbdmr16616161f8f.55.1793619338425; 
 Mon, 02 Nov 2026 03:35:38 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d5dfsm22819867f8f.3.2026.11.02.03.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 03:35:38 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 11:35:37 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I73cebcb7649e7c2bfdd29fee955b192f143a5ab9
X-Gerrit-Change-Number: 2086
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2086?usp=email>
X-Gerrit-Commit: 564210a5f01fa902c5b3775d06fdfc22ff0e42b5
References: <gerrit.1793619336000.I73cebcb7649e7c2bfdd29fee955b192f143a5ab9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE5MzM2MDAwLkk3M2NlYmNiNzY0OWU3YzJiZmRkMjlmZWU5NTViMTkyZjE0M2E1YWI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e8b68de9dc4330a93f3a53a250cf93eee5e19686-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNqKH-0000000059g-0ZRu
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: route: print
 net_gateway info instead of unset rgi/rgi6
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
Content-Type: multipart/mixed; boundary="===============8787101719957854223=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8787101719957854223==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="x4vkz28ffOU="; charset=UTF-8

--x4vkz28ffOU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2086?usp=3Demail

to review the following change=2E
=


Change subject: route: print net_gateway info instead of unset rgi/rgi6
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

route: print =
net_gateway info instead of unset rgi/rgi6

init_route_list() and init_rout=
e_ipv6_list() print rgi/rgi6 before
they are filled, so ROUTE_GATEWAY/ROUTE=
6_GATEWAY were never logged=2E
Print ngi/ngi6, which the surrounding block =
checks and exports=2E

Broken since 2777cdd3 ("route: handle default gatewa=
y (net_gateway)
and nexthop towards VPN server separately")=2E

Change-Id: =
I73cebcb7649e7c2bfdd29fee955b192f143a5ab9
Signed-off-by: Razvan Cojocaru <r=
azvanc@mailbox=2Eorg>
---
M src/openvpn/route=2Ec
1 file changed, 2 inserti=
ons(+), 2 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/86/2086/1

diff --git a/src/openvpn/route=2Ec b/src/openv=
pn/route=2Ec
index 0bce966=2E=2E7a475a6 100644
--- a/src/openvpn/route=2Ec
=
+++ b/src/openvpn/route=2Ec
@@ -619,7 +619,7 @@
     {
         setenv_rout=
e_addr(es, "net_gateway", rl->ngi=2Egateway=2Eaddr, -1);
 #ifndef ENABLE_SM=
ALL
-        print_default_gateway(D_ROUTE, &rl->rgi, NULL);
+        print=
_default_gateway(D_ROUTE, &rl->ngi, NULL);
 #endif
     }
     else
@@ -770=
,7 +770,7 @@
     {
         setenv_str(es, "net_gateway_ipv6", print_in6_a=
ddr(rl6->ngi6=2Egateway=2Eaddr_ipv6, 0, &gc));
 #ifndef ENABLE_SMALL
-     =
   print_default_gateway(D_ROUTE, NULL, &rl6->rgi6);
+        print_default=
_gateway(D_ROUTE, NULL, &rl6->ngi6);
 #endif
     }
     else

-- 
To view,=
 visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2086?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: I73cebcb7649e7c2bfdd29fee955b1=
92f143a5ab9
Gerrit-Change-Number: 2086
Gerrit-PatchSet: 1
Gerrit-Owner: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>

--x4vkz28ffOU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2086?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">route: print net_gateway info instead of unset rgi/rgi6=
<br><br>init_route_list() and init_route_ipv6_list() print rgi/rgi6 before<=
br>they are filled, so ROUTE_GATEWAY/ROUTE6_GATEWAY were never logged=2E<br=
>Print ngi/ngi6, which the surrounding block checks and exports=2E<br><br>B=
roken since 2777cdd3 (&quot;route: handle default gateway (net_gateway)<br>=
and nexthop towards VPN server separately&quot;)=2E<br><br>Change-Id: I73ce=
bcb7649e7c2bfdd29fee955b192f143a5ab9<br>Signed-off-by: Razvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/route=2Ec<br>1 file chang=
ed, 2 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/86/2086/1</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><span>inde=
x 0bce966=2E=2E7a475a6 100644</span><br><span>--- a/src/openvpn/route=2Ec</=
span><br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -619,7 +619,7=
 @@</span><br><span>     {</span><br><span>         setenv_route_addr(es, &=
quot;net_gateway&quot;, rl-&gt;ngi=2Egateway=2Eaddr, -1);</span><br><span> =
#ifndef ENABLE_SMALL</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       print_default_gateway(D_ROUTE, &amp;rl-&gt;rgi, NULL);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        print_default_gateway(D_R=
OUTE, &amp;rl-&gt;ngi, NULL);</span><br><span> #endif</span><br><span>     =
}</span><br><span>     else</span><br><span>@@ -770,7 +770,7 @@</span><br><=
span>     {</span><br><span>         setenv_str(es, &quot;net_gateway_ipv6&=
quot;, print_in6_addr(rl6-&gt;ngi6=2Egateway=2Eaddr_ipv6, 0, &amp;gc));</sp=
an><br><span> #ifndef ENABLE_SMALL</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        print_default_gateway(D_ROUTE, NULL, &amp;rl6-&gt;rgi6=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        print_def=
ault_gateway(D_ROUTE, NULL, &amp;rl6-&gt;ngi6);</span><br><span> #endif</sp=
an><br><span>     }</span><br><span>     else</span><br></pre><p>To view, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2086?usp=3Demail=
">change 2086</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
086?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: I73cebcb7649e7c2bfdd29fee955b192f143a5ab9 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 2086 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</bod=
y></html>
--x4vkz28ffOU=--


--===============8787101719957854223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8787101719957854223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8787101719957854223==--

