Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F24CD4851
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 10:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=91MFX6tsQc2+iuzsUcl/pXhGfi/CY6iTfC4qd/WVykY=; b=NJ/HmrNWoMBjdbW2XTmEGI/b0B
	iIm2p/x6UHVJepGvL6vJqB9iTtOWS6bXbRsvNlNJjRMYTOI0Zs9obZ9dyhyyzWPd/36IhvI49WaE6
	B4Djk5fJoAvyVjL4Wx7tiNhSnDOPIu8x9c6tzAIz6nUzi37lK5WoBq+gw71ztrm75tFc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNTSU-0003UV-6r;
	Thu, 14 May 2026 10:38:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wNTSS-0003UN-B9
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 10:38:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=hFC01QazPGGdFEd8GuynNOl5crB7viscgann/MHSZ9c=; b=WVr+tkADzjMvgRs660o1CqaNG8
 i6jGhOhHzLYLZAThfSCNpo38ijbDdNfvMpBELk7mm1Wfs4iOI6JLQB8hMfS/Uq0deteLUhMycea2s
 cqqkyXafZmiPEjZEoOKFKuhGjTManb2GotXNNY/jxl/dfmAnzSJUt+oDbDzXDe0p1l04=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hFC01QazPGGdFEd8GuynNOl5crB7viscgann/MHSZ9c=; b=C
 1yvVFKsmyW1fVj2L3itd3phzTsSXvTenXiZT1cxEGQ4Kh2RY3u5n133erxP4ia9guLN54XGH1Y+ve
 Jc7WU5YiktEGaAwrxeW76i0giEoGNaoxVNapCGT1Fi6pEw6qw62YLmG9OA9UdvODGZufMY3IJ2tOt
 gVV2EeMUaLb1wzzs=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wNTSQ-00072d-3g for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 10:38:24 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so129926095e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 14 May 2026 03:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778755091; x=1779359891; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hFC01QazPGGdFEd8GuynNOl5crB7viscgann/MHSZ9c=;
 b=gl0+IZaNTxCnDBjCqx0G6sI1Q61uL8PZibP0io66CIJ5P/Ql0vHxK1+eFYx/V8AJUi
 trsYQpR7ROx6QnK6V6w40r47d/sAacG3mePVXCoMmATePxjph88eQEeqbScvlj8L92oI
 D7T5BLY/l9qzKCRSdT3G8QsPMPa3HKxGvXHctBzjmLK7id1Vc4RHnrxJ8R627+uigkg0
 N3DtoZwdShM3mv0SmcM5VAuZJosvzSzJ9XgA6d0zNfra5KpAUEIbuwChE5lPRvT6miOt
 PKpHmqgTTE8klNBKY1pvAjfkOu7mZ0iXAftPEVcIn8ya9rROqEkrHyhzRuv0odkt/yAi
 XrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778755091; x=1779359891;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hFC01QazPGGdFEd8GuynNOl5crB7viscgann/MHSZ9c=;
 b=raUNHUPzGLzzYuHFlMmeQfooyY1ywqq+LLapM8Zzm6pvhPR+CV/r9YfzytZqYLz0NL
 O1HIC+G6V1gGtJYp/1Cf4/SqzxqwgXvfr3PPFER3sqyQxQs2zOUM1b3tNCRPtg1oup+0
 ulBGm+pIodW2Buskl4eh5KGhMKtWAu6rwsW/cGzyx4rZkhox6Gin9mNV0GDPI2n3cOtL
 iBBcHF+msJgPgOhgaIzX4zcMqWUMfikVfltk2n1vEuakJBi1BSK/F18R0yy830rsBKzj
 T0YRhA1AnJ5EVBRMQzTFM9EgFRPadPCreTVFRJdPmUqmTbdXWlYFZ2oXlzV5lEX/hzXT
 6cfQ==
X-Gm-Message-State: AOJu0YxTxAQuttdFSgldxoMKfKFepVFZfPogeVRTzl0Kd+qLX83ZOxji
 BhaWr+RjowElUjMjHLGh0VtzUAXEEQXnBBBlCBDqipOMT1zYxBEefnmqXywx8JUsCOIGl9BefgO
 cfBxL8u/5qbYv3zH9FOAHriI+m8ogd+9VTeCJMYrGP6uDzDvsuFEM5bdHaDUwJoLhTGPLyq8fyR
 wRBGAyuw==
