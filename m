Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF317C5B572
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 11:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gVlY8mGve6zj4WJjL3ofK0/wQGE1rIzgAlks1/QWA8M=; b=aX+r4ftTpKGwnxmeZofZJEAZnU
	XpOXa2JN421xb5LLN45Cb3yvKb6as1IFc7oB2JDzNRFsrdRnwlW9pyphm+r99ZZyWttW0xmECYoV6
	CoKMns0ThXO3krSkoGvzzA39+sZT+vbYuPH+ako7PVFZrrAE591CZQ47nY89zLoPTtZo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvvMm-0005vT-Vl;
	Mon, 17 Aug 2026 11:18:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvvMl-0005vN-HV
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 11:18:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=jnmf7AJmyGn79QTy3W/b8Sx5fn/+weBhYnhB3XHRDTc=; b=ePBXqbI3rpJJsT+wv5bA3Km+YE
 NwkNBO5sVb1T7vUIv7YAiZoGUrnpdZVQC6ZF425F0RXM2PmVEfuRBRhyuab+7SX0eIYzb+1o3IBAf
 X4miEymCJQ2brG30Az6Eivtpft3gPoGkFYPK4d8GFmSvwFY+2yix6RbDF1+cB0jrMXCY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jnmf7AJmyGn79QTy3W/b8Sx5fn/+weBhYnhB3XHRDTc=; b=P
 jleyMP0kB2hCPkPsy/GFOMWip0dIjhT7V1TodLADETsJLvSVXyHDeTQrBZbd9DgDdW9ijkatD4M//
 y/cYpUJf4EKl4AeArgETVDKeRn/on3caXxxn+zjNYMlwyVVzybGK1VSYpZlkPEU1PkGIjgdbaAS90
 0mE4SpAUf6954jW8=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvvMl-0007ne-Vg for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 11:18:53 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47fecbb7000so1706689f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 04:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786965526; x=1787570326; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jnmf7AJmyGn79QTy3W/b8Sx5fn/+weBhYnhB3XHRDTc=;
 b=ghVHtFU+I2nDGS7cdnpFBXkgEH94mXsZrRYqhKiwaNCP3uyO2BnnQLfSET4KAqDvAX
 RL7hTr3YV0WzBMI0HC80SWOymm9hFpBsvmHj+MK2RiS5xIL/cpeoCrlDUMIp6iVAY7AY
 uhk1wF7bGtwwQUdjvZxL8x8pArST3i6SKiumrcgTqtB7wWP1+RWZuVfjp52oCr+mxkbM
 yFEyadWbWvYn+RloDb3ZdQ6asSkdtvVXGhiy7kt4F5CJQWmhzRRRlqbnMmigykTV4TyY
 /rhzuD+mwJr9XW9k2Q4sLEYGz1wLaGLATQstzgt3WEncAIgs9eMyPRtudyFN+1SreP+b
 qPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786965526; x=1787570326;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jnmf7AJmyGn79QTy3W/b8Sx5fn/+weBhYnhB3XHRDTc=;
 b=rAXGXylUxykrb4iFc9hNKWlSnTFEuVRexWFoaKcu2Zp0COzvNmehnl0sabcp+Iucc+
 g7JLf4jqOJABrlPv6OaLlJ3XPsxwRGdT4wblRQVVOGaYKsbNOTWYw23IaQrfchJHQ5sj
 neDl+KQ3YrQfeZzTCh7zYTL+kO0mRDbvtAmSn0R//9CjoIi9CxSmCSBY6XLRhRN2S3Pc
 gtSFB9T9G1WTR/c+qdtUum5Btag2S9CtYb3RF8ZhO5Fvow3O8HPQZsFVzpBs/2fs20t0
 xEA9e5D6J4n+q247ojYe2GSoXLRKgd7Hpo5EkOJc3lK+kLS2E2BB7VBF/gyuv6XW9V5Z
 4vCA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpxzpKoR/pm5/xdq3A5zp9wVTGCCzQ892hVD2ixBrPU22JbqM6VnQmlMv4jjmMNlhi7ixn9yxfcEnaZgDrx@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxvkfkOHcLQmx4CpVkc9DRfuyY3iHWpMB/mOd+gwJ3RVIxeYt9n
 4F8zPYYSC17YNYA4Qt2wcWMZKNkliiG/vvzqEciKMHSN19U7Xj+DZGrrIz5S1YhGIMF9yN5ZLux
 yg+G7DHOdaKoZNBwsYaWEwVoFKgZ6mR9xQZ+3JrhIlRdwjM6HOiivw9cl2rvBIzFGYmXY
