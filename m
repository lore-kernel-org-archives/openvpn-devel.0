Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC69CD4F35
	for <openvpn-devel@archiver.kernel.org>; Wed, 13 May 2026 11:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uJO0pXAD7dKkPEpwQN3Rk5FOiAvXYNdVsnWnbX5p80o=; b=A0oZrs0U7XV/I6AuTAaquAlhTV
	p09Y/K9nNEDo09KRmgC6+k42ybQm3d4AgBt9rJ4rR8KI9xp6N6eYmJu5yATM5eMOJKRWRj9ObJKvr
	T6ap7mw+Z2qGWHwirFMbWqzNT3Cw4CHXoDWcOzxYiDsZBoTQiGdo72ZykDaBz/xBDxSs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wN7Un-0005ei-Ja;
	Wed, 13 May 2026 11:11:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wN7Uk-0005eV-NB
 for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 11:11:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Hd4PXhVvLRHBDP4L4ype6NCKRpI535NuK2CTeh4gGZ0=; b=brgbQjc0SfCBVo4iVi1QNsohFS
 /sDvP76fNpogDtCqxn4OrugEl5GSfIL+HhdGEeYxZ66Rw48ZU2WIi51MSP4E4DV+ok/6fdYG6DM3L
 7Q+c1mIuRFULMc1BERZL0WUCI1hBI1mpmIkqmeLgUcgO+swBsgczj/B5PPoo251rKPpU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Hd4PXhVvLRHBDP4L4ype6NCKRpI535NuK2CTeh4gGZ0=; b=A
 cJ7/f+fqlPklqG+uNBW3KscBVu6wGeqkiN5eMEQfAfuU5Wyl2ESmcyg94Twyy+QkJViMVvpE/u2H1
 CUT3qaEwMTLfunt5FnZtph52EvwDJQSocPbNfeXthiS3i1fahu/VMN6u+4pAySVpFhgUTEp3ezd7g
 +bjiGlfCChNgqAKY=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wN7Uh-00016D-EP for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 11:11:18 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-488d2079582so69571155e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 13 May 2026 04:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778670669; x=1779275469; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hd4PXhVvLRHBDP4L4ype6NCKRpI535NuK2CTeh4gGZ0=;
 b=HKROKBIWb3LtIzmv7ZteSHo7oZObYi3r34sElJNGttl8n5KB0usMU5fs7NQr9GgbNZ
 jeqNQjDE/Ebi2Ji+Vpa4XcywFTJet+CSD3telbwa2OM406mMOnsXnsrfArMIlKyQoav9
 uHyHO5VeStXze1iPbun/gj8bs4luA1dkKfbHwayjOuOo6J0biCyWVpcytch1KZWnr40X
 YLosZgmxTNr7crsOAKrN+84v92nePjmMA+jPXqvBCfiU0Jnidmbmk4gsk1nZz4XTEPcJ
 9I3dZIRC77SujJ3mYND+0cCzuaLSkF8TJH+bm2mSX/8d6l4U/TxK1hs1J1YL0e+4MbTe
 fOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778670669; x=1779275469;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hd4PXhVvLRHBDP4L4ype6NCKRpI535NuK2CTeh4gGZ0=;
 b=QPrdGYs9rhi3cq8nmyOwPqbEJeN0FxDi8EWPDXCGwUBEOKBuR+uGgFd5MMpLOxkfzY
 tlFRqieHqJFo//f7ZSiVMWePTdBxrgEj7Y2rF2yNN8DH4da6CmYakb/fj3Jo5k5pm6zu
 NBot4nB451SuT0T7ItQXC1CaCnQECJtCMxU99xoWV+LPNqIiHTsc2aXx6jI2lR/SZtkB
 wknKsQSmn21WkUKYH7666wseYPJHKG/xIfkfLL7pTWkcrE1L/XoKmKBmc7EU5O/Yvp9o
 DkHGVathp7hlbgCAeFck8z1BvGw5FI+LdGjJIZtyXPehTdXjOyYOIZ9yYvbzDaC1LHjo
 Uryg==
