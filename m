Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BCDC4451C
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 15:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ihXDa9d9uWIemMZ9pTqm4pxBZfd8N3biTVYqSNAHDL8=; b=Jv7Imks2IGcXbGLyLkTZrlea3w
	VmJKYb951qGlbtBwbll2jaaT0i+/AQ1SeC+fzNh2BanTps3HaUl8XXgojO6QpfImDST2xAGy1p0ti
	Ry+ftgbU153ABHPDMINrp4KRwkmNMN3epVJq+tcyOYCg6PjU8GqJ9/GLmbo1fXi1x1G0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkkJu-0003rb-Os;
	Fri, 17 Jul 2026 15:17:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkkJt-0003rV-BK
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 15:17:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=U5wBdDF7DRG28bcaQ5mcF0VBa31VkkZz2BrG2N7QsOE=; b=MB3roypZ2BIBVbHE/+85vePKgC
 xz2vR7nkdR6BekIc3tyM0P43N+rqKJhLiLRYIzh9GE+bVq/OMyNVZXLYLPkzVu7Xg+H/CkfvueFhC
 TC/QvovZz8P3CwjH3jmO2aBoCEJqpp+HT6MuGz9E6tmPRIBL4iRmEu4yU+FvGIp/vfzI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=U5wBdDF7DRG28bcaQ5mcF0VBa31VkkZz2BrG2N7QsOE=; b=A
 fbZ4KG7VuAEcJwLH2aYsJp/TEURexn55ogRw2Sd+a4HcLWOnBYic8lWOHVlYHer+cF+PRg231LDVw
 7Gv0yXEY/9w47DVIr4yW2j4GBpkPIK6XLiMp9/6FRGUqkF2ypq3w7f5zCo/eyPYPUGYF7yIJ3/knv
 Yllmp/UxY9hL+PGQ=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkkJr-0007GX-UL for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 15:17:45 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-493f4638f4aso38244365e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 17 Jul 2026 08:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784301452; x=1784906252; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=U5wBdDF7DRG28bcaQ5mcF0VBa31VkkZz2BrG2N7QsOE=;
 b=P47RmMVrPOT8V9XNDA0pMljCCM5dcsye4AhtNBvtmO9IZTEKpqSMjEb5jXHc207J0A
 F08yrd2ynF9FUHsR60QnjfBiYJE22bVBL8CnW4haHsA48QIeEBhb10Sax7Vw4+3OC7l+
 N87MO+YHCs2PdeCqMySF/c0i9Ve7i3b8MDs5M5dn2uLthnvj3mq9+dFErs+bbOBeS2IY
 kgU5RJ7POJsUmExsMDHeIZZqYBkVjcErnwGRCUuoVx7ar3NqZgaYcgDP/Ndq0eURY720
 ZBNQaztu9+xH7SadENvrHZVlDWqFs2OsZf6TvoS4KSYp3czsudSVkYCH6MH+o5DnSJUj
 q8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784301452; x=1784906252;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=U5wBdDF7DRG28bcaQ5mcF0VBa31VkkZz2BrG2N7QsOE=;
 b=r9NY2/zmOlky/kPuLD9qOiiImniVo1Qoef6cJ5xW4neCPLxz/W4tGWEg6A+tixf45c
 +83aHboU8Vee3btPYii/sngNkKw3DSphDG1TLYVQfAzinRfv5UWjrnV5PVlEwHde3UCi
 bFWL/zG4flgkyQ7nMz6q78HFowPuHKI7SMw/K83qOHEBIoI6jZbIAPqEOMQPpN3TSDZS
 c4/OFHwWbJzLS7F+/5su9Vkg2sA+r9saZXC1WbbuUwbWQPWwieWUbw++QUPxQB8jSFA4
 mgtz7BZmsuZOp9Z3lIV4hT+qmKSRXbZPUL1H5LTKyibuPtp9iaKYDT0KfCi3KCSvYTKo
 Tr+Q==
X-Gm-Message-State: AOJu0YwxTvOvQ0KR1f16jx3EmVPqucQKSiKkCBnmGSaurpygkyXTRqQG
 7WSj3eMfXIB0Z2Iifd7FA1R9ROdZ+WkPaLm2hcj387p3Vv4XDWKY1av6rh4HnCRdIKlCJal5OK6
 PabGdG2TuA2Jur0Iz8+O+XbAy5z5kAJsY+8WCOkEfdmFJg+mjXHDkDChBjfCz80pI3Loo
