Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE36E606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GfrFQ7XC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mTsmWmdW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fkd78Fsi;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=amFaEtc/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dqXlp7bMDWCKid/rZTRnbBTfgSnWU1AafSDNHg0gs78=; b=GfrFQ7XC+cKFL0JHT+ZaK5iHYI
	DDmz9MsdZEBzHepRyoGSH+GqE1ZTQ8MCrNCTPJiVH8taePps+HIGQBytFU+7fU9Y4vIrFgpiyu/7e
	5LnGVAqGlLFJReoEVB9d/d2S3uFvfEsy2PhdKrjL+vp8JXSD5oztRokrbUprIaLBN4gM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTGQa-0000000071L-1Qss;
	Tue, 17 Nov 2026 10:28:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTGQY-0000000071D-0gWY
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 10:28:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bOWsyShyhM6xUSJc+ppWPt71KwxpiJQFQK3lp+eYNKQ=; b=mTsmWmdWWSv6LErNQrAQ83cj+t
 yEGKigbOg7VVlEUMjbRJnjRlzlRG1KGXhz1JYYbYAqIy+hysvsdarkrriqix6xk1VGTrJrIrCY94p
 mtXX5e5878QTSuZn4iSHoyRvzH5pfyuJlkT8dxzxqoHM8/iCxI3jiDweTY4jB7n0mGos=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bOWsyShyhM6xUSJc+ppWPt71KwxpiJQFQK3lp+eYNKQ=; b=fkd78Fsix5hHWKmk83O1NGK47i
 hMiA4vKEwdZDdR7uHxvJg9LlJvHs0RtUrHl2S59c+P2FojicaswHcEjdYuoUg5YIWmMTMD19rI2+l
 5fzMAdpQMru2UKOTJyf/Z2hB/IceCkq5gRTlUhbCN51Hp88S513JUkfcq4jNubUfjP10=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTGQW-0000000021J-36m2 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 10:28:38 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso4218795f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 02:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794911310; x=1795516110; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bOWsyShyhM6xUSJc+ppWPt71KwxpiJQFQK3lp+eYNKQ=;
 b=amFaEtc/IFepN3Xu4rtWG6HYINzSYWtcV53agp1BzpypEnpylJT6GNnNeKjBdVdHCh
 ca8JT4qqJejBfYLuAqxBPuJC7JE4eXh2HraUUfdnRV55Np3UGvWW3CRTthLB6ti6osy2
 +RwgSi+eyZRK/tNFh8qWZP0YsWaaQKpzK5Mj5a+TfUqY0SEF268mXcHGTcxpfgpbn6MI
 ua2Wzim4m8ZpGr2xARBZ57cbFmBR5j9BtOivdcZNOtt86bfRabushYZ6LGZrq/VyolnW
 l5yn3A8WYrMAQ1RhRGj7RCjXkGVLeLtRbTaAOFgQ+37qW157jTkLbk+Ka1Chsj/Inkwr
 8K8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794911310; x=1795516110;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bOWsyShyhM6xUSJc+ppWPt71KwxpiJQFQK3lp+eYNKQ=;
 b=paRfkpU2FhyML4H+YmSX4EHeau1ICqV27OBx7giFKO0VpU60WR6DpIaEYyH3DPXBEi
 OKjnowaaXRxzw0JWQ0eC3b7yhIcHBHVTFwzN1OwCAA5l/h8Y2Ynl4S/7YYq8mm11H/1Z
 WkK2t8SNixqFBMSKCyFhJ6eI9igg/48CsPnVrXUWY02Ya2vb8mEMgx3a9nKrLMNKR+kT
 ldVXY6m4rtjOKl40amdujSZGMN4LtAhPUv+JR1hERaMPakHRZnkkEJDzMIZ8JpRFv801
 Yg1QJBMT0wWlxmHaInaw/MDf67aiN7xRZCKbs/wf8KWGrITZ12xYHM8hS6fGWVNBV2Od
 WF5A==
X-Forwarded-Encrypted: i=1;
 AL+hErHxbJ6LXhc6isTxk/GDq7Gc5JUohfQzounmX/CAvPRSSWo7U6tXVUJ3l+JQqnmfKbPBCTpHQM7FUXk39OTz@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/Sc8F3WwqwaVEZSEXa4NwBzJN1ZnqvVPpnTgr1+3+0El+UIb5d
 WgTaXP4yu+rOlyWk2xYob9w2yf3JEOYmpcbi9zg5mJk+n+v5DUaCs8AWRHI+LY/CNED+uRG9S0F
 nhe9lvSEgYyd1dqqEUlm7uS1ti3duirgL1nw6cwnPpl+tmom6rQYVMtfQXjDsMG3rhZpi
