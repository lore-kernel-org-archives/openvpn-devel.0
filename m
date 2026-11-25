Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1102606A31E
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 23:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=g/a+iLaW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DEWtZNVB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ddtfYNv7;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VKJBwwCB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XbdDWSuKa0VclhGDd8KhiV6f92N9k69y02wntkUoY88=; b=g/a+iLaWga5XcberQv8wpn9IpK
	CKcAfd3vfK2Ww1Grt0qTWPRRv0Jql8WF0UG7s2UTycssIbaQ6GHFRmkQdnjvPi5xkVLuPY3tLQDsS
	eiDlk3WFxtTc2COlNgLGrdZ7AQ7vBTLruarI1WaYVvn855xG3MbNSvwbG5O8ewh4NZ7s=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWMDX-000000007ta-30yO;
	Wed, 25 Nov 2026 23:15:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWMDW-000000007tT-09Lv
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 23:15:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0KMDo5GzxiyRsqUQLu6+ZWjSx6Kfk9Jz2OEJlXuvkxw=; b=DEWtZNVBnXu6pWdJV1v1NY8tEF
 g7vQi1UQTNJXwiRASOqOLDmFl5dNahJK9a7oaWSBv2Pjn6fZRH4JvqxuvBDfn0JIjH2VqDI1ordDq
 jRYi/MAZG3eSXRSGmaMhnRRFDzFJ7UO5tSBZrtaP+zWra5ao3Q01VprKo97GK5HH70Dw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0KMDo5GzxiyRsqUQLu6+ZWjSx6Kfk9Jz2OEJlXuvkxw=; b=ddtfYNv7gujPlmK3rznMNsojiD
 qjwiQZUwVMjMSAEU/rcswkZpgc3QGT40sN3cKHXVelNfRH6Keb8xvJrPuSP28ZntwJg7xkrR0lwo6
 l9ZVTLSll9vcvPOsJxzhhT7HWlXQLPcrkWVZCLTQhhSMGlXXkSV++GP7szGiNX2sOhik=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWMDU-000000007UX-0Krp for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 23:15:57 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4bb5b8ef642so56807865e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 15:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795648549; x=1796253349; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0KMDo5GzxiyRsqUQLu6+ZWjSx6Kfk9Jz2OEJlXuvkxw=;
 b=VKJBwwCB2YXcxoxSCS8sr6uXRYaA6aDUnPWgfljTPDxqk5/FL6rGRUxJq7tLc0a4eO
 dQO45Kesola/I6EusJc7t/TkWimHYTYLnzIx+WlZtOqTSlsz7LRMnz4HWFt4q/FpU3Rc
 xRdpYf54K9z0mqLlW4RtpPCVYb3X+en4viE5cOdczYUjGjR83rqALikuoCAtFGZrXEDl
 miG+uaY9Lkg3RIPheLiNZNdlYFV+/vJVA51RXKNJY9CJiZmRk10o0+eZBQyT0Ae35DNH
 ZIQkX/mi8O53Tw2Ij/00+5yDBycqyK3R12pQqxihOjvUeG3KBBs9TWcWPCeNwX/66evn
 tQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795648549; x=1796253349;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0KMDo5GzxiyRsqUQLu6+ZWjSx6Kfk9Jz2OEJlXuvkxw=;
 b=u44yWTCn9M3v5hHXJ0gSlSfDa3h9jitbkJNjw2N7M4IAASD54hVRiS0tZzB8yPOnAV
 +CRSpEoJovX8HzS+CwB7gxtwxp69ezOIJmBUs+wVJUyPR682ItgBdw2oDR1b2q6QpANy
 xAoeAYjTO/028hAjbo8C1ehQI/SRgYcmVQ204plwfiWzLIQvwOkznsZI83haZTH88PWD
 00XupLa4JA4GeKC/61KqGfceg2WdtD8rEYLUgqOvpQHp/ItJde/+MbuHVH+kYmz+F9JM
 4nXrUcU7ChxvAay9pPap3O/gj0OIuLmlb/P/aRDCJYmRyjO6jTQIvsnq53jPbkN2FtwJ
 uuvw==
X-Forwarded-Encrypted: i=1;
 AL+hErHU2TSUHUrKhc79AcN9T2LqkYSEdmp88Ivsy0m4LvSnTk2H6eaMeLWSptmRTGQezBM1/igInsuex3asmBtJ@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8irNhwcd7ncDVdgOzMqSVUt1tO2q4VeOKcAU9NRvVO/ENCFsQ+
 7dFtlHRtAHRpFjcdswh1TGaMxhXFMYrjaoToXFcdxhWS00yirvMGQPiR3Z1qgpnQDR6R1NzH0Kq
 RkkHvkF0z0pt5UXajG253wfB9wgBf3BwbsQHFNLN0QD3tJYVMSPC3FY8mRG1lHOHpagB2
