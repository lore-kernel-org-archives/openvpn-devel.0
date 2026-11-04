Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61960606A32C
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CKB4SpP7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BGmYsmgt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TAVOiBaM;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Es3ggtWY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=FGIA+HeLcOgwbA/uLwQlcp6RA2gbdvlfFYUlAmRfA5w=; b=CKB4SpP7AJ1VOFEkzaV1hOmHsi
	G6ykTyrzPMm13Ek7E73sPgHhdoIGqkuEnpWtIh7PYtYx8hKXOCmz7KPavLI9wgYfc9ZO77Txybevf
	+rL0mfCkzD/B0c9Z3O951UqTjL2VJUSig7QAHd7SxWh4InnlNBeH/BOuVDcGIqavAmJo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOdq1-000000002I8-1WM2;
	Wed, 04 Nov 2026 16:27:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOdpg-000000002HV-3GIt
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:27:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xo1lUyyujGWnPazd8895j1mWdPQ7n4v1rELj61xt1xI=; b=BGmYsmgtOLE5liTyLRCxMRZlP5
 Rtt98KCT/SjbzCFLg8ITYDV5nCiE5ZpPZrTYpwbMRE2BZFikt9cSgAqP0JrRqmKbQtRC45XQ74kCW
 eoOC0NME/cghleifUWtFJdgRXyWStWR3Ada+NkoXROENImI6lwK95ekyTjCe3otwLJU8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xo1lUyyujGWnPazd8895j1mWdPQ7n4v1rELj61xt1xI=; b=TAVOiBaMFw1Y6fsaqFCdX1LxE6
 pEGG+y9+PJROWzpzNd75JUouX7OYT//O0Qf3AE9zCR17TVFXOxWW6APWGseL0uoKvI4JHp5cpuqL8
 hC7UEvHjC/rR02cMhykZF4weyZDD8RlskD9lzaY2pH8aBkty6boaMb845fOodxjwgg/8=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOdpf-000000006M8-0fPc for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:27:28 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4afe2d546f9so10815055e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 08:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793809640; x=1794414440; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xo1lUyyujGWnPazd8895j1mWdPQ7n4v1rELj61xt1xI=;
 b=Es3ggtWYsUMq8Zl2Xapl0p6A5HemHiQP+EjvSUaQaYI4gZChrrrBsrKDtfqBr8w4kN
 UhRtGLnmmbM9HS619Q53g6+XdMeS1X2wraMHbOkG8uyFVyx+eat4/1+1dXEYcpic4iMe
 G9+OhjWM+DOc3QcWpEP+j0I47CgIt+rBS7cQwewz8I+n4Py05yaINa08cd1ql2ofuQ0n
 SJ55y1QL6gCyILrMcmV7fuwLv9LwDoQ9nXy7kQgcQMlKWYTHZrpr94J0ZJueXtzC3alS
 XHHdp2MLtB0i+VDKjRNY3kJ8K3LV58fL6I/RMeNwYqm54dX08HqVxkCWGD0wFwIvFjAb
 SD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793809640; x=1794414440;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xo1lUyyujGWnPazd8895j1mWdPQ7n4v1rELj61xt1xI=;
 b=ocj2JLRGvgctsXz4MBSl20+8j3hXfHs7I4AekSGykKRlsTRCgLatAgBx+03P+pRwdg
 FbUByafRzPHsfvjgIcpJUrmPo0IA9zBoLhXFxE/5oZvoAAxFzb5Mu+HEQ7K005R4nB33
 UBKqURhja0QJQloSc2HBlvoQ/bmVjMvc6rCvYrycaoDDZwzL7A54MXIgl47cC+8mjqr2
 hBXSGHrgFjA1J6VSS7aZKFZsFRhg+Cg6KGvDX87N3Y9teIdPTkb/v0RKyuPfJ02AHRv3
 IOHFtMQXFSaKvCu7T/vNAs8PkIfDzktCx9KA9w3Xu9ipYPNrF6Stj/1fIWYU70VHsT51
 t39A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxqs50TbrADKTC1AJC+aABkaJZeCZ5JZO/9LhSDznh+BsD/toEuOwRta0max6Hvi9r0dPnZX4qAboz2qjuB@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8q09/HXLXYoVTaHaCqL5Xft99imdfBOkiWEBvJm6DeSLB6wXSL
 v+aavUToTra02ltzxmu27xnxFN/B2tM5dqTxloNt/QfjYMddczquHAackyQa0RDGqkpSP/b6JYl
 fIQUn8ezCWFcEeef+HBf9iyB2jJCY/baJqwaXYF1uolORKANWKnD6DRQx6imWV8dObLU8
