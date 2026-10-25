Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DE5606A328
	for <openvpn-devel@archiver.kernel.org>; Sun, 25 Oct 2026 21:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cYdG6LRH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=P1WmAS0k;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JCUi70WR;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=BtNvBDk6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=AcfqeM1GZaDxjeDAXjc+OnbULgznhO6gIqLDxAUgrjs=; b=cYdG6LRHX+cPaMgaSvBFnoD+jR
	AZnqOcf7yYOgaQF1gepQJ4TOOr7kFs7j3NjGKMqc8IwXuX7eTM/FvP5AAadzMh0ykIO0ArP4iikyo
	alL5vyZnBC4QMk6fF9ZEXru+CiTT8fzLIyRnAJiob3mmlA2osaO4lSspea+vIttFeaSg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xL5q5-0000000070I-3iEK;
	Sun, 25 Oct 2026 21:33:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xL5q4-00000000704-2id0
 for openvpn-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 21:33:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dtJGySqhvSdehfDa7pQeQANHhCR/u+gxq7O/McG8/tM=; b=P1WmAS0kSj+VmCx1qC+XUxxBsa
 0lRVYmhbxOl126x0bWhLWRM6iqj4Fua3k4uahCY4CnX4dO7nGM46dVrYr6zWDZQJfmDvPZTXHdcNP
 e0COeD/djfY3Ren0NOoJcfRPTxBIurqCeviA91qcpGr+jFiPXOFCMbYEnRiQHDv///Q4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dtJGySqhvSdehfDa7pQeQANHhCR/u+gxq7O/McG8/tM=; b=JCUi70WRKk1VgTiNK9AOvGGzM8
 kwbGednwHAs6CaZJ6h84Hf/VKVOJgG5H6BgIL1pp461JVlmp/55YAzfVQFvYLI0hzNkCxlQJYbbx5
 5aL1/DxGEom/o+d0kSMGpm0AAdy4r3IG7va3Eo25oUL0qTIAT+3preyt2MyvoJ7zv0mM=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xL5q3-0000000032m-2eDz for openvpn-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 21:33:12 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso8868835e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 25 Oct 2026 14:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792963985; x=1793568785; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dtJGySqhvSdehfDa7pQeQANHhCR/u+gxq7O/McG8/tM=;
 b=BtNvBDk6n8Ym1TupeTon/FcLr7Zg3LEyPakpyIhDTFLl2ykywmkZPpDGNqwOoNV1Jv
 t9q+E1agxumxNYinjsrSN0JNjr//9g6twJsS5JNVeQGVuInItC4T9J4gfxm0Gq/VZw66
 QC9ZQH9q8u9Y1/iinQefVBSO8E/vbXpFYgrvbeKFw+63mhkbnE5eeFw4K04Vn649imTY
 naffM1XivFIFSEG3TxI+IrBkD3uVDoqjpxEvO1Fk/ZiLEtvFkIi4QiGv/VM8KA3FefXa
 Oc1bHb6k3bYvmmLxCN5ptauxdAjmWOHunR6Sk4hWkczoaMkNiXQY2qB3jnK2jwlYu8rj
 Yrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792963985; x=1793568785;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dtJGySqhvSdehfDa7pQeQANHhCR/u+gxq7O/McG8/tM=;
 b=AktrxkC05oXQR2IPPAXcqZYMQmoTa0r0i5QiMOKDaWeKoaXOmA5hqLinZ042Zas/ED
 /uTi/bogrQXPANz6ioCNbcVzbIpdhaWAC1dlyisbFBb/SMZlYuCQx6gLydw3+k89lZst
 ax4pUJeNhPdt3VwMmXb2QCdaZmddAUXkl2iKuEC3wN08zHHoM9/2GngEdLBcOAKs3oOL
 DMC8DyYhHGHm/t8HNEtd9XR4bhXxetFDhl4AwCcUEWKbgSViQiP3n9/FIkKeUnPXyYxW
 n3aiC0pxyelr+XV+hMW58e53VSEouFXGX1sHUNebIHRGyurNCoeKF0UrRMTA3tafiS9i
 yL6A==
X-Gm-Message-State: AFq9FYK7xY0dK9mTJOqx5jeJgZNQlY+LJ5lqk/6iAkXK9RufpOCP8910
 gz0DD7F9PmGoitGJxA5qYef0ULclu1kNwb4ANkY8Bu47u/GU3SfbLcxM1HYMKwcwAlb6Ni0Y/Hk
 J285xJ1DUuk7C+KNP9JmrC78NDO2VlsRrMhiuCLzSi1GumIRlG9yWzqI7BL9Xn6qvbA6kjhw7tL
 7PlEtW1w==
