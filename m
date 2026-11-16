Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38C4606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UH6HArV5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ing3b5lS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=H7TnGjX6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=FQnrBf82
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NZFkSDOLA1sAGluEvW5etd+XBx+AtrqqEuPqqC8iSNc=; b=UH6HArV5DNEQGAllPdw0QSpQPA
	oLa8GUgH7dZT5GS6FUXwF17rgx4KJulxTVXO97TQx5E2ZNKhBXTHiNRah59rzHEjGvXPTwZjCEY/m
	DpUxgzXN7C1nu99pgNfMxoyrIP0jIu2qq6qT1t0zUI9lGlZqsyZBOEXg2vYma8WOCX5M=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSyCJ-000000004zH-1ENK;
	Mon, 16 Nov 2026 15:00:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSyCH-000000004zB-1Blh
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 15:00:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tN+btFLGtqPc9kaxsuZi0Heoy3oGntVOD5M/wa5kuPI=; b=ing3b5lSogCblnuemnthycIeZK
 vO5ukFUmcsJNEiuDG6lHSImzTS3eChbvh73D2NvR6XAnMiDiYi7T1SkNZ1MN/2PLXvncFxjmfE+Xz
 Ibt6kTEpMRV83gnMfCzwIZA08hmKl71Hm4kzA0QZS+siUBRDQWA8EeW/mZ0Pi9NZoDZE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tN+btFLGtqPc9kaxsuZi0Heoy3oGntVOD5M/wa5kuPI=; b=H7TnGjX63i9rh6EERhlPvDEmbA
 tuJux4Tn5eGe0Mzm+PdpU8hRetoOdSQ+ml+9LnFLK/YNWYp5CySztdD+GHY/nbHCDxL5zBWnEs7yL
 kfkv5CMyBZtZsEZkkfkM6LRopSO8XhMTPlmcX+JU1hq6atlUPMM0Z6iHoK/fk9bpg2hk=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSyCF-000000006m9-3U8o for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 15:00:41 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so35859945e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 07:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794841233; x=1795446033; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tN+btFLGtqPc9kaxsuZi0Heoy3oGntVOD5M/wa5kuPI=;
 b=FQnrBf82BbhF5ofma1e4px/0yevlXSd7sF1QiHAoudKy0OLCyzKM9OJ5Jq/o5LfAOp
 wOOfUrA7ZgGLj/MRHxk9mA8FDoOJrIFHzdPHWw7WL5HsU13mOYhY8fXXeWSbVxVMBTbc
 JaqV59+vWlSgjvBq4YnP0BDLbwLvLs8Wi4ZyWPQ1zAAffP/0b0YOpQWeSIfa1w6HdmAS
 mImh0jAD3eWQYALag6HFyb+5ew9Rf4FIJUOisUYiwgyb+UQJObvOTq/N5Zg0P8dNuRnJ
 OEY2YLqx3zl9npmvvOy6De3wlHniNo3yZqiVRNqk+e+XvcqHrXtoQ0FGH0mh+iAqNrjQ
 5vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794841233; x=1795446033;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tN+btFLGtqPc9kaxsuZi0Heoy3oGntVOD5M/wa5kuPI=;
 b=v2NxzbK6ROo4FaGrutShzjsZq26Z9kQ95NL+oVVyfATpwFRurM3Nof7uvElFFNw4y2
 ZgfSwg9Nk3Ygq+3bNAdBiNnjBeovIADjjp6C+qHg4fLWU1lJepiBfk0dVPWsLts4BzzE
 WbhIbtkknzSe2n+R0nkUKDub7RQiRn/3JFCONe5xbgDVVzEykV9Lj9gZR4RmUbuKXWs7
 l3ekhHaprIcE+ey8Xw1PA0PAz+f+yJiD7wH2XwjQARvDYJedNBaiCRZtWqXGbvXmzMuO
 zyhCVM/tvPoXq+clVg9wnA0fUkknj5ktipUNHa5drDGSwPJZE69O+C4bqT62wAp/TOjb
 mGaw==
X-Forwarded-Encrypted: i=1;
 AL+hErE9bxA6lIU7kp/+nBJYfpyyrogEhz8HCNF/xz+cuqqzVXp2vLEqd9Pf/Ea9w/+QFXj6BCalYEX3bYkY+nD6@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9joK1zmEpj2mHzlf8hvIFA+G5YH+gYJpsMIYn0l3qpogtELZIE
 eA1eS65uhYP6DZrF8LQ8drRcQqvoLGfaXfmqdxSUE14bjwZDi+Q6g+QentA9/aJ7sexrgCSXC8s
 RWaVqge3r2yQSDDEAycpCS3nxBxiJzCmleaGnurFxpoYt5HukyWeVOF+aSleCuf5v+dS6ZfU1hz
 tAOsMh4g==
