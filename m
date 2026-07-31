Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AACC5516F
	for <openvpn-devel@archiver.kernel.org>; Fri, 31 Jul 2026 20:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CtXvnpc7NNWwP50WfLZUMvfAl8nMFYHXlGD+kkwfk/Y=; b=Gr5iugKvEyglWvdJCmMpOdSx4y
	+lX0tJ9vKV6TxnovGw1sqbIWod58A/b8qSqGbtz8g0Vtve+Vy3BlxjG6M8o8D/CC2Co98UpqSzHiR
	t1AVy5t9ko2z3r8IEpdn0pLgwFJdU6Baf2UcnTwW1PjeLy5IYAV4JbHzUhgXm8h6Ezuo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wptYB-0006MG-Aw;
	Fri, 31 Jul 2026 20:09:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wptYA-0006M3-6U
 for openvpn-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 20:09:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=NjaQ+XBhKL0K3/0IucfJwegm0RDherf5uTBZ1kVjR2I=; b=LXl9BXQMuUT7nwQVHqEY7wvez3
 sto+KAkwSs/pHF/gcOCRCAuwS6PybOSXzWK3C+em5CQuPVo/6pwYtSry/i1mXQIJUZSUWdeXrrjGe
 mOdK8tfcALGstgt2ieev9i6vKHgq2mYLU7aCKGNm56P49SGDq0UAdzdhz2vmPs6zwd8M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NjaQ+XBhKL0K3/0IucfJwegm0RDherf5uTBZ1kVjR2I=; b=P
 VEU+K3sQBxDFa2wI8Xro/5GqQlDqZSUTSlXg6cPH+jqlPpTfv4EaBA/zb22Ag9VzgKyLoJVAufoIm
 aLdKb9M3qhXOhkmg7pzn3F0pQ0P8qcsw9zrf0w0/A4AaA9NXrAmb/QHjQm3YgoFwPyDnfVS0ywlWJ
 t8mp9y9EQ0/BCXTs=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wptY8-0006NA-W5 for openvpn-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 20:09:46 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4720f3bf164so1604980f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 31 Jul 2026 13:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785528578; x=1786133378; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NjaQ+XBhKL0K3/0IucfJwegm0RDherf5uTBZ1kVjR2I=;
 b=U8R2iSbwX6kqdVrp8QFXwKLzsF/r1r34BIp1xR4G5cBYMV+VDKrYaNWWCZwIETsGzS
 9veNc/ntVhfDX9KIh8qHZk2qroaVTbmeuH4IeQOYAz8qMeZ0KxZGYr4XFpTPRs5GacQ4
 QxJPq+k81TANkbNpEzEwdd8SDgPlsO9kHYj7J8fNbB+1QqMQCMfj/8MgrmzIcHiDhybw
 sn1xRIZ2R7JP/Zk0uxyPXS/s6bn2IPhCEWEoj/4kw0WOFrphJPMtpbpA2jLf/kToiWcc
 7iNuc6ql+AzKEy61xwW44P0iZyG+VK/Bq+7CUNoA7+7e2gvGkcLFqmHBsCcMEP8x8GI+
 fS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785528578; x=1786133378;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NjaQ+XBhKL0K3/0IucfJwegm0RDherf5uTBZ1kVjR2I=;
 b=Eq6jpEME6Sovb9OXmUMp6BPziSXcB/b2cmP+EgYIKzDHW2EP2E0xGgqFiCJfmpwFLJ
 r9VAfRu71Bi9qOUEkwYT1GF6jbe8aPNy23AhxraD0+IUHtmmRfdDQ19j/kD+8v2dXSv+
 h4ABmWHdkuKsDZ0SH3IovMzqrdhCi7AAP5qC50/Gr9YqhtYQ8U4JcdDVC2+FGXI0mjah
 geWTNAiTiRo6LgXsNHWdmGniepUUWHocHdJU1WHTPf66XoQ0quAVNoHWyrvZbmCr8cdc
 ml/hZsu9HS1h69otLZW4ybbyga1j/ISHXXRmokN8SaQitUfCqRZ3d/UzZ9FbW1U0lxjF
 W7IA==
X-Gm-Message-State: AOJu0Yw5vR5bZtwAXWXCnehyhIk2wTCetzlEtBYI2E/xIpoNTKPPwvgj
 mKQiIsaZkGofMZqCTHWKiU4H90YWgQ9X2iowSqzFacyd1QVwFTx7vKxAPELSegq78D5X0SnU8s9
 Qvn7vgmFJApASsF9ShP25CsFsaQTmpBKer/y0RnLGxsDyir9nKsee/pP3Ttjn0kTlvHGk
