Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06B6C982F1
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wsxbIdw5uPvxs+9IKe8BaNnLr1QcC11okiFSTWCm5dc=; b=a4ihhEmqPdWxWzOiNNkZI+iQuL
	RnlG2oJtwjq+T7JwS0cTfR50YKOwU2It8jjwYNOunU7Q8R3sI0aHztCGQoqVl2b6hcJ+YBgO+k8WU
	/AIiMlSnXipuFgIC3hmO4FOM135fvtx0gahENfCBULRA+pUOvfOBSoz/FNnwSk5inJZ0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8xKl-000884-DW;
	Tue, 22 Sep 2026 10:02:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x8xKc-00087t-W2
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 10:02:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cFebOF/PlqmdkhQtb2wokQZvhiwC4HUP/GH1sKQoQkM=; b=KSOv5bi++9x7F3Jrd//0DrkQqU
 fFp2m7daH+RouAb48Ilc7l7e3X/5K6bUFfGiLXmA2rBhTUvJ+TdA8fFFUEuJ8I7M/Rc1z75mRi6Xl
 IKeE/89mXw2SLGHBijnRAKZxl0arouEH64BoHyIxARPXehpxRHd9KGvdtkYbWlyDdX4A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cFebOF/PlqmdkhQtb2wokQZvhiwC4HUP/GH1sKQoQkM=; b=b
 7XtKrb32JN5EtcVP2N0TyWLWvgRCAVradISc0bvbi1CqyogGs16stDU1BzWrX5+w/Q7DzH1njgQKw
 Pk1XAnbZI0HZeVVPczFTcwXxH5fWgQeRXmQVDHUm8OfGMevVTilnzDVWCdFeSvft6Eq6e38TSQgn7
 9D50fcGdFzh4GuJ0=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8xKc-00059e-Ps for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 10:02:35 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b965f447cso33377855e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 03:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790071348; x=1790676148; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cFebOF/PlqmdkhQtb2wokQZvhiwC4HUP/GH1sKQoQkM=;
 b=M4nVRW82Y3Z32I15VwQcuv5gRdT4LzDyfFyrX2k9MBK4mhuuJVpF8/0smwFBRbPKG4
 uHmNcNiL3GEhEYUKGroiNelUd/ZSz1WLANmjk5cZBFWv/7Ow2ndXgZ3OvUmfu0PS6OM6
 vjoynK/8BrQzSCjRknwCP00YtvN81Svv8aI8hYiQU0aOVfs9BDoogR+lr7pYx808qggq
 IYfCPShT+o930NGvEmwjvA/auGUpFEN8Cgh08gALUue0/S5czwFg/C4nPmYL5FJLNCv5
 JpoCGLT4cnfI794BrNC2eP6ss/MTyt+3GldPQkujqM56QM4HUgFSFOHQXld3Jj8aUXZh
 +9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790071348; x=1790676148;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cFebOF/PlqmdkhQtb2wokQZvhiwC4HUP/GH1sKQoQkM=;
 b=FEKw7F8GvO2rccTIUFQz0xWHpY2d5W160A9CHy8wXPD4PugRNuiJx+SyOIm3d3wrsB
 /aJo0dmHtSxw4VQR7xNfvVrdClbhk9N9YITSMBYf07QMa308O+7q4S5zVs2yvxOP4H+2
 leWY/3HB/s+8APLIvUBGGgSIO64P82fw9Ja4IDEQQOFST+lv/g19iZyqLkSJIKhm+3R9
 c9ou0Tl9TOrcJ/hD/GQ14h+QHRsrYSS2T/P81Ci6outq+Itq8+Q5o4t7QttoXZM8xqJa
 Fz5fLsUDBoQkWRDQQsdeSuNknk+LZ6iNllXRT263la8/IZ9XHcGDAFvn1uUMcOUXoHzs
 pfZA==
X-Forwarded-Encrypted: i=1;
 AKwUvByqClfM+u/LELZKUoet4A6Z6THcSnPSqkRkXaAmTpDf/VUFqYkgcKpg3KrhGdBdzMp7pizCnsZw/hoiavJL@lists.sourceforge.net
