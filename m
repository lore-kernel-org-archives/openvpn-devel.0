Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C287606A321
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LddI3n5N;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ULawOIH3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jG3/DlPj;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GyUE3u6B
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=Hp8/DrGvRC0ux4w9Z6IRsDSKtnEDInyD0s4ytxTjsTg=; b=LddI3n5NxJvAV+wxaKNNlJ7zG8
	ccd+tXXyetr0NW19BA15YRw0euBYVDwKUv1Kk0n1B0mPJs6hXX+uMkAs6E+GuuMLHrMI2IPbh0C7l
	N93Y5jg1KjbCYx5IQhUq5J3MvT68+FEmuK+ynp59/iD6SRnzrDMbs0MyMBttlPjM6a8M=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVtqb-000000007kV-3QUf;
	Tue, 24 Nov 2026 16:58:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVtqa-000000007kN-3kiz
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 16:58:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OfpElf6IvM0yw/FBvkUVhQf9oOVYVwnTTnG6QycgQR4=; b=ULawOIH3WD2MCPY0ZPoOLZXudJ
 Jl8kMJIdW9DZs5VoT81+lwmzvCSilyfKZ63bih/EBcefLf31AgWw/r1DMZrl7rtW9sI6yeDtjJAC7
 P/Io0kYH8F9cSz87sGpd2MaMcGFOhPhMo/nonZ5K7TBZvsJQHQ8wFtPcE7APWslzpz5o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OfpElf6IvM0yw/FBvkUVhQf9oOVYVwnTTnG6QycgQR4=; b=jG3/DlPjLcj+Sg56ZaNrltxkoZ
 iwAEbN4pdou4xeHnNnISU1SFz2s5qZEIt5qQTAKB1/O/+Mx5HaFaNDZOrpNYCMEn5WuHe5apy/RMY
 dsXiwU4zK9qLZEy/nZ1AwsTgmjKvrqOmOPYx8CObsqVEWdWAz4quzRu+2eZOEsO8Atbs=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVtqZ-000000000PK-1pjt for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 16:58:24 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so2744276f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 08:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795539497; x=1796144297; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OfpElf6IvM0yw/FBvkUVhQf9oOVYVwnTTnG6QycgQR4=;
 b=GyUE3u6B9zFFgWxXZweEl9dvSB/vBWfQ8ViNfNwQQP69n19/dg9KhNCQWirkiW5kO/
 6Opiee5hdu2y06sYRbTHEw/+4F3xqMyx5mU2mDzBI8a3fEp6VJ9SvbunS+DZWRDI2nN9
 TUmFwct/1NNeKqoP9DxFzU1PeguOkP6DQGH6E6xIgeXmGG88v8wdfCftr3E+9LcibIYb
 yY2NSUkyqUiE+GpIwJ0LYOyADbSfCyDWknIfr/6iqK+CCaG6NMsfz7A/XmHHtOF0Wd6H
 /RoLJ3OlJJFpiqsGlI5nK3Mv8KnOTfS3TNYwquP3V0Fyg1MsNBMI8mIMEk3lSYCfPwQA
 Sk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795539497; x=1796144297;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OfpElf6IvM0yw/FBvkUVhQf9oOVYVwnTTnG6QycgQR4=;
 b=JOB9xZqhmUMZUqXC1d0mm313Qss0aF7xwUm99tK+iAejuSxr8k80j2fk0cmv2rAfZH
 c4QfgeQ4eCeoUlurSe70v8W/wHcXT1cODeDITz7v58Ya1JUeMBQ6xopQSWJYerlZI553
 3uCe3K+7edgvFtY1uzAKy0rMvrKj3RKbu33oLj0aECO3AILYYGb2WQ1x+5dQ5YTKYJIj
 GhWVY8mMwyLIcXYnvZSHgxU91PNBtVc7JRqDAIf9/JcIeei0eOah/2KspEXS4ujFk9t8
 HxY1r/3vjP8szbOhM3v4SDbAEv79mMmME2LKEKlz9mPOMDUo1NJyjqvZqDz4+18YtPfV
 7ykw==
