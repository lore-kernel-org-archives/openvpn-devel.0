Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70980C79FB7
	for <openvpn-devel@archiver.kernel.org>; Wed,  9 Sep 2026 16:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GHPLg8oUJKNV/k1IrrHuh0d+UQAMIY19MHelZes4SEg=; b=HGN5NibBqpop3/rYGPBdxWoJr0
	Cp1G3zcvnQeDAYIZCwxfO7ejLn1UTGVKZNnrHYV6oKoEZmwK9H53GWnY2FpHwBY1CgfQR4XVXLZ6D
	LQWn/2ZA9BxrsqwkRJym7RGb7zO/Jsif3Nvvt71K824Dr8I1xu5pRrQ3BkfcS0mkaSuw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4Lb1-0008N8-OV;
	Wed, 09 Sep 2026 16:56:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4Lb0-0008N0-9m
 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 16:56:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=XxRwwN3yp2WgTvD+iCCPPGlroKePEnaoQh07HOI0Yqw=; b=baxJf4avc7klj+4S2oGfAe0LAr
 kSiTaCSFVJP3uA7moDP8lnhB0IwM5zLPqaAkWIZ+Xzabn3XKlM7pnEQ9ie8IfbwbeBk7mu0Zu1qqj
 raeMJRXxKFdwRTB4jxeYF6vVgN2M+b40zHIltKkZNXauWQXLCtFbfPmSUjxrFgPYnp3c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XxRwwN3yp2WgTvD+iCCPPGlroKePEnaoQh07HOI0Yqw=; b=F
 7H9s4WXkYa8m7V4N3tYdRyPBNdNPKMFokCygwBpJYzQIDs+cnf8clBzvMw3Shho9DGS7nQNAU+D8g
 BQ4G1LvyJSWhmxOLNwKmjlDhQyJCVgI88uHXp3Gjw8hvnu2LB9rDmI7+Jd0VWBn3s8UUrY4LMJRm4
 Z9H/Gh3kDJZBzPlQ=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4Lax-0000vh-MW for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 16:56:26 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-486955ae01eso279108f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 09:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788972977; x=1789577777; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XxRwwN3yp2WgTvD+iCCPPGlroKePEnaoQh07HOI0Yqw=;
 b=PB+am275eJhgLlaTToPmzltMfSYmmHMTLfDbeNRccvTk9G5yz4ZU/7CZDidHhNeTQ2
 244QlNOsElDfiKV/XriCT55h5zMeqGKf+NPO7zO4Dz2hn/arRSaDs+PeHq6LqXW0K737
 Dv0T7xhFzyuk7itDWuHLmWUz6st3Gasv4rMnxTRU4Cnw4X+ebqxlX++90O7t7IAwliRr
 Qdp53UxxRUIhNNosibABPbzCjpzDC9h5LoBRqE/BZeePUqOR+zIKQt6xt19jL89/D5+P
 lp3Ki/xerOoRS2/ozKWPoOzF0tI0kkRSGDu6Xo8FcIpIcwTHjsnYTnrNCwhn2HMv56FR
 crzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788972977; x=1789577777;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XxRwwN3yp2WgTvD+iCCPPGlroKePEnaoQh07HOI0Yqw=;
 b=s1NiNCfT0AQhZQdU9y3wvgQtahDLoJTsAoFid+yFENXKI9Ak+P7xf0jdDXQZMwAvB5
 YOPhta4mlArzRM/9RtqoFeWSbx0SyMunMzd2XeBESdoIgWLCgm2nK500Ve3rutNdVxRX
 roDLxsTEXPcQ7vGR/D9sQ+ccWUWpcvB1w74gfc+Kjhc7yQbvXCGvRkaga0ZYkAKTCwzt
 8R0PNFUElOTUfyw+EwYYv5KPIsi1nTyvxHozjKLIYbdVOpZdBuUU9O0pgWnZb308v6fU
 NGcBMqx2snQzY/AruQBIKa6NzKz1sx0QpytJeoz9bSxhpIkcE3+g/8i+ZKLjdbrqKX+K
 kgTA==
X-Gm-Message-State: AFuF++mgwn9Zm5T7TxNg8bAF1G7ks/Etpu2DxPgrwc1BqhiUQXri2i95
 CaY5c6e0CANX1tuQfp+5ZIgdn4VIW/B0yBlOxi5SJuTMQG1TEXLyDA4RWCjOJrRno8YbS4GPWn2
 QBO65XToUtWovPUojJ6eiBI566Sv3mpu3AIGVzrmF0zUlsdLtJheRgNZ6bKvYVD1Up64D
