Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81882C5DF93
	for <openvpn-devel@archiver.kernel.org>; Fri, 21 Aug 2026 16:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ctVnUFr409prWBFmCgY0SDgD/DM5TLlr47VXQ2KH+h8=; b=V/1IYoSRhDhfHEavBHKNX5ksLA
	Qaxz8YKUoP+DiyJqXKjaRh7yiKCP03bDBbDX96e136JhVRySw86QCH4JjZNhdZuEzJdrrDWpHlz3a
	TBA1FuNX+ID/RzHCoEzZ4ZtOstr5LXfZVG+L7z5Rtwii4Oxq6L2HozzG/Yg/tnImSGck=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wxRl9-0003ML-Px;
	Fri, 21 Aug 2026 16:06:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wxRl8-0003M8-Mb
 for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 16:06:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=t2jruPNH1pokdXNOli/I8L6472yrt/D3JvXQmKaqYXM=; b=a1TMqbpDedXKO3a5TrKkbbbBtz
 Izvp/tOHuRrO9QZJkIPVDGEzoO1HJv7GSWWi+Xghv7+2K5HQH1E2uYVxZrdPiupLrLYHWanGMKGJ2
 4POXaMbUV3zPQVTZwpMgrJ3OMdq/VR9RXWo/8lN/DjtFjxja9F0QUeUtFF4puY4ZKBF0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=t2jruPNH1pokdXNOli/I8L6472yrt/D3JvXQmKaqYXM=; b=F
 NK47yhRNNwdecpUc13Qax33frX2lEJPR42sS1wPCjJ9er7bhrxk+LOmXkUGHJjMB8FiL0tkDfaqMv
 AaXXDeuTKNtj0mWVeyqseYjR3/m6uIzpuiqAvymw1KOM6WBYH7zsPZMfqFAkAt+lX7PmPBVhFfjhw
 FWE8/ibgY21qc0+Q=;
