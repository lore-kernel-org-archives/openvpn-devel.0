Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA64EC5CFC1
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AAgXC1IzZ0NyNixbnOE6jhkldfnspmy2+EPy6iF/vBU=; b=hxLBGqfpOavr9hrAPHgxMToqSF
	SK3OR2FqxtNk3+ibzPlmuJlwq/EXzTeURIQIYZxi79qrJ/NrCRPVKXIpaZgX6h8c5vBLen5OrCIF6
	R9JRXaOcLxPKxFjAq0LPN1CQkf0QZEVshP8M/THlW/PpsX8Bz6Nvt8YIFX/kl2ZG32XY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wumVX-0005SI-GJ;
	Fri, 14 Aug 2026 07:39:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wumV6-0005QN-HC
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 07:38:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=UEdVHexzM0O9NbPKTZavm2s7RPlJCGD0DFrsmRnXKNU=; b=lDeYgY1+WxEIzINBh5GuUpqHLq
 Ufdlixok2QRb7pf8g8rZucXaC3TblJ7KTskZ/EZlopvxEQ/kI6LSicpyNRqDVNkPbbdxlnX48Fmjf
 T8nJeoUlxZVF4591w2fCcBhDEybgyXkSAExbhzRJB6656ve5Xs6s5KiV1qf8aqBgrO6c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UEdVHexzM0O9NbPKTZavm2s7RPlJCGD0DFrsmRnXKNU=; b=F
 0zl++/ZDICsIMHGjFFzky+39KcqMJxvjIinc1wyx61hMVPRfTcMfITMSV/Vml77H4o1oqUkXr2xJS
 an68VHxBCLcv7lZnXavojV5UYqrket2xAQV2nf1R3dNp38sr0PfCOEOzaFeDhhOtma7Q9LIPFD8SJ
 Lb12Cl5b5DyHyHaY=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wumV8-0003Bt-Ql for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 07:38:49 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47fecbb7000so316807f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 00:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786693121; x=1787297921; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UEdVHexzM0O9NbPKTZavm2s7RPlJCGD0DFrsmRnXKNU=;
 b=FfnaXhoFW0ihveC/IoQFQHQ+9LaM6wuUnYPpGUZWe8ebiIcyc70ds+Qvt8HHPEWCw6
 Q5YjXAzyE1YNPibL3UMbhXkgJ9qLcfgI1dhZ3XTS6LoVoytRhoECBc0MHn7or6hfQhTA
 t+MGfe5piaSEHtR7pdfMTS0D2qcvUtTtGY5VmJvmeW7vwUrdKGsCRZzJVGvfDtsZhioD
 aVM40UH30hPIDCmyWqsFUD6yMcqWlc5tuqiBBUN/NHzg/CjSlvVlQREOK771gPW6xvrb
 pd6NuinLxeFLwHemW9PIc5vEHJOV28jF+4BwpNm6DfIxXZH3L0OMAFPVgC98mHr23CqS
 nf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786693121; x=1787297921;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UEdVHexzM0O9NbPKTZavm2s7RPlJCGD0DFrsmRnXKNU=;
 b=eTCtcznQZLFep4fDEAQDCZmpV79d41id0kqKHiQN+34N7axN4XI496fpwgdzU+7aI+
 ycfYSMz+zyl6ZZUAbPceBDdKFxrlHAFmvYStrxKyssc0Oj2K0/SRFo13pjd+6AZbjAS6
 04QRLgMYo14wk6cS5TUOQ0NCffbsYeVHH7MEb34T2xlA38IA+7C6fvugRWIsMS8pYslw
 miFzCO7rjpbJhxjUG30GLSZKW8LwKFVcbZ/IY6D/6XY8BTp8rmyaiY8YlJS4qxfQ9avV
 ixQH2dNlJLzCrqXT4jk0GV1sfNoqz/KApXkNX71+Hjf3Z6v7vlEqGy3HeOyElwBZRnVx
 xRfg==
X-Gm-Message-State: AOJu0YwqSlBEvdEawVeN6rbpLmWRlgO/1fMEH2YHPmcLy39ehzDJdy+U
 QGY/iJS7zHZLwFCMbygjiSC3k/RVOMzT+Y1J4MfMRA2A3NCgzbw1Y7a/nfz9tWkr8rcoNbCroWp
 pLVEamfXgPb9cdkjfKn6Gl77LAdIrlFGEUIfj2r7wcAHnIRIXxDqr1xXtR6+bRuAx7uN12B24X6
 lW+uERRA==
X-Gm-Gg: AR+sD11JXzX2LvJ0IrYVLkAHLGAuQNo+ilTpX6aDlnuVles21sGtmwjXIHhnnqQtk/w
 GPf8ptR4fr7eENtpefhqs4aX0vwSxCnUuhnbX3SAe6m8N14t0923PxgoaSsGmTkoGy+VsV7FJZE
 PqjlCvSVgbC+pJ5SEVgI2c/uqh6dOZ9wm5f1wJiCJpHhSuo0IixRsr1tmUkghbtkw7AUPeKXoEt
 js1UxITz1/4ThLvz4C5byzjYVOvMr56PKlfuOq1KwLQSdda3RcqTZc2finNJH76xi7Fnb6LBdEP
 M3TYkXZSzWT7xYbyHCYtIqbCi3ibINg4hjr0WNvpI8KWH7KqWIrhc8Zbo0GnxqD1zimbgPvIYEq
 JTOmiDug+qO8eT0WAnXTZyunl75jRlM1BPTdjPVxWPbZuIQQvGDdSdLHzSF0cMPmAXCaOdUvttP
 gkUySM2unfShJyyXnKfd5PQyznPfgK2UkIzTKc1gqShavPgKxVjpw4FRibt5rV4F3DOHfpftWEC
 FPoPPL6X5Ndm3mwGGyF8FVgeOb/ttCUIrCLKpXH8xrRxS1PxU8+6bFjbMRNitpvNjegQ4L84FQj
 2zXMKQDBJSo/OVSHpBcgGpioN6EExixiaGC8JRWFr2P27QcBO6I=