X-Gm-Gg: AYBFou3U17FskdX+TuFHimw3jJ4aHMypCffB3EzNoVnpTuRukXWqF7hdCnbCvQwNh/Y
 mHJ9B8IsfD6ltMlZbS52eQXQUmOEyB+dgwe/ErHTJGVQP/VYSQn86hU1GcRoUFkXOyTY5sHiewr
 cNIKJHEXrbFW+8+1IxtvWdGL8TlmMc6fqjFvE0LREjCowh4X+slk6J5fE5OguZ9yrYzsTOI02ck
 U3fZ6028I+v28842uCIYBxCopBY7HnPskEsyn7f9m+N552T18haxuVUtOKYEUPmp09T1XwsIzRx
 LxQ2In5IfyokMWEI3gBp5dru6n+nKrAYCGvZ/17FvGNCB5BFk3X2VjKxgKY2hPMuUXbVCJ9IEZk
 JzzdAZXbsamz5kECXsMDpthSSRZTtEV9dA0fTvi+c/iqri3/GzHZ6SXDbnF9ew6W7cqkg1WnJtM
 NUBbNIb7KHfmhaD9tTDYWyI6TRCLKD+WayeI7MRE5x3S6cs1KwqxGr3rBoweGD5PQ7euJvWaJYs
 VaLI5RMBgUHr4QboOdNyySEVa2NKJK9/zf13GZlkbBC3ICEPwcBOLT3se6cx6ircWW/ZLegfr1v
 l2yhpN+wSN8DVepspZn4RxwPfjOz9Wpe+t6xHJatdm6ILn/EFM3M9A061Fkm8vgROw6ioXRFwkD
 /n94BuBBOTMdCD7IRXma4V0ZdLhKoLUmWCwF7P7Jq28096oLC/66JmV/ODOkn9od2vg9pqUXM4o
 b+/ptZ0XzWn58Bv0w=
X-Received: by 2002:a05:600c:3112:b0:4a2:150f:1607 with SMTP id
 5b1f17b1804b1-4bb55a4ebfbmr299828065e9.13.1794911309880; 
 Tue, 17 Nov 2026 02:28:29 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb78420edasm87340335e9.9.2026.11.17.02.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 02:28:29 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 10:28:28 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I388a52d19633d0604a1610fbfba31cfff7f518ef
X-Gerrit-Change-Number: 2202
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2202?usp=email>
X-Gerrit-Commit: 933e563d2dc9ff61407112961a140fb79b6122bc
X-Gerrit-Comment-Date: Tue, 17 Nov 2026 10:28:28 +0000
In-Reply-To: <gerrit.1794853507000.I388a52d19633d0604a1610fbfba31cfff7f518ef@gerrit.openvpn.net>
References: <gerrit.1794853507000.I388a52d19633d0604a1610fbfba31cfff7f518ef@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODUzNTA3MDAwLkkzODhhNTJkMTk2MzNkMDYwNGExNjEwZmJmYmEzMWNmZmY3ZjUxOGVmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <caf708cd06eef5e6c429c3fe8e59d970278c03da-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTGQW-0000000021J-36m2
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: mudp: drop unused
 addr parameter of do_pre_decrypt_check()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0335704244617588147=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0335704244617588147==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="86azDiOfYdo="; charset=UTF-8

--86azDiOfYdo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: R=C4=83zvan Cojocaru=2E

Arne Schwabe=
 has posted comments on this change by R=C4=83zvan Cojocaru=2E ( https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2202?usp=3Demail )

Change subject: mudp: =
drop unused addr parameter of do_pre_decrypt_check()
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2202?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I388a52d19633d0604a1610f=
bfba31cfff7f518ef
Gerrit-Change-Number: 2202
Gerrit-PatchSet: 1
Gerrit-Owne=
r: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ge=
rrit-Comment-Date: Tue, 17 Nov 2026 10:28:28 +0000
Gerrit-HasComments: No
G=
errit-Has-Labels: Yes

--86azDiOfYdo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: R=C4=83zvan Cojocaru=2E </p>
<p>Arne Schwabe has post=
ed comments on this change by R=C4=83zvan Cojocaru=2E</p><p>Patch set 1:<sp=
an style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; paddi=
ng: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2202?usp=3Demail">View Change</a=
></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2202?usp=3Demail">change=
 2202</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2202?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I388a52d19633d0604a1610fbfba31cfff7f518ef </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2202 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 17=
 Nov 2026 10:28:28 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
=

</body></html>
--86azDiOfYdo=--


--===============0335704244617588147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0335704244617588147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0335704244617588147==--

