Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB8D606A323
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Lz64PseD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GRf8jT9L;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Zr2FHCtN;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ZemdTqcn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=YR9QvdeKOXwmghXjwH1MXEPtntYlSgfK2d7rIUmvP48=; b=Lz64PseDAONMSiLWmuz/BtLlXH
	qtJTL6edaorEEdRqh/KSuAHLpqGDQvX6WaIFSgxtl+8Igb31vUXSZJBNPs7KsIrA9n7Sa6Cv9gjbM
	Cr+WD+MQWQAurJiIyZCqZ7HJgvmNL+6dounRLO7zf9FKm1/8fKeBWIq0UqR0wZpVLl/o=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSGCp-000000003Mb-3pAx;
	Sat, 14 Nov 2026 16:02:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSGCo-000000003MK-0c00
 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:02:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UMt9JgwTer55Bh8jcQzaobNwS1iMBd8fmE1cWGxhr0g=; b=GRf8jT9L5qxlFHhfYsM4ueDetO
 lHEbihlhWCYEMxe4tVbgnO/gQKF7TpUdnxELHBToTLDq2S45qnyioWxSBlowj2YvcOOojtvXDVIEZ
 pGO4bB6Q/2zyBHjTe/UBU775kTwlNfs3FQe3Hl5x1rIJhfJSXpgrkvz0/1f4q2to53/g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UMt9JgwTer55Bh8jcQzaobNwS1iMBd8fmE1cWGxhr0g=; b=Zr2FHCtNqjkKZUxd6RKn+TK5Sd
 GBE1GWtvfrz1wuVRQ5NIWQQoXZiseH+nmjCOazPbaWJ0geep7+33G0Oq3WS0GM6tShP6nRHB36J1O
 +qtoRdemR3cKvqNCcz8eH5pS/HMvVuX5qBt7sN9EtI15RI+8h7ZUo/XAMYTMcCC6C8c4=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSGCX-000000001LU-0xop for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:02:01 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so24231415e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 08:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794672115; x=1795276915; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UMt9JgwTer55Bh8jcQzaobNwS1iMBd8fmE1cWGxhr0g=;
 b=ZemdTqcnwXzlHOT1czs1sWOwQWuCLRnq4D4682lIM3ei4LEEgG95upt1zAVNNlO2ex
 Qq+Ehc4bMIFDgqL9VM+xDQVh3ZcXCiK1pjl3YvNJvOWllrs8FLz9ysslXf7Pd40XoysH
 t9kIl+eHXkyi7DayAEMGr7ndnlENg/kvGd0aZXyj76n12UfjYduXMoSMfgOhrHmZdkxQ
 M98sKPMyCYTnp3VOv00jDuNkQH++aDLNEU4B8VF+LnNo7BNjmdM4ZHkoMzEqh0Sebm6F
 owjHN8zSPnPnhXBmozjeiUrledKH6pM8YtH+Sra0F1tEUR/Xqdhh9INcc9SyktvvvFUH
 rSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794672115; x=1795276915;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UMt9JgwTer55Bh8jcQzaobNwS1iMBd8fmE1cWGxhr0g=;
 b=cuoBQ7pUjKy0xCLGEL92AqXlPOp/N7PdGDuLAN8B8mGIN9vS01RKjHj/CLEB3abHv/
 NPJ3ABme+Jt5MMPrG/7sduotplew1e7Zj5NoVIQm5ZKEqUjbA9fnAri2s6aLvSaz8eQx
 J3fgPd7EaiKRnlGxiEIBfZDE2rbxrn6l+w/B+TmPGIY0xb8qjii+QjQxeTHIaW8z2fUk
 BKkk5qc8gsl3yRxaErypM27aTuWiHvOYl2hbdWaETsZ3HUwQ0B1JSYi4os0ocVdZ1Utf
 A6UjNrCe24O/iHkU3moPi2W9rQe+P4iPCUqdPLV8UGNe59+krlJsBDCNpsr5epMM2ArB
 Z0lw==
X-Gm-Message-State: APuU4Z/MIIdBGP9YVmZPPiA/WSJQSq/ECkoBS0IPlhKXADGYWHboafkX
 yY+sEOFZZIKiOR38+ikACX7QeYn8bXPMfRoekIrWWHj89Pe8Q91gDFR5MgFHY39jQ1MKumByaVF
 6gBk55KsUwDTVoHsLhJnz1waVowXVh/L3wLR3H4A8iTib5E/Osii6xLE2iSIcQpYVU4JW
