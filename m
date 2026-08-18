Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEEDC5DF67
	for <openvpn-devel@archiver.kernel.org>; Tue, 18 Aug 2026 06:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dev9xeVe7XwNCoIXZN7AczbPMZsvbNyLxIp88X6naf4=; b=h4PF/Ei1dGPAzbxC9HKqSCU6y1
	bIsi1bu8QuTV4DujKPhGjJ2eeYznJrbWfEt4MYDolrn/kxWsAzJD6bqNjHPgfSwsk8kUngIfwUuVJ
	+tX5QK/xXPWLTmJDtFWsvqW1nyVxCSG0G6eEgraAqpuFMJRGGLQKEY4QMyVLlYlWOwFA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwD8j-00064g-VP;
	Tue, 18 Aug 2026 06:17:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwD8f-00064T-9K
 for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 06:17:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=01QQweuLzAl+Rj738DCzJG3fp5AdwRFne+xZAuzz/UA=; b=LJ6mkLa704jPksnaR6Se7ZKGKH
 4BsfAnNT1W8mUCC77jLs90zuYCORA3wZXR7sbeZHGZAwVVXsQeK4XjM/ptcdN9yO/8OipQmja7QYt
 3zx+i5549Bx/4LK2pdU+PBkiD1snBBZ3raBSj58c42kQpNqsP8+ZGmyQiNYOzx8IG0no=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=01QQweuLzAl+Rj738DCzJG3fp5AdwRFne+xZAuzz/UA=; b=d
 eTEGnx7CZI+HqjRwOTi7reJBgFRi2kUYemK/ZVcyGTWXljTkzBPSpW/ksZcA7cYQDgQkUD6NO1EAF
 rvTMy5uCCFoipAekNuEk39RFtinH9VR11JTucb7yOz7zEyyDLplOmVO1cL4Nx7kIa61h2yuHrRc3N
 yOdu0tKgxEcRggJ4=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwD8b-0005zN-JL for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 06:17:30 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47362928f65so4068115f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 23:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787033843; x=1787638643; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=01QQweuLzAl+Rj738DCzJG3fp5AdwRFne+xZAuzz/UA=;
 b=MZGK/aQVORTYES3Ta2TD7TWgvwHpGzMdsO0r/J6q5kCczPD52ueg17RVzqZKbCtEsX
 MGKhaD5AXWn6fQlI0DjwGfilzussiAVpAyGO3N7OeLnBiMt4vlfps81lwbZ2itB3AvRO
 a4h5bscgoptbP9Xuv/zVnhFO5MZ98NghBtkSVbEUyS4yNXiDTfRnKF7Ody5eyPO2ax/g
 SvmvGf39uAaLyjOql3UA667yJRPwh7nNtbNCH2VeuZGAyNykdVptAnrKzFESSy6xt2iI
 voj6VfjA8lDLY0a+AP0vQJTfrz1WmYlgxiUCpkjTU4uvrVNVd8O7LLjd13AKKJT+2Bmb
 fAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787033843; x=1787638643;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=01QQweuLzAl+Rj738DCzJG3fp5AdwRFne+xZAuzz/UA=;
 b=TyRX6ybOEKbcnmjTvYtc3wPQVMgjcJDGCBORTI7+3ILGIy8FCmEyxBku+bj/ThmbiS
 SADy8E32vbHWSbeEKaX+WLLE9Pyms74EIqwkKycxJPtPcNr5WG5kuAkhVyCwhIlpbPVs
 iIJF3admLbyVZ3aKEBB6P+wCmo9cNQdG1GMN8keVJBEpQqp7sT5A7slDHCY9TKTril4g
 zBeQXBUyelShindDwgCoPMtbnN3WfQ0/KVPFVP2OzjNiqO9CkeDxOooNNmWoM66yuodp
 DLo3g5u5GLoBI5va6CS5g1dosEvqU2kvyRND8qQiM/RZ9f1sTNZJcfoJQkVG/UhZJRI8
 9zlA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpWz4sMTRX05zwoglEh1TiY4Z2uiqGGDVJajeeVYJwMpY2wfKuY6/8886KpA2xPH/aNy1iev3yQq3J5Fx3T@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy8qh/cph+Dy4a5tvSSwVsfl60TDp69aLoIQ/NurneTjJn+Fo1m
 pMAk4UcR+iAcIDQTCd1fDtsJUrheQdycpEnKfucAyRrW1oeu+TzqlzraGeL+rS3W0cteXw/ZhSi
 Y813NAVUiL3BTNZySbRYjDYj8UAcIv4+FC4IsAsonr06IFfZOccAFuuyzZr/tI6iG3u/1
X-Gm-Gg: AR+sD10W3yoNhPEeKHxhTid0m9ti4jC5XxfHQj4ZNvlFlA2NxyC5t87Z+bSGbErJdvN
 ovvmiTwWUBqpqFNjXldG4hcvE+pMAMEUkIe0TNdzhV58xMv4NbZvLrRb1gVvxprdXWejOHkIlkY
 Dd9NJZCgusVtb3ym2o6wssS5bexGVR/mB9sktUXv7o22MZbFKum6bLyDbw6POQtzAafsUyZFKeK
 ZocHbAXbRflIg51F2EgeLtx2iRErB/V39xTLf8iNa/N8miD9SC7yw+cJg74CgtO/JbmRqmkRMEi
 Us6GmciG4uPlhnLi2L3JsZEghfW8o8d3hGgvHc2O4Rf5F8mYSgaHtyBPVOOhZfhBa/jzWWuM0YM
 FIfIOztY+on2MSIQCMPZQdV3Ve5rSrKnb1PEng0GV8Aj/+NHm0RPPS4ZgsqiOor2UywaeAhgm36
 FyNR512ejucoC3eWRQX7ArqYPho5ZQGyi7k8+gJMtJKuPDQP9+FZu3RxT37KGB3pZTUJXPregRd
 a9AqJPxFoDH56RLojVPwumENHOkzEYJU2oVGK89ZF/KtxhcSgTcyFvCSjM04NqW6qb0FAiaJV4M
 8fayS2LPJuf87DwCH/C59J2Tp4l38c4DI4F+pruJw/CjIQuN4BA=
