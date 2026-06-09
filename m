Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4EFCD8CA4
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8/mbUoym5DDpxifCZX9EjPm/xTMGA0Z/ZGYEEuPLM7w=; b=iItUOBlh+eOz2cXcxoal0Qglht
	tAekmKowioNnlC+UfJ9nzYRvXrpYn1ZvtHuF6UOYWCgDUyia69TP8sgHQs1ENC7+6N8LjeXSkG+Os
	0pHDAQfq4WFnKsjuAzvo7zpp34W8Md2fOcjHu9xuw89U9JHnRyBckILgYWUnXZ+Gkl+o=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWxf8-0007fv-F4;
	Tue, 09 Jun 2026 14:42:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWxf6-0007fc-Ah
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:42:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=PMMqb0ijv70RIcbnJBAoRbmVlEPy+H07R49u4BC+T0E=; b=FN6Kjum5V5c+mW3UXToMzQn5ID
 x2KHY0uHYq/E/mmSwwu6JsfEizl+6BKmuLhnsUigTb8JpUYMSsXg/9NSY74ki0t1aafl2Vy3ec26q
 hXwnPIrAMBlvhJ1vY1/vOE5GFnlkM9+1gZ6n0qwjjv7s0/hlY+5JcAnwCfjk3UGqTeZI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=PMMqb0ijv70RIcbnJBAoRbmVlEPy+H07R49u4BC+T0E=; b=T
 pw/pUkhVVGqNZ/rnJPLyDRzwidjqcAtq76EdcH7u6qK0VzVr4xRODnIUygeiWsaNyvz+z6oD+rXN6
 9rIr6eY5Zkjq3JYV3UmHON0o9ptOI+QAQtFWHU0zf9sKarTdHGDYsc7AbnYwmUZ/GoJMNAkwegTYh
 AuSvJUdOJrq31o1c=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWxf3-0005Vp-P9 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:42:41 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-45ef372c58aso2999261f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 09 Jun 2026 07:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781016145; x=1781620945; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PMMqb0ijv70RIcbnJBAoRbmVlEPy+H07R49u4BC+T0E=;
 b=YPKCDb2qzXRFg+gwwz9M0g5lx4DbDavOiX1Iy+YQHFtjir81L8nLOxrk/cH5eulAUd
 7/nZp5A8xMxdphtI22BKXYGugITQvbqwLV/TfgguBt5wBMMLxgSWQy2KNfqRve30loJY
 ub8WdH+C66JwLS5RK2mbSKlFRZfK415YOhxgH6YkzUWxhuy4TnyFDNJtlTe8p/U+0EF+
 hnfzWJ3MrtEsk479MdhTc7XvbTqVm7tcF4FeyBiBMDzJA58pFWUx01vIFHKGQ6KKTaNK
 /aAOnBEa/GA8gCHgFfXqYYHqq1mxkP0RkwrCOFInuUstlfses1397zow9Na/FpvUFMwk
 LVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781016145; x=1781620945;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PMMqb0ijv70RIcbnJBAoRbmVlEPy+H07R49u4BC+T0E=;
 b=qf9nGJ5OLMRorSggD4JVYXNVaVCgoBqdPsSMT3DgQ/fDnYKbYb8XIBzRfEtiZ/Tyyw
 NqrhfUBNkUevI/rA/fp2zRgLJQfCjSgZVQO3CHtJOqdtQJzDTJ7TI/XUkmZcDaN6e0uo
 L99TyLWEErpqErjpAUVpERxN9A0NNhX1Nmr/bR2RWdhAZEqPJMZIWReQkerXbJOs5uBd
 LaYWvDi/AMpmdwqEFpBF3k6OJs0h5Qr7ZRJykG7FgkUkOkAy2vzrueDLhZa9lU38PucF
 9hiA01HfeFHBLXBeTmDB8jfFMYJptfZs6ES8/Opt2bRjZpNw8Ulft1zvf5bXPM3fflfw
 e/rQ==
X-Gm-Message-State: AOJu0YyxYNuHMKD7GmAVVL+pAVxsMurTNoEFHigeRvtomTOUXoBtzbVe
 knirOwI2mgv6lHPgZSnkVmUMBzjtm+YheAAZoFwprsvWjHORTmejMomsQK9BCeAtmZ74SBFLB4D
 wHkNZxul8o1HRi1R3SbJVK2EDy4eh0SI/v46PTOzXLFW6vAzgyg7KfPcanVYz3a3dCkC2m9IEHa
 n9zLQcTA==
