Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937D7606A33F
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YRDodjOI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=E25IaHhz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IA1Lx0lu;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=W9pKy6x8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wepUitNio0hHgtfHiZZf1rleFsdo9pHsZW2lafxMPTs=; b=YRDodjOIRuuaL0aJZqR9rdvvO1
	1Hy32tzw6325axv6BXxyZEEIQ0AR9vDAqzPp0sMDwuO2qTFqVVLKXDIYjyugsIlODFqNqfLWVuZ0v
	OidHFF2ugC27XovlhHJmVJtE7phrgBptDMlNtBVexZ5uePo9gWCNR3ffqnji4iCJh+Mk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSxsj-000000006i3-0Rhk;
	Mon, 16 Nov 2026 14:40:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSxsi-000000006hw-0U4T
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:40:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zrwuFEiKWHASBjYhkTnlGjsrFr6ytp6ltXiBWxBCYqE=; b=E25IaHhzwFgtWo6QRrMWw2ajau
 xsVDIaZkWeY0aXOz3TI7ZMBcCL9pZax2CjVaO286MQzNgaiV6rq9zKgWzBTS68RUBelExRpAJn39O
 LCSLqgESXgRw3BSURqMdDLoHl4lHUt6Qkl1AMEycAiNwR8ZYE/43ax+oSo6siI+Mc8Uo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zrwuFEiKWHASBjYhkTnlGjsrFr6ytp6ltXiBWxBCYqE=; b=IA1Lx0lu+06krYuKIE0nEGAfRq
 iIF7X/W7bp4er2X/0Vhnk8cO9XdUOHWXi8Eq54HLboJZSVgVnhWcpLu9WIDaXUOcH64cHWzUJHB3n
 W+ph7zUB6TsIhUCr32nyrhfBZPCA4btqM8m4In0y6s8Gr0CVanB1ZcNPnkZ12zv/li1s=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSxsf-000000000XP-0wuj for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:40:28 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso3862953f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 06:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794840018; x=1795444818; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zrwuFEiKWHASBjYhkTnlGjsrFr6ytp6ltXiBWxBCYqE=;
 b=W9pKy6x8JIyKV9sSduGDdJFR8vO5f+QM87Bdik6nZqBBlq60/L/g2jnlQRDaMcrL50
 pjVTLagzJPIt8JoKxl3cTVkDWenheQgxogB7CF8VqQKAjL42KzK6BU14tso/EB/UjUSS
 4wFPjEO2+p27ugVF6eQSNEmWS7kobZtrqC7zQrdJGbMtkUul0Lun2qtqQxAwYKy50Msv
 43KXBRmtDY+Ma2c864XJb79FQzROQqe63g559J6cTE5yWTbFW9qQFhULBzaRtR5MC5Oq
 qk49BhqRE7luwdU5AJDt38jp98CVb7tYovC7ot1iS9dLJutth4cfmt/yW5/8jKNeYyLD
 wUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794840019; x=1795444819;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zrwuFEiKWHASBjYhkTnlGjsrFr6ytp6ltXiBWxBCYqE=;
 b=10GCTTqaKBP/Ku+4zlx1WIissLCybdgR+UdznBTK+yjjEIO6oKg7g9p5A1JmSElzY8
 /kWXPvHblsDogbeHPN7MuPt2nlGuT6UoanZ70gPUPDxlbQ/BX3/njEDlcFyqISg7RefC
 jYcqKTiO+kTlPMpGtKRcRelO7cawvr9D91BoP47eqgPDn0pUKZ211aQUstOOUKsnBqXW
 1ZLpw3odyNT4zRBaVFRa8miiXylS4u3fPaCOOpsRix7v9eoD3HN+9piBrWTUOcdOz7zN
 SK44ErOCL88HRsBIi4mcpy2IM2oavCLLy6UtVbNiy1/lPMCUmzkllAa1UWOiNF1Ul5FM
 yg7g==
X-Forwarded-Encrypted: i=1;
 AL+hErE/RUqPMNJs5NzxovpFjuRe96gLOnkYhK+/xTkdNlSrorxN3jc18As/7JRcyHQGjFTDa5si3o3TCC/Q0Yq+@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/pxR32Vh3qHCvGdgCIBs6Vc1DpKxfgVkS95xRtR/pz+6DTdkOr
 +/ZFcrv8Ge3YJNMPRxX7MMsS1D5NshsV5MQPOVeJ6ONI9ME++bitIBAmVhn/BKwD8yxL3sod5Id
 hH9wvLOtIU+9hTyet6K2Mjh0/xu4r4vJki0oS0EZa+DgzxbxYBB2JpDlvQFRn04/28NzdPtPDM2
 FHLij/Pg==
X-Gm-Gg: AZFdTZdzv0DwHT69cgp65QDUzRIlAp+CDuK4c/A0bm+AWrlpbNLoubm9ZgHh1UCGWEy
 lLczMr/XiYdxtLmoo5zL6FHo5ZJSFGTZVwr2LEC8Dr5PK3wbMITVRYnnCn/g/P6ptI5Pi7SjXI+
 w1MVs61eugiJwzet+myeNyxwLx7+TtoDOvyPWB4i23kSDDZlRmkhM7OPATaihYUF8m6hB6bP9Py
 2m2lpEb/WgDk593B+w2osZBmTp1rGa/xqwB+9yET1GIHKTo8dzFoxdBjxpT2OrzTjXNsfRDmwZi
 6I1PQWWCQqqANMtTBHxcleKKOPHpvv6pF7sQ/Xpj1sOIak+U0Tc+vQN3yPCP8QSfvU4Mi7TjTot
 XAEBA0hCBQVpVUCkD+P4hfdqI3Q26rjTzuF67JMHlGnilo3pgrUMaw2jldNLMgX+wzrLgPEOcI/
 ZY8BnBbNVc+n6JD4XhXDwfyS0h3UAUTFn8enTBJ/2j9EiSi41Wt0Fj77Lxxs+jxc39AkMeoZzlZ
 N5rNjoSnzOmrea6+zQ/tuwTIBLy4pzAGVKPmulxvEANeDSaHCrXZmEypD7pVL8s55F1wKZD4xN0
 1iPxsnHQCM08J5PwCcsg1evnSqDI3xeF1kJTOe1hadFoohgCSl/zo2idu2pKdstDu4DfZknVPoz
 dmbeS2drlJpcEmbmhJLIOEljLk7fVhaduzW5DPA2ypgxioI/Hb949RWkDMA7Lfnype5IW6AJqD2
 h32lOejH7CJWXDZ6hOtC8dr0ohRFQ6ST6eBDp4
