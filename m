Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A922C88E56
	for <openvpn-devel@archiver.kernel.org>; Sun, 13 Sep 2026 09:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u+HE9uvAXy32z37DMmSkHOxMSAKuT/qz/6JC6f0iMFo=; b=JIQS+VRoGg4EuFcwACWh594RlS
	dHGmyLJCFaU+beqkD1IA5GRm0rHP+Rvo8Fu3ur6mUz4dElCJ00WLXx8huJCpMD62Q2sBPElK93m+z
	iGmm5Lxob0iZeL+zqwZEkHBA44BWcLEM8fNupEybg1FZ+kd2yePi136fRcnF+w4KzrAk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5gly-0001Y4-6Z;
	Sun, 13 Sep 2026 09:45:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x5glw-0001Xq-SS
 for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 09:45:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=9dbIjueeg/SgiblPJyYTaHQ57DQthl/VgFX/dnuBO3Q=; b=d3inb9GsZ8Kiy/tynC6+NAXuSw
 tEpBqsmQOpe/KdekEREJ9GVWFPav8n7mEGWOAF91kD5T6AuFvasyj/L4++W852j/yKdHrlenH6ZQA
 TisSFtZ6Voy4o2UcjJDH0aCKmsz13jTeXdKHZc6N9D2g7PIDvQ0lOe6Ev6A7LN5tA9FI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9dbIjueeg/SgiblPJyYTaHQ57DQthl/VgFX/dnuBO3Q=; b=k
 jxPcqdZubooh0zqJTubzaIRsdln+QoaKrZZpifC1s24wEUkyT6CHYoBS/nMncbZsH2HaVR41g1aTo
 aOxHXwawWElYvu7ONNiC8jqvSutvY8cXAfc0Kk5NLKJBPew4jpYwD6vTZe0+6bzZSwa92Vq/Wx3vG
 IEVGCwFoJmhvUcR8=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x5glw-00052N-Mi for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 09:45:17 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d37b5so7050215e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 13 Sep 2026 02:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789292710; x=1789897510; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9dbIjueeg/SgiblPJyYTaHQ57DQthl/VgFX/dnuBO3Q=;
 b=Doi5O8NI8PSUDYs9HyRtLhys4RF5CsHo1rYercUIOS18O/AEEBkTw6yJXXrqac8O/O
 3Yz+nb9dgE472JJyQ0zC5d3dJsG9gbp5RYTPtv6QY/B7KCZQ071khiOCMo1HYWiN9RCa
 jFBV9GYZtOELuEi178V2PZJHnVsVGl+E5O2LUMf0Zzu6rEl5hL5CgU8IhHIUwRA03ZGc
 /dbur5bzC+CRlBCQoqq8m+EqPFU95pSn87PktlBSHFxMae3bGF+x4SLkqLFoW9EvnCze
 ZZw3KMQhGUZuiyuHtoDur1OMYl5DQb4vJadXPffgqRZUpNCzXoqNGrut37ApbjV5Mcc6
 y0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789292710; x=1789897510;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9dbIjueeg/SgiblPJyYTaHQ57DQthl/VgFX/dnuBO3Q=;
 b=ssQcS6GsoGCkOCGNDHehRQWZ6C0UHAHngBEbGF4sn5r+X+ZO8ffuHEVn0vxLfOUmGP
 LkI/paf2/mfzfYuM7z4z9g9JTMGlQ4go7cgO23rv9slbD+H8X4igcRAMCCHcl6tVydbZ
 ouxA2Ed/LR1nrtu1FC+wYSIci7v35gVaFNc2QsCzt1KCYj+ucc6UJ5KHPELhgUlBRXhX
 UxUTbD6rNe4FFm1tVs/gKtc31/lJLw5GJjuSurABsvfdTHl52CLGK5fjIBtXr59oLuuI
 vaCYbMEdaQLX/IJpM84SlfQrbe3v6uYgfEl/dvN/Y79w2+5HLT7D/83w4HKLv+meoVMX
 NIag==
X-Forwarded-Encrypted: i=1;
 AKwUvByD0R5s5xiC9+qkuudiAw/8GWkwDfrJgSEMIpB5gFLrKK/dIUq0KHOlNQbN6NwfYFZRZppEdKnTuL4+95ru@lists.sourceforge.net
X-Gm-Message-State: AFuF++n+VyvYw0f0uuq9VpArh5LCg1H96RAoNjd0vRw78mkB6IlF4vzq
 BWFcbe8j5D9QzYX9aTRCFwXyDKskbXMXzdUo04FhBkBlDW+iagD0UgLy+rahkCjETyBVEdlxt88
 N8r0RQIo/ZNOzEkLMkDXDOkIL0fl6nJpGeWbLRUSSs42qERMkIcvNOrjiB+SJv4ZRLElHvAlyEq
 DJ76MaBg==