X-Gm-Gg: AYBFou0mqmRKjiUSqX0G9fr/aBGWH8yUi8WjIFx5JkRtFmMAsQQYoT28Pr/lbq5ZKrm
 fpn3bvLCU3aXTKlMpY9El1g+RjPxVi9+uM2WXqDhXS13bhx6O3mTAp/QzTZH6nr0JE4Hg1B4YA+
 V9v0SPMbwMUXANvtHwGIopmCClqGbca8d0InO3gI4E4rhHZEtE5GhhaJTws2fJ52EzictomqghX
 Dw9/PWDCp5dJhDAbvtE0RigN0Xd3ozMJfXoPQsEmSKXPtAv1KOGqmvkuGfwWZJyJlmRz03vDxEC
 HhvII4AxKHNVFh6au/BwBN5sL5vrKVXjK7StKpU+tIgl/XBglxfBsiZBb4KiURZGwX2vJzaKY3i
 gjp4Rp7BRAlGcPNYSP+UXUKNAIIztx7yoaQNhxPClVFs4yHwv9bEU/5dYWe1gUWtPm80iguqwmU
 F6w1ShEo/QHWihHqVjqWwPg4OoU582XQ5jRPt6HXQg38+RcS77wctdgcvNgyCgf9goGzNzHoBEl
 sMQlO35lVx4rlK1Sfst/PTD991gU6funhmJzcgO2Fp0svhrUOl39bKWFUILPtUII7WMuIpi/rBo
 dHXbGy7gthswWfp6DhSSO/dQQGyOVAOC4Qhsi2hKUHOCZ01eKC8Mw1Htub7W5xHYbVoNjagzJ8T
 htNn9DRKkEeKE9K5xDyG7dXvFVaV5oWDZLjdSRqWcoXxT8Ynt/qVT0jybmRTUzavfgEEKqdPR0C
 EV4v2F6PDWUaOxtfA=
X-Received: by 2002:a05:600c:1daa:b0:4a1:9663:7633 with SMTP id
 5b1f17b1804b1-4bb55a47625mr124018865e9.11.1794672114510; 
 Sat, 14 Nov 2026 08:01:54 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e28c882sm245910875e9.6.2026.11.14.08.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:01:54 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 14 Nov 2026 16:01:53 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I0f8ea4fa572f84e6dcc9b0806c23977c64ea645d
X-Gerrit-Change-Number: 2126
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2126?usp=email>
X-Gerrit-Commit: af0a34c160f03ea97af19b58ec16fa4b6e8f6116
X-Gerrit-Comment-Date: Sat, 14 Nov 2026 16:01:53 +0000
In-Reply-To: <gerrit.1793781037000.I0f8ea4fa572f84e6dcc9b0806c23977c64ea645d@gerrit.openvpn.net>
References: <gerrit.1793781037000.I0f8ea4fa572f84e6dcc9b0806c23977c64ea645d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzgxMDM3MDAwLkkwZjhlYTRmYTU3MmY4NGU2ZGNjOWIwODA2YzIzOTc3YzY0ZWE2NDVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <eb05b343c7ec86028748adf650c297b71df65496-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSGCX-000000001LU-0xop
Subject: [Openvpn-devel] [M] Change in openvpn[master]: pool: reuse
 handle-to-address helpers in ifconfig_pool_acquire()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6609463064412898424=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6609463064412898424==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BCDC1QIP0js="; charset=UTF-8

--BCDC1QIP0js=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, R=C4=83zvan Cojoca=
ru=2E

Gert Doering has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2126?usp=3Demail )

Cha=
nge subject: pool: reuse handle-to-address helpers in ifconfig_pool_acquire=
()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 1:

(1 comment)

Patchset:

PS1: 
pool man



-- 
To view, visit https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2126?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I0f8ea4fa572f84e6dcc9b0806c23977c64ea645d
Gerrit=
-Change-Number: 2126
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru =
<razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelb=
it=2Ecom>
Gerrit-CC: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Anton=
io Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attention: R=C4=83zvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Gerrit-Comment-Date: Sat, 14 Nov 2026 16:01:53 +=
0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--BCDC1QIP0js=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, R=C4=83zvan Cojocaru=2E </p>
<p>Ge=
rt Doering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2126?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2126?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">pool=
 man</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2126?usp=3Demail">change 2126</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2126?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I0f8ea4fa572f84e6dcc9b=
0806c23977c64ea645d </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 2126 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div =
style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio =
Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Ant=
onio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 14 Nov 2026=
 16:01:53 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes=
 </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body><=
/html>
--BCDC1QIP0js=--


--===============6609463064412898424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6609463064412898424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6609463064412898424==--

