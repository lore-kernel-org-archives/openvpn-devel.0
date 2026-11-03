Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F6F606A31B
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bTzxFKb+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Z1cOIpbh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lX8n7C9a;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XxcbD7sd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=stwM3dZtgEFZ4ZpPxQiw8emnJG+mIXx4sDWuR74pFng=; b=bTzxFKb+sD+kGCr7NHlsyzAiq8
	Oqa+7uJNKi5xF1NVhZsrEiHuGwynDgOMVDNyD804ZnouJDZydVFWuM9j1TzxQsy079O3UElmATjCk
	Qze+QLg/62Ta0xu1cMUkiUYAjR8XyWnxSgmIJxl7Zw341A6o/ShIrD9bN6Oa8ykk+fRc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOKKx-000000004kB-2W2T;
	Tue, 03 Nov 2026 19:38:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOKKw-000000004k5-3Azp
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:38:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7sHN6cu7kv3us2riovN73KcK4DYyhfLaQl+gSttJeWg=; b=Z1cOIpbhX2QpsFETIRU1+TkKNc
 QUXet+RxTXXs/AEWNo1DpcJ7H5AdzxaakIeF2taJCF3JTjiAMj801Tyfo7LQpBoiPTISrO1V/+AqS
 p+E8M/Cucp7c3dTIUmN/rD/Epo1CxP4g7fc1vwds204/7wrV2QlFJW6bIbA3dV1HrQM8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7sHN6cu7kv3us2riovN73KcK4DYyhfLaQl+gSttJeWg=; b=lX8n7C9ac2rbrn2lhaiKFH8+Js
 MrT5T9dbxbtqjDd9CQt2JTp70z8SqXnW0s95AJcDxPRzuYa4UAUzKxtMQU9/u34rcpAbiOU9kwAEf
 AOwmSQl5wGPjEsxBI6Gym8z6NIWXWlrHcO06b9lCNCbxJcYQ8KL7ehIF1pMFEKq9BJcE=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOKKw-000000006SU-0u7h for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:38:26 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so35154375e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 11:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793734700; x=1794339500; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7sHN6cu7kv3us2riovN73KcK4DYyhfLaQl+gSttJeWg=;
 b=XxcbD7sdbHvQZVHjH1iqmhtUquGtutxAjSdsOllv1RaATbYFJzQEXsfebFsA4sab+p
 b45m7NX5KNXepfUq+FM+Uqu2ZU/Q/DWQYtm58DdNpw6IUxqQzOKYsvf6vOYrWlhnv3D/
 thT9hqIKcwaA/7zmq7yF208zvC7a6h44gbNvNXJCF+rY//G/KrXXfShFPX4SbbHTw50E
 OrUyNz919sK5LOGVbuawFlczhH22aYzHMhcYBv31ZDibBCweJ7SnstFEQU6xkumPyhvW
 sqsp/W6bCbXKBDZ3sUK9ptFW2YdOpBKjPZuXO7rDOP3YCIBISMaTUmT8fj2lqghEUJj5
 riwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793734700; x=1794339500;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7sHN6cu7kv3us2riovN73KcK4DYyhfLaQl+gSttJeWg=;
 b=ZnDDH6T6pUWmE8WQTrCaywPLMRvmdYk5L2wIgZaazrccs1eRg77owbR4YI9uzE+sIB
 xhfk5E5EhCuujEzLb91s7iffYOsSaC4l10dypeDcK/dyZkBIDYLZA8OxJrLvcFXSBEjv
 3xjPhmD9U2ry2iY0cVSqWMMRnP3o8M9o1KzFpqmX66zCERDTdH3qZVoGWjsSlkEr4Lwi
 uY2jbGGnHNuI/W3sSvSU4pE7JhsuZuvvpPvsXBT88CUqGLV+hPXTxCXzVEtIVdrOOmxx
 1nBv2zGLma1uy+Qbr9GKQX355cJ8rVEUkeJiRGezLJVos1JLmI7qiYQqMiYCmxgY0H7T
 JJHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0BIo7C72MvBtIVYOJ/hPz3WCUI8WIHa6dfBMI3X7eNq+/mWNCsUuWRa1PtSLJDTPD87opwOJ74xtrncjr@lists.sourceforge.net
X-Gm-Message-State: APuU4Z93kuF4n7dy3Rlbfua8PaOq4YZr/jt7snraSZkw4CufPJiLt4aG
 KAQebKs1K/iaMqZOwsBa3LYk+tcgNZL89mzhvmSY6dKJKs74zCNvkpq02P4axVx3KEOPd2ScCJ2
 7KnswEf1pGVEr5/OdFrN8dxuRb/E5w2/f+NT5mmibo+LhLKlKVJIRmAq5iMOzNIniOO2Pv3tkqq
 C1Rw1bwg==
