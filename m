Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F45CA601D
	for <openvpn-devel@archiver.kernel.org>; Fri,  9 Oct 2026 14:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aH5z7vUmJlx8+IshyBoCT46ySNrO6mfccxYCw/pE5X4=; b=Fpbhx7ADEJ4ObOzkMsPu47RLrt
	5Y0h2ivnCCZ9PpDSBtnYNnJ/vAalGviIQBW3VHKqbtpID4qKWeCgeOBBVi827pAHcuC7TA2PX1qxT
	TUtvPsMRjvSq2ykh3dWw3+f1ewS3hGfDr47S9lWbO86ONdkWveU6plIU2spQrUaw8wmw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xFBw8-0001yH-PE;
	Fri, 09 Oct 2026 14:51:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xFBw8-0001yB-8P
 for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 14:51:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=6j6b8XXZvZISMcrq55wYgL4/uRpNTjFKpJMunDvdHd4=; b=UX2GhEf8i5MS0E2fAM24BYcEet
 lDM6FzO84HvcpCqbT2J4D8iqu7S2vZ8xQF/Eo3oSxLxSJL/dOW1rPwILl5c99E/KaYjqTx+8YRf4V
 Rj5NC/yEbd8NBwC8x6UeS0gXGzRvmuOX6PpA3BxK+N3Y4jiRSvVNmkHpcsAx+ABy1Nt0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6j6b8XXZvZISMcrq55wYgL4/uRpNTjFKpJMunDvdHd4=; b=G
 /GTgwbunPFTRkRwckK0BXfQykpt9GzHVHQioYiV/IYHbnUPkdR+9sEhlIxg/gkSah6T6AGFek/LjP
 pkdQWvUX/UidLEk5jsGMJ65Z7BNVfN5stwzYRkqcuBQgsPigTlGr/w1cL3jycsKWoZj44esgVxATp
 TJ+RH0pLIzBvZLwM=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xFBw7-0001bR-6P for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 14:51:04 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48afe75f055so5846869f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 09 Oct 2026 07:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791557457; x=1792162257; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6j6b8XXZvZISMcrq55wYgL4/uRpNTjFKpJMunDvdHd4=;
 b=ZOhxHG0eBRUqNn8qSWnyKmlH5/O5PCT/VxkQ8QKV9Z7ErAIi80Uqy4rCXb4wMqqDiE
 Z3Hw+vHkcCUTRIDhvb0JAX+V/Z3sQ5b3B0H+2L7eKvvW1rkDkD8+UkY4iGdzgBgZsFXd
 w5n8OME+qhudmS49sccYBDJR2Yp/40yl1JsKlGwISesWATP2ZaenofXBOtGE39VzDsAI
 aqR+L8H8S4iNSUlDZs1F0uYj+n1RjgLt7OgIFIpas/vs74/8kO/TrOq97xoqiNaMBDxy
 HatC2Qv1jNhySWD9MLWpy6Ff1rDBOae7Al6g0AKxrsc8yUaBmTh/j4Q/kVFQR6U9H6mS
 j15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791557457; x=1792162257;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6j6b8XXZvZISMcrq55wYgL4/uRpNTjFKpJMunDvdHd4=;
 b=izboJcRQzhKGiZ2pJwrt52odB0bIFpyBx2t/1zBQw9AyxV1HM5CiPf9efWRwe7PCpF
 aKPOyeAr2e+nFarQY8urRdHIdlPXCbvDMsMHnmlkep9vrqFq96rU/SFiADEUKyx5mot9
 hwa3FdPAv9fMwEO5CiBPMiOboj/ZrnSeqVGlu+yJmmoxxtDSiC0RSxJcKyFIMqi0+cMq
 s73xsvLMAvaK4S282ayLDkkpIXL31HVAztBRU1LjBAm1ujI35Mbh1gNgNSWr6TMTXRF3
 qalN91xcxTjhxv/PlmoLHwsffmRCmGH3e/AMfC/sm5T8Tdu88Yl/28ilERpG8J8oqTIW
 LHMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMgxxBYZQES3VD9Aokuf+6z6h/f5byXADmnXRh/EZ5mYjVTeBSDp4GiBIylzyAn7OjkdK2j6w4cP6QGPkf@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKAF/Na99xw261x12JJsAbsTAlpyv/SZZBl+WiTqImx5L5G3XwW
 LjWVDDTuOwkc5RoFUG+HY5I5fCNgMX+te4wDsx2yYhxPk6AACRqRRI7KqPUL5/2nNYds2K9ovM8
 IuGF4G+m3u6zAHcATz8tyBUZYgsAxv9evr96nM6PRWm4YMyFfc+aIaHyMNHN1J1Vc7z7Yu/P9Hv
 OJ142BLA==