X-Gm-Message-State: APuU4Z9i6Flq8Jibv9PG3VL0tIfNBHiVQyZCEhuSgrN5iUq7iDkDzG/u
 heraSvqHYzJoyEM03AGhYMDj56nHZRjq5sM2kpeHUh9DDA3OIv5XZn5lU6Ex/P/dCz1Oiec/QmL
 rhHrqSvHRooxh1aVzVLkTsZLe+wxORkNtBRrIibn5s3RJdF2iXK/fV/E016E+8PI5GO/jA66/XA
 1dDdw3ag==
X-Gm-Gg: AZFdTZeQOpIDCDmEO5MvMNiHsxfmvko/nEQSfOuJtqSPZVAjHgoP36YXGgu8aiGcMrz
 cw3pj3rIWL/ikRDeVeqj/T7UVWTucjabviHuuvlN4x84bZlYkS2ODb8etqu3eHhCCM4dA+Zb3Pf
 YZRTIcxCALy7JVkCFBePpHwY6ppVNbkcoM6RErOc34xcVaY7kyomEZJwCtVruDYl+DOfjM9DBbR
 EyZv/ex0nwQfi7S/hqAigy2NcxngI3f3GvIFV9PIdNZbmiK3zR7UD95gbVX1k/u28dF/7T0gbO8
 rrq1MXKXxj84hWgNYPa8kQdzIfJ35DZfw6+JoefPO+hLjfnVQ6OvAfk4dfR31LhllD+OCosQpz8
 o+zbFw4BUmFJBLd7LVZWGbLJfD1czY66O365BM0GyXPG3Aw84b4fQqxJxSZsy3B3+4lwBbTYQat
 jfum01qdsL6qD8rvPZFYBmZH6vqzFIYKvWWSQLre1cbmfByjxC+px4LooLWbtLxvOdxab9PYJ9F
 oXMFU4ru3DHySgbMT9nT6cP+XuzWcTtaSAZ7y8xmPKZK0h4cxveWmsb8fIGxkI+w1ZNvt6N0uZj
 DSqu1YRiACOCjewponB5v7oF8vHVz16U3nVy3JTaYNmE8bKl0zmsmF8rRpJods+dSmX23MvTeO6
 +6ozCH5fcDWxc5JOoNHDuwILYfkAVtQw6jAYgn/Cmu8An+AJI0hw+Geo7/ZLd1vGH3bN9usrS8g
 74Ns3NjOCqnJHqRIU=
X-Received: by 2002:a05:6000:248a:b0:487:b50:101c with SMTP id
 ffacd0b85a97d-4abaa97702bmr28291958f8f.5.1795539496644; 
 Tue, 24 Nov 2026 08:58:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bc8ce06sm28472956f8f.47.2026.11.24.08.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 08:58:16 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 16:58:16 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id5152a5aacdd50f2fa9c5b3dfab92be8887541db
X-Gerrit-Change-Number: 2340
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2340?usp=email>
X-Gerrit-Commit: 1293f16f252440a4bb29d286d2f8f6e1f117d3f3
References: <gerrit.1795539493000.Id5152a5aacdd50f2fa9c5b3dfab92be8887541db@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTM5NDkzMDAwLklkNTE1MmE1YWFjZGQ1MGYyZmE5YzViM2RmYWI5MmJlODg4NzU0MWRiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e46dce6097140a9dfadcb3deab37ac813a6a68e0-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVtqZ-000000000PK-1pjt
Subject: [Openvpn-devel] [S] Change in openvpn[master]: argv: Fix conversion
 warnings in argv_printf_arglist
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0425256030263584509=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0425256030263584509==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="t1jMtsu2ybU="; charset=UTF-8

--t1jMtsu2ybU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2340?usp=3Demail

to review the following change=2E
=


Change subject: argv: Fix conversion warnings in argv_printf_arglist
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

argv: Fix conver=
sion warnings in argv_printf_arglist

Due to the int return of vsnprintf th=
is is always
going to be somewhat ugly=2E

Change-Id: Id5152a5aacdd50f2fa9c=
5b3dfab92be8887541db
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2E=
com>
---
M src/openvpn/argv=2Ec
1 file changed, 5 insertions(+), 14 deletio=
ns(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/40/2340/1

diff --git a/src/openvpn/argv=2Ec b/src/openvpn/argv=2Ec
index =
c716e5b0=2E=2Ecf841a5 100644
--- a/src/openvpn/argv=2Ec
+++ b/src/openvpn/a=
rgv=2Ec
@@ -323,11 +323,6 @@
     return f;
 }
 