X-Gm-Gg: AYBFou20n9PtuqiVTeOkjsczG9am+m26JbMBbn9cFHuLce1FCzZrmAXmovbcWkvzp90
 OeoHPXByjUATQIPcjMRq1EuC+QGUNXSR26VqdboC2sHlnt4kSPUPcmWw+EROixfe0a3ueLtJ25C
 6zGeAZXsbTmvgPCbYiQpq5FLMpIpgfnUFFeLnym+70GcjsgXvBiGKGkCa4DLbo/CmskBgmRj8TR
 V1Ve1aMTC72eBPmSYT6XrCEuRV4zmb7Ua1RBsECgXIJAUMXbBmj9ovLg0VFps5kIgLdoeDw3geW
 t3fWqpfYHgzEPYQ98ce5YapMuEK2DoMmXNoWMMNZZVP6ouOPM3oLXmHDrmW7wCRIRZ1aA6YIf/c
 oFQohZchtRRmeuG2vCjy6HWUt63gtwXEHwe8MTTyI4PU2/32LeWJ/WDiAUQOsQBL7knOo+sMoVQ
 +b5cT6R5l+hkT1zCCtgKcGaskaBZEwKkjh7WRHDtqRCnEcdDwOv4JQLveduuJ2GTC9rCN2y2cvD
 TXWgx8CQ7er7ckwUPWY+m6/grKmXSfOMwzFM1yMGoT2IuTwBpcn95TqQrTZSUv+jGLWZb+zdsXy
 qnFpVf9LuhHzU512RRl4+DFgT1qVKcpiuiszMOf7W75+Ivk6PNVCe72HaYun1w==
X-Received: by 2002:a05:600c:474a:b0:499:79b9:e220 with SMTP id
 5b1f17b1804b1-49cf825d722mr334011065e9.10.1788972977052; 
 Wed, 09 Sep 2026 09:56:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c1bfc1sm4352265e9.4.2026.09.09.09.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 09:56:16 -0700 (PDT)
X-Google-Original-From: "d12fk (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 9 Sep 2026 16:56:15 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182
X-Gerrit-Change-Number: 1907
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1907?usp=email>
X-Gerrit-Commit: a453210da741209545b1b6d026a6487151789341
X-Gerrit-Comment-Date: Wed, 9 Sep 2026 16:56:15 +0000
In-Reply-To: <gerrit.1788885240000.Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182@gerrit.openvpn.net>
References: <gerrit.1788885240000.Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODg1MjQwMDAwLkljOTgzYTNiZjFlZThkNGVmOThmMzg4M2Q1ZTVkZGYyMzQ2OTZhMTgyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <448d048d957740fba661f997db545d61057c2124-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4Lax-0000vh-MW
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: openvpnserv:
 harden CheckConfigPath() a bit more
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
From: "d12fk \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, razvanc@mailbox.org,
 max@max-fillinger.net, gert@greenie.muc.de
Cc: "d12fk \(Code Review\)" <gerrit@openvpn.net>,
 plaisthos <arne-openvpn@rfc2549.org>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5522376345405463101=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5522376345405463101==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4/Dp9OULNZs="; charset=UTF-8

--4/Dp9OULNZs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, cron2, plaisthos, razvanc=2E

d=
12fk has posted comments on this change by MaxF=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1907?usp=3Demail )

Change subject: openvpnserv: harden=
 CheckConfigPath() a bit more
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 3:

(1 comment)

Patchset:

PS3: 
This is not n=
eeded=2E In 2=2E6 this check is already present further down in the functio=
n=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1907?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Ger=
rit-Project: openvpn
Gerrit-Branch: release/2=2E6
Gerrit-Change-Id: Ic983a3=
bf1ee8d4ef98f3883d5e5ddf234696a182
Gerrit-Change-Number: 1907
Gerrit-PatchS=
et: 3
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer: cron2 <=
gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerri=
t-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc=
 <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: razvanc =
<razvanc@mailbox=2Eorg>
Gerrit-Attention: MaxF <max@max-fillinger=2Enet>
Ge=
rrit-Comment-Date: Wed, 09 Sep 2026 16:56:15 +0000
Gerrit-HasComments: Yes
=
Gerrit-Has-Labels: No

--4/Dp9OULNZs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, cron2, plaisthos, razvanc=2E </p>
<p><a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1907?usp=3Demail">View Change</a=
></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1907?=
tab=3Dcomments&amp;usp=3Demail">Patch Set #3:</a> </p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">This is not needed=
=2E In 2=2E6 this check is already present further down in the function=2E<=
/p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1907?usp=3Demail">change 1907</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1907?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2=2E6 </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic983a3bf1ee8d4ef98f388=
3d5e5ddf234696a182 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1907 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk =
&lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;m=
ax@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Comme=
nt-Date: Wed, 09 Sep 2026 16:56:15 +0000 </div>
<div style=3D"display:none"=
> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-La=
bels: No </div>

</body></html>
--4/Dp9OULNZs=--


--===============5522376345405463101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5522376345405463101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5522376345405463101==--

