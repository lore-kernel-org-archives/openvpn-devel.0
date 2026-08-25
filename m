Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAB0C61DB6
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WS4Lo9TvCoTaBtbHPAgxtrL+Zok5MprsR/L/BXyEOFk=; b=T5+gVlWAr0zwXdeNMghaiVeni2
	KcPWHJcaLustzdorX7aq05SjEO2UKRUUEqX6mfuoi7lifI1vy1AD8zBe1PgN6Ny28/Whn+DT+CiVW
	N3V/lvmVTdZ7BRKozOzISyCQqRMaMctkSnx9IPBkakwCJblk8OJESGfq1uUIZ+VaLr1g=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wylan-0006fv-0W;
	Tue, 25 Aug 2026 07:29:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wylal-0006fk-G9
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:29:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=/0WDVJinSHz23E5lOuR2DP3ipwADVdlZ16zQn6UIgMo=; b=SCyj/BDqbkik7hTyPKbGGrawDS
 PgzqcgQCdX4hsAxU+gx0p507gJrp7TuyOPhV5U6FOP5PJMHPA3JJ9TRP3ILeOLs6SEGwofx2afIU6
 M0UPetB/bmX061KB5tAW0+eaz72ZcCm9uhoc+wT7s3J9gPjxaFiz1JZLoK6zt/ixHr74=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/0WDVJinSHz23E5lOuR2DP3ipwADVdlZ16zQn6UIgMo=; b=K
 iffuMnRVBUkJSieChqXBPIwO2kx6OxDcQMNc8hk/jQA37fMASC8UB/oWRg9azVDauHiHK+yv+bOEV
 d/yc0aCALugTTcJO4F5V+YYRzx1kAGy6hh+0Yqmc3YkOAIY6GVSYA/YjvI1f/VRkZV+h1wYgBcSQM
 MAEialZlejYVeVx4=;
