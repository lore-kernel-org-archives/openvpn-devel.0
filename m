Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D17BC624DE
	for <openvpn-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0n+7koUIGm+b2p9GN1x/ZyvZ2rAl9ViY5ybyj/WzdKw=; b=LjgrLhHL5KjTwyOJBpIMyCm4Pn
	WJ5ljC0MET2w6OuqHmwBslw6B48gSNtMVmL4pXaCekJGQV+3XG46lq3EC2nGvVGGaW0qOuXp5ELnn
	DRZVgYc04UBElsenzAiM+EYubXKwQoEhlw4J9QqG2m41FR77cR3NHqUHNn3l6HVpzBbM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2T2s-0002ta-UI;
	Fri, 04 Sep 2026 12:29:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x2T2o-0002sl-3X
 for openvpn-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 12:29:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=PH64DP5lX+x6lK4XbCWMrCHI/EMF4ADHJkRf/m0wD80=; b=fQ4/SD5OqbeoQ78MDVjENEZIUJ
 8IxX++eKnHVRxXWleGsS02c6ic0Xiq9SRZObjplVwJeKwUnDtEucfQ/qnaSlVqUv1jZUZ1ajt8w8V
 fGATb03xiAV1giZigUVutrHx/Gxo0Kgg2aXIZkJr1n4EXWLBj3tONfiSJiPCQmUdGyvA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=PH64DP5lX+x6lK4XbCWMrCHI/EMF4ADHJkRf/m0wD80=; b=V
 lS7fUsI5GRjQz0sWBViJ0/L1VC2z5UQ6AMbPR6dNojxZnpwEkH/rINF4WKVJJlpZs8F8zKxt4p/fW
 BJtop2b2RTk0G0mppV8oYpIJuAlqVAFttVh2IBrIGolsGVY7/qSgdGXW6MKUrbDKDRoClatABslOV
 inZp5tFOWS5Gyh0o=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2T2n-0005T6-NS for openvpn-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 12:29:22 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso14980245e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 04 Sep 2026 05:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788524955; x=1789129755; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PH64DP5lX+x6lK4XbCWMrCHI/EMF4ADHJkRf/m0wD80=;
 b=VqPDWicOB8XvgAGUFOSMO854hqF5otPcCcW1fff4zQdOBagu4TxveH+6uV8sviV5Ez
 fov8JuswPh+OF+P+wpaCUloX3tlOiWNxtR4W4e5Vy4ZfWAFhNbbskCNQIIOurrLZItr5
 zFUuk5UugdEOaClWgIiq1HrvhfGiBVU4CRxDbh8kTP0grSbeIm67nSlEtccLyFk0mkY4
 Ogek0FXT0i6BUxz9SzhtzCDPlguKz66317fDNeDINZP+APf6YtU6vRENXtkAlBHsc3kL
 G+Sl/SQG3voQ/GFfvg322nDOztbx0EFfn4JjgCTy6wlCYq/7/8dYyZSG2ReoS9CnbN2b
 3Kow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788524955; x=1789129755;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PH64DP5lX+x6lK4XbCWMrCHI/EMF4ADHJkRf/m0wD80=;
 b=rJHstTN/LjiaSZUWHbrOFCNFYPJ8kLYGF+rWzMnxtfFUIKtuMpo18MaGPKEqWBbc/l
 GTnjxCd10zm85jXe/k+2TmmiUb0JIxVurXexhg9estPgzhRCM+26ExC0TkDCWduonjGy
 zg4xLBZv10/LyOGDEkwsHJC3i9G8njVQcI/zL2Evx5BtFT1oLgxBm/b3NckXTn7PcFpt
 EeKGzaJXYRadPB0uO0/Yl+3gHp+3uUN2LNOr5Sbaw5fZz+NkSbNrbYw6cM0Evsp3lUUJ
 aZJkch+YuH8I0Y7Vsy8Ww6VHu1VGqCmYRoeWk5fg6UJPmz+MhbJ/coaEwSMUot0Y1otz
 ZCrw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxGDAmkrOkABbuL5u2acQCSuzNiEgGVIwX4tfK35qc8+Vg/a/IdWIFFyx4054YjqjjrWIVBa0sQWPPpVbnz@lists.sourceforge.net
X-Gm-Message-State: AFuF++m4svIG6irBbo+FPgk54iM/hOOicap1T5VxatwKhyuDyikn9vGv
 7u5l8/qwEnqxOmSDLJqEtRyctT/VmI9Q77hhxppRoGMRwu1d4T7EH7bzSkFMZZ6VLrLLpkVgyy/
 N9lA/vFH8aCfheDTEl855stCxU0SBRBx7y214JL5gCLAE5rapAqTT2xCPa8JvYIVxgcii