Received: from mail-ed1-f45.google.com ([209.85.208.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wxRl8-0006e1-Gn for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 16:06:23 +0000
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4a28cbdso2231280a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 21 Aug 2026 09:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787328376; x=1787933176; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=t2jruPNH1pokdXNOli/I8L6472yrt/D3JvXQmKaqYXM=;
 b=ZeONmI7tTIV+/ha6aTIrDf1682tJujgaiHmXI9AikQ+aAXvELirMoeFGcwDA5ablxi
 vdk/69fP+VCdmgSdwmKzF0G2qn5pUAS6O6SIvTfQU9eZ5oqCgXGVM1tyLT2iybNXQuHy
 GlKHrPsAZ6jdMJyW7sIEcgf47jsLcobES8iYcN7BkoOvXCb2ty/xIvUZCHMpkH5THiHa
 0dtKni3m64UVBfQN1l0KyO6hqb9bZS6lljc0fCJjtbInFzEMUk/Py6cLgLlbftyUQsnR
 eQURcFvqo2zBuCvxNSYp0c3XrP8xBP3a78AYDFDVmSAZ9AYD5M5T9GDMTgHKVZcbJutd
 ofxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787328376; x=1787933176;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=t2jruPNH1pokdXNOli/I8L6472yrt/D3JvXQmKaqYXM=;
 b=VISDgpYkZvt9CqwnTU6KSb8GkMukMY+4oNweVtIqqab3sc0q6WNgLM/3HlNj0CjvjZ
 tw0CrkVgSgSoGro6ilG9xd6pvX4JKz++1Cr4vfsbbwE0v5R8Gz8GmLqEYm19Om2fkiz/
 BdTRnRzeGlL3WGrGzplY+iuqSaX13/05tKTcJmmnap1l2Is0xujU5zcdqCeFqLsxtWLH
 N3x1QYyCchHVvRRJnr7bbr/d6b62pVXRDj1OaGLyNdRzUHuiN+ydbwJFQgzjuYB1Xdob
 8TulJOhRdH9JZbfBSAtfY8JzciAyYH0qR6iKFAMCpoOOarF4hsADVZl1M9OSxxtAxur/
 Kffg==
X-Gm-Message-State: AFuF++kv6OpS1GW1szDHCK7QMBrRVA4UmBemdCgNVy7MMhmShRqVm5cx
 wDfwBt8DVeA/EdivP/78P4gI0WSkx+DdgJNRTihtf6ZK7LeGOGjo2DEtpCyThG4xcpETv8+i0Sv
 PgFGAhznuvfrxjwlWdmbywSFG9f+Hr34seuSwBEzyTJWU1xKWhch3w/EtJVOc3rsWqFFbyp8oEL
 3zqpl7vQ==
X-Gm-Gg: AR+sD125xYYDy6UQYcyMzRH5c1rOcplvGTPGhaZVZ/0H/I4rhLurADOMMvycMhCZsZW
 cbSA4EeyySast/llBqaHM2sfOVmaOGtE6dy2ymcDaVygRbE5YxMf8KrE2x10DamvaTlp4gCilCi
 pBJRhLEPdIIW+5puVrZbxz9328755K/3pVHiuXObV2LRWDCj1mUWrIqlEW2cfGtvmYOYiqx/lMd
 ctwusbtv27xBlfHkJbmTzEIz3q3Y8Zw8RJoYSD7XOUq7lV/0fS0r56uK2bK2oGFse9++VzUWlVP
 Cg6ZVsIhKOOijWzS30FIbn+fOpQQTWcCMEmQO+L0wAxa90jmCssZO2hx12Ra0w4s7RCaYMZzF/x
 FrkrKSBWvWpE3W1XFt68s8wW7nMRh2/MHj3qvJdrWWQaDFnxRmjQNs1E0EV9sJSYJrHeY+LkAGI
 ImunUoO3AjiezzrReLG3Mr9kv9ttSZC4bZDdlNkCFrOQek2RTqXufX+bAdThpwgmOv3XBaRV4XT
 XMlXp2L/gEeBwqwb/KM74W8Ab6QiNwfD7vWF0bw2Vg5jGKbmzKzyM2wcE3ra6QGUd3h2SAjT0/A
 J9mGyFseaHOS+BjXvEb6UBtp7xLYerIiBlRt16t+6+39yLW/8Bs378ZAiMnUtw==
X-Received: by 2002:a05:6402:3242:b0:698:3469:fa99 with SMTP id
 4fb4d7f45d1cf-6a42eeaf740mr7397244a12.0.1787328375778; 
 Fri, 21 Aug 2026 09:06:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff16c2cbsm7567761a12.22.2026.08.21.09.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 09:06:15 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 21 Aug 2026 16:06:13 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icd53745b242e0ca2943863d5b274b2a13b4419bd
X-Gerrit-Change-Number: 1851
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1851?usp=email>
X-Gerrit-Commit: 42fbc73ee1e2be9a109f4cb9337e951c4c4c67b5
X-Gerrit-Comment-Date: Fri, 21 Aug 2026 16:06:13 +0000
In-Reply-To: <gerrit.1787327336000.Icd53745b242e0ca2943863d5b274b2a13b4419bd@gerrit.openvpn.net>
References: <gerrit.1787327336000.Icd53745b242e0ca2943863d5b274b2a13b4419bd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkljZDUzNzQ1YjI0MmUwY2EyOTQzODYzZDViMjc0YjJhMTNiNDQxOWJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5175e62632ad9ac5cbff64dd7bd09cf2833406c0-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wxRl8-0006e1-Gn
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Make
 pull_permission_mask return uint64_t
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
 openvpn-devel@lists.sourceforge.net
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0027996227693569457=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0027996227693569457==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LypiUWkuMrY="; charset=UTF-8

--LypiUWkuMrY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

razvanc has posted comm=
ents on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1851?usp=3Demail )

Change subject: Make pull_permission_mask return u=
int64_t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 1:

(2 comments)

Commit Message:

http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1851/comment/f5c5742b_e62e09fd?usp=3Demail :
PS1, Line 9: Commit 9=
1fd9614 already change most of the instances for the
Minor typo: "changed"=
=2E


File tests/unit_tests/openvpn/test_push_update_msg=2Ec:

http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1851/comment/54572d9a_e49912a2?usp=3Demail :
=
PS1, Line 26:     unsigned int flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OP=
T_P_SOCKBUF | OPT_P_SOCKFLAGS
Should this stay `unsigned int`?



-- 
To vi=
ew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1851?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: Icd53745b242e0ca2943863d5b274=
b2a13b4419bd
Gerrit-Change-Number: 1851
Gerrit-PatchSet: 1
Gerrit-Owner: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Ger=
rit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: =
Fri, 21 Aug 2026 16:06:13 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: =
No

--LypiUWkuMrY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1851?usp=3Demail">View Change</a></p><p>2 comments:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1851/comment/f5c5742=
b_e62e09fd?usp=3Demail">Patch Set #1, Line 9:</a> <code style=3D"font-famil=
y:monospace,monospace">Commit 91fd9614 already change most of the instances=
 for the</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Minor typo: &quot;changed&quot;=2E</p></li></ul></li><l=
i style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_pu=
sh_update_msg=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1851/comment/54572d9a_e4991=
2a2?usp=3Demail">Patch Set #1, Line 26:</a> <code style=3D"font-family:mono=
space,monospace">    unsigned int flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS |=
 OPT_P_SOCKBUF | OPT_P_SOCKFLAGS</code></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Should this stay `unsigned int`=
?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1851?usp=3Demail">change 1851</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1851?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: Icd53745b242e0ca2943863d5b27=
4b2a13b4419bd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 185=
1 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 21 Aug 2026 16:06=
:13 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--LypiUWkuMrY=--


--===============0027996227693569457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0027996227693569457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0027996227693569457==--

