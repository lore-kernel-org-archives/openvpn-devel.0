Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B1BC982CF
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=giBuzJ7vP84EYG1NaplCoNM4bG/3W+HkvusbJM0xxyU=; b=YB0/onmkct5xAQ/ZL5nyAF12CS
	9oPt3r6bk+QQPclRLwngsL7dHLRNqM3jZsaeRRbGIIlvNBknym/l7kSjSR6bAE4ORrW+BacraXqhA
	6RxXtnsLSRIsmVAbZvfxpLLKD3yvd1g/NMswHpn8qUsPdrPsKq9PQoaN1S8J2k0k6Rj4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7BJ9-0005UQ-4u;
	Thu, 17 Sep 2026 12:33:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7BJ6-0005UF-Tt
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 12:33:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=HoS1xdAo98R+leZr85eLXhu0HaR7F4UPyQJ39cGbXoQ=; b=IX7ctGSKFmeCqGj7i9VaHCGVXN
 1yUCoI4WunBcRoTXjCiuC2IrEaPSfkvABbc7u8riT2qSX9NE/uAJ2+MXm/5ahlhk8f4Fi2p4VvGZz
 rWfLQ6VD4a9MupCezOpTKQUNseQSAc2H5B27vGVdps/wEDXNYPXYNvseTNIE1McMJ0rs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HoS1xdAo98R+leZr85eLXhu0HaR7F4UPyQJ39cGbXoQ=; b=c
 wEF7KPAR2pazVjSrsXH0jpKkM1Z0ISLS0r97FUY9TD3/gNjDm5FrEIp3Wp4lbvRYvJtdIK4xU3VBt
 ZeGDRkMCYCeVejMwqF+/cCHRtLMu67LuQA42toU/scj17lcy7430n90Wa0gOvdwBsMmVoixQCq5fH
 w4XdzYGvHkACZ6S0=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7BJ6-00067w-GK for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 12:33:41 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ccfd61ecaso7389045e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 05:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789648414; x=1790253214; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HoS1xdAo98R+leZr85eLXhu0HaR7F4UPyQJ39cGbXoQ=;
 b=fBr0rBNyrHqNpoTVCmOWYqtkle7RWm6lgxi6fMnbHGER2Mi5lWO+9YowDsetUqt9yf
 26STu/9TF/e7rhYrWKg78TC3EHDZEq7PjVZo2MkfrEwhdjvStzDaOmjSrCzTqVs7ZfFU
 hQZgpvfcpQThHyecMWE8rdG92A1uTgAcULc9Na0JP6ioBJIrxyNoKwdEfCfjPCYhA3X+
 ydLsSAEB2raVMxmvkgOmuu5wKqMXniwNKHuHKCY+5QwM/4+HALWIt5OUgdnjT6n50wOw
 TDI+3pbWWG29AdtmKcKh9oc7C9aCI9kRzNATS5+BiuK9NBIFmPWEIKs1mY/EnJLNjjFp
 Ts3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789648414; x=1790253214;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HoS1xdAo98R+leZr85eLXhu0HaR7F4UPyQJ39cGbXoQ=;
 b=TUw1RAZUOvc3cZJW0MKVVHUcEmDZUuAoCnW5Vp8SqHttLUXMBK8w7ytd4V2JxHKg6q
 U/nHeUIVQljEk+CH6BSlv+CQbiwdaHWgE66AGJ+RApakdSq4q9Ceh0DZV5PD/RQlWJfe
 8q92uFcdjdg0Ncn7opRSlFIt9Uud54iLiogFarZuiLhL6zA49et8HHUeF7gwp6XvWXsr
 qjbki/CzWtGNHVcHgSQpI6qeHDpZAYuQoBPeh91awUL+qIt7N79brxXb8gtd2Blb6YYX
 lnRbxP/z6NFrCH9h6dJTJ6h6DgfjCF12RBtClVurnl4iImw/YDMRVY4YLY0KPtp3rojn
 3z1w==
X-Forwarded-Encrypted: i=1;
 AKwUvBytuT2mKjxASuVJlz95gAtnK5nss9hEA0gp6gUeddpggF9+3eVFsfnZ4h/mMzYuN1YjRc1amIEFoOMHjZUM@lists.sourceforge.net
X-Gm-Message-State: AFuF++lADkiL5oHTht0tDkO93u/rRhu6FTsSC3Og5w76pc6vxt1eta+K
 O4BHjbx4jmulkqWkPVK9nVxqnVoL+OHVKVtFgzYme9fA1EcynM8ZTDC9bWhxACneMJQk9HDRM2p
 N3ykFkD88nizDD3n548Tl5tke3owjR22y3gQj866WAWadP74Nx+yyap2F1bmQE9BnTZME
