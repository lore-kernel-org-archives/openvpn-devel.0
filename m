Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76539C79F8C
	for <openvpn-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9WvBkvaq7XRrXiRhleGg4VZrh0hIvukkqaEJWZuNwGk=; b=YJ236tf84terDrODBF3EgR3TOE
	Q7fLgGT+j4gUVf2jygcAM5UBdvbG4w/RGeTDJb6eEg1rFup5946dlrttYGEL6GpE/tC2aKLfUakZV
	yoOz4hz4DBf73MoPG5EfWm2D1JtheV3SuG6nFWXAjSXVolSKope/ObOT4+GGSElDIwi8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4Drt-0006kH-61;
	Wed, 09 Sep 2026 08:41:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4Drr-0006k7-Ra
 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 08:41:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=pxTtXVaqpqj+BPwVlE/5qYUhcj30dqk1OPpbzp+s8RQ=; b=Zkq7fxkQUyEUhlOwptyUvyu8Fe
 WQdGHIkhmXFtgHosOCH7SfpeCridyR98CAgt44D2oF9B9r0UtzgM2Tmx/7oO7vg9AIjdLCUyRqxh9
 Seb9SYWYJsfRquWpIxzJMg/XdpS+u+4tNhI6yYZb8Ly8emS7xZURucbXLEZMHWSboAjE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pxTtXVaqpqj+BPwVlE/5qYUhcj30dqk1OPpbzp+s8RQ=; b=f
 BbFGYpUz7Yut5nBnchvKop0Yu8I/7BipWL4H64JP6hz1C9hyDgk/W4ZxW0S18u1HQx8Mb6uM6OJal
 kBsxhDpNnPam3eb9ky7T3mEnGMe1lseZmg2UL/RQYFA9S03cI04GmGyHS4jvc/zqtCZjik77mFgTw
 V9Ei7GwPHsv2IP+8=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4Drq-00015o-Fy for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 08:41:19 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-484392e3d33so3979360f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 01:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788943272; x=1789548072; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pxTtXVaqpqj+BPwVlE/5qYUhcj30dqk1OPpbzp+s8RQ=;
 b=az6hjzMWeXE3NK8WSAJ0786IxclPZ7HbHedSBzk1HYwEtPjlM51f90IGiEK7Dajyiy
 n7UJOvYvPT1pG7Ui9y+mU6+JE6ejeUlsuQu7Qr1ydxxji9gvux38KD/xSo6TIbXmuNWI
 GOOgMTdpLfdvbC2ZWfntE9wiDwNTbSooUXayo+Gl3hAssvyfoPikYGj3DgPb+q5f5Rue
 p1QSlV+YSSx3jBVNa2cRfUcy32g5byt5mNxYCYslJpM7l3MBDmXAY5skYQXF+5AiOjmA
 snk/Cb2pBj+P8a/7BAxfOm8krttCbbYrB70SVqgjwe1OShhMZBwOVsw7s8nVWdQ4V0WD
 IzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788943272; x=1789548072;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pxTtXVaqpqj+BPwVlE/5qYUhcj30dqk1OPpbzp+s8RQ=;
 b=Fx29zSML5WGlr+CKdF8Atr9/9h2f3Q6tm8YEJUvDB5+vGqpFEm3SpLf9nnqlNLVlo6
 jdU130NFoDZW0p6U8kOp9ET4RH1loVuraw78NJI9UZAWtgXB+GblbTSwE3FGAmbNv8kf
 zztQF7QMgEBc25BDTUmrrBUWJ31L4TXqPTRsvi5CsoyXjq+6LTIAxPuQWYNXFdMjvbUK
 F960VmBFicWwf0PZz57C7Axu1zBbKmer1XmU1w3wZDPWrtF0RSTwH78xwzYpZU1EpeT9
 tSkOgTXaAUfCkKMIBXThCDma9j6VB/Qn0bpC6+DXaIELbQDZ8heuBdL3n1Y5tx0Frb9S
 h/hg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzsPlwETMPeQJISiM2hsO88sS3t+wRXxr2TtyNWWCfb61tqzGMo0FsHeu/mV7fz70D5gTa3Bpe+mKyFYupI@lists.sourceforge.net
X-Gm-Message-State: AFuF++l3VQcdyU7Ho7AOM4U4siitAK67S2pC3wrykzNucJmx9yJXrN/H
 jDpVFzxMKEwUELr+CpUryZHXXErZkuungvb4wC3gUNtF1U3R4BtqP3ebt+c3l6o/E+FyKbEuhRm
 iyT01dzg0GU+zAvPc/XIZb8qxfL6kV+szmh6DFCWuGMM5gEbzS2hSB2LJwISNe/vtdyaAhCgNLn
 OMHc3TWA==
