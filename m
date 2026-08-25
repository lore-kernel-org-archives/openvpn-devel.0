Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA8FC5DF94
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w1tm8r8WnVvN1dPEviAdLmcp8isDwBodLrCZXZB2qX8=; b=GaLQiPOEQUEMbpzjw5bYx5YVGB
	F/bTohxNvz7tiQsEkM+kGsZj0Z6aUnqE2RmC2T6+M2MA3C00Hkweu2H6w92OF65oa14rU0SQvch0/
	TXf4jvnK0wvB1BOsCaWA//n3ImVuKkJI0vGoMKPC+cS4A1ItBV0QXS3/ItlE2Guw199s=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wylhV-0004F2-0s;
	Tue, 25 Aug 2026 07:36:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wylhU-0004Es-0Y
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:36:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=pxkWS95sBDNX/wysxT7+NVw2exSH6uAvpzSI2Ybg+js=; b=ZSt1f35kjPCndaQZ4GIu/GpxKN
 Wqy1Ea6o8RSZC6Vxht7++QbkH7s3AywZjVWv0ZYCCPzpHEfzZWPcT6K0gqQkM0EuNvjWWjQbnhbCq
 wiGQUtwTU+cGlAZ1A23IVFZefra/7HiadmHsmoSaesztyS0m2u5164AjoU5nreRKpFT0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pxkWS95sBDNX/wysxT7+NVw2exSH6uAvpzSI2Ybg+js=; b=Z
 WsPfIlQLMdG50Hzlj+g+kKYuoXuqMQ4Kh3Ma5jntz8tDhim8LM0EFUBdiKzdYqSNE58z6JSGNCKhA
 9QtHDJssmC6Y3dbv3hpWluVfWhjFm4Qpaq4xEoptPlIwPgwrHPBhteMXvKEDwObM59e3vNLMNFyUE
 3t3XjPMLKQTc36g0=;
