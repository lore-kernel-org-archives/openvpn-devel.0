Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E4DCD98F0
	for <openvpn-devel@archiver.kernel.org>; Sun, 21 Jun 2026 21:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=G0oMofHRvFGG7QpO6YjCs4jyjI58rZ1yaV+i6ClMVWk=; b=gJq/qAh4xlCMEY
	Jvv7UyOLmb93Foo2eV7VJHBCublGGzZOq+4QLjpWxK9hJ4Tgk0mK95dhSL/HCbLmAG18XdqQkRfZH
	37xTzBI0j7KFFpbCtMueONEhgZxGfLFRmRDXMoZfHsrHa6IV5WZznPI+2oI+tURn3B+mAfoL8doHE
	ngQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbPfh-0006bz-7a;
	Sun, 21 Jun 2026 21:25:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbPfL-0006aT-O4
 for openvpn-devel@lists.sourceforge.net;
 Sun, 21 Jun 2026 21:25:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zvMu1XFrhEBuwnfkKHXu4MdcGdT9kZi73Yer/jdQ1As=; b=BCP0gmQbUGxhaZZj4hi4O2i8M3
 C0Y1ma0BOEtj4QXb02MK+NIyrBPIDqlJ8PoprGiDCYz0tyfvgbjJVK0g9u7/SFFgjevvhJLSOtMHe
 n49oXmPU8o3ntX7imuoFllbEKk/HcsI8kwpA14VniqTuEWiLLH5y2i6rylyQ7ASP74TA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zvMu1XFrhEBuwnfkKHXu4MdcGdT9kZi73Yer/jdQ1As=; b=R
 11MxVJWAfGXBZDDszW+mx8tJzCHcVTFbrMD7eCxeo863egWuw3gXsWUW2X06Jm0stsE2L0ZyP9coZ
 OC3l2BsU5hvWqcqIv8PPJ2xfa6HGmz2fewf4wIVVd2GR8RVZJG/U6dpt0HOBNi5DZIPcKAMiz4T3N
 FJrwOxnIXQIEDK5M=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbPfK-0003eq-V0 for openvpn-devel@lists.sourceforge.net;
 Sun, 21 Jun 2026 21:25:20 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49222b6e871so31397055e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 21 Jun 2026 14:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782077108; x=1782681908; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zvMu1XFrhEBuwnfkKHXu4MdcGdT9kZi73Yer/jdQ1As=;
 b=Q3GoXVavepL3T/fNFtbkVymfh5Z3yT9nxnAO67jU3cNHtMvSs4SEjPlYVXnm08qeHe
 BYNawY1Pf5c6Vrs+721uGeb6eOxr5oS0di4A/QadlyDwctkIeNZEVAY5nn0BYXYV0R54
 8dl54Dc+4NzRO+nskX39OHzOO07vWawEqkjOAnXc2WQ6NqkcH/jSS0TsnBSx7vIuKJ5F
 2/F0v2srdrJuSurn49IBWGHlm7GeWNipkScXa6zyyxyJjwc6dl3iqdR3s8wBuK6UzwLQ
 Em2jDv8arMDhxftUDEleFp0zG2fyK4zb/IDQ91Kfte5nxgO5sZwJLQMUPXXsLtDDe+UT
 sd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782077108; x=1782681908;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zvMu1XFrhEBuwnfkKHXu4MdcGdT9kZi73Yer/jdQ1As=;
 b=ZpY1evukHi2J084J9f8niyNXpgLbf3gShTOc2ydwsCqN1Nfsl0JJ1+xAOz9L0ZFMpv
 TU+TL2n6mKcT/sLrNAIQq/wvQV+I09+NhVTfctZygPPUPSleLS4i4lDi0sYutS7kJoRw
 MAsDaFoTcKdrzyCaHg5HNGnyaM3AehD8I2H9FOMHNkKHabrAVbbyX2d9d/3btjRAA+EQ
 EgGVgAx1Rr/xE7tLIf8tOouI5yjDNdclRhE4q5mpf/szynMCmg4Ie0Xr4j6Zw/2eKlhA
 rd93GW8mP+yeMU3YV3gTofCD6N1qbFSDAD5igXaaEKkB1A391Fo+vmNE6fvmg/8yoQtQ
 cw/g==