X-Gm-Gg: AYBFou07A3LKzqBjQ+NyyCHpBqQV9MRp0NXo0LmacZRKEuUVhbMxU1x7+SEM7jq4fAf
 XqaawuhvzAgmK5kL02DCyPp3nYRgrJhD3idCEbgIDNOt8FzJ9zmf+F4Xd+rJCru54cyjnzwZ5Gc
 je5EPXWhIOCkOyfapD6UE/CfGgzGgn1TtfvQGVhDtH/Kdqi6vEZ2F/CD4AFYu7nQsgTsejGYDCs
 TDVVjGeoa1GiueQ5vjmVX0RBOTakvtFhGat/71p7v9SlmEza/UvteWF0fGZrBbADvBT82LDL8iP
 5B8edvZ3SBv/PoL7vgFKPIYCeVpRwcJLebZPWQxGrjZsGWjGY7NG045gN+OmbLiT62QP+HuzuEk
 OEnr43dSUum7ytxcawLP5Who/yerdSW19nY+70scQ/PPlbqFPnD8gUonx3YYCxTxdKQgUSsfazz
 rP9mGpcT/MvmeDdhQWwJEB4+xzbUit6E+rSKRvDpw1P7YnLTRu4NAvIZb/EWoSE3tdjBdUvreHM
 SkML8b42XYPw5Gyj8O+Ow+js6pct+3wyMkmTukMMFP+7HWG2ax1UFuGitnnz2Rbw7I+N2hukpdV
 NgnuUVmCh3TtzAAi45uDJLKmHgpuO1fOxDB3DZpc7rM7U9Vc53xFDu474GbTpglsKxvX/a75iGz
 9w8tyb4XyR76hrmi6w291v2svKaVqkFGF20Ud446cXiUp08Knzpn3fYvukK/ptd+Y1eSd1/Gl35
 By2n/HzT/xW+UUbQ==
X-Received: by 2002:a05:600c:4e88:b0:4a3:59c7:f226 with SMTP id
 5b1f17b1804b1-4ac16bc4713mr385219635e9.6.1793809640460; 
 Wed, 04 Nov 2026 08:27:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b43cb234a1sm72641355e9.9.2026.11.04.08.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:27:20 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 16:27:18 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: cdbf85ced0fbcfffe1527f249ed44aeae5f048d4
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 16:27:18 +0000
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9cb9ae56430135c95edf5d6b6fd71c08832c561f-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOdpf-000000006M8-0fPc
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6442127723967129111=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6442127723967129111==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dX3+McYWv08="; charset=UTF-8

--dX3+McYWv08=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Lev =
Stipakov=2E

R=C4=83zvan Cojocaru has posted comments on this change by Lev=
 Stipakov=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail =
)

Change subject: control_msg: Add a shared TLV codec and use it for early=
 negotiation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 5: Code-Review+1


-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1965?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
Gerrit-Change-Number:=
 1965
Gerrit-PatchSet: 5
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>=

Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan =
Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: Lev Stipakov <lstipakov@gmail=2E=
com>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: We=
d, 04 Nov 2026 16:27:18 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes=


--dX3+McYWv08=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Lev Stipakov=2E </p>=

<p>R=C4=83zvan Cojocaru has posted comments on this change by Lev Stipakov=
=2E</p><p>Patch set 5:<span style=3D"border-radius: 3px; display: inline-bl=
ock; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +1=
</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?us=
p=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"><=
/ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1965?usp=3Demail">change 1965</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1965?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1965 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none">=
 Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Co=
mment-Date: Wed, 04 Nov 2026 16:27:18 +0000 </div>
<div style=3D"display:no=
ne"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-=
Labels: Yes </div>

</body></html>
--dX3+McYWv08=--


--===============6442127723967129111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6442127723967129111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6442127723967129111==--

