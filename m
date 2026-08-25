Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6864C5DF94
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lBfyqKNRPSxYjItK8DNN4x+TJEn5LleMaO4gRpcxas4=; b=DqKBhREO+u4WfxE89dl/ovYhaR
	n4Sr5ZpdC33IoAxS4XFgPWQlYPCzMnALgWIqsCHda9MEoHDPNTzt4OIJwaisSlJ83nW9dycfEmtx/
	7OgZ9Q/ZN3RHpAkN6oasdK5+k4/Jy8RDkFpsPz5HadfZgT5zzZaWstZ8sJFPzVkQFQSg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wylak-00027v-EH;
	Tue, 25 Aug 2026 07:29:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wylai-00027o-G9
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:29:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=VTn7tf807eTA+kUevAZfHlPeoNSe4UY3XyOFBrT5QRo=; b=e+FGFGLb4Go2iVALCsOOsTY69S
 pR23MelTl0P9HMPp2UUq5MIgHpbjyRNRzQNl9/ypIzkAnMXBzBnEndrteDh5MH1OgmGnT/hU4wqZk
 sMEE9hEJvXq60ZRzJzMjqrjRKiAVfE3K0WYIoIei9ft5tI7JsSu73GXHO3Pm311NYar4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VTn7tf807eTA+kUevAZfHlPeoNSe4UY3XyOFBrT5QRo=; b=T
 Oh4fHqwB3S3nevl1Db6FqS08Ad93+uqCNMmlhfHrH8aHWdhr3gvK1lyEoWmgyKo7a2Y11RqSI5CJI
 gf8Oy6ckghC378sRCGQCD8dplCMZr2icPB11DbrzoRCj18oBdiZnoBiu6VOhA5UQisnK+9UGpg7X+
 jEGbZs0qwiQIbM/s=;