X-Gm-Gg: AYBFou18wehfh0VV2T4CeQw+fobCE85fCmnPad9A2zWqBY6MsFxYKQcf7oRHenSBPMt
 9KjuxljSDXelAilSOfaA6m0MiqBs+BTNGQ70QnwTRn9e/qxpbVOqVCxKyadwjDiJZ9yQcGuYjhJ
 pNbb0VWaCJyflKkLAx88s7/eDjMacNkNiQ74zQYeg8Cbc8wQR59XkNfzbFtE8vzK2Lz4eioTuX3
 DLisqt3aT1m/qygQf2NlC6VR8kgWd5ghWG1J11F5C1Pn6jhdS7DukRkXHu9d1uNtvnELdcMcQ5w
 5iC4YLlxc1JT+tdVAh8cYy8nolNsvuPYu36lmTLuBs9dt8tgAy8kzTEDBK7cWiYl5To9EIIr1X6
 ZVZvoPuDFjMJdK1yQwi7BV3TPE83zUP3yMzlbUapva0C2gCpld2xFG4NXs1Sel3UINwi0kSqaH/
 iKmQAJ6A1KqdFwUJ3siqZhMHE8piUMWnYJ9DHjZOGM+g+LxohQfD6EIV8DlNfII+BJAxV5zKqpW
 2XGVxQb24j5vq0PJjtkYc4H/j9J3t8n/xx2JDWPezHdQRNvc6GgREHD6pK2OcDxU60G9vuzTO5i
 jvqJakpBcIOOCZEvSNHrQK3Osgw4cdJB1GgqEvkqn43myxiAo8c=
X-Received: by 2002:a05:600c:3105:b0:499:59fd:dbfc with SMTP id
 5b1f17b1804b1-49cf82bea15mr43760855e9.1.1788524954763; 
 Fri, 04 Sep 2026 05:29:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5533ffbsm153648845e9.3.2026.09.04.05.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:29:14 -0700 (PDT)
X-Google-Original-From: "syzzer (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 4 Sep 2026 12:29:12 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic334518048d6ca57a504257e210467f9c451d268
X-Gerrit-Change-Number: 1898
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1898?usp=email>
X-Gerrit-Commit: eda13e5920b005cb50abb11bf776bb8e7cc32fe7
X-Gerrit-Comment-Date: Fri, 4 Sep 2026 12:29:12 +0000
In-Reply-To: <gerrit.1788519683000.Ic334518048d6ca57a504257e210467f9c451d268@gerrit.openvpn.net>
References: <gerrit.1788519683000.Ic334518048d6ca57a504257e210467f9c451d268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NTE5NjgzMDAwLkljMzM0NTE4MDQ4ZDZjYTU3YTUwNDI1N2UyMTA0NjdmOWM0NTFkMjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1e247bd78f3827427bc2ed4bdcfd8e6009b68e10-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x2T2n-0005T6-NS
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Check for null-bytes
 in certificate subjects
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
From: "syzzer \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: steffan@karger.me, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net
Cc: "syzzer \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0622590436824864511=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0622590436824864511==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bL9Dv6295N4="; charset=UTF-8

--bL9Dv6295N4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, plaisthos=2E

syzzer has posted=
 comments on this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1898?usp=3Demail )

Change subject: Check for null-bytes in certificat=
e subjects
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1898?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: Ic334518048d6ca57a504257e210467f9c451d268
Gerrit-Change-Number: 1898=

Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Rev=
iewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: syzzer <stef=
fan@karger=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-At=
tention: MaxF <max@max-fillinger=2Enet>
Gerrit-Comment-Date: Fri, 04 Sep 20=
26 12:29:12 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--bL9Dv6295N4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, plaisthos=2E </p>
<p>Patch set 1:<span style=3D=
"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;bac=
kground-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1898?usp=3Demail">View Change</a></p><ul sty=
le=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1898?usp=3Demail">change 1898</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1898?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic334518048d6=
ca57a504257e210467f9c451d268 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 1898 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: syzzer &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-Comment-Date: Fri, 04 Sep 2026 12:29:12 +0000 </div>
<div sty=
le=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:no=
ne"> Gerrit-Has-Labels: Yes </div>

</body></html>
--bL9Dv6295N4=--


--===============0622590436824864511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0622590436824864511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0622590436824864511==--

