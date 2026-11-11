Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DE9606A321
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jKNUs4LI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=J087wzBz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bEQcDREV;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=edYiUam5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=y4ZBd5ePXrVNuED8nFKvhzNVSsnxtrRyX8e5x/gnskw=; b=jKNUs4LIAAtucvu1p7xW/a1ECw
	NN40YGcSiPzXBJOmST5heh+Y3SQefsKRHyZCDJLSqWxNE0BtN5EU2ixMtHcmf0EhacC9V+LlllxmJ
	//KYsaEm4CR/seND++4787AEpdUiI0OqJjZsrBVr4dRfT4u8LtggfglbOIS+svZJhpgc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR4bG-0000000087d-2TTO;
	Wed, 11 Nov 2026 09:26:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR4bF-0000000087N-0bm4
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:26:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7vCuctQEwFC0tVSmW1vkGR6Pa9L7rfjbcHjlAPVfWQk=; b=J087wzBz3I7NTLi4ggmbk0Avv/
 iLs5npL71jzA6Y1fzgzxkwbFzwgS4cJJ/vtAGrhbbftYllu4/GB384X9Dl48AvTvIK0d3/Qm9xTUD
 hLjljkiMZFKk8h5NdRTz/CH+MMF/bLulXUkwb5HdlwXFfOIilIsBlNAF6OOcbkguqKDs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7vCuctQEwFC0tVSmW1vkGR6Pa9L7rfjbcHjlAPVfWQk=; b=bEQcDREVtY6dFIwDeTXvWIc1nu
 WIBLew9ew/KBZGR9a76XWw+IKe3pIbrXz1bFgIy0hQsUyXQ+HVsQqMIKtruNUXhSzFbrr0z1yE6WL
 ZOqRjBtQ9thSErNSTub7oCDTRPY6N9M0U4rrZMcxcXzANfzh+d6aT70hck/Q292sXZ34=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR4bD-000000002Ph-22jH for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:26:36 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-490a0e72588so1607602f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 01:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794389189; x=1794993989; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7vCuctQEwFC0tVSmW1vkGR6Pa9L7rfjbcHjlAPVfWQk=;
 b=edYiUam5rYrH6iGWBrbcnETW73B4QNl+K5ih9hRZRlDdJzNc4acuM+b4tgLNrFgztH
 DHk1ZM4LN9R4p7h6dSkKF0mrzF19yD74+mrPK9AgUGoJYAZCieQHJPBxmScwAPAo0Wn8
 wghwwyYh1XKpySOUnbvXo4PzY9+hL8qpnrhb+8chtkOEbhXq3HK6NT1Za57KttHMbb9n
 X4nCQE7iIFOr08I2Ibzv8Jhs7oz7L/kGcXadfTytQw6ZuCTzAbO4uKEyE+RYbsbSOZjd
 pB5XuQ/3/LkYyv+Cx2dWQq6IbBkxR1zJjZRN99IEGX2bmV6NRSoQIqpGcNjCVxMYox5H
 UCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794389189; x=1794993989;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7vCuctQEwFC0tVSmW1vkGR6Pa9L7rfjbcHjlAPVfWQk=;
 b=rKW6XK2Z1aeOEZ/P8Tmkl9LBpU141fH7QfZVi0mToe+JRmy73bNn5vqWkxs+Itqe2e
 uiauHu+5bcKqXHsoSxc3k869LKEbmjH8d9slB0d5qbW7t8CqCZuODWhnHcTzURkEJNHh
 Vs/JNn0JrqVZsumCSRrRy9S2xBH835eBilREcxElUmE6gr4g+s77Yvzi99PUFmrv7W/f
 fTqUHcGX4vlpsKFD/uqwsOxm3QViRwiuXPxjkc9dSUNubZXtQELmp85LRRm+JLaqzjJ9
 dv4TQtucCc4lZ4Ox1ntB3RiQc8gry+5VhYYhbyYSEtjyPiCUyumQw+OheWp23q5ESo2a
 b3BA==
