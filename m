Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE238C5B572
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 17:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RlnVELLV5WNqH+08+hIj9nYmJhzdE4R2SZ04x9PHQ6k=; b=ZH1rW97qFsTGkX+bbPUStUt4dm
	HGd0k4MZi3ipKStS5Ego6R3qsWC+PzATY5q2HBayll4K/hmhyqk0bgOAga+G1ZSrQR24yYoA7pVEG
	7fLFwROGPcfic9QbuxOnFZi/zR5+Tau87S5u4ZyVYZ+ga3xaiTaLj9g8lIVvnJB0ciVo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuZCs-0004MN-JV;
	Thu, 13 Aug 2026 17:27:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuZCr-0004MF-84
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 17:27:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=5LncsnBdiYv1yjDrUChqmEqWH4ZvAuh3arG03xmVFJA=; b=NXg910lO9dWb0emcS8GsQ5udPH
 4g0s7G61cFHvF/P3B+wc2tuvGFPUWgYy8GZ0E5CLPmn/BuKIhevh1NkmvTIrcMtJ0bfBPOEwHdgIs
 S5Dt53LO6QKjtcnEPfWgorXwJCJV9aCQw+x+wI7aGyWhtvT42lOf3AECcW5YD1VMz2mo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5LncsnBdiYv1yjDrUChqmEqWH4ZvAuh3arG03xmVFJA=; b=U
 0WJTbQar//fE9hxjK24H12kFNb3VUMZoxXK4dPWZQAV2QbnyOBdjr9sxEHdqMUXvvyBVD54812Ipj
 V4uUBYgYeo6uTpNXBZYJoWwvkVyVHgwgzfcsJGvXohQt7kkjK+dSgICo/dmslJdQYpsZTVa/tb8Xe
 OPgGwYDPIvGVCWGI=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuZCp-000607-JS for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 17:27:05 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4954df200ddso1357915e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 10:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786642017; x=1787246817; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5LncsnBdiYv1yjDrUChqmEqWH4ZvAuh3arG03xmVFJA=;
 b=ZbTozvOLLmdPSgpK+T82q1ucsF7dRQarPxh7TdW+Lsn2U5XwnGi6+CthRyOPmV9z0l
 2Hln7gPVrdRiFhcZvVieAdSYgCyBAOJB3BGhVW7yphxeSZBGTU10TNDw4sAblH6R6M81
 4l7IVadot1rNLi+YLypgkmxYBpYooWqa8NkLMBjrlPD7obPWTGQ8yFRlu4j9qVguyGyi
 xDWZFyMkL6yabP3yDMT6OUhWMGcYkfcFtiHfEgAwkCr//Vavf1As7kIcQ2BE2zsv/dST
 wZzAu04BCTOmuVwQPenZDW0IzO+K1pYk0SKWMD0UtMxyovzn/YPpwEBeG3r4oOTET/fZ
 psIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786642017; x=1787246817;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5LncsnBdiYv1yjDrUChqmEqWH4ZvAuh3arG03xmVFJA=;
 b=Cz0zmY/lv2LyRJA14xqWL2HCj6WwJDZSeL+NW5ARW7zNrGrj9DoRG7FbGm0UobMoKG
 fNQRnKWPQVZ3kkt+h5A+F/PCw7doD2Ixouno0gWCCDYn+jw+2cZOrRxVnHtW7B0GZjPy
 3qTg/of0q3ScihX75rKGTY801LRLcysj0n7JH9KhcJDCfjSvw+0j0mIUud5ETf3N1qj5
 yh0ptnUYH21Oj602oHf0TSdwZ4fPV+4GuPXu0NJpSHkG7+qGKgZMDByZ+rjA8qX1ArQa
 lAe2VcaUersYuwf4QgboDU9WHslAjI72Had0D0DXboK27JRpP06sfdRT1bCR+jePCiQy
 cxDA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUR8ZNbBufFMkaIsd+1jXRGOfiMMcegR83CM5IaWGWrfjfKf4UQ+1PGB9x+a0NWc7MYFpBtoUuG4G4/4cJ@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzDc15eW5VFq3xs9LusVy+0su1a65btcCSK90/VOnyDAo8xfDcs
 0YOtTbwfpVPbnSBbCOaEu8XwCu1UFLLrvSB020oSwtR4+5dqJvZ9odq/CkGwCeOXXiB1fn326lD
 uHNoQSlNUEufYSU5BV/D/imeorLt2gpPMZbJc2uUvd9jtBxU/OzyCzhQw69D7xoexMmJc
