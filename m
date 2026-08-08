Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541E4C5AD2C
	for <openvpn-devel@archiver.kernel.org>; Sat,  8 Aug 2026 09:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C8Ms7SLmg4iIAfVx0jyDVdZw8CP/q6BEuGuFJY5Q3Jk=; b=Fx7tzQ74naOc94und6TSXwWzBL
	6eXqTFrP0HsLWdMp0uBJ9j4MYLTD3QMOkOOC5r+5WigS/yIfQW1ZCYUgIW1+efEj7354Amx/DuS5m
	RX1tmtnBFdslENgPR7kV6lMyKIuGXPhJld9h6HFo/7jrCY2DPayuG7bB+7idm3QIM/no=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsdiS-00089I-V9;
	Sat, 08 Aug 2026 09:51:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsdiQ-00089C-OE
 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 09:51:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=WXWkrGUFkzrwpvT3y2zF6DO5nXvU3w9Ioma/0KFFG84=; b=Cv4GYqkwwhIleOMQqL2eiydeSl
 Eqm86xyMnZpsC8XbKj3VtOs3U+b4Jpo5R9faUD23CtR0L+jFfVcow3eglOdtNXdCIkSj4Bstvpd+3
 iTViNMQvUcqb+Jv+oGRE2H87KrW1YcsFFe4SMRn2eEwRYJUZl8p7OqfBF6BFqPJYviGk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WXWkrGUFkzrwpvT3y2zF6DO5nXvU3w9Ioma/0KFFG84=; b=T
 +aJaSyHS1WWjvx5K+SoeeOqiJsjCGlnufG6Y32EFTb7BP+UNyH/1bGC73abrIELefU242rXj+9kKm
 ZkxGQ540iik5rug5FyBzT2FQtqaV0I1O5+rlZ/52FpthZLWkUb/gObgx0qkoYe5X9KLfLbDSt7UQn
 ML9QSV7yFLoI2UJQ=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsdiU-0007HJ-Bc for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 09:51:43 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so1924835e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 08 Aug 2026 02:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786182695; x=1786787495; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WXWkrGUFkzrwpvT3y2zF6DO5nXvU3w9Ioma/0KFFG84=;
 b=Am0ko2i5oegt3QSHe+JephTaK2JetxvNUb+AVch750EnaBkzX4qATHW2zKj5saSsPG
 3i9NHuedPmDapHiId+E9tlLQ5ObR1tyr3DgySE1XcIFH9Gi68wkelDqaz2uhJXnzH/Di
 gecZwNE+yThcLB0cN7WonAQjB/ZWcSqR7jxAMC8Tyc8SSuveFC9OOc5YbiAu6K12dXAI
 8Qo1s3GO0hvT3AZ+9Evfz7bFwOR/tYoaThA59o1/JT78ZlpASQHSDrFJrL3fBRaQi6ao
 fBxcZZmLd/Dg9Hst9RE4mC03D+wNs0KvgrdsVYrvvK0PdBBljoAbPyyKKWPBzmAh1RQE
 G7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786182695; x=1786787495;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=WXWkrGUFkzrwpvT3y2zF6DO5nXvU3w9Ioma/0KFFG84=;
 b=MNTVORHqTAP5bo9DkEBws5fMXseCYUqOQc67hAO/tlVBZyAL3hHuyfOHL+TX49HPAG
 Wl1xUGZrgcqiKVHbMeDYqhL9Dlq5TUJqjJcFzvawmvhxmf/xgVe/Luq9CDvCVmBn71vK
 YcSJApNIGKB+GfTGTqXwTgA+2r/3Y4k9y9qrW2eUqj9h+753M3Y2H19wk6Rl46XKPZPm
 DzaQiIdo+L51OjgM5rIEzQU2XoMaR0hRnaY/BieiD26CpyPSBOsMGk4Q3tgWyntypdQ8
 f7C3mRk3I2RPzCe2l4gmKjw0hwJmfMg+QAqLBHWMFHFXSMBPPcSGI8ctZSNPUpJ7jQPp
 WLZw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrso/Cv3x9K3Gr66JZRYFlXrbAs/i+woQIPNi+ag+jytjgACYTBUa/wPeKwXkIrjWw8q5FrkvJ+uzkKYrns@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzfSGXQM7jljHh9iQZecZxe/UNuCc+ZXoi1e23ZmTsMmERfuEC+
 8HvtZJcqNprLvHBWbtkr59bPkZOSI5/bnSZRuf+MwxFKYAmUTC8D1rhEris8F+eL/QWVsMPWtC5
 TUeWh07fn2uaHWONGuRabV//pe6K1vJ7149RD5aoYwgtet4U4R2EoCQL5dZCI9qFWvJAZ074rhX
 TfKiaVyQ==