X-Received: by 2002:a05:6000:601:b0:48e:2bf4:e7f1 with SMTP id
 ffacd0b85a97d-49c72212179mr24179411f8f.39.1794840017838; 
 Mon, 16 Nov 2026 06:40:17 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f7828a4sm22812597f8f.23.2026.11.16.06.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:40:17 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 14:40:15 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: 9c8fabfb154d8e55b56aef80ed34175a48cf2504
X-Gerrit-Comment-Date: Mon, 16 Nov 2026 14:40:15 +0000
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4c304e847cce44c7eac6051b1a18c8c226b9a1f8-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xSxsf-000000000XP-0wuj
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add a
 shared TLV codec and use it for early negotiation
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com, steffan@karger.me
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4232379946054291917=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4232379946054291917==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="X4lGa5t/Fu8="; charset=UTF-8

--X4lGa5t/Fu8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru, Steffan Karger=2E

Lev Stipakov has posted comments on th=
is change by Lev Stipakov=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
965?usp=3Demail )

Change subject: control_msg: Add a shared TLV codec and =
use it for early negotiation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 8:

(3 comments)

Patchset:

PS8: 
Steffan's co=
mments addressed=2E Also both of Arne's points are addressed from patchset =
6=2E


File src/openvpn/control_msg=2Eh:

https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1965/comment/7c9936cb_ad84fbd6?usp=3Demail :
PS7, Line 88: bool c=
trl_msg_tlv_read_header(struct buffer *buf, struct ctrl_msg_tlv_header *hdr=
);
> Do we actually need read_header externally? I could imagine a peek-lik=
e variant would be useful=2E [=E2=80=A6]
agreed, not needed externally=2E R=
eplaced the implementation with _peek, which never advances the caller=2E

=

File src/openvpn/control_msg=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1965/comment/f151cdba_d94abc27?usp=3Demail :
PS7, Line 87:     }
> When=
 you return here, the TLV was only partially consumed, which might come as =
a surprise to future  [=E2=80=A6]
Fixed=2E ctrl_msg_tlv_next() now peeks th=
e header, checks the length and only then consumes, so shorter value leaves=
 the buffer untouched=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1965?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
Gerrit-Change-Number: 196=
5
Gerrit-PatchSet: 8
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Ger=
rit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojo=
caru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Steffan Karger <steffan@karge=
r=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Atten=
tion: Steffan Karger <steffan@karger=2Eme>
Gerrit-Attention: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lich=
tenheld=2Ecom>
Gerrit-Comment-Date: Mon, 16 Nov 2026 14:40:15 +0000
Gerrit-=
HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Steffan Karger =
<steffan@karger=2Eme>

--X4lGa5t/Fu8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
, Steffan Karger=2E </p>
<p>Lev Stipakov has posted comments on this change=
 by Lev Stipakov=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1965?usp=3Demail">View Change</a></p><p>3 comments:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchs=
et:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1965?tab=3Dcomments&amp;usp=3Demail">Patc=
h Set #8:</a> </p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Steffan&#39;s comments addressed=2E Also both of Arne&#3=
9;s points are addressed from patchset 6=2E</p></li></ul></li><li style=3D"=
margin: 0; padding: 0;"><p>File src/openvpn/control_msg=2Eh:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1965/comment/7c9936cb_ad84fbd6?usp=3Demail">Patch Set #7=
, Line 88:</a> <code style=3D"font-family:monospace,monospace">bool ctrl_ms=
g_tlv_read_header(struct buffer *buf, struct ctrl_msg_tlv_header *hdr);</co=
de></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0;=
 padding: 0 10px;">Do we actually need read_header externally? I could imag=
ine a peek-like variant would be useful=2E [=E2=80=A6]</blockquote></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">agr=
eed, not needed externally=2E Replaced the implementation with _peek, which=
 never advances the caller=2E</p></li></ul></li><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/control_msg=2Ec:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1965/comment/f151cdba_d94abc27?usp=3Demail">Patch Set #7, Line 87:</a> =
<code style=3D"font-family:monospace,monospace">    }</code></p><p><blockqu=
ote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
>When you return here, the TLV was only partially consumed, which might com=
e as a surprise to future  [=E2=80=A6]</blockquote></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Fixed=2E ctrl_msg_t=
lv_next() now peeks the header, checks the length and only then consumes, s=
o shorter value leaves the buffer untouched=2E</p></li></ul></li></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=
=3Demail">change 1965</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1965?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1965 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Steffan Karger &lt;steffan@karger=2Eme&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: Steffan Karger &lt;steffan@k=
arger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne S=
chwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 16 Nov 2026 14:40=
:15 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"d=
isplay:none"> Comment-In-Reply-To: Steffan Karger &lt;steffan@karger=2Eme&g=
t; </div>

</body></html>
--X4lGa5t/Fu8=--


--===============4232379946054291917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4232379946054291917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4232379946054291917==--