X-Gm-Gg: AR+sD12Jr4UgqyAqEMyFU4Tlwv9qfRN8e6IgOgHgM/1O/US0W6fJB5uperbzrssNxJP
 sEjl9xPfdHdk9ulfgYbxVWFeHCWb/EEFEur9dFawmx9TTr/NyTnd6+MAZ8z7C8kbmTOUlCkBFNL
 SOUsaYicFcEbRpfkIr2LRIpVOxxFX3xv2X8jilhGu2A4r14uLYHS4plG7ylmRjK5C5aQ16WQB4f
 Ohdwu3cZavrVR41GKKqiROgZlYM2HFSm+fDqXJPLxugdOxLL318PL7m850FIYaul5p6FVcYd/ug
 hvPYTOP8AiXblxqfpMJCeX17lpmL0zmAlboisTIgmbcjrUy/KrXgDiF4ZzwnZgMtN3xi/3b1D4D
 5eacAMx6S2OvXaJj5UKPqiUbIy6JVQObFOeUuW5M7b9Op71A81Ai6/rvDU2TdoIeGK1pb8FU6KS
 QSojqEiay2ILmQ+0rgYYMGFxM+OjZXPC2r/x7WdVJz4OCYikHAObaZ9pPAPnbHaMNEwFL6NVzsW
 ojfu/s0Bmu0c3EWjWNTb+I090gJzJ0N+xvgZ0KYzxEEtDOWJ7EWmm2lMNfdSwQovNutfvZ2LN09
 +q7PzxFxC+VOy4xu9FIPy+tazpcUg232d0ZjrCPlrPyar6m5Hj8=
X-Received: by 2002:a05:6000:4698:b0:47f:93e8:af81 with SMTP id
 ffacd0b85a97d-47fd7264de7mr1188266f8f.10.1785528578371; 
 Fri, 31 Jul 2026 13:09:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e2cf1sm8497854f8f.10.2026.07.31.13.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 13:09:37 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 31 Jul 2026 20:09:36 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3c7d1f9e5b2a4c6d8e1f3a5b7c9d2e4f6a8b1c3d
X-Gerrit-Change-Number: 1832
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1832?usp=email>
X-Gerrit-Commit: d1e67f419f1ea9121d44fa4b91c59e7209785e57
In-Reply-To: <gerrit.1785402220000.I3c7d1f9e5b2a4c6d8e1f3a5b7c9d2e4f6a8b1c3d@gerrit.openvpn.net>
References: <gerrit.1785402220000.I3c7d1f9e5b2a4c6d8e1f3a5b7c9d2e4f6a8b1c3d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1NDAyMjIwMDAwLkkzYzdkMWY5ZTViMmE0YzZkOGUxZjNhNWI3YzlkMmU0ZjZhOGIxYzNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8e1f4b21296e2804cb96d470ac48bc8fa7293ea6-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wptY8-0006NA-W5
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: Ignore hard
 reset packets with a non-zero packet id
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
Content-Type: multipart/mixed; boundary="===============5207707838792160257=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5207707838792160257==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ldvqsmaGdPA="; charset=UTF-8

--ldvqsmaGdPA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1832?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by plaisthos


Change subject: ssl: Ignore hard reset packets with a non-ze=
ro packet id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


ssl: Ignore hard reset packets with a non-zero packet id

A hard reset is=
 always the first packet of a session, so it always
carries reliable packet=
 id 0=2E tls_process_state() relies on that when it
treats a received reset=
 as the early negotiation packet only for packet
id 0, and the stateless th=
ree-way handshake relies on it as well (see
the comment in session_skip_to_=
pre_start())=2E

A reset claiming a different id is therefore bogus=2E

We =
had a bug that could cause hard reset replays with packet id 1 in
specific =
scenarios (P2P TCP)=2E In that case we accepted the packet id
at face value=
 and then ignored the control packet that actually had
id 1 as an replay=2E=
 This caused a difficult to diagnose dead connection
that was stuck just be=
fore TLS negotiation=2E The check added handles
this specific scenario well=
 in that we just ignore the bogus reset
but do not abort the connection att=
empt=2E Starting fresh might retrigger
the bug=2E If there would be a separ=
ate bug where the client only sends
hard resets with packet id 1 we will st=
ill get logging on the server
side now=2E