X-Gm-Gg: AYBFou1snGUozD7Lkw1yrnviSu3h/jEN/IbmXW5oLjrIcn9tLOM+BW1rxDcopf1PWU6
 McPprJu0lqfEXUQeAPbT9//3OtGAzxXolac/FFAPGDTPT0LlL5ecycqfWfFXq8n5Ecfr31CY2u1
 qE4k4z/4hGee+yBO85BlsnJX+OeUCiSYoQxR+XqBENCs1BseTo1SIR/+MKjawmuSYbSk623tuBp
 51+PmwM4nSepp0sJIim9DW8m4+tcjZqHiFvrjsrs1utXQDoLA/rorjrr3kDTTCy6IpWgrdMfuTz
 S8C4TSqVxkAvK8rfiULyaWPkfd3CTmEtQnNrI4qRM7OEyWitObwpvYT6kkXBbT40CrM5Y0wyUlK
 dV6y3kwuFMNEbCgwMbe6kgMULpYHnzBm+YUijJMNQR3QMSJzAKpwAQxLgfdrJvwwRJ1PZOe6krg
 yTrA775bhrrAm1GLCKXnUGygo2mpJ1vxFTyYTol9jpJKZsR2rmU3tcICy7wEMDvAqKIT4GZr8SB
 cBCm3n/lqpsPccBeyni3JNyeS398xDhkKIlTsASka1FoqNd0pQuNtOlsSfCNGFQ2kwUd0YJUFV/
 ZBE+7cC9TQ1GMkGdTgV19+c2UD3aB2Mx7FlDA4nE9RJo/GLT/9Bzi6AH9LDQNQ==
X-Received: by 2002:a05:6000:2c05:b0:485:8c17:9771 with SMTP id
 ffacd0b85a97d-4858c179a47mr33872797f8f.51.1788943271817; 
 Wed, 09 Sep 2026 01:41:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588390e30sm40952733f8f.7.2026.09.09.01.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:41:10 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 9 Sep 2026 08:41:10 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: abandon
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6a886a1cac2d4725859dab2325cd362312ddc659
X-Gerrit-Change-Number: 1905
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1905?usp=email>
X-Gerrit-Commit: 83a0276cbe830f8e28fe239cef35a83bb75d1001
In-Reply-To: <gerrit.1788885150000.I6a886a1cac2d4725859dab2325cd362312ddc659@gerrit.openvpn.net>
References: <gerrit.1788885150000.I6a886a1cac2d4725859dab2325cd362312ddc659@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODg1MTUwMDAwLkk2YTg4NmExY2FjMmQ0NzI1ODU5ZGFiMjMyNWNkMzYyMzEyZGRjNjU5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c161d075085dae093aa0c50a0803e1b55853ebb8-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4Drq-00015o-Fy
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: dhcp: Fix
 off-by-one in write_dhcp_search_str() temp buffer guard
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
From: "MaxF \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, razvanc@mailbox.org, gert@greenie.muc.de
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5307446742789642803=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5307446742789642803==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AzBsXkWTZ64="; charset=UTF-8

--AzBsXkWTZ64=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

MaxF has abandoned this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1905?usp=3Demail )

Change subject: dhcp: Fix off-by-one in write_dhcp_s=
earch_str() temp buffer guard
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Abandoned

Already backported
-- 
To view, visit http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1905?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: abandon
Gerrit-Project: openvpn
Gerrit-Branch=
: release/2=2E6
Gerrit-Change-Id: I6a886a1cac2d4725859dab2325cd362312ddc659=

Gerrit-Change-Number: 1905
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@max-=
fillinger=2Enet>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Re=
viewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <ra=
zvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>

--AzBsXkWTZ64=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>MaxF <strong>aban=
doned</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1905?usp=3Demail">View Change</a></p><div style=3D"white-spac=
e:pre-wrap">Abandoned

Already backported</div><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1905?usp=3Demail">change 1905</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1905?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: abandon </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: release/2=2E6 </div>
<div style=3D"display:none"> Gerrit-Change-Id:=
 I6a886a1cac2d4725859dab2325cd362312ddc659 </div>
<div style=3D"display:non=
e"> Gerrit-Change-Number: 1905 </div>
<div style=3D"display:none"> Gerrit-P=
atchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@m=
ax-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--AzBsXkWTZ64=--


--===============5307446742789642803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5307446742789642803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5307446742789642803==--

