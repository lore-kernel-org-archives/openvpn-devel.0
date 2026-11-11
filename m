Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8753E606A324
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GUHYOKFc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=eLaJD/et;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HhsmbIXJ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JonlZi2U
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JHbgwpiCwsPJSuOFqixH68o80cnUW01Yc1QO0ysJKMU=; b=GUHYOKFcZ3mrKahJ3B62JvlqIj
	5m0tA04qPeXwky95kKuBTWDxPdaUN4kEwwU51BJxXtrgCQuU1qLFeb9ZhJ3An4fr+XjsUnmpyZFby
	GZXsEpNTTQCG3r8WZi+Ls3tI0dHAeFM34mg2wxTkt6STaldd5x18PODyGcgoPxs0wT6Y=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRBv6-000000005f9-2aAH;
	Wed, 11 Nov 2026 17:15:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRBv4-000000005f2-1jCK
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 17:15:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HbN1I3OFe86GfNvpfI75tHqvNLPDzDrNp0Da6kQvnaA=; b=eLaJD/etQIarkT16Ktx/M6RKcP
 pBR015L9pFcvdps+ws4l9EoKfQUWoABUSgEgYNnSy+6G6P1TqhqiPtXHkbnSRRri8okgRf4BLPJGU
 63qRq1gyjZhuO7lX8oiOn8qiz3chG0E9YaAdapWeOpYOUDhgd0loorwQQtzsW6e1tYx0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HbN1I3OFe86GfNvpfI75tHqvNLPDzDrNp0Da6kQvnaA=; b=HhsmbIXJid42maSzdum07+G4Kn
 OhyaqySaw3l+aah6xDKmHxxlWgjkN6uLY0BZULc/fqfs/5mKjswKcVeVIzjiGCYcZEpcuN1bUeviJ
 ZcMXzl6m7d6v8Za7zaw/ARK2aB+z8kUGpSqViaRf4MWfUUYdAtHLzpzLBgYI7eaOsmQ0=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRBv2-000000005ue-3tVe for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 17:15:33 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so2280247f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 09:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794417326; x=1795022126; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HbN1I3OFe86GfNvpfI75tHqvNLPDzDrNp0Da6kQvnaA=;
 b=JonlZi2UH9gSxu9WAbRlXF+Xp40K9kksKdziJoyfbg3XPGrIXDLTHMJhFt1TGrdNb2
 AnJ2GufR9pmjp4LfHVOUiwuK4ZA3sdCyvQQCJpIGlV+HlzsyGnhrjpWuOkXvGuqNfjFL
 nLHWAMbuHcuV2m/vKoBUHGFTw54Bx7M5H1X7wCuM4S/j0yh2MBkF0Wl6pWjFpXGFF6fs
 IJOoVnsaWmBdmqfY15gtW3tT5yTfNhiCM7gJvC8FbYtUsrDMbW/wRaBPeZy4IQ2E0Dxn
 1VPMxWx/y0d2SUzBE0NbEABYdxPpis/0MtZ4ja41R4ybyzyyxkEC40efWWsjHYf0pMy8
 tGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794417326; x=1795022126;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HbN1I3OFe86GfNvpfI75tHqvNLPDzDrNp0Da6kQvnaA=;
 b=hOFZVykfneHWxMwAywawqr1CLKr8ocWltA2nqkbPYkjnupfcQr8719xblq78SemHdp
 ROkhPGiK9s8kAHisDF5VyRfDje+rrsFzy9966BZD+J23fef7o1vMTR/8Iyhaym5CGRqB
 H09xSV4RT3qkKq1v3rzaYIj74bP27/2injrg3qOBOrDGi4md1W+2JVOERm/8SMDJlV1Z
 6pQZbcg0hiYu8XTP8E8+cs8uxM4l4OkjWZK+69/b/fldwsMnLZ8PDIhwPrds3JTZxhkU
 87GGnwUeZpl7oIhz3zhNNnQdNh3DGAclllIdHujw0QJmvOzAHSrHpz9lI/zmYGVmH3by
 qzvg==
X-Gm-Message-State: APuU4Z+cCjkrTJ7fI7kNzq6VpRlVD5IPw2dDbM8cd33rHSsIAU5dKEYc
 xI04hUbfIMsLGq3d+JE718myOLA9dk5WNLM2F7ujr2pXxWjQSDxs9TNcvMoqAdhbp3f/x9akgO6
 TIdF26Q+FtGImK2EXlGJ1FWfNvHpvBeTCecFbSP2IIjixp12AvLIDAJ4r7XChcMpVxdab
