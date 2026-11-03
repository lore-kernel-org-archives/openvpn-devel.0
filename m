Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB43E606B24F
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mBhz1Ht3;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=clW9ZEQt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gBzMJtF6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=eqiSYw8t
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Gkd7Bt9AqOdS20iDTGvZDOKGbZEY4EFgEE9/W3bVZMg=; b=mBhz1Ht3RkEkdJqM3YVwVj+W7/
	PWcVEV267secE8+4CtYFhMg2ysddtlEiTFMAaitA6lOGxijW0Bw8gS03JpTKVE8QmRWrvOdDcY7MF
	lfTBPYeyGhsHS9nAZ2zJAINVE518cAKwPVpjrxfiPpvzjSBJf+57lhFdjCBf/id1lvyY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOGEb-000000002Pd-2Nk5;
	Tue, 03 Nov 2026 15:15:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOGEa-000000002Ou-0KNc
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:15:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VDgTUzC5cmk6Wj9RuCbcVAyDTi2i7osVJGIDmU7n47A=; b=clW9ZEQtzeQNAtlxBuJqFgoFCw
 Xk/mK6cN6Mv0wqpxoI8AUkibQvBgGzE74PbZwbdMH7ysRLkc6NEb4PP6q0CfaubAtI9u710ELhSH1
 LBq4/vXOcpfBp5+hies93dSQupLSSb4X4CviEIImNIDBf4I3g2VWezv3IPWaB4SHM4b0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VDgTUzC5cmk6Wj9RuCbcVAyDTi2i7osVJGIDmU7n47A=; b=gBzMJtF6cxOIO222MDwekBEhCV
 IwhCzFiWK19wpMsjb94W8SWPn8pnXldoHs16jPBj1TJnONTn8Z5gj4EN0kEPkprRixZ1iOYcpxj24
 HJbUujWgxhcklDZ7LRnYdMO4umJBDmQ6XWDdIuxQEgnAuy0hw1EmaFhhIeLjZDb6Vkoo=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOGEY-000000005xh-1ojF for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:15:36 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so34868475e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 07:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793718927; x=1794323727; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VDgTUzC5cmk6Wj9RuCbcVAyDTi2i7osVJGIDmU7n47A=;
 b=eqiSYw8tVn6htBXcARJIuR3Q75M0qiIDbrh601dXtPYbTePF9kkWcyyVUbXGugYKDE
 sj74CllN7hj4ZSPtMLN3fPh61wnFiCU4gRQ5IW+U1Z4CfXr21FBjxK9E9Nxi9xMS4Xcx
 NeR3lbdDqIihA9Z/Jbz5pz884vjvepH6rQP43yie4mfHEYkf7WC8ThkRkBtpnp+qq7oO
 gvUUrvd9gPVQ3DV43pBcM4XWZVgvqi7feEet/DXLyIOUxsuFV4E72QTQn6Es2R1zy0nQ
 oLS6Cu7xI0lfAlXeQnLlsLHl9yO9bR6c7ZnlRS4nfXc63KCXYuwdCIbcO4B/k6tX3gnt
 YzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793718928; x=1794323728;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VDgTUzC5cmk6Wj9RuCbcVAyDTi2i7osVJGIDmU7n47A=;
 b=tpqwmzvByfHck0y4F4gt3QsKXxI5HySsxImGv8Bb/Q85oAkYgi7gv9i0FZz+O/XvbD
 j/ScWhuNCZlz3SoxTFFsUD7pIrN+oR7Sbn4VVXL0ipl0vcKVvR8cNrWXggZVchlc2tdD
 ojnHV1TLTqN/Y2sA1vtn2JQWOIztFV7Ppjp+72eOAU/e2COrTqY7Fhhp/NY4EJYkkVe5
 0gHiRIqCDtCj6Y+41otfV0PyyR8NyJYsJEnUpuy5EKxwzfJ+pFEZdIXk8Lh+f4l20pKC
 OeOJC6KOyoinZVC/Pe914m5Wlugx2vFyRI0jUA5vktxh6nS9hBDhmp4pgxpWAieZxtGn
 hfsg==
X-Gm-Message-State: APuU4Z8bDpm3ucKQFUS6lglF2t/4MPk8ojPsbiITKR0LAoGMOb74JBjg
 m4wc3XsWJPIpSNmx1JllfxuQJ4RzlUp71QSZ2s053sSpanHjq+Mqgs+DFhorzItMySTQufY8ifk
 MwOg8qCj4InhcWbc0x14Gqhjk6nWfiseeBhPgBu9lLaa4OPKATKwm2MEIWiwmKkIeoJB5NHj3xc
 Zzgte9Xw==