X-Gm-Gg: AYBFou3xytkDbujzAdhTnUK0sWiT0Yd5ASGexAU1xTaWADkfgp18RWF36GZ7sxsam8m
 6IZV/SiVnuOdUqKCet8HKCl9ssGvaqTe+y/yPMqiYrcBoHyfbPMro4AbN2m8KGzm2Qt4XPBm3JK
 RliLLTnD5dt6q+4KlQB7pzEc6ik3GvPdqfaS3XMbsijKppSyP7nkDmHWF1EANew0TJOV7ZG0wC5
 G5y64qpQqUTO+mQfW7PBcbMp6e/rhvp8Vy/6LTjUOBP5pCmz42ncs6E1qSbhjUoD0hHJWA4o/ft
 b+cmEjvysBKyR6NN2ePeeoZzue1IDiMlg/XfuU+R4Ds+HQV1qzLGxZmmyrlttigEuvBPVV/K8yS
 ocljXW+QLddcUbbU0zKROM5pU+ivv0O/KH7Z8Wwi6LJlgiIr5gu1vE1JhtjAg9cgmIaNJI7elkA
 /05VKLKqQvN5zN0ALxGMfzkE+ubCJzgtA9SZZCIxQtL0QPCdCyN0zOsrX4gXh/9aYLF/iz3Qk2Y
 6JKbKQNaCFEgI9TxjU6fO+4wvIkzCQYb47/FovYrjGmxVYl8hElSnHpQm/dfmOsj7I0ETTEvzF2
 aEASJ8cR02aPtfFzKfByiFK2DMR+wAyksXHVnNrT/93Z/hpMJsUZP/MreSDo+ic=
X-Received: by 2002:a05:600c:a0b:b0:49c:e1f1:3dd5 with SMTP id
 5b1f17b1804b1-49e618863bcmr247836175e9.4.1789292710030; 
 Sun, 13 Sep 2026 02:45:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6aac22bbsm99650565e9.0.2026.09.13.02.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 02:45:09 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 13 Sep 2026 09:45:07 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed
X-Gerrit-Change-Number: 1617
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1617?usp=email>
X-Gerrit-Commit: 35aca022b11f9efa8a8f0f3eef5c632a9c52102b
X-Gerrit-Comment-Date: Sun, 13 Sep 2026 09:45:07 +0000
In-Reply-To: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
References: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1NDIxNTU4MDAwLklkMGNhYTQ5N2M0ZmYxYWQ4NzQzY2IyM2YzMzJmMDAzYjJkMzM5M2VkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e86f2a75714a37935da84561d38f8bc9c836661a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x5glw-00052N-Mi
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove various
 useless assignments
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0873957753505896402=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0873957753505896402==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Fmm75+PN/FQ="; charset=UTF-8

--Fmm75+PN/FQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

cr=
on2 has posted comments on this change by flichtenheld=2E ( http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail )

Change subject: Remove var=
ious useless assignments
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 21: Code-Review-1

(1 comment)

File src/openvpn/p=
ush_util=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617/comment/48849=
d0e_8d7bdc20?usp=3Demail :
PS21, Line 134:     }
this is changing behaviour=
 (because in the `else {}` branch we're no longer skipping something), **bu=
t** I think this is actually buggy before, namely, loosing one option when =
push-continuation needs to be set=2E  Right?  So this is fine, but should b=
e mentioned in the commit message=2E



-- 
To view, visit http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1617?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed
Gerrit-Change-N=
umber: 1617
Gerrit-PatchSet: 21
Gerrit-Owner: flichtenheld <frank@lichtenhe=
ld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@m=
ailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-CC: stipa <lstipakov@gmail=2Ecom>
Gerrit-Attention: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment=
-Date: Sun, 13 Sep 2026 09:45:07 +0000
Gerrit-HasComments: Yes
Gerrit-Has-L=
abels: Yes

--Fmm75+PN/FQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>Patch set 2=
1:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail">View Chang=
e</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0;"><p>File src/openvpn/push_util=2Ec:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1617/comment/48849d0e_8d7bdc20?usp=3Demail">Patch Set =
#21, Line 134:</a> <code style=3D"font-family:monospace,monospace">    }</c=
ode></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">this is changing behaviour (because in the `else {}` branch we&#39=
;re no longer skipping something), **but** I think this is actually buggy b=
efore, namely, loosing one option when push-continuation needs to be set=2E=
  Right?  So this is fine, but should be mentioned in the commit message=2E=
</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1617?usp=3Demail">change 1617</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332f0=
03b2d3393ed </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1617 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 21 </div>
<div style=
=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@gree=
nie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;l=
stipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gma=
il=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, =
13 Sep 2026 09:45:07 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCo=
mments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </di=
v>

</body></html>
--Fmm75+PN/FQ=--


--===============0873957753505896402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0873957753505896402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0873957753505896402==--

