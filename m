Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14396606A324
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 02:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=L9h+cYDv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DJDWwwdO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cqTkBgYH;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=OdGHP0uN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=cqQUVkfhFYFLqRPa/OtBNDjrBd9FduYwBHseYhu4CmY=; b=L9h+cYDvGsRoSsXJvDXq7FWIgt
	u3mzxjWfaITLgi9QcTdri76kEVkkbPRm/1lkLoqpsIz1OrqCXuZlc0KpkjVd9fb5LPHHTjoRobdr3
	ipbIBFWfnubv2Qb+MZ/ZdoCQQx3x3UxElKOffAUrJRTtJMAeOwy852YXzIjFoWVIKdxU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xO4O8-000000003Bd-1A27;
	Tue, 03 Nov 2026 02:36:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xO4O6-000000003BP-3gWO
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 02:36:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sCUBsHDPS4ktLA3UJHHlS3nMqkMfRGcNU7DF8Yn8l1E=; b=DJDWwwdOXa/gWRj1x+Jz6rOS6L
 sCIoFdEfIZCtR7B2x5AZeVXv5UIWAUdxirGjgrdIPvbp7vDeYhEppaTXSZDFrIGP1wtXrl6k0Tnnn
 zzyayP/MSo4AOlN/Jvw1jBfyvWrNMxK/sdFJE/tMRUNL0F7A2ZbTq2p7eRDShHfcgxjs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sCUBsHDPS4ktLA3UJHHlS3nMqkMfRGcNU7DF8Yn8l1E=; b=cqTkBgYHGeez7vybPqU4VY0S3p
 0XYz6Q6iz67mNJf6BLs95rD995zgq/8Z9EJe8M+gkj8fSeY5+vzSJi5y9AaBBG1U982zmJKN4GY+W
 ZRoXJtceN1Qz8/mJafoIaxEYE2gVzpPf2+7QaL6O36uY7AhAkO7e46cmn8Xu17GpxPVY=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xO4O4-000000004ru-39QS for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 02:36:38 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so2572335e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 18:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793673390; x=1794278190; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sCUBsHDPS4ktLA3UJHHlS3nMqkMfRGcNU7DF8Yn8l1E=;
 b=OdGHP0uNdDyjgjPOQVbwGc0QzbwS/pT13utJXyBbt5qut7QaPwzX6USOfP576RRAF5
 EG9cbBmsxN1CES1gN8YWrzUc73fjMYrMU4YT9KRFOpgNOKdd/6AM7R/uuDgzMNUk6WHp
 5lxqGuybAhjDF3L3lRtrUmzYaP5qa2FlCunkaFmszNWIt87YFn3peNbCVrGR+QcFPjLk
 4xI6MgIcp16UMxKZZOO8fXL1ktGOTH1laKqDHZOuAdUYwkT9sW+f9XX23YbXCGF14sgu
 3IzF6BSspa/mqw9KNAUpbK5W9jp6egqb8t6FFxVLvrsu19G6Dwl08rSGqr18J4IVYrAg
 k5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793673390; x=1794278190;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sCUBsHDPS4ktLA3UJHHlS3nMqkMfRGcNU7DF8Yn8l1E=;
 b=0TVRjvYW5jKeLLxheSabpJCNv1IVlKvBaJhrkI6wQNpeFyzlAcL9gDLzdzrkv5OVgN
 BYh6MJRpZj0X4VIfBgEA1BqYTvABH/f1vvbqza21pFfppjQHEdDjUk/jL/5cpY8yJ3+h
 NWr1c4P4uv4bRk2e/EKm8So4yfJN7zdtgF04q2cKkib2yhYMv09BM+BFff49uAUETEo2
 2gjG6MpxfuSnS9BHiGApDvXAJO7UxMBy9kYU4rxgANn2nQD667svmDoLBpb5x/khuqtS
 hhmUDvcW5iFCkOj/5pwJ7Y+YxmABeIVrmxIrs1SszvwTPPLMzKI6qg+bsF2X5O+Qag84
 saYA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzAFkTJA9ytHOw4FuvYg50umJWzsLvoMMgCXKxCvWoQQ8PYlzu7lKKBW0gVvdB6tui7ORWeoj2TCjopf/ZQ@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJ52QwoWE5lU2qw3peuF1ri71mSflWsYcmiqNll3lYpcEawQSVS
 5l/gdRPUh9o5JhkuozXGv0+XdexRoSJlFe61EET9ZS7GUFJDBSjaHjVwc/rLuNfNcAJxKR4iCfM
 iO1qwbyduC6PhWT+OfoqIUP7VJK8a9bHdwwV/4QfTtWve7YkwOEQMeJrkmiSIS+0KMr5B
