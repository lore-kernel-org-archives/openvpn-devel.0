Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5BA606A31F
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Qw80yUly;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EuC2rmeS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PZ0ua+mH;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dpbNoJkz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=nHCaYxbwKXdPCGiyMxOUjR70Cww/ykz0VQgpmnFQ8w4=; b=Qw80yUlyE1ihkvviEddk5gXLTE
	+2BzGsTpydqVqP5o8yPiZrLibC4CG/h3wvqalwn7RVVUGRnc4oW193UPb3kI0NPAt06TkDO3EmA/i
	vX8CRboLAEqHtsOZTPNnu1+Zff9zHFXFFGll1/xI9Pf7+WkdXItjSZCpVIqS5LaTb87A=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLLUo-000000006FS-3FjS;
	Mon, 26 Oct 2026 14:16:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLLUl-000000006FJ-3Qk0
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 14:16:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7RpOnxoM6O+EgHbNlsOlbqKvcdDFtGzJEn5N7z9L82U=; b=EuC2rmeSQckMGikv0qzh9n20cu
 9HmHR+BPbSojtajJHzbiUL+fS0qPo7ywL8ECT9H/x6mCbiBtq0TseF2lDvEUfZM0RHUBX7n6HPdYu
 Wl1D3Dug1dZ0jJErYGLojgVbrOdlL73OINZrQ2zAaYl+ExTzTuHsel+HpmGCyzYQDjyA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7RpOnxoM6O+EgHbNlsOlbqKvcdDFtGzJEn5N7z9L82U=; b=PZ0ua+mHTiOC0JEM1jlxe5/eok
 uxFr7gkwsGC//3csR9h/qKA6ocfhMva7l5ULkZoKimE/2GXPRCMxoYa0NkYxF7iue8HXcAKwybMoU
 kubo3edjHo2kbV0yp5t3B7RbD2FkLlsJlodCVyk8U7Z1d29eecZ5x75HbS36QIcTmCso=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLLUk-000000001t1-12ar for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 14:16:15 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4956869750eso20219435e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 07:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793024168; x=1793628968; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7RpOnxoM6O+EgHbNlsOlbqKvcdDFtGzJEn5N7z9L82U=;
 b=dpbNoJkzQhG/qus8wBKFcsCTH+zMOoIaB+j3gkj5NsvKhPtg4F86UrI0G8CJ9LkUtW
 2w59DZQAH3Yxn/YzCng02C84KO3IEBrJvz5fDg+kmcfzur16kSXuS7Ww7o6N2dvggY0D
 1gIwMVPl2fLUVFrWhfMueKLU0ofVy3zqSonLV58BzbzX+hCaNB1CGRI1Q6Jppafe7Mvn
 DUCGktvecbI6F4yBCQ+EG62TewCpHnCZbl+VQH2M99pnqCA1EhPgLSCOEd8joNpW8u0z
 /mcK+aCE6w0NByqW6EOqckRe6SIuE57uSId3XEq+AWBorESgdHYE7q+1erITVSVF57Uj
 ifZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793024168; x=1793628968;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7RpOnxoM6O+EgHbNlsOlbqKvcdDFtGzJEn5N7z9L82U=;
 b=TZxdz0xRk/9habXwJt9Wh3u09cn3WnLKXdqV+p7sCRzJGDMUarmNtAL8j5pcaY64+2
 7KdNxQUeuURptm1mV9fkYpUGUHTZBNrkY8JnPqqOiYRqLbsW3Osmcm3EVx1C6KTE9stR
 lR9jJ0vI7wMAA4dXn8yiIKGhyPn5wX/EDGrLqUuOk/FI6EtKWwH+MCOjNTpxDrRbytxU
 Ae29hP/CvdYAJTS1jQvuNZv6ylg9VWGjL1E1W2YtQfBYpqMd2qqVj8Ec+/gSl9w0TeCJ
 53UGA3YVYW0FggAD3eEXMzmOuPgQ+fAW3F7APoKnudIw8LHkN+Jcm6YP1JdH6o22b8s0
 KPNg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxezDPiCAzNg0X7WBl/tuJzKs4iLRA9wEqNqXko7CWY5AM9f1eHuRtMU1IE85lma2+jcSr2Tn4vB8f0t8ks@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLgYBJVFGi849q/SkJ2XFF0Ai30E7N80gAHOFcHbBbButgKqYoi
 OEajtpJEdw0MtSdCu0JFg/1M4ZFck/h9AGSJdxA5c8Z0RRnbwh54mua9X6oyw50KK5kUZVmLYRe
 VGzDYh1wEY426v+e3tCnLJqwyfOhTcy7+2TeqIwgZAZ/mVJK5cuccg4n5rypHS/gAuTh+
X-Gm-Gg: AYBFou0Sf0BMqWaxKOApF7h4tdBwpOp2uqkGwKlc8+/7w8aEJskb5sKnyhWnvJexNfH
 ThS07zIIq/u3d9iytQJrtr1vIEYpWMuFbsCj0OvimP4n6cs3o/qe6BF6K17a3P9mVpqVHASu7dQ
 vt5LaSnrGsEDN3Wdxg0JZfAgOUftln/+cwqpslWDeInRo+yGJrXo5UR4xHa5kfNHSqOteHKWaaB
 YHQ6x/lP7JyP/7g7816AfBFdS/MhKdk4HBLSGsQfXPl2/OCpiK5KSdqn0php7EgYI21iPCjTqZS
 4ksg/PIf1CprNufmnn7e6R1MqCPjjSaCG2jw44nynGCq0VqjT0UHkQlIKxtII4GJRU4c4Z2I4X/
 HZiSM5v8jFApxORsN3eV0uFhQDzQ9U6HDuTcpMdfg+O+eaIt1/mo4mA0v1CaFZ9tGmWYa+vnHrE
 11vq6VIn1NDeOZUFf7yTuYi50fspEsLmlSQ3xrEpq/EnDQ6bUltswNPFYr0mi/hLrJo8td1SZhS
 frBXZeMDQ1LIs9Dxfif4jUO6/B3tWIvtoiiEjyrRMxMoScR8ZeswN7PJp2ZnU0x9fdiFfs+021r
 40l5i2wYvXs/YxOUU+UGnUBR8igRjPnJK3NGZCCJp0iGQN+ivExZFO+e+LlW3pNfGiPp2CuX33V
 BGdHd6bxc7pltU5m+66drKemplCTE3AMSZ+bwncYyYg==
