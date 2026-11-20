Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743C6606A6A0
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 21:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=S4o9nZPu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bFg/UI8d;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lNBaFOJr;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GVY9qW45
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=g6uyOQISc5/ik+Dd3NM9oyCS7Psl7jTqoI+T1KI6GJk=; b=S4o9nZPuTgI3dnokuUr7DG2VrC
	NPs1/2j7HzLewAxj5NM1Atv2gEN6hy0L530HhRVn670f4lORuAKY6Nh3Ifu2Yvst7EqvT4UeBdql0
	kJTKRYnnQ+Dw1rHJgBUlzdrMRxyt2KPQVTPiep8MT64UP9GdOiBnBRXrOdGxgN1P+5sY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUWFB-0000000044Q-1Ehc;
	Fri, 20 Nov 2026 21:34:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUWF9-00000000449-1wMe
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 21:34:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PzLVE7TKPm+W05mTbR1p5DCqw/iyg/53md5XPF4cueo=; b=bFg/UI8dQHApjJNCO36ZDVQu/S
 HbdizDtwxBra57dpu9gzq7LVPobqhYTUbH3/Oj0/60FA2C5aQ+5qpD/xBtuChrH99TZN9cVfEq7+O
 aDTyLIozfDNMfEKnhZ5eVD/wnT37+5PM/cCpTcEJTLr9CPmjneU5avSY+TYo+IVq0cLg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PzLVE7TKPm+W05mTbR1p5DCqw/iyg/53md5XPF4cueo=; b=lNBaFOJrR4B3Q1X/GFh0Nqll6A
 cTGvFedjFkfYHwU3izHFVlkoiSaAKfsvFtTwCVctxRt16hXC03sQleJ+4Q/EcfBj8+8Wd2yq1w+YS
 gOv9EJOpG63PNgtbj+bnB/1HByZwKPxJ8/2jDpgneXAsn3uz0U6Sismr30ji4S+cPd4g=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUWF8-000000004PN-3BFF for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 21:34:03 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4a32576da88so822341f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 13:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795210436; x=1795815236; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PzLVE7TKPm+W05mTbR1p5DCqw/iyg/53md5XPF4cueo=;
 b=GVY9qW45HfkPDPTpwvgBdTI/n9dze9RrgpbZqfBES5QggZUcTchCO7zK9hAp9qmpqV
 li/fw1cMV0ke9jrUy6sj7omH9B8LDXlucTBFXqjNfB/WaVNMKz7v0fJY7hTEnZ4Thons
 vDHlHub9yzKbZH4AcyY+btjyrWj9B/ldSNrpYpYQkfzxzhWcVbc91MXjXnufIRxuAWdZ
 wHCK6+P5/nDYy5ljiBtO118W70RBbEIHv9X/Gpp52uPWFc/jONMepIgZpZi2f8OfeDBv
 taUCs56YS97uG20gaWBPwqOJGeb1tTcRqTsvOXB7hosBHl6npVBpoSCj+Zp6Xe1ysB+z
 Gckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795210436; x=1795815236;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PzLVE7TKPm+W05mTbR1p5DCqw/iyg/53md5XPF4cueo=;
 b=P6aXrlcgai+r8glv9ArvIxY0H3bVhY0bTjJfIblVMWuBjbwY1Mvp94ssqsiQPEmxE7
 ymq110WKa/f0viYsXXWk9GmhhHKkXo1hMLSKnwaEfhsRKB9fTTx8IcCqELcyV3VzdWNa
 JLdfav8UunuHXoS2t5XbhBFTBWuB2bH+tZBAYuqXD3oQe/Cc/LGL+5g7QwWywpfMrATU
 Q9BhNRl4THj3d2/xw5KF4LkKxDqalMnDrO5j/m9HVY6dQWAlhQ2IUXgHgEx6RLS8iX2n
 E3pfNDEBbRyV2QNLvSIfMK+V57uG/45KFGHsAT72XtwUgCh+CyJ0qQ9nRbKCeIkiyVI2
 F2Lw==
X-Forwarded-Encrypted: i=1;
 AL+hErFpBwzuVCV/DlQilrzyQ/SoNHOOl/7mkSthXzFWEWOi3jk0YMBw6Uo+EPTdwCR9K7W2V74fjDIskQ3K8mjK@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/X+NilN0V0lv/emoB2P2g4h3/iwYzS8r1tTNBj+T7hAHi796mh
 vOVr7A58p3Zr1aCngyL78ITID900KvJvrGGbRxHhQJsVaIyNz21kA/9iu0lKi/lFWCOON0l5ZeR
 18t9QiCB/yvxw8n6CvcQMBuFwz8k89cAAnbaUVVxt9ppVBMrT9HC4tdA+ojy5ywvjr5Z1KBUR4Y
 ZH7a9zHg==
