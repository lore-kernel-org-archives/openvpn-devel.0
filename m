Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE07C55174
	for <openvpn-devel@archiver.kernel.org>; Sat,  8 Aug 2026 15:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UADAL3gLQMw/2TDTtzHzg5DFQy1XvSO6VGM+atC6Gqk=; b=CLQ0hL6MGAMrXzpNy+YPEjGJrp
	cwEW4aHXqUI/S0dWy8XDcEkbubnw6/sacQImpqt9fiDMdEA792eWCl0qdAFfC7yjxv1KdLF9U3H7e
	VXy7rqmEL4tgs9oUHbHWSdO0Mlu/pj27pjiKB4Wq954BvT24zwTvLXNb09+lbcSd3Rq8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsjIf-00075J-GK;
	Sat, 08 Aug 2026 15:49:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsjIe-00075C-3G
 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 15:49:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=eQh1w9EBre54juzoyrC68cbw52y84q6sRfwF/3HlF/s=; b=LfY4NZ9KjfSLw81GcperE8CCfT
 kn2nOoa+uS9+YbcrFPUo7IhSAZspbC6x5AWs8NgJ6imfHMf+12vuFE88vjJaTDwFV71GVW2Y9xEQi
 gr/OPKigfzVdjZ0uUfDEMxDzKFYa7PZizuvK4AvgzzxGJuSLnDMk4HLIhrtl+dF0h4/w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=eQh1w9EBre54juzoyrC68cbw52y84q6sRfwF/3HlF/s=; b=M
 2wGBwYUvjSmX9VvRYGv3d/37bAc4OlKzJzk98KFf1yQr0T5Xa77bGxuE4jU2doHiwnyIQxCQRLg9a
 tdvLrZssfKqafdAmiXSiLlIVtOEZ98u+4pSnzJpjZlJxNI4ZZZfL173HZ1RK4Fw9cwEyKZ9GZmbnz
 PLBG0KJcq9FYiLvc=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsjIh-0004pU-0v for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 15:49:28 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49557167508so3966205e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 08 Aug 2026 08:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786204161; x=1786808961; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eQh1w9EBre54juzoyrC68cbw52y84q6sRfwF/3HlF/s=;
 b=VYp0203avkW5yhhLlXSlCpKbyVk6khMswee03CSsFRiNQbnMYLKl3Jm7lYKb2oT76D
 XB0WmhUyvFqyNsrW57O/vfgtYYGfS5J65avQBQNqwv6xzGwDhU/wR9jH0u52RMizTC49
 ML/+waGTtcwJ2Qh1hQaXawcMNou8hEKTJuFsHdVTaNyVzDMDFM8Vj/d0mluSQkNqXk6w
 UpXSTa/XgR2ZvEn0Du6rb7RBYO63Vy8/wVNx//en5e+KVE7dAJ+Vj1UjdWK72SbbVztQ
 QUIUFiG+WMkVgqwXxhYgaRsLUmdC1OMA+w0B4Cr8F6KlLrVmO1ZFyqFVyFTHPnUb0eJN
 X7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786204161; x=1786808961;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=eQh1w9EBre54juzoyrC68cbw52y84q6sRfwF/3HlF/s=;
 b=oYcYQPtOYOGY/iOzusoWZoOWD8to90sR/46imbDXf6Dwq6Qx/BM7qmkaQg/TDbKTZc
 kWRkEAQiAFbyuc0uvNcdktCGDsjDwJttijMRiS4wn3AWmbDf1YjmTbyz0JDmLHutXkN9
 1RjwQDRsrxjysZoOXMFdLDXp9IokMgLBxWuext5ALrYwZ2XSbHcVIJ+NqTi/gCnLy1dN
 8ZLPJlXu5QtSxTXPTHZwPzOPyYeYS7JiXKU7QzM1ThXSr4rJhouWvB9HAOD/nGRTYy90
 GBGg1lghIUZ5diEx0tHhbxKbKfDrtENpRPeRjpFmNqMKMkEstY9v0eI4k/YPTE2PGYXi
 qoqg==