X-Gm-Message-State: AOJu0YzHCjh12PNcUBrwW6X/FJ4jZAbdPr+xct9LnNHqZSbU5eg4mOHG
 GdHBSXeg2g3ObmFjGmEdGBNqSybIQ5pDb1/cgaOAhl+AxSkkkTjZar1AeZxXy6oBCKXa3hLW13n
 7lRABnOcapDCRrke5EF8dODRs/A2hI4zTFqWtzT/YVgoQpGHF81LOEW6hInAsbeFQXf/I
X-Gm-Gg: Acq92OFp7Cl47bzyeGCnQdmSuZvmgn56ZxN8TaTL1Ah35vtH4BJAT93J6I3lNXjpg9V
 bBjBIzi1fR9bEFAZ2+2KPJk3OhihBAKps/gcG4zdpOvKwAFTBVPbkjtK0by3oQCdtyGHJDzGcbU
 9KBPRX4Wh4DTtDTBLjo0KYkOtGuP3q7IyG2c59CO89TisMatzUZer4OECJ0jSi6wtFAaiRvMZC6
 g1wdMg2d41x0D0f3RguyVN9VIenXp93jEAneK14dT2XU/CNfXYJ4nyDRxU1I1vJQgE16O0wz9FR
 oa8L6ZE+syRyPQCgtpmpAO2rXqhekqjGNo5WvP8u73ibRz6C641NbZir1cUh+Vyr425vm/1OSHL
 BXB0UKYa8tYRx++lHLtSJ8qcI8ovssB4e3ykyMujsVG8jISP+NWBrqxwimtSwKjFd1EJWHG8Dzm
 il129V+w9ohIfHZGWvA+GTgxqCXIgKc/W3SIJuu0suahs4rP53kI/Wo68zyPXlw1ZVKCjt6keV2
 3jjCqnAwoiMAUK6P0X5ItDVGSXqtUeSyUi+SLYauH+ciQMN5P1ViRlBCRRl21sgIOnAs+4x/+Pw
 U94gB13BIDwAcA==
X-Received: by 2002:a05:600c:3f0f:b0:488:a2ac:a334 with SMTP id
 5b1f17b1804b1-48fce99d7e5mr31453805e9.3.1778670669312; 
 Wed, 13 May 2026 04:11:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f428adbsm47250005e9.17.2026.05.13.04.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 04:11:08 -0700 (PDT)
From: "cron2 (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 13 May 2026 11:11:06 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: If58bb807842b7b95aeffe6849e7a7344e4925762
X-Gerrit-Change-Number: 1667
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1667?usp=email>
X-Gerrit-Commit: 9922d2c3f397944625b99afe984563cb2d9a0456
In-Reply-To: <gerrit.1778102459000.If58bb807842b7b95aeffe6849e7a7344e4925762@gerrit.openvpn.net>
References: <gerrit.1778102459000.If58bb807842b7b95aeffe6849e7a7344e4925762@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MTAyNDU5MDAwLklmNThiYjgwNzg0MmI3Yjk1YWVmZmU2ODQ5ZTdhNzM0NGU0OTI1NzYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ab87029a7ce6c91bf603154765bd8eddad90e347-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wN7Uh-00016D-EP
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: multi: Remove
 useless checks
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1709943630714223384=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1709943630714223384==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KHNIvWL0IwI="; charset=UTF-8

--KHNIvWL0IwI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1667?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by cron2


Change subject: multi: Remove useless checks
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi: Remove useless checks

I=
f mi is NULL, the previous code lines already
segfaulted=2E

Identified by =
cppcheck=2E