X-Received: by 2002:a05:6000:460c:b0:47f:e886:6dff with SMTP id
 ffacd0b85a97d-481606f67e3mr5929322f8f.4.1786693120480; 
 Fri, 14 Aug 2026 00:38:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2cc811sm5764038f8f.33.2026.08.14.00.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 00:38:40 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 07:38:38 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: I2ca40d0d86599896b38ea1467313b6a6cdc8339c
X-Gerrit-Change-Number: 1527
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1527?usp=email>
X-Gerrit-Commit: 8f2c2fac6cebe453166666fd73c0f58fac1f4a29
In-Reply-To: <gerrit.1771008896000.I2ca40d0d86599896b38ea1467313b6a6cdc8339c@gerrit.openvpn.net>
References: <gerrit.1771008896000.I2ca40d0d86599896b38ea1467313b6a6cdc8339c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzcxMDA4ODk2MDAwLkkyY2E0MGQwZDg2NTk5ODk2YjM4ZWExNDY3MzEzYjZhNmNkYzgzMzljQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f4aac44ad8166b1b5ad1adb5339eb35a21016254-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wumV8-0003Bt-Ql
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tun: Avoid
 sign-compare warning in header_modify_read_write_return
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7964016736865191674=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7964016736865191674==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0WvoaGROcFA="; charset=UTF-8

--0WvoaGROcFA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#10) to the change originally created b=
y flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1527?usp=3Dem=
ail )

The following approvals got outdated and were removed:
Code-Review+2=
 by razvanc


Change subject: tun: Avoid sign-compare warning in header_mod=
ify_read_write_return
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

tun: Avoid sign-compare warning in header_modify_read_write_retu=
rn

Since we already check that the value is positive
just make the implici=
t cast explicit=2E

Change-Id: I2ca40d0d86599896b38ea1467313b6a6cdc8339c
Si=
gned-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan C=
ojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1527
Message-Id: <20260813180835=2E3160-1-gert@greenie=2Emuc=2E=
de>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg38330=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede=
>
---
M src/openvpn/tun=2Ec
1 file changed, 1 insertion(+), 10 deletions(-)=



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/27/15=
27/10

diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index e7193d8=
=2E=2Ef2a4394 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@=
 -1706,17 +1706,12 @@
 #include <netinet/ip=2Eh>
 #include <sys/uio=2Eh>
 
=
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-=
#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 static inline ss=
ize_t
 header_modify_read_write_return(ssize_t len)
 {
     if (len > 0)
  =
   {
-        return len > sizeof(u_int32_t) ? len - sizeof(u_int32_t) : 0;=

+        return (size_t)len > sizeof(u_int32_t) ? len - sizeof(u_int32_t) =
: 0;
     }
     else
     {
@@ -1724,10 +1719,6 @@
     }
 }
 
-#if define=
d(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 st=
atic ssize_t
 write_tun_header(struct tuntap *tt, uint8_t *buf, int len)
 {=


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1527?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2ca40d0d865998=
96b38ea1467313b6a6cdc8339c
Gerrit-Change-Number: 1527
Gerrit-PatchSet: 10
G=
errit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--0WvoaGROcFA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #10</strong> to the change originally created by flichtenhe=
ld=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1527?usp=
=3Demail">View Change</a></p><p>The following approvals got outdated and we=
re removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">tun: Avoid sign-compa=
re warning in header_modify_read_write_return<br><br>Since we already check=
 that the value is positive<br>just make the implicit cast explicit=2E<br><=
br>Change-Id: I2ca40d0d86599896b38ea1467313b6a6cdc8339c<br>Signed-off-by: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojoca=
ru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1527<br>Message-Id: &lt;20260813180835=2E3160-1-gert@greeni=
e=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lis=
ts=2Esourceforge=2Enet/msg38330=2Ehtml<br>Signed-off-by: Gert Doering &lt;g=
ert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/tun=2Ec<br>1 file change=
d, 1 insertion(+), 10 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/27/1527/10</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index e7=
193d8=2E=2Ef2a4394 100644</span><br><span>--- a/src/openvpn/tun=2Ec</span><=
br><span>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -1706,17 +1706,12 @@<=
/span><br><span> #include &lt;netinet/ip=2Eh&gt;</span><br><span> #include =
&lt;sys/uio=2Eh&gt;</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored =
&quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span> static inline ssize_t</span><br><span> header_modify_read_write_ret=
urn(ssize_t len)</span><br><span> {</span><br><span>     if (len &gt; 0)</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       return len &gt; sizeof(u_int32_t) ? len - sizeof(u_int32_t) : 0;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return (size_t)=
len &gt; sizeof(u_int32_t) ? len - sizeof(u_int32_t) : 0;</span><br><span> =
    }</span><br><span>     else</span><br><span>     {</span><br><span>@@ -=
1724,10 +1719,6 @@</span><br><span>     }</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span> static ssize_t</span><br><span> write_tun_header(struct tuntap =
*tt, uint8_t *buf, int len)</span><br><span> {</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1527?usp=3Demail">change 1527</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1527?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpa=
tchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: I2ca40d0d86599896b38ea1467313b6a6cdc8339c </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1527 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none">=
 Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></=
html>
--0WvoaGROcFA=--


--===============7964016736865191674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7964016736865191674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7964016736865191674==--

