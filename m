Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F39DC5DF97
	for <openvpn-devel@archiver.kernel.org>; Sun, 23 Aug 2026 13:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ju3kPe2lJ0HroaL/LhB6/5IEko1UFRYgFhnn/fOx2GM=; b=YpKlws+32X/7Uf5jW807E+FdYp
	ubsWIOmI0RQNXDiU4faHvc1Dsp8OjRnaSeKD1hhOiMtnXH1x67IfnHXnlmmt9n63FvPcJWF38DKL0
	EHFjVawilQiWc+OKIr3aDLr+4bPF5C4zf0OYCVOf4CNFJ4vV+rYlNu1/Tus4zfUWHtkg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wy8Bc-0003Hj-7n;
	Sun, 23 Aug 2026 13:24:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wy8Bb-0003Hb-Oz
 for openvpn-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 13:24:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=TgDo9sNyKEqJvh9yMFsK7wOt0LBD4McGQhJ1A3ZYdTU=; b=JZd1VxQzed5PUBQZLAkfKBgiY/
 nVJ3TGiUdunJ0D/dAbC1FlV02KBheS3s66+xw17LsNkOywzpkkrdZILbbmLbBpOf4hImIanMum36S
 Kw1ADLxEqYWiWqrIdkVN6E7kelpzkpg21A15YRAGtEMUOHDHFyGx/NTMVcOjKzPFb8RY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=TgDo9sNyKEqJvh9yMFsK7wOt0LBD4McGQhJ1A3ZYdTU=; b=A
 D65D7FORqsKNWdcMA/02D5C8/o9ZPsNqKdqkWHc/FyJYioNw7M3i2ZVEtZS5shH7xN6iEiru6Xjcc
 vTVk2YTafTS8y2Kw6ssrMUtIhAUaTAnr9Vrec2aGPnufy9MqDH1QBQhJs6FSoynA7QbsYC9EKXBx5
 msVzBEHJ7r0FnF68=;