X-Gm-Message-State: AOJu0YwZ+CnYka/PlPaFQnhMr6Q7EFClGvArFZ4cfSBWMjHTyJPga05P
 scd19yITQko6tikrjYiROy6HzgvZ6gILl5rt/oDZoSu70KC0bFYHZjKCS4ow5WAD7jZgC6WzoZs
 dnpBz/UjGQ0gz0BpMk0QtAGYhcUeuE5ouQG19vAiFaaaItWptxEuWpWnFSFpB+n/rHkZIkoCx5G
 XdNOjQ5g==
X-Gm-Gg: AfdE7cklvbchtVNxt4afVBfaJYjtveNd8KNYGWikRitD61tBHyYKGnZFVvWJQnwhy5E
 nEaQ8Fh4MzqQQ9LDLSg8MZq5KBwiIRL5zWd7t5rQj5hihKa2kGOl9mbnFMNsFRd5QbZ1+Ctqj8Z
 8SlOa/8PzJIDtZb4eOVgM7XVwBryzRvlH4ILFVM9CXw074KgMRrkEnq/oXFx1Mc2BjD6sdKyoBO
 Z8QiZOqhyua564vlUri4kIXCYJbin1pnYB97N11wgA5G4XK2JaPySgRKv+B2P7ZfkU13LfyQmjA
 NZhfmY1qKehGcoH49o8/AWHvrsSzZHFPZXlHTzILz+QEoh5XdS9P4A06MmrJ+Y8+TCvoFoPJCfi
 +Z88FyKm8sPXbI1DblPCCLP3TAN/KLAnXnjszZBV2GJ0fTE8oRzHTSiP2Ttv9Qgc0h1va0etYtf
 XuApO4h6PJdOUT+MWSgqKxN/oO8X2dYDUlv5jo4cCjl9xu8hnOuFDHeN+Bz0VwvijH21v3Pq0FL
 67r2FmTaBKUdJlT3T94LI63thailk+7yaS3mckQsjDABkf8294+3dz3mk0PFq7TGoND3ogzI++V
 rmcspeqTyJINIQ==
X-Received: by 2002:a05:600c:3b01:b0:492:4911:8a with SMTP id
 5b1f17b1804b1-49249110250mr100932305e9.12.1782077107788; 
 Sun, 21 Jun 2026 14:25:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923ff821aasm259422955e9.12.2026.06.21.14.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 14:25:07 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 21 Jun 2026 21:25:07 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I49b37b5a90554fa2d4a83c8fc5608dad2a36b835
X-Gerrit-Change-Number: 1715
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1715?usp=email>
X-Gerrit-Commit: a7817549891e7005fc0ca408396cfef95a1d30dd
References: <gerrit.1782077103000.I49b37b5a90554fa2d4a83c8fc5608dad2a36b835@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMDc3MTAzMDAwLkk0OWIzN2I1YTkwNTU0ZmEyZDRhODNjOGZjNTYwOGRhZDJhMzZiODM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1c4eb98f263546e1e27492cbb052855dc37a6612-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbPfK-0003eq-V0
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: options: fix
 use-after-free of DNS options on client connect
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8430035959466309398=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8430035959466309398==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QpsjHBhT/V4="; charset=UTF-8

--QpsjHBhT/V4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1715?usp=3Demail

to review the following change=2E


Chang=
e subject: options: fix use-after-free of DNS options on client connect
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options: fix use=
-after-free of DNS options on client connect

struct dns_options embeds its=
 own gc_arena=2E When inherit_context_child()
/inherit_context_top() copy s=
truct options by value, the child shares the
parent's DNS arena=2E options_=
detach() detached o->gc but not
o->dns_options=2Egc, so pre_connect_restore=
()'s gc_free() (and context
teardown) freed allocations the parent still re=
ferenced=2E

