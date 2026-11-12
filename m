Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165D8606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bJXOUgEt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SzZm/XWj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TDVpeb/y;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QlUqanLN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Km8d7DJmVT9oFOoQNHDtXio5Sx93nTWIewqo5d4aH7o=; b=bJXOUgEt4kxdjTrIzUObLfQCpe
	bJi4FkqDczfgzOV6823+qxA1KqElCaI90A0mFiRAtnDWmxiDgW2QbshyhxWTxSjn/dASrifCwTfmv
	ni8PtCvjbGbZuWWD7jyq6uWQoxY2t3K8U67KB8T3pbFOXeH0plGxDZez3iRt2OlwdFJs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRYLB-000000005EM-31Nf;
	Thu, 12 Nov 2026 17:12:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRYL3-000000005Du-0qTD
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:11:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fxa9XXNmBjSRoDBY/ccrPzkm8UQdeyIryFikGJOttpI=; b=SzZm/XWjnOSuAau75g3+V/juof
 y5V8P3WGP0HGWq2GbtQdYDhMcvCg6Eg1mOg6bZttxvvvplQRrlBFczLZzonT1KdinyBgIhtrYsT2B
 DiaulUeNAkuJ26AEiqBtccotlZcv4+ReZWtdYBSBe8lwXlRgiWbJ74wA2t4L6Ybk9Hqo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fxa9XXNmBjSRoDBY/ccrPzkm8UQdeyIryFikGJOttpI=; b=TDVpeb/y+b8+kzCCz7xLM0zg0N
 vJ2+q+7ufXQ61VkRIKv+jUSBAeAhWJQiAAD5jz1WSB61w66WN71AVNGlOj+N1JmbsdpwtsS+Myl/c
 O6OuaSYe5t4TxvC5bJpuiDL+MM8MjQg9J3hdf5/RLrmrGmW7mwcAoGI8+ESE9pBjSH+s=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRYKz-0000000075M-3HNv for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:11:53 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4b79502c27aso247155e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 09:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794503503; x=1795108303; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fxa9XXNmBjSRoDBY/ccrPzkm8UQdeyIryFikGJOttpI=;
 b=QlUqanLNCQsQPI6/YSGCzUDr5OQol8qFW0DiyaYSMVD/Yuq0pYUUnmvBw6Ck4AjlcZ
 SPhrhQUbrIufOAENGFJ++VWrykusNYQhb6r3fEA8SllM3oNBnFU+Dtv7FMZ6e0MZKdmb
 BiTI9IqYt/UFPrhBy/ECK396LoR/mEfbn6b8mKd3paBiWq/8AGYJaSlBWJQ9fKnJhi5H
 HczzyQehxiteWwnckteeOJKmHy+zy3+sfuM67t5EvY/2KAltikKkHKxkpzgWMvTXqu+r
 TCOroc7csUjLAWd61JTkyVE9NO8HygX6PtWW17p/QLGS5Guu1HXA2FKBcz/wsoWGaQaP
 95iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794503503; x=1795108303;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fxa9XXNmBjSRoDBY/ccrPzkm8UQdeyIryFikGJOttpI=;
 b=hCF+WFKNW+Tv7cdlXdsksy4i7LSedvBLfYlYmZeCOGY0U+FNGKF9kW6b4hY4iHZ1Mh
 nYZ9PXpm18c0azDP+tI1QRXgEJQztQW5XXQNiD+DXj95DXsLl8N/lKAgs2I5D1G2oeo4
 5CTlQcIVhux2dpQdY6ZmWo2UjCEHtGknGgPw6u/LyDr0yfeHzIe3Jkax64j6VMuCwdS/
 vZaXEqd7FhK5Ok2LJvzvMNYm80XtWmjYBevklKzwLh0zy0YXgHu8z7XgJy6UAN13q4fD
 Fngiuk1qy71kwklaqNvBtesM/xcjbSaetpwxtqDYGrbqevEAJqnkX2Th4DRJ5OVBI/GC
 uKMQ==
X-Gm-Message-State: APuU4Z+PbcRU59cA5lu8V7DMPBzq/fLazgHfxIfFl40ZONvTv+fR7ua0
 PTNh6k0joxnTc9exzmfhXQktV9wUZSRc/0a7rPmlKQZiK88SDvlAToOCpzb34WrFU5b/A4hle5N
 hy8ninQ6wBT+tlUQDs8Y+XS9gwgfzIR8rNA/5epZIVT9UkRmXhpMLDlXQFPkjhBjohqCC
