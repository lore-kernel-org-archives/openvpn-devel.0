Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95613CCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OQY/12LGrVZLuQCtJZ68ZrqFot/5Ch94lEdP5sMyetk=; b=TLb1PigozMLilELNhcdwpUtPN+
	A7BCJ8aNwGPmPWA42YMEvDeeif+H4GxQHNzECImu3lq3BOU6TSlTQ7Vk0N50ZByVerFhtWJaw1hs9
	ux51usjP1EDLObFTbu9dho9hToquA/q4vAEWa9uzeLyWUP3GA4SQqHlnpwYaZPba5mx0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xI9st-0002SW-TX;
	Sat, 17 Oct 2026 19:15:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xI9st-0002SP-6K
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 19:15:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=TXGMpXrdsNbWryYS2FTJG6+HChrSDP9EGvj3Bu02tH4=; b=Tsc1DCQp5v2a0k9fFEFUYnfbPU
 9qUnj06dKI2iA/K5kGIkjAm/qxNnyII0hhqm1yiGye/OEZj0KYM7ygfyWVLhasgg+5sH17TPu1jnk
 Hr243Er224dY8isnadSM7yHQDlEJNKkTsB5fC/O6mJmZHFK0JhitTYEyQFM96lA/ieaY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=TXGMpXrdsNbWryYS2FTJG6+HChrSDP9EGvj3Bu02tH4=; b=U
 8vFJ5bsBAWwHDOqD1w559NP+lP0IYr9/NB9VqfZNMRva872Do9nn8Vazf5gw3uL/2Wn67EBeQSID6
 qGqZbkgtNHAPfsEdX2cEyZ+8wfQ+DfFd8OcdcnPL9xtiQDOV2UgBluMpe/iSMUUS7ln//eYvqKutJ
 kRICn2yevCmqaUnA=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xI9ss-0000vy-KM for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 19:15:59 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a1698ea378so6807985e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 12:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792264552; x=1792869352; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TXGMpXrdsNbWryYS2FTJG6+HChrSDP9EGvj3Bu02tH4=;
 b=OHg69QK0GnT3gHC5vBHbSGm32Gt7vGMD8WX0GfSfuR148cfBkkbXpcZJ6moonv1a+k
 hQhdYkXXD0ZTRDCaouiVFABmpR8HWokUE8cUmYP0kbzcRds7LuRK1/VMo1fdEGqwjKNT
 rzoNEvnRhkkrDD54Y9Tk1l6IwatPzX8505+T7TuQg4AnbwxkxwnCMC0+0WDFHzP3r2ga
 Alp2YGY5QDj1N++HDoMG84MlNeWKjQJ58qJDX6tpGdtPNh9eiCnftVGBnVWNL8IgcCYE
 UTfmQdhqStpooc7ZLn5fWXR0xIaBopff7w4z83uB6CnocNxbbBlTp23xIVMlbHLwKQgz
 kefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792264552; x=1792869352;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TXGMpXrdsNbWryYS2FTJG6+HChrSDP9EGvj3Bu02tH4=;
 b=o1aGai1GcR1VK/0j4PwhnVpp2I6xVIKSmbtXJBDJK+ObndFnY1eK2MwZnSeyIFPSRB
 VsCblu1RBdPAJVWAeEDD5va64e4DS9l6Jk+6XUzIDI3eS3tNSpp3r35N1ACxnahy9eKn
 S7KFl5feLTCn5lpcfMnBTn5IXAvKYsbDKmU5YzargJbToIlElTlosSF3nVIqhcynSvl5
 Vj0M0ifI+XMPEHvE0lhJ7OsD5yvdnRhXC5MI5lcQh9LHkNRqVJ14RlN1v6ZVfJKOYwN9
 jVmjU1BpmfrZPHJjcWFP9nf1ISu37rkMJd52EJqtv4n/ysAbcKwb5NOVoBHBADa07EFC
 sl3Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgzt+tX6CSjfB6btDyvI9du6YN6pNRE56Q2nh5EDHB1TD7Vs3VvOzPpo0XlpDc9o9Aw10tM3zWg523rDHV@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKTXtZqQVG0kI9sdDAVOeHERt7JP4n6AQJa6fe6UWjdbj0TabPt
 H74NRPMIDHfQZTTT9i8bL1WYcvQ66ANhhsgdp31JdTK/NyS9x+KM6zLOeVc5by+36+La8+Hf360
 CAZE1Yo+C6XhKMqlkRhFIBtOyRCtW60m0ouIjYlHL+YmgbE4W0FaOeQpordAcBAsZ7kO8
