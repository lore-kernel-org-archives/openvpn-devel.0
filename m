Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10135606A32E
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FGDQhvhB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DcCHwcyX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=H8JzU5VJ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RVEpYsn9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=JyIN0UmgV+NoRb9GDq6tVSznmiYjfG0siem5mmBTnKA=; b=FGDQhvhBSdMgkyola815xWYTqV
	wLlnP/TPsno1dokNksd42A2kzCd2dmSCdHb7M3SMTMIh8Me2AXNvkmRWJqKIcG0H/VUEaUf58+Q9a
	r4BzAeC+Qt7huJJ5y6ifzUuJisQH4eK+uHPe4ENxNhi9lq3i/kwGWwCjVc2XMQOPvdEU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOVxi-000000001ma-0pBu;
	Wed, 04 Nov 2026 08:03:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOVxg-000000001mS-2alf
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 08:03:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q/3iQYFWfzPXjqCLmVBRRQ9GF+84q4KP3sW+esLMWlo=; b=DcCHwcyXuDNY9hSOubtBG5NGb2
 HYlBbEok9FbUkWP/S79esN8M4VGE43KNDVGW2Nqlirj7TGHh4/XTiEuZ8CDmNqaYon3fT2Q9JE+Yg
 IeoFkVJxD6sV0kCby71+T7wtNlMVx3KGsNP4e8f0AhEp3rtpyL0sv7ULIqNT39P2nT6E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q/3iQYFWfzPXjqCLmVBRRQ9GF+84q4KP3sW+esLMWlo=; b=H8JzU5VJQjDwrWuYyFjRHmuXVS
 vqm+9KbqmSE/G1giISESPFe736ewUXMTVOHBsl427heuLW374y2ge9TaKRdtmb4v2BGKGiEBukyva
 van73u7KpgS2ZJIz7qsQ9g7U/tivD/LKTEPFJXd/MP+Rakf4vO1QYd6J9AF6YoHqGq48=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOVxe-00000000700-0cP3 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 08:03:12 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48dfaa3fa12so922643f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 00:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793779383; x=1794384183; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=q/3iQYFWfzPXjqCLmVBRRQ9GF+84q4KP3sW+esLMWlo=;
 b=RVEpYsn9A/Wbjl+w1Eq7YPUN5B32G8FOvUgidw2Y2Q06yApoD+NVK6kRzRfwthqSel
 8KWGep4MizRCFW3MjCApmWoh4kBLwEi5+3DHkxEIedDOwYMQrz0lGg8tqDoz7yoEjCgA
 sXelv2I0pfkiqYOZ2M86x2jr3QgWBPJAjzX4ZBcI+9XkDuo6IN49+217x7E4vgh9ALCh
 3JEMA0vg6/HciVB5gQ3Fzil1wn3MlUFYnR1LNsngqQq38kVmISlWuucrHC5yK8efQoJJ
 e2lZiyaM6DO9bNfx/xo92itn851EaGGzMii0rN+CvGMG4VfWcgD9jdv9WHcX9esIkZpd
 BlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793779383; x=1794384183;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q/3iQYFWfzPXjqCLmVBRRQ9GF+84q4KP3sW+esLMWlo=;
 b=2vh2ybuPv9g+AhB24kjq5Q2tQRJyFhhGCCGYmyNnhXsuvKVHGNnvfmj9KtCQpjiA29
 LRn614deCVgJbAhkojXFRWapwYD2JiyeM5Er706rVCQZqXVsHEqk1KczUia9kmdgkMeu
 lwC0L54vmWEEizFdTSY142Sl154aN4R/SMNy9UKoeXDb68Nqi1ReFquRG6vfAtQGkt4v
 AA00qscUH+o/fknfVEN/IwMwk5rsy9hUJpdJkTma3Z1yyYCVXDNnw6p4gqJmS+ihnlp8
 cWjPSeuK4aecBAJJTecf3d9YQgWBNHu0TH4R3AxWE32TZe0X0lplrHQo+ob/Huusr9VF
 f5FQ==
X-Gm-Message-State: APuU4Z8tYy3e/DacMawamlyXvFv76KrE3bBsj+WtM3rO/53A8JyA+pVc
 jF22iTRD+n6cJbqt9qTBQEDeLsdrJLehZYQUvaqlK6nj81o5LMaRkLIC+nAq0iJ3MqytmRGmWuA
 XvSQ6jnrGxTHnImnEXho3kJKUTXjLuEmBHzxnrZdkYZGX5NX0JoUsT+hnLMshi00dVDSr84vCDr
 rC9VdBKQ==
X-Gm-Gg: AYBFou1zPJRRERqx/4sm1klvR6ehQOBe1IYvmh68yjzLKtkLZqNsORC9WGjgAx9KCr5
 j9cK2V2ORDSp7CsjLkFnkj8RkDaHb7iqxn6NDWBHrdgIyTPjUg2CC0IiZqu4W8E4kT5gGXUqGCm
 sR5szWndh9JdYTj5vMrGacLhCG+A6faH6Pj2B2tViUrZXzVPMVtm8nplhQ7L5E7d/UwloGPthHn
 UfWLaYwJsEpapmcFrTb1n6ye2flxnDoOYin0zs3bzEqyQrpRrpXB7XkCER6/npzK/V755Nw0xzW
 3JyCc3c3ao/NdOZ4B+WwbXGPNXElhQq1xSWUQ4fipMYrxaFoiw6sHhZYA7RnpE1kfFeLVXCcQR5
 aZI1zawWTWILBuBLFlNAVbN7w/P3Jv9uqvo6xUpw7Wgb6xEur/a8nD7AR/eeZggXc+yMvNfvP/L
 DhMgMZmxHfcRnTQ9KNIMJyBGxadgAmG6a7M+QCwyYS9Wuda11PSY+4mesZd4/0KLNlbeoO49mNG
 W/osNh5axHQg7NFr140ySlNfj9pcFFg/MisEK0kugXGN/TFl6J770c/Pd7BbDf9aP4pqT4HK3Od
 CuWsvG8ihAerB5mQs1fpw9o/pI4DlKOXoa69mp5XNBKscffdZ6B8l4z6N2gpCVNKVYwjVpE6n8z
 QQqWZ8tRZDHIDw7mMhHrIBB/J85S3++siDVrSqhUuupsbYUvSZ7QxAQISQJLSC2cxROIo49Fhq+
 b5f5IlgDA2332hPg==