Received: from mail-ed1-f51.google.com ([209.85.208.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wylhS-0007Kb-J0 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:36:03 +0000
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-69c600f76ccso7476960a12.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 00:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787643356; x=1788248156; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pxkWS95sBDNX/wysxT7+NVw2exSH6uAvpzSI2Ybg+js=;
 b=fmHCIsuL4oksb/mxjyMOjIp9kJ9DxhOdsFjTQRyxVpLnxjvY028c3+LKMM28xvl6Lj
 rkchAuWqwdbyB3Z6ARdn4xTT5hELeou7YffXVAkEahXAkw9fu8eXAZLSXvncIeOu/+eA
 w86Yfi1myLh/pnxys9MIqpRG2PUQToYjLvmIGvOXudFH6p6G5z75hnKu1o/rgBV5H1rq
 962/+1cezVs1zArwGtN48bS2KDP6gGGLJqHr0RyQLoHh8hxVtLP5/qCUUb3NQcV04K1w
 RHuZl9VWY2FTUbCr3wDTxvAWRli2Oxd7J3fQTOCA/voMmTEeGPnzg6CjtzERSILiSdWL
 4WTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787643356; x=1788248156;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pxkWS95sBDNX/wysxT7+NVw2exSH6uAvpzSI2Ybg+js=;
 b=JE+HPHUFUNkolUM/wBurYIhXBCEL+x4y1YLrc0wAY6K0H8WKGJgotT+lhFHuTk4fSm
 n1RjZ3RWtF/6v/rx2/MEQOZPmil3op0vE9I1Hm2opKCagtJZf5gwEVJbVQxECduozuTj
 yK9PXLy6oLimFxvSsi/JGl7taEmECJGmzF12m8KxBqG6dfR91OCxKoT0dpONv77zPasQ
 JFlq5S0OJ9o3au+2pJaJk0pFz/qRnyjpwPc4RiFy3HfPLf51xkkmtxLBIQtk5TgP6QSX
 71REviPZeiTB83l6hfGR5v7qYUPP56St8CosOkUvA01/a6f+FaGyJJ9rL/fo1b6GCTsV
 tZhQ==
X-Gm-Message-State: AFuF++mNUFtkxdyaIhyF8ZgkYbhcoRcNo//M6fk1jHG3kJTKrG+4bSGC
 0vVnESclHUoZu9lGrrTqcJSEpPq1l1fkbO1Ud0L7VSZq+MOlMpvD/Zy2XXBCK7u5fZbmK9lTkF0
 SJMKlf7rta7mio/S+irakvnkWcdMTKjZ6nwYRTbfVrZgI7WSYzuUKjzr0yn37G9xWPUZGZTYoE3
 C9mB0OwA==
X-Gm-Gg: AR+sD13oLtmN/qR9DDgAegXD+nCWdoDtuQiRFzJ5USJ+gTSj7WDk1lXeTQbCbxcUFxR
 /dg9ZmIE03I5SsSzs0ICROzru/QB0K1sM5zJaocb6PP+j2FOOtR/AwZwrn9Q+XBwMjdBRIMWhJR
 Hy6qeSQK6oWxg4YLpPvYdDHJFbGyGYDouJn97ElpaLCOHoAA72raqhojBMAQGGuS7TIkSpPSLpQ
 b9QuNYXkwki74rQt2eYU1PhgK8r7ELJ9N2xmZe7IJo1VitSwPskobQj69jSKHVYs1GigF0Wbsgi
 8QfrdkaLX1gsde3t3DT2PH/JctkfkgoQJ3DjX2YEX2bNcRWHoHsbt00dqINOscVmecJzZSqsZhj
 LXMYCMh+JWveRnXHgMGAgngv6JlHwnGFlZJ20VxKknQRkmwhhLUtGpaCxRghuOow0j7SCtJoLHi
 6v4L0zdNLJQHCB9KavdMcXfd3XZVp18PKuEJM8///6SYbmYfJ40rgjas7E9oWKaFrHl/XuUxjZq
 45D6qEKNw8zbKsx8VmcLFTJ9RSQhWe1sPL39p8m+U3Rz2PcDIm+V539qKTD2TlMdgHHfwmUfwHz
 XAy/4iZNQt1ROe7WvC28dkhqWFZuiiTGD7V3xrAms0GTTv4Zlxo=
X-Received: by 2002:a05:6402:4442:b0:6a0:9468:a025 with SMTP id
 4fb4d7f45d1cf-6a5c4162b8dmr4988895a12.15.1787643355861; 
 Tue, 25 Aug 2026 00:35:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e19a05bsm18086456a12.17.2026.08.25.00.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 00:35:54 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 07:35:52 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iad13c3bf73dbe073e52ede504ced7fb2f6a9b71d
X-Gerrit-Change-Number: 1866
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1866?usp=email>
X-Gerrit-Commit: de5381481584165cf83a0b8b423e2efab40ebd9f
In-Reply-To: <gerrit.1787570563000.Iad13c3bf73dbe073e52ede504ced7fb2f6a9b71d@gerrit.openvpn.net>
References: <gerrit.1787570563000.Iad13c3bf73dbe073e52ede504ced7fb2f6a9b71d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NTcwNTYzMDAwLklhZDEzYzNiZjczZGJlMDczZTUyZWRlNTA0Y2VkN2ZiMmY2YTliNzFkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5500331b4138e6802a31faa97d51e484100f03b5-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wylhS-0007Kb-J0
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mroute: Remove
 unused functions
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4664690605219890202=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4664690605219890202==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NjjQVys+lQ0="; charset=UTF-8

--NjjQVys+lQ0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1866?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by cron2


Change subject: mroute: Remove unused functions
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

mroute: Remove unused functi=
ons

Both of these have been unused since commit
1308ccec9f85418b088723bb87=
0855c0a933311b
("Remove support for PF")=2E
The first is ipv4 specific and =
very limited in scope=2E
The second is equivalent to just using CLEAR (at l=
east
in actual usage)=2E
So I think both can safely be removed=2E

Identifi=
ed by cppcheck=2E

Change-Id: Iad13c3bf73dbe073e52ede504ced7fb2f6a9b71d
Sig=
ned-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Gert Doer=
ing <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1866
Message-Id: <20260824161743=2E2156-1-gert@greenie=2Emuc=2Ede=
>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg38645=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede=
>
---
M src/openvpn/mroute=2Eh
1 file changed, 0 insertions(+), 20 deletion=
s(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/6=
6/1866/2

diff --git a/src/openvpn/mroute=2Eh b/src/openvpn/mroute=2Eh
inde=
x 639281b=2E=2E9d61b22 100644
--- a/src/openvpn/mroute=2Eh
+++ b/src/openvp=
n/mroute=2Eh
@@ -249,24 +249,4 @@
     dest->v4=2Eaddr =3D htonl(src);
 }
 =

-static inline in_addr_t
-in_addr_t_from_mroute_addr(const struct mroute_a=
ddr *addr)
-{
-    if ((addr->type & MR_ADDR_MASK) =3D=3D MR_ADDR_IPV4 && a=
ddr->netbits =3D=3D 0 && addr->len =3D=3D 4)
-    {
-        return ntohl(a=
ddr->v4=2Eaddr);
-    }
-    else
-    {
-        return 0;
-    }
-}
-
-st=
atic inline void
-mroute_addr_reset(struct mroute_addr *ma)
-{
-    ma->len=
 =3D 0;
-    ma->type =3D MR_ADDR_NONE;
-}
-
 #endif /* MROUTE_H */

-- 
To=
 view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1866?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iad13c3bf73dbe073e52ede5=
04ced7fb2f6a9b71d
Gerrit-Change-Number: 1866
Gerrit-PatchSet: 2
Gerrit-Owne=
r: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@gree=
nie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--NjjQVys+lQ0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1866?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">mroute: Remove unused func=
tions<br><br>Both of these have been unused since commit<br>1308ccec9f85418=
b088723bb870855c0a933311b<br>(&quot;Remove support for PF&quot;)=2E<br>The =
first is ipv4 specific and very limited in scope=2E<br>The second is equiva=
lent to just using CLEAR (at least<br>in actual usage)=2E<br>So I think bot=
h can safely be removed=2E<br><br>Identified by cppcheck=2E<br><br>Change-I=
d: Iad13c3bf73dbe073e52ede504ced7fb2f6a9b71d<br>Signed-off-by: Frank Lichte=
nheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Gert Doering &lt;gert@gr=
eenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1866<br>Message-Id: &lt;20260824161743=2E2156-1-gert@greenie=2Emuc=2Ede=
&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcef=
orge=2Enet/msg38645=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/mroute=2Eh<br>1 file changed, 0 ins=
ertions(+), 20 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/66/1866/2</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/mroute=2Eh b/src/openvpn/mroute=2Eh</span><br><span>index 6392=
81b=2E=2E9d61b22 100644</span><br><span>--- a/src/openvpn/mroute=2Eh</span>=
<br><span>+++ b/src/openvpn/mroute=2Eh</span><br><span>@@ -249,24 +249,4 @@=
</span><br><span>     dest-&gt;v4=2Eaddr =3D htonl(src);</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-sta=
tic inline in_addr_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-i=
n_addr_t_from_mroute_addr(const struct mroute_addr *addr)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if ((addr-&gt;type &amp; MR_ADDR_MASK) =3D=3D MR_ADDR_I=
PV4 &amp;&amp; addr-&gt;netbits =3D=3D 0 &amp;&amp; addr-&gt;len =3D=3D 4)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        return ntohl(addr-&gt;v4=2Eadd=
r);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        return 0;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-static inline void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-mroute_addr_reset(struct mroute_addr *ma)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    ma-&gt;len =3D 0;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    ma-&gt;type =3D MR_ADDR_NONE;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span> #endif /* MROUTE_H */</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1866?usp=3Demail">change 1866</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1866?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Iad13c3bf73dbe073e52ede504ced7fb2f6=
a9b71d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1866 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emu=
c=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=

</body></html>
--NjjQVys+lQ0=--


--===============4664690605219890202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4664690605219890202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4664690605219890202==--