X-Gm-Gg: AYBFou2cj2H+7TJe7q1uxpMnEFqEL7z6Hcu+9Xzr/TfY9l8kNeqMb59/IWJ6lAY0AIY
 bhfGgu8kljBtfXGNeoVFvRAjlRzEZBmN56RRy/ra5o1OmyPa0XoyefhcRq6CTg4fmTh3MhPw65U
 yqRiL29NfCY784nuQTy1B2tKuy/QmumTBFmcmcug+5v2rW8mKewqDVTRROwMjdgw+2S0OioCWgU
 95jY/kIy3wB3/tQsuiKfsCD7sWXYEr0seRXsL4Do5JtUBylW6irQ+UL1XsnaYiWH6uaolu41cMg
 HiWnPCihWg/Cv97iEUM2PRTK4vxzeqpk7PGzm/Sph/arDMj4CuDaeaMxoxPc2FX5Ke2qCYwrsyr
 ih2O9V6+yze2+D6Ez49kvoVva+irqfIMOU7wu3Y9NBMgLBiWwOdclQrR7t5s509UitkTGlZIe+c
 +B2yoJRpU+lw6jFh97cX1oBf/TNtyEyPQOOqTLx83zPFKLKd2COLJWMntooF8e7qk158LxcSgTp
 nDoJvDU5W56E3cMxyjfysJtH1YJgJaW9wpk7QkOHashDqMr/c0xqJUDuno+WGHvUVpZlJQHuK7y
 Io2jSG6s3Nd0asgPRQ24mCFSDsrpaGAK1n+slOEWof63+XvN577hUpkub47Saw==
X-Received: by 2002:a05:600c:8b58:b0:49c:fa21:e749 with SMTP id
 5b1f17b1804b1-49eb733e3b5mr80030755e9.31.1789648413815; 
 Thu, 17 Sep 2026 05:33:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd232d5bsm71580885e9.12.2026.09.17.05.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 05:33:33 -0700 (PDT)
X-Google-Original-From: "syzzer (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 12:33:32 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iea1481e94ba1abe18c39d81cd797187c88427571
X-Gerrit-Change-Number: 1902
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1902?usp=email>
X-Gerrit-Commit: ed00063229719e8056263c1b2fbf05ccf7aaae19
X-Gerrit-Comment-Date: Thu, 17 Sep 2026 12:33:32 +0000
In-Reply-To: <gerrit.1788781350000.Iea1481e94ba1abe18c39d81cd797187c88427571@gerrit.openvpn.net>
References: <gerrit.1788781350000.Iea1481e94ba1abe18c39d81cd797187c88427571@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NzgxMzUwMDAwLkllYTE0ODFlOTRiYTFhYmUxOGMzOWQ4MWNkNzk3MTg3Yzg4NDI3NTcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9f4a484eeb52f6c1a6b819316cd91a94eb12aa7b-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7BJ6-00067w-GK
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.7]: Check for
 null-bytes in certificate subjects
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
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net,
 gert@greenie.muc.de
Cc: "syzzer \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5972215074373065645=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5972215074373065645==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fZA7k0fMI1U="; charset=UTF-8

--fZA7k0fMI1U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, cron2, plaisthos=2E

syzzer has=
 posted comments on this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1902?usp=3Demail )

Change subject: Check for null-bytes in cer=
tificate subjects
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 3: Code-Review+2

(1 comment)

File src/openvpn/ssl_verify_=
openssl=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902/comment/9ac216=
3d_204c3cfd?usp=3Demail :
PS1, Line 389:                            | ASN1_=
STRFLGS_ESC_CTRL);
> I changed the code to escape control characters again=
=2E [=E2=80=A6]
Acknowledged



-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1902?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E7
=
Gerrit-Change-Id: Iea1481e94ba1abe18c39d81cd797187c88427571
Gerrit-Change-N=
umber: 1902
Gerrit-PatchSet: 3
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>=

Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: s=
yzzer <steffan@karger=2Eme>
Gerrit-CC: cron2 <gert@greenie=2Emuc=2Ede>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@=
greenie=2Emuc=2Ede>
Gerrit-Attention: MaxF <max@max-fillinger=2Enet>
Gerrit=
-Comment-Date: Thu, 17 Sep 2026 12:33:32 +0000
Gerrit-HasComments: Yes
Gerr=
it-Has-Labels: Yes
Comment-In-Reply-To: syzzer <steffan@karger=2Eme>
Commen=
t-In-Reply-To: MaxF <max@max-fillinger=2Enet>

--fZA7k0fMI1U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, cron2, plaisthos=2E </p>
<p>Patch set 3:<span s=
tyle=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: =
4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail">View Change</a></p>=
<p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"m=
argin: 0; padding: 0;"><p>File src/openvpn/ssl_verify_openssl=2Ec:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1902/comment/9ac2163d_204c3cfd?usp=3Demail">Patch Set =
#1, Line 389:</a> <code style=3D"font-family:monospace,monospace">         =
                  | ASN1_STRFLGS_ESC_CTRL);</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I change=
d the code to escape control characters again=2E [=E2=80=A6]</blockquote></=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">Acknowledged</p></li></ul></li></ul><p>To view, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail">change 1902</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: re=
lease/2=2E7 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iea1481e9=
4ba1abe18c39d81cd797187c88427571 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1902 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3=
 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-filling=
er=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: syzzer &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: MaxF &lt;max@max-fillinger=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 17 Sep 2026 1=
2:33:32 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes <=
/div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=
=3D"display:none"> Comment-In-Reply-To: syzzer &lt;steffan@karger=2Eme&gt; =
</div>
<div style=3D"display:none"> Comment-In-Reply-To: MaxF &lt;max@max-f=
illinger=2Enet&gt; </div>

</body></html>
--fZA7k0fMI1U=--


--===============5972215074373065645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5972215074373065645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5972215074373065645==--

