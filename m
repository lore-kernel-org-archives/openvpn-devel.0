Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0012BC624D4
	for <openvpn-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rqZjZfYrpMp3qWEu+G2MD2hOOMRIHB+VXn7illzA+9Q=; b=hy8m2qRXaxwoqzfV+ABOPeL/Hd
	f4vtJUdiG1pnaZ6Epl5W9VQUQ48DT5ACVevN/bakDpEvcrC4gWI+MC4zgrBCinmj20vVA8RYjdZx2
	1/V02XPYMTGaZn6TkNLiHv2dZZmb8Yor1Ry9yh2/n4hxiMK86avJBbATs6X94bECPa3s=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1n0G-00065f-6d;
	Wed, 02 Sep 2026 15:35:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1n0C-00065S-VY
 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 15:35:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=NmEERd5+AQqGj8Uz63laRKcj8oP0CCFBM/ZboNq4NH8=; b=ae1B8Qa89gqP4tACPMrqKrXCln
 S55+sOFpF6MZIORUTFNFovWD6T2GrkojgkKUVMI+AsBYpz+Xp83XpbrMmok1/UFHudvjab6/m2oPP
 R63e2DNx5aKcF5I9BDIYvfKUk7xeUiUtGaJL693fnTi/nNs6QwYAbTae2zbpQJwkr97M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NmEERd5+AQqGj8Uz63laRKcj8oP0CCFBM/ZboNq4NH8=; b=m
 5tgNqgCJF6dMXD/nZyq6EPX351bHIyp7CTf21Uaggc8xQXHNjPxFP1k5paa8jf0vQxubVOUVokvS1
 xKDFFrGvqhAYEIPuVyWyFUkrBO//9Xe34oweLl3IAV551RAgcy5m2Uzw9l7n7QYfL7aqbouPy7NFp
 Nggl7n7uey2ZlVtU=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1n09-0005V9-Kv for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 15:35:52 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so12055915e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 02 Sep 2026 08:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788363343; x=1788968143; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NmEERd5+AQqGj8Uz63laRKcj8oP0CCFBM/ZboNq4NH8=;
 b=H0mQTba3gr8RsWokq4CI6YZv179c8X3h7e7maoO4WwOu+AdVdT+qDdc6JoQqgVpIyX
 7FMiStVUbd+mGgRJcOOVi1L4AGM7FehbQ+xfvsE57MOEX8uFnMgMatlkY25Gih5fHatM
 pJCt+3T9GHdqoWWhwxYXoCBsJgEF8kNWee53tzJwYk+Qq4X8zPG3EVJ/7VrjQW2UiIRa
 KYsXlB3Q6XUmnwYNwNPx2muHHzofuY0rGwIL0IhCUdrd3Bx960bl3MkWl5mz0e5iPgis
 sU6Flxct3bIgscKGNiaQhPC46LMd3MrDeBuZasECIFlTzqEZJOZJdHB3NAB5WjRzQnbn
 DvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788363343; x=1788968143;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NmEERd5+AQqGj8Uz63laRKcj8oP0CCFBM/ZboNq4NH8=;
 b=epgxkVeTze2xJ15CFw3S9PsKE8UIssZxA47JeVDhhi13a1IXSPh0jo0bIEp4RXO2hv
 2QkqzkCwtiZqr9Ielv9GDI5WlCCMAxNJOCsw8anO3KjQzYTkwpZDVC16Sba8JY0aTcmS
 NZBJ0NaHVa26EAWPJMRN30Wsu5m7IgC9n58tq22FlLz6zChARbjFEJPiF6sJLjLqabMH
 StxC9n04JJD47bfmtAceo5z5iX6Y5LW/wVCwP8kVFDnOuyHFYiRAycyoMwv7gusXcXZM
 8506k4VHMoM66HPZcgN9Psk0hTR+pSyWJM5C8XghlzvGundEZZH8bNRcycr7s8Gzj4A5
 SBew==
X-Gm-Message-State: AFuF++kVuyobZ+z4lW1FEkMT15Qf3vfNjdzJFXMIDPfv6ifcZGgMGtGX
 wHLr5IJwqvGXrgBrCrmwmnjCkyntgF65h5PL5iHouFvgzU+TNy968i0ALxZqWn1rQya7/8B6bxy
 y7N3nTJiZBArVarqwIzehf0GAlZmZVwc4x+BxTa7pgZC08hJCqASvLweZsg2ujjWBCyYr