X-Gm-Gg: Acq92OG/egjW+e8BOUkPFO31Y5xC56aTVIPkIDlj7PIlDYmk11gTDeQAQD1b6dDXF72
 plUpq+9IiY/HLtUPz+Hey0pi4kZuCZtuRkQSs9vvGmyGZMJQclmCDQEH80UTxJANrZuB/pA9K9A
 648XGkmlqT/KkXp5WPi+H0f0hQmr8tgRn29XtzdsreZT2M4Z8e/D97wNGE9oU5a1LGEsFNkMw5T
 JsGWHocCzXBaqkqYNjDWOsA5RzGx6qDTyvVtS8zWNv0V0+Nq7EMeYaFt/q3tu5o4JotMnzB4YOo
 LNjCVTpUk95k/2gFVClUwKLeD7uAv4lSsFJn3c5DMS32sMvzUCn3HKBF8diYTiP7Oxh4Q71rLTg
 0DHgIRR10ZopQRlZKgBBG/rVCfEQSkp7+GTSTduwM/tBE8dTFpGJ/B/KluDaigFuVMVNuFP3oTD
 sYaTSDvTtuKVAhI8FjgJEtkj+ZQMD8al87sC1rRhT0C86D/OWB+PJKRZhykC44le5QDSFGpf3nA
 012o3TiTib5M2zU8LhkNM2d06DL4UY4FaDpfITpPysftVeuzbdpLdZ/i9P4+yQjhyU9jwOsYKXf
 X6p2MUlSamfmUg==
X-Received: by 2002:a05:600c:4583:b0:487:2439:b7be with SMTP id
 5b1f17b1804b1-48fce9b2fe7mr96379485e9.6.1778755090808; 
 Thu, 14 May 2026 03:38:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd767d5ffsm15717565e9.23.2026.05.14.03.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 03:38:10 -0700 (PDT)
From: "cron2 (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 14 May 2026 10:38:09 +0000
To: flichtenheld <frank@lichtenheld.com>,
 plaisthos <arne-openvpn@rfc2549.org>, d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ida6d4fa8c5c5ffbd7909d6afd51b1b6f32ca2d9f
X-Gerrit-Change-Number: 1674
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1674?usp=email>
X-Gerrit-Commit: 50bcb9206b1dc3100a6b20cf569c4caf9c9105e3
In-Reply-To: <gerrit.1778239616000.Ida6d4fa8c5c5ffbd7909d6afd51b1b6f32ca2d9f@gerrit.openvpn.net>
References: <gerrit.1778239616000.Ida6d4fa8c5c5ffbd7909d6afd51b1b6f32ca2d9f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MjM5NjE2MDAwLklkYTZkNGZhOGM1YzVmZmJkNzkwOWQ2YWZkNTFiMWI2ZjMyY2EyZDlmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <24c3eb539a21dcd7db8d3f889c06d66e9d1a3d13-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wNTSQ-00072d-3g
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: Address
 some uninitVariable warnings from cppcheck
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3352945555033160117=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3352945555033160117==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GwP5pEFJRoM="; charset=UTF-8

--GwP5pEFJRoM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1674?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by d12fk


Change subject: openvpnserv: Address some uninitVariable warning=
s from cppcheck
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

openvpnserv: Address some uninitVariable warnings from cppcheck

In th=
e first case this is about helping cppcheck
remember that msg->addr_len and=
 addr_len are the same
thing, but we use them in confusing ways=2E

In the =
second case there is indeed a theoretical
code path where we use an uniniti=
alized buffer=2E So
make the code safer=2E

Change-Id: Ida6d4fa8c5c5ffbd790=
9d6afd51b1b6f32ca2d9f
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Acked-by: Heiko Hund <heiko@openvpn=2Enet>
Gerrit URL: https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1674
Message-Id: <20260513150902=2E27447-1-g=
ert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg36908=2Ehtml
Signed-off-by: Gert Doering <ger=
t@greenie=2Emuc=2Ede>
---
M src/openvpnserv/interactive=2Ec
1 file changed,=
 19 insertions(+), 16 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/74/1674/3

diff --git a/src/openvpnserv/intera=
ctive=2Ec b/src/openvpnserv/interactive=2Ec
index 473a8d3=2E=2E164f1bf 1006=
44
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=
=2Ec
@@ -1868,7 +1868,7 @@
         return err; /* job done */
     }
 
-  =
  if (msg->addr_len > 0)
