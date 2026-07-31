Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACE0C55173
	for <openvpn-devel@archiver.kernel.org>; Fri, 31 Jul 2026 20:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pB+CuWp2kfJU9XxvnCSTMuQNrV+QSxLd3hznIeDoxK8=; b=SbvqP8B5735QrsHZJu4DOnfgbX
	h8uH3wubBN6Ft8+CfuoMV8CvtBPsgqjxgNkHTIOjd0+ihKrC8HMcIybTafMUbNv5dGlYIxxxCkYXE
	GY3a41BAQlou+tYAjg8bMvFaiNljO/aX+u49CoqA+x4Hcwu1Bvl17HQjaVLsfwXViF14=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wptYC-0004ZH-6S;
	Fri, 31 Jul 2026 20:09:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wptYA-0004ZA-L3
 for openvpn-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 20:09:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=l5DKGAVE7MBw1VBR2xOJFqHg8bPjjwTHU2KENippV4U=; b=f6AbUES8TvHgqxVyrgFpRtoFTx
 qm5ZCCkQ/TuT+srMgLX6+WusEc2XCD2rMsS9U0icjCpTzVRQAly1W5YWnXGZ0gRKPyFKFwBtAz2cW
 QmjW2gvKVy1YR/Hbc87n4KqF2xLoZHdT5ZD7o169rjSq+D3QGqanM9qUKlBBYCSw6uiU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=l5DKGAVE7MBw1VBR2xOJFqHg8bPjjwTHU2KENippV4U=; b=D
 3Ts+XXy6E2XZse2cbtqfRoGhHFDVpyGlBPk5yOIfO/y1xvKR3K605Tx35/pbVG4nRjVdWYC3VTKDb
 3vsRmaM4rJN3HI03c5vC43JOIbWgZy4UlW88JdYR1u+DdHd75/Jgmxmx8DGCIAh4jJzl/8Cz6D7oW
 o5xfujkK6PWoeh80=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wptYD-0002hb-Bj for openvpn-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 20:09:47 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-47de008b020so1028869f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 31 Jul 2026 13:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785528579; x=1786133379; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=l5DKGAVE7MBw1VBR2xOJFqHg8bPjjwTHU2KENippV4U=;
 b=VUz/fGcjL7XyaiYaQrHmFeDOcCyX1/1gtx6bDjgL5GZtvGldID2TZcOZ3lb7ZeVLmV
 lV7z8SFM+sIqGyPpDdUijCBt21sDkPZr8Nj+ahx5DjjqjA16UCKGJbA14PyoPDFdNuWC
 HJRvaCUAXflv/7ZsAl4K1bVC+JfD129nXeEUupPP7rMJEH0QhK6TCOqyW4JuQL7A6+Ys
 Yt/F5srweg9jOhZFvqJdkzME/hSwAodeogHP8MSeoxOpT8T8p0+V5D+b+COe+iisa8GF
 WJnVkm0yBn653mMgwN8J6emJHzZf+P8+m82didtnXwy++IoOhsbop46ia7fX5g+mrhv5
 J7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785528579; x=1786133379;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=l5DKGAVE7MBw1VBR2xOJFqHg8bPjjwTHU2KENippV4U=;
 b=jI71caOzwAjGwChz+P664u4Mzvte0Z8J01ZOa6wn5ZHCqBj/634+jVrPEGIwX+uAc3
 UTGjQVU9sdmrCNIKtJhh+stQle5pMqPCpfMP1tbwu9urVN4BbNJSBLN5WIQ1mjcQ+SH5
 GJihEe+Y2mHjlz1Kz7p7XH9998+Q83a6LNqfFrKmK6y007RUSKNh223tjw/Sy9oY0X1A
 wJ/Iaj49ntyZ4iXOP7TMOVA3KDNaqIGR6OQDCmoMxpxFNItQURH8w9FVBal5cmH/0+X9
 pcpawhOIwYTAAoMb5Pel5Ty8sL8HhE4br8aT5X9FJdyeugOJfOFeiudBBWFUC+rkrjZx
 SCeQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJeFsglyG4OiZGnfFga7ksOTjK73Fzf/707p+FBOhoa+iSpjURJqzKFtaqZpLCsfUvnD2R0S2QdMLqjAsm@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyCMcvjghZFlKhYq3WGK4Md/EpDBpFlR49eCu1VzglUl2eMGQEt
 KfbYe611X4JjVEt34KpzfoMAW7rX/dBZfxftFRjpgSH8V1Fv6F0nODbmoKYLz2IURilwXtUVxmW
 0bwKv++R0RBKswnMGJ46H4jl1UZlaHBV6xqukkcWnrsBJt997ZWIgrjER6639RbHADV+S