X-Gm-Gg: AR+sD12N4LGWym7lxGLTEOQSiTZumkxhdMPfLZwvlJL8sMejqN82o36qBy5gUVH8pey
 VXvUP9Sm8qVytBWqRFySUWVcDVc8MFFsmRBBYmucUR2jyWnBOk9r1gaGhpPQ5qNqk1KpfI8r5AC
 AWTZyrquxYCnUuLYVhGWEl0Cq0SqH7JMtqPxnaPpUeOEE830hefRSh6TDRsM00k9FWlzDT2ZwVY
 QiZKAwMcNGsp85b3sTCifdKo/DRZyfrn9g1Gwq56TYC44ghMdAiXPznHqA9u3ws3R+qc8T6+r/B
 +9qbZs3Pp/9yzI3G9WkbrnZ/JHBXPhK6AMHJCa4/xM9kn7yFBjYbBJ7E4H+B6Tj4U+mLY75o5eC
 i6+gHKQDYoyRpYRrCWCMaNt0ssX5mQxUkhK/eKY2gasI5C7iMeO4qtyLURlvCM1YYNyLfESM8Vh
 ugIyKe/jF2led2R2rIgWAHuTZmrZSxu9sXHqmwkvl/OrhBq9pHyP3zzJFPRRPjmKf2JrWXHESmE
 vwFsaDUDzLBwGgKJDUPX77uFOHritiICJSiqINrB5WvU4XA2c1hWDo5vdivAxmG44hPr3x90aN4
 Wo7lCEP7YSLNmXF8GWeTLABtEN/uLxFKKE0JsuHCTzM6/Y8QMCs=
X-Received: by 2002:a05:600c:b95:b0:495:5858:8101 with SMTP id
 5b1f17b1804b1-4996199186fmr70198195e9.15.1786182695495; 
 Sat, 08 Aug 2026 02:51:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48002206effsm12957395f8f.32.2026.08.08.02.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 02:51:35 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 8 Aug 2026 09:51:34 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ib6956c3a8b332866a59b41c186cce4e0bc5f078f
X-Gerrit-Change-Number: 1791
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1791?usp=email>
X-Gerrit-Commit: 944166798f7696d8db2412be59a29f3e3f19270c
In-Reply-To: <gerrit.1784290573000.Ib6956c3a8b332866a59b41c186cce4e0bc5f078f@gerrit.openvpn.net>
References: <gerrit.1784290573000.Ib6956c3a8b332866a59b41c186cce4e0bc5f078f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MjkwNTczMDAwLkliNjk1NmMzYThiMzMyODY2YTU5YjQxYzE4NmNjZTRlMGJjNWYwNzhmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9a14a5d6225c03f9ec2961d2ff68fd389ab4d65a-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsdiU-0007HJ-Bc
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: t_client.rc-sample:
 Add missing documentation for FPING_ARGS_x
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5985279702068803013=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5985279702068803013==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LwggfsgWsRQ="; charset=UTF-8

--LwggfsgWsRQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1791?usp=3Demail )

Change subject: t_client=2Erc-sample: Add missing d=
ocumentation for FPING_ARGS_x
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

t_client=2Erc-sample: Add missing documentation for FPING_=
ARGS_x

Also include some smaller misc documentation fixes=2E

Change-Id: I=
b6956c3a8b332866a59b41c186cce4e0bc5f078f
Signed-off-by: Frank Lichtenheld <=
frank@lichtenheld=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1791
Message-Id: <=
20260807131327=2E52748-1-frank@lichtenheld=2Ecom>
URL: https://www=2Email-a=
rchive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38207=2Ehtml
Signed=
-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M tests/t_client=2Erc-s=
ample
1 file changed, 7 insertions(+), 2 deletions(-)




diff --git a/test=
s/t_client=2Erc-sample b/tests/t_client=2Erc-sample
index d61ecc4=2E=2Ea35d=
185 100644
--- a/tests/t_client=2Erc-sample
+++ b/tests/t_client=2Erc-sampl=
e
@@ -8,9 +8,13 @@
 # define these - if empty, no tests will run
 #
 top_sr=
cdir=3D"${top_srcdir:-=2E=2E}"
+
+# PKI args
 CA_CERT=3D"${top_srcdir}/samp=
le/sample-keys/ca=2Ecrt"
 CLIENT_KEY=3D"${top_srcdir}/sample/sample-keys/cl=
ient=2Ekey"
 CLIENT_CERT=3D"${top_srcdir}/sample/sample-keys/client=2Ecrt"