+    if (addr_len > 0)
     {
         /* prepare =
the comma separated address list */
         /* cannot use max_addrs here a=
s that is not considered compile
@@ -2639,25 +2639,28 @@
         free(wide=
_search_domains);
     }
 
-    /* Create address string list */
-    CHAR =
addr_list[NRPT_ADDR_NUM * NRPT_ADDR_SIZE];
-    PSTR pos =3D addr_list;
-  =
  for (int i =3D 0; i < NRPT_ADDR_NUM && addresses[i][0]; ++i)
+    if (add=
resses[0][0])
     {
-        if (i !=3D 0)
+        /* Create address stri=
ng list */
+        CHAR addr_list[NRPT_ADDR_NUM * NRPT_ADDR_SIZE];
+      =
  PSTR pos =3D addr_list;
+        for (int i =3D 0; i < NRPT_ADDR_NUM && a=
ddresses[i][0]; ++i)
         {
-            *pos++ =3D ';';
+            i=
f (i !=3D 0)
+            {
+                *pos++ =3D ';';
+            }=

+            strcpy(pos, addresses[i]);
+            pos +=3D strlen(pos);=

         }
-        strcpy(pos, addresses[i]);
-        pos +=3D strlen(po=
s);
-    }
 
-    WCHAR subkey[MAX_PATH];
-    swprintf(subkey, _countof(su=
bkey), L"OpenVPNDNSRouting-%lu", ovpn_pid);
-    err =3D SetNrptRule(nrpt_k=
ey, subkey, addr_list, wide_domains, dom_size, dnssec);
-    if (err)
-    =
{
-        MsgToEventLog(M_ERR, L"%S: failed to set rule %s (%lu)", __func_=
_, subkey, err);
+        WCHAR subkey[MAX_PATH];
+        swprintf(subkey,=
 _countof(subkey), L"OpenVPNDNSRouting-%lu", ovpn_pid);
+        err =3D Se=
tNrptRule(nrpt_key, subkey, addr_list, wide_domains, dom_size, dnssec);
+  =
      if (err)
+        {
+            MsgToEventLog(M_ERR, L"%S: failed to=
 set rule %s (%lu)", __func__, subkey, err);
+        }
     }
 
     if (d=
omains[0])

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/16=
74?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatc=
hset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ida6d4=
fa8c5c5ffbd7909d6afd51b1b6f32ca2d9f
Gerrit-Change-Number: 1674
Gerrit-Patch=
Set: 3
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer=
: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>

--GwP5pEFJRoM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1674?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by d12fk</p><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">openvpnserv: Address some =
uninitVariable warnings from cppcheck<br><br>In the first case this is abou=
t helping cppcheck<br>remember that msg-&gt;addr_len and addr_len are the s=
ame<br>thing, but we use them in confusing ways=2E<br><br>In the second cas=
e there is indeed a theoretical<br>code path where we use an uninitialized =
buffer=2E So<br>make the code safer=2E<br><br>Change-Id: Ida6d4fa8c5c5ffbd7=
909d6afd51b1b6f32ca2d9f<br>Signed-off-by: Frank Lichtenheld &lt;frank@licht=
enheld=2Ecom&gt;<br>Acked-by: Heiko Hund &lt;heiko@openvpn=2Enet&gt;<br>Ger=
rit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1674<br>Message-Id: &lt=
;20260513150902=2E27447-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg36908=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M src/openvpnserv/interactive=2Ec<br>1 file changed, 19 insertions(+), 16 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/74/1674/3</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnser=
v/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index 4=
73a8d3=2E=2E164f1bf 100644</span><br><span>--- a/src/openvpnserv/interactiv=
e=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span=
>@@ -1868,7 +1868,7 @@</span><br><span>         return err; /* job done */<=
/span><br><span>     }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (msg-&gt;addr_len &gt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (addr_len &gt; 0)</span><br><span>=
     {</span><br><span>         /* prepare the comma separated address list=
 */</span><br><span>         /* cannot use max_addrs here as that is not co=
nsidered compile</span><br><span>@@ -2639,25 +2639,28 @@</span><br><span>  =
       free(wide_search_domains);</span><br><span>     }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Create address =
string list */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CHA=
R addr_list[NRPT_ADDR_NUM * NRPT_ADDR_SIZE];</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    PSTR pos =3D addr_list;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; NRPT_ADDR_NUM &am=
p;&amp; addresses[i][0]; ++i)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (addresses[0][0])</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if (i !=3D 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        /* Create address string list=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        CHAR add=
r_list[NRPT_ADDR_NUM * NRPT_ADDR_SIZE];</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        PSTR pos =3D addr_list;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; NRPT_ADD=
R_NUM &amp;&amp; addresses[i][0]; ++i)</span><br><span>         {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            *pos++ =3D &#39;;&#=
39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if =
(i !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 *pos++ =3D &#39;;&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           strcpy(pos, addresses[i]);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            pos +=3D strlen(pos);</span><br><span>       =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strcpy(pos=
, addresses[i]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   pos +=3D strlen(pos);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    WCHAR subkey[MAX_PATH];</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    swprintf(subkey, _countof(subkey), L&quot;OpenVPNDNSRouting-=
%lu&quot;, ovpn_pid);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    err =3D SetNrptRule(nrpt_key, subkey, addr_list, wide_domains, dom_size=
, dnssec);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (err=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        MsgToEventLog(M_ERR, L&quot;=
%S: failed to set rule %s (%lu)&quot;, __func__, subkey, err);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        WCHAR subkey[MAX_PATH];<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        swprintf(sub=
key, _countof(subkey), L&quot;OpenVPNDNSRouting-%lu&quot;, ovpn_pid);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        err =3D SetNrptRu=
le(nrpt_key, subkey, addr_list, wide_domains, dom_size, dnssec);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (err)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            MsgToEventLog(M_ERR, L&quot;%=
S: failed to set rule %s (%lu)&quot;, __func__, subkey, err);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }<=
/span><br><span> </span><br><span>     if (domains[0])</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1674?usp=3Demail">change 1674</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1674?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Ida6d4fa8c5c5ffbd7909d6afd51b1b6f32=
ca2d9f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1674 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@openvpn=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC=
: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</b=
ody></html>
--GwP5pEFJRoM=--


--===============3352945555033160117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3352945555033160117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3352945555033160117==--