X-Forwarded-Encrypted: i=1;
 AL+hErGkXrDg93+sVOQPYi0EtUrPXG5Pv13e+k6CeOCBmMVb2OFPUILwmtS2QNaU+El8UP4A33zq3OrIBxOOlHIM@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8mgDgTj2ZJN2owvcRvAzaC5rIoV4Gl9VYT5DTFQ1lu9lzArK1W
 u4a4Z/zIoTgR8umYqYbYIoB6wOD6fxWcwIHAdCkrACW2hF1DSZV0B/iVKyEHYUYMoT50k5Jz+Yc
 WVm2u346HCvg6KJv/r6JLlgefrdyB83umLtDCpMf0Jagxl40K5LSldAy42cbK28bZWHVq
X-Gm-Gg: AYBFou0IXcww0vlAZsbP6ocAdYKv68NpQS5JEoBUb14yrnK/xAirbhDV5RskuGisd5a
 iZ7XQv1EXloSHL8VxNx8FqlkvsxhWZBMwCrKu4Q+181m4gYocRvq/AdgqwdoSpUd+xGFoUmtOWz
 rKHvDdV1PmR3uW5BPLoKUy482JBlZRqfB57UX+hx3rMRasno8xyvtZp9Qu94ZH/52kU+3X5ET7e
 iAIpgCQDtUtm0OtDdcaVzlLf+FxcbqjhxCOBqclbLlqsE5/f1LBd7HAk+la0axXwAqUUAXs8Qnv
 ryScF5UkOFThWMPkZe0kfrJXygY2QgaJoKp9EOUPBOz5bZLs5F0EcDe9S/D5mmRtZFiVL0j6cuw
 LUsziEBZm0TpHyASlR+BZYIUAD4Py8AiurHANyyac5LfUV04dWca/xBPc703beenTnPbHMoTAem
 7dtLatu6xFrIajIaA0cRqk0n5rSfjyaBxqzbwZhZFetSk7j67kdy2LbqsVoV4cfpdnBy0Teuc6v
 YRFVLqHq/+Q2wPX5vlNYbyERtCExR8Ylmq36QKtjQ/Nv3HB3HgtnEBGQ/FNqmTSxWXvw2syiKIw
 oVQjClLxrFidvnBDfS5wwRZfAXAKssHg/RRpu3UDRfLexzklJT/ieErBmKjgHCRifR7YxqsGwYm
 uzNHRRaQGUrlgdK3SC8FMnv1ZGttIdObMvk+9FzRz3+7hpeEVDUmqxd2Vk1twJ05wmtYyYZ65fq
 pueuHeTEdjsuFWKU0=
X-Received: by 2002:a05:6000:4808:b0:487:13f:f612 with SMTP id
 ffacd0b85a97d-499c82cace5mr2572806f8f.37.1794389188694; 
 Wed, 11 Nov 2026 01:26:28 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498369a3fd2sm10563130f8f.52.2026.11.11.01.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 01:26:28 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 09:26:26 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972
X-Gerrit-Change-Number: 2162
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2162?usp=email>
X-Gerrit-Commit: c4d3d47750d4359fe2726370f3a69c3558932737
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 09:26:26 +0000
In-Reply-To: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
References: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzA0Mjg4MDAwLkljNjAyYjEyNWQ4NTdmMWJlZWQ0YWY4NjYxZjUyMmQzMzliYzllOTcyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0a11a2b1f870f30e2ad1ac8981ad6385d4252e32-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR4bD-000000002Ph-22jH
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: keep
 IPv6 name servers in NRPT exclude rules
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0671394168904680801=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0671394168904680801==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5mi0ACgJe/8="; charset=UTF-8

--5mi0ACgJe/8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Antonio Quartulli has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail )

Cha=
nge subject: openvpnserv: keep IPv6 name servers in NRPT exclude rules
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Co=
de-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2162?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic602b=
125d857f1beed4af8661f522d339bc9e972
Gerrit-Change-Number: 2162
Gerrit-Patch=
Set: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Re=
viewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc=
@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Comment-Date: Wed, 11 Nov 2026 09:26:26 +0000
Gerrit-HasComments: N=
o
Gerrit-Has-Labels: Yes

--5mi0ACgJe/8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Antonio=
 Quartulli has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?=
usp=3Demail">change 2162</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2162?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2162 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Comment-Date: Wed, 11 Nov 2026 09:26:26 +0000 </div>
<=
div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"dis=
play:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--5mi0ACgJe/8=--


--===============0671394168904680801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0671394168904680801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0671394168904680801==--

