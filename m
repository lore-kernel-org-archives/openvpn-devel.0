Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809B6C5B572
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0vmnLID0HgVewgKCkrmKDgtOBEWhi/VSx9aiuiV/usc=; b=aiuJL/dSE36Hk6Dqh7TdyGLmed
	cH0LHCzcjjtDOsqwPnzslvzuFanrR+7CK5iHM2i2X9upPbqs8/aljmjwz4Q2qKp05azOJaqDyMoIX
	Aeb/LcMyy+FdyD5fBuHdXubis8s87jbCIYUVOSDyky4xqSiXApKq90oLgO7LaUkYTqbs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwiOA-00067u-OL;
	Wed, 19 Aug 2026 15:39:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwiO9-00067o-Me
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:39:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=95aZIvGwcpbDI5HfkRZ68FZwe3x2Ozx+ERJANDW3krE=; b=G+gWVN9CStKzX7YaCIiW+Qh+vD
 jfMqBrk+wsVb4Ml2ayiqaJMFVsxLVLn7kenY2PJhitMYahIQ86YrtQJAwiaebORlGMHnVpEGs7mUX
 Gx6R+DRg3hZXyaVkuURjjDl34FuIQ/uaDUIneph2JU47k76IdMXzRWF7Dh5xO8C3N04M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=95aZIvGwcpbDI5HfkRZ68FZwe3x2Ozx+ERJANDW3krE=; b=f
 KHSx4jd5JGXdse5vrdwzXTRVPzm0+ui4jJwqCEAojXJtVWYn4K5zk0xe4nGJci5ihp8I6ppNKyw4p
 sBglJz3vroXEKGQXawoMvnHCoSeIyLnhiX317lp2S70I4UWpcbkTIDS7b3qvz9iRAKN16i/4fs+7s
 4FoIHJGqqOjI2qMs=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwiO7-0007kr-FP for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:39:38 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so761410f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 08:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787153968; x=1787758768; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=95aZIvGwcpbDI5HfkRZ68FZwe3x2Ozx+ERJANDW3krE=;
 b=NH0Pzgi57tJR9Mcej4BirgWIGTF6nhNgRpMo9SJQVWZEzgCi2UadN6m0F0f41fErYZ
 5tE9DFR1qSS8JSLuuaUsWByqZYZpOPPTTWS3V+OTqJpyipUA5jah+fCnMc3Lu6EMabxL
 Go04qFzVrZ24BLcwE4iBZCYBueX+APZJnSiWOeoP7ARfd5GBkuVHjTW76BKunaHCT1kt
 I4b+TBruZYQJMKMYTWlVgiTsyJ/o+4cfNkH7FK/ZoAkmCZubvcUr7U8F98LXBTOGzQDS
 /0j+NVXDmKGfI2Ym294glSI+Jmibus6E0HZ4J+purOvgcabWYITQoQRUeRCs6WfbW/Wg
 lXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787153968; x=1787758768;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=95aZIvGwcpbDI5HfkRZ68FZwe3x2Ozx+ERJANDW3krE=;
 b=c53agD087I0xfQ1Cqj3TciGqm7Gebvp6BayCCSTiYOP6nwFeYsxX0Qghjibg3iyUBI
 DQHGLgezNvfWNeYEXcfQUQXrANdS3Limbybg9adD7kaQhqBCtZTCdMXvjhsLqJSiDmcD
 jySIU7CmBv5pdCXbFW4lXiCaWUtWVEeEiy1AS0+KbINQs49zAJ2+2OE6ecNTfFnGBoio
 tLnIlXDLKXGDNd13GyHze7UNl+bHtMbawg/mUoyvYZiCKuQR+029aNLVny1k0qmDoFip
 yb62yGdcGUwRFk7l4ptsCWL14qedGKevw65+lIIDVpdYWE8hTH1EWDeLkbxnfRHPT+d0
 Tesw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqfydlFczsWVabXGotCjMcuazomf6zyEfMYrFZQY/5HhsBe2lEmOl4OruJsdTXtex8E/TGPXcmzc13hVlsm@lists.sourceforge.net
X-Gm-Message-State: AFuF++mGCJboSlC34W4GMDYdbcT87MndV8553b04+X+lIMrQbnvSA4BI
 Bv3hBehL5hYxgbjZw9Ac+75aISu/r0ggPWdLVw9IU7Vltvd9M69uewE+f4th8w4Dqetj6/+1Odj
 ChnGaLr1AyryeIWL5SEVYVA/UL9tCvpvWf7201vGYo4gcCzQP6pbf0SUoMIn76o6FkrBoC5OfQy
 YETGkKBw==