=
+
+# Customize ping tests
 #FPING_EXTRA_ARGS=3D"-t 1000"
 
 # Load EXPECT_I=
FCONFIG* parameters from cache
@@ -48,8 +52,8 @@
 
 #
 #
-# now define the =
individual tests - all variables suffixed with _1, _2 etc
-# will be used i=
n test run "1", "2", etc=2E
+# now define the individual tests - all variab=
les suffixed with _1, _2, _2n etc
+# will be used in test run "1", "2", "2n=
" etc=2E
 #
 # if something is not defined here, the corresponding test is =
not run
 #
@@ -64,6 +68,7 @@
 #
 # hook test options:
 #
+# FPING_ARGS_x   =
   =3D "arguments to append to the fping command line"
 # CHECK_SKIP_x     =
 =3D "commands to execute before openvpn, skip test on failure"
 # PREPARE_=
x         =3D "commands to execute before openvpn"
 # POSTINIT_CMD_x    =3D=
 "commands to execute after openvpn but before ping"

-- 
To view, visit ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1791?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Ib6956c3a8b332866a59b41c186cce4e0bc5f078f
Ge=
rrit-Change-Number: 1791
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--LwggfsgWsRQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1791?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">t_client=2Erc-sample: Add missing document=
ation for FPING_ARGS_x<br><br>Also include some smaller misc documentation =
fixes=2E<br><br>Change-Id: Ib6956c3a8b332866a59b41c186cce4e0bc5f078f<br>Sig=
ned-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1791<br>Message-Id: &lt;20260807131327=2E527=
48-1-frank@lichtenheld=2Ecom&gt;<br>URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg38207=2Ehtml<br>Signed-off-by: Ge=
rt Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M tests/t_client=2Erc-=
sample<br>1 file changed, 7 insertions(+), 2 deletions(-)<br><br></pre>
<pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/tests/t_client=2Erc-sample b/tests/t_client=2Erc-sample</span>=
<br><span>index d61ecc4=2E=2Ea35d185 100644</span><br><span>--- a/tests/t_c=
lient=2Erc-sample</span><br><span>+++ b/tests/t_client=2Erc-sample</span><b=
r><span>@@ -8,9 +8,13 @@</span><br><span> # define these - if empty, no tes=
ts will run</span><br><span> #</span><br><span> top_srcdir=3D&quot;${top_sr=
cdir:-=2E=2E}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# PKI args</span><b=
r><span> CA_CERT=3D&quot;${top_srcdir}/sample/sample-keys/ca=2Ecrt&quot;</s=
pan><br><span> CLIENT_KEY=3D&quot;${top_srcdir}/sample/sample-keys/client=
=2Ekey&quot;</span><br><span> CLIENT_CERT=3D&quot;${top_srcdir}/sample/samp=
le-keys/client=2Ecrt&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Customize =
ping tests</span><br><span> #FPING_EXTRA_ARGS=3D&quot;-t 1000&quot;</span><=
br><span> </span><br><span> # Load EXPECT_IFCONFIG* parameters from cache</=
span><br><span>@@ -48,8 +52,8 @@</span><br><span> </span><br><span> #</span=
><br><span> #</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# now de=
fine the individual tests - all variables suffixed with _1, _2 etc</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-# will be used in test run &qu=
ot;1&quot;, &quot;2&quot;, etc=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+# now define the individual tests - all variables suffixed wi=
th _1, _2, _2n etc</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 will be used in test run &quot;1&quot;, &quot;2&quot;, &quot;2n&quot; etc=
=2E</span><br><span> #</span><br><span> # if something is not defined here,=
 the corresponding test is not run</span><br><span> #</span><br><span>@@ -6=
4,6 +68,7 @@</span><br><span> #</span><br><span> # hook test options:</span=
><br><span> #</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# FPIN=
G_ARGS_x      =3D &quot;arguments to append to the fping command line&quot;=
</span><br><span> # CHECK_SKIP_x      =3D &quot;commands to execute before =
openvpn, skip test on failure&quot;</span><br><span> # PREPARE_x         =
=3D &quot;commands to execute before openvpn&quot;</span><br><span> # POSTI=
NIT_CMD_x    =3D &quot;commands to execute after openvpn but before ping&qu=
ot;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1791?usp=3Demail">change 1791</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1791?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerri=
t-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: maste=
r </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib6956c3a8b332866a5=
9b41c186cce4e0bc5f078f </div>
<div style=3D"display:none"> Gerrit-Change-Nu=
mber: 1791 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<d=
iv style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=

</body></html>
--LwggfsgWsRQ=--


--===============5985279702068803013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5985279702068803013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5985279702068803013==--

