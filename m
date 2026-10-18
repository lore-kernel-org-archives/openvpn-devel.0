Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03933CCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 08:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZNRDpqwWcyckNdEky7blOe9LexH1/YHfDQBhKUHbtEg=; b=lggr0EZGbMYw43t+XWGBScgMxT
	UjenlOmN3uwJK1GIoMSt9PG8Bh4cqVNCArU+McgWdn7drodzaSAlKodvSgrCHBL4rnhoZp4M2o1Rh
	VI9EwcYIdMeQNYXMdHb/d6RuyRuu/Gd5GTrMxKiyuS9Mxtzyec/SOCmlOBdd6+KjBFLo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIMUq-0003NS-MM;
	Sun, 18 Oct 2026 08:44:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIMUp-0003NE-87
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 08:43:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=nownfcYADDFOKqHaQ8DESSdNUSfpm6iGhSGT7oKUzXw=; b=ig1iDUjO5r0ZugZs1wojC4nrEm
 NLSN9NgOIvwmDIbe9uRNyPQYE6AqLxvFl9TJi/TzDYzo+WL4GiFnNoR9FjHMzGiN8NOcUNdDHO6vn
 mZvY/4nErsCAM1I7Ai4r7CUe90tTCdOoMTe113nKg6v2G6T1aZoXHzp/ee2neyS4qxQo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nownfcYADDFOKqHaQ8DESSdNUSfpm6iGhSGT7oKUzXw=; b=Y
 sffYkfTekA/XIuR78jdwLwNsXtdbI+NG3jbbYrr8N70AFkL4t8YOXvFLIQww1H4+gm4j1cJWRwuJg
 9hoAh5pDRFrTiRARpptWcB+WxDEKxAL3z7gOgsor5gDyA+hmjgFB3tacd4+lNTrlLE6mWr/qcERrQ
 nM7iA6kAnOqBoMyA=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIMUo-0000za-QX for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 08:43:59 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so895229f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 01:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792313032; x=1792917832; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nownfcYADDFOKqHaQ8DESSdNUSfpm6iGhSGT7oKUzXw=;
 b=cmvlq99cFSEQtUIKpPoKMzYo2RhPbLyOfAZWDcpujxNMMaZiDhETRC1mrXU5Tf2inF
 S3DH6TFAFtea1fS6V4DqFHthIibqaB203Mpe9Rs/gjoIynbECvU5ZAiQZJX5ew6wr6YT
 sHx7BaAecy4PMLopiPv7TcemELiX9teXkY5+Mj03if7w60ug56OiCiSu44fxP+YA6sjz
 BBKYV6Q9eeNpDED6oEHbg7HQe41r6/kMwCPfbGIwYfnDmlfEfwBkexkH/02EjfSfpnCA
 iuwORgKL60AO8zmRLNUWpTVtFXVx+XPNiWIPE+//4XlnclROZf4GiI0TCibQlb56IKrs
 eEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792313032; x=1792917832;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nownfcYADDFOKqHaQ8DESSdNUSfpm6iGhSGT7oKUzXw=;
 b=eXGPGmsmwQhHA+FWfbyvHQWrzpBVqIXIRpvVQqubYc9h0+0Cme4/3NmNelvNb5i8zT
 x6AlXV5yznUJThqlNDdm370f6gZvPBYbXmUwNll0j7WPlVbZ9RNxNEALQFRVsUgbWWKP
 7Pm5KgXcKRAFFG1jD2MhFH6Rw8yZpfKp92vg70a/icy8z/vcIepvfPM4ObO06oNxNkET
 /g7207Al0Z0sOGzd/BDAfNFJ11a62vzpG08MmkAvtO8C91FLC87IIHZ7ORVWPV7a4hfz
 YKbY+XLSLG4r+iRPcmlaqJoxH0pzQaigHFOO/ac27pYx4UtiTQC2etXzOT09bndZgW0u
 FqDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzT8ZyprWpxIUttqvcmzExYkjCrb87Ab1IbgCv/Dx3yUKwedJ/7wB37+zYTY/H1c5ipntMCn+QPst3CXNGh@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJ5y/d4SLlqX0/seGjuw9HR5pOcbBRlrBI2C9xwBojBlYWPzQle
 y2RLTZBtw5mpsfB3RA7CKJh8fV3iPcZJ5PlNdgH7qHGUABdXCDbQUJp3dYr97GNGG6km21WVLFB
 9RYM3giea37JrjwPFSpWqER64S6D2N+gUEUPuTJ+2jXX4LN8TmwCb8bQCbj65CoBSMOOACizASA
 RuPUNIRQ==
