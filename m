Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07495606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YckbkYBp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VsitVUhL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=UQ9wjhVI;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GIrD/hfT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Wzdt5ia41M7ZcFal1MKkcrF7nh3ObXRkcty7IzrWpLw=; b=YckbkYBpPI1g8w6cwybIdaIHt6
	wTM43c8LceKERw1prMLmmmuPUodeG4svtYxxw1p0xhdBld1SiVxZCoeYw5Y68GbuJOi4Ysy5Wc9DS
	aKKMISYxAvXg7if53Z5zAsSh/VSAB8TT+5A0hVW47fFQXn2fMFSVbrN0nK01Z4bnfCu4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVY7Z-000000004Df-32p1;
	Mon, 23 Nov 2026 17:46:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVY7Y-000000004DZ-2pgJ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:46:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NhTad9jdJbRGyrWpUEv9zhR5fWy8l4HRWqnQ0Tqo84Q=; b=VsitVUhL0Kq4E7fmlG+1ZyiMjo
 FhfklbRAfNVJ2TShGQETz7hbQF44CT2RL8dlRmOcO4MjBnh8XPJ31l+y0nxfeFjmpAoaiSr7GvyAF
 BR8UrgGvKKFPYcefl3MvXviyQa3YtxnfrZv49QuBz+XsZ0tUfvJZx4w5N+pt+kBcSfl8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NhTad9jdJbRGyrWpUEv9zhR5fWy8l4HRWqnQ0Tqo84Q=; b=UQ9wjhVIuS7F5dRkVbCxibecwP
 UNJ0+3j0Dbomg015wNNqMcxsm9Xje4W1XrGeppN58EB0x/pFSlJmu2UEIGyhzgzy1uAvoVHo1HN4p
 NxiuohPd311a+YZfVv/4D6G5XzNx8pI+7809FTrP8PWR3AnNe+RoWmpg3fKLYhWch5JQ=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVY7X-00000000272-3p8m for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:46:28 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-490d59c3edaso2419186f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 09:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795455981; x=1796060781; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NhTad9jdJbRGyrWpUEv9zhR5fWy8l4HRWqnQ0Tqo84Q=;
 b=GIrD/hfT4YpqFtVoXblb1U0yvK7+g5zdvJZAEI8JyjN0put84BFXGGf/5HeUB0irOl
 uYzu0wQ1b3oxm3jxLyTPsY6WQ5McBUQZeb25kkVOghjJqhRCriwjbKJT+FgpLjWvhxLf
 AOYzVuRH+VwZCbVhH5U8wDvpK109O/oPZnQ2PT5hlGmOuAJCoQJVDnz+wErUfjF7XSgY
 QMObQwG5P/MeHVM7YIHK6Ak8/iI1sWn1Olv13r2BsVywvKRT7FHa+5fUfHaaPc+XNVyA
 IZrG0CbFaaYlHvdqkHRvldvJQw9yOgSZ8rjF2vHwUcm+PMn4Z8aYxCN9+9KxY42H/HuT
 dqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795455981; x=1796060781;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NhTad9jdJbRGyrWpUEv9zhR5fWy8l4HRWqnQ0Tqo84Q=;
 b=1sKxKgTYz0SaxJD4YzroDJYnoZ6ohZcNeBVRAbBZudMdOxi3ZbtnAXemX0zJlU0RT2
 0cMlIb1onm6Y1aFzEpF3vwzgRKSIFNGJHqp8dFy/qwK/8jMtJZPf8xBAZjWBB56tGGeA
 ttTvOrBtRu1rk0PplsKe7zXTplELKOKfKJ5iYW6fWTAf+yCGAe0YPTn00lcXDugfJu40
 4kHtNo/VOVkuVKbOmq7yi2x7H1TvNjHNghN4+AeidMhhtw45Kel+TuBtDf4wvRDquWET
 RvwKFW/6V80P251Kaoubdg7LMuyZFg/s+OMvkOJVFhpbfM0Cv6lJA8HONB5xDVGFcFdG
 rSsw==