X-Gm-Gg: AYBFou2dc/rOqw3HSpwkuhsSqTylarBz/SQCGDrjCsx3Y2MHx/oEwKHHSo/hufodUCm
 MefFpzcCwfmCFK1OO3MqdtfmikI2ZqPM4OmMxp17dcxRrAaRDUZ4Q3XUcwfKP7ogzPUPHRYzmN9
 fuozq+7ax6sRrXUt6UtqPYWk6uzgS2pvLbLum2RMyJ0xDN4Uhs1vR1z7T4H5tGTbd93YaKXb+e1
 Vu063cruYtqpaSIuWKDKFIblz0pqydH3IYJqmmKw5pD7sYifbM+K9dW7dEvtAHLtzV4SaWz3yPW
 dcHY72i8FD5n+2EFC4wKmp95UEg+n6axwKjW40To9Dkq7iJ8n98XXaE2YrP9Y2mGGq0C8tJhyhu
 ALHFOsucL6L2YbwZZyp/+aLsfqCaCnPmFdnBZPFyNOE2FjzwuVaUoNU7db6rJDE+Y1jSW9hCloz
 NyARvIcYvAPYtM9wfwovAtnShWNzo1tVdINHZ74Ia5YIU7+iO7LzMooMrsdhAo0EJ649+WMr1se
 tQ7+T0Y4ACPqzr7wRVRlQuNkC92TadfFd53entDh3drcUFcdsipmYUVhIJd57oAAyE06av7t2gl
 SQR0QE8n87IN9JHvGemv6nTYBzdDSBI6ye2WUHJQhD6+Rhr9s+ha0GyNCUvDgnWX6zjzGUXRM1j
 H8ScdBcDPpP7ReM557/wFo/OXTMA6BntN4z3c2VQDP0zwdg+JCKy3WkNkx4GFmkSZua9bHJLn4z
 cNXJPM/tDwxE8u8t4=
X-Received: by 2002:a05:600c:6298:b0:4bb:6375:aa41 with SMTP id
 5b1f17b1804b1-4bb88934652mr95300035e9.27.1795210435971; 
 Fri, 20 Nov 2026 13:33:55 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf630esm7877356f8f.16.2026.11.20.13.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 13:33:55 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 21:33:54 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia359824eea8780805a59d19146740afe3630fa0c
X-Gerrit-Change-Number: 2233
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2233?usp=email>
X-Gerrit-Commit: d3aaef4478dd675f0ee2f65d8aa5ce0805a797b6
X-Gerrit-Comment-Date: Fri, 20 Nov 2026 21:33:54 +0000
In-Reply-To: <gerrit.1795207472000.Ia359824eea8780805a59d19146740afe3630fa0c@gerrit.openvpn.net>
References: <gerrit.1795207472000.Ia359824eea8780805a59d19146740afe3630fa0c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MjA3NDcyMDAwLklhMzU5ODI0ZWVhODc4MDgwNWE1OWQxOTE0Njc0MGFmZTM2MzBmYTBjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9fc4af9cd425026ca6042674bcec7c3b23674edc-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xUWF8-000000004PN-3BFF
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: don't
 use stale data for NRPT exclude rules
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5962803652112820746=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5962803652112820746==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9/PF1Sl0pjE="; charset=UTF-8

--9/PF1Sl0pjE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund=2E

R=C4=83z=
van Cojocaru has posted comments on this change by Heiko Hund=2E ( https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2233?usp=3Demail )

Change subject: open=
vpnserv: don't use stale data for NRPT exclude rules
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2233?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia359824eea8780805a59d19=
146740afe3630fa0c
Gerrit-Change-Number: 2233
Gerrit-PatchSet: 1
Gerrit-Owne=
r: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc=
@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-=
Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: F=
ri, 20 Nov 2026 21:33:54 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Ye=
s

--9/PF1Sl0pjE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund=2E </p>
<p>R=C4=83zvan Cojoc=
aru has posted comments on this change by Heiko Hund=2E</p><p>Patch set 1:<=
span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; pad=
ding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2233?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2233?usp=3Demail">ch=
ange 2233</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2233=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ia359824eea8780805a59d19146740afe3630fa0c </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2233 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hu=
nd &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Comment-Date: Fri, 20 Nov 2026 21:33:54 +0000 </div>
<div style=3D"display=
:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-H=
as-Labels: Yes </div>

</body></html>
--9/PF1Sl0pjE=--


--===============5962803652112820746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5962803652112820746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5962803652112820746==--