Received: from mail-ej1-f53.google.com ([209.85.218.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wylag-00074r-7w for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:29:04 +0000
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c1f758014b8so481628366b.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 00:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787642936; x=1788247736; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/0WDVJinSHz23E5lOuR2DP3ipwADVdlZ16zQn6UIgMo=;
 b=LL3m9tgEGqrIkgiBVvaiENK/NghRKI2qrYrDtxdwyl4o/QmKZIr8HIzk+/wn1AQMuS
 6fiAaAuZCJf5RIVNGjtpl6OYxC67jy9MSdbi8mhTpjJxPfWja9DgcHce0hEZue1eqHgA
 WOjW5mtMNHk0tgYr/t1rb1+/KRyxvbtLSkbaQnY+Ray3vxm4RVFOuYd0sP6ZF99D978y
 Zqn2y1Jj7IepeVCSxuiIege0pEYhvt75PSLg5CuKXk2GYnrL9Q0pwpajxNK4Lb1ss2GZ
 /pfVFYre40FfNlizbEM5JcIKz5zML+p6BRal+hXMbviSz60utdU5xYA5siI1zMGhDkyr
 nZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787642936; x=1788247736;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/0WDVJinSHz23E5lOuR2DP3ipwADVdlZ16zQn6UIgMo=;
 b=W4OshpTWvYD9TlCgDJCMDpNDIGgSji6VQZ6Uy3OQjhEDIme5u9AwyYA4dr59UTlsK6
 w5F2gTiA6WOoRm479rllrfGgTL3xO6tnoviIeF8AnrwwsGoSwD7M8G/h9RZ72EEFLHrt
 No9VPPHofiCbAav1kAONuGr705PQQFa1NZGGa4tkCzya+sslhas2xtqXxVAkrwvfiyi+
 ZvIRIaNemTPlu/BloY0HJlFPXCxaw4NzJMF+wsHDUq/wyEFFxgQP+esJhFayJDaC/rWG
 2a7V+gMi0DvRzg49IoZBHN4a/n+gjMZgNqRN9iovH2yfuazs55UaXqbGcMrcL2BmNl0V
 gJKA==
X-Gm-Message-State: AFuF++l+d7a9IbqlyK4KL9YYqCsoTKpF+z1xtndXsiOtesnEHuQGMCfC
 dogMcBc3ZYEZEfJXUdqkJtIobyOmsDsudSYrPbHbQ4LqiYnnFOtTQ/1EPb4v4FhNgj1cOVw6t2F
 hIO92g/T9HUxZyw4zMMDkEyVGE8GMRzfe+1coTB3OT7nUx75PYKla5MwzxsOKWxwXivi1
X-Gm-Gg: AR+sD10Fw0nM8LCyVZQzPpGxI8tOEWpc09R1bvdBTUELYFEZEK4Q6QvQur5MwoRMB9h
 0UdzbTdX3PxtbtyKDLY2izT2kIThlDAfUUQ+cp6uQyl0SrD3H1UtANkKaD9yTxbVCCTEa4PwZ29
 aTNFBouo0eKwXIXNMxCdMT/2Lm3h+Fsxf/LzxUnxCpk+hyoiA5b6lNxO6NMxtW0/OyrxD1VJcnK
 7yAexfMx2/1QEpwR3ZqKpoHPbzc2xcRd2K3DMQ3m0drF5+kSMd4nOJe6wPqTEY+AVoNu9qdhuW9
 L4w6x1jat0F2ecR4woZ/l2yBqApPvPFYGfYanOS6C0AMeZE025S2l6r7z2Ga7FEMj+ft0IsoDFF
 QBJqqLi9Ugxz1h8oT5XDxywbM4O07qQo6STTLV4sa+FiXQOT8t3IUg+w0hmID4LDi/x9mEsGVHF
 VaDHKylLG2Q1hEH2YRxj35QnzfKUNNbcPDjNiaFGgBzUfPt+0x3jDlsv4u269sORdHGZIOJ37S0
 otdA/gWsZi0qrwHO/uGSN7oBDlKsr3D9MI4IlxiTLu65OxG05hP7akcocNQlZq+TYUJHJ3NMNqi
 c+y835yEhY5HcEjZDrjPWJxNJ0fvVVx361BFyY7ubS+b90bHBJw=
X-Received: by 2002:a17:907:e00c:20b0:c20:23f8:99a5 with SMTP id
 a640c23a62f3a-c246a6a402cmr2536984066b.15.1787642935443; 
 Tue, 25 Aug 2026 00:28:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496295627sm1573637166b.15.2026.08.25.00.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 00:28:54 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 07:28:52 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Icfb109714b42cab0af34f21f8fc8972059091c8e
X-Gerrit-Change-Number: 1862
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1862?usp=email>
X-Gerrit-Commit: a0598f56bf21aa241d303a02d47912b71749d66b
In-Reply-To: <gerrit.1787570563000.Icfb109714b42cab0af34f21f8fc8972059091c8e@gerrit.openvpn.net>
References: <gerrit.1787570563000.Icfb109714b42cab0af34f21f8fc8972059091c8e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NTcwNTYzMDAwLkljZmIxMDk3MTRiNDJjYWIwYWYzNGYyMWY4ZmM4OTcyMDU5MDkxYzhlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <08ffd54291b9106766792dc96dc8810b1b6b5ced-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wylag-00074r-7w
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7285649521546829080=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7285649521546829080==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WxTntDBgu38="; charset=UTF-8

--WxTntDBgu38=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1862?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by cron2


Change subject: interval: Remove unused usec_timer functions
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

interval: Remove=
 unused usec_timer functions

These have never been used in the git history=
=2E
Probably OpenVPN 1=2Ex remnants=2E

Identified by cppcheck=2E

Change-I=
d: Icfb109714b42cab0af34f21f8fc8972059091c8e
Signed-off-by: Frank Lichtenhe=
ld <frank@lichtenheld=2Ecom>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ed=
e>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1862
Message-Id: =
<20260824161640=2E1971-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-a=
rchive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38643=2Ehtml
Signed=
-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/interval=
=2Eh
1 file changed, 0 insertions(+), 43 deletions(-)


  git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/62/1862/2

diff --git a/src=
/openvpn/interval=2Eh b/src/openvpn/interval=2Eh
index f6d3503=2E=2E59051bd=
 100644
--- a/src/openvpn/interval=2Eh
+++ b/src/openvpn/interval=2Eh
@@ -2=
55,47 +255,4 @@
  */
 bool event_timeout_trigger(struct event_timeout *et, =
struct timeval *tv, int et_const_retry);
 
-/*
- * Measure time intervals i=
n microseconds
- */
-
-#define USEC_TIMER_MAX 60 /* maximum interval size i=
n seconds */
-
-#define USEC_TIMER_MAX_USEC (USEC_TIMER_MAX * 1000000)
-
-s=
truct usec_timer
-{
-    struct timeval start;
-    struct timeval end;
-};=

-
-#ifdef HAVE_GETTIMEOFDAY
-
-static inline void
-usec_timer_start(struct=
 usec_timer *obj)
-{
-    CLEAR(*obj);
-    openvpn_gettimeofday(&obj->star=
t, NULL);
-}
-
-static inline void
-usec_timer_end(struct usec_timer *obj)
=
-{
-    openvpn_gettimeofday(&obj->end, NULL);
-}
-
-#endif /* HAVE_GETTIME=
OFDAY */
-
-static inline bool
-usec_timer_interval_defined(struct usec_tim=
er *obj)
-{
-    return obj->start=2Etv_sec && obj->end=2Etv_sec;
-}
-
-sta=
tic inline int
-usec_timer_interval(struct usec_timer *obj)
-{
-    return =
tv_subtract(&obj->end, &obj->start, USEC_TIMER_MAX);
-}
-
 #endif /* INTERV=
AL_H */

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1862?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchse=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icfb10971=
4b42cab0af34f21f8fc8972059091c8e
Gerrit-Change-Number: 1862
Gerrit-PatchSet=
: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: c=
ron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>

--WxTntDBgu38=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1862?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">interval: Remove unused us=
ec_timer functions<br><br>These have never been used in the git history=2E<=
br>Probably OpenVPN 1=2Ex remnants=2E<br><br>Identified by cppcheck=2E<br><=
br>Change-Id: Icfb109714b42cab0af34f21f8fc8972059091c8e<br>Signed-off-by: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Gert Doering =
&lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1862<br>Message-Id: &lt;20260824161640=2E1971-1-gert@greenie=
=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg38643=2Ehtml<br>Signed-off-by: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/interval=2Eh<br>1 file ch=
anged, 0 insertions(+), 43 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/62/1862/2</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/interval=2Eh b/src/openvpn/interval=2Eh</span><br>=
<span>index f6d3503=2E=2E59051bd 100644</span><br><span>--- a/src/openvpn/i=
nterval=2Eh</span><br><span>+++ b/src/openvpn/interval=2Eh</span><br><span>=
@@ -255,47 +255,4 @@</span><br><span>  */</span><br><span> bool event_timeo=
ut_trigger(struct event_timeout *et, struct timeval *tv, int et_const_retry=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/=
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Measure time inte=
rvals in microseconds</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#define USEC_TIMER_MAX 60 /* maximum in=
terval size in seconds */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define USEC_TIME=
R_MAX_USEC (USEC_TIMER_MAX * 1000000)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-struc=
t usec_timer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    struct timeval start;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct timeval end;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#ifdef HAVE_GETTIMEOFDAY</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-usec_time=
r_start(struct usec_timer *obj)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(=
*obj);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_get=
timeofday(&amp;obj-&gt;start, NULL);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline void</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-usec_timer_end(struct usec_ti=
mer *obj)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_gettimeofday(&amp;ob=
j-&gt;end, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif /* HAVE_GETTIMEOFDAY */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-static inline bool</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-usec_timer_interval_defined(struct usec_timer *obj)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    return obj-&gt;start=2Etv_sec &amp;&amp; obj=
-&gt;end=2Etv_sec;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-usec_timer_interval(struct usec_timer *obj)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return tv_subtract(&amp;obj-&gt;end, &a=
mp;obj-&gt;start, USEC_TIMER_MAX);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span> #endif /* INTERVAL_H */</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1862?usp=3D=
email">change 1862</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1862?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: Icfb109714b42cab0af34f21f8fc8972059091c8e </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 1862 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner=
: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--WxTntDBgu38=--


--===============7285649521546829080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7285649521546829080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7285649521546829080==--