X-Gm-Gg: AYBFou3JSuFdCNOr8wZPzG4v1boHufNfykmJO+B7fwUr7dnwXZji/gxH/DotQq/ay2Z
 CaFHIvCiZtBUjsVosjHbQZszGoq3EwwZQvPKeBpbvKg/u4QcE6JRJTwt1Pe2erLipaWfy/PzCz+
 bV75SKZxAyoH9gysqNgMglR57X6DW20OK66tYPKFo/lsL5HOSQY9W7me+a7NuGqkDAI0y6K5Ljl
 I84yr3OrPBH25LuahuAubxS3ZnUayeVktMoe/nOM7oYrmxxKZ/q/ELTyZJ9WMxtdP2nGqsBsWzO
 6AvhpwL6VdV/8odOvmP7ac6SwElvSm8ctpMDCs9kbbDNI/9jwB4M6IUNBhbHXh8U1n9xZWG6k23
 CPkeSv6QnlAgdbSfBcpyOULoj6S73t7rI3ZCW9fG4kU8Ay+FpWz4Tn7cWUcu/e1Q2UVEmX1t6eY
 RzkWpDv80nbfUG0vF3R4cJZTENMWU8nr9DeEZUhREs7I6qXrjA3bTQKJH8Cxf6sRprnOBVyN4g0
 EnBtNqlk0A4ggyehgAbwNp8OD2b6TTmlAds9GCcOuDT+lw9FKyj74qDNCl/mzjmza4VILMPLHRV
 tuwMibzA3D09E29jDLz1dnMiAet+41E8v6WKCv+ggtuajM9+Hag6Bemo69fv7HSgxO1o9Sw=
X-Received: by 2002:a05:600c:1da1:b0:4a1:ac66:6059 with SMTP id
 5b1f17b1804b1-4a1d7614eefmr68264635e9.26.1792264551981; 
 Sat, 17 Oct 2026 12:15:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8a9ea3bsm112595285e9.0.2026.10.17.12.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 12:15:51 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 19:15:49 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I7c54aba5ce771fc4a10e4efde7d14721cbcd7bc1
X-Gerrit-Change-Number: 2006
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2006?usp=email>
X-Gerrit-Commit: 57d2a152f6e2206e41471deb040580e6f27fe1d3
X-Gerrit-Comment-Date: Sat, 17 Oct 2026 19:15:49 +0000
In-Reply-To: <gerrit.1792255622000.I7c54aba5ce771fc4a10e4efde7d14721cbcd7bc1@gerrit.openvpn.net>
References: <gerrit.1792255622000.I7c54aba5ce771fc4a10e4efde7d14721cbcd7bc1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU1NjIyMDAwLkk3YzU0YWJhNWNlNzcxZmM0YTEwZTRlZmRlN2QxNDcyMWNiY2Q3YmMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3a16712e14a43fa38dca508fdf22202953ed1cee-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xI9ss-0000vy-KM
Subject: [Openvpn-devel] [S] Change in openvpn[master]: crypto_openssl:
 Avoid conversion warning in hmac_ctx_size (1.1.1 vari...
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1817296463919763155=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1817296463919763155==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Zzs8LyIUyds="; charset=UTF-8

--Zzs8LyIUyds=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2006?usp=3Demail )

Change=
 subject: crypto_openssl: Avoid conversion warning in hmac_ctx_size (1=2E1=
=2E1 variant)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 1: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2006?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I7c54aba5ce771fc4a10e4efde7d14721cbcd7bc1
Gerrit-Change-Number:=
 2006
Gerrit-PatchSet: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Comment-Date: Sat, 17 Oct 2026 19:15:49 +0000
Gerr=
it-HasComments: No
Gerrit-Has-Labels: Yes

--Zzs8LyIUyds=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2006?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2006?usp=
=3Demail">change 2006</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2006?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I7c54aba5ce771fc4a10e4efde7d14721cbcd7bc1 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2006 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Sat, 17 Oct 2026 19:15:49 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--Zzs8LyIUyds=--


--===============1817296463919763155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1817296463919763155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1817296463919763155==--

