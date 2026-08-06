Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEBCC55ABF
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 11:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oOHbB65B0ubJbouwCdcKshG37mXFt/jNBxmHkyMun2o=; b=KP9hGAxWmFRGA4xEElR628v+FK
	LnTKNMiOsyIxnWvDjlnl8u8wnFam006mTFpfIRQIUIrJNX4GlqC86Kc1JHXB7zoiUtl+1cN/Ilrgl
	cD8TDxaR7RWRaY3kvY+ZMHXn8VQjMP0VY0nXsFJZqcSBCUqJugeTyy1AKkI6J5D0QEaI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrw2I-0003QG-8m;
	Thu, 06 Aug 2026 11:13:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrw2G-0003Q5-Mn
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 11:13:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=GVjDTCbYaSMGhv/ZMwPIhrsHR8yJgd9JKA8/HjzDAAU=; b=WArzPoH+HlZth+smqXFdzeifp2
 vNZB/6F4gszoPEc6r5PJ/zcvoNSGgfTLv70VC//TOrJRToPoRFupZJXUvVu/lEOBE1T8srHGI25dm
 q6XLnyy4HBBqNHGar4lGAUETROjboHuFHfyCs4cat+nmN9YNSh9H37AFgazlRHNB1TUo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GVjDTCbYaSMGhv/ZMwPIhrsHR8yJgd9JKA8/HjzDAAU=; b=g
 6R9R4VlcFvJytGhSg4Vz9zUfOmqPkTRG4LFgKgCnCcrnvZhLnh2HN4cMxpxFgUDS/bjUIgV5/uDAa
 M92iJIRWf+nStmODThhOsOeqTIQ8ObnsQ6YELlyXP+BMVFmlpLinVnfqBjuThO2+AOgw0wEjWbZun
 EZhGqzkvHBQpp24k=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrw2I-0001eO-S5 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 11:13:16 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4955de8797cso13754115e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 04:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786014789; x=1786619589; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GVjDTCbYaSMGhv/ZMwPIhrsHR8yJgd9JKA8/HjzDAAU=;
 b=T6a8IpntzDZ8qC7QiJwoXYpphAfP4khbG/ycVrdub3IDweackc2INHJ5QxglEpFFEC
 EOxxfy38ltXzSSTcvDvS4yIwEZTbDjPMK7/iqVJGXRufF1+jRZec5qNYjbm+70YvHjgz
 YIwC9pXnScup98AwaWnurFvSUBJWbI6CRcSKGiVZJKLfFQCWpiRLCzs1qTSCuZ2r1w6B
 2Eof3Tk/aATp5Y6uiQaiA1nlvxMhEHc+1RihXSqSukGx+EV2Z92B1ckU4GIi7JhXTdKX
 pI6XiTpYZ3IJY1+8E5R5rFUG+mrXf+ondZRifa/FECPo1f03jv4VXtIPi74kq+wLu5qq
 2yBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786014789; x=1786619589;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GVjDTCbYaSMGhv/ZMwPIhrsHR8yJgd9JKA8/HjzDAAU=;
 b=FuRf7WFqujCL44u1w8oGoIBrhNhoHwMp2tXGtwwBYuS/ZYIRpSyMqVZWD0wgHCFPx9
 djkKleUQ+8orStIU0iumkbTsvhJ6mUFnHym32Cs6nHau5VyXaIJ3NYM1r7+UAoQmZGT0
 IxUzWa5Q9Feb2PM7XBWkWkUOr+ZrHiiTfJZnpKuWUwaLJmS3RoV0kQDLlt5aDQ8KvLiV
 Xh+goX7nMgyxnHD3xlt3cTSPjhDGAwMluECsDait/xkGYwdebYt94x89wPF3vN2iFRQJ
 gQefwEAQoBtlhxJFvdniCpLSL38dmqwZURzieUAYWiuC6QaxH+RDmaU6SwuRKGwrfT7n
 bbCQ==