X-Gm-Message-State: APuU4Z9pnwToBseIGD0KCea7GKCJarVqRo83clOgx/+nNeznaGZMpwNT
 cO7uGtFzXUMFfX0GWLFTz5G04NzAS/HleuDtPEwMfvBkEdJXEsx+kPJUA7hRtAuih6OEnTwoScK
 oPc84WXQ3FdqWtDOoyZR/J19IS/nji+MlDz9r8LpMMS2Y2ESwgCSn3zgCu5EJx2aK9KVJ
X-Gm-Gg: AZFdTZeWZF3lpuyrQIwcT97R6muB66ubV/HXv4bVdgf1O/JhO4AHKpHIX0yz1jFgvFR
 RPPZGlyOV6Lb5/DsZF00XLcSDirf/SPu+HMuFV0UBcbVXbz8X97HiOcVYd7zGokt5dVd3/kM2tt
 SjjJ/4b4VGnEPuMppIO4ZW+4sFHtoYrTo9GBOiDrTsRjiZZZcs516ca7mLJuju16T2EQvpR7z06
 /OeGDTkJLpg/DCY3TNvKhVqQ60XP05eHxfADB45QB0G6pAAQ+oIIv1Xbme04UzkMTsz8XWDQkci
 TNgH5vQTCajzMiq/VHfUn/unPPsSmmbnxGQsZozmtRGE79+ySC4VkmiJZSN88EGjG7iE0Qh84Sd
 q2FDXxK7cV1Mu/ZrA0TKLzK5Nj5krhzDr0MkbUGguzEFiqEJBBrrcx7wir6Qtzl5ZntEOnjiepH
 Ahonc5NczIXGVRUiL5oF9J/ypniCh4lQYL+aijH0tyR38JDdIFY1Uj2s3W0/Sk6HT7iQlCZH9UM
 vY592n91p9Je/cQuDWdcsaZTmtMgdatyO4knMqSMl1B8/Ln67gp9hLqfUgwjGCpGonOcSHGuZA/
 zQGOQwuaq4uJzTIpcMnFtGRtbuOjPyFJ62ZJksb+4cb2R5EFmQQZU1bTWpBekUY2G+4dJi/+6Eu
 VkBkR4dm8tY9+2M4kuZAX/7DmyKMveMY58fJiCvWz9RFm0G/Z+ayvvEmq5V5xPOaixQEV3fe25D
 bhLI/FaFLU6B/tTLg=
X-Received: by 2002:a05:6000:2211:b0:493:72f7:1d5b with SMTP id
 ffacd0b85a97d-4aa5b235116mr29225212f8f.29.1795455981126; 
 Mon, 23 Nov 2026 09:46:21 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d55sm23720144f8f.5.2026.11.23.09.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 09:46:20 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 17:46:19 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ibab5e329d386651ba0dd0e2f4f9bc61c357cdebb
X-Gerrit-Change-Number: 2329
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2329?usp=email>
X-Gerrit-Commit: 8aa208ae714a19708e3c7264409f0cf51bf0f3b3
In-Reply-To: <gerrit.1795443399000.Ibab5e329d386651ba0dd0e2f4f9bc61c357cdebb@gerrit.openvpn.net>
References: <gerrit.1795443399000.Ibab5e329d386651ba0dd0e2f4f9bc61c357cdebb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NDQzMzk5MDAwLkliYWI1ZTMyOWQzODY2NTFiYTBkZDBlMmY0ZjliYzYxYzM1N2NkZWJiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c7b3ee27c87a88c87605f99e02fbd604633c56ea-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVY7X-00000000272-3p8m
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tun: drop unused
 is_ip_packet_valid()
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0610182356387632297=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0610182356387632297==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EDqslj+J9xk="; charset=UTF-8

--EDqslj+J9xk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2329?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Gert Doering


Change subject: tun: drop unused is_ip_pa=
cket_valid()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


tun: drop unused is_ip_packet_valid()

Its last caller went away with Win=
tun support in ad7a6945
("win: remove Wintun support")=2E

Change-Id: Ibab5=
e329d386651ba0dd0e2f4f9bc61c357cdebb
Signed-off-by: Razvan Cojocaru <razvan=
c@mailbox=2Eorg>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit UR=
L: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2329
Message-Id: <20261123141=
837=2E2675-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom=
/openvpn-devel@lists=2Esourceforge=2Enet/msg41829=2Ehtml
Signed-off-by: Ger=
t Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/tun=2Eh
1 file change=
d, 0 insertions(+), 27 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/29/2329/2

