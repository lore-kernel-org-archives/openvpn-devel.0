Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380CA606A31D
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZeK5Ek4j;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DSkbcNOq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eWej71LN;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=eBWunFjc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=IHCIdB0yYLKvuZYAr8pk6vTHGUHShNDkXxNWPJ+AKxw=; b=ZeK5Ek4j31tEaC7wqL+Xm3KsX2
	q2rBQnOMRfqFPICo93Jc/FLYR4vfkQqXE0YJ/6tZEeNrkorjYfes+G/9y5HsDtkLqfznH5gWDyDU7
	4D6F5tgipjB92ZZUqHEAwvGJpXTFNFl0aS/dsWAENdBons7P+5KnQY/S9pTwRERSDm4A=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLLWQ-000000002PV-0UGs;
	Mon, 26 Oct 2026 14:17:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLLWO-000000002PJ-48j0
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 14:17:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JmlXv5pUnXMfJ4STLciJIX2VCKaEGtJXnqEs016gLrg=; b=DSkbcNOqHdPKg/nt67bSqhOIgD
 4T3gjGtNfxl4d6i0lZZ0R/1OYXfEBJOlgmOzvjYb7sP0ZpXmMX8KW+uTT+WKlM1qCITJjRq/Y2/FK
 0q8mGovM7Bj1XctlTFJtsL3emH5YXKcMhALDD8kN2uE+gJvnf11twlcM7Lt3FVCQg5hs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JmlXv5pUnXMfJ4STLciJIX2VCKaEGtJXnqEs016gLrg=; b=eWej71LNjso2Jodpp8feqY2UyR
 rbwMOoPN4T3zQfw9aoTLZGzJvxNiyJHIjjtoJAusN78vwk/QdsN2hJplWRMVRax3WNJjQukXwDQLP
 qkBxtGPo3Tcx0g3v7QhG3avM1EN4cGwXPqMWVMC494m86q/zD6VO/bkPxS3yL45OzE7U=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLLWN-000000001xM-1CXI for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 14:17:56 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so22382655e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 07:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793024269; x=1793629069; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JmlXv5pUnXMfJ4STLciJIX2VCKaEGtJXnqEs016gLrg=;
 b=eBWunFjcuAHziI4LKtgIjQ8/Xjl7wuUZvTwuC3e3QatoTLCgNdE+qBjWRq/dVTnf2K
 jeDOM0jsynS0MASqcui0+Jb9tDxxeWGjLTK+L8Y3yomMs9RWGQbhCan8+/yQrEp0H5Um
 4IOZ/SgrbXKMjyhvnGZoZyIPtwTgEIA52AbczvyzV7AA+x7jLtG/iqYUsqoG7C/LpY0M
 twbFbPqW8EiDye9BtirlJz6gBym5km+6SVIQc4WLFMn8m68EN1G7g8afjFjXKHzhYv9x
 kYuHF5LSeFhItH03wnzANO1ARwjqhtAu7hzW0KRNMrLo3o3u+ma/e7gju0DULg/E+uAo
 zIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793024269; x=1793629069;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JmlXv5pUnXMfJ4STLciJIX2VCKaEGtJXnqEs016gLrg=;
 b=uK3R+zSJIRh6sf7clfVOaX7bSDQZouxUxDvezoI4sA7ZAyJHJ5uGB7duEJY6xqzM0h
 ViOr/3u4hj4CT1v2ZEahoDRdhvynymRLHyI8UVrzpdNtUMqIaZ4pg3DqvRRnjP4rDhpP
 C3jp0RemlEdMvSClAEVXMvRgyIwiKLpn5bylFKS0WsoYQVCp/t2RNuV8ESzsblZVSG8o
 +fQox/gqnSuHrV7k+TiCRjAqzZsdEYfk9QRTIu6XX/9ibJnCaD9xA+wBJfyL0zCMfLEN
 5FurAcipkWLxIzI3S2DY575q4SZEO5Xig8MFtGCCSE6NmJbqxGgvbWxCjMN+sLDm1OxS
 yhIA==
X-Gm-Message-State: AFq9FYI2KImAK+0vaQY/yLDys1e72McEAPuX0t7GVxlXO8ZWUQ+igJMf
 eWn65UTzqqUVcpi5FBgPfzuYDvsYzhZIkrNEPhE94T5vIsTSzg3ZbHir1wGnKBcLVzow7wXVUGM
 k/ztZM4bF2ncScJxy6uBdVfmNe1aKIQ24R3wGnJcIVR23X9v56LJ9V0L3rMMfQsYPTTXR
X-Gm-Gg: AYBFou32s4qWzAfMqQvl9+v3Sh/Xsu5e7T+uMWjfF/+hV1H53eEUgGACUdhqFt+ilbU
 +DhH5YyL+C+39aVu460Ia/cvB+Hguv+91k6bI9bBqYT7TewhKKPSaowv4eX5vW2xDris5K7iTFn
 Q8gosB8Jy+G0APVifh+whSPzWaFwSjEwtMqy1Jgs6shBpG9lc6NMS+BcafspSB8r7BvhbcRxVm4
 YZIh237q/G9/7ErSeo1vLkfxun5roKzuTXVnCegBWVwWgyNnJoqyA4o0YIa2DTNJFkIOFb+mgc7
 4akGLs9LQxEeiyVkvmJGrtL6aYWV1mFr92pF2kXEFwbLkB5LwTQLrXTOZkdlDZuq4p638Mh3Qfi
 j20hsDOL//4pgrS2Gl/26aeuBSWE80h0eOGzg2UHni5Yooe1yNvsWMnDUKXnN5PBegN6jrFG2zr
 3PC0aHPIEV10ISxxfsY6dhcZfz/oQky85szgSzsXU7AHXkjd0Ob4y/D3+oc+lrLMe+0MAfR0oua
 Wjuzz4pGQVyzzxAV9ZotaTYZUSGu/nyHJ0DUqPbP/b0+sI9bAJq+La6CksC6edW26q3E/QrwFDy
 /6cBJlLYwJWSB3WjdgdSLmo7h8dVtAnRfqUyTPdL3XzsYyeloCevr3GCdxaEcEr+G/Y9Koh202W
 euXlu84UWFG0DmoJNe9T+dY8bpeBLd7DvuIWSQhU0AuF9XSmDlpYKAKIm1Ox1c1dr