X-Gm-Gg: AYBFou0sYYNQXQkts8BFskj+lOVi01XCx7UE8Wtqb6DZW5fMGGOH0sAyZAiATdV63cL
 MRQDSQHbFbfMpboe9NaGKs0jPBmzP3veQro0Ip+fDzogUGV3fZML+7SltaFsnGZMbA8ip0t51bQ
 DsAhRGT5Z4ma59EBosWzdCOc/fWOOgFSjPAflkH40HrrvvcZe1IJrRzNpDH30xFNA331DJB9/Rm
 gTRYaTnHPsMcmFNI6HOEfxdDoWbw1CajOcbTz2AT2Nc8ozA9iTWqn7WqluwhojuUid0xvjeBuu4
 7lmLDDhx60NTjo3LXJz4Sx+IIkPFUIvQy+jBb+nY0RZSXZtNT7gkgzWtNS0M3bDdp3NGdzPeZQC
 93Z0s1jMCIHHY5Ckw3G3kztMPwcjWIxpk648XGIbIgcvtHdQZOiKo57gcsoLB6IZ5t1pjifBa9l
 IUUQFBi298VbL1DMQj7DwhzA9kYFNUM42/KiYLs+PBHy5olN/TzmV3706MtsihhMlTpInJTpV4Q
 lUMkxZl1i4hEug3x30x5lS0oBpqw4V4U8MEteffzA00jeU9GDx3kO2+adSiCnF8PVMr3CmyL5Aj
 O1slaiQzGniAWwvXhI7uHvCeFqOZntZSp/FB41l3Wj65gmsPjRxVJvOds0ZKag4eynVgCBYkfIe
 apxZ50YmBf0xKzLRHt3xqfOImRMlI23k/ZHDgtgG/TQQ=
X-Received: by 2002:a05:600c:4e4b:b0:4a2:e0c:2b0a with SMTP id
 5b1f17b1804b1-4a35aca5bd3mr80987885e9.16.1792963984855; 
 Sun, 25 Oct 2026 14:33:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a08dcbfsm98612655e9.2.2026.10.25.14.33.03
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 14:33:03 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 25 Oct 2026 21:33:03 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I136d57b7487f228e37894fa710b1ccc2c4606eb5
X-Gerrit-Change-Number: 2031
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2031?usp=email>
X-Gerrit-Commit: add6d94d1fc4685974f158c6e4ac7e32ed8620eb
References: <gerrit.1792963979000.I136d57b7487f228e37894fa710b1ccc2c4606eb5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyOTYzOTc5MDAwLkkxMzZkNTdiNzQ4N2YyMjhlMzc4OTRmYTcxMGIxY2NjMmM0NjA2ZWI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fb38e77a3a69dfeaf471ca4108a20a66a39ffcd3-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xL5q3-0000000032m-2eDz
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix typo of nprocs
 instead of nproc in run-cppcheck.sh
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1329148202552874479=="
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MISSING_HEADERS,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1329148202552874479==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LOxwc0dX8qo="; charset=UTF-8

--LOxwc0dX8qo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded this change for review=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2031?usp=3Demail )


Change subject: Fix typo of npro=
cs instead of nproc in run-cppcheck=2Esh
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

Fix typo of nprocs instead of nproc in run-cpp=
check=2Esh

Commit ccd058e75 accidentally used nprocs instead nproc, making=
 the
script fail on Linux=2E

Change-Id: I136d57b7487f228e37894fa710b1ccc2c=
4606eb5
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M dev-tools/ru=
n-cppcheck=2Esh
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/31/2031/1

diff --=
git a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh
index 58609=
b2=2E=2Ea9c4643 100755
--- a/dev-tools/run-cppcheck=2Esh
+++ b/dev-tools/ru=
n-cppcheck=2Esh
@@ -22,7 +22,7 @@
     num_procs=3D$(sysctl -n hw=2Encpu)
 =
else
     SCRIPT_DIR=3D$(dirname $(readlink -e "${BASH_SOURCE[0]}"))
-    n=
um_procs=3D$(nprocs)
+    num_procs=3D$(nproc)
 fi
 : ${SOURCE_DIR:=3D$SCRI=
PT_DIR/=2E=2E}
 : ${BUILD_DIR:=3D$PWD}

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2031?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: I136d57b7487f228e37894fa710b1ccc2c4606eb5
Gerrit-Ch=
ange-Number: 2031
Gerrit-PatchSet: 1
Gerrit-Owner: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>

--LOxwc0dX8qo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe has =
uploaded this change for <strong>review</strong>=2E</p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2031?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Fix typo of nprocs instead of nproc in run-cppcheck=2Esh<br><b=
r>Commit ccd058e75 accidentally used nprocs instead nproc, making the<br>sc=
ript fail on Linux=2E<br><br>Change-Id: I136d57b7487f228e37894fa710b1ccc2c4=
606eb5<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>=
M dev-tools/run-cppcheck=2Esh<br>1 file changed, 1 insertion(+), 1 deletion=
(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/31/2031/1</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/dev-tools/run-cppcheck=
=2Esh b/dev-tools/run-cppcheck=2Esh</span><br><span>index 58609b2=2E=2Ea9c4=
643 100755</span><br><span>--- a/dev-tools/run-cppcheck=2Esh</span><br><spa=
n>+++ b/dev-tools/run-cppcheck=2Esh</span><br><span>@@ -22,7 +22,7 @@</span=
><br><span>     num_procs=3D$(sysctl -n hw=2Encpu)</span><br><span> else</s=
pan><br><span>     SCRIPT_DIR=3D$(dirname $(readlink -e &quot;${BASH_SOURCE=
[0]}&quot;))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    num_p=
rocs=3D$(nprocs)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 num_procs=3D$(nproc)</span><br><span> fi</span><br><span> : ${SOURCE_DIR:=
=3D$SCRIPT_DIR/=2E=2E}</span><br><span> : ${BUILD_DIR:=3D$PWD}</span><br></=
pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2031?usp=3Demail">change 2031</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2031?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: I136d57b7487f228e37894fa710b1ccc2c4606eb5 <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 2031 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none=
"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--LOxwc0dX8qo=--


--===============1329148202552874479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1329148202552874479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1329148202552874479==--

