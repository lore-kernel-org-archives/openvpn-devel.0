Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA79C5DF7D
	for <openvpn-devel@archiver.kernel.org>; Tue, 18 Aug 2026 15:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UF1WdOxSPvGJixEyhA/aLeNkYKQOCWDckeatTAVushw=; b=AtdUu+JFyExt8hv4MHiO7ZVGWM
	zxh5K1VvzSZNOVABnRetO6y1UmkwnXcXAxjAImsi0zKTQPXafTWCJloa1h4D9xkCBHZkh0W5/xQZF
	Bc3ZlOK5qweU69CCZ9xPIu6bJ67idyEPYL9ladywI7CKgDUZOYmVy3bBo78M+0N30VYc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwLW6-0002zv-GD;
	Tue, 18 Aug 2026 15:14:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwLW5-0002zj-46
 for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 15:14:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=k9XrGr+W7XQmy59pmOcVXIXwaF1dV51WGVKJwPP+0Qk=; b=DGhma2Y3t9lI3xepxepifQ52Ev
 320Es99iUKVhNfkI23aGRRn0rexUUXmAoILLmCIS1GzOQiw3efNY1EpSdS5ZK/nI7Xxgp8wJt0o8T
 QYWinXDr+URt4I2mo+dMcdqBh0wGGdw/wh/7lyx8akXYYKjnwe8G7WJvbVVe51itDNTg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=k9XrGr+W7XQmy59pmOcVXIXwaF1dV51WGVKJwPP+0Qk=; b=d
 Pu9ICENf2wiTR5T3PQwfrEMl8jqcJxfKIysYWzMynJENsAkvCKJHJBV61KzyqztPyXb9kWOaKh4Bd
 LIalqGHSE/D2ESlIikg4NJvmD58PNmOYsULCxEFyiPmBvzoLdRe0UdPMzx7X4J5tD6VgxPnlnHHAR
 1mloq/qMFSSonAXU=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwLW4-0008Pe-EW for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 15:14:17 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47f703a9d05so3189168f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 18 Aug 2026 08:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787066050; x=1787670850; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=k9XrGr+W7XQmy59pmOcVXIXwaF1dV51WGVKJwPP+0Qk=;
 b=V14MXfoZIRTB9bJnpg3zs2V64B/Tj/RXalHC4uggqJHrQuoOQ31AG2UFaOymquOPNB
 MXXWgS4oypnqTQzlQvAx8v4dUfg5Hpc+R//jVEPcqPLw6e8/gFMiVaUYi/HlqtyCsv1+
 5TLGAf5yGMV6LxfAOfWc1etj08Ppd/FSGkmkBlR4XqUHlJkFWgTSW4Grqmafo9/YSW0L
 ZtyfDTPvCPWmTBf4hbRthLR3FrnXNXbldEdPsHxaaQGWNJd6pzhXSXJsTJcI6N5cOU0M
 h30iBnuLWSZ4649K6CxxbU3dZGAZ4eLnGoDzQzjXKB8q9BkN6rBvJDhtdg0K1V57hZlD
 gRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787066050; x=1787670850;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=k9XrGr+W7XQmy59pmOcVXIXwaF1dV51WGVKJwPP+0Qk=;
 b=qxWvLxEpDLetx2OaN8wfm2cakFV0AxIn+fYgk69zXltQB9pgeabN3qD5VkjS2jE6vO
 SVXdSpcZ01DfLmaUhzsQ5GMCf7TVFnMQ2syT3rs37Art56+qhtgGQQSnMkcie73/gWFN
 YNfilxAR9bSBIYKcW9+HiG/QzOHGlDhPB9tNcA9XHrU/E6DWQFsgzIhrGT/2UbyHO7CP
 Ov6gPmVV8G3KEW+VlFmUg18GRPpqbMVlD7pL8bq9vo8K9wtCD7wQkoDjDpfiL9sQEx31
 QogwkTZ0DaMyspapwcX8SD6P39XH/FzmuLV6+4jlbzeoiiG+UGOKH+rBpBLGKRoMiSdp
 B2WQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoeQ8k7615vi96cIz93UE1Doa1OD5L6GcADMgxd1PJGJurRH8z2unLpwc/9iwAMDwqt9MijxWPnMXscODcg@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyF8nXiAB5W3cj9pNfJn2ocJU1YgWRm7Tyo/KpEE+tZt3dtOg2O
 IH5Aj2DOpdZ/qu2ZQxpRaAQISrso9OG/0703nV4OKUgw9jzrKxC8BBBUVRGPcwJie1s4LC1V8Y7
 03kGxHL/NVyX6fbcbZM0Bjk7BlufeGsp1TBBEbKIC7mdBPwU01K6uff9h74ywfjLdnH8S