X-Received: by 2002:a05:600c:3e10:b0:4a1:9661:14b5 with SMTP id
 5b1f17b1804b1-4a35acba868mr114167865e9.29.1793024268530; 
 Mon, 26 Oct 2026 07:17:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecdd5b3sm16625219f8f.53.2026.10.26.07.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 07:17:47 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 14:17:46 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Id206b12bd67c0b8a014a2c62277b43b18debfd43
X-Gerrit-Change-Number: 2033
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2033?usp=email>
X-Gerrit-Commit: 54a66f355ace8e89b25ed9e85c659d290eb700d2
In-Reply-To: <gerrit.1793012308000.Id206b12bd67c0b8a014a2c62277b43b18debfd43@gerrit.openvpn.net>
References: <gerrit.1793012308000.Id206b12bd67c0b8a014a2c62277b43b18debfd43@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDEyMzA4MDAwLklkMjA2YjEyYmQ2N2MwYjhhMDE0YTJjNjIyNzdiNDNiMThkZWJmZDQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <130a6fd160631b018e0acc70bcd82a44587e9b59-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLLWN-000000001xM-1CXI
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: run-cppcheck.sh:
 Make CPPCHECK_CHECK_LEVEL=normal the default
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3602125047988219022=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3602125047988219022==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9wyKU4I3eBg="; charset=UTF-8

--9wyKU4I3eBg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
033?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by Arne Schwabe, Code-Review+2 by R=C4=83zvan Cojocaru


Chang=
e subject: run-cppcheck=2Esh: Make CPPCHECK_CHECK_LEVEL=3Dnormal the defaul=
t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

run-cppche=
ck=2Esh: Make CPPCHECK_CHECK_LEVEL=3Dnormal the default

exhaustive is gene=
rally not usable since it runs for hours=2E
So avoid confusion by choosing =
a sane default=2E

Change-Id: Id206b12bd67c0b8a014a2c62277b43b18debfd43
Sig=
ned-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Co=
jocaru <razvanc@mailbox=2Eorg>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2033
Message=
-Id: <20261026120859=2E76788-1-frank@lichtenheld=2Ecom>
URL: https://www=2E=
mail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40139=2Ehtml
=
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M dev-tools/run-c=
ppcheck=2Esh
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/33/2033/3

diff --git =
a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh
index a9c4643=
=2E=2E07c0a6f 100755
--- a/dev-tools/run-cppcheck=2Esh
+++ b/dev-tools/run-=
cppcheck=2Esh
@@ -3,7 +3,7 @@
 set -eu
 
 : ${CPPCHECK_VERBOSE:=3Dfalse}
-:=
 ${CPPCHECK_CHECK_LEVEL:=3Dexhaustive}
+: ${CPPCHECK_CHECK_LEVEL:=3Dnormal}=

 
 if "${CPPCHECK_VERBOSE}"; then
     verbosity_arg=3D"-v"

-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2033?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: Id206b12bd67c0b8a014a2c62277b=
43b18debfd43
Gerrit-Change-Number: 2033
Gerrit-PatchSet: 3
Gerrit-Owner: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>

--9wyKU4I3eBg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2033?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by Arne Schwabe, Code-Review+2 by R=C4=
=83zvan Cojocaru</p><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">run-cppcheck=2Esh: Make CPPCHECK_CHECK_LE=
VEL=3Dnormal the default<br><br>exhaustive is generally not usable since it=
 runs for hours=2E<br>So avoid confusion by choosing a sane default=2E<br><=
br>Change-Id: Id206b12bd67c0b8a014a2c62277b43b18debfd43<br>Signed-off-by: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojoca=
ru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2033<br>Message-Id: &lt;20261026120859=2E76788-1-frank@lichtenheld=2Ecom&=
gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg40139=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M dev-tools/run-cppcheck=2Esh<br>1 file changed, =
1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/33/2033/3</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh</span><br><spa=
n>index a9c4643=2E=2E07c0a6f 100755</span><br><span>--- a/dev-tools/run-cpp=
check=2Esh</span><br><span>+++ b/dev-tools/run-cppcheck=2Esh</span><br><spa=
n>@@ -3,7 +3,7 @@</span><br><span> set -eu</span><br><span> </span><br><spa=
n> : ${CPPCHECK_VERBOSE:=3Dfalse}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-: ${CPPCHECK_CHECK_LEVEL:=3Dexhaustive}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+: ${CPPCHECK_CHECK_LEVEL:=3Dnormal}</span=
><br><span> </span><br><span> if &quot;${CPPCHECK_VERBOSE}&quot;; then</spa=
n><br><span>     verbosity_arg=3D&quot;-v&quot;</span><br></pre><p>To view,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2033?usp=3Dema=
il">change 2033</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2033?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: Id206b12bd67c0b8a014a2c62277b43b18debfd43 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2033 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</=
body></html>
--9wyKU4I3eBg=--


--===============3602125047988219022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3602125047988219022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3602125047988219022==--