X-Received: by 2002:a05:600c:528d:b0:499:48be:3189 with SMTP id
 5b1f17b1804b1-4999fa84b7dmr105944545e9.0.1787033842838; 
 Mon, 17 Aug 2026 23:17:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a315d3sm9771053f8f.6.2026.08.17.23.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 23:17:22 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 18 Aug 2026 06:17:21 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I52773764e0f4056fe5367918a9b2e6720b165c21
X-Gerrit-Change-Number: 1585
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1585?usp=email>
X-Gerrit-Commit: 8235441b0fb18ecccc18719aef4743ff65568042
X-Gerrit-Comment-Date: Tue, 18 Aug 2026 06:17:21 +0000
In-Reply-To: <gerrit.1774268486000.I52773764e0f4056fe5367918a9b2e6720b165c21@gerrit.openvpn.net>
References: <gerrit.1774268486000.I52773764e0f4056fe5367918a9b2e6720b165c21@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc0MjY4NDg2MDAwLkk1Mjc3Mzc2NGUwZjQwNTZmZTUzNjc5MThhOWIyZTY3MjBiMTY1YzIxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0d3eaf9b79c2c8eb55600fbdaa183f5abe580d75-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwD8b-0005zN-JL
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dev-tools: Add new
 script to convert mails to Gerrit patches
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
Content-Type: multipart/mixed; boundary="===============1973223564829937741=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1973223564829937741==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="E3XwhNS2ni8="; charset=UTF-8

--E3XwhNS2ni8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1585?usp=3Demail )

Change subject: dev-tools: Add ne=
w script to convert mails to Gerrit patches
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(4 comments)

Patchset:

PS1=
: 
In addition to the inline comments, this script only deals with `HEAD` a=
s far as I can tell (so it ignores an mbox series)=2E If that's intended, t=
hat's fine=2E


File dev-tools/gerrit-submit-from-mail=2Esh:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1585/comment/ceda5c85_2f73518c?usp=3Demail :
P=
S1, Line 18: TIMESTAMP=3D$(date +%Y%M%dT%H%S)
This timestamp looks broken=
=2E `M` is minutes=2E I believe you want `%Y%m%dT%H%M%S`=2E


http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1585/comment/2e0a21c6_19bd43c0?usp=3Demail :
P=
S1, Line 22: git -C $SOURCE_DIR am
Should we check if this failed?


http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1585/comment/69690139_ec9cd096?usp=3Dem=
ail :
PS1, Line 37: if [ "$warnings" -ge 0 ]; then
Isn't `warning` always `=
>=3D 0`? Did you mean `-gt` here?



-- 
To view, visit http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1585?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I52773764e0f4056fe5367918a9b2e6720b165c21
Gerrit-Change-Numb=
er: 1585
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc =
<razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Com=
ment-Date: Tue, 18 Aug 2026 06:17:21 +0000
Gerrit-HasComments: Yes
Gerrit-H=
as-Labels: No

--E3XwhNS2ni8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1585?usp=3Demail">View Change</a></p><p>=
4 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1585?tab=3Dc=
omments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">In addition to the inline c=
omments, this script only deals with `HEAD` as far as I can tell (so it ign=
ores an mbox series)=2E If that&#39;s intended, that&#39;s fine=2E</p></li>=
</ul></li><li style=3D"margin: 0; padding: 0;"><p>File dev-tools/gerrit-sub=
mit-from-mail=2Esh:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1585/comment/ceda5c85_2f73=
518c?usp=3Demail">Patch Set #1, Line 18:</a> <code style=3D"font-family:mon=
ospace,monospace">TIMESTAMP=3D$(date +%Y%M%dT%H%S)</code></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This timestam=
p looks broken=2E `M` is minutes=2E I believe you want `%Y%m%dT%H%M%S`=2E</=
p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1585/commen=
t/2e0a21c6_19bd43c0?usp=3Demail">Patch Set #1, Line 22:</a> <code style=3D"=
font-family:monospace,monospace">git -C $SOURCE_DIR am</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Should =
we check if this failed?</p></li><li style=3D"margin: 0; padding: 0 0 0 16p=
x;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1585/comment/69690139_ec9cd096?usp=3Demail">Patch Set #1, Li=
ne 37:</a> <code style=3D"font-family:monospace,monospace">if [ &quot;$warn=
ings&quot; -ge 0 ]; then</code></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Isn&#39;t `warning` always `&gt;=3D 0`?=
 Did you mean `-gt` here?</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1585?usp=3Demail">change 1585=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1585?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5277=
3764e0f4056fe5367918a9b2e6720b165c21 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1585 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@m=
ailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Comment-Date: Tue, 18 Aug 2026 06:17:21 +0=
000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div=
 style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--E3XwhNS2ni8=--


--===============1973223564829937741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1973223564829937741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1973223564829937741==--

