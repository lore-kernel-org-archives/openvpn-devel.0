Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA40C44539
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YScpHbNJqvKuBKHjiPR9IsiKy+vTrtAX/Yt4bG6c60U=; b=Nt6QuhVtffW20dbnwx3Vl0Uy3d
	zUA4qDm+sVrQQwMET3BHE0OXuKBQArOv0Z4wJOkU8pfWtWvrYERqUTShhIvUMr1+12CuJgKNFboxF
	Sl7MQ+46L7upuBsqDxRp92jBDdkKMAP9p2lzVM3S9WFs5W1wDPtND6CIItawzca1D5vM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmX5s-0008PB-1K;
	Wed, 22 Jul 2026 13:34:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmX5p-0008P4-9b
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 13:34:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=YkU6tPiY6xajSFfGJnitOiLwmo5MS05F6IG0dIjMMWE=; b=Tw1v0rZYpeVp3pCQh2PyW/5+S4
 lAGDYyHqcxj0pDBEfDaQFz2uu8sVWkf19U3do1KeHjnnbz613asjre/l4GY6xAWkz4bZJrwR93o29
 GnrlxT+FmltoqDbJkUPSFx1vj5fdqyhyShETd0iEde9LWwc0b52MGySdFQPlMujuJI/E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YkU6tPiY6xajSFfGJnitOiLwmo5MS05F6IG0dIjMMWE=; b=V
 BM55dKtXuyh/pMyUsdJz41BCZoh9rpLDaB28OcShxkt7IGe/W3D0kOh99Qpqj6cz1uE/dBG0A4nt5
 MKC1bHVy3GuQ0BlgT+pGG+iQGEKLQSngun60GV5uaGqcBu+0KLymoTcSk0JemyPOVN3pAA4bFEecg
 zBlS1Bu3xKX+i84k=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmX5o-0007r8-Mt for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 13:34:37 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-47f7027ca11so2816389f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 06:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784727270; x=1785332070; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YkU6tPiY6xajSFfGJnitOiLwmo5MS05F6IG0dIjMMWE=;
 b=gqh/6Y+JIjyWY7qKxTtgED5gk21S/Rhk5wBCpTHkq+jc9iWqONOnLFq0bgtZYBXGi7
 JMs1Pqcc//rKiC6XHkxZpSXolU4V+Jqzj0IFUJM/rvMsQMv6RqWAL60CEVzJ8bahQzu7
 ZJmABQqNT5p9oBZu4VLBbqhDvQrXyHQCE8m3a54N02aWIXq7Z5aeEVIaAz2c/bl32qEs
 T2Bz4NQm5eK7+ZQRdNfUsK8aQvETIEaiNH9f8MwePY3yvYjuj2g8QqpL6gl2IonqRJVR
 VaBShG3WAe/WboGlDJ9RZi2hhmG+pmxtcsDsjfJjoBKk+7m+SRBwVZhzs6cg0qr/eDcA
 2puQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784727270; x=1785332070;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YkU6tPiY6xajSFfGJnitOiLwmo5MS05F6IG0dIjMMWE=;
 b=TdjWAsguQC4gW3AoVTQ5hXsgKUVQneUMPUjizeNp23Z1MAPj6CO6VUJwD+r0wPhcZX
 VWzYwQbie8wBczwLIB9qIbNXyNLJHqaa9Iy26FeXCREzr+dHIoar5V/AM97R0JxhyxH8
 sZWQjWGL/9yZ/QIgC1K3G0+XAux20lGYaWo3L2wa3ErS3uosouUlD7CD4PEfKcH6TBFe
 inOKkIeyxuMPgoHJVVhsu6vbY8YIh5+WT3bnfBh+JfOea6LMyVO3Vm4mB+oP0zhL/yId
 pIhiJpxwanmJr7P6g9uuibepQep3DIEeTA7h3KRo54zx2ONC8MVJyONCQjquFmutuYzQ
 fCeA==
X-Gm-Message-State: AOJu0YwIU/XhVzsSCiSc+Rf/A34bkYDBgAhpFrmzC6/cWJTxlVVxAN4k
 8pOmz+pKySJy5VkBGE3C0xoZQcHJ6O4sAoCC59qEMMNBd6hgMc4Ard7RejOmF/i4JCqqk5jw3qG
 XENE77V6d9Awl2b7MEa1LHbgIEHPTpbVUSTm4XMJmyw2gZnGKSkNqhJuCtgWGB2Gcj1NTb6v1q5
 0a6oQt3Q==
