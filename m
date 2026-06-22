Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817A2CD98F2
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 10:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DZ2DTQXKj/vwV8xltYXhUe5XNaonhMVTGikaMb5dW+8=; b=gv3udF4QfPT+uftnWJcR4CXnJ+
	3LJ82+tHDnLXvRhsTuiU1AqpKXsD7EHjNPUEj/FLb2HJ3OpDb+JBeWFXoH2AESqr2sf2a1cPeSnKt
	uWpcPT2vAm+oTXkZuwOP8jphSzTYT1P2Q0uKAamPU3jlqdQ0CpOLwxtF7Ui6hfke1BsQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbc2j-000063-6l;
	Mon, 22 Jun 2026 10:38:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbc2h-00005v-Vz
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 10:38:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=25tMWP4BAAfK8Y+Rnb/tDyaf+ObSba+BU6GzgDACGOI=; b=HKYrJ5DclXdfk6KpLTYjeM9Yhi
 yh7LB7bMjU23NsPx5t/3y2zFufAupllLgdzNj0v+UYDcBttTotSV7vyUpNnt91jOPPJeCtdTaVwm7
 kWuOWrYfUTJmdKn9Glg8/4eQgRMFPfQ5pB31Oe8jenDLMSz4T92uBcVddXMsuo1mX++g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=25tMWP4BAAfK8Y+Rnb/tDyaf+ObSba+BU6GzgDACGOI=; b=K
 g7LCy+aUkTY4dNAL0RsdK9zdlipZ/kCHsD2o0BuYsfVwQ8ldDt9a6Tu75x8rABkGKQmAizuZYZs1X
 r+uahc+gcexxSkPrPAugGCJSNn7M6qajfrDgDvNJytbA2Xd54cqlCiIpEGQAsO5zoblVZLNEntTWp
 dD5MMEfFXiY1wzxA=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbc2f-0006Su-VS for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 10:38:15 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-490b64c8311so40443015e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 03:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782124683; x=1782729483; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=25tMWP4BAAfK8Y+Rnb/tDyaf+ObSba+BU6GzgDACGOI=;
 b=DlVAffwiR8HpzWxDNNFWGHvAOcOg1iJWgo8OOtK5GpMzf+l5G2MgSDe5MeRmN7VLHS
 57wtLfF/ETnQxv+KoaSOPj7CeJz0IwVTLiOaS2He7Y5mbqeThupk/02vY1uqxPdkudIV
 v1IjiypelARNE+SrvSW5aRZqHw0WggVhM49PdL3wb6Ec2vm/YWU465iAOLDEx1X3865f
 xfxuREdKBs2humEpxUvjTvFlfiQAkGeMeXOS1FPfqxioJXnSzFLf8FtAYt5UEKDRo6JF
 /3EumGVyQdbINt8PP7GnGmbdeqbpCD6rgelx5fauRugJl5mIQgi8EopAJX9nSgHth84k
 inuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782124683; x=1782729483;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=25tMWP4BAAfK8Y+Rnb/tDyaf+ObSba+BU6GzgDACGOI=;
 b=A1O4o50ec0ryoeAV2lcJGJTQdNUiuAUGXn2ZPlnJFFR8MZTMXqFs7zuhbIb5ko/W+z
 N+RYdLbJuEtFQeYWDxps9q9mza45CzQtDnqLB91eYV5T7uvKW3lL+2kiKYC0UAHzagFg
 DlO3OtB1kDCeiixX5b5zFc3KKREBXXGJKgR0D5EPSooU5cJAeENONVjZwFd2i3Mk5VYK
 E/O7PQE/SPZP3+MPYcM/o5LmiPhDwtVeAcxMLyDtvGzv4EDTx95FTaDDfbpbmyDpyjEz
 PbwGLbMlq9d+00gFcvH8s9//G1OKj5a6wLaoFBwxkZCgKSbBDvlljUxzwuwvFHuGdLcK
 ocgw==