X-Gm-Gg: AR+sD11qNQfY/DODg43KQjCWBpw7iZcGxjvnbM7SC+UOjcqTiifp4S+McSyeaCNatui
 dv3xNYStuyBA3BhdU9YgZIb25K0HRbV4qno4PCxTIJVCGqjRhAgMOa562YHo8MGhXaYeGyucLQl
 A8hFUThm+//2iXA5E44mIjcwfO13aN7eGd7QZVjgAIiHvWomcUkR4fgTVkM0ewU1FRu9U5RApgJ
 jzig7daToi3YcFst6PMGrcD8ZEoyCP8zi/p/txtSdbOtBBbGMqyFEVBvQwEDTVquHWfiaoA+Y/i
 YlnNvsFrYE8+/7o5iSmHHLLD6VwJL2vUGh8FvLYr0bRPxxvDOvf0b0c579wlx3fxGfeKSi/AdrA
 FwjfLz3UW3/0oiEaT4G/6SH1vde7KoJGgJXz6J1vYzClwKNzC1t0+XH5T27O0xxgp1yNKmmBRsk
 vYDkMVi8l4dEkCNo2RbOXGME22rbQhzc4yfDTgbyhsfZsjh7FFVtOsaYNZla3/MTBDnxGxmOXui
 9kzUL9Nsk3gZPmqxbm8u7i+zEpXhP0MAtatS84EDzpHsucQJOVcWkEMF1910DFDq195gx7XMZig
 XGrZKcs+hpsFXuY6zfUGV39m8huj4O4i2CgcJKzYXUT7VaoCJn8=
X-Received: by 2002:a05:600c:3486:b0:499:8704:242c with SMTP id
 5b1f17b1804b1-49ce5591a08mr114878115e9.0.1788363342742; 
 Wed, 02 Sep 2026 08:35:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee131fcfsm3513065e9.4.2026.09.02.08.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 08:35:42 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 2 Sep 2026 15:35:40 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I68429deb39c0bae335d46a4170973a14c644ccf9
X-Gerrit-Change-Number: 1891
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1891?usp=email>
X-Gerrit-Commit: cf08504bbbacdb0c3d94c7a0358a6ec06c553cdd
In-Reply-To: <gerrit.1788295708000.I68429deb39c0bae335d46a4170973a14c644ccf9@gerrit.openvpn.net>
References: <gerrit.1788295708000.I68429deb39c0bae335d46a4170973a14c644ccf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4Mjk1NzA4MDAwLkk2ODQyOWRlYjM5YzBiYWUzMzVkNDZhNDE3MDk3M2ExNGM2NDRjY2Y5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <305c7bcf29fba3c5bcb25f525ddfe9f3c3af9c03-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1n09-0005V9-Kv
Subject: [Openvpn-devel] [S] Change in openvpn[master]: win32: quote
 arguments that cmd.exe would reinterpret
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8401277649880134014=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8401277649880134014==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Yko0fPTWyGY="; charset=UTF-8

--Yko0fPTWyGY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello d12fk, plaisthos, 

I'd like you to reexamine a change=2E Please visi=
t

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1891?usp=3Demail

to look =
at the new patch set (#2)=2E

The following approvals got outdated and were=
 removed:
Code-Review+2 by d12fk


Change subject: win32: quote arguments t=
hat cmd=2Eexe would reinterpret
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

win32: quote arguments that cmd=2Eexe would reinterpret=


wide_cmd_line() only quoted arguments containing a space, so & | < > ^ %
=
( ) and ! were passed unquoted=2E CreateProcess() runs =2Ebat and =2Ecmd fi=
les
through cmd=2Eexe, which parses the command line again, so a certificat=
e
subject passed to --tls-verify could start a second command (CERT/CC
VU#1=
23335)=2E

Quote on those characters too=2E Double quotes are already repla=
ced with
'_', so nothing else needs escaping=2E The delimiters , ; and =3D =
are left
out: cmd=2Eexe uses them to separate %1=2E=2E%9 but cannot run any=
thing with
them, and quoting them would change what existing scripts receiv=
e=2E

GitHub: OpenVPN/openvpn-private-issues#159
Reported-By: Clouditera Se=
curity; Z=2Eai Security; NSFOCUS <security@clouditera=2Ecom>
CVE: 2026-8425=
6
Change-Id: I68429deb39c0bae335d46a4170973a14c644ccf9
Signed-off-by: Lev S=
tipakov <lev@openvpn=2Enet>
Acked-by: Heiko Hund <heiko@openvpn=2Enet>
Gerr=
it URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1891
Message-Id: <202609=
02121416=2E7047-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38897=2Ehtml
Signed-off-b=
y: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/win32=2Ec
1 fil=
e changed, 19 insertions(+), 3 deletions(-)


  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/91/1891/2

diff --git a/src/openvpn/w=
in32=2Ec b/src/openvpn/win32=2Ec
index dd88a22=2E=2Ea9990b5 100644
--- a/sr=
c/openvpn/win32=2Ec
+++ b/src/openvpn/win32=2Ec
@@ -1034,6 +1034,22 @@
    =
 }
 }
 