X-Gm-Message-State: AOJu0Yyml+E5FwK2oNknj0Ko0Mh1+E1UFfDNzKEq6FmkXra0zQgLGOb5
 RlhKMQbkC/NF5cVWe9L/2Ry/w6/w60UX4NXkGUem+kBf2uwJjMyYg5yLbxVkKZsSvIGu0HClxZO
 KBbYAo3/hLGsNJBaOiNdMbayokU+d9bBeqAyjDYAEmPbW7dpfiDiL7x7/JGulnbFXKi9l
X-Gm-Gg: AR+sD105h/wp3ryrjZhYeKHhWkdS4ioz5beD/u2jciEQbtrxvy1eyan2fgjNXFCENZH
 +P+TH/DRQtYfoHaHhiCOLQRyDshrmYdV05Uwbia5rSGa+gtNASx6uhAcKy7mzbCZqiA/MNNcBSF
 d86sJR2mIExjgPB4imv9F2KVo2et0rKihLFQZBkFLtipdxdtScxixTvYQ2ATsOVyPIpazTpHKNf
 PbrKG/HRW4UdbRvIE2uMN726G4VZ3y9XiCW+Mi7RBGdUpkHKSWzs0VM2nQce5RnRxKQtJ3DMDmo
 GrDdZSKiWoEIuyI4EbNnwPEiNK/n9PmHZHKrE1yJomtOsxZaG/FRlbCSKj9h6cysoAoCh22P/+m
 Dlycyq7KycCUU972NHQKzedpMC2vDthF7rbDRawfMhEe03NS/7FtqCqgCYDbqQkLSN74W6vKKYQ
 9PFzITUlgN6Q2IiOIWrlGun0TUI/GtwryY5mA0ru8xzf77WA+u7iWZ0FFmhgRKTNR2vbl3ZLNER
 mgAm7JuJjSDOKth8tEWiIUwuE21+CPB0SaPH9kLMN6mCLhAQYSS6mRfwBqPbmVKLjexRXR/4xD2
 3b/2/gEKmBdLtpvjiTKU5ocj/KcKV4KcU1u+Jpajo/31GTTL0Uk=
X-Received: by 2002:a05:600c:19d2:b0:496:bbce:fc with SMTP id
 5b1f17b1804b1-4994e7c10c6mr398542845e9.12.1786204160837; 
 Sat, 08 Aug 2026 08:49:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499542858b2sm268949515e9.14.2026.08.08.08.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 08:49:20 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 8 Aug 2026 15:49:18 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6
X-Gerrit-Change-Number: 1800
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1800?usp=email>
X-Gerrit-Commit: 8e96dd5325d288ed10b67f5ad87cd23c2eada1e5
X-Gerrit-Comment-Date: Sat, 8 Aug 2026 15:49:18 +0000
In-Reply-To: <gerrit.1784722744000.Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6@gerrit.openvpn.net>
References: <gerrit.1784722744000.Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NzIyNzQ0MDAwLklhZDk0ZTdhOWQwYjNiZThhOGRiMDllOWEyMGVhYWM2MDQxNDcwYWI2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <847550535eac6123a1a7f21dde7411727b9a6470-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsjIh-0004pU-0v
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Allow extracing
 other integers from peer info and add a unit test for it
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
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8438007231424995012=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8438007231424995012==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="D2WL5hXF8+g="; charset=UTF-8

--D2WL5hXF8+g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

cron2 has posted commen=
ts on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1800?usp=3Demail )

Change subject: Allow extracing other integers from =
peer info and add a unit test for it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 7: Code-Review+2


-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6=

Gerrit-Change-Number: 1800
Gerrit-PatchSet: 7
Gerrit-Owner: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Sat, 0=
8 Aug 2026 15:49:18 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--D2WL5hXF8+g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 7:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1800?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1800?usp=3Demail">change 1800</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iad94e7a9d0b3be8a8=
db09e9a20eaac6041470ab6 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1800 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;=
gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 08=
 Aug 2026 15:49:18 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
=

</body></html>
--D2WL5hXF8+g=--


--===============8438007231424995012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8438007231424995012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8438007231424995012==--

