Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF09606A320
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LOvNy2Hr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Pbq6wVdf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MgKR9MCO;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NadhgukN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=YMUZiWg01ffv6Hoya6uj4v3HB51ZpY8O8Pc1tl3jDeQ=; b=LOvNy2HrdpeI+atMMR7HjmbfAm
	rEZzmXxaWfVlpB0k2xV2uhCSXJE6sLoEM6dbhQbebHuKgEUiUYuZDIDOhTPw3uQ845+rTbP+IMcvm
	/De+cGHXfn4/r5n58261uOsPFd/FUgmYPdizcGAeMvm57tWzSlBm9fY0m/sFM9CB6gt0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUNNi-000000003de-3vQi;
	Fri, 20 Nov 2026 12:06:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUNNi-000000003dY-0mJQ
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 12:06:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DawIdqdx73SRfGrqIcd4cg+V9nFlpSkHuq51uTzhDNU=; b=Pbq6wVdfn4klOEyDTMOhviVbxj
 zO/sLeo74CaY9ix4/i7A+AcBjLon8MHYBxOOUAQqlidFlBzAgM30hOxGhiWdLGDnCstfCBPSNonC5
 kpPu/RtqOjucsfqeh8QShy3tJplRG+UGfdtMf/dw+cAhhxrIOBMZNlxwdTHeT4chjvC4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DawIdqdx73SRfGrqIcd4cg+V9nFlpSkHuq51uTzhDNU=; b=MgKR9MCOImptHbSR3xjw/sA4up
 6Y47ogXDjJtXrR5h2FvS9awetdIkCXg+eNcj0JDoGI26421Xj42im2xiQB3GyWAJgzHsCVbadU5MQ
 eXy8mTzHit0M/NvqBIpCPv+suKnt3NWU0jnkIKq0PI4TrQtV98+nj6OTsqxtEevfsMQE=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUNNh-000000005pD-1YjI for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 12:06:18 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so8061025e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 04:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795176371; x=1795781171; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DawIdqdx73SRfGrqIcd4cg+V9nFlpSkHuq51uTzhDNU=;
 b=NadhgukNEOkQ9irgLtUjUZtL8wcQl47DuIgI52qJjd0nHBq+oqHpEC/O4LiSezBwgO
 eswChoC+6djfIqeG2D9me8j1XdwOR3v8A7i3i5dgZruVVxK+ZStqttTmmEO4v7IDZxMw
 HymWeLnV5qQE8DH6Felwi5nsW4whFFHbUc1dYKToA/mEMiiei2uFALp2/IWL4spcso3y
 KV8ipzBffgsXHJM0olQsY6cUhx3SQBWwKHcbSpTVTeGmuCTqzVWWPotPTMY0Msqk6/cE
 wNdzMXX7tZxnUhdxR5dwiL6+/bqX7dTcrHc7HCC11wNNNpLq/hEzWubApbzvv2OGNn+1
 9DFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795176371; x=1795781171;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DawIdqdx73SRfGrqIcd4cg+V9nFlpSkHuq51uTzhDNU=;
 b=wXL6LPJzH38N5gfzgZHBzgRoKjsWQuBpYy1lJ5JLz9JdwF7IOCFhyXMdPDn3KwIYl7
 FgIC7nUfFJMoDaCrCouJKpxHPJv/V7Vpz0qXMdEL32l7jBgCXz2pWWpG1sFy4gs9Ne9n
 sRh5Kga+rtGFxbSIn3HbTDEJOSPDGNp7XSRvpUSxuxnTFOK02pNmL+Yi5EwFRD5TwxcA
 9ErXwD1QxeOyahOVLtkeozy4RVD5E+Vr1iTwnBMAEbmxrzaINaof1iGkCYUKWhfwnoKt
 v6cFjU9a7BhpgjFEYs6OQknU7BLme8+g0GZrGm9cmOcVeW9yByzhOlCrII8BLfrNx5kk
 96zQ==
X-Gm-Message-State: APuU4Z/O+Eq/Beqzk1grB2/5faYXexPJUQ0l5NcEakEenkF6iFABE6ND
 2kKcRbIlYb15U66ufHty0SvGLqUryzF66TRlTP2LZAgiqcMm46dOAL9+dymuIlf9ZWtQcYiU1Er
 PRwBi/Tl7idY0MAUjy182MJ1bJoxdR1Svwxe4DTmiG2PNb01VGAfouLt7AEhjHCsrIJYZre0I3q
 E2D3C07Q==