X-Gm-Gg: AYBFou2JIwtxm3yzMtU8ihEp0AEBTCl5fmNfukOkIhjJ35z2ucJvGuUdchFXyyQT7JT
 oEdbVj74z7xYO7awL88ZOR7WoZKhOk+6Ku0pYZqpbbRS8d5gKutkyZzzZ3tHMuq1/wm8I/hYxhG
 jVaZgpUh4h7LrNvX5PvpiuvmXJeVwTu87uEeS1lctJtco4qVZ/FV2H2kK7a4ewRMTWRCo7STK/H
 eOr3x3RvVYAnkLSepOSshNpLd2d6zYXm1/MYxfHmDscjSH31+JOhPjI+TjGb2DYw9X8YRLwKLXl
 VRWCYH0nwYapMJk2yVz3+4A9ljksExDWO4W4AtZO8T9ci+Y0OJe/VDXost9kt920ywJo30xNR2p
 055tHGacXV8ldy9Tk96oKe+2+NPHVmhMI9pnMpMUiOxIBpJ8gg5+B0LxmrNp4q2MIJJ0cu7rcnq
 4NMVqrK9zpbMdTUt9JbdO02Dm6BKRy7kDAA85EPlHn2cGXdZYk6yPJlHHwLdxUUgUlF7jppXLfm
 MqUpq+aCo4z0ruzwF58QY6XN5cbMn1Pt2oxQUJFtMT2RjjmkLS0w2NUzjdQEvDN3pFsinjanq1J
 0p8GwvbPkPnwNJz0x+2dNuXBsHWQphtXx0syzqb2GQnWdfHtN5IeGadhOKXExi1XsvbGMuFZyXL
 xcisZiTGQOav0zoQyBxM6Kj7el42X4CWc10LfgnH3H6zV5zySIfxMVUlPpoUqUpkIPRFJcFcfKS
 U6gvAa/W4UcQG8/Q==
X-Received: by 2002:a05:600c:b8a:b0:4ab:c447:49df with SMTP id
 5b1f17b1804b1-4ac182dca8emr314704545e9.23.1793734699452; 
 Tue, 03 Nov 2026 11:38:19 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fcbfefe0fsm249910f8f.13.2026.11.03.11.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 11:38:19 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 19:38:17 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4
X-Gerrit-Change-Number: 2037
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2037?usp=email>
X-Gerrit-Commit: 83d7171af6b153b64cc428cd58c782effb95014c
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 19:38:17 +0000
In-Reply-To: <gerrit.1793043747000.I695967524bb9e83887b8c07d0d09baff6e41acf4@gerrit.openvpn.net>
References: <gerrit.1793043747000.I695967524bb9e83887b8c07d0d09baff6e41acf4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDQzNzQ3MDAwLkk2OTU5Njc1MjRiYjllODM4ODdiOGMwN2QwZDA5YmFmZjZlNDFhY2Y0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ce6b48ae12bedbb62d4019773c3c2e8281ca5b9f-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOKKw-000000006SU-0u7h
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add python scripts
 that demonstrate the ACC protocol
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 ralf@mandelbit.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0383724322083304319=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0383724322083304319==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HH/tZ2ZNu4g="; charset=UTF-8

--HH/tZ2ZNu4g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Name of user not set #1000061, Ralf L=
ici=2E

Arne Schwabe has posted comments on this change by Arne Schwabe=2E =
( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail )

Change sub=
ject: Add python scripts that demonstrate the ACC protocol
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5:

(2 comments)
=

Patchset:

PS4: 
> Pasting here Sashiko's findings (the AI bot accidentall=
y picked this patch for review): [=E2=80=A6]
Done


File sample/management/=
acc_sysinfo_server_demo=2Epy:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
037/comment/2db1e65e_9416a968?usp=3Demail :
PS2, Line 64:     def client_ev=
ent_CONNECT(self, client, kid, env, extra):
> Should we have here a method =
for reautch client_event_REAUTH ?
Done



-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4
Gerrit-Chan=
ge-Number: 2037
Gerrit-PatchSet: 5
Gerrit-Owner: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-CC: Name of user not set #1000061
Gerrit-CC: Ralf Li=
ci <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: Name of user not set #1000061
Gerrit-At=
tention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Comment-Date: Tue, 03 Nov =
2026 19:38:17 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-I=
n-Reply-To: Name of user not set #1000061
Comment-In-Reply-To: Ralf Lici <r=
alf@mandelbit=2Ecom>

--HH/tZ2ZNu4g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Name of user not set #1000061, Ralf Lici=2E </p>
<p>A=
rne Schwabe has posted comments on this change by Arne Schwabe=2E</p><p><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2037?tab=3Dcomments&amp;usp=3Demail">Patch Set #4:</a> </p><p><blockqu=
ote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
>Pasting here Sashiko&#39;s findings (the AI bot accidentally picked this p=
atch for review): [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li s=
tyle=3D"margin: 0; padding: 0;"><p>File sample/management/acc_sysinfo_serve=
r_demo=2Epy:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037/comment/2db1e65e_9416a968?u=
sp=3Demail">Patch Set #2, Line 64:</a> <code style=3D"font-family:monospace=
,monospace">    def client_event_CONNECT(self, client, kid, env, extra):</c=
ode></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;">Should we have here a method for reautch client_event_R=
EAUTH ?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail">change =
2037</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2037 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: Name of user not set #1000061 </div>
<div style=3D"display:none">=
 Gerrit-CC: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Name of us=
er not set #1000061 </div>
<div style=3D"display:none"> Gerrit-Attention: R=
alf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Comment-Date: Tue, 03 Nov 2026 19:38:17 +0000 </div>
<div style=3D"di=
splay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Ge=
rrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To=
: Name of user not set #1000061 </div>
<div style=3D"display:none"> Comment=
-In-Reply-To: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>

</body></html>
--HH/tZ2ZNu4g=--


--===============0383724322083304319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0383724322083304319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0383724322083304319==--