X-Gm-Gg: Acq92OH0TjEteldGTGXKFOBa+mAol7bCj1UjBsAaXVfFwuyyKojVnl/lT/13/MOtMbx
 4QvQFHfxYuabgo1QBmdmj/m+Rvem2EI8vlaPIAI/5H8vlJh+KNcNv2NduT/+2dW2NlZO6hAltXg
 GG+AWYEd0Tvf0Vfigzcw/sx7nIwQtzscSxe+MhYkiWzoQ1FVd9y1IBIqhLcz1PLrEru3DXs6WSH
 R/TpGEU7gZ45dICP5V25nXb18NU/EyXbB+GdxsnMQbiY3u+ljognYQJlnKQhwAdnvPC02aZP3f4
 DN8UGlY3clUUBsWM0QoJogGVWjKIZthf9e1y1PFSbG5Sp6YYe6K5kO+TUAugPL4/HWxNMhI82Zy
 qXxxkJRbijw/vx2FFoxTW6o7LXWRDVAL3j/SJ7pWOPuwz7rZqC2PBPwlqTHBNSrWN9gKyYOlXhD
 gT1uTatAeXt/qA1SZGNBB1FdGCApolc3fd16vYnLXnRxlJz62AUSsvHSJ249b9HHPKt5CLz1fjT
 MoAIv4Z4qvqaClz67QgunlTXZSr5th8I+tNX2B6ot8a8QEWpL3Jwy0CGbTBSjJA+aaOLnG+THSJ
 F5DvSbycCCuwzWgXuIaSb1N4
X-Received: by 2002:a05:600d:8494:10b0:490:c2a3:3304 with SMTP id
 5b1f17b1804b1-490c2a333c7mr206951335e9.35.1781002392034; 
 Tue, 09 Jun 2026 03:53:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3fcf5bsm562887995e9.9.2026.06.09.03.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 03:53:11 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 9 Jun 2026 10:53:10 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2ca8bf90a796f2b757c2fde0ae24468ef3abc3b5
X-Gerrit-Change-Number: 1701
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1701?usp=email>
X-Gerrit-Commit: 8c28f890128eb7beab953a326abf4f0b82ab24e3
X-Gerrit-Comment-Date: Tue, 9 Jun 2026 10:53:10 +0000
In-Reply-To: <gerrit.1779381787000.I2ca8bf90a796f2b757c2fde0ae24468ef3abc3b5@gerrit.openvpn.net>
References: <gerrit.1779381787000.I2ca8bf90a796f2b757c2fde0ae24468ef3abc3b5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MzgxNzg3MDAwLkkyY2E4YmY5MGE3OTZmMmI3NTdjMmZkZTBhZTI0NDY4ZWYzYWJjM2I1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <09a3f08f137362b8cf56133efc24508e8bdf574f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWxf3-0005Vp-P9
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Null-terminate
 tls-crypt client keys when testing
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 max@max-fillinger.net, gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4670299189085810884=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4670299189085810884==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ztyd+w9HZsw="; charset=UTF-8

--Ztyd+w9HZsw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF=2E

plaisthos has posted comment=
s on this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/170=
1?usp=3Demail )

Change subject: Null-terminate tls-crypt client keys when =
testing
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1701?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I2ca8bf90a796f2b757c2fde0ae24468ef3abc3b5
Gerrit-Change-Number: 1701
Ge=
rrit-PatchSet: 1
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Review=
er: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: MaxF <max@max-fillinger=2Enet>
Gerrit-Comment-Da=
te: Tue, 09 Jun 2026 10:53:10 +0000
Gerrit-HasComments: No
Gerrit-Has-Label=
s: Yes

--Ztyd+w9HZsw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF=2E </p>
<p>Patch set 1:<span style=3D"border-rad=
ius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-col=
or: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1701?usp=3Demail">View Change</a></p><ul style=3D"list-=
style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1701?usp=3Demail">change 1701</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1701?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I2ca8bf90a796f2b757c2f=
de0ae24468ef3abc3b5 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1701 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div =
style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@max-fillin=
ger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue,=
 09 Jun 2026 10:53:10 +0000 </div>
<div style=3D"display:none"> Gerrit-HasC=
omments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </di=
v>

</body></html>
--Ztyd+w9HZsw=--


--===============4670299189085810884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4670299189085810884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4670299189085810884==--

