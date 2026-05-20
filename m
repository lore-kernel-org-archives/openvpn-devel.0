Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A00CD4F3D
	for <openvpn-devel@archiver.kernel.org>; Wed, 20 May 2026 16:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:Date:From:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IL91SHTvxtDi9J15Ym4QmDJerBEFHDhgsjtHEUzGSvM=; b=CoNkUIrueK5HlLaV73KvkBXLKn
	IM5DAmE/LEO6eRBm7NSjBF95KbF+ScbRaZD3T4Hk1cerhp0Kb+9ty3UkvjSO4iVHV05anFSPm/gO/
	911CYSZD/1qJKr7od/jBIBGndHUG8qtTmN6g85QEXjMfH9dMXq9WBEF8wdAP2EJUX8bY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wPjd0-0007bV-JM;
	Wed, 20 May 2026 16:18:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wPjcz-0007bK-HK
 for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 16:18:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=3CYN9sYumjgbcYbq6F2RCmNhR2dXPJigni5FrdcT/Xc=; b=H9LfDo1utHTgiRzLfKd2lfqFcU
 1Ihc87TaohGX7EbhK50kYPXfrKO2KZcnNEsQXRd02Q+HTrCi5QgV4HPsBYH2d8KhPoXayNbYnKtq2
 hskhM/5OnK6cxVV7oqeYDCioPaqg51qY3nSF65btiFi+BmhvG1gpnDgwcLJDs0CG60W8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3CYN9sYumjgbcYbq6F2RCmNhR2dXPJigni5FrdcT/Xc=; b=e
 za0hABvYPTdF1TA7Ns6VbvdpR8ayMK9ZA6IEP54i+v92hANEsDBp/ZVyCs18+ajXpM7l+EIlzqgCu
 3GJbUptDhXuwSF1zFsi3SOKjRPFVOddUyuh8CYswT47FF+40mKs5hz3A7J5DrOXQKHytiRCF5Cj2A
 vSM5lmtGoRpBS4d8=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wPjcy-00089D-0Y for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 16:18:38 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-48e8132c6d0so33988065e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 20 May 2026 09:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779293905; x=1779898705; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3CYN9sYumjgbcYbq6F2RCmNhR2dXPJigni5FrdcT/Xc=;
 b=YAfbfLnKHWhuW2F39Jg4DH3c1gDjZF0Spv756rJjM2xnGNBR4LmyyQbWtKUwHT9KKh
 Hpc6wohKO2MUdUYZDfCO1/EGZ9MYHuUPmum28B1fEVKNeV5ewAJrLRV0At5/s0nmPKvS
 706vB+GBQBp5utKmz4BTYO+aUbrtZB0kaCgsN10zS9KV8WoZwT9o+J1AvTR/IMnowxrU
 rJacmEhwocFb/a0cxJsz0gVDJ4RSvJ3gnj3N0DD8CAlKNZMAUJYQDky3qy/GitFXvEg4
 85rYo6jq/+Oazw3NorMhV3fWqpg3Cdl0nmwLBovrCY+IpUlQhPr7zmhmxb6Vk1+YWcyf
 Sumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779293905; x=1779898705;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3CYN9sYumjgbcYbq6F2RCmNhR2dXPJigni5FrdcT/Xc=;
 b=n1PL6AAorT3fVRVtPIYfspQqXX+wHzmrUELjBPja2D03yaQE/NMJGcW9fvtHh9MNhJ
 6czOmAogYcMytkGZ2mfACndhbKxUfA5ru73IIJQ/UV+yLr2w/XUwpgxBtAhB+4ATxsI2
 JgqfPBDxClTD1nj5iEaMKWj7HGpE68gdsRdtyq1Ti34xlO735RZTbzKxwQp20PO7v0KA
 tdzlSf9hyILjn9AA8Vu8H6luUy0nONAHUhWH60L7kxeYG0OkVO+S4bpfv82cTsJj1pPO
 w65iKYewBouObhw+NgJVe9Fb6PQg6TMbGPns37S4SdnUl+g6Kcauv8dv3j9SgjWPVBtS
 DleA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8OXE+4rjiFPPi/qRsVZ+9zVSGkoxNrkyxDbI8nV439oAoInK9vh3ZK4fCKl+jn/SIwGkUuMspw3MESaU8o@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy41BB4xx5fT1a/mzSTupNlim1suxOcLbGPmo3wurMBViH/kcov
 kNHz0t66gfopC3wde1gNEudqT1eXfoG2GwhleMNkeuu4wTZIVULr3fJuAe+0La0amMoMtByKVG3
 B4+1QFyvYG3pwS44hvzPXn25vd2X/2kKkLGRoCNAOcb2AROSleHiWc+kcDgqWzOvllOx90/RTT5
 jIX464Hg==