X-Gm-Gg: AYBFou2DkdS4tu+xCnCDZScKUBj3BknbNKUYvIcjr2muXa9IhXg38Z6wNAPLK9tFcj+
 ioOGpGR9HfWt9CzRkDswIx6QKbBEBtsml9EAXs2/tM3JB55LytOKngt1bcH2s14rVY/fJnMb0iW
 STuQnGDSyy7p5vcmgN3aNz3Rs6KlngpkLX6yFsHU3iKNxAbxHGBTNuWiBQjWXQasxF4RjoyBHkQ
 NLJf/9k6zJEDECDtPhR9reVK7AewMdpBdPo+yzXwuvpdVjmESDTRQ4QgaimRMBKEoamfKJLr0+C
 p72sv2f6f90n1CtE6rMVRviIFtkrgFVxFogcKpwNLFz8pctdds4sdIGPdLnqyFS8rbu8WuzcE9R
 4iF7QUuTkiTvicF2G8NqzzkqIE3eaHeZsP8Dw8GYcuv9MH5cdaXHhmVsQCE5PsEng04zC9J9mmm
 udRG85v4JbhAKbnXzmGvNt7+xy3gxvRkM4VoBZmD2lcxVSpeMZMaCAYA4vEWv44636crQAoD9LT
 pS+N3ZQ+0yqUjkyk4xQqZYZdXQPDj5tZT723GYSEtLvLFBevyQnf9wjXD32B9noB4USEOOM8xVi
 IM1QQiJuytXjauKonhw8jis+IhX85MBE5XWYKzzKhev8WuOkzY7KSDbiby7x/oYtEQrZNH8r+LD
 UnL/hx5JheDFnpIM4bPB/qFoR/TciQt8rUFTP/f6BV3D/gvRoLlGaXm7ji1ABBZq4Wsa7f3S23L
 IyrDeP516qtY9a5Zk=
X-Received: by 2002:a05:600c:4f84:b0:4a3:59c2:b41e with SMTP id
 5b1f17b1804b1-4ba0931ed6bmr116637045e9.4.1794503503086; 
 Thu, 12 Nov 2026 09:11:43 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0950f3casm91469665e9.3.2026.11.12.09.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:11:42 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 17:11:31 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie7228ee95c2b43f9be2bf4c6a9a959af2f729088
X-Gerrit-Change-Number: 2176
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2176?usp=email>
X-Gerrit-Commit: 3bda384903bbf3c81f5fb40920030669971e3e85
In-Reply-To: <gerrit.1794417322000.Ie7228ee95c2b43f9be2bf4c6a9a959af2f729088@gerrit.openvpn.net>
References: <gerrit.1794417322000.Ie7228ee95c2b43f9be2bf4c6a9a959af2f729088@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDE3MzIyMDAwLkllNzIyOGVlOTVjMmI0M2Y5YmUyYmY0YzZhOWE5NTlhZjJmNzI5MDg4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <211f169117c9e438039f33f9a8aa98ab83347d4b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRYKz-0000000075M-3HNv
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tun: Make
 error_flags unsigned consistently
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5202887764332100508=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5202887764332100508==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fDUIydBOPQU="; charset=UTF-8

--fDUIydBOPQU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

H=
ello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to reexamine a chan=
ge=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2176?usp=
=3Demail