Received: from mail-ed1-f46.google.com ([209.85.208.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wy8Bb-0000mX-Fu for openvpn-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 13:24:32 +0000
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-6a374bea882so5078469a12.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 23 Aug 2026 06:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787491465; x=1788096265; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TgDo9sNyKEqJvh9yMFsK7wOt0LBD4McGQhJ1A3ZYdTU=;
 b=RzjRwMLpT4HeChc7Wiy6V/u/R65J+nbddlX6OFX37amzYxeuSFwLhvM+KsQYyc1sa3
 /LGFFn5iN8jutglAzOoaU/fvZvHChUpqqbE1YOV/GKk5VD1GejGSswbpvPPxhv8CQRbe
 I7JibEZLbSk6bhIrL55PHZGKpITrSPy+0hH4/pqPBGMgDd1X1TeOFrXuWPItsFf2tDVQ
 pESePOcddGv6IV9uVs5ZYOtSP7PnxImZqkOJKV3/rms1V2W+cQHDYJG2dRFP/2hacBR6
 WCSXRYvPL8JVaEUjRhBcPgrfZR0M+0VaSa+BuRCbQrGQfYTgOYeXl2knq7Gc71rvQBZu
 ThwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787491465; x=1788096265;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TgDo9sNyKEqJvh9yMFsK7wOt0LBD4McGQhJ1A3ZYdTU=;
 b=IWIZGiUoxiJ1GCoh/LcYv98VTKgE2ceYvWg2OD2RsKeQzArZty0+f2bTOBxVE2Kayi
 BrDYxsXzMqLxGXE7gzLa1D+WAxOQdAXuDp7tbagjKQ91yNHIgjiopynmqhB0RCeQ4MLB
 ddrduUeywMHB1SpioYuQ+hgIoKOzryZxSFLEhkEDLIqBmK0VnsTjCvrmntZMqbwgkwbG
 T0PXYTpOEPW3oV4LlF5Dm/syVjy7WM4r1qYfoQ9bBs63p5SwvxuU7lJncEKMds8JZVTP
 3DV8j7HzzJdtIDhFSbmSrt2olEeLudkDqopSIjMrlHavJ0h5deCXz3tIQqNBYSEmTLox
 94Zg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro8u7w4Rcbi9BMx8AG1M5M/beRFJYCIlgcP9K/PnnlZ656OPE65CJANviasF8aKiXSIelW210NHKALqktUl@lists.sourceforge.net
X-Gm-Message-State: AFuF++n71ruGhEGylmLHlBGAmZjCVKuOdBjfK5P4cxlg5kSmjVvBjJzG
 +flQnw0KrZqB/ggl+IlIxQMOwh+JvDUuIM8eh3VWhw9wtSCkDxUcn9ViIoZn1ngrxL19yNHiqLG
 V4gg0j9dcgmWctqaLLOvyHxaPgctie/xcb7ZJbKut0wC8Vi337fKxQIavZCAk8QfTbg4G
X-Gm-Gg: AR+sD10XbyXC9izIg7Wjx9UERmEooXhqr4poLNaNry52KnmSGOJj2phXBZhWR3+JATS
 JT/ubXkcaqy9lWVE0hdiXhdDJUisNlE9e/ziy+igOb75LI6tjXEqm5rrwcQOgfhvdIr8T5kfLvL
 tmV9TNuKlfMZ91enWYs58DP1ee7SpepMJKzlR3qflSDtYLCKexUrKixAX1ct3WQz0DpAU3Hk11C
 s0QGr4j+ugPh8undgToAetm+bUHzvv6pooHVcDelg750oMCNml97wmbwcGr/yhaUrxQVFAI7WAK
 rISVqoQZWH5wIpi87agFiv2FrPen9HM5nDWHrZFcdO7euHRKomS1YlytcpeMQEhaYcR6juoHw9m
 SP9VfyG1DFNk9nzGMtjEBiDsAvRtsWeUieQVd+0jrHAXMm6cvScjyLH39Buvb/FxQJMmfuW0MpN
 tqFMEXNLSJoZau3BTAo7U3xCg1+x7GmP3cer1QChioYpkfDhmGdwTLAtnuCkjvARusp/nSZ4Oul
 6aRuxs7IYfxdf0NPG3XfEwyy5dRIRr06XAdUksUrBO49iATlayneWDpdFOJzzA/Osbdrz3joC8c
 ujdhNIqey3CD2SsUwLjXAQeJc1d7u7iPfcS0KLj7XjG16qsQLzI=
X-Received: by 2002:a05:6402:24c4:b0:698:ecf:d18a with SMTP id
 4fb4d7f45d1cf-6a42f1be3d5mr19949222a12.9.1787491464781; 
 Sun, 23 Aug 2026 06:24:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e00108asm4874789a12.2.2026.08.23.06.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 06:24:24 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 23 Aug 2026 13:24:22 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icd53745b242e0ca2943863d5b274b2a13b4419bd
X-Gerrit-Change-Number: 1851
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1851?usp=email>
X-Gerrit-Commit: 42fbc73ee1e2be9a109f4cb9337e951c4c4c67b5
X-Gerrit-Comment-Date: Sun, 23 Aug 2026 13:24:22 +0000
In-Reply-To: <gerrit.1787327336000.Icd53745b242e0ca2943863d5b274b2a13b4419bd@gerrit.openvpn.net>
References: <gerrit.1787327336000.Icd53745b242e0ca2943863d5b274b2a13b4419bd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkljZDUzNzQ1YjI0MmUwY2EyOTQzODYzZDViMjc0YjJhMTNiNDQxOWJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fb5099a5c0e8eba87d74479f5fc984dc91629568-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wy8Bb-0000mX-Fu
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3375137328565341245=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3375137328565341245==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XNH7oUK2+ZY="; charset=UTF-8

--XNH7oUK2+ZY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: razvanc=2E

plaisthos has posted comm=
ents on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1851?usp=3Demail )

Change subject: Make pull_permission_mask return u=
int64_t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 1:

(3 comments)

Commit Message:

http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1851/comment/9a934e8b_b22ac1fb?usp=3Demail :
PS1, Line 9: Commit 9=
1fd9614 already change most of the instances for the
> Minor typo: "changed=
"=2E
Done


File tests/unit_tests/openvpn/test_push_update_msg=2Ec:

http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1851/comment/c8eee815_61fc51be?usp=3Dem=
ail :
PS1, Line 26:     unsigned int flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRA=
S | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
> Should this stay `unsigned int`?
Done=



http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1851/comment/255bdbf8_750b98f9=
?usp=3Demail :
PS1, Line 26:     unsigned int flags =3D OPT_P_UP | OPT_P_RO=
UTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
> Should this stay `unsigned i=
nt`?
Done



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
851?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icd53745b=
242e0ca2943863d5b274b2a13b4419bd
Gerrit-Change-Number: 1851
Gerrit-PatchSet=
: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvan=
c@mailbox=2Eorg>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-C=
omment-Date: Sun, 23 Aug 2026 13:24:22 +0000
Gerrit-HasComments: Yes
Gerrit=
-Has-Labels: No
Comment-In-Reply-To: razvanc <razvanc@mailbox=2Eorg>

--XNH7oUK2+ZY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: razvanc=2E </p>
<p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1851?usp=3Demail">View Change</a></p><p>3 comments:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1851/comment/9a934e8b_=
b22ac1fb?usp=3Demail">Patch Set #1, Line 9:</a> <code style=3D"font-family:=
monospace,monospace">Commit 91fd9614 already change most of the instances f=
or the</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">Minor typo: &quot;changed&quot;=2E</blockquote=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File t=
ests/unit_tests/openvpn/test_push_update_msg=2Ec:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1851/comment/c8eee815_61fc51be?usp=3Demail">Patch Set #1, Line 26:</a> =
<code style=3D"font-family:monospace,monospace">    unsigned int flags =3D =
OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS</code></p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">Should this stay `unsigned int`?</blockquote></p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1851/comment/255bdb=
f8_750b98f9?usp=3Demail">Patch Set #1, Line 26:</a> <code style=3D"font-fam=
ily:monospace,monospace">    unsigned int flags =3D OPT_P_UP | OPT_P_ROUTE_=
EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS</code></p><p><blockquote style=3D"=
border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Should this =
stay `unsigned int`?</blockquote></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To vie=
w, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1851?usp=3Dem=
ail">change 1851</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1851?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: Icd53745b242e0ca2943863d5b274b2a13b4419bd </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 1851 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comm=
ent-Date: Sun, 23 Aug 2026 13:24:22 +0000 </div>
<div style=3D"display:none=
"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-L=
abels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: razvanc =
&lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--XNH7oUK2+ZY=--


--===============3375137328565341245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3375137328565341245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3375137328565341245==--

