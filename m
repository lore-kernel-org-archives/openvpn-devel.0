Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BE4C61DBD
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pRZt5++eS/Uv5ZskdZG/lKHLt5xA/K0cwE4xQM8A9W4=; b=fUzOIKU8UszliAaZH3e656WWcc
	9n5q1GyXpk5SNJnKpP21ktGMZKyisgir8b2Yv6V4EMPI58Vaj2NEa3SKdJEnL1eSsQMJ+6L0Vf+NB
	k8CIfbW37Jq5OFs0o6JeHERmL/bJoiIHjQshew91YUTLAfjuUBDpUIuMKZhsCxUCdJiY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wymBR-0003yq-HG;
	Tue, 25 Aug 2026 08:06:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wymBA-0003v5-Tl
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 08:06:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=3sawWEwudveDT0v+gRHivPhyrkYtW57yXavSwL6fF9o=; b=ERdv8yGcBsJfCMEHOdzEyu7sxl
 F3GHgLSm+WiBzzU/DlmDW9NtfNoBWAXGOHBgoLGOLwpgCUdrXmSmbod50HBD5atAzx2xiAcolpAQo
 rqwYL5XsqCFEKWtPkgaFubJQvsmFUPOEerUTSuksHqCwJyAtSltwkfI/SJGaivQts0xc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3sawWEwudveDT0v+gRHivPhyrkYtW57yXavSwL6fF9o=; b=n
 Di4vRPq1TiV4kWJXVsgfW9XGn8u//Ae+LlpJ7PSyj9Abcx9PyN/jUyA7Motfcejjgale9BiZyOAAd
 MlV+wNCb4vCUUoPtT+O9gAkRuWXNoKTXN3HRrEEWxdCniod5gqD9EUq7YsrpSZY9qttQeB4wmxtlQ
 scHy4KU/Ugdq8FE8=;
