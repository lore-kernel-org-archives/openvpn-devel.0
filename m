Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3126C982DE
	for <openvpn-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XV7TwVvw/H8eUVul7YQQdkYq1SJRm+91AQPV9wTYgOE=; b=MdACDQrc6lPz/VZ/AvspCRAVjb
	yvVtY1BBAI9Rj+ltiJtz2P4FsjVc2vIE/YAQaUiGBZ1FyP0MN148G3gAkfPvkYfhtmwAV1VXm2eFS
	Ifj2xADZ/JlHUUM0QaIZ7LOtNrw6tWsr8eXiuHB+PP25OA678KmB2INjxmdx+NLwxFDM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8axe-0001ds-Cv;
	Mon, 21 Sep 2026 10:09:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x8axS-0001df-QR
 for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 10:09:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=SQzv5w2x0yybsRA2tGawA6pqRRBEI/eSCnWmZXpUaDE=; b=eYfcjWcvyFz3D+M2eDnhqyiFBc
 VdSY3gBwfWHukNiC8A+FTMC1ef2gnR6xBOODdfBMHu8YMrX5MITvgl1nR7IyppmuSsgd5Re0jvULY
 L8WQWnvRYQ3Txwcwxs2R0e5+7012f1acgLTzatwY919d87Hd7v+RA+jCAwi5h3YG7hC8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SQzv5w2x0yybsRA2tGawA6pqRRBEI/eSCnWmZXpUaDE=; b=L
 RTrWFpuxdV5vx3deeN0jc74LRj4OrNsnObJMy1YEQjeUs4jsyrO8PQLmB0yHjZ3S5ta5ETZb+d0LG
 vCsw4g5WNm7UVwxbgjuSn7/zI5DRRK01oMNqnO7gvoJpmrzFYi4AVNr8aunKzQtilKPRSlBwIPUCZ
 HdrMxj4JAzo5hh5c=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8axO-0003bZ-Fp for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 10:09:08 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49e6598dd44so13911105e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 21 Sep 2026 03:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789985340; x=1790590140; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SQzv5w2x0yybsRA2tGawA6pqRRBEI/eSCnWmZXpUaDE=;
 b=As46hD5I/uvoG1rrtKT5DXH1Jg7QjHFtoYu+Bro/DAyhlF6lOBCv7cmR7XRcVOH6ss
 4wx7UWrTu2lWl/5HrmI1l1SbDce5gE/XxB3GNm/NAgqkDOvDGqMb0qu1LjB+XPK57K73
 Kv2k1ahtfzCoE1fLFCK9pXw3Pu7HG+x1kwbcxdOe++7wgUHedCSZw+WNweLLv5JrqQo4
 F+J/edeMaK431PR9bZpROftDHrMrGPfDBax/RqKqDQ7Q8fz3vfhBdZD19JETOx7+sm+Z
 fhJnR00+US8r33bo0Ed9FKoRpjQ2ONFXsDeOhZmIxHAx7mIww9YIs7p8o+FDRnex86Aa
 AKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789985340; x=1790590140;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SQzv5w2x0yybsRA2tGawA6pqRRBEI/eSCnWmZXpUaDE=;
 b=QafssaTA3QXEp5Hh2cQaNwIWCGzcx7OKDpoI91+lIxBYJV7aDhufW7hXNIDsUe6rT+
 3r+QUx2FlgyyeD1ek0hpncqvmYmIfY7SiOstv5Iyrk+gDEOuzo8c8rLdIE/1Sgp4lkhE
 lQxfHGGvSjrVTQnP0PhkKmPubx7t9mbTR14DJGumsa//WYHuVeG1XCoQpHx/TfJ7bvTE
 fFAfmSBnjpRvpGL96xjmk/KtKqJ2h3pnYs+uWivGyX7pFpn0YKhb8hPX9U6VRdgsdQ5x
 Avtpw6LQKKDIPYEWGvGQ6KNKXWcI6tCSkAMARFG9hFKx1q26QRrXhsoBIFrzc4kickHb
 EKrg==
X-Forwarded-Encrypted: i=1;
 AKwUvByXoCDlukzosjngZpPFEySf2SvvmeDyptc3Wzv3nzPnhlPsHkZZVDpGAXZzwV2Re8YU87sjh39KKEsDEaAi@lists.sourceforge.net