Received: from mail-ej1-f44.google.com ([209.85.218.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wylah-0000FL-O8 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:29:05 +0000
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c214e625259so661268366b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 00:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787642937; x=1788247737; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VTn7tf807eTA+kUevAZfHlPeoNSe4UY3XyOFBrT5QRo=;
 b=YRzrC8nGtzPqrDCtENWzP6UfUIq5xE1IfI5l4l4FzTahj1r8nErvaed3sl0MykMYOX
 KBBum5TNW7E4HKm9gu8KeO3jmg06IgWsepJ6lnCsoz9oXazBnjW5mWCwcWZ1Ub1oNSN4
 F8H1hlDFBjjPtuzYA1gz8i8JKRyIl1R5QvE1hke8+LXiZENNeMBdmlZu1aTe9Dwxcuhg
 FJMP+n1BfLAPU3KNCjVi6lDZZkTX/OYR+SZxYpAmjdnUc/gHYHkmU3fhDJjHTtsWJ+LW
 Evn1ZEz17plM21FIu7F2OEWuOL8TxkJEcx5WnojRg/pXMJfuFw9HeLoRzFa0/pDDLVtx
 ctnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787642937; x=1788247737;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VTn7tf807eTA+kUevAZfHlPeoNSe4UY3XyOFBrT5QRo=;
 b=ahFvvOmG+XbwO1ju8YFx6uw8Z+h11nOvEvArl4HQU4MvkGJK2lxYq+LGSPMHK+BXXB
 gA9Yc0SFaIRImHhk6RNWza4dO56LyRRCQdegW0Nv6XKSZJ2aj3d4lmSTEPO41qLyk7XL
 zfrREND0qXC02hZmUvtnAllwhTDO9Bgyc/DJmd0zq4dhl2cmdbXY9YqQHgeEjqG9kerF
 j8oNK3B4FTqjqZWeTcFpoRbWk2bJNyYElENG3Pk+fmiVZB62P/NJik5MTXeI4xY0aaBg
 QFDwU36QdxPEwAu52S8ZcPMb18sfI5nqhwEfyr1Qq8k5AyuW5ujn2r+PDJHQbU9zAq0R
 OVFQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp2yfir6fYIGuv/R4YK4n7ccu7n4RDx0RiPgRoNZgUx7YaC75nxro5hYSkgc4s0DfBe0DoqA1RXs3sm12zh@lists.sourceforge.net
X-Gm-Message-State: AFuF++mGsRWLP7U4DCFwSwZ8ergGQJTBOo23WZsxE1hJU8pLOFhPiOJs
 UxsghDvyJHJgtzJBBo5abc4lB5PnNDHocaQ2F76w2Wva+Phyf1GNDcqF/oVku0fOb1MwedEeRB+
 T6MyWq9xAredZVJrzsvdB66DC7LHCpX2WJngsSB9Q3lgm/EarF+yz1cmoo+BpQUNl9teX
X-Gm-Gg: AR+sD12TTzVf8aFeYBIr6JxWeH0DYm5n2LF1KjZKJjtRyeIQXpl3uNypQPCby3OJjdr
 FVL63FAZkrsbQAe3GkbfgezsCcGEe3vDlXVBOySfTCKcnwPMyQ+aaNCajuqppsCbjrhVSVgq0ro
 zmqnyV0/fAOfHEph003cBaI0sImRcRTB+LZSu297yUnDrjdMjtzCBYzIEnq7YwFOLImlHncAI4w
 kqXyGp3M4jUcK0Yu8P3jomWvzX9OAdj5O2XT0ACoDlFn5/mvLFdCvUilXKzGeV4fs7F0JhIMEBK
 4ged/B//MZyYEVoCoRam9rEdBQWTHRSEoV/oEVqNjMRqX6xe5CnSAMZSaAMXQaxj4oXjhS629nM
 2ZouL0/UrZNWXGjOybSVRmWSbBJ4t6mwuzPg+gbGcyymxGuTq66EQ5BsEIYpIpEOYMZH/SLbb1z
 Bpvx/SE15/BFNgwgh+czoCeQSm2SSaR5h7QCZdSYVBEaAQiS5VDEXxKwd4XE+qU7WSX6eY2wHh6
 YxGMHKq3nNd7m+C3xX+pGB3xCEL4AwFM69we/VvLSbIhcattUVcOiLWaNjEb9Ja1BKbwSsxU0/Y
 4u2XWCD+TpOipDQ9FC78UGQYymL82cVoGOEwqLJIxmDOhNagp34=
X-Received: by 2002:a17:906:4fc6:b0:c20:21be:ea75 with SMTP id
 a640c23a62f3a-c24e589a45cmr464851566b.8.1787642936984; 
 Tue, 25 Aug 2026 00:28:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f809bsm1797096666b.41.2026.08.25.00.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 00:28:56 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 07:28:55 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Icfb109714b42cab0af34f21f8fc8972059091c8e
X-Gerrit-Change-Number: 1862
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1862?usp=email>
X-Gerrit-Commit: a0598f56bf21aa241d303a02d47912b71749d66b
In-Reply-To: <gerrit.1787570563000.Icfb109714b42cab0af34f21f8fc8972059091c8e@gerrit.openvpn.net>
References: <gerrit.1787570563000.Icfb109714b42cab0af34f21f8fc8972059091c8e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NTcwNTYzMDAwLkljZmIxMDk3MTRiNDJjYWIwYWYzNGYyMWY4ZmM4OTcyMDU5MDkxYzhlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <08ffd54291b9106766792dc96dc8810b1b6b5ced-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wylah-0000FL-O8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: interval: Remove
 unused usec_timer functions
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
Content-Type: multipart/mixed; boundary="===============5096832451035917528=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5096832451035917528==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6zrayf2xBgk="; charset=UTF-8

--6zrayf2xBgk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1862?usp=3Demail )

Change subject: interval: Remove unused usec_timer =
functions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

i=
nterval: Remove unused usec_timer functions

These have never been used in =
the git history=2E
Probably OpenVPN 1=2Ex remnants=2E

Identified by cppche=
ck=2E

Change-Id: Icfb109714b42cab0af34f21f8fc8972059091c8e
Signed-off-by: =
Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Gert Doering <gert@gr=
eenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
62
Message-Id: <20260824161640=2E1971-1-gert@greenie=2Emuc=2Ede>
URL: https=
://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg3864=
3=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/op=
envpn/interval=2Eh
1 file changed, 0 insertions(+), 43 deletions(-)




dif=
f --git a/src/openvpn/interval=2Eh b/src/openvpn/interval=2Eh
index f6d3503=
=2E=2E59051bd 100644
--- a/src/openvpn/interval=2Eh
+++ b/src/openvpn/inter=
val=2Eh
@@ -255,47 +255,4 @@
  */
 bool event_timeout_trigger(struct event_=
timeout *et, struct timeval *tv, int et_const_retry);
 
-/*
- * Measure tim=
e intervals in microseconds
- */
-
-#define USEC_TIMER_MAX 60 /* maximum in=
terval size in seconds */
-
-#define USEC_TIMER_MAX_USEC (USEC_TIMER_MAX * =
1000000)
-
-struct usec_timer
-{
-    struct timeval start;
-    struct tim=
eval end;
-};
-
-#ifdef HAVE_GETTIMEOFDAY
-
-static inline void
-usec_timer=
_start(struct usec_timer *obj)
-{
-    CLEAR(*obj);
-    openvpn_gettimeofd=
ay(&obj->start, NULL);
-}
-
-static inline void
-usec_timer_end(struct usec=
_timer *obj)
-{
-    openvpn_gettimeofday(&obj->end, NULL);
-}
-
-#endif /*=
 HAVE_GETTIMEOFDAY */
