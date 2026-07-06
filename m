Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF95CC43458
	for <openvpn-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RwsCSslvefK6P3s5SlEuSrFapikUKIZsyHd6+Iaz2HU=; b=cT2aGGBKKnwQ/1QdRcYzFFX69T
	1sm22SMKTruUMNvqLMCxqAO5jFCYDQQ43F6zazFVDnc6VwLsmzzu2Amu7AffyqnWs/z6fTMpqfyv0
	TH5wHh0DATGFNLZWUL/ympwr0WluhqsUvOAwTaueAu474UjgvaryOZtLNfI68YhIT34Q=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wgiDM-0007p4-T9;
	Mon, 06 Jul 2026 12:14:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wgiDL-0007ox-4x
 for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 12:14:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cZrKN9Abpp/0oquHxGzM0JiBUzDWmL6E3DCGG1wfu3k=; b=B97scACYFTAsm9CcuhcOrfUpkX
 i5C1Sg5HNvn15N4b61Ms8uOHD6cmBlb0HVomRQFpmwF5ipW4s0wVOHO0YH8T9wcwv1LN5XB+z5QJH
 QmHlYNNle6IHbT8v4iCAtOG/ThWJrbgOkef6gWT8QJ3qsnUxfB8LDCUFP5fH4+nqwGsQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cZrKN9Abpp/0oquHxGzM0JiBUzDWmL6E3DCGG1wfu3k=; b=L
 Oa+GedvJikYtvQiXIh6NOLMfI9Ci8NJPCcLsebZ8xXe0evrgFxeOQPamfw2EMnFz+Qt3ZAYjXCEUn
 5mkp24RVIwpGv+7MRTYD4qcDemv9JwR9LVkQ41FC81MSmBx7N/yF83Y1IKBa3j4jAD/a0gYUQFhhj
 iNkv02Nks4XeCYL4=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wgiDK-0002KR-5S for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 12:14:19 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-493bb510ce4so22378245e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 06 Jul 2026 05:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783340047; x=1783944847; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cZrKN9Abpp/0oquHxGzM0JiBUzDWmL6E3DCGG1wfu3k=;
 b=W4HAxa/YISTJxos3hhJxitbA6zJT8tr3q8k/ofxqr+xJxoImOzu8cb8AXvFhSTC13O
 kq6ORUGZlum1gPrCSKfKXw9caQHvy6QomaS3HGB6dTF09GaOZexwxfH9w5bT7Pqa7f6H
 TjFuOU667HCHW3h7g7I33xCJ+wXKjKkYQ4fILzg6JhVZxOo+XuzUS0Ys26Jq/JICfQ/p
 Uf0se6UtgNwd8BN5v1LVNOuM+mMiA5818W3gmpvvsS/JTfultkzoejg+x/9U6mMfyZsO
 H6hazF8Xm6iUNklowKs32XPlQc7r/pkCKcND2e/jsDC9NL4N9T/58jLcejqaRLp2VZ+r
 wESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783340047; x=1783944847;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cZrKN9Abpp/0oquHxGzM0JiBUzDWmL6E3DCGG1wfu3k=;
 b=FU6/fn4JsUe0UBsIkFOy72pjsbULPCTTIK6kpS4uYDZzMV5bBEsb3WaZnErBFwfSWV
 UwTKifNwSrEH9HazZ5WlXTJ7fOuRjGwCkqDcNpxU991a/aznJOlmbQsSmQDVmFk2tArL
 vyoZW4X7Uv8xwLWmYYnhKApZmGTayF0EpAH/w93Cty62RQq8T8pBeU2zqLB9dwiVNL76
 UhfuLbyUbMfwgk5mOtIv6k2yi0bBqLowcKPPdKVA4iKdmjoXqKsIxV1WKWKrkIWeInVn
 UIktXte1sc5HphjTmgjJb/G1FTtIon6/kpiPp5+bK+f0R5xDBAw6UhCoTMowyhlg82wc
 yy0Q==
