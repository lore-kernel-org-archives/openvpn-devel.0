Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39348C98324
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 14:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6NkG1CB0IvoPEHgmRPR1UVwXk1AtECQf67vNLsr+tuA=; b=H/fLse2KBNerLpic0W7y/3xpch
	Q7Rv6opXMoFPCuaqHLA6cEqKyGSOg6z7rLjIYNNDFedswwxitUExfOGIXTaj6A26tgy3ThHNTI7Ho
	lp3c8maiJ4AfkITGy4CALATNbyJcPebC5O15wStCy9/eyA6oUVOh/YiSWfZbkFpG9aRw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA73R-0004uC-RY;
	Fri, 25 Sep 2026 14:37:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA73Q-0004st-A4
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 14:37:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ZgyL3Jo80ywdMma58tHiJeAMJtyCPKSqdCCIQBJgJ9Q=; b=dgwe7FePfmoNjgXK5fPqdtMn5K
 mnhCmaH/MhQNEjSmHusp04oCaq/KNm/l1MH6N67v54U+U0M9eUGvMA1YhC0EYAgz3V5y55kRuROL1
 jxZpn8fFQfNpfdHeYlYNQlog2p75HemLnW3wjFhCzfrwBidLpKtNCVyJox88ZT490xT0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZgyL3Jo80ywdMma58tHiJeAMJtyCPKSqdCCIQBJgJ9Q=; b=c
 UmApKsnEzHp5nnDStIck4i1oTX6/Q3hkJsWYfQrIJL2f3Uvi9s4CJnI64ZiEwjUxKu850FcZAkJ3P
 oUgBnp10tDjXlJJsDm8/HpbS41/hjUNJ+3AqmBiF7qfwvguG448u+jhLSp/p+N69e30xmumMoGQu7
 j30fHLicBBQiJvYI=;