Change-Id: I3c7d1f9e5b2a4c6d8e1f=
3a5b7c9d2e4f6a8b1c3d
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1832
Message-Id: <20260731114605=2E115=
96-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn=
-devel@lists=2Esourceforge=2Enet/msg38098=2Ehtml
Signed-off-by: Gert Doerin=
g <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/ssl=2Ec
1 file changed, 15 in=
sertions(+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/32/1832/2

diff --git a/src/openvpn/ssl=2Ec b/src/open=
vpn/ssl=2Ec
index 60df7ce=2E=2Eccd8264 100644
--- a/src/openvpn/ssl=2Ec
+++=
 b/src/openvpn/ssl=2Ec
@@ -3896,8 +3896,22 @@
         /* Extract the packe=
t ID from the packet */
         if (reliable_ack_read_packet_id(buf, &id))=

         {
+            /* A hard reset always is the first packet of a se=
ssion, so it
+             * always must use packet id 0=2E Ignore it if it=
 claims another id=2E
+             * In a specific existing bug these pack=
ets were replays of an
+             * already handled reset, so ignoring i=
t is better than aborting
+             * the connection attempt=2E
+      =
       */
+            if (is_hard_reset_method2(op) && id !=3D 0)
+       =
     {
+                msg(D_TLS_ERRORS,
+                    "TLS Error: =
received %s with packet id " packet_id_format
+                    " from %=
s -- 0 was expected, ignoring packet",
+                    packet_opcode_n=
ame(op), (packet_id_print_type)id,
+                    print_link_socket_a=
ctual(from, &gc));
+            }
             /* Avoid deadlock by rejecti=
ng packet that would de-sequentialize receive buffer */
-            if (re=
liable_wont_break_sequentiality(ks->rec_reliable, id))
+            else if=
 (reliable_wont_break_sequentiality(ks->rec_reliable, id))
             {
 =
                if (reliable_not_replay(ks->rec_reliable, id))
            =
     {

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1832?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3c7d1f9e5=
b2a4c6d8e1f3a5b7c9d2e4f6a8b1c3d
Gerrit-Change-Number: 1832
Gerrit-PatchSet:=
 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>

--ldvqsmaGdPA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1832?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">ssl: Ignore hard reset=
 packets with a non-zero packet id<br><br>A hard reset is always the first =
packet of a session, so it always<br>carries reliable packet id 0=2E tls_pr=
ocess_state() relies on that when it<br>treats a received reset as the earl=
y negotiation packet only for packet<br>id 0, and the stateless three-way h=
andshake relies on it as well (see<br>the comment in session_skip_to_pre_st=
art())=2E<br><br>A reset claiming a different id is therefore bogus=2E<br><=
br>We had a bug that could cause hard reset replays with packet id 1 in<br>=
specific scenarios (P2P TCP)=2E In that case we accepted the packet id<br>a=
t face value and then ignored the control packet that actually had<br>id 1 =
as an replay=2E This caused a difficult to diagnose dead connection<br>that=
 was stuck just before TLS negotiation=2E The check added handles<br>this s=
pecific scenario well in that we just ignore the bogus reset<br>but do not =
abort the connection attempt=2E Starting fresh might retrigger<br>the bug=
=2E If there would be a separate bug where the client only sends<br>hard re=
sets with packet id 1 we will still get logging on the server<br>side now=
=2E<br><br>Change-Id: I3c7d1f9e5b2a4c6d8e1f3a5b7c9d2e4f6a8b1c3d<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Arne =
Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1832<br>Message-Id: &lt;20260731114605=2E11596-1-=
gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvp=
n-devel@lists=2Esourceforge=2Enet/msg38098=2Ehtml<br>Signed-off-by: Gert Do=
ering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>1 =
file changed, 15 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/32/1832/2</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><spa=
n>index 60df7ce=2E=2Eccd8264 100644</span><br><span>--- a/src/openvpn/ssl=
=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -3896,8 +=
3896,22 @@</span><br><span>         /* Extract the packet ID from the packe=
t */</span><br><span>         if (reliable_ack_read_packet_id(buf, &amp;id)=
)</span><br><span>         {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            /* A hard reset always is the first packet of a sessio=
n, so it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
  * always must use packet id 0=2E Ignore it if it claims another id=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+             * In a spe=
cific existing bug these packets were replays of an</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+             * already handled reset, so =
ignoring it is better than aborting</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+             * the connection attempt=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+             */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (is_hard_reset_method2(op)=
 &amp;&amp; id !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             msg(D_TLS_ERRORS,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                    &quot;TLS Error: received %s with packet id =
&quot; packet_id_format</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    &quot; from %s -- 0 was expected, ignoring packet&q=
uot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
      packet_opcode_name(op), (packet_id_print_type)id,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    print_link_socket_a=
ctual(from, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            }</span><br><span>             /* Avoid deadlock by rejectin=
g packet that would de-sequentialize receive buffer */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            if (reliable_wont_break_sequen=
tiality(ks-&gt;rec_reliable, id))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            else if (reliable_wont_break_sequentiality(ks-&gt=
;rec_reliable, id))</span><br><span>             {</span><br><span>        =
         if (reliable_not_replay(ks-&gt;rec_reliable, id))</span><br><span>=
                 {</span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1832?usp=3Demail">change 18=
32</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1832?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I3c7d1f9e5b2a4c6d8e1f3a5b7c9d2e4f6a8b1c3d </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1832 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>

</body></html>
--ldvqsmaGdPA=--


--===============5207707838792160257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5207707838792160257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5207707838792160257==--