With one or more non-pushed --dhcp-option directives that yiel=
d a DNS
entry, a connecting client triggers this and the server crashes
(us=
e-after-free in setenv_dns_options(), reported as a double free)=2E

Detach=
 o->dns_options=2Egc as well, mirroring the existing o->gc handling=2E

Cha=
nge-Id: I49b37b5a90554fa2d4a83c8fc5608dad2a36b835
Signed-off-by: Antonio Qu=
artulli <antonio@mandelbit=2Ecom>
---
M src/openvpn/options=2Ec
1 file chan=
ged, 6 insertions(+), 0 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/15/1715/1

diff --git a/src/openvpn/optio=
ns=2Ec b/src/openvpn/options=2Ec
index 0c2866c=2E=2Ec1e417cc 100644
--- a/s=
rc/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -1532,6 +1532,12 @@=

 options_detach(struct options *o)
 {
     gc_detach(&o->gc);
+    /* The =
DNS options carry their own gc_arena, which the by-value options copy
+    =
 * in inherit_context_child()/inherit_context_top() shares with the source=
=2E
+     * Detach it too, otherwise pre_connect_restore()'s gc_free() (or =
context
+     * teardown) would free allocations the source context still r=
eferences,
+     * leading to a use-after-free/double-free=2E */
+    gc_de=
tach(&o->dns_options=2Egc);
     o->routes =3D NULL;
     o->client_nat =3D=
 NULL;
     clone_push_list(o);

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1715?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: I49b37b5a90554fa2d4a83c8fc5608dad2a36b835
Gerrit-Change-Number=
: 1715
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Ger=
rit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>

--QpsjHBhT/V4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ordex would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1715?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">op=
tions: fix use-after-free of DNS options on client connect<br><br>struct dn=
s_options embeds its own gc_arena=2E When inherit_context_child()<br>/inher=
it_context_top() copy struct options by value, the child shares the<br>pare=
nt&#39;s DNS arena=2E options_detach() detached o-&gt;gc but not<br>o-&gt;d=
ns_options=2Egc, so pre_connect_restore()&#39;s gc_free() (and context<br>t=
eardown) freed allocations the parent still referenced=2E<br><br>With one o=
r more non-pushed --dhcp-option directives that yield a DNS<br>entry, a con=
necting client triggers this and the server crashes<br>(use-after-free in s=
etenv_dns_options(), reported as a double free)=2E<br><br>Detach o-&gt;dns_=
options=2Egc as well, mirroring the existing o-&gt;gc handling=2E<br><br>Ch=
ange-Id: I49b37b5a90554fa2d4a83c8fc5608dad2a36b835<br>Signed-off-by: Antoni=
o Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/options=
=2Ec<br>1 file changed, 6 insertions(+), 0 deletions(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/15=
/1715/1</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=
=2Ec</span><br><span>index 0c2866c=2E=2Ec1e417cc 100644</span><br><span>---=
 a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</s=
pan><br><span>@@ -1532,6 +1532,12 @@</span><br><span> options_detach(struct=
 options *o)</span><br><span> {</span><br><span>     gc_detach(&amp;o-&gt;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The DNS o=
ptions carry their own gc_arena, which the by-value options copy</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * in inherit_context_chil=
d()/inherit_context_top() shares with the source=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * Detach it too, otherwise pre_conne=
ct_restore()&#39;s gc_free() (or context</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * teardown) would free allocations the source con=
text still references,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * leading to a use-after-free/double-free=2E */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    gc_detach(&amp;o-&gt;dns_options=2E=
gc);</span><br><span>     o-&gt;routes =3D NULL;</span><br><span>     o-&gt=
;client_nat =3D NULL;</span><br><span>     clone_push_list(o);</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1715?usp=3Demail">change 1715</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1715?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I49b37b5a90554fa2d4a83c8fc56=
08dad2a36b835 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 171=
5 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>

</body></html>
--QpsjHBhT/V4=--


--===============8430035959466309398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8430035959466309398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8430035959466309398==--