X-Gm-Gg: AR+sD121UWdkik3zlhkqdn/BuviuI1sQDPbweTXltEVZEGCsqOocqD18SLgwyo8GkBh
 hrRontwcFnhWffa+7Ldc526I+5zVpAhy/cu/XkXeKXAfo3IiDqjaFlQIIQyZLRNEXVGbuyzMP5b
 AeImaq3+iclbxhcd5aO14n36v/0/IaZaDmBqOrVaDug+pDB4Aj67v7yCNwXxoljOl9X2PfHhfTd
 K40UG0L9Aj/KNYmNnpvbVPZaLVzwmNn1ph98o/zp/deIJmXKS7GFa3VAd0SkBEpl0PzZ1hnESOV
 lRW5xb6fAbcL6xX1KwKENYn2nYKDwZyh8D3yUjobTgpfyQvATdM99ySuKOdT1rFvMnd9rVxG7gh
 sTiZ9r0uazGtysUbx0SiKEkrKpOdZ/77mGdc8rRercUBaIcg4EJ2jnddPgStM0OB+HW3hb/YA7v
 4scjQCw0yHsIy/m3Wl+HLzvifuLmgWoWRGYnTEHd+6/BwUiha7f+TO5mVrJ3OZtGv71mc6Spb8E
 3OWAk8Ess/m73dBIZ78839QyHzGnfkyYNwPLC3ginUIY3TUq1s/94k/cBtfpZxJ1mNIMx+Xq1eJ
 QLQLXn1U4TbNQYM0e8gXEI5YGWOTWUY94q06oX1uH9iVPS7t8KU=
X-Received: by 2002:a05:6000:480c:b0:47d:f6a5:1fbb with SMTP id
 ffacd0b85a97d-47fd7270145mr2045307f8f.13.1785528579197; 
 Fri, 31 Jul 2026 13:09:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd458bf7csm8872624f8f.32.2026.07.31.13.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 13:09:38 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 31 Jul 2026 20:09:38 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3c7d1f9e5b2a4c6d8e1f3a5b7c9d2e4f6a8b1c3d
X-Gerrit-Change-Number: 1832
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1832?usp=email>
X-Gerrit-Commit: d1e67f419f1ea9121d44fa4b91c59e7209785e57
In-Reply-To: <gerrit.1785402220000.I3c7d1f9e5b2a4c6d8e1f3a5b7c9d2e4f6a8b1c3d@gerrit.openvpn.net>
References: <gerrit.1785402220000.I3c7d1f9e5b2a4c6d8e1f3a5b7c9d2e4f6a8b1c3d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1NDAyMjIwMDAwLkkzYzdkMWY5ZTViMmE0YzZkOGUxZjNhNWI3YzlkMmU0ZjZhOGIxYzNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8e1f4b21296e2804cb96d470ac48bc8fa7293ea6-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wptYD-0002hb-Bj
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0361642963176366815=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0361642963176366815==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8hheFE7pXZs="; charset=UTF-8

--8hheFE7pXZs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1832?usp=3Demail )

Change subject: ssl: Ignore hard reset packets with=
 a non-zero packet id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

ssl: Ignore hard reset packets with a non-zero packet id

A hard=
 reset is always the first packet of a session, so it always
carries reliab=
le packet id 0=2E tls_process_state() relies on that when it
treats a recei=
ved reset as the early negotiation packet only for packet
id 0, and the sta=
teless three-way handshake relies on it as well (see
the comment in session=
_skip_to_pre_start())=2E

A reset claiming a different id is therefore bogu=
s=2E

We had a bug that could cause hard reset replays with packet id 1 in
=
specific scenarios (P2P TCP)=2E In that case we accepted the packet id
at f=
ace value and then ignored the control packet that actually had
id 1 as an =
replay=2E This caused a difficult to diagnose dead connection
that was stuc=
k just before TLS negotiation=2E The check added handles
this specific scen=
ario well in that we just ignore the bogus reset
but do not abort the conne=
ction attempt=2E Starting fresh might retrigger
the bug=2E If there would b=
e a separate bug where the client only sends
hard resets with packet id 1 w=
e will still get logging on the server
side now=2E

Change-Id: I3c7d1f9e5b2=
a4c6d8e1f3a5b7c9d2e4f6a8b1c3d
Signed-off-by: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit UR=
L: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1832
Message-Id: <20260731114=
605=2E11596-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Eco=
m/openvpn-devel@lists=2Esourceforge=2Enet/msg38098=2Ehtml
Signed-off-by: Ge=
rt Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/ssl=2Ec
1 file chang=
ed, 15 insertions(+), 1 deletion(-)




