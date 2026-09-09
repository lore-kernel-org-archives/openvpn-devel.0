Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2590C79FB6
	for <openvpn-devel@archiver.kernel.org>; Wed,  9 Sep 2026 16:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OnVlXascx0VhOCo6sqVkl5tUsW4Em6aWi4u+msivkM0=; b=em/pDyQ4mAfhdyvwhmFLLAW5VL
	Oo59zr0LMkusYO9XO7MrNA9jek9ijfaywuVEESAt+23KQTtVtHk3z7FtR8jXBme6Y1w1IWSmzR4VG
	a5fmRXMLE3g6/gqkbYt/L8pFrAacbbsgW8XYo5s/y+EPb1Wc8GweTTzvTt7ULe+42n9I=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4Lad-00044S-9M;
	Wed, 09 Sep 2026 16:56:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4Lab-00042h-TZ
 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 16:56:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=UIbWFyZWT+ViTanyHio1qa+f2xUq/z82/rNPNvj4ctQ=; b=nHQoTjGuuIEpOvcKxP+VeMdrqP
 HxA8wQwRWoYrvN49Vw5TYBVGRmyqRCktP2ZQYSyrQ9tivL4opyQWKGxCjcpo1WbdzQBSnak9yzb81
 A7WJY7arPYBD+sBnR3U0iTdinrCS5MLs3nlRS3GYXVd6wRd1Byv2WJjus22gLh8N/tGM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UIbWFyZWT+ViTanyHio1qa+f2xUq/z82/rNPNvj4ctQ=; b=a
 0ALmHvq1z5PLG5rUjydhpO6GLMJYhAwoQ03zLKu/Pij3ITKacQsobFqrQlI7szx0ogxNz/0e4bdw8
 Ts4o7URNgZvzW9po+vFteWzO2BIISpJFmfFy7QfwaZN1dvVF4mkclPo5OLuctlvnB8++AU8J/Tl+V
 MU21B98240jYORa0=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4LaB-0000uH-0Y for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 16:55:35 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49d097b4939so2737215e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 09:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788972928; x=1789577728; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UIbWFyZWT+ViTanyHio1qa+f2xUq/z82/rNPNvj4ctQ=;
 b=Ws73szW46wVTa1+4p6pCJatt96cLTlhEmh5EqFUsVYqBlHWqUrbz+AI2UE+5H2ZKhZ
 j5PxQrKPQ6b3ZZIj6jQpmv1rHpunWsb0JFENFsMYaE2HPFpCEoiPW2i6L/AnVaPlm2WI
 nKldGBDy+cvtjGPiicPkJutt8cLFaePh2X02eFEW6hxo2lvwpyQFNiYw19Sm1QLPMuAx
 kQZGrFQ2206yvNuCLkKzxpwi+efFtMsvNf7bN55fSiY7tERQ8TfSzlvov9TbayJmyqM2
 HTKdwvocpDA/WlekBlA0rTcb8OSeH1U2ERLxfvf5GetIWFl8TTettseVseXeXxCIH4X4
 VdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788972928; x=1789577728;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UIbWFyZWT+ViTanyHio1qa+f2xUq/z82/rNPNvj4ctQ=;
 b=m7Gq9UXmMOELBS20kx57GAI5Gx/3JP+yNa+ui7X8k9TBZe4vABSwOOKCKeZfoJIBCh
 S5MHavxIKItnp0Z+q01pvb+W8TOIfDkfQmGmPFsbOboEtzt4eXW/4G6SrVuGjViUmn8b
 nkz7cnhSb7t7AWaAHLgvERbd+cILxiKYT4K9uRRx8GlYUJkdUWMOtgcO46+GIQ+kiudB
 IbWhsiHyjTJWhiupjLNJbENvm+eb1W/RXZRueW0DSxgB1NDZEYgR7bRJw30xQBuyxQ4a
 1CV5FgHoyzKRlML00gM6CHusuzy0YJ+cPhAwJp+4acg6nBZffM9Vtf62rTQVe8Q4h2iB
 9pKg==
X-Gm-Message-State: AFuF++lLItJlvfXPWvwGycW6A1FewDz4NBO1nIFAQjUXkJbdIKaxTv12
 RccZQhCDWJlAc6FKb2jd6xE659ZIXSVofmo0mYlsh5J541BBhdSFBj+QyzoWytDlY8wfbPuty6H
 AWEDiZvdje0/6VPFc8jsoShnDyWGHWwspGt9MylKLIJZP6WeeE0bRF79yUrGQB5CncoKT