X-Gm-Message-State: AOJu0Yxlstsmi2tWaNyatK8O0Fk3L5PL9x8JlGUM8hP5s70GJnQ1vS6W
 ujCWsX0/LIZkT2Tox3Yvm2EIJutWZCnqZ5Vhj7pVcyz9OW6+Y77/j/WxznjfXiyh5jTjvZ5fIAq
 PRCgJrzjzhMc0oPFZYDI5Kw11+IRmbRQohNZPHzDWL25/FEwOKqq8J/ljGUvsxh191ZdH
X-Gm-Gg: AR+sD1081aDPIL1fVErVsMGhIl5AppqqqdBi1au9fqRsotw+hFAdY938JDk2xFeYZrb
 Y4uTmOztg0Xjeuo86Y+Z/qtFwGIyZdNt9ClA9A9ByZjFkToSGoVnZEqX13R6zvTZz0saPYCExlf
 Mqx+XuavlaAuJzEX5RYhBXb8Z6fcoM/750n+fdRwQQx5Jvg41noG+P9UGMstmoQk/ZuG88YLzPW
 DRyjGJ3IpBr+G6E/EaweK2OogKMocSrlk4ZeIvt/a0VFOk1uPKTar8hMKXi3Fooc1/5awORvji6
 gd63a+qK58hlxBnSAomOf/I40axo8bKT/c4cxZ41W9icAyT3JkRteFcNUzg3BEes0LPDXH6rKwA
 FH6GIiJg/jVbxLDlRwB9wnUQ9GYH9qEchsUFVw7hlfE0fuxsYyEuyPDpipRxHQGaiTTddZxeP/3
 UPXdS4xFZmCA8JhYqjfE53CT/wjyeJ6Ber22qscGOi4n9r0rOo16IpdkHbW3WGE7A6gdFSjWqFR
 5BPEx4NhlGYF+YSMktj25h88DhVD5Z4wP4Qiq7gUCqR9irDc4vv7w1dwkbRT9+FgBd4BNMpL4h9
 9II1vadhBSmu09bf9lkxwl4POsyHvwhAxZcrqdVtK3HsQqK6muptXE+UgfKAZQ==
X-Received: by 2002:a05:600c:3b29:b0:495:4811:7998 with SMTP id
 5b1f17b1804b1-4994e7d389emr157870425e9.17.1786014788685; 
 Thu, 06 Aug 2026 04:13:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995421b1e2sm68607795e9.8.2026.08.06.04.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 04:13:08 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 6 Aug 2026 11:13:07 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1a6a0ca8beba3214b21047755246ceeb30141c2a
X-Gerrit-Change-Number: 1839
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1839?usp=email>
X-Gerrit-Commit: 0827214723a8cdd887b60250359a63b1ed8f147b
X-Gerrit-Comment-Date: Thu, 6 Aug 2026 11:13:07 +0000
In-Reply-To: <gerrit.1786014571000.I1a6a0ca8beba3214b21047755246ceeb30141c2a@gerrit.openvpn.net>
References: <gerrit.1786014571000.I1a6a0ca8beba3214b21047755246ceeb30141c2a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2MDE0NTcxMDAwLkkxYTZhMGNhOGJlYmEzMjE0YjIxMDQ3NzU1MjQ2Y2VlYjMwMTQxYzJhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1386ba19cb466a42e855ca24d8f334907c559591-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrw2I-0001eO-S5
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.7]: Make test_misc
 compile with -Werror again.
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4085264636668664399=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4085264636668664399==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VIImLyOAAkY="; charset=UTF-8

--VIImLyOAAkY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

cron2 has posted commen=
ts on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1839?usp=3Demail )

Change subject: Make test_misc compile with -Werror =
again=2E
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1839?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E7
Gerrit-=
Change-Id: I1a6a0ca8beba3214b21047755246ceeb30141c2a
Gerrit-Change-Number: =
1839
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 06 Aug 2026 11:13:07 +00=
00
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--VIImLyOAAkY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 1:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1839?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1839?usp=3Demail">change 1839</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1839?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: rele=
ase/2=2E7 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1a6a0ca8be=
ba3214b21047755246ceeb30141c2a </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 1839 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cro=
n2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Thu, 06 Aug 2026 11:13:07 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--VIImLyOAAkY=--


--===============4085264636668664399==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4085264636668664399==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4085264636668664399==--