to look at the new patch set (#2)=2E

The change is no longer sub=
mittable: checks~ChecksSubmitRule is unsatisfied now=2E


Change subject: t=
un: Make error_flags unsigned consistently
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

tun: Make error_flags unsigned consistently=


Previously both int and unsigned int was used=2E

Change-Id: Ie7228ee95c2=
b43f9be2bf4c6a9a959af2f729088
Signed-off-by: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
---
M src/openvpn/init=2Ec
1 file changed, 4 insertions(+), 4=
 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/76/2176/2

diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec=

index 5235c4f=2E=2E585e50c 100644
--- a/src/openvpn/init=2Ec
+++ b/src/ope=
nvpn/init=2Ec
@@ -1810,7 +1810,7 @@
 
 
 static bool
-do_open_tun(struct co=
ntext *c, int *error_flags)
+do_open_tun(struct context *c, unsigned int *e=
rror_flags)
 {
     struct gc_arena gc =3D gc_new();
     bool ret =3D fals=
e;
@@ -2312,7 +2312,7 @@
 bool
 do_up(struct context *c, bool pulled_option=
s, uint64_t option_types_found)
 {
-    int error_flags =3D 0;
+    unsigne=
d int error_flags =3D 0;
     if (!c->c2=2Edo_up_ran)
     {
         reset=
_coarse_timers(c);
@@ -2471,7 +2471,7 @@
     do_close_tun(c, true);
 
    =
 management_sleep(1);
-    int error_flags =3D 0;
+    unsigned int error_f=
lags =3D 0;
     c->c2=2Edid_open_tun =3D do_open_tun(c, &error_flags);
   =
  update_time();
 
@@ -4558,7 +4558,7 @@
      * open tun/tap device, ifcon=
fig, run up script, etc=2E */
     if (!(options->up_delay || PULL_DEFINED(=
options)) && (c->mode =3D=3D CM_P2P || c->mode =3D=3D CM_TOP))
     {
-    =
    int error_flags =3D 0;
+        unsigned int error_flags =3D 0;
       =
  c->c2=2Edid_open_tun =3D do_open_tun(c, &error_flags);
     }
 

-- 
To v=
iew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2176?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie7228ee95c2b43f9be2bf4c=
6a9a959af2f729088
Gerrit-Change-Number: 2176
Gerrit-PatchSet: 2
Gerrit-Owne=
r: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--fDUIydBOPQU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Frank Lich=
tenheld <strong>uploaded patch set #2</strong> to this change=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2176?usp=3Demail">View Ch=
ange</a></p><p>The change is no longer submittable: checks~ChecksSubmitRule=
 is unsatisfied now=2E</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">tun: Make error_flags unsigned cons=
istently<br><br>Previously both int and unsigned int was used=2E<br><br>Cha=
nge-Id: Ie7228ee95c2b43f9be2bf4c6a9a959af2f729088<br>Signed-off-by: Frank L=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/init=2Ec=
<br>1 file changed, 4 insertions(+), 4 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/76/217=
6/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span>=
<br><span>index 5235c4f=2E=2E585e50c 100644</span><br><span>--- a/src/openv=
pn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -=
1810,7 +1810,7 @@</span><br><span> </span><br><span> </span><br><span> stat=
ic bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do_open_tun(st=
ruct context *c, int *error_flags)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+do_open_tun(struct context *c, unsigned int *error_flags)</s=
pan><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</spa=
n><br><span>     bool ret =3D false;</span><br><span>@@ -2312,7 +2312,7 @@<=
/span><br><span> bool</span><br><span> do_up(struct context *c, bool pulled=
_options, uint64_t option_types_found)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    int error_flags =3D 0;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    unsigned int error_flags =3D=
 0;</span><br><span>     if (!c-&gt;c2=2Edo_up_ran)</span><br><span>     {<=
/span><br><span>         reset_coarse_timers(c);</span><br><span>@@ -2471,7=
 +2471,7 @@</span><br><span>     do_close_tun(c, true);</span><br><span> </=
span><br><span>     management_sleep(1);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    int error_flags =3D 0;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    unsigned int error_flags =3D 0;</span><br><sp=
an>     c-&gt;c2=2Edid_open_tun =3D do_open_tun(c, &amp;error_flags);</span=
><br><span>     update_time();</span><br><span> </span><br><span>@@ -4558,7=
 +4558,7 @@</span><br><span>      * open tun/tap device, ifconfig, run up s=
cript, etc=2E */</span><br><span>     if (!(options-&gt;up_delay || PULL_DE=
FINED(options)) &amp;&amp; (c-&gt;mode =3D=3D CM_P2P || c-&gt;mode =3D=3D C=
M_TOP))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        int error_flags =3D 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        unsigned int error_flags =3D 0;</span><br><span=
>         c-&gt;c2=2Edid_open_tun =3D do_open_tun(c, &amp;error_flags);</sp=
an><br><span>     }</span><br></pre><p>To view, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2176?usp=3Demail">change 2176</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2176?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie7228ee95c2=
b43f9be2bf4c6a9a959af2f729088 </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 2176 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </=
div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>

</body></html>
--fDUIydBOPQU=--


--===============5202887764332100508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5202887764332100508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5202887764332100508==--