X-Gm-Gg: AYBFou2giaTRdKJNk/u4kLMLUAISxWOA6mcJvNisa6ogjIZ4y77QSfl0rnlKk7+4/gR
 KIamWwQd8pKwS0hDQ9FawNaG4B9v8ZcTVi+roMEVrtxjPDQyins0v3NnupzduMeKqVtndFIQISt
 K6RB7iBBpCOoWo2fkFP2dh5YeUF6KBGHMxzawLGYwO26g/3ITwtOHbdWVofqVUHxNYMrQ5QJux/
 YqB4EIAqNHvdeAYIsdrs8mdwcBqAst4lF3HpLfy2KkvcNGhJ33mOPArHVw+SkEs4qG85+nk79PX
 qX16fsszO/zPcGt9z4QqCISDLchMW3iXYSZU6nYvBKy3NlpaW2NzjfnL6hXCX6a6kyglJld3xbv
 Y3K92x/t9QaEW2GOZaGAihj9F3HLG1jArNCpyg2Zigi3eI/yf7G1CczD9p9tJ1aiBvfPVSBt2eO
 VjGNkD0sF26YAuh4pd+qEsrkVHzsLG+Ta5fMUIiM+705Nuea4GNJfaAkaRMpljHwZw+AdCz06bS
 nYNaLXMTdutBkWuQ7BXdBrCuhw/gVw5CAWrz/Z7gXiPxgaafwrjKjxUWb1MapHXkM1AKHiCv6UH
 A8aMAjmZg9nAjgvQMTcPTTS966H1iPiLg/1k/nJ2baRXSRkudl7CJuKupo69ON76vjjUBnoS07L
 Hpsgw50tlY+bFIClZBCLtHcw0PKtc2cc83avprEZyDAe8t3ebMqLubaR6pq7JXEpxX8vrLMsYcc
 xdwFe548U4sEh9wU9Q
X-Received: by 2002:a05:600c:820e:b0:4b4:262b:88a2 with SMTP id
 5b1f17b1804b1-4bb887c9f5cmr70820735e9.1.1795176370581; 
 Fri, 20 Nov 2026 04:06:10 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884911e3sm94503045e9.6.2026.11.20.04.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 04:06:10 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 12:06:09 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ifc72b3677056dd089b8c6cfae4bd07911b6f8407
X-Gerrit-Change-Number: 2228
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2228?usp=email>
X-Gerrit-Commit: 21bfcbef5fec36bd8d84d368daff0c58664b5c6a
References: <gerrit.1795176368000.Ifc72b3677056dd089b8c6cfae4bd07911b6f8407@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTc2MzY4MDAwLklmYzcyYjM2NzcwNTZkZDA4OWI4YzZjZmFlNGJkMDc5MTFiNmY4NDA3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7ddf47ae3bc2c90a1a8a3d2b1ef53945a4eb0915-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUNNh-000000005pD-1YjI
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: options: check
 permission for --route-ipv6-gateway
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
Content-Type: multipart/mixed; boundary="===============7963281422290265187=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7963281422290265187==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/SP3xm6C4dQ="; charset=UTF-8

--/SP3xm6C4dQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2228?usp=3Demail

to review the following change=2E
=


Change subject: options: check permission for --route-ipv6-gateway
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options: check perm=
ission for --route-ipv6-gateway

Unlike --route-gateway, the handler never =
called VERIFY_PERMISSION(),
so the option was accepted in any context (<con=
nection>, ccd, inline)
and was missing from option_types_found=2E Require O=
PT_P_ROUTE_EXTRAS,
as --route-gateway does=2E

Change-Id: Ifc72b3677056dd08=
9b8c6cfae4bd07911b6f8407
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2E=
org>
---
M src/openvpn/options=2Ec
1 file changed, 1 insertion(+), 0 deleti=
ons(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/28/2228/1

diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec=

index e51ece7=2E=2E2068393 100644
--- a/src/openvpn/options=2Ec
+++ b/src/=
openvpn/options=2Ec
@@ -5350,6 +5350,7 @@
     }
     else if (streq(p[0], =
"route-ipv6-gateway") && p[1] && !p[2])
     {
+        VERIFY_PERMISSION(O=
PT_P_ROUTE_EXTRAS);
         if (ipv6_addr_safe(p[1]))
         {
         =
    options->route_ipv6_default_gateway =3D p[1];

-- 
To view, visit https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2228?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: Ifc72b3677056dd089b8c6cfae4bd07911b6f8407
=
Gerrit-Change-Number: 2228
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--/SP3xm6C4dQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2228?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">options: check permission for --route-ipv6-gateway<br><=
br>Unlike --route-gateway, the handler never called VERIFY_PERMISSION(),<br=
>so the option was accepted in any context (&lt;connection&gt;, ccd, inline=
)<br>and was missing from option_types_found=2E Require OPT_P_ROUTE_EXTRAS,=
<br>as --route-gateway does=2E<br><br>Change-Id: Ifc72b3677056dd089b8c6cfae=
4bd07911b6f8407<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg=
&gt;<br>---<br>M src/openvpn/options=2Ec<br>1 file changed, 1 insertion(+),=
 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/28/2228/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index e51ece7=2E=2E=
2068393 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><spa=
n>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -5350,6 +5350,7 @@</span=
><br><span>     }</span><br><span>     else if (streq(p[0], &quot;route-ipv=
6-gateway&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMIS=
SION(OPT_P_ROUTE_EXTRAS);</span><br><span>         if (ipv6_addr_safe(p[1])=
)</span><br><span>         {</span><br><span>             options-&gt;route=
_ipv6_default_gateway =3D p[1];</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2228?usp=3Demail">change 222=
8</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2228?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
Ifc72b3677056dd089b8c6cfae4bd07911b6f8407 </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 2228 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--/SP3xm6C4dQ=--


--===============7963281422290265187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7963281422290265187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7963281422290265187==--