diff --git a/src/openvpn/tun=2Eh b=
/src/openvpn/tun=2Eh
index 61fe943=2E=2Ed8680c6 100644
--- a/src/openvpn/tu=
n=2Eh
+++ b/src/openvpn/tun=2Eh
@@ -502,33 +502,6 @@
 int tun_write_win32(s=
truct tuntap *tt, const struct buffer *buf);
 
 static inline bool
-is_ip_p=
acket_valid(const struct buffer *buf)
-{
-    const struct openvpn_iphdr *i=
h =3D (const struct openvpn_iphdr *)CBPTR(buf);
-
-    if (OPENVPN_IPH_GET_=
VER(ih->version_len) =3D=3D 4)
-    {
-        if (BLENZ(buf) < sizeof(stru=
ct openvpn_iphdr))
-        {
-            return false;
-        }
-    }
=
-    else if (OPENVPN_IPH_GET_VER(ih->version_len) =3D=3D 6)
-    {
-      =
  if (BLENZ(buf) < sizeof(struct openvpn_ipv6hdr))
-        {
-            =
return false;
-        }
-    }
-    else
-    {
-        return false;
-  =
  }
-
-    return true;
-}
-
-static inline bool
 tuntap_is_dco_win(const s=
truct tuntap *tt)
 {
     return tt && tt->backend_driver =3D=3D DRIVER_DCO=
;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2329?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibab5e329d3=
86651ba0dd0e2f4f9bc61c357cdebb
Gerrit-Change-Number: 2329
Gerrit-PatchSet: =
2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewe=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering =
<gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>

--EDqslj+J9xk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2329?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">tun=
: drop unused is_ip_packet_valid()<br><br>Its last caller went away with Wi=
ntun support in ad7a6945<br>(&quot;win: remove Wintun support&quot;)=2E<br>=
<br>Change-Id: Ibab5e329d386651ba0dd0e2f4f9bc61c357cdebb<br>Signed-off-by: =
Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Gert Doering &lt=
;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2329<br>Message-Id: &lt;20261123141837=2E2675-1-gert@greenie=2E=
muc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg41829=2Ehtml<br>Signed-off-by: Gert Doering &lt;ger=
t@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/tun=2Eh<br>1 file changed,=
 0 insertions(+), 27 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/29/2329/2</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/tun=2Eh b/src/openvpn/tun=2Eh</span><br><span>index 61f=
e943=2E=2Ed8680c6 100644</span><br><span>--- a/src/openvpn/tun=2Eh</span><b=
r><span>+++ b/src/openvpn/tun=2Eh</span><br><span>@@ -502,33 +502,6 @@</spa=
n><br><span> int tun_write_win32(struct tuntap *tt, const struct buffer *bu=
f);</span><br><span> </span><br><span> static inline bool</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-is_ip_packet_valid(const struct buffer =
*buf)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    const struct openvpn_iphdr *ih =
=3D (const struct openvpn_iphdr *)CBPTR(buf);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (OPENVPN_IPH_GET_VER(ih-&gt;version_len) =3D=3D 4)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (BLENZ(buf) &lt; sizeof(struct openvpn_ip=
hdr))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            return false;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    else if (OPENVPN_IPH_GET_VER(ih-&gt;version_len)=
 =3D=3D 6)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (BLENZ(buf) &lt;=
 sizeof(struct openvpn_ipv6hdr))</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        return false;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return true;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-static inline bool</span><br><span> tuntap_is_dco_win(const st=
ruct tuntap *tt)</span><br><span> {</span><br><span>     return tt &amp;&am=
p; tt-&gt;backend_driver =3D=3D DRIVER_DCO;</span><br></pre><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2329?usp=3Demail">=
change 2329</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/232=
9?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: Ibab5e329d386651ba0dd0e2f4f9bc61c357cdebb </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 2329 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert=
@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></=
html>
--EDqslj+J9xk=--


--===============0610182356387632297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0610182356387632297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0610182356387632297==--