X-Received: by 2002:a05:600c:3554:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-4ac14ec66d9mr369603685e9.2.1793779383434; 
 Wed, 04 Nov 2026 00:03:03 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4532916f2sm31338725e9.5.2026.11.04.00.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:03:03 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 08:03:02 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I879cd0fe9b1fabb350e1c4558863480064d45903
X-Gerrit-Change-Number: 2123
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2123?usp=email>
X-Gerrit-Commit: 851d474992c7c69b240fc166d87ad71fb17f8da5
References: <gerrit.1793779380000.I879cd0fe9b1fabb350e1c4558863480064d45903@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc5MzgwMDAwLkk4NzljZDBmZTliMWZhYmIzNTBlMWM0NTU4ODYzNDgwMDY0ZDQ1OTAzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <de7c3593811847127007cce76833f4b8fae063c4-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOVxe-00000000700-0cP3
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: route: remove
 unused max() and gc from BSD get_default_gateway()
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
Content-Type: multipart/mixed; boundary="===============7256523218176351056=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7256523218176351056==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="N93HyY2JDqA="; charset=UTF-8

--N93HyY2JDqA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2123?usp=3Demail

to review the following change=2E
=


Change subject: route: remove unused max() and gc from BSD get_default_ga=
teway()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

rout=
e: remove unused max() and gc from BSD get_default_gateway()

Both lost the=
ir last users when 76d11614 ("get_default_gateway()
HWADDR overhaul") repla=
ced the SIOCGIFCONF loop with getifaddrs()=2E

Change-Id: I879cd0fe9b1fabb3=
50e1c4558863480064d45903
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2E=
org>
---
M src/openvpn/route=2Ec
1 file changed, 0 insertions(+), 6 deletio=
ns(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/23/2123/1

diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
inde=
x 53550c4=2E=2E27012f7 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn=
/route=2Ec
@@ -3322,12 +3322,9 @@
 #define ADVANCE(x, n) (x +=3D ROUNDUP((n=
)->sa_len))
 #endif
 
-#define max(a, b) ((a) > (b) ? (a) : (b))
-
 void
 g=
et_default_gateway(struct route_gateway_info *rgi, in_addr_t dest, openvpn_=
net_ctx_t *ctx)
 {
-    struct gc_arena gc =3D gc_new();
     struct rtmsg =
m_rtmsg;
     int sockfd =3D -1;
     int rtm_addrs;
@@ -3529,7 +3526,6 @@
=
     {
         close(sockfd);
     }
-    gc_free(&gc);
 }
 
 /* BSD imple=
mentation using routing socket (as does IPv4)
@@ -3698,8 +3694,6 @@
     }
=
 }
 
-#undef max
-
 #elif defined(TARGET_HAIKU)
 
 void

-- 
To view, visit=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2123?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I879cd0fe9b1fabb350e1c4558863480064d=
45903
Gerrit-Change-Number: 2123
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--N93HyY2JDqA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2123?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">route: remove unused max() and gc from BSD get_default_=
gateway()<br><br>Both lost their last users when 76d11614 (&quot;get_defaul=
t_gateway()<br>HWADDR overhaul&quot;) replaced the SIOCGIFCONF loop with ge=
tifaddrs()=2E<br><br>Change-Id: I879cd0fe9b1fabb350e1c4558863480064d45903<b=
r>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M =
src/openvpn/route=2Ec<br>1 file changed, 0 insertions(+), 6 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/23/2123/1</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/route=2Ec b/src/o=
penvpn/route=2Ec</span><br><span>index 53550c4=2E=2E27012f7 100644</span><b=
r><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=
=2Ec</span><br><span>@@ -3322,12 +3322,9 @@</span><br><span> #define ADVANC=
E(x, n) (x +=3D ROUNDUP((n)-&gt;sa_len))</span><br><span> #endif</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define max(a,=
 b) ((a) &gt; (b) ? (a) : (b))</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> void</span><br><span> get_default_gateway(struct=
 route_gateway_info *rgi, in_addr_t dest, openvpn_net_ctx_t *ctx)</span><br=
><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct g=
c_arena gc =3D gc_new();</span><br><span>     struct rtmsg m_rtmsg;</span><=
br><span>     int sockfd =3D -1;</span><br><span>     int rtm_addrs;</span>=
<br><span>@@ -3529,7 +3526,6 @@</span><br><span>     {</span><br><span>    =
     close(sockfd);</span><br><span>     }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span> }</span><br><sp=
an> </span><br><span> /* BSD implementation using routing socket (as does I=
Pv4)</span><br><span>@@ -3698,8 +3694,6 @@</span><br><span>     }</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#undef max</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> #elif defined(TARGET_HAIKU)</span><br><span> </span><br><span>=
 void</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2123?usp=3Demail">change 2123</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2123?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I879cd0fe9b1fabb350e1c45588=
63480064d45903 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 21=
23 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--N93HyY2JDqA=--


--===============7256523218176351056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7256523218176351056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7256523218176351056==--