-#if defined(__GNUC__) || =
defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ign=
ored "-Wsign-conversion"
-#endif
-
 /**
  *  Create a struct argv based on =
a format string
  *
@@ -378,9 +373,9 @@
      */
     va_list tmplist;
    =
 va_copy(tmplist, arglist);
-    int len =3D vsnprintf(NULL, 0, f, tmplist)=
;
+    int test_len =3D vsnprintf(NULL, 0, f, tmplist);
     va_end(tmplist=
);
-    if (len < 0)
+    if (test_len < 0)
     {
         goto out;
     =
}
@@ -389,10 +384,10 @@
      *  Do the actual vsnprintf() operation, which=
 expands the format
      *  string with the provided arguments=2E
      */=

-    int size =3D len + 1;
+    size_t size =3D (size_t)test_len + 1;
    =
 char *buf =3D gc_malloc(size, false, &argres->gc);
-    len =3D vsnprintf(=
buf, size, f, arglist);
-    if (len < 0 || len >=3D size)
+    int len =3D=
 vsnprintf(buf, size, f, arglist);
+    if (len < 0 || len > test_len)
    =
 {
         goto out;
     }
@@ -423,10 +418,6 @@
     return res;
 }
 
-#i=
f defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#end=
if
-
 /**
  *  printf() variant which populates a struct argv=2E  It proces=
ses the
  *  format string with the provided arguments=2E  For each space s=
eparator found

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2340?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: n=
ewchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id=
5152a5aacdd50f2fa9c5b3dfab92be8887541db
Gerrit-Change-Number: 2340
Gerrit-P=
atchSet: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>

--t1jMtsu2ybU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2340?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">argv: Fix conversion warnings in argv_printf_arglist<br><b=
r>Due to the int return of vsnprintf this is always<br>going to be somewhat=
 ugly=2E<br><br>Change-Id: Id5152a5aacdd50f2fa9c5b3dfab92be8887541db<br>Sig=
ned-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M s=
rc/openvpn/argv=2Ec<br>1 file changed, 5 insertions(+), 14 deletions(-)<br>=
<br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/40/2340/1</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/argv=2Ec b/src/ope=
nvpn/argv=2Ec</span><br><span>index c716e5b0=2E=2Ecf841a5 100644</span><br>=
<span>--- a/src/openvpn/argv=2Ec</span><br><span>+++ b/src/openvpn/argv=2Ec=
</span><br><span>@@ -323,11 +323,6 @@</span><br><span>     return f;</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;=
-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> /**</span><br><span>  *  Create a struct argv based on a format string=
</span><br><span>  *</span><br><span>@@ -378,9 +373,9 @@</span><br><span>  =
    */</span><br><span>     va_list tmplist;</span><br><span>     va_copy(t=
mplist, arglist);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
int len =3D vsnprintf(NULL, 0, f, tmplist);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int test_len =3D vsnprintf(NULL, 0, f, tmplist)=
;</span><br><span>     va_end(tmplist);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (len &lt; 0)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (test_len &lt; 0)</span><br><span>     {</span><br=
><span>         goto out;</span><br><span>     }</span><br><span>@@ -389,10=
 +384,10 @@</span><br><span>      *  Do the actual vsnprintf() operation, w=
hich expands the format</span><br><span>      *  string with the provided a=
rguments=2E</span><br><span>      */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    int size =3D len + 1;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    size_t size =3D (size_t)test_len + 1;</span><br><s=
pan>     char *buf =3D gc_malloc(size, false, &amp;argres-&gt;gc);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    len =3D vsnprintf(buf, siz=
e, f, arglist);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (len &lt; 0 || len &gt;=3D size)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    int len =3D vsnprintf(buf, size, f, arglist);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (len &lt; 0 || len &gt; =
test_len)</span><br><span>     {</span><br><span>         goto out;</span><=
br><span>     }</span><br><span>@@ -423,10 +418,6 @@</span><br><span>     r=
eturn res;</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span=
>  *  printf() variant which populates a struct argv=2E  It processes the</=
span><br><span>  *  format string with the provided arguments=2E  For each =
space separator found</span><br></pre><p>To view, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2340?usp=3Demail">change 2340</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2340?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id5152a5aacd=
d50f2fa9c5b3dfab92be8887541db </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 2340 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </=
div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--t1jMtsu2ybU=--


--===============0425256030263584509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0425256030263584509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0425256030263584509==--