X-Gm-Gg: AYBFou1+YAgj/IBjifd5mIhEhrW+Rj0uYUXNKleydlRVusfQX8B8MIYjHuD43vCqLm1
 8xBstk/H41c2xTatnlSwGtidp3nZu67kZL/nKh7CMsMiIJmNpAvV2XrNWy+fyYbfRRhUbQIeQ3C
 WzvcRNr06q4PwtmxpRfchzCnGD0syqww7G9T9d3lcSiNAZLYwNZEk6cNpcBaR5gkOzprrGVIHME
 nSbJ01XL1pyELnIC3lmcsh+3JvIfJA+DPkuSpct3XpqZAHDwN4MSWjkFdAAnbK3z3trIYOY2dDA
 NWoQMAEd1db1Rq/qnPzPbdSqRVD2MjnJCK2klrusCiBkHvy2Z0TbJb4BIiEDUlJ2d5xo6CzQiDF
 PCwfuDD/jY42tSmcO7v6t9vbdj9dse0z08gcIeAGgWYvDUNuHlqJyd87lpg4xCWGZw1y8P/vV/g
 EZaUBhIyaXDYmBB7Rn3saG8VTGSmJnGttN0ZastZj+AbyYimjKs+vL086vQMXjlJ7KUFA1L13/S
 BL+d6Q8bwclY5LRBfDenD5pMzNuiICZQ391dUL4H42aukRxNUJ2Rs28zg5TpCynnt6ma0SkHLgq
 gqOZKx8yE0WQcCY87OpX3mrKeJUds4Dq+hLcg/kFWYmccseH5iHqxCrhEwp1DA==
X-Received: by 2002:a05:600d:101:b0:49c:fa21:e73f with SMTP id
 5b1f17b1804b1-49d2590a99emr14360965e9.21.1788972928246; 
 Wed, 09 Sep 2026 09:55:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c494basm3100985e9.12.2026.09.09.09.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 09:55:27 -0700 (PDT)
X-Google-Original-From: "d12fk (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 9 Sep 2026 16:55:27 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: deleteVote
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182
X-Gerrit-Change-Number: 1907
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1907?usp=email>
X-Gerrit-Commit: a453210da741209545b1b6d026a6487151789341
In-Reply-To: <gerrit.1788885240000.Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182@gerrit.openvpn.net>
References: <gerrit.1788885240000.Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODg1MjQwMDAwLkljOTgzYTNiZjFlZThkNGVmOThmMzg4M2Q1ZTVkZGYyMzQ2OTZhMTgyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c2b9c585d06ce63ac38e2df8f0f94f64d800663b-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4LaB-0000uH-0Y
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
Content-Type: multipart/mixed; boundary="===============4072334197440810108=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4072334197440810108==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Dpo+9OlrNsU="; charset=UTF-8

--Dpo+9OlrNsU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, cron2, plaisthos, razvanc=2E

d=
12fk has removed a vote from this change=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1907?usp=3Demail )


Change subject: openvpnserv: harden Check=
ConfigPath() a bit more
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Removed Code-Review+2 by d12fk <heiko@openvpn=2Enet>
-- 
To vie=
w, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1907?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: deleteVote
Gerrit-Project: op=
envpn
Gerrit-Branch: release/2=2E6
Gerrit-Change-Id: Ic983a3bf1ee8d4ef98f38=
83d5e5ddf234696a182
Gerrit-Change-Number: 1907
Gerrit-PatchSet: 3
Gerrit-Ow=
ner: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer: cron2 <gert@greenie=2E=
muc=2Ede>
Gerrit-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: pla=
isthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailb=
ox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention=
: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: razvanc <razvanc@mailbo=
x=2Eorg>
Gerrit-Attention: MaxF <max@max-fillinger=2Enet>

--Dpo+9OlrNsU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, cron2, plaisthos, razvanc=2E </p>
<p>d12fk <str=
ong>removed a vote</strong> from this change=2E</p><p><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1907?usp=3Demail">View Change</a></p><div s=
tyle=3D"white-space:pre-wrap">Removed Code-Review+2 by d12fk &lt;heiko@open=
vpn=2Enet&gt;</div><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1907?usp=3Demail">change 1907</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1907?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: deleteVote </div>
<div style=3D"display:none"> Gerrit-Project: op=
envpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2=2E6 </di=
v>
<div style=3D"display:none"> Gerrit-Change-Id: Ic983a3bf1ee8d4ef98f3883d=
5e5ddf234696a182 </div>
<div style=3D"display:none"> Gerrit-Change-Number: =
1907 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2E=
muc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt=
;heiko@openvpn=2Enet&gt; </div>
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
ay:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@=
max-fillinger=2Enet&gt; </div>

</body></html>
--Dpo+9OlrNsU=--


--===============4072334197440810108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4072334197440810108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4072334197440810108==--