Change-Id: If58bb807842b7b95aeffe6849e7a7344e4925762
Signed-of=
f-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Gert Doering <g=
ert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1667
Message-Id: <20260513091710=2E28378-1-gert@greenie=2Emuc=2Ede>
URL=
: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/=
msg36899=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M=
 src/openvpn/multi=2Ec
1 file changed, 2 insertions(+), 2 deletions(-)


  =
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/67/1667/4
=

diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 06e3758=
=2E=2Ea957fdf 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2E=
c
@@ -3054,8 +3054,8 @@
 
 #ifdef MULTI_DEBUG_EVENT_LOOP
         printf("P=
OST %s[%d] to=3D%d lo=3D%d/%d w=3D%" PRIi64 "/%ld\n", id(mi), (int)(mi =3D=
=3D m->pending),
-               mi ? mi->context=2Ec2=2Eto_tun=2Elen : -1,=
 mi ? mi->context=2Ec2=2Eto_link=2Elen : -1,
-               (mi && mi->con=
text=2Ec2=2Efragment) ? mi->context=2Ec2=2Efragment->outgoing=2Elen : -1,
+=
               mi->context=2Ec2=2Eto_tun=2Elen, mi->context=2Ec2=2Eto_link=
=2Elen,
+               mi->context=2Ec2=2Efragment ? mi->context=2Ec2=2Efr=
agment->outgoing=2Elen : -1,
                (int64_t)mi->context=2Ec2=2Eti=
meval=2Etv_sec, (long)mi->context=2Ec2=2Etimeval=2Etv_usec);
 #endif
     }=


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1667?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If58bb807842b7b=
95aeffe6849e7a7344e4925762
Gerrit-Change-Number: 1667
Gerrit-PatchSet: 4
Ge=
rrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <=
gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--KHNIvWL0IwI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1667?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">multi: Remove useless chec=
ks<br><br>If mi is NULL, the previous code lines already<br>segfaulted=2E<b=
r><br>Identified by cppcheck=2E<br><br>Change-Id: If58bb807842b7b95aeffe684=
9e7a7344e4925762<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Ger=
rit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1667<br>Message-Id: &lt=
;20260513091710=2E28378-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg36899=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M src/openvpn/multi=2Ec<br>1 file changed, 2 insertions(+), 2 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/67/1667/4</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/sr=
c/openvpn/multi=2Ec</span><br><span>index 06e3758=2E=2Ea957fdf 100644</span=
><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/mu=
lti=2Ec</span><br><span>@@ -3054,8 +3054,8 @@</span><br><span> </span><br><=
span> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span>         printf(&quot;P=
OST %s[%d] to=3D%d lo=3D%d/%d w=3D%&quot; PRIi64 &quot;/%ld\n&quot;, id(mi)=
, (int)(mi =3D=3D m-&gt;pending),</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-               mi ? mi-&gt;context=2Ec2=2Eto_tun=2Elen : -1, mi=
 ? mi-&gt;context=2Ec2=2Eto_link=2Elen : -1,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-               (mi &amp;&amp; mi-&gt;context=2Ec2=2E=
fragment) ? mi-&gt;context=2Ec2=2Efragment-&gt;outgoing=2Elen : -1,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+               mi-&gt;conte=
xt=2Ec2=2Eto_tun=2Elen, mi-&gt;context=2Ec2=2Eto_link=2Elen,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+               mi-&gt;context=2Ec2=
=2Efragment ? mi-&gt;context=2Ec2=2Efragment-&gt;outgoing=2Elen : -1,</span=
><br><span>                (int64_t)mi-&gt;context=2Ec2=2Etimeval=2Etv_sec,=
 (long)mi-&gt;context=2Ec2=2Etimeval=2Etv_usec);</span><br><span> #endif</s=
pan><br><span>     }</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1667?usp=3Demail">change =
1667</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1667?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: If58bb807842b7b95aeffe6849e7a7344e4925762 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1667 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--KHNIvWL0IwI=--


--===============1709943630714223384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1709943630714223384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1709943630714223384==--