X-Gm-Message-State: AFuF++nJDw0g/ny1ME9cDV6O7E4f+HGrNI5C9s/2PGXt4A3mzHuKTvaq
 P/4XD3nRufwpvZjCTLnckk8GISjPvpypTlUnuxAQ2IwuXiQ6+MYLA2g9kQEI6gtZXegmh2onCc7
 bOXfIDvXj1Ju3ygyZIzGD29nWLw5u7JIlN+HZeQV0uLKO32EqCMcjfGp2L6tVuQe+/dTW
X-Gm-Gg: AYBFou3x+FXNC38QQ2dxmW6sefEpfiktBySmLXamSnW1J6WC4RSXpjgeAAi5r8uo/ZJ
 tzfhDpOcU4NUoru6uMZU89XXX0fS4qnQnwOiZ4wQ9UsClybuHXDCQqJ5IBO68dn/qqi5tktQHIe
 i6rJNJR476CTWLi4EZWzuM0Zw/FRLWFacAHGRccbB8MbLfiRl/9WK8BG6mQuo8X0VVXIrzXw8bE
 1uGMiD1urjhe0rL3LtAW0QmDTYMqs12Qmt/Qh4QX5H4dzVit/ohXPZdz84JdLIoFk00LAfyrbss
 E/NuDcjCXc+4L2S2XFhGV6C4MSwgqz9P8K5SJlBlxfMuxmEusO4Lcj9OwDtSUVebi5grEKjz0mw
 2qawrZIIdHsBRBTKgPRWciGsgsHKT95oebyTNeUNnrykVg49U9E4AxhqLuSanOX/vYX2dACrZSw
 nYn0Lhnns9aKBPo7KH+POpHJo24XAxykxBXWaOt9gNCzWJAgiKAZvDm+7irTAfNTQmkcBbi55bb
 02zAnc/Y0juAx0RcmyUJd7TBj8B29/lBIo0CwarVAmga15/ZPVJHf3IxS4Zrz3JsiuLGNriHiqB
 gPm8QsIiQD+xfHAsCOK2JdzkAmLDTGf0JRzDn5kVAb8oGqYGrTWnM40jy41tGt0KWPuxorU=
X-Received: by 2002:a05:600c:3e0b:b0:49b:d03:8d3a with SMTP id
 5b1f17b1804b1-49fc5687115mr128759255e9.11.1789985339812; 
 Mon, 21 Sep 2026 03:08:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcd2f7ef3sm217833225e9.0.2026.09.21.03.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 03:08:58 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 21 Sep 2026 10:08:56 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 18
X-Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
X-Gerrit-Change-Number: 1744
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1744?usp=email>
X-Gerrit-Commit: ea6de1a0f171b515b904ea85a93a9b819798d8c0
X-Gerrit-Comment-Date: Mon, 21 Sep 2026 10:08:56 +0000
In-Reply-To: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
References: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk5MzBkMzc4OWUwMzEzYWEwYzNiYzUxZWU1ZmQxZDEwODM0M2Q1OWYwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b72f4c341512ebdbdfc835d326467a1f5be7a4d9-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x8axO-0003bZ-Fp
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Answer
 SERVER_PROBE on the server (P_CONTROL_OOB_V1)
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4097608162604655057=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4097608162604655057==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FSckQF6zeUo="; charset=UTF-8

--FSckQF6zeUo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

ra=
lf_lici has posted comments on this change by stipa=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1744?usp=3Demail )

Change subject: oob: Answer SER=
VER_PROBE on the server (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 18: Code-Review+1


-- 
To view,=
 visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d1083=
43d59f0
Gerrit-Change-Number: 1744
Gerrit-PatchSet: 18
Gerrit-Owner: stipa =
<lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: flichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attenti=
on: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Mon, 21 Sep 2026 10:=
08:56 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--FSckQF6zeUo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>Patch set 1=
8:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #d4ffd4;">Code-Review +1</span></p><p><a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail">cha=
nge 1744</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1744 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 18 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt=
;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: sti=
pa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Comment-Date: Mon, 21 Sep 2026 10:08:56 +0000 </div>
<div style=3D"display=
:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-H=
as-Labels: Yes </div>

</body></html>
--FSckQF6zeUo=--


--===============4097608162604655057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4097608162604655057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4097608162604655057==--