X-Gm-Gg: AYBFou18bUXSmlPwfhhVgcTnnEp/TQ7shegnWmGbgmmfyIrfoRoP1mTzVvcYAH6xyGO
 xZ5dkQxKQjNbPxzWGUPtYEJsuGLY6/8bVbB0k7pfLbmW8itXSow3hh3SfP5SW4G/gefU5gh/Zdv
 26qMw07ey8v9gox5J++MX2IHUv5jRMEdSt3KO17vwo25RL+dYh8LzIJJ26VrLDGzU0r/sAXGf2B
 bo8aTo2Ma6jwdjZMWcwqOfqNTlnJcGPGs4MEtbFgAsZ+rLu9PUcmLAtGYuF+I4xLZnmmZb/F8/7
 QV2irTdt/b1wBUh1fe3XXQx74wh44yyswMFRiW7smt125g37wwOy2yoTJ0atF3hI/k4BJkQ/V6J
 3QM5ar4U/hjiWUAbXJLK+tqpJvaNuBtsbLcOO9e9HFTvYKNWS2NvDNWHyBTKh2lISsZay88Qhwp
 h+fI4D7z9JXtUlcNIKa1tKdhMdlXzidCBxvXvTn6bZH1VjFJkn7drzcCRs2LSHFJYfL1s6eVNQr
 FKEqb13FjjUu+N21Wv6XIT0cM1aW3YurCHaADfbcvEUR5EAY/igU/IOb5D9oN0Q5yGhm/IR6MUU
 o/bAGhwh1Qa/gwG4Xj8T+plp1H1EsJLWr8hxFXM8CnZjKMLolkuQEUIroKbhUaHVNz5Z9QaEZ/I
 2CJAuA93ula/hjoEmFgPO/1tcQx/kM1B9LEKO+dXR17pI0qNzmwmxvQNP7288Xz/G3jpsaBw6/j
 LgNOaV9rtX7PYOetOXEI4mPb4colisxHwmxf1O
X-Received: by 2002:a05:6000:22c6:b0:490:7fb3:cb41 with SMTP id
 ffacd0b85a97d-499c630f989mr5007589f8f.24.1794417326059; 
 Wed, 11 Nov 2026 09:15:26 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835d2c027sm12164222f8f.24.2026.11.11.09.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 09:15:25 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 17:15:22 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ie2d784272184261a62c848e6ad3b7a4570ae6dc7
X-Gerrit-Change-Number: 2165
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2165?usp=email>
X-Gerrit-Commit: cf99ec4d5d7882c334cc065d670c35d2fc70ea2b
In-Reply-To: <gerrit.1794313546000.Ie2d784272184261a62c848e6ad3b7a4570ae6dc7@gerrit.openvpn.net>
References: <gerrit.1794313546000.Ie2d784272184261a62c848e6ad3b7a4570ae6dc7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzEzNTQ2MDAwLkllMmQ3ODQyNzIxODQyNjFhNjJjODQ4ZTZhZDNiN2E0NTcwYWU2ZGM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b00a6c47314f8f4f985b525c45f377b01a91e81c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRBv2-000000005ue-3tVe
Subject: [Openvpn-devel] [S] Change in openvpn[master]: buffer: Change
 return type of buf_forward_capacity_total to size_t
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
Content-Type: multipart/mixed; boundary="===============8244834595033172758=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8244834595033172758==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9Dcnx8+N2YY="; charset=UTF-8

--9Dcnx8+N2YY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

H=
ello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to reexamine a chan=
ge=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2165?usp=
=3Demail