X-Gm-Gg: AYBFou0MziuqmQHGltzxLgCCKz423kzSq18ak3Nz5Qwh5FIM+urqclU3hE/R+jLbNpn
 9SORfQr9rEcEAdgchLda8WH2the+mcxpxsv2ez9Y0J/gw2moTIQcOvObf4/ThcSXiaxXLLl3BPK
 sEANGR0lZ3eDRHgqYSJ3t/T3aSku/7peH2oL32Es4cE+/YDAyAoeMx9WlQK/84RP188T11jy0+H
 W17evGYq+meLC+SfEFZtynDkEtLKcgOTFzCyeF88OtuMQE3nXysiZOFfDs3gY0GewWuJl85zwd6
 JVOwfYK1P4Q4wm/DQooUC1qRR5ItOQabqModOO49B6HESVsXgmiJ7yPepz3MvRbYe85Kxi22WWz
 U34pFzx51JtjF7gOFJBiD1NzuXqiTDmftEkHrQi81enMNy+rcLLLJSI4uafuYSgeASFTpia02Aq
 yYqvdDnzWIiXpf/GJ7lNWBAHnQ/4ZVPJuqXJ+1iFKK+P7N9q0uY295+j5sAiBjSnSQKaa18EhOq
 t0v3v61Sg2AAYqvUet9MUuHqsB9Gziaj5pEankpWTd73OC0enJ8jXFMoYuJc5M5q7IoM3PExXRx
 4VhEjjh/3wF1wEXCONSFN5Qeez9luXipiiwD9DGGbmB5iOozpwY0mKcGH5nx
X-Received: by 2002:a5d:4d8d:0:b0:48a:fcec:2a29 with SMTP id
 ffacd0b85a97d-48dbaadde25mr3118618f8f.20.1791557456369; 
 Fri, 09 Oct 2026 07:50:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9aac57fsm4288967f8f.23.2026.10.09.07.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 07:50:56 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 9 Oct 2026 14:50:54 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I07b373851175d865abdb1513f90655b3fa31d5fa
X-Gerrit-Change-Number: 1882
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1882?usp=email>
X-Gerrit-Commit: 3cf7029e67253a95792cd3d320a1dad53ac4a8e7
X-Gerrit-Comment-Date: Fri, 9 Oct 2026 14:50:54 +0000
In-Reply-To: <gerrit.1787928357000.I07b373851175d865abdb1513f90655b3fa31d5fa@gerrit.openvpn.net>
References: <gerrit.1787928357000.I07b373851175d865abdb1513f90655b3fa31d5fa@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3OTI4MzU3MDAwLkkwN2IzNzM4NTExNzVkODY1YWJkYjE1MTNmOTA2NTViM2ZhMzFkNWZhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5fd2c9398fcbf8b118ae95f10b7955aa7e539901-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xFBw7-0001bR-6P
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_client.sh.in:
 Check whether addresses are in "tentative" state
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7391142385215497601=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7391142385215497601==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TyeaFwPpx/A="; charset=UTF-8

--TyeaFwPpx/A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering, R=C4=83zv=
an Cojocaru=2E

Frank Lichtenheld has posted comments on this change by Fra=
nk Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1882?usp=3De=
mail )

Change subject: t_client=2Esh=2Ein: Check whether addresses are in =
"tentative" state
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 2:

(1 comment)

File tests/t_client=2Esh=2Ein:

https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1882/comment/da21a0dc_9e447718?usp=3Demail=
 :
PS1, Line 277:     done
> good catch=2E [=E2=80=A6]
Done



-- 
To view,=
 visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1882?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: I07b373851175d865abdb1513f90655b=
3fa31d5fa
Gerrit-Change-Number: 1882
Gerrit-PatchSet: 2
Gerrit-Owner: Frank=
 Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-CC: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gert Doering <gert@greenie=2Emu=
c=2Ede>
Gerrit-Comment-Date: Fri, 09 Oct 2026 14:50:54 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Comment-In-Reply-To: Gert Doering <gert@greenie=2Emu=
c=2Ede>

--TyeaFwPpx/A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering, R=C4=83zvan Cojocaru=2E <=
/p>
<p>Frank Lichtenheld has posted comments on this change by Frank Lichte=
nheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1882?u=
sp=3Demail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File tests/t_clien=
t=2Esh=2Ein:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1882/comment/da21a0dc_9e447718?u=
sp=3Demail">Patch Set #1, Line 277:</a> <code style=3D"font-family:monospac=
e,monospace">    done</code></p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">good catch=2E [=E2=80=A6]</bloc=
kquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1882?usp=3Demail">change 1882</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1882?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"di=
splay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I07b37385117=
5d865abdb1513f90655b3fa31d5fa </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 1882 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </=
div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Comment-Date: Fri, 09 Oct 2026 14:50:54 +0000=
 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div st=
yle=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:no=
ne"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
; </div>
<div style=3D"display:none"> Comment-In-Reply-To: Gert Doering &lt=
;gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--TyeaFwPpx/A=--


--===============7391142385215497601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7391142385215497601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7391142385215497601==--