X-Gm-Message-State: AOJu0YyfgKxspRfA4zfBpdmvgBZGqhb0LRDm4SvpLZVue0kNxRt+jRM6
 zTxkuFHSgdW97pGJ3Yfq3yjfnYkkRjKpNJq4mXsaeazqry8/4g8GiCcc1SUFscuL0GgdUUosvwq
 C4ySNQb4V/uMm4gH6X0jKTzL8w0Tn+EyCETNx15FD+Ufnhn3uUULU2yk+AoglJpVl+Bsg
X-Gm-Gg: AfdE7cm8ouCCdVdXIsGhcXaeZnxApJhiuaPvtI7uTJI2KBVX4DbWansFMc0aOUWvG6z
 /pEgp0WXk2AQuxTCtQvQI2DqrWvw7eTGYFgKvhzvwze4vMD5TFp9x+tLbbxLZCzfOiCRkWZZH++
 9GsNGKuxjPnKF0dpp4/c3eWkZEf4z9g3EmGMeFyStrVuRPfKN1NE2ETj6h6QZ7TXHDSkpDoiDw/
 Mr5flqVVEosmDG/g2VDGcNcIUhNh903d4c6limLQZlUCj8fSCM9Q4C8FJydJZJ/S5K9qUEYjXF+
 FGd7f3eIkbSodeBoyhcvVyprK9dAMmxFskw/5V3EN+97zYRdhafrCOFu2yOhi+qCh52IXePTPA7
 taqa8/wFwAPhK7dWz/naevjqNaiktfjmKxFCMZCjy1uqLMeh9a33HV3Zzc5FcJ6kI9A6lLQvXu1
 zVJIPcE55fBO9GJMeFeWpE/wwqQi9QomhHa2Hqpc0mmu2vEWN3eMbLNT8HlW4gZ4BUVCQvpq6Bi
 25yiR8cpVWGqKcKOqGilz1GxTxrGhPfexvElEDSE6Irvj9Qo/h6voCJBQB31t3+svifYzPZ6Dhs
 2/Q=
X-Received: by 2002:a05:600d:8499:10b0:490:acb8:1490 with SMTP id
 5b1f17b1804b1-49240dfdf6dmr169201505e9.4.1782124682851; 
 Mon, 22 Jun 2026 03:38:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49249207dabsm346514715e9.0.2026.06.22.03.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 03:38:02 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 10:38:00 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I49b37b5a90554fa2d4a83c8fc5608dad2a36b835
X-Gerrit-Change-Number: 1715
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1715?usp=email>
X-Gerrit-Commit: afeea8df799b1bb1c3fad0cb00fc336538f0217d
In-Reply-To: <gerrit.1782077103000.I49b37b5a90554fa2d4a83c8fc5608dad2a36b835@gerrit.openvpn.net>
References: <gerrit.1782077103000.I49b37b5a90554fa2d4a83c8fc5608dad2a36b835@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMDc3MTAzMDAwLkk0OWIzN2I1YTkwNTU0ZmEyZDRhODNjOGZjNTYwOGRhZDJhMzZiODM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <151b34194cf2b8900571eddc3bae147828746b80-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbc2f-0006Su-VS
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: fix
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8274778613184810734=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8274778613184810734==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="p45IatznmtA="; charset=UTF-8

--p45IatznmtA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, ordex, plaisthos=
=2E

Hello cron2, flichtenheld, plaisthos, 

I'd like you to reexamine a ch=
ange=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1715?us=
p=3Demail