X-Gm-Gg: AYBFou3S1nfhDlEXCjxk/63RvSN2ssGNKK/Bd4kzUzP+XL/XqZxEtxPVsQQwEX4KQXI
 VlCrs6mANMTxo5Akj4mrW6XixcVplLb17qULbwWTUyhxAZxr2ndqwp2EwgWkXuxxKQyuzZ3dqIK
 oEG7JLgdyUJq7Do+uozZ+s+g4s0tv6OiPvyKTbg9I93jBUmE3Dibh7CokZApY90Jd7ENve6ptNk
 EV0v0TqX/M0GccO6SrPLC+5LOF4mww1s+n+GkGa55yT8iL1H4cigbQiodFUsMGJiQgBJv6CZ3Qb
 r9jpf72F6zv2fruwjbDe120kp1fTvcu69eY78VLTskSE8jXZZZtZTJFrZmQxpuODhEKw7YNufkS
 lT2rPK2Sv8gCyi2oCm2QXrJcHyFt5O6WDz/sugVta4WE9z/K2u/XJStEB72L+vFoLmHoyeEb6Xe
 HGAA9ZjXb4icc+zZvpp7mlfSsYgEu7PlrEG5YsMaxEuMhlys5ryn6PYUuV6E8fso8B2QMb+r/B4
 OR6z69XC85hhhV3aWsz2qN54y1Olp90yZ0mWQwuW4B2v0qLsiiYmG9ppqSrkHgad1wxO8c/KcGw
 ju97xvoiauEh8Q0pONZxe9CHuiV+KIlQKXol5Xqk2ZX1Wj/CVjHq1gakuibgXH+veEZTSiMJ4Ux
 Y0GN/sqlYoMKTd3tWtEsYy1tYlS+BBhCDH7KDZ5kuC/bFjdtiosANHJqpTE2llg/Jmjb7Ij0H9h
 Ro2OVtZfA9daVXFaI=
X-Received: by 2002:a05:600c:81c9:b0:4a1:83f0:7c91 with SMTP id
 5b1f17b1804b1-4bb55a65b31mr220310215e9.18.1794841232843; 
 Mon, 16 Nov 2026 07:00:32 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e293540sm391935195e9.8.2026.11.16.07.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 07:00:32 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 15:00:30 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I9c2403c21ef8f21a0fbd998346c8ad719b4b9972
X-Gerrit-Change-Number: 2198
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2198?usp=email>
X-Gerrit-Commit: 4a4389a2ae44a3ce9b24bfba4bc64dfccecfa83d
X-Gerrit-Comment-Date: Mon, 16 Nov 2026 15:00:30 +0000
In-Reply-To: <gerrit.1794839855000.I9c2403c21ef8f21a0fbd998346c8ad719b4b9972@gerrit.openvpn.net>
References: <gerrit.1794839855000.I9c2403c21ef8f21a0fbd998346c8ad719b4b9972@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM5ODU1MDAwLkk5YzI0MDNjMjFlZjhmMjFhMGZiZDk5ODM0NmM4YWQ3MTliNGI5OTcyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c0815fdc76031919063bd48b93c0239eb1af350c-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSyCF-000000006m9-3U8o
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: Switch
 buf_forward_capacity and buf_write_set to size_t
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1204728675205275596=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1204728675205275596==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JoFHtPaea/A="; charset=UTF-8

--JoFHtPaea/A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2198?usp=3Demail )

Change=
 subject: buffer: Switch buf_forward_capacity and buf_write_set to size_t
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:=
 Code-Review-1

(1 comment)

Patchset:

PS2: 
Patch version changed while I=
 was reviewing, but the comments for v1 still stand=2E



-- 
To view, visi=
t https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2198?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I9c2403c21ef8f21a0fbd998346c8ad719b4b=
9972
Gerrit-Change-Number: 2198
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lich=
tenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: =
Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 16 No=
v 2026 15:00:30 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--JoFHtPaea/A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2198?usp=3Demail=
">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2198?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Pat=
ch version changed while I was reviewing, but the comments for v1 still sta=
nd=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2198?usp=3Demail">change 2198</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2198?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I9c2403c21ef8f21a0fbd9=
98346c8ad719b4b9972 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 2198 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div =
style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 16 No=
v 2026 15:00:30 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComment=
s: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

<=
/body></html>
--JoFHtPaea/A=--


--===============1204728675205275596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1204728675205275596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1204728675205275596==--

