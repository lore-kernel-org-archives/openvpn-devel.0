Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005C9C88E75
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t9OHcRQ27FiKJ/MTj+AIKB6Z0f6IRPpYVHnSkfYusHY=; b=YgjKkAe3cVFFDjqYVX9eAy+ipC
	gUwA2Bz90ljyFbE5I+nusNQ7xpo2OtH3OU9i6ItcAnH5wvZ7OehGMRA+AFJxPsHU15vBSAhMP5zlK
	lOjDVSDmrkb1Bml055DuUClbf8qT2/3xAui2+J496U1ULjVOGRIrb49pqaLQBxvPy3ag=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6R53-0006Zo-Lv;
	Tue, 15 Sep 2026 11:12:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6R52-0006Zb-Hd
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 11:12:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=0aVlFW/HAtKAXk/qdwVTC9zp7HKk5P1AhyeLobpVBas=; b=YPF1JZikxNJSey3KYTqChvBeQe
 g5eH2FSSgiK4Vo4X+XGbi45JxUPzg6Kc37Lfc+NFva/34ZFIu9tTGuBpJqveBatpouqRGLqgfOeoL
 FVPfNmGwX6H0KNVimhTtbcypCeozJj6II49ktVZiYM8j4bJRmQLi4F+hT/S1j5oUQunU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0aVlFW/HAtKAXk/qdwVTC9zp7HKk5P1AhyeLobpVBas=; b=I
 F6o0VK3Y1ecFeoxn/TzOL872v9xG9C07OXQ8DgJxWjCWJWIObOEFTrDZXrhOFloWukj4+ppT2cDIt
 MmxNqGdK6XNnIBRypdI98AplYm/9lCYV9YOl+jj/bSw707bIDjgzzcfDnsEbWuRiTwJV7DCgbICbm
 XnKzc7axkwIrIfPc=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6R51-0008EI-Lo for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 11:12:05 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e6b885ef8so14592545e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 04:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789470717; x=1790075517; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0aVlFW/HAtKAXk/qdwVTC9zp7HKk5P1AhyeLobpVBas=;
 b=GyDLRO9F6K6rjrdYR7SZWD+7+0vpyCCxmtRyJBqARBSppW/pT/vFheZ5V1BVQ+Un/6
 Y8XKzjfbyjSjXkhIBz6O4xmyey/v5m9n5yGjPjvD3dZMIK8IrTdwBa9b0dT+w31z56Uh
 AvWCy8VbRHW08HIxxht9T68Z5zAqtH8aktOtOScQvZJkLFVH37d5HBzm0hBnnzHFNIVB
 MWHO5F++erjotKOxa64y2WJOOWv7O9sTyhw9zsjBkPMkGHXorQ1DyG8FTvIFQCRpkeZg
 mjO5dqPtoqcZvk0tixfCb0RId6/0+e+Vx4ZuZ6e6/BIrcTALaoac/zhsanBa550bK4e9
 oqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789470717; x=1790075517;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0aVlFW/HAtKAXk/qdwVTC9zp7HKk5P1AhyeLobpVBas=;
 b=Niz06YJ9pmvdNTajGyecR+x0ZSZpQXCsdfHDxbJPKcZA8GzMjgj+lRuef23sI1q45z
 RDYnkcsxngxUVjDElxe5/SzrRXCDqhKIthRcY0k1wvkxctMPnxwmOZonTvHCL2/uzpX7
 rPT7S9f9EEMi0/xEiNQVb6A1duSVnKZ2Nk3D4yjwxDHpzhbNRju5XHv8CX7zUsM6OcdM
 wJZ/QHAUOmoz7bBPH2hJfaFcRcPW5cg9i4GVTQwQgEHuO3XcKyYTn6rzZ/1Sy3h4bVm3
 DQcxZAG/zq/DRA8U2hSwlejzp+F/86ebQ9RD2EXgbPBMqV337K5HZfBOjUUyKpUuuDnV
 cFNQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxyQTYiFzSycsMHeDcSJrLqx+CdcnzWoFqzk7JtbX5nYw/Tju6Iq6aUCgn7OU6+ka9rrWzDUGhUPa0YXZOx@lists.sourceforge.net
X-Gm-Message-State: AFuF++k0RtKJun0zU1eDlykZs0FkL+bE6YWd2RT1Izjmq6m7COP6lGiJ
 VOhR785zmv+JYZ6DuW/6nTJSgytqSfUvYKbpdajmTG8rDuTvSVH8GOrfYL3Iv87UGvLUGWM6OkJ
 WP/vrbPXNCvFM9o6uq+bBgL2kFrn5ZWG7ZfmSgImmdSnny448Oxz4FvXIxsF43CMf/2f0VKTf+n
 v6MaaW8A==