X-Received: by 2002:a05:600c:3b22:b0:49c:fa20:cbfd with SMTP id
 5b1f17b1804b1-4a35ac9f145mr129550935e9.20.1793024163036; 
 Mon, 26 Oct 2026 07:16:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd354asm15878869f8f.43.2026.10.26.07.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 07:16:02 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 14:16:02 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I136d57b7487f228e37894fa710b1ccc2c4606eb5
X-Gerrit-Change-Number: 2031
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2031?usp=email>
X-Gerrit-Commit: 766320d69bc402e700fe4d014d3738ec8a9441da
In-Reply-To: <gerrit.1792963979000.I136d57b7487f228e37894fa710b1ccc2c4606eb5@gerrit.openvpn.net>
References: <gerrit.1792963979000.I136d57b7487f228e37894fa710b1ccc2c4606eb5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyOTYzOTc5MDAwLkkxMzZkNTdiNzQ4N2YyMjhlMzc4OTRmYTcxMGIxY2NjMmM0NjA2ZWI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e06c4c79954c64693db2efd37db1a642da469e6e-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLLUk-000000001t1-12ar
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6207339912370200815=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6207339912370200815==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aMfZmrbv79c="; charset=UTF-8

--aMfZmrbv79c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2031?usp=3Demail )

Change subject: Fix typo of nprocs instead =
of nproc in run-cppcheck=2Esh
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Fix typo of nprocs instead of nproc in run-cppcheck=2Esh

=
Commit ccd058e75 accidentally used nprocs instead nproc, making the
script =
fail on Linux=2E

Change-Id: I136d57b7487f228e37894fa710b1ccc2c4606eb5
Sign=
ed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Antonio Quartulli <a=
ntonio@mandelbit=2Ecom>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2031
Message-Id: =
<20261026110205=2E55077-1-frank@lichtenheld=2Ecom>
URL: https://www=2Email-=
archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40134=2Ehtml
Signe=
d-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M dev-tools/run-cppche=
ck=2Esh
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/dev-=
tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh
index 58609b2=2E=2Ea9=
c4643 100755
--- a/dev-tools/run-cppcheck=2Esh
+++ b/dev-tools/run-cppcheck=
=2Esh
@@ -22,7 +22,7 @@
     num_procs=3D$(sysctl -n hw=2Encpu)
 else
     =
SCRIPT_DIR=3D$(dirname $(readlink -e "${BASH_SOURCE[0]}"))
-    num_procs=
=3D$(nprocs)
+    num_procs=3D$(nproc)
 fi
 : ${SOURCE_DIR:=3D$SCRIPT_DIR/=
=2E=2E}
 : ${BUILD_DIR:=3D$PWD}

-- 
To view, visit https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2031?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I136d57b7487f228e37894fa710b1ccc2c4606eb5
Gerrit-Change-Number:=
 2031
Gerrit-PatchSet: 2
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit=
-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>

--aMfZmrbv79c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2031?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Fix typo of nprocs instead of npro=
c in run-cppcheck=2Esh<br><br>Commit ccd058e75 accidentally used nprocs ins=
tead nproc, making the<br>script fail on Linux=2E<br><br>Change-Id: I136d57=
b7487f228e37894fa710b1ccc2c4606eb5<br>Signed-off-by: Arne Schwabe &lt;arne@=
rfc2549=2Eorg&gt;<br>Acked-by: Antonio Quartulli &lt;antonio@mandelbit=2Eco=
m&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Ger=
rit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2031<br>Message-Id: &lt=
;20261026110205=2E55077-1-frank@lichtenheld=2Ecom&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40134=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M dev-tools/run-cppcheck=2Esh<br>1 file changed, 1 insertion(+), 1 deletio=
n(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/dev-tools/run-cppcheck=2Esh b/dev-tools/=
run-cppcheck=2Esh</span><br><span>index 58609b2=2E=2Ea9c4643 100755</span><=
br><span>--- a/dev-tools/run-cppcheck=2Esh</span><br><span>+++ b/dev-tools/=
run-cppcheck=2Esh</span><br><span>@@ -22,7 +22,7 @@</span><br><span>     nu=
m_procs=3D$(sysctl -n hw=2Encpu)</span><br><span> else</span><br><span>    =
 SCRIPT_DIR=3D$(dirname $(readlink -e &quot;${BASH_SOURCE[0]}&quot;))</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    num_procs=3D$(nprocs)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    num_procs=3D$(npr=
oc)</span><br><span> fi</span><br><span> : ${SOURCE_DIR:=3D$SCRIPT_DIR/=2E=
=2E}</span><br><span> : ${BUILD_DIR:=3D$PWD}</span><br></pre><p>To view, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2031?usp=3Demail"=
>change 2031</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
31?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: I136d57b7487f228e37894fa710b1ccc2c4606eb5 </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 2031 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></ht=
ml>
--aMfZmrbv79c=--


--===============6207339912370200815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6207339912370200815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6207339912370200815==--