X-Gm-Gg: AYBFou0Fel0oKIei4xf1mXsz5VOXVV9Fl8hht+OopNTEyg9Ws+UG8q+SnMxMGwb7BeR
 Z6GthinmtrNcHgxuYazIgOiQl7vzqnGRy0HUvxc/wegg8gTT01O8LVqSFYWX9bnE6OJOEmn5nuf
 vuzEvZOcOEg4WUqn0Br2/VIZUj4FHOIEymKICb4D+y/J4I0sakmuQs08mNA0Kj1533+hdn/mcPl
 dDbd1l+8fBpeoMAX23eCAAXh11VeDNDzaPTmxl89FVnm9l++XFPKCmYWkhoMD9WrkWSmySDA5Nd
 55bSxz4+AsQ1pIb0cGBOBQHSbJPEWpeb4FmlQnGouCwJvreVmnAwLJ3o3tP5xUTp2mjcIkBYCUY
 NHChzuW5Mu2socsXvMjLjtkYRwZM380DoJ3lqVzbXr4ASo//641/Pz4xDA4k8MOXh87V0cypC3B
 V0w5Izq3LgynrTr4T68Kgkuh3+WtjWjzXdNzL2fNPgJluo+JYdK4IuKSr+uK8g8MeP4ZM6pVGJi
 niMcWmv2hmkw2MAtEfOFhKYeiLYWUUtOLyzqVjP1eogSd3KYlZKFUNshGqoWLh9aqKi3+1B45IE
 x4U8G46e5l8WwNp+PB04lwHIv0tlfRJXYFopOfxSa0o+OMuwYUnXCw4UwdxIo+Jlo9P8D1FLgH9
 QWWV0I8q5oI8EReGE4pH9w/wr84oZehcnvRxlwdZpciuMu+Lw6W11USZ0yB7nlKwGG4eE8WJZKU
 z1t+mvpyrH4uCFUg==
X-Received: by 2002:a05:600c:6387:b0:4a2:150f:1605 with SMTP id
 5b1f17b1804b1-4ac1904a81amr310544835e9.24.1793718927279; 
 Tue, 03 Nov 2026 07:15:27 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2aa5781c9sm70693865e9.8.2026.11.03.07.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 07:15:26 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 15:15:25 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I440c4c73865fdbd80f2c607e83c50e345a0e2438
X-Gerrit-Change-Number: 1950
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1950?usp=email>
X-Gerrit-Commit: 0a02cbf3958351561dd611c2db807ec9b16215bc
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 15:15:25 +0000
In-Reply-To: <gerrit.1790329891000.I440c4c73865fdbd80f2c607e83c50e345a0e2438@gerrit.openvpn.net>
References: <gerrit.1790329891000.I440c4c73865fdbd80f2c607e83c50e345a0e2438@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzI5ODkxMDAwLkk0NDBjNGM3Mzg2NWZkYmQ4MGYyYzYwN2U4M2M1MGUzNDVhMGUyNDM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <32d5ea9026e212ff96bc648d94887aa49d7866af-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOGEY-000000005xh-1ojF
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Do not look up the
 "none" cipher in OpenSSL
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6136699568672972614=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6136699568672972614==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oApRVpHEAVg="; charset=UTF-8

--oApRVpHEAVg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

R=C4=83zvan Cojocaru=
 has posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1950?usp=3Demail )

Change subject: Do not look up=
 the "none" cipher in OpenSSL
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
To view, visit https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I440c4c73865fdbd80f2c607e83c50e345a0e2438
Gerrit=
-Change-Number: 1950
Gerrit-PatchSet: 3
Gerrit-Owner: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-=
Date: Tue, 03 Nov 2026 15:15:25 +0000
Gerrit-HasComments: No
Gerrit-Has-Lab=
els: Yes

--oApRVpHEAVg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru has post=
ed comments on this change by Arne Schwabe=2E</p><p>Patch set 3:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=3Demail">View Change</a></p><ul=
 style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=3Demail">change 1950</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I440=
c4c73865fdbd80f2c607e83c50e345a0e2438 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1950 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Comment-Date: Tue, 03 Nov 2026 15:15:25 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none=
"> Gerrit-Has-Labels: Yes </div>

</body></html>
--oApRVpHEAVg=--


--===============6136699568672972614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6136699568672972614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6136699568672972614==--