-
-static inline bool
-usec_timer_interval_defined(st=
ruct usec_timer *obj)
-{
-    return obj->start=2Etv_sec && obj->end=2Etv_s=
ec;
-}
-
-static inline int
-usec_timer_interval(struct usec_timer *obj)
-{=

-    return tv_subtract(&obj->end, &obj->start, USEC_TIMER_MAX);
-}
-
 #en=
dif /* INTERVAL_H */

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1862?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
cfb109714b42cab0af34f21f8fc8972059091c8e
Gerrit-Change-Number: 1862
Gerrit-=
PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Rev=
iewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>

--6zrayf2xBgk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1862?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">interval: Remove unused usec_timer functio=
ns<br><br>These have never been used in the git history=2E<br>Probably Open=
VPN 1=2Ex remnants=2E<br><br>Identified by cppcheck=2E<br><br>Change-Id: Ic=
fb109714b42cab0af34f21f8fc8972059091c8e<br>Signed-off-by: Frank Lichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
862<br>Message-Id: &lt;20260824161640=2E1971-1-gert@greenie=2Emuc=2Ede&gt;<=
br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg38643=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M src/openvpn/interval=2Eh<br>1 file changed, 0 insert=
ions(+), 43 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/interval=
=2Eh b/src/openvpn/interval=2Eh</span><br><span>index f6d3503=2E=2E59051bd =
100644</span><br><span>--- a/src/openvpn/interval=2Eh</span><br><span>+++ b=
/src/openvpn/interval=2Eh</span><br><span>@@ -255,47 +255,4 @@</span><br><s=
pan>  */</span><br><span> bool event_timeout_trigger(struct event_timeout *=
et, struct timeval *tv, int et_const_retry);</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * Measure time intervals in microseconds</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define USEC_TIMER_MAX 60 /* maximum interval size in seconds */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define USEC_TIMER_MAX_USEC (USEC_TIMER_MAX * 1000=
000)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-struct usec_timer</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    struct timeval start;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    struct timeval end;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_GETTIMEOF=
DAY</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-static inline void</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-usec_timer_start(struct usec_timer *obj)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    CLEAR(*obj);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    openvpn_gettimeofday(&amp;obj-&gt;start, NUL=
L);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-static inline void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-usec_timer_end(struct usec_timer *obj)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    openvpn_gettimeofday(&amp;obj-&gt;end, NULL);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif /* HAVE_GETTIMEOFDAY */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline=
 bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-usec_timer_inter=
val_defined(struct usec_timer *obj)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    re=
turn obj-&gt;start=2Etv_sec &amp;&amp; obj-&gt;end=2Etv_sec;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-st=
atic inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-usec_t=
imer_interval(struct usec_timer *obj)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
return tv_subtract(&amp;obj-&gt;end, &amp;obj-&gt;start, USEC_TIMER_MAX);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #endif /* INTERVAL_H */</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1862?usp=3Demail">change 1862</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1862?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: Icfb109714b42cab0af34f2=
1f8fc8972059091c8e </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1862 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@=
greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>

</body></html>
--6zrayf2xBgk=--


--===============5096832451035917528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5096832451035917528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5096832451035917528==--