X-Gm-Gg: AR+sD11gbtKRF6BgP5oC9bMSX9at9aluJUnNSutGlEHBtqOnisBxvGEAIgzRSEAvVEV
 zJWvC/UKSDlsLRCHwj+cS+T18FswtUlqHJHShnAsnbeKMEaFTwElPED89v7a3jWr+rFi3zQX2h8
 HqJKvbgVnH8EDAebP6iXc8JXP2xumaQW3tjWQmkF7kiiaAdnhzy2FuDNf+lORXM8L/W6Diz6mH9
 YprYw+VfsKax5Q0dqut6BBj/MzUefX2c6gjy2Yc0+v5ISo8LmfSv89n7ywtPNY+wdazoPm/MbZA
 gtAjsYudlnihx82aJnsSIny6HqYkwKEilzBt+23l45WRV52ldlgpdkaRYWI71BBNSamYwvKy4wO
 N5/uVDa2ML1ZwulTt1/MrdTsnIO//dVW82RNNX87Jh5uRo71EalOfqfSi+h0cwo8oINw8KXXE9E
 C/baw7aXRCcEZ991QHo7dM1NwAWSdRPHncKMA4YlKvT1UpJBBhYwXmJDkv2b4LyPUyOJVzs9bdx
 6LzFdVs/zMh25C/GdEeP0ZGGPCTHf46PF/stkChYdzAG6vwLRYF1f8R0hRsIHcbx5ZDyculnWa3
 bqE7ta/FEQlqFLwKrA2p6KqJc8le2X/pXQOVISBu1u1wOAxDY/+lBkM9hoYrNw==
X-Received: by 2002:a05:600c:5397:b0:493:bb6b:5bb5 with SMTP id
 5b1f17b1804b1-499879857d0mr398727895e9.13.1786965524718; 
 Mon, 17 Aug 2026 04:18:44 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996100082sm189080015e9.2.2026.08.17.04.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 04:18:41 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 11:18:38 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iba7e5e553679ec0cf47cb2e5d9b2fb1859ea767c
X-Gerrit-Change-Number: 1591
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1591?usp=email>
X-Gerrit-Commit: 8298d70b58ce135f7fddbe848a5307c4d65774d2
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 11:18:38 +0000
In-Reply-To: <gerrit.1774451380000.Iba7e5e553679ec0cf47cb2e5d9b2fb1859ea767c@gerrit.openvpn.net>
References: <gerrit.1774451380000.Iba7e5e553679ec0cf47cb2e5d9b2fb1859ea767c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc0NDUxMzgwMDAwLkliYTdlNWU1NTM2NzllYzBjZjQ3Y2IyZTVkOWIyZmIxODU5ZWE3NjdjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7c4929d8933019bc58e3d809d7ab39d5a9e79f86-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvvMl-0007ne-Vg
Subject: [Openvpn-devel] [L] Change in openvpn[master]: m4: Add
 ax_code_coverage
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
Content-Type: multipart/mixed; boundary="===============0266670445298293874=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0266670445298293874==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IBgQods6GQs="; charset=UTF-8

--IBgQods6GQs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1591?usp=3Demail )

Change subject: m4: Add ax_code_c=
overage
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1591?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: Iba7e5e553679ec0cf47cb2e5d9b2fb1859ea767c
Gerrit-Change-Number: 1591
Ge=
rrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc=
 <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date=
: Mon, 17 Aug 2026 11:18:38 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels:=
 Yes

--IBgQods6GQs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1591?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1591?usp=3Demail">change 1591=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1591?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iba7e=
5e553679ec0cf47cb2e5d9b2fb1859ea767c </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1591 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
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
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 17 Aug 2026 11:=
18:38 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--IBgQods6GQs=--


--===============0266670445298293874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0266670445298293874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0266670445298293874==--