X-Gm-Gg: AR+sD11TjhDi8fvfzkExKBfgOQY8WtgkkjRv25LCuxna5rQxnTubfYNMVC32yvIY736
 syov7iJQ6suICUmXQlyM8iCQxjTO4ppAl4nH6qvMdySHL6z15txVojg8rRg5UUsGWd7+qbY4CIx
 EuTxH6VAtd7fGEZurxHiPg7zpovEqJ7xrCFz/ZWrgTngS7yl04qbx9HYJWNV3qC2NP6NHMQ3NKw
 9zunrzyZhpQInSVwXLFKY+uZA1fF/iToVrKVtWY/yGu34nDlemd5D8NMztCLylvHpkQZZ1VwJgB
 RX01uPmMpL2U52vn8E2MB7R5WoFb1PcdpaYYEc6ap6qT9Wrpe8yR95FKq3xDGECpRKDs37fI//e
 EdIrhtBSLbzt0/8MMkIxD229g5m7z9qJLqCanqbcpPC54SxXoVqu8nPuFqcqND1i7BtuU4vfKkC
 kpD7JKIPhc1sRJsU0n6rW0RMKNqKcNpfvaXr1hbh5fJbb3LWJ954YbaqRObloaDRnQPJJk/imOH
 n4qvzGLVwEiML0DGOJSjRPN6Je1Tw8GgEeK2aXGMm/V5qnkunkBa5LqbRro/gcBkxmY7USupZ+1
 /Z3M6VE6oa8NBscQ9PGaOlr9v8OhJhh3glxcCVAe9n6/T2Dl+9U=
X-Received: by 2002:a05:600c:4ed2:b0:499:8743:77c8 with SMTP id
 5b1f17b1804b1-49987941ae1mr530581205e9.8.1787066049561; 
 Tue, 18 Aug 2026 08:14:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499961098cdsm288730115e9.6.2026.08.18.08.14.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 08:14:09 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 18 Aug 2026 15:14:07 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac
X-Gerrit-Change-Number: 1407
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1407?usp=email>
X-Gerrit-Commit: 8535abbeca3e048d7a90af0e14bd5d812649fe86
X-Gerrit-Comment-Date: Tue, 18 Aug 2026 15:14:07 +0000
In-Reply-To: <gerrit.1764168347000.Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac@gerrit.openvpn.net>
References: <gerrit.1764168347000.Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY0MTY4MzQ3MDAwLkliMDU4NGU4NzI4NzAxY2NhMTBhYzU2NzVjOWNiMGU2ZjVlYjkwMWFjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7194360f827a86c453e21917a0c3a0ba89a290cd-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwLW4-0008Pe-EW
Subject: [Openvpn-devel] [M] Change in openvpn[master]: packet_id: Avoid
 conversion warnings
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1795857783246612188=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1795857783246612188==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DH1ply4Ssio="; charset=UTF-8

--DH1ply4Ssio=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

razvanc has posted c=
omments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1407?usp=3Demail )

Change subject: packet_id: Avoid conversion =
warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 8:

(1 comment)

File src/openvpn/circ_list=2Eh:

http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1407/comment/5a2c3702_25dbc08b?usp=3Demail :
PS8, L=
ine 63:         const size_t so =3D sizeof(list_type) + sizeof((dest)->x_li=
st[0]) * (size); \
> maybe then we could just have an explicit cast to size=
_t here?
FWIW that was just an observation on my part, not a big deal=2E We=
 will probably do the work of removing `-Wsign-conversion` warnings as well=
 at some point, and this can be done then if no other changes are requested=
 now other than this=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1407?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac
Gerrit-Change-Number: 1407
G=
errit-PatchSet: 8
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvan=
c <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-Comment-Date: Tue, 18 Aug 2026 15:14:07 +0000
Gerrit-HasComments: Ye=
s
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Comment-In-Reply-To: razvanc <razvanc@mailbox=2Eorg>

--DH1ply4Ssio=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1407?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/circ_list=2Eh:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/14=
07/comment/5a2c3702_25dbc08b?usp=3Demail">Patch Set #8, Line 63:</a> <code =
style=3D"font-family:monospace,monospace">        const size_t so =3D sizeo=
f(list_type) + sizeof((dest)-&gt;x_list[0]) * (size); \</code></p><p><block=
quote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px=
;">maybe then we could just have an explicit cast to size_t here?</blockquo=
te></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">FWIW that was just an observation on my part, not a big deal=2E We =
will probably do the work of removing `-Wsign-conversion` warnings as well =
at some point, and this can be done then if no other changes are requested =
now other than this=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407?usp=3Demail">change 1407</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib0584e87=
28701cca10ac5675c9cb0e6f5eb901ac </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1407 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8=
 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: fl=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Comment-Date: Tue, 18 Aug 2026 15:14:07 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Comment-In-Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </=
div>

</body></html>
--DH1ply4Ssio=--


--===============1795857783246612188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1795857783246612188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1795857783246612188==--