X-Gm-Message-State: AOJu0YzeSssjcyf0ZrQAi0DLKcgHhuxQN9W5xQcMT9b555aJyhkQEI+d
 3fMMtqvLC4grxaZHpFHiHcVTO/t+AvfZGAas3D3b3Sd4nIiZLbs3qe+wb2UG0BrV8PuXMMkfyWx
 /KKwrA7hFfZ4FzHWpRXXwODGy/xmQjVrOziTziavHubl5Em9reBnfRnW/vxVGK9erpTx68Fb0ms
 b/HkQ9oQ==
X-Gm-Gg: AfdE7clUTuQI7KQHNkqavBzXG7hiAIdPrtjSgEcg2aTeT5keU2J11jLutmRzibBnCsW
 alHnMG4iMI1NR664fAVz70yBkeDWHxlv4adnBivWPtEa7VpF+ETR4XGYqW4aJOPBYFKpZkFFdZq
 cFMIzfJEDnuWl9X0krWh4wWw8feudL5q7U+L41lgHVU+O84cxKxBOyJPKlzQCdDDl2IxmeFn95h
 XMWBahKHcwFdm5SPy4Iy0eFUcEShQbd17FHXj760P+Sa6HA0byoeZQy53ji4WpN86eOPiGjyXEu
 IZX3QbW7yS0eC+dgSP+Ub3DEvg4EAeL1RFH9eIVr8wc4iVhEh8w3rHitKK7m/CFlJidT/wKOzyQ
 bBi+GXDg91wOS+Dt4H/5xCh9oYVFZOEA+FZHqVHtFfvaYcMmrtpbeFX1vvvrYXUvVQ/Sd2evNk5
 bLQWJ2rgpKKyrgJMcAWLf+TPatzN34sH3yNCG/gczisNa9TpfuVjC12L7umDC6iWSWfDiO2O85H
 lfJ7TYORnW7TG/CmtnM5GyT+9+fzLaSYM/EYj3aRmbS/YtthYIhWpPp+8LVB3sbO4XbT34tFYuW
 usVNzVyrXcA3Hw==
X-Received: by 2002:a05:600c:8b2f:b0:493:ae5d:8c40 with SMTP id
 5b1f17b1804b1-493df06bae6mr1863565e9.27.1783340046906; 
 Mon, 06 Jul 2026 05:14:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63bf7efsm370671225e9.14.2026.07.06.05.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 05:14:06 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 6 Jul 2026 12:14:05 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e
X-Gerrit-Change-Number: 1723
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1723?usp=email>
X-Gerrit-Commit: b418167638991954a02dc17e3c4e4b5953a07e88
X-Gerrit-Comment-Date: Mon, 6 Jul 2026 12:14:05 +0000
In-Reply-To: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
References: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzZDUyYzZkMDA4NTAyMjkzYzNlYzU3YWQyMmQxYzYxM2RjZDFhOTRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <01a5b9eba2be20d01389b1b7d901382a2920561d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wgiDK-0002KR-5S
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Extract
 multi_check_dest_addr_allowed from multi_process_float
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2222731465471718241=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2222731465471718241==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="C0/bVhpkKTk="; charset=UTF-8

--C0/bVhpkKTk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

flichtenheld has posted comments on this change by plaisthos=2E ( http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail )

Change subject: Extrac=
t multi_check_dest_addr_allowed from multi_process_float
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: -Code-Review


--=
 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3d52c6d008502293c3ec57a=
d22d1c613dcd1a94e
Gerrit-Change-Number: 1723
Gerrit-PatchSet: 3
Gerrit-Owne=
r: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Comment-Date: Mon, 06 Jul 2026 12:14:05 +0000
Gerrit-=
HasComments: No
Gerrit-Has-Labels: Yes

--C0/bVhpkKTk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Patch set 3:<span=
 style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding=
: 4px;background-color: #ddd;">-Code-Review</span></p><p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail">View Change</a></p><ul=
 style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail">change 1723</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3d52c6d0=
08502293c3ec57ad22d1c613dcd1a94e </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1723 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3=
 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: f=
lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 06 Jul 202=
6 12:14:05 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No=
 </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body>=
</html>
--C0/bVhpkKTk=--


--===============2222731465471718241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2222731465471718241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2222731465471718241==--