X-Gm-Gg: AfdE7cm4PGee87W3JTUNsLCE2BdRmDP0VaTBdJRXqgF0F+q72VvyIMFExF3nqIW3Ebs
 j0kjUE9I7QjNszByeDu3Kn8jJZqcqVLyoF3GTRNW0VdYFG0xNSPzPDYdlKyoQ1t/oCrU7ISPdSR
 OL0gaUlBgIZFo0Ecy465EE/0xxasrvw34h+C5ibXkojfWDQmrvzxaS8cZnib5gvpbie09HWffef
 6D2y699Ic8DdxkHV4bLsHXCgAjczB6WQcdxBMRlzDVAa5m1RoLvy5zmELzwGRHGwCXzobjXka+I
 h2sU92BwsFmn20V3By59SYiNbEJQmhNO/ynR7MM/wC3ydAnkff1XQwd+nJP4iCMc+acqon8yQz8
 C0Lfv0k33lMxE2lOZ1RzSTFtYl7gpaQpjaAZrvGaVyJ10YDNrGcgqPRlA9WlW9+G7PbcSffpo9F
 FqimPrNFcLOe5MmjJ88t7Y8qTSOAEmXuM2RWzM6/LRYmpaKWXuYLH2X1lbyl1Qv2v6hPNFyIpws
 yx8n2+VWOaShdqUPhP9/ckbvMDd4UYZ/kJWQWfF/AAjoyIJrWQaRqWo7H3fTwfIW3kT
X-Received: by 2002:a05:600c:548f:b0:495:4d00:2fc0 with SMTP id
 5b1f17b1804b1-4954d003084mr20135655e9.12.1784301452198; 
 Fri, 17 Jul 2026 08:17:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549a3f07esm55862515e9.6.2026.07.17.08.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 08:17:31 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 17 Jul 2026 15:17:30 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
X-Gerrit-Change-Number: 1573
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1573?usp=email>
X-Gerrit-Commit: 93d8efc4aa02009f633bfaa8ed0622d7eb8d0da2
X-Gerrit-Comment-Date: Fri, 17 Jul 2026 15:17:30 +0000
In-Reply-To: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
References: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjU1MDY2MDAwLkk4MDdmMzk4OTAzYWMyMDQ3NTMwODAwYzI5OTQ5NzkzYzZmNGYwZWM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <75b4ed98d830201df8b3ac42e1e5bde85db0a560-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkkJr-0007GX-UL
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Replace custom
 hash_func with siphash
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0643444707907385042=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0643444707907385042==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="g3EEpfFuU08="; charset=UTF-8

--g3EEpfFuU08=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1573?usp=3Demail )

Change subject: Replace custom hash_func with=
 siphash
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 7: Code-Review-1

(1 comment)

File src/openvpn/siphash=2Ec:

http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573/comment/a08f0ca3_761a4efa?usp=3Dem=
ail :
PS7, Line 46:     if (siphash_cryptolib_available(ctx))
Isn't this th=
e wrong way around? siphash_cryptolib_available needs siphash_cryptolib_ini=
t in case of OpenSSL



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1573?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I807f398903ac2047530800c29949793c6f4f0ec9
Gerrit-Change-Number: 1573
Gerr=
it-PatchSet: 7
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 17 Jul 2026 15:17:30 +0000=

Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--g3EEpfFuU08=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 7:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1573?usp=3Demail">View Change</a></p><p>1 comment:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/siphash=2Ec:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/157=
3/comment/a08f0ca3_761a4efa?usp=3Demail">Patch Set #7, Line 46:</a> <code s=
tyle=3D"font-family:monospace,monospace">    if (siphash_cryptolib_availabl=
e(ctx))</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Isn&#39;t this the wrong way around? siphash_cryptolib_a=
vailable needs siphash_cryptolib_init in case of OpenSSL</p></li></ul></li>=
</ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1573?usp=3Demail">change 1573</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1573?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comme=
nt </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9 </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 1573 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerr=
it-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Comment-Date: Fri, 17 Jul 2026 15:17:30 +0000 =
</div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div sty=
le=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--g3EEpfFuU08=--


--===============0643444707907385042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0643444707907385042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0643444707907385042==--