Received: from mail-ej1-f50.google.com ([209.85.218.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wymB5-00008q-OT for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 08:06:42 +0000
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c167aa9500dso674839866b.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 01:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787645193; x=1788249993; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3sawWEwudveDT0v+gRHivPhyrkYtW57yXavSwL6fF9o=;
 b=JTnvK/vtmgM1ovmevCeYx5vOvogbcMv+Gy1RcU/BPeHOTAIHCkKTfXHjLJbfS0zH9b
 V5xhGR3+TAGPjf2ZbmoXBt4EqsU5r1XkL4/hgk2/4NYxyrAyqlkmg5KIxagq79MTNtio
 iXusl8l/xbXJOmEh08Zd9/zMBvwyqadVLxn+jBO6goIsxgdYGhQsiH6PolQ2NusQ8VH8
 WwrM6cYxp+j7jYL5strrtjMhs1/qnqs2KNlvVWmTNDmgve7eUK0EtBNTl2Nd1WtO5DlB
 JOvFeBGwSvUYscO1K4i5Qn/LpI0xiQr0+5TD6/saiFch4Z8XLy9Z04X0y7i3WCdDnsO8
 /nNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787645193; x=1788249993;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3sawWEwudveDT0v+gRHivPhyrkYtW57yXavSwL6fF9o=;
 b=RRVizs4hS2tgU7b0j8ijDsgA9d/Bxkw+oo5JWkR0GDroKe5mKsf57Yrwm7Vm0dD9Qo
 x/Nh+R3d7xoN62UMvioCs1vRW45veRGrESocr2DzrsJ2W1ZxOyA5D6i1McsNE9ueZRcL
 be5PW6cwYvT3pjMfoQAWppgVLMPydX4B0X/NwfeApMfZjTiHelYDRwrMht6N8qyT4gNu
 9rEqkFTrhOBtEzNXIeqb2hFVA2UynWlONcnE+ennmN8JURVfvMpPZiyPTQOly7OWtP9Z
 7Ji2+ffEKbdrqDQ21Ec5JRiJFEV8GDJbZhVu+WVecUDgBrREUTjnn6i66oTsrea9imXv
 AVKA==
X-Gm-Message-State: AFuF++kSMY2PB9Dm+qzHAdV0Hg+LOOujndt7wGLCMsaoxZtWjSc4We5x
 6onMBwQo1CMujF/8WZpTs9f+5GwL8NGsuOMWe4CxA3Eya8J6ufISs80MwhUjWdBlpKg8qIB7FCe
 zZEMDkZ3giAN0T1W2RdKItt+JnupRQRaW0APYMNP1uBaJ4ipmGOuXh6ZDf76V8tYWRTPZjWQt+n
 C7SRxGCw==
X-Gm-Gg: AR+sD10294spCuYIqgS0d5jAugiL6F2+3+xCQ61j9SI2VQp+pyvsybl86W/7k41MiwY
 4E1wAGQngy5nZVxvlisEMcMXIJKW7Pu4WpN3kzTU0kSVCkkqb+BmPY26FMSvM2xsAQcHM6GRKCR
 z+ya6vEz3PHhoHvcgjjIpckNGSj3k4KaBLL8FRxb7MbXnXEuZ7fJWvw0FkqQZlYX+0DrODY82Fw
 YPQ1wAKIxiCGNtirpj3TOdGpQ9ONyrfpVe+ulhQ0+bICUPOzyQC+a06DwpRhPinowKKnNW+DoqQ
 UDGqVU7ko4XTNvaCFTWLP3acgMuFDiobcWthsCfkbD1t6ABFeOBo4yyirJiXP0PkWfHFySQhBq1
 R1j0UIblzF55WU8mjvEYz9qyNjzvIDpyA7BPR4g6IC57keSPGShcws1HtkOIcai0rhdDzxdqOKU
 jjQzk+2FVpQoMXN/sx8Wg0FUQ4afxNJbAN9fPhjIRRiWZ/DaL+fA3nXpVcyNkjWXTEtf2xUE4WX
 ET7x0wTAboBeejncZTQnRX6KR1P7JPCKP/WG1VPq0vCyAwROfbSfRGJtpUaTjBj0DD1m4AaXZsb
 Kvdk/TmIXGCorICW3ULi0C59kXkLhYuJQz+cm9ai0md6COsNtWw=
X-Received: by 2002:a17:907:3e16:b0:c16:3074:657f with SMTP id
 a640c23a62f3a-c246a4ce3b8mr3607618966b.9.1787645192589; 
 Tue, 25 Aug 2026 01:06:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f9cbcsm1864912666b.29.2026.08.25.01.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 01:06:31 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 08:06:29 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I450568c0307a6372506d115cb389d172472140d4
X-Gerrit-Change-Number: 1845
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1845?usp=email>
X-Gerrit-Commit: 1d818506d565af43c394ce0f5ba2420806401642
In-Reply-To: <gerrit.1786968495000.I450568c0307a6372506d115cb389d172472140d4@gerrit.openvpn.net>
References: <gerrit.1786968495000.I450568c0307a6372506d115cb389d172472140d4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2OTY4NDk1MDAwLkk0NTA1NjhjMDMwN2E2MzcyNTA2ZDExNWNiMzg5ZDE3MjQ3MjE0MGQ0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b782ef1f9de50543ef1102fde0f85828737dd460-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wymB5-00008q-OT
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: buffer: Remove some
 useless casts on BLAST returns
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
Content-Type: multipart/mixed; boundary="===============4792516691505406725=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4792516691505406725==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CPJ3yUP3ksk="; charset=UTF-8

--CPJ3yUP3ksk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1845?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: buffer: Remove some useless casts on BLAST ret=
urns
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

buffer:=
 Remove some useless casts on BLAST returns

We can compare to '\0' without=
 having to do casting=2E

Change-Id: I450568c0307a6372506d115cb389d17247214=
0d4
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Ra=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1845
Message-Id: <20260818142252=2E27227-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg38485=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/buffer=2Ec
1 file changed, 3 insertions(+), =
3 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/45/1845/2

diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffe=
r=2Ec
index 2b4d05d=2E=2E046e231 100644
--- a/src/openvpn/buffer=2Ec
+++ b/=
src/openvpn/buffer=2Ec
@@ -500,7 +500,7 @@
 void
 buf_null_terminate(struct=
 buffer *buf)
 {
-    const char *last =3D (char *)BLAST(buf);
+    const u=
int8_t *last =3D BLAST(buf);
     if (last && *last =3D=3D '\0') /* already=
 terminated? */
     {
         return;
@@ -523,12 +523,12 @@
 {
     while=
 (true)
     {
-        const char *last =3D (char *)BLAST(buf);
+        c=
onst uint8_t *last =3D BLAST(buf);
         if (!last)
         {
         =
    break;
         }
-        if (char_class((unsigned char)*last, CC_CRLF=
 | CC_NULL))
+        if (char_class(*last, CC_CRLF | CC_NULL))
         {
=
             if (!buf_inc_len(buf, -1))
             {

-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1845?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I450568c0307a6372506d115cb389d1724721=
40d4
Gerrit-Change-Number: 1845
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--CPJ3yUP3ksk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1845?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">buffer: Remove some usel=
ess casts on BLAST returns<br><br>We can compare to &#39;\0&#39; without ha=
ving to do casting=2E<br><br>Change-Id: I450568c0307a6372506d115cb389d17247=
2140d4<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<=
br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1845<br>Message-Id: &lt;202608181=
42252=2E27227-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-arch=
ive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38485=2Ehtml<br>Signed=
-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openv=
pn/buffer=2Ec<br>1 file changed, 3 insertions(+), 3 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/45/1845/2</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/=
buffer=2Ec</span><br><span>index 2b4d05d=2E=2E046e231 100644</span><br><spa=
n>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec=
</span><br><span>@@ -500,7 +500,7 @@</span><br><span> void</span><br><span>=
 buf_null_terminate(struct buffer *buf)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    const char *last =3D (char *)BLAST=
(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uin=
t8_t *last =3D BLAST(buf);</span><br><span>     if (last &amp;&amp; *last =
=3D=3D &#39;\0&#39;) /* already terminated? */</span><br><span>     {</span=
><br><span>         return;</span><br><span>@@ -523,12 +523,12 @@</span><br=
><span> {</span><br><span>     while (true)</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        const char *last =3D (=
char *)BLAST(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       const uint8_t *last =3D BLAST(buf);</span><br><span>         if (!la=
st)</span><br><span>         {</span><br><span>             break;</span><b=
r><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (char_class((unsigned char)*last, CC_CRLF | CC_NULL))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (char_class(*last, CC_=
CRLF | CC_NULL))</span><br><span>         {</span><br><span>             if=
 (!buf_inc_len(buf, -1))</span><br><span>             {</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1845?usp=3Demail">change 1845</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1845?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I450568c0307a6372506d115cb389d17247=
2140d4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1845 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razv=
anc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=

</body></html>
--CPJ3yUP3ksk=--


--===============4792516691505406725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4792516691505406725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4792516691505406725==--