X-Gm-Gg: Acq92OFWvu8oXsO2X8IjADZNr3S4LPzOs2aFE46IiJ8HX129RXk0kF041A0O2dOrAra
 JH0OHnnIEqIfrL3/2XzNIMHLH3oC3pau5iZpQwg/lI/+XKc/oYxJJPXOua2nZjRZy7kvCT/qJUD
 eGqzAtxzonHW8mCCXGH5YGFHES09SY24I5kW4b6hhPgGfwmtYpQYUeIVKH0ab4AiPGvTX+pG9EI
 11BsgX+2IL+16waHYQs/IW7GFTrXCGD4eLT8yW9JMRt0gK5AvBilD1izDvZ3MU++iHQYxzXT6w0
 Dcej32MLqHAymVH7zEWuUkTlQuJLaHV+hpSuadP5TcW99sEW7SDO6z4y4CsAT58XfgmTVwmdajW
 yqFzuWr3K4ipzJE4dqvhasB7kzxEQSw/eDkvdpHYQ6dlMsucu9hIfv9ekldlej0BjgDb1PmvGFe
 gqq7KnykqGXWGVyOOv4vD7lQ80auSOqr9EsVi8j87oCyfqT8bAf7vI0T4QUyU5fqbb9gi6u6q+6
 6fgn9ekSPFPZBZ/LJrMzFBrAOTfBWzavKx3M2wm3Xk6pNnvpGfvQgOBAWQwdrW//BUvEcfcnd6D
 ko3ojcPk57PqCO4cQuBo7ROy
X-Received: by 2002:a05:600c:34c7:b0:48a:54fd:54ea with SMTP id
 5b1f17b1804b1-48fe60ecd93mr381419375e9.12.1779293904680; 
 Wed, 20 May 2026 09:18:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a5653sm55173120f8f.35.2026.05.20.09.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 09:18:24 -0700 (PDT)
From: "plaisthos (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 20 May 2026 16:18:20 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I70560efd113308b7377424127eb2c1da4266371a
X-Gerrit-Change-Number: 1679
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1679?usp=email>
X-Gerrit-Commit: 96d7c0ec791afbd3c412969bab407ac1a37314df
X-Gerrit-Comment-Date: Wed, 20 May 2026 16:18:20 +0000
In-Reply-To: <gerrit.1778963232000.I70560efd113308b7377424127eb2c1da4266371a@gerrit.openvpn.net>
References: <gerrit.1778963232000.I70560efd113308b7377424127eb2c1da4266371a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4OTYzMjMyMDAwLkk3MDU2MGVmZDExMzMwOGI3Mzc3NDI0MTI3ZWIyYzFkYTQyNjYzNzFhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e688182029ceea88afd13b725f86b6f83d078f46-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wPjcy-00089D-0Y
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Replace strtok with
 strtok_r
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2038490870525362917=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2038490870525362917==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ktspCFl/CJ0="; charset=UTF-8

--ktspCFl/CJ0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1679?usp=3Demail )

Change subject: Replace strtok with strtok_r
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5:=


(1 comment)

File src/openvpn/options_util=2Ec:

http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1679/comment/be9f75b1_d2478461?usp=3Demail :
PS4, Line 5=
1:         char *lasts;
> Sounds good=2E Will amend the patch to do that=2E=

Done



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1679?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I70560efd1133=
08b7377424127eb2c1da4266371a
Gerrit-Change-Number: 1679
Gerrit-PatchSet: 5
=
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-Comment-Date: Wed, 20 May 2026 16:18:20 +0000
Gerrit-HasComments=
: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@rf=
c2549=2Eorg>
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--ktspCFl/CJ0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1679?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/options_util=2Ec:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1679/comment/be9f75b1_d2478461?usp=3Demail">Patch Set #4, Line 51:</a> <=
code style=3D"font-family:monospace,monospace">        char *lasts;</code><=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">Sounds good=2E Will amend the patch to do that=2E</blockquot=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1679?usp=3Demail">change 1679</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1679?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I70560efd113308b73=
77424127eb2c1da4266371a </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1679 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: flichtenheld &lt=
;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 2=
0 May 2026 16:18:20 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCom=
ments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>=

<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-T=
o: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--ktspCFl/CJ0=--


--===============2038490870525362917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2038490870525362917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2038490870525362917==--