to look at the new patch set (#3)=2E

The following approvals go=
t outdated and were removed:
Code-Review-1 by flichtenheld


Change subject=
: options: fix use-after-free of DNS options on client connect
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options: fix use-after-fr=
ee of DNS options on client connect

struct dns_options embeds its own gc_a=
rena=2E When inherit_context_child()
/inherit_context_top() copy struct opt=
ions by value, the child shares the
parent's DNS arena=2E options_detach() =
detached o->gc but not
o->dns_options=2Egc, so pre_connect_restore()'s gc_f=
ree() (and context
teardown) freed allocations the parent still referenced=
=2E

With one or more non-pushed --dhcp-option directives that yield a DNS
=
entry, a connecting client triggers this and the server crashes
(use-after-=
free in setenv_dns_options(), reported as a double free)=2E

Detach o->dns_=
options=2Egc as well, mirroring the existing o->gc handling=2E

Change-Id: =
I49b37b5a90554fa2d4a83c8fc5608dad2a36b835
GitHub: closes openvpn/OpenVPN#10=
60
Signed-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
---
M src/ope=
nvpn/options=2Ec
1 file changed, 11 insertions(+), 0 deletions(-)


  git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/15/1715/3

diff=
 --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 0c2866c=2E=
=2E75bd87c 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=
=2Ec
@@ -1531,7 +1531,18 @@
 void
 options_detach(struct options *o)
 {
+  =
  /* The options struct carries two gc_arena's (one generic and one specifi=
c
+     * to the DNS settings), which the by-value options
+     * copy in =
inherit_context_child()/inherit_context_top() shares with the
+     * sourc=
e=2E
+     *
+     * Detach both (i=2Ee=2E re-initialize them), otherwise c=
hild's call of
+     * gc_free() (or context teardown) would free allocatio=
ns the source
+     * context still references, leading to a use-after-free=
 (and subsequent
+     * double-free)=2E
+     */
     gc_detach(&o->gc);
+=
    gc_detach(&o->dns_options=2Egc);
     o->routes =3D NULL;
     o->clien=
t_nat =3D NULL;
     clone_push_list(o);

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1715?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: I49b37b5a90554fa2d4a83c8fc5608dad2a36b835
Gerrit-C=
hange-Number: 1715
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <antonio@mandelbi=
t=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: =
flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: flichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>=


--p45IatznmtA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, ordex, plaisthos=2E </p>
<p>orde=
x <strong>uploaded patch set #3</strong> to this change=2E</p><p><a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1715?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review-=
1 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">options: fix use-after-free of DNS optio=
ns on client connect<br><br>struct dns_options embeds its own gc_arena=2E W=
hen inherit_context_child()<br>/inherit_context_top() copy struct options b=
y value, the child shares the<br>parent&#39;s DNS arena=2E options_detach()=
 detached o-&gt;gc but not<br>o-&gt;dns_options=2Egc, so pre_connect_restor=
e()&#39;s gc_free() (and context<br>teardown) freed allocations the parent =
still referenced=2E<br><br>With one or more non-pushed --dhcp-option direct=
ives that yield a DNS<br>entry, a connecting client triggers this and the s=
erver crashes<br>(use-after-free in setenv_dns_options(), reported as a dou=
ble free)=2E<br><br>Detach o-&gt;dns_options=2Egc as well, mirroring the ex=
isting o-&gt;gc handling=2E<br><br>Change-Id: I49b37b5a90554fa2d4a83c8fc560=
8dad2a36b835<br>GitHub: closes openvpn/OpenVPN#1060<br>Signed-off-by: Anton=
io Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/option=
s=2Ec<br>1 file changed, 11 insertions(+), 0 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
15/1715/3</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/option=
s=2Ec</span><br><span>index 0c2866c=2E=2E75bd87c 100644</span><br><span>---=
 a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</s=
pan><br><span>@@ -1531,7 +1531,18 @@</span><br><span> void</span><br><span>=
 options_detach(struct options *o)</span><br><span> {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* The options struct carries two gc_=
arena&#39;s (one generic and one specific</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * to the DNS settings), which the by-value optio=
ns</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * copy in in=
herit_context_child()/inherit_context_top() shares with the</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * source=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * Detach both (i=2Ee=2E re-initialize them), o=
therwise child&#39;s call of</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * gc_free() (or context teardown) would free allocations the =
source</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * contex=
t still references, leading to a use-after-free (and subsequent</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * double-free)=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span>    =
 gc_detach(&amp;o-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    gc_detach(&amp;o-&gt;dns_options=2Egc);</span><br><span>     o-&=
gt;routes =3D NULL;</span><br><span>     o-&gt;client_nat =3D NULL;</span><=
br><span>     clone_push_list(o);</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1715?usp=3De=
mail">change 1715</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1715?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: I49b37b5a90554fa2d4a83c8fc5608dad2a36b835 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1715 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;=
gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>=


</body></html>
--p45IatznmtA=--


--===============8274778613184810734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8274778613184810734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8274778613184810734==--