X-Gm-Gg: AYBFou2lWCRsNgi72FOXB2pWimEjpeAHb+zIr7WNgJ/bLdt5Yp9bRnJlQnKEMtouNEN
 oXSMIYpASgpAzV1ncxefHpFwUFzNyaSmzPWOa6UuyajkU/pjKX6Yo6FzGZrWGaUgEnz3X4dOLpH
 2yn63kIjG8+Fd+eahCUsoMZa71e68sIGCr3d/h+qU0QE34oMQwrDmd+nXwn1j/tUIOHKAs9bNYh
 FYxmylTXlWi9J2ymANHZJcFBHKUdZeG2s59keEF4Ehh5FAYnX8iut5gyivo1HMI8lJqu5Rq/ELh
 WWj4StuJ1E4vF6S5oE3KcN9yqiPctxHWw7BM6P/9vXMtXZL7O/ITw1WeOm0Zs219blV3roYEzZI
 WlFGEVHDewCFwG9pYn/vUxnfVXITlfr507kuuelXPYGQ69OzirnXZXQWWQEMIpI/jYSDWZAV6Nf
 6teElwNtTOPFZN6vQeJjK7ugW/4W+xv+ENT2/0gviXspHl5CTTBPd9ZFOu7ox2wB3TLcTs5K3pO
 4DcwvJo53OGNosP2X6JP6ZwJUmv3CSIJalgGVc8c0ycvDbqdYYrK/M1PmylN/joROz0mdptcHDB
 BvZs2mLMN9hp4cyf+CVwUMHzw0EAVIgOmPqVEKSq9uW0I7opOpTTk5RpTFB2PX0=
X-Received: by 2002:a05:600c:198d:b0:49e:6861:50f7 with SMTP id
 5b1f17b1804b1-49e7a65c9abmr77923035e9.5.1789470717024; 
 Tue, 15 Sep 2026 04:11:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7ef74a5dsm51200605e9.7.2026.09.15.04.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 04:11:56 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 15 Sep 2026 11:11:55 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iac6d49d064215510bde9a4cd4600ab3a50a45cb4
X-Gerrit-Change-Number: 1916
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1916?usp=email>
X-Gerrit-Commit: 65262c0afd5095fa68f320d23fdacd1b8c8a8e92
X-Gerrit-Comment-Date: Tue, 15 Sep 2026 11:11:55 +0000
In-Reply-To: <gerrit.1789456688000.Iac6d49d064215510bde9a4cd4600ab3a50a45cb4@gerrit.openvpn.net>
References: <gerrit.1789456688000.Iac6d49d064215510bde9a4cd4600ab3a50a45cb4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5NDU2Njg4MDAwLklhYzZkNDlkMDY0MjE1NTEwYmRlOWE0Y2Q0NjAwYWIzYTUwYTQ1Y2I0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e7005c7cb3c7505d2d57adb3d8f2cdb76bcf799d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6R51-0008EI-Lo
Subject: [Openvpn-devel] [M] Change in openvpn[master]: ssl: do not trust
 the peer's request to resend the wrapped client key
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6136816771521898662=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6136816771521898662==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7ixCBcqgZ7Q="; charset=UTF-8

--7ixCBcqgZ7Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

stipa has posted commen=
ts on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
916?usp=3Demail )

Change subject: ssl: do not trust the peer's request to =
resend the wrapped client key
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 2:

(2 comments)

File src/openvpn/ssl=2Ec:

ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1916/comment/a53010cb_09d451a0?usp=
=3Demail :
PS2, Line 2625:                      * promising a key we do not=
 have=2E */
> This is quite strangely written and talks about the client it=
self in a weird 3rd person and does not [=E2=80=A6]
Agreed, will simplify t=
he comment=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1916/comment/b82c=
ac22_b1a27396?usp=3Demail :
PS2, Line 2685:            && session->tls_wrap=
=2Etls_crypt_v2_wkc;
> I don't particulary like mixing in this condition in=
to this condition as it now does not really matc [=E2=80=A6]
Dropped, along=
 with the parameter and the three call sites=2E

Note that tls_wrap_control=
(), which prints this message, doesn't cover the two call sites in write_ou=
tgoing_tls_ciphertext()=2E They read the key with buf_len() before anything=
 is wrapped, and buf_len() is not NULL-safe=2E The check in parse_early_neg=
otiation_tlvs() is what keeps those safe, so I kept it=2E



-- 
To view, v=
isit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1916?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: Iac6d49d064215510bde9a4cd4600ab3a50a=
45cb4
Gerrit-Change-Number: 1916
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <ls=
tipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue=
, 15 Sep 2026 11:11:55 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
=
Comment-In-Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg>

--7ixCBcqgZ7Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1916?usp=3Demail">View Change</a></p><p>2 comments:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1916/comme=
nt/a53010cb_09d451a0?usp=3Demail">Patch Set #2, Line 2625:</a> <code style=
=3D"font-family:monospace,monospace">                     * promising a key=
 we do not have=2E */</code></p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">This is quite strangely written=
 and talks about the client itself in a weird 3rd person and does not [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Agreed, will simplify the comment=2E</p></li><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1916/comment/b82cac22_b=
1a27396?usp=3Demail">Patch Set #2, Line 2685:</a> <code style=3D"font-famil=
y:monospace,monospace">           &amp;&amp; session-&gt;tls_wrap=2Etls_cry=
pt_v2_wkc;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; m=
argin: 10px 0; padding: 0 10px;">I don&#39;t particulary like mixing in thi=
s condition into this condition as it now does not really matc [=E2=80=A6]<=
/blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">Dropped, along with the parameter and the three call sites=
=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Note that tls_wrap_control(), which prints this message, doesn&#39;=
t cover the two call sites in write_outgoing_tls_ciphertext()=2E They read =
the key with buf_len() before anything is wrapped, and buf_len() is not NUL=
L-safe=2E The check in parse_early_negotiation_tlvs() is what keeps those s=
afe, so I kept it=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1916?usp=3Demail">change 1916</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1916?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iac6d49d0=
64215510bde9a4cd4600ab3a50a45cb4 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1916 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmai=
l=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Tue, 15 Sep 2026 11:11:55 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No =
</div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--7ixCBcqgZ7Q=--


--===============6136816771521898662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6136816771521898662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6136816771521898662==--