X-Gm-Gg: AR+sD13iTwOKqSAB6DKqSEAacCAAnfiMLlcGm30OWIkMYi5VgnIbguGpl1boN3senh5
 WwwrwP5RjbKspnvwmlvZwYWqJ05rSu38QVpUdRGPYiX25g4drhji7p1GCyzPkMWyIPHr1KozHRH
 Z0rBbgesgv0Frzmq7mS7ZzCy40AVRBeyJxdnBR3pphpx0SFZP7nk1O1sOQ59uXT6s15xP+G67oj
 g7FagG3iWisgYE0sfilQYKITBJWeCFAIkfLLDBkoNHxMKlSP9FMJcGEb8hoKDVoR7wHwkehmu5f
 1apmChWUgoD2TZpDWiN0lWd1LadAWR703jceDnMw506I7ztYCg//7wWio4AEoRVtuXndWl1MbsQ
 SBPccLQANbC9S3uoAYrAnuZYu1iVQLIligYxnTYlWQ20OV9oU9NJCtmJCSCo9dKmkH3N6m2eZ4p
 0iUhUw+G73SvOWxmyZClyFEJmMYiPaIkdEyhVibrXvOG4ktwHkPaOzh0rRBrwloV3MEk9kS4oI8
 9egK6K5dngkTelJ7dJWHzZ3huwIYXrgPfSjD8Q4mn6zTzeNFb0wdocFXc+oljOOjQ3R
X-Received: by 2002:a05:6000:41dc:b0:474:d7a5:4b6d with SMTP id
 ffacd0b85a97d-47f6230d16cmr27750073f8f.21.1784727269863; 
 Wed, 22 Jul 2026 06:34:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a596sm6550388f8f.4.2026.07.22.06.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 06:34:29 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 13:34:28 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I0f56ca69efae0ca376eb9eae064a893c8768188e
X-Gerrit-Change-Number: 1799
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1799?usp=email>
X-Gerrit-Commit: 1ec92ed73b843478ad10411fc63aa76cc3f1b3a8
X-Gerrit-Comment-Date: Wed, 22 Jul 2026 13:34:28 +0000
In-Reply-To: <gerrit.1784718444000.I0f56ca69efae0ca376eb9eae064a893c8768188e@gerrit.openvpn.net>
References: <gerrit.1784718444000.I0f56ca69efae0ca376eb9eae064a893c8768188e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NzE4NDQ0MDAwLkkwZjU2Y2E2OWVmYWUwY2EzNzZlYjllYWUwNjRhODkzYzg3NjgxODhlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <aee2bc3632768a512fe10706e0fae4186fa9e4a6-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmX5o-0007r8-Mt
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Remove --providers
 option for Mbed TLS
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
Content-Type: multipart/mixed; boundary="===============6801684477138068921=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6801684477138068921==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Fn5AH7u48xE="; charset=UTF-8

--Fn5AH7u48xE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF=2E

plaisthos has posted comment=
s on this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/179=
9?usp=3Demail )

Change subject: Remove --providers option for Mbed TLS
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(=
1 comment)

Patchset:

PS1: 
> Not really=2E Mainly, I wanted to remove the=
 option from the --help text because it's not working=2E [=E2=80=A6]
Yes=2E=
 Removing it from the help text only is fine with me=2E



-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1799?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I0f56ca69efae0ca376eb9eae064a893c87681=
88e
Gerrit-Change-Number: 1799
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@m=
ax-fillinger=2Enet>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit=
-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: MaxF <max@max-f=
illinger=2Enet>
Gerrit-Comment-Date: Wed, 22 Jul 2026 13:34:28 +0000
Gerrit=
-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Comment-In-Reply-To: MaxF <max@max-fillinger=2Enet=
>

--Fn5AH7u48xE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF=2E </p>
<p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1799?usp=3Demail">View Change</a></p><p>1 comment:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"=
><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1799?tab=3Dcomments&amp;usp=3Dem=
ail">Patch Set #1:</a> </p><p><blockquote style=3D"border-left: 1px solid #=
aaa; margin: 10px 0; padding: 0 10px;">Not really=2E Mainly, I wanted to re=
move the option from the --help text because it&#39;s not working=2E [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Yes=2E Removing it from the help text only is fine=
 with me=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1799?usp=3Demail">change 1799</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1799?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0f56ca69efae0ca37=
6eb9eae064a893c8768188e </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1799 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<=
div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@gre=
enie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@max-fi=
llinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Wed, 22 Jul 2026 13:34:28 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No =
</div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Comment-In-R=
eply-To: MaxF &lt;max@max-fillinger=2Enet&gt; </div>

</body></html>
--Fn5AH7u48xE=--


--===============6801684477138068921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6801684477138068921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6801684477138068921==--