X-Gm-Gg: AYBFou1U/FcxEuN9m47Gg71Vzfxde/RM/eFNAeGAXyakbGCZeNWQb1JqKghzBVLwdP1
 +Uf3aYKQf6/ovyoaW+FDaYD0nVoBaSSX2b8+p0o7mbGXPxhsjceDXP+QIo6IrAvFNICkLYYGMW5
 OxAxEG/s6l7QLnkNBp7qmEdHp/JR+L+QwDBwmNaRKjZHdM5p0mSdR/sP8alNFY0qA1Cnw1F7IVW
 CeTWSwPy35Wz8sSU52Zwsn3M6Hkx/6MJn9OPa1O7fCpECkk6aTXbkn7e0jn8BwXF9RAomF8uLWW
 zMEQh94Hm8cz2gC1XMv1TcQt8B+qQRuM+jIaSiJZzZSrLurMnyk34AJaX6zj9+XmvdsirS8zE75
 ddxX56hnFVUs9fXjgrsjGp9r7hTCQUYg+X13vYD4LFuQ74kRPwq23HBUR1KRrLMOjhiBYvYhMOD
 oDNl9LEyaVVaT8qiirNH4WrQ8o4L6vmg3yGHEB9H/+klpIrwMnb6bDvdcWbWo60/oGO+cJcklDV
 am5cp5v//HRriDGd1uefJH2xwfe58GE/gNRMmz46k89zNTGOWNy/c5K2yIuENp3ribprs4U2f7A
 STUC1QRXCIVaX8X+PagA4OKMSAO/ji6Z/I8jWyDGjHywq5Od6VF5BaHTaACg0A==
X-Received: by 2002:a05:600c:1da1:b0:4a1:c6fd:4db0 with SMTP id
 5b1f17b1804b1-4a1d76011b2mr93156585e9.19.1792313032227; 
 Sun, 18 Oct 2026 01:43:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8a81587sm358446465e9.1.2026.10.18.01.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 01:43:51 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 08:43:49 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48
X-Gerrit-Change-Number: 1787
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1787?usp=email>
X-Gerrit-Commit: ca9d8ef79982b235df1baaa4b177be855645f092
X-Gerrit-Comment-Date: Sun, 18 Oct 2026 08:43:49 +0000
In-Reply-To: <gerrit.1784067448000.I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48@gerrit.openvpn.net>
References: <gerrit.1784067448000.I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLkk3YzBmZjQ4ZmIwMTlhYzdjMmQxZDk4MWI3YjdlNDU3OGZmNWRjZTQ4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0d60aceb0ea90b1be389a3a13bfc0a2f6eaee7ee-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIMUo-0000za-QX
Subject: [Openvpn-devel] [S] Change in openvpn[master]: push: push
 route-gateway(s) for subnet-pool clients
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
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3443772154831428186=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3443772154831428186==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="j/oWkLUExJg="; charset=UTF-8

--j/oWkLUExJg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering=2E

Antoni=
o Quartulli has posted comments on this change by Antonio Quartulli=2E ( ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1787?usp=3Demail )

Change subject=
: push: push route-gateway(s) for subnet-pool clients
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 6:

(1 comment)

Patchs=
et:

PS5: 
> This bombs in the t_client test with surprising errors [=E2=80=
=A6]
thanks for copy/pasting the error - this was a real issue and it is no=
w fixed=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1787?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7c0ff=
48fb019ac7c2d1d981b7b7e4578ff5dce48
Gerrit-Change-Number: 1787
Gerrit-Patch=
Set: 6
Gerrit-Owner: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Rev=
iewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doer=
ing <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Com=
ment-Date: Sun, 18 Oct 2026 08:43:49 +0000
Gerrit-HasComments: Yes
Gerrit-H=
as-Labels: No
Comment-In-Reply-To: Gert Doering <gert@greenie=2Emuc=2Ede>

--j/oWkLUExJg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering=2E </p>
<p>Antonio Quartul=
li has posted comments on this change by Antonio Quartulli=2E</p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1787?usp=3Demail">View Chang=
e</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1787?tab=3Dcomments&amp;usp=3Demail">Patch Set #5:</a> </p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This=
 bombs in the t_client test with surprising errors [=E2=80=A6]</blockquote>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">thanks for copy/pasting the error - this was a real issue and it is no=
w fixed=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1787?usp=3Demail">change 1787</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1787?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7c0ff48fb019ac7c=
2d1d981b7b7e4578ff5dce48 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1787 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
=
<div style=3D"display:none"> Gerrit-Owner: Antonio Quartulli &lt;antonio@ma=
ndelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 18 Oct 2026=
 08:43:49 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes=
 </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div styl=
e=3D"display:none"> Comment-In-Reply-To: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt; </div>

</body></html>
--j/oWkLUExJg=--


--===============3443772154831428186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3443772154831428186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3443772154831428186==--