X-Gm-Gg: AR+sD13qoXoqQdNURnLKxDTEhfbqs2d50Nd36TPcckb2e/R8A7kpbzj/ZHwkC2Do5QH
 gIF2lXbu9BZE7/lU31yhVk43oivBEXDP6tUJThtUnhL+dWS5H2KMbbVgC76eIwR7L9ZJmTcW9nL
 WzyRY+4I/iA3lmFWHMyiwTLAXW3duL6FcU5BN+n8jW8JCOkblykt/KX3PzLhmpFEmVW8P+Fcn7y
 ReaI+MnCTdQIGSa/P386F7FF6on5UZ0qM6KXzrhUKryD8yvo0TEnuZRXc+OaDKTShweU4M+NS+o
 RS4HMcEJobVdtLyyq4MQIUMb7ah0i3aWkMCBULkEbxMygNUIWznD315t9amza0diiWYIdGUanBD
 s5Cy9vmb424BuGfAFL0NAIJySrYDYNaf0mgREq6R7GSrZqx02BsWPHWD76rMXKwZwcojOvwSvSk
 74A+c4slR/Snrl3qCRxVOuji5eok0wliur6CZWZQnMzg+91gjiJJK3XZo4Cc9OEENlhl42ZgvMO
 eXPzHMQMSIHuKC2NZY31QKG2uXzstL6WeeWIRMunvZP6ZDy/tuNhf7lloMRJtH9sUn2z4naz5QU
 NcsdU9q1f5TC/9t4rKZKv3Reojd+lX2UMYFEJGOlfec00iyHvEg=
X-Received: by 2002:a05:6000:382:b0:482:aa2a:52f7 with SMTP id
 ffacd0b85a97d-482b1e92974mr10963890f8f.6.1787153968278; 
 Wed, 19 Aug 2026 08:39:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14c33a8sm6730122f8f.28.2026.08.19.08.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 08:39:27 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 15:39:25 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I12bef330e2c8a5e5b21c2fa807584319b2b7101f
X-Gerrit-Change-Number: 1846
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1846?usp=email>
X-Gerrit-Commit: 82c8562de76089838ee7b4ad609aa6ab92f3bddc
X-Gerrit-Comment-Date: Wed, 19 Aug 2026 15:39:25 +0000
In-Reply-To: <gerrit.1786968495000.I12bef330e2c8a5e5b21c2fa807584319b2b7101f@gerrit.openvpn.net>
References: <gerrit.1786968495000.I12bef330e2c8a5e5b21c2fa807584319b2b7101f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2OTY4NDk1MDAwLkkxMmJlZjMzMGUyYzhhNWU1YjIxYzJmYTgwNzU4NDMxOWIyYjcxMDFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <37fa9a85d684114f2f942d850a62faf246d88a8c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwiO7-0007kr-FP
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Factor out address
 resolve code to a new file resolve.c
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8737255903492153589=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8737255903492153589==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mQbV88k/qxo="; charset=UTF-8

--mQbV88k/qxo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1846?usp=3Demail )

Change subject: Factor out addres=
s resolve code to a new file resolve=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(1 comment)

File src/openvpn/s=
ocket_util=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1846/comment/60b=
fb95b_ce53e550?usp=3Demail :
PS2, Line 113: 
> Double blank line introduced=
=2E
Done



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
46?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I12bef330e=
2c8a5e5b21c2fa807584319b2b7101f
Gerrit-Change-Number: 1846
Gerrit-PatchSet:=
 3
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mail=
box=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attentio=
n: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Comment-Date: Wed, 19 Aug 2026 15=
:39:25 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply=
-To: razvanc <razvanc@mailbox=2Eorg>

--mQbV88k/qxo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1846?usp=3Demail">View Change</a></p><p>1 com=
ment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/socket_util=2Eh:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1846/comment/60bfb95b_ce53e550?usp=3Demail">Patch Set #2, Line 113:</=
a> <code style=3D"font-family:monospace,monospace"></code></p><p><blockquot=
e style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">D=
ouble blank line introduced=2E</blockquote></p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul=
><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/184=
6?usp=3Demail">change 1846</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1846?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I12bef330e2c8a5e5b21c2fa807584319b2b7101f </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 1846 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-O=
wner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mai=
lbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;razvanc@mai=
lbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed=
, 19 Aug 2026 15:39:25 +0000 </div>
<div style=3D"display:none"> Gerrit-Has=
Comments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </d=
iv>
<div style=3D"display:none"> Comment-In-Reply-To: razvanc &lt;razvanc@m=
ailbox=2Eorg&gt; </div>

</body></html>
--mQbV88k/qxo=--


--===============8737255903492153589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8737255903492153589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8737255903492153589==--