X-Gm-Message-State: AFuF++mC8VEAIYLIUbPz03FyYDrdJVw4Ag4MGX5YqGZacgxAXoH+wbS4
 +47vSOA4jrXgypMjy3EcYvMfz47lou0H2hMG6R7ewWf5b7ft3n+gDHsOUnsltl3kOisD3xlgXLg
 DDY2cWxsfr0gT2x0Z66MkvMPWLnD6rN0InNLF6DYdd77mRqi5mDmkeaUhTxlVELXhPPAK
X-Gm-Gg: AYBFou2L/Qq1/jjyuwhxro5tVPExc28mzzniGJMuOTstuyJI8WUvex7IOOAJJjNFyO9
 MV85IuHU/eBZRQmCwCvCwSDECkeHO4gMxVmt7UGRoIbjGzT1tfaVxNxRI1jZNq+HVX3Mld/v00l
 eRqyQJ796WrrInNl166umqI0Y8e+oFAmu4PkaegOzXaqmG8x/8DnJU1CMz/VPh4kIZRs/AuIp6b
 IRu/h7sDXhX8AnI0+v5qZe0ff4dHhLaZIZb7+mx3NPO4z6nlxLioU0uSdETGcTI+q6hYooJPnob
 6YgKC620jloKzbXWYneulQYJPaBpQ8jHyllHuBnn6vTxAJoJzsd69RbnhZ8s4P2GKa1IxSGY7Nx
 B8Pg+/RUEL2JLF5xvY5ou6EjQz7n7/ZNz56/QH0D6VF+QTWBzMsxK3hUgMK1Sqe+SJ/uN+1VoGe
 VWPLdcLT9kx4Ofhy00BiW+G0VIMGmaxgvudnJetETlhQOxpgbpO+F2hCoIVkJ1hRwL8QTy0+M9T
 nKqHqBAbkqb56rJhIA017MZ0xo8V244duE6al7XZGwxQt65zHdo5swZU1lZNV6sDm0AFTqJ+OPx
 P2B6A5lIKDCEUDdo2WQR/qejv4lHXGPHZawnnwwNe9bDfrWq2JDlHr6QJXKjdM8gOnxOd6S2
X-Received: by 2002:a05:600c:a108:b0:49f:d6b2:4dfa with SMTP id
 5b1f17b1804b1-49fd6b2503emr46726595e9.4.1790071348203; 
 Tue, 22 Sep 2026 03:02:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48862731a53sm3788282f8f.4.2026.09.22.03.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 03:02:26 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 22 Sep 2026 10:02:24 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I983d67e1c90bea460f531f11d4c58d33a351d81b
X-Gerrit-Change-Number: 1922
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1922?usp=email>
X-Gerrit-Commit: c3d12d0f16b96d12ebc4935c4d933a95d3d6e99e
X-Gerrit-Comment-Date: Tue, 22 Sep 2026 10:02:24 +0000
In-Reply-To: <gerrit.1790006381000.I983d67e1c90bea460f531f11d4c58d33a351d81b@gerrit.openvpn.net>
References: <gerrit.1790006381000.I983d67e1c90bea460f531f11d4c58d33a351d81b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDA2MzgxMDAwLkk5ODNkNjdlMWM5MGJlYTQ2MGY1MzFmMTFkNGM1OGQzM2EzNTFkODFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <990abc353d221d8fd3280f17b64074bc3ded666f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x8xKc-00059e-Ps
Subject: [Openvpn-devel] [M] Change in openvpn[master]: GHA: Maintenance
 update September 2026
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
Content-Type: multipart/mixed; boundary="===============5476503393881287911=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5476503393881287911==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Qzx+kzuE0TM="; charset=UTF-8

--Qzx+kzuE0TM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1922?usp=3Demail )

Change subject: GHA: Maintenance =
update September 2026
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1922?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I983d67e1c90bea460f531f11d4c58d33a351d81b
Gerrit-Chang=
e-Number: 1922
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-Comment-Date: Tue, 22 Sep 2026 10:02:24 +0000
Gerrit-HasComments: No
G=
errit-Has-Labels: Yes

--Qzx+kzuE0TM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>razvanc has posted=
 comments on this change by flichtenheld=2E</p><p>Patch set 3:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1922?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1922?usp=3Demail">change 1922</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1922?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I983d67e1=
c90bea460f531f11d4c58d33a351d81b </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1922 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3=
 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Comment-Date: Tue, 22 Sep 2026 10:02:24 =
+0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--Qzx+kzuE0TM=--


--===============5476503393881287911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5476503393881287911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5476503393881287911==--