to look at the new patch set (#3)=2E

The change is no longer sub=
mittable: checks~ChecksSubmitRule is unsatisfied now=2E


Change subject: b=
uffer: Change return type of buf_forward_capacity_total to size_t
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

buffer: Change return =
type of buf_forward_capacity_total to size_t

All callers already want a si=
ze_t, so make the
conversion implicit=2E

Change-Id: Ie2d784272184261a62c84=
8e6ad3b7a4570ae6dc7
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ec=
om>
---
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M tests/unit_test=
s/openvpn/test_dhcp=2Ec
3 files changed, 3 insertions(+), 12 deletions(-)

=

  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/65/2165=
/3

diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index 5f21=
de8=2E=2Ea4e2809 100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buff=
er=2Ec
@@ -275,7 +275,7 @@
     if (buf_forward_capacity(buf) <=3D 1)
     =
{
         size_t len =3D strlen(str) + 1;
-        if (buf_size_valid(len)=
 && (int)len < buf_forward_capacity_total(buf))
+        if (buf_size_valid=
(len) && len < buf_forward_capacity_total(buf))
         {
             mem=
cpy(buf->data + buf->capacity - len, str, len);
         }
diff --git a/src=
/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index ede3066=2E=2Eae6dcb7 100=
644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -1068,7 +1=
068,7 @@
  *
  * @return Capacity minus offset, or 0 if \c buf is invalid=
=2E
  */
-static inline int
+static inline size_t
 buf_forward_capacity_tot=
al(const struct buffer *buf)
 {
     if (buf_valid(buf))
@@ -1078,7 +1078,7=
 @@
         {
             ret =3D 0;
         }
-        return ret;
+   =
     return (size_t)ret;
     }
     else
     {
diff --git a/tests/unit_te=
sts/openvpn/test_dhcp=2Ec b/tests/unit_tests/openvpn/test_dhcp=2Ec
index e3=
31d3d=2E=2E3a84e1e 100644
--- a/tests/unit_tests/openvpn/test_dhcp=2Ec
+++ =
b/tests/unit_tests/openvpn/test_dhcp=2Ec
@@ -50,11 +50,6 @@
     return "du=
mmy";
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagno=
stic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 st=
atic void
 test_write_dhcp_search_str(void **state)
 {
@@ -146,10 +141,6 @@=

     gc_free(&gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pra=
gma GCC diagnostic pop
-#endif
-
 int
 main(void)
 {

-- 
To view, visit ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2165?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: Ie2d784272184261a62c848e6ad3b7a4570ae=
6dc7
Gerrit-Change-Number: 2165
Gerrit-PatchSet: 3
Gerrit-Owner: Frank Lich=
tenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: =
Frank Lichtenheld <frank@lichtenheld=2Ecom>

--9Dcnx8+N2YY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Frank Lich=
tenheld <strong>uploaded patch set #3</strong> to this change=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2165?usp=3Demail">View Ch=
ange</a></p><p>The change is no longer submittable: checks~ChecksSubmitRule=
 is unsatisfied now=2E</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">buffer: Change return type of buf_f=
orward_capacity_total to size_t<br><br>All callers already want a size_t, s=
o make the<br>conversion implicit=2E<br><br>Change-Id: Ie2d784272184261a62c=
848e6ad3b7a4570ae6dc7<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichten=
held=2Ecom&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>M src/openvpn/buffer=
=2Eh<br>M tests/unit_tests/openvpn/test_dhcp=2Ec<br>3 files changed, 3 inse=
rtions(+), 12 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/65/2165/3</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><span>index 5f21d=
e8=2E=2Ea4e2809 100644</span><br><span>--- a/src/openvpn/buffer=2Ec</span><=
br><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -275,7 +275,7 @@</=
span><br><span>     if (buf_forward_capacity(buf) &lt;=3D 1)</span><br><spa=
n>     {</span><br><span>         size_t len =3D strlen(str) + 1;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (buf_size_valid(len)=
 &amp;&amp; (int)len &lt; buf_forward_capacity_total(buf))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (buf_size_valid(len) &amp=
;&amp; len &lt; buf_forward_capacity_total(buf))</span><br><span>         {=
</span><br><span>             memcpy(buf-&gt;data + buf-&gt;capacity - len,=
 str, len);</span><br><span>         }</span><br><span>diff --git a/src/ope=
nvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><span>index ede3066=2E=
=2Eae6dcb7 100644</span><br><span>--- a/src/openvpn/buffer=2Eh</span><br><s=
pan>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -1068,7 +1068,7 @@</spa=
n><br><span>  *</span><br><span>  * @return Capacity minus offset, or 0 if =
\c buf is invalid=2E</span><br><span>  */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-static inline int</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static inline size_t</span><br><span> buf_forward_capacit=
y_total(const struct buffer *buf)</span><br><span> {</span><br><span>     i=
f (buf_valid(buf))</span><br><span>@@ -1078,7 +1078,7 @@</span><br><span>  =
       {</span><br><span>             ret =3D 0;</span><br><span>         }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return ret;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return (size_=
t)ret;</span><br><span>     }</span><br><span>     else</span><br><span>   =
  {</span><br><span>diff --git a/tests/unit_tests/openvpn/test_dhcp=2Ec b/t=
ests/unit_tests/openvpn/test_dhcp=2Ec</span><br><span>index e331d3d=2E=2E3a=
84e1e 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_dhcp=2Ec</=
span><br><span>+++ b/tests/unit_tests/openvpn/test_dhcp=2Ec</span><br><span=
>@@ -50,11 +50,6 @@</span><br><span>     return &quot;dummy&quot;;</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Ws=
ign-conversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> static void</span><br><span> test_write_dhcp_search_str(void **state)</sp=
an><br><span> {</span><br><span>@@ -146,10 +141,6 @@</span><br><span>     g=
c_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> int</span><br=
><span> main(void)</span><br><span> {</span><br></pre><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2165?usp=3Demail">change=
 2165</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2165?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ie2d784272184261a62c848e6ad3b7a4570ae6dc7 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2165 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Li=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--9Dcnx8+N2YY=--


--===============8244834595033172758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8244834595033172758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8244834595033172758==--