X-Gm-Gg: AZFdTZdhtvNB4ncBMBrtN8QXq+N9dJPX/zbqQJWuewyAGhrSnHdROFA9Hg9a5JlDzll
 jOWzfxZlHakf0XOcUvqiRJgsAiKhUmO7eaSkZat64iWdJnSeGG3Net5ln/Selt5QrPADutvAPNL
 EhgaNIljMuxSdXswRgAZPQ6OMDwVxusQZ94EpYEwZD+jHjqIqBOm4+av9VbgsGhEVgJcsYhHPvi
 AguhTcqN1TWZUasMf1HTi2P6ta0oyuJbBLlAAbdTk6v/KTy26Wa1gnwyZv6GvdzO/A7ZB+T1UIK
 pag386CjohB8WkarW3CyrzjZYwtvWOKhXo2+UqqJ1vs8ASZ2gGRaiTlC2x6ON3UY4jg52xFPT7S
 SSDpcjpUFy+I1kZUiv5vVRowBcuWf3pk1Cks0Q6uwIt/9hL6kbaowNndZM6slnvv8DZN5dDYpLe
 jnIBn+TOOkuXkK3D2MF0U8KxKVRrTTq9YzbA52pjjdStafZkfDUG7BbZeCHBvdfmLtZj/rASTIj
 I+YB01jizqmoOj5AUKhYdLTtA52x3UNESD1J96b2IAlOvDnzG9sxr62Mk0ndUNYpDRVkdcwM/PY
 0gvIy7NcQ3TKsrsMSRiE+9Uk5E+o1tHDjcEI/7XOMnAb50cfOsxrqITQSCHnA0S0WhgjoZ+olRw
 nDWFWvMjPjCMbTO8oX/hry/pqknBw9d3TqtjBMwmpOfttQPgmJxPjIagh21Z6fdD0soTFka7m+Z
 Xj94YED3jxcRKSwUM=
X-Received: by 2002:a05:600d:9:b0:4bb:aa4f:c025 with SMTP id
 5b1f17b1804b1-4bbaa4fc0f1mr18217495e9.1.1795648548989; 
 Wed, 25 Nov 2026 15:15:48 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b09bsm1024810705e9.4.2026.11.25.15.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 15:15:48 -0800 (PST)
X-Google-Original-From: "Deri Haerudi (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 23:15:46 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Id05f3e4e32aeb806d762858e754adc82f42d4371
X-Gerrit-Change-Number: 2341
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2341?usp=email>
X-Gerrit-Commit: cafe4eab2d6f519bde8d4ebef000ab02a8e66006
X-Gerrit-Comment-Date: Wed, 25 Nov 2026 23:15:46 +0000
In-Reply-To: <gerrit.1795562472000.Id05f3e4e32aeb806d762858e754adc82f42d4371@gerrit.openvpn.net>
References: <gerrit.1795562472000.Id05f3e4e32aeb806d762858e754adc82f42d4371@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTYyNDcyMDAwLklkMDVmM2U0ZTMyYWViODA2ZDc2Mjg1OGU3NTRhZGM4MmY0MmQ0MzcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d4f5d2dc3e588538bc392dcb50be5c4e395a2d80-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xWMDU-000000007UX-0Krp
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dns-scripts: parse
 dns_vars_file as data instead of sourcing it
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Deri Haerudi \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: abcderyscreenprinting@gmail.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 heiko@ist.eigentlich.net
Cc: "Deri Haerudi \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4368656508767089783=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4368656508767089783==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="laCZIa7tado="; charset=UTF-8

--laCZIa7tado=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Deri Haerudi has pos=
ted comments on this change by Deri Haerudi=2E ( https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2341?usp=3Demail )

Change subject: dns-scripts: parse d=
ns_vars_file as data instead of sourcing it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

Thanks Heiko, that sounds li=
ke the better fix=2E Passing the variables
directly also gets rid of the pa=
th the runner currently trusts, which
this change could only document as le=
ft over=2E I'll review your change
when it's up=2E

If anything from this o=
ne is still useful on top of yours, for example
the dev handling in the dns=
-down sed calls, I can rebase that as a
separate change=2E Otherwise I'm fi=
ne with dropping this one once yours
lands, whichever you and Gert prefer=
=2E


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Ger=
rit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id05f3e4e32aeb=
806d762858e754adc82f42d4371
Gerrit-Change-Number: 2341
Gerrit-PatchSet: 3
G=
errit-Owner: Deri Haerudi <abcderyscreenprinting@gmail=2Ecom>
Gerrit-Review=
er: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan =
Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: Heiko Hund <heiko@ist=2Eeigentl=
ich=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comme=
nt-Date: Wed, 25 Nov 2026 23:15:46 +0000
Gerrit-HasComments: No
Gerrit-Has-=
Labels: No

--laCZIa7tado=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Deri Haerudi has posted comme=
nts on this change by Deri Haerudi=2E</p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Thanks Heiko, that sounds like th=
e better fix=2E Passing the variables<br>directly also gets rid of the path=
 the runner currently trusts, which<br>this change could only document as l=
eft over=2E I&#39;ll review your change<br>when it&#39;s up=2E</p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">If anyt=
hing from this one is still useful on top of yours, for example<br>the dev =
handling in the dns-down sed calls, I can rebase that as a<br>separate chan=
ge=2E Otherwise I&#39;m fine with dropping this one once yours<br>lands, wh=
ichever you and Gert prefer=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2341?usp=3Demail">View Change</a></p><ul style=3D"list-styl=
e: none; padding: 0;"></ul><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2341?usp=3Demail">change 2341</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Id05f3e4e32aeb806d7628=
58e754adc82f42d4371 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 2341 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div =
style=3D"display:none"> Gerrit-Owner: Deri Haerudi &lt;abcderyscreenprintin=
g@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: Heiko Hund &lt;heiko@ist=2Eeig=
entlich=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 25 Nov 20=
26 23:15:46 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: N=
o </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body>=
</html>
--laCZIa7tado=--


--===============4368656508767089783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4368656508767089783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4368656508767089783==--