X-Gm-Gg: AR+sD12ffea1lSJ7zAI9wPXFaXUlu82PzmVSU8uk+F6yIG7fa+TnUo48ys3gYifRqpn
 xspdNYEL6m927/PDjoN/SD5nJgBQfCDQtzNha7pV/29CeyXwYOnr4YyLOr4WFS+c/BkqkGasckX
 rI9H6M+IhnXsLFXGdkoxN0VOE0YMhVOxhFzb/szqEY1u8jsaHCJfAoKsCCdl3H7+mabP3VZR4sO
 brZAsSHLsIugAD9K2eKdE2BiBLnBy7XcyF7NiEdXdkhj13sMWcIJ3KCSMufbAtUJxMSFUZ/R3P+
 5NGxW/UXiqgaiIIkkJFTBdq09UM0WawBKeIgJ2HZ0W6xazmPeUIRJeF/FI7GVyJkInI2ieBcEGp
 z2VtBDW+ruJMfnJGRe+OcIRkIzgrNmfsX/zJ9GpjfbwQm6feiaPT3smvsXMvlLRaVD3NGH2EeAB
 6Sp3deAAS15TpMqBhaDVfPvyjfHnixlawNDws0OUZlpvriAbvT/Be3Mz4UFdBHBj/oJLcP2487e
 YsKTUKNAbnlb0KiUCAyo+rVMZFiwGRGe3AcWVdNx0LYW+wD/Ys5k4F/cCfaNr80Cmly3LVLvNT0
 2ipfPy832eGJOI8lKnSbYUG32mNiA88WoKT8hVmNY6FScZNlptM=
X-Received: by 2002:a05:600c:2114:b0:499:5210:c537 with SMTP id
 5b1f17b1804b1-4998792e462mr1036675e9.1.1786642016908; 
 Thu, 13 Aug 2026 10:26:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b58700sm74384155e9.9.2026.08.13.10.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 10:26:56 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 17:26:55 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Ie0b94b596637d660392bc4eda48d16cfecfeb971
X-Gerrit-Change-Number: 1562
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1562?usp=email>
X-Gerrit-Commit: 8aa3ba3778797e47f669dd737570e21bbff469a7
X-Gerrit-Comment-Date: Thu, 13 Aug 2026 17:26:55 +0000
In-Reply-To: <gerrit.1773073753000.Ie0b94b596637d660392bc4eda48d16cfecfeb971@gerrit.openvpn.net>
References: <gerrit.1773073753000.Ie0b94b596637d660392bc4eda48d16cfecfeb971@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMDczNzUzMDAwLkllMGI5NGI1OTY2MzdkNjYwMzkyYmM0ZWRhNDhkMTZjZmVjZmViOTcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a5c810c066569b942bde25fc44518d7efcc6ea96-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuZCp-000607-JS
Subject: [Openvpn-devel] [S] Change in openvpn[master]: init: Avoid
 sign-compare warnings
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2154386795513659001=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2154386795513659001==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LeaY4tKFSn0="; charset=UTF-8

--LeaY4tKFSn0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1562?usp=3Demail )

Change subject: init: Avoid sign-=
compare warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 8: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1562?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: Ie0b94b596637d660392bc4eda48d16cfecfeb971
Gerrit-Change-Number=
: 1562
Gerrit-PatchSet: 8
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Com=
ment-Date: Thu, 13 Aug 2026 17:26:55 +0000
Gerrit-HasComments: No
Gerrit-Ha=
s-Labels: Yes

--LeaY4tKFSn0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 8:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1562?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1562?usp=3Demail">change 1562=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1562?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie0b9=
4b596637d660392bc4eda48d16cfecfeb971 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1562 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 13 Aug 2026 17:=
26:55 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--LeaY4tKFSn0=--


--===============2154386795513659001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2154386795513659001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2154386795513659001==--