Received: from mail-wr2-f35.google.com ([74.125.225.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA73B-0007WE-MO for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 14:37:22 +0000
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-4887f6cf16bso479216f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 07:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790347035; x=1790951835; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZgyL3Jo80ywdMma58tHiJeAMJtyCPKSqdCCIQBJgJ9Q=;
 b=EP7o3I7dPeh7T4xbMGkMjA0QqGfZT0JLyFz/x0FCu94Bit0XI3zEAC2iQ4mvTGMh42
 g54qciAkKbvB2Tmqzs+cbHs27fRQi1C1foTrftLox4R/VXBINLBvs1F04eMypIq+FDEI
 9cC15LHT4RHR8L81BH6l2ncDpEvw3pyKFI64yMkZBnr2kkxOhaOVJc4DsjtYVS45BBh8
 1iTFZd/JH5UrjqcXM9P5lrUEzj8dACrVQijtcTi6nEkrsxDBX16IAR4bI0CVql09TKNs
 1QDcyR6nqZPpMC7tEDdo3/6gxYZkpngPqguiD8AJN5RoxdII3vs2qD7TGSHZUjGzl8ou
 v03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790347035; x=1790951835;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZgyL3Jo80ywdMma58tHiJeAMJtyCPKSqdCCIQBJgJ9Q=;
 b=AqOB1fm7zuVh6LsOoSDtywMnIQhwxAa01yzw1P1yJPrEuY0cLLcoou4xRurXJCO+53
 whlmcD3j7pPniXTBbZGKNUZtOlIoZAk80lJFQFFFdHoIsMkfekcLwdtCkECpJmatpal9
 WLstgf28IfpVgq8HoIbqfG8o0pPnRKMZCXoN3PAMrWSIG0Aqv0XmbEsJCo3R5+4SEsX1
 BQP2boytnKjoQj9802sqRm86+k49UCONY5uq2ivj6A6KE8eHzoTIN7RoK2Q3084awcK9
 cWuRAg1p/8Jv8r1/zcWElfV788+xGxsgWc5aKKdVD6cLt5VBItXA08qq1z/mKwMQyGXP
 CakA==
X-Gm-Message-State: AFuF++m/KkFb+B7DWwgwF/OO/lUjW8tmPtkeZ8pwS9XX4LuzslNeE0iS
 EGatXgVvmIEvN0PJbbRXmyH6qesmXMViRZCyoxtaO8YfMtslGhiJ/Zjy9uHsWA/nlBHt0zTp2Yn
 qR5N827N+NH14pMxV6cmUhTSEYYY54wZNf7AKA0A8QZJi1eY+Reou+xyfy2xvF32Su8hM
X-Gm-Gg: AYBFou3mkHbvU6fqU13x0aWu5J/EevFIDWqzD8CYd/VS+Z9hhaR1FEsPauzlbizaKYc
 s3mDZK7H6mrbskLc3VDU1c6k+olVpXeCy9wwGe3wlf02T8VQNnzKF4BYHkwxattlwiKHjvJ7nWo
 hEUxnUyHoKCE3q8z/O2wSrc9j9KPBAqJR9zV/znxyk5V516jS4oGiMFZnRbC/kvEL7qvGqxmK+r
 NF9aZssfOLSD7ulqumJJBakoL9xGqb6+vG9qvqXwKzRa7dmDj1kUnvnwxuo6OBwFkiG6ndQTCys
 UI1xxQMlGcmPeQETgUiPYpuYrYLHJJ45ReM5w6tBAoOcdoGCo/1EHp/nI47TquAEd9W///Ei+r6
 rI0h0hGHSfsi2ssK0uHg4jlfP496/bBIZo2DQdI50v/yHWG5SM+jcbpUHlndcHJ1NY80IOL/ztY
 fMdR79isUiSBN7MKL9qRcCpuDA8q0RY0o/jVYhQLbPaEdGD7baQkQUqWdryDixjb6RRx7KLiVtM
 9Sn4ID484GehpKbE90/7mUKARUqLwyrmTvk6Jt41iGQGimOV2OC+Xt+TJXVKNvP+GTtNAWKfxi4
 GF6aGMPpgUgJi8CdhxGqUrwXfsHVI8Qr6cIOLnQqCMqTTlZcqhKWcjzIrG1j
X-Received: by 2002:a05:6000:25e7:b0:487:35d:cb0f with SMTP id
 ffacd0b85a97d-4887da06e28mr4574055f8f.14.1790347035061; 
 Fri, 25 Sep 2026 07:37:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a64ed6esm8385704f8f.29.2026.09.25.07.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 07:37:14 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 14:37:13 +0000
To: razvanc <razvanc@mailbox.org>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Id999691f74d291f4b902b8ca224a12d9bc7e6046
X-Gerrit-Change-Number: 1951
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1951?usp=email>
X-Gerrit-Commit: 67e6faa4496ff6fedc9297faf78d8cd4646a0b4b
In-Reply-To: <gerrit.1790339862000.Id999691f74d291f4b902b8ca224a12d9bc7e6046@gerrit.openvpn.net>
References: <gerrit.1790339862000.Id999691f74d291f4b902b8ca224a12d9bc7e6046@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzM5ODYyMDAwLklkOTk5NjkxZjc0ZDI5MWY0YjkwMmI4Y2EyMjRhMTJkOWJjN2U2MDQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f9df46f17c5b46fe8ae554af30d6bbccb06be6a6-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA73B-0007WE-MO
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: multi: make
 multi_add_mbuf static
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5916555607829736503=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5916555607829736503==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4ekjSJ3Wqjk="; charset=UTF-8

--4ekjSJ3Wqjk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1951?usp=3Demail )

T=
he following approvals got outdated and were removed:
Code-Review+2 by razv=
anc


Change subject: multi: make multi_add_mbuf static
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi: make multi_add_mbuf stat=
ic

This function is used only in multi=2Ec and can therefore be
declared a=
s static=2E

Change-Id: Id999691f74d291f4b902b8ca224a12d9bc7e6046
Signed-of=
f-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
Acked-by: Razvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1951
Message-Id: <20260925130715=2E9850-1-gert@greenie=2Emuc=2Ede>
URL=
: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/=
msg39496=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M=
 src/openvpn/multi=2Ec
M src/openvpn/multi=2Eh
2 files changed, 1 insertion=
(+), 3 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/51/1951/2

diff --git a/src/openvpn/multi=2Ec b/src/openvpn/m=
ulti=2Ec
index 67204c3=2E=2Efd54946 100644
--- a/src/openvpn/multi=2Ec
+++ =
b/src/openvpn/multi=2Ec
@@ -2833,7 +2833,7 @@
  * Add a mbuf buffer to a pa=
rticular
  * instance=2E
  */
-void
+static void
 multi_add_mbuf(struct mul=
ti_context *m, struct multi_instance *mi, struct mbuf_buffer *mb)
 {
     i=
f (multi_output_queue_ready(m, mi))
diff --git a/src/openvpn/multi=2Eh b/sr=
c/openvpn/multi=2Eh
index 6cb86c7=2E=2Eac6cb78f 100644
--- a/src/openvpn/mu=
lti=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -354,8 +354,6 @@
 
 struct multi_ins=
tance *multi_get_queue(struct mbuf_set *ms);
 
-void multi_add_mbuf(struct =
multi_context *m, struct multi_instance *mi, struct mbuf_buffer *mb);
-
 vo=
id multi_ifconfig_pool_persist(struct multi_context *m, bool force);
 
 boo=
l multi_process_signal(struct multi_context *m);

-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1951?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: Id999691f74d291f4b902b8ca224a12d9bc7e6046
G=
errit-Change-Number: 1951
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@m=
andelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>

--4ekjSJ3Wqjk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by ordex=2E</p=
><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1951?usp=3Demail">=
View Change</a></p><p>The following approvals got outdated and were removed=
:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">multi: make multi_add_mbuf stat=
ic<br><br>This function is used only in multi=2Ec and can therefore be<br>d=
eclared as static=2E<br><br>Change-Id: Id999691f74d291f4b902b8ca224a12d9bc7=
e6046<br>Signed-off-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<b=
r>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1951<br>Message-Id: &lt;2026092513=
0715=2E9850-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archiv=
e=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39496=2Ehtml<br>Signed-o=
ff-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn=
/multi=2Ec<br>M src/openvpn/multi=2Eh<br>2 files changed, 1 insertion(+), 3=
 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/51/1951/2</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/m=
ulti=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 67204c3=2E=2Efd54946=
 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/s=
rc/openvpn/multi=2Ec</span><br><span>@@ -2833,7 +2833,7 @@</span><br><span>=
  * Add a mbuf buffer to a particular</span><br><span>  * instance=2E</span=
><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br=
><span> multi_add_mbuf(struct multi_context *m, struct multi_instance *mi, =
struct mbuf_buffer *mb)</span><br><span> {</span><br><span>     if (multi_o=
utput_queue_ready(m, mi))</span><br><span>diff --git a/src/openvpn/multi=2E=
h b/src/openvpn/multi=2Eh</span><br><span>index 6cb86c7=2E=2Eac6cb78f 10064=
4</span><br><span>--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/ope=
nvpn/multi=2Eh</span><br><span>@@ -354,8 +354,6 @@</span><br><span> </span>=
<br><span> struct multi_instance *multi_get_queue(struct mbuf_set *ms);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void mu=
lti_add_mbuf(struct multi_context *m, struct multi_instance *mi, struct mbu=
f_buffer *mb);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span> void multi_ifconfig_pool_persist(struct multi_context *m, bool f=
orce);</span><br><span> </span><br><span> bool multi_process_signal(struct =
multi_context *m);</span><br></pre><p>To view, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1951?usp=3Demail">change 1951</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1951?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id999691f74d29=
1f4b902b8ca224a12d9bc7e6046 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1951 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--4ekjSJ3Wqjk=--


--===============5916555607829736503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5916555607829736503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5916555607829736503==--