+/* special to cmd=2Eexe, which CreateProcess() uses to run =2Ebat/=
=2Ecmd (VU#123335) */
+#define CMD_QUOTE_TRIGGERS " &|<>^%()!"
+
+static bo=
ol
+argv_element_needs_quotes(const char *str)
+{
+    for (const char *c =
=3D str; *c !=3D '\0'; ++c)
+    {
+        if (strchr(CMD_QUOTE_TRIGGERS, =
*c) !=3D NULL)
+        {
+            return true;
+        }
+    }
+    =
return false;
+}
+
 static WCHAR *
 wide_cmd_line(const struct argv *a, str=
uct gc_arena *gc)
 {
@@ -1072,13 +1088,13 @@
         {
             buf_pr=
intf(&buf, " ");
         }
-        if (string_class(work, CC_ANY, CC_SPAC=
E))
+        if (argv_element_needs_quotes(work))
         {
-            b=
uf_printf(&buf, "%s", work);
+            buf_printf(&buf, "\"%s\"", work);=

         }
         else
         {
-            buf_printf(&buf, "\"%s\""=
, work);
+            buf_printf(&buf, "%s", work);
         }
     }
 

--=
 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1891?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I68429deb39c0bae335d=
46a4170973a14c644ccf9
Gerrit-Change-Number: 1891
Gerrit-PatchSet: 2
Gerrit-=
Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: d12fk <heiko@openvp=
n=2Enet>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--Yko0fPTWyGY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1891?usp=3Demail">View Change</a></p><p>The f=
ollowing approvals got outdated and were removed:
Code-Review+2 by d12fk</p=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">win32: quote arguments that cmd=2Eexe would reinterpret<br><=
br>wide_cmd_line() only quoted arguments containing a space, so &amp; | &lt=
; &gt; ^ %<br>( ) and ! were passed unquoted=2E CreateProcess() runs =2Ebat=
 and =2Ecmd files<br>through cmd=2Eexe, which parses the command line again=
, so a certificate<br>subject passed to --tls-verify could start a second c=
ommand (CERT/CC<br>VU#123335)=2E<br><br>Quote on those characters too=2E Do=
uble quotes are already replaced with<br>&#39;_&#39;, so nothing else needs=
 escaping=2E The delimiters , ; and =3D are left<br>out: cmd=2Eexe uses the=
m to separate %1=2E=2E%9 but cannot run anything with<br>them, and quoting =
them would change what existing scripts receive=2E<br><br>GitHub: OpenVPN/o=
penvpn-private-issues#159<br>Reported-By: Clouditera Security; Z=2Eai Secur=
ity; NSFOCUS &lt;security@clouditera=2Ecom&gt;<br>CVE: 2026-84256<br>Change=
-Id: I68429deb39c0bae335d46a4170973a14c644ccf9<br>Signed-off-by: Lev Stipak=
ov &lt;lev@openvpn=2Enet&gt;<br>Acked-by: Heiko Hund &lt;heiko@openvpn=2Ene=
t&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1891<br>Mes=
sage-Id: &lt;20260902121416=2E7047-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: ht=
tps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg3=
8897=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<=
br>---<br>M src/openvpn/win32=2Ec<br>1 file changed, 19 insertions(+), 3 de=
letions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/91/1891/2</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/win3=
2=2Ec b/src/openvpn/win32=2Ec</span><br><span>index dd88a22=2E=2Ea9990b5 10=
0644</span><br><span>--- a/src/openvpn/win32=2Ec</span><br><span>+++ b/src/=
openvpn/win32=2Ec</span><br><span>@@ -1034,6 +1034,22 @@</span><br><span>  =
   }</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* special to cmd=2Eexe, which CreateProcess() uses t=
o run =2Ebat/=2Ecmd (VU#123335) */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define CMD_QUOTE_TRIGGERS &quot; &amp;|&lt;&gt;^%()!&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+argv_element_needs_quotes(const char *str)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (const char *c =3D str; *c !=3D &=
#39;\0&#39;; ++c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (strc=
hr(CMD_QUOTE_TRIGGERS, *c) !=3D NULL)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            return true;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static WCHAR =
*</span><br><span> wide_cmd_line(const struct argv *a, struct gc_arena *gc)=
</span><br><span> {</span><br><span>@@ -1072,13 +1088,13 @@</span><br><span=
>         {</span><br><span>             buf_printf(&amp;buf, &quot; &quot;=
);</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        if (string_class(work, CC_ANY, CC_SPACE))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (argv_element_needs_quotes=
(work))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            buf_printf(&amp;buf, &quot;%s&quot;, work);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&am=
p;buf, &quot;\&quot;%s\&quot;&quot;, work);</span><br><span>         }</spa=
n><br><span>         else</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;buf, &quot;\&qu=
ot;%s\&quot;&quot;, work);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            buf_printf(&amp;buf, &quot;%s&quot;, work);</span><br><s=
pan>         }</span><br><span>     }</span><br><span> </span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1891?usp=3Demail">change 1891</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1891?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I68429deb39c0bae335d46a4170973a14c6=
44ccf9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1891 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@openvpn=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></h=
tml>
--Yko0fPTWyGY=--


--===============8401277649880134014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8401277649880134014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8401277649880134014==--