diff --git a/src/openvpn/ssl=2Ec b/=
src/openvpn/ssl=2Ec
index 60df7ce=2E=2Eccd8264 100644
--- a/src/openvpn/ssl=
=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -3896,8 +3896,22 @@
         /* Extract t=
he packet ID from the packet */
         if (reliable_ack_read_packet_id(bu=
f, &id))
         {
+            /* A hard reset always is the first packet=
 of a session, so it
+             * always must use packet id 0=2E Ignore =
it if it claims another id=2E
+             * In a specific existing bug th=
ese packets were replays of an
+             * already handled reset, so ig=
noring it is better than aborting
+             * the connection attempt=2E=

+             */
+            if (is_hard_reset_method2(op) && id !=3D 0)
=
+            {
+                msg(D_TLS_ERRORS,
+                    "TLS=
 Error: received %s with packet id " packet_id_format
+                    =
" from %s -- 0 was expected, ignoring packet",
+                    packet_=
opcode_name(op), (packet_id_print_type)id,
+                    print_link_=
socket_actual(from, &gc));
+            }
             /* Avoid deadlock by=
 rejecting packet that would de-sequentialize receive buffer */
-          =
  if (reliable_wont_break_sequentiality(ks->rec_reliable, id))
+           =
 else if (reliable_wont_break_sequentiality(ks->rec_reliable, id))
        =
     {
                 if (reliable_not_replay(ks->rec_reliable, id))
    =
             {

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1832?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: mer=
ged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3c7d1f=
9e5b2a4c6d8e1f3a5b7c9d2e4f6a8b1c3d
Gerrit-Change-Number: 1832
Gerrit-PatchS=
et: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>

--8hheFE7pXZs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1832?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">ssl: Ignore hard reset packets with a non-=
zero packet id<br><br>A hard reset is always the first packet of a session,=
 so it always<br>carries reliable packet id 0=2E tls_process_state() relies=
 on that when it<br>treats a received reset as the early negotiation packet=
 only for packet<br>id 0, and the stateless three-way handshake relies on i=
t as well (see<br>the comment in session_skip_to_pre_start())=2E<br><br>A r=
eset claiming a different id is therefore bogus=2E<br><br>We had a bug that=
 could cause hard reset replays with packet id 1 in<br>specific scenarios (=
P2P TCP)=2E In that case we accepted the packet id<br>at face value and the=
n ignored the control packet that actually had<br>id 1 as an replay=2E This=
 caused a difficult to diagnose dead connection<br>that was stuck just befo=
re TLS negotiation=2E The check added handles<br>this specific scenario wel=
l in that we just ignore the bogus reset<br>but do not abort the connection=
 attempt=2E Starting fresh might retrigger<br>the bug=2E If there would be =
a separate bug where the client only sends<br>hard resets with packet id 1 =
we will still get logging on the server<br>side now=2E<br><br>Change-Id: I3=
c7d1f9e5b2a4c6d8e1f3a5b7c9d2e4f6a8b1c3d<br>Signed-off-by: Frank Lichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1832<br>Message-Id: &lt;20260731114605=2E11596-1-gert@greenie=2Emuc=2Ede&=
gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg38098=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>1 file changed, 15 inser=
tions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl=2Ec b=
/src/openvpn/ssl=2Ec</span><br><span>index 60df7ce=2E=2Eccd8264 100644</spa=
n><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=
=2Ec</span><br><span>@@ -3896,8 +3896,22 @@</span><br><span>         /* Ext=
ract the packet ID from the packet */</span><br><span>         if (reliable=
_ack_read_packet_id(buf, &amp;id))</span><br><span>         {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            /* A hard reset alway=
s is the first packet of a session, so it</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+             * always must use packet id 0=2E Ignore =
it if it claims another id=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+             * In a specific existing bug these packets were repl=
ays of an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
   * already handled reset, so ignoring it is better than aborting</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+             * the connectio=
n attempt=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
      */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 if (is_hard_reset_method2(op) &amp;&amp; id !=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                msg(D_TLS_ERRORS,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                    &quot;TLS Err=
or: received %s with packet id &quot; packet_id_format</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                    &quot; from %s -- 0 =
was expected, ignoring packet&quot;,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    packet_opcode_name(op), (packet_id_pri=
nt_type)id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            print_link_socket_actual(from, &amp;gc));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span>           =
  /* Avoid deadlock by rejecting packet that would de-sequentialize receive=
 buffer */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 if (reliable_wont_break_sequentiality(ks-&gt;rec_reliable, id))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            else if (reliable_=
wont_break_sequentiality(ks-&gt;rec_reliable, id))</span><br><span>        =
     {</span><br><span>                 if (reliable_not_replay(ks-&gt;rec_=
reliable, id))</span><br><span>                 {</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1832?usp=3Demail">change 1832</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1832?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: I3c7d1f9e5b2a4c6d8e1f3a5b7c9d2e4f6a8b1c3d </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1832 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> =
Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--8hheFE7pXZs=--


--===============0361642963176366815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0361642963176366815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0361642963176366815==--