X-Gm-Gg: AYBFou1vNz35+CshXROgVxX3cAEuw3TFzgDa8RrgiM3ZLCFxaOQFcmUndmurkksT0Xy
 Ze6hMibu5dYbYa+qQPnj1FVET5rqmhSN9TYGA5WLa0/Ddv5nkyFtu6f74nsro4YqEF9u7yhC7WB
 pl6bub8qpsSbRRNLtO0xIe8eSBq+R6slyyR1LmQEODVEdEGbxM0hP9U+xAuWFM79ljNpSRmq+kV
 t/JX0lPmhPPyvjlaOl/godA25B/Nvb5qvH9W7QWEis8+02XQVJgar1SQ6CXx3rCvFm6qhuN7XlD
 9Oz68ZUL7zIsvp0S4Y15uV5cQX8X3Xx3EPJuBaezXd2DZ630vrX9X4VgClsRNazAJbLqL9H2swf
 bLS+JcM8qC4RkCbSqJ12bsRYTlqsfweAy0tynSJVu5E1UD+Qw+n7zZS8SFHglcZnHxKqvzsBX+p
 FkZfjsXLsoz339y1mNSmC3jZbwO8OpmapxP9Et6xpCd9FyA305Y9/PHVPOpAMsAQ2xtReu3jMOf
 HdxlNQsBwxoLRPYkx7qcESeeVQrP6ZMr/atz/Y1EJ3x4i9V+zsWjdo0e9sB0T1m3vCrNovKAZpW
 FvJdDXEbKBFg+xKLJNnSYkge9G+24vCldbtiYmY0qKj+pugStpAkRFji4fAA2fQc9NnyMe4LeE+
 u6lOoNiPvlnv49BH7Id4j36Ldj7o9sCdutYOKT1vxOphZUe9HFfd/+Bu50gv1Txn1XekyTcmRlN
 4ygjPxhfGW/0x/mAHEsXLiI0wNoN7wlVdTIVE=
X-Received: by 2002:a05:600c:4687:b0:4a2:10f9:37db with SMTP id
 5b1f17b1804b1-4ac16fa4dadmr268917325e9.7.1793673390164; 
 Mon, 02 Nov 2026 18:36:30 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2ab00ff3dsm46575585e9.14.2026.11.02.18.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 18:36:29 -0800 (PST)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 02:36:25 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 25
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: a91bc1d13f39e6ec5e0dac0426c2cb4afe4ad3fe
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 02:36:25 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c6c478a82dc11cf788cc08d57896f0c318f020e3-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xO4O4-000000004ru-39QS
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement
 sending/receiving app custom control protocol messages
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "chugly \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: charlie.vigue@openvpn.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "chugly \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7878734196318519848=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7878734196318519848==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6L/BGn+xE7g="; charset=UTF-8

--6L/BGn+xE7g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

c=
hugly has posted comments on this change by Arne Schwabe=2E ( https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail )

Change subject: Implement=
 sending/receiving app custom control protocol messages
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 25: Code-Review+1

P=
S25 looks good=2E Two doc nits in management-notes=2Etxt: "the lette 'F'" (=
letter), and line 839 still says "to facilitate the pending authentication"=
 in the ACC section=2E


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1858?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Gerrit-Change-Number: 1858
G=
errit-PatchSet: 25
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewe=
r: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: chugly <ch=
arlie=2Evigue@openvpn=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Comment-Date: Tue, 03 Nov 2026 02:36:25 +0000
Gerrit-HasComments: No
Gerr=
it-Has-Labels: Yes

--6L/BGn+xE7g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>chugly has=
 posted comments on this change by Arne Schwabe=2E</p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">PS25 looks good=2E T=
wo doc nits in management-notes=2Etxt: &quot;the lette &#39;F&#39;&quot; (l=
etter), and line 839 still says &quot;to facilitate the pending authenticat=
ion&quot; in the ACC section=2E</p><p>Patch set 25:<span style=3D"border-ra=
dius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-co=
lor: #d4ffd4;">Code-Review +1</span></p><p><a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1858?usp=3Demail">View Change</a></p><ul style=3D"lis=
t-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">change 1858</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4a6a6ef41e15896b=
8b79d795b2a6de86b8ae4c84 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1858 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 25 </div>=

<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: chugly &lt;charlie=2Evi=
gue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Comment-Date: Tue, 03 Nov 2026 02:36:25 +0000 </div>
<div style=3D"=
display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> G=
errit-Has-Labels: Yes </div>

</body></html>
--6L/BGn+xE7g=--


--===============7878734196318519848==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7878734196318519848==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7878734196318519848==--

