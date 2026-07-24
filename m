Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDC5C531C9
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 11:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zbwcQ3XBeaXMUmDR5C/w7CxmWDOdSguAxPLxztQ/g4U=; b=bok59tO3aMjDhtbw0DokK/8Yug
	KbcUZyoDixFyErfNCkoz7VvJM6HyB2Lrg8TimW6KHwR2WQOT6+owh+aHa1sTnLtpy0EOi7uHNirpq
	DkFkla/3avVNj4+AB3d5SzEHMySJDg+5y3d4A5geOFa8NKHwaT+5yFA5asbWXQOdENrw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnEJ5-0001hS-4M;
	Fri, 24 Jul 2026 11:43:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnEJ4-0001hM-08
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 11:43:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=JNgGayLV+1IwvDoFARcZJAgrIg+x7CdFe2whxgyI/g8=; b=SyiwWDVawFTP6/tnw0s7hPD7I6
 7/IW6imUV5Yn7LUeWI9O3X83iVrJncNdoVYk+wXPoE6DWjOW+vXbRDqnyy1OD5m4d+06C29YcLTms
 CrSJL83HaRUVYQkkV5oEytw3rEI1Tq8D0lS+b0bf8ITNwFal3LmNvYOmY+iLQ64q7V78=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JNgGayLV+1IwvDoFARcZJAgrIg+x7CdFe2whxgyI/g8=; b=L
 KK5L67RIR0wzhvle7I4TxvMJie4wRs6n0RTJjZJjp6lKP06Fld6nNgjR5UrKzlw5W7FDQEkUMcItB
 dYbyhAQ+xrxlbWlr81zRTQy4NIkfb7gpzKr4RMm5+NFpM1RdCpJPucQqv5CnLaqnmG04Ew54SVhqK
 3M9eDWfd+XV1gf/o=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnEJ0-0006s8-Ta for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 11:43:10 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-47f703a9e5dso239621f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 04:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784893380; x=1785498180; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JNgGayLV+1IwvDoFARcZJAgrIg+x7CdFe2whxgyI/g8=;
 b=KQ0l0dKXbWJUjOXKORLv/irdo1ux5g6yIKSnumY6BNXh+TJtWKGSsxb6gCBmtS+adk
 cOhx5I988CLjGeVxET8PJeZbZVAX6ftva/rs1zKv4nIEBcMshQ2Qkwu2Oq++JRQO7yec
 /c43dhbQpBy12qjKUKoiqaaMiksnQ7vkgMUeoB/0aylANcx9sx6tCMD8+0Olza46Ab3e
 wtZTU7A0oe14ypTCSdi839xGncm07bFrt+MyuFjcVYrhb07RODN2lBTw4mzDmu6MU2/R
 hgDG0s0Dvfq9H4JQT1WagPCllwEvVGqazcsR075REO5UKgfY6jU2z04AQInlAeSL+uGl
 itsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784893380; x=1785498180;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JNgGayLV+1IwvDoFARcZJAgrIg+x7CdFe2whxgyI/g8=;
 b=k9TkBHd+WKfERtfL07gT+wJkWs7/jnPGLQAiZeXPgXYJa/wQSFZjYZxl1xW7vFpw1t
 wfmqtAxVDv0Oucf763/PQCfQc2yJuWIPR2LHlpSCcc7VdRbu+7oaSpcaZmHYJXHhfZqj
 KYME9EgPohOvMNAC8BgBrJ3JmbzDvcCmQTNsyi6QPJvOk6a6RQEoSuSzPwKh2zdhdv8n
 Mh44sXALbECVzQPxhJ5wcOIyDI+Us6EFjBMlOPARb3K+zAAx9kFqb4G/M1XGNcu+b4/F
 lJWiLjUSrWUSaqkm9yfuWIyb0JRu/tKBQidukGCpIdbLXxh1dfShz9t9C4zbs52RRdqR
 stbw==
X-Gm-Message-State: AOJu0YwMJkMTEjx1rhiAJxJQeKFOq+1Eaks3J82muKYFwBATr1NxeWib
 ihQ8dOabBXyB4dt7BQVQFvP95wVou8O5mN1u4kh18IDd4sg8KhpIEkLOWz30i8IzpjDL7M938aa
 asuAeC2opCNmtAf8KvquiGlizUNj0iTaSyr+bWgqtUdBIojpbHvJrYpqEh9i6pHT065FN
X-Gm-Gg: AR+sD13RSWhirImIxQZzfmmsTmtPzcgcxC0IEOQdXqP8HbahQq2EZHFPvCLQzWO/PyU
 2G7maORwroYo4D2ycUzxlZ8nS6CV2NapgfX5QhZfJHdrrJYYcxYNmjRVPBcK++urdXTrk0w4bLg
 qkNzeP3SVZ6Sj9glGBXs9D5zeafbXSp2BVNtLz+gXY733ViNHTRsZf7RRyKMPc3V0aYBHmWz8IE
 uf4DOWax5tPoY7T1TUrbr0kaod836gOapZ5tE1vOa2g88DlUkvvhHIQXcinSpbXiW63IZb7YuIZ
 6rH2Yg1D7fksaWEtdPfnvCZ269O68YddN85MN2ZJaKMMa5GBADghb3uduIHR8Aj6yr/El69tDuV
 FYIGkZb9oNKc+X92TuoVZ6KhCsBlo9Ew3aoWDdeHeL2bQ4G/JbJxTR0L9CK80MnR/6MPezI9HgR
 ureIUPdFQ1GnOGpm2jzlOi5wZVK/YsLg4rWLsE2CmNYTV0nNAlG6ckgwqZLdHaUPb4PCDXoloSO
 ud6g9PjGXRFXKH/XGdoN4mJwbLtEaET1JNq/eZL2Y5Wq25z76TRv56o9TjJGM18viX7
X-Received: by 2002:a05:6000:2c0d:b0:47d:fc23:abe8 with SMTP id
 ffacd0b85a97d-47f8d755388mr9118990f8f.28.1784893380025; 
 Fri, 24 Jul 2026 04:43:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6ef25sm21861264f8f.36.2026.07.24.04.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 04:42:59 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 24 Jul 2026 11:42:58 +0000
To: ralf_lici <ralf@mandelbit.com>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I4d0887839b4a13a92e92250d1b315dec949698f3
X-Gerrit-Change-Number: 1795
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1795?usp=email>
X-Gerrit-Commit: ea3bb67e2b1e130c90cd2b28ec5e31a455d60164
In-Reply-To: <gerrit.1784390158000.I4d0887839b4a13a92e92250d1b315dec949698f3@gerrit.openvpn.net>
References: <gerrit.1784390158000.I4d0887839b4a13a92e92250d1b315dec949698f3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzkwMTU4MDAwLkk0ZDA4ODc4MzliNGExM2E5MmU5MjI1MGQxYjMxNWRlYzk0OTY5OGYzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6d3be64111d4f553750dd986807ead316df296b4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnEJ0-0006s8-Ta
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: make key state
 desync recoverable
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1661158988199958819=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1661158988199958819==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VwjCXuL4iKc="; charset=UTF-8

--VwjCXuL4iKc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 ralf_lici=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1795?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
ordex


Change subject: dco: make key state desync recoverable
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco: make key state desyn=
c recoverable

If installing a DCO key succeeds, always record the slot in =
the
corresponding key_state=2E The installed-key counter only tracks whethe=
r
the number of kernel slots grew, but a successful KEY_NEW still means
tha=
t this key_state is associated with the selected DCO slot=2E

Also replace =
DCO key-state assertions in dco_update_keys() with error
returns=2E This pr=
eserves the invariant checks but lets the existing
caller restart the conne=
ction instead of aborting the process if
userspace ever detects inconsisten=
t DCO key state=2E

Github: OpenVPN/openvpn-private-issues#143
Reported-By:=
 Hcamael
Reported-By: =E7=AB=A0=E9=B1=BC=E5=93=A5 (www=2Eaipyaipy=2Ecom)
Ch=
ange-Id: I4d0887839b4a13a92e92250d1b315dec949698f3
Signed-off-by: Ralf Lici=
 <ralf@mandelbit=2Ecom>
Acked-by: Antonio Quartulli <antonio@mandelbit=2Eco=
m>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1795
Message-Id: =
<20260721203807=2E5813-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-a=
rchive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37732=2Ehtml
Signed=
-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/dco=2Ec
1=
 file changed, 20 insertions(+), 4 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/95/1795/4

diff --git a/src/ope=
nvpn/dco=2Ec b/src/openvpn/dco=2Ec
index e944547=2E=2E2584368 100644
--- a/=
src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -73,9 +73,12 @@
 
     int=
 ret =3D dco_new_key(multi->dco, multi->dco_peer_id, ks->key_id, slot, encr=
ypt_key, encrypt_iv,
                           decrypt_key, decrypt_iv, ci=
phername, epoch);
-    if ((ret =3D=3D 0) && (multi->dco_keys_installed < 2=
))
+    if (ret =3D=3D 0)
     {
-        multi->dco_keys_installed++;
+   =
     if (multi->dco_keys_installed < 2)
+        {
+            multi->dco_=
keys_installed++;
+        }
         ks->dco_status =3D
             (slot=
 =3D=3D OVPN_KEY_SLOT_PRIMARY) ? DCO_INSTALLED_PRIMARY : DCO_INSTALLED_SECO=
NDARY;
     }
@@ -166,7 +169,13 @@
     /* if we have a primary key, it mus=
t have been installed already (keys
      * are installed upon generation i=
n the TLS code)
      */
-    ASSERT(primary->dco_status !=3D DCO_NOT_INSTA=
LLED);
+    if (primary->dco_status =3D=3D DCO_NOT_INSTALLED)
+    {
+     =
   msg(D_DCO, "DCO key state mismatch: selected primary key is not installe=
d "
+                   "(peer_id=3D%d, key_id=3D%d, dco_keys_installed=3D%=
d)",
+            multi->dco_peer_id, primary->key_id, multi->dco_keys_inst=
alled);
+        return false;
+    }
 
     struct key_state *secondary =
=3D dco_get_secondary_key(multi, primary);
     /* if the current primary k=
ey was installed as secondary in DCO,
@@ -190,6 +199,14 @@
                =
 primary->key_id);
         }
 
+        if (secondary && secondary->dco_st=
atus !=3D DCO_INSTALLED_PRIMARY)
+        {
+            msg(D_DCO, "DCO ke=
y state mismatch: expected old primary key is not installed as DCO primary =
before swap "
+                       "(peer_id=3D%d, new_primary_key_id=3D=
%d, old_primary_key_id=3D%d, old_primary_dco_status=3D%d, dco_keys_installe=
d=3D%d)",
+                multi->dco_peer_id, primary->key_id, secondary->=
key_id, secondary->dco_status, multi->dco_keys_installed);
+            ret=
urn false;
+        }
+
         int ret =3D dco_swap_keys(dco, multi->dco_=
peer_id);
         if (ret < 0)
         {
@@ -200,7 +217,6 @@
         pri=
mary->dco_status =3D DCO_INSTALLED_PRIMARY;
         if (secondary)
       =
  {
-            ASSERT(secondary->dco_status =3D=3D DCO_INSTALLED_PRIMARY)=
;
             secondary->dco_status =3D DCO_INSTALLED_SECONDARY;
         =
}
     }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1795=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchs=
et
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4d08878=
39b4a13a92e92250d1b315dec949698f3
Gerrit-Change-Number: 1795
Gerrit-PatchSe=
t: 4
Gerrit-Owner: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: ordex =
<antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--VwjCXuL4iKc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by ralf_lici=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1795?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by ordex</p><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">dco: make key state desync =
recoverable<br><br>If installing a DCO key succeeds, always record the slot=
 in the<br>corresponding key_state=2E The installed-key counter only tracks=
 whether<br>the number of kernel slots grew, but a successful KEY_NEW still=
 means<br>that this key_state is associated with the selected DCO slot=2E<b=
r><br>Also replace DCO key-state assertions in dco_update_keys() with error=
<br>returns=2E This preserves the invariant checks but lets the existing<br=
>caller restart the connection instead of aborting the process if<br>usersp=
ace ever detects inconsistent DCO key state=2E<br><br>Github: OpenVPN/openv=
pn-private-issues#143<br>Reported-By: Hcamael<br>Reported-By: =E7=AB=A0=E9=
=B1=BC=E5=93=A5 (www=2Eaipyaipy=2Ecom)<br>Change-Id: I4d0887839b4a13a92e922=
50d1b315dec949698f3<br>Signed-off-by: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt=
;<br>Acked-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>Gerrit =
URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1795<br>Message-Id: &lt;202=
60721203807=2E5813-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email=
-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37732=2Ehtml<br>S=
igned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/=
openvpn/dco=2Ec<br>1 file changed, 20 insertions(+), 4 deletions(-)<br><br>=
</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/95/1795/4</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/dco=2Ec b/src/openvpn/=
dco=2Ec</span><br><span>index e944547=2E=2E2584368 100644</span><br><span>-=
-- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</span><b=
r><span>@@ -73,9 +73,12 @@</span><br><span> </span><br><span>     int ret =
=3D dco_new_key(multi-&gt;dco, multi-&gt;dco_peer_id, ks-&gt;key_id, slot, =
encrypt_key, encrypt_iv,</span><br><span>                           decrypt=
_key, decrypt_iv, ciphername, epoch);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if ((ret =3D=3D 0) &amp;&amp; (multi-&gt;dco_keys_insta=
lled &lt; 2))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (ret =3D=3D 0)</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        multi-&gt;dco_keys_installed++;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (multi-&gt;dco_keys_install=
ed &lt; 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            multi-&=
gt;dco_keys_installed++;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span>         ks-&gt;dco_status =3D</span><br><sp=
an>             (slot =3D=3D OVPN_KEY_SLOT_PRIMARY) ? DCO_INSTALLED_PRIMARY=
 : DCO_INSTALLED_SECONDARY;</span><br><span>     }</span><br><span>@@ -166,=
7 +169,13 @@</span><br><span>     /* if we have a primary key, it must have=
 been installed already (keys</span><br><span>      * are installed upon ge=
neration in the TLS code)</span><br><span>      */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    ASSERT(primary-&gt;dco_status !=3D DCO_NOT=
_INSTALLED);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(primary-&gt;dco_status =3D=3D DCO_NOT_INSTALLED)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        msg(D_DCO, &quot;DCO key state mismatch: selected p=
rimary key is not installed &quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                   &quot;(peer_id=3D%d, key_id=3D%d, dco_key=
s_installed=3D%d)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            multi-&gt;dco_peer_id, primary-&gt;key_id, multi-&gt;dco_k=
eys_installed);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span> </span><br><span>     struct key_state *secondary =3D =
dco_get_secondary_key(multi, primary);</span><br><span>     /* if the curre=
nt primary key was installed as secondary in DCO,</span><br><span>@@ -190,6=
 +199,14 @@</span><br><span>                 primary-&gt;key_id);</span><br=
><span>         }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (secondary &amp;&amp; secondary-&gt;dco_status !=
=3D DCO_INSTALLED_PRIMARY)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         msg(D_DCO, &quot;DCO key state mismatch: expected old primary key =
is not installed as DCO primary before swap &quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                       &quot;(peer_id=3D%d, =
new_primary_key_id=3D%d, old_primary_key_id=3D%d, old_primary_dco_status=3D=
%d, dco_keys_installed=3D%d)&quot;,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                multi-&gt;dco_peer_id, primary-&gt;key_id, =
secondary-&gt;key_id, secondary-&gt;dco_status, multi-&gt;dco_keys_installe=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retu=
rn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   =
      int ret =3D dco_swap_keys(dco, multi-&gt;dco_peer_id);</span><br><spa=
n>         if (ret &lt; 0)</span><br><span>         {</span><br><span>@@ -2=
00,7 +217,6 @@</span><br><span>         primary-&gt;dco_status =3D DCO_INST=
ALLED_PRIMARY;</span><br><span>         if (secondary)</span><br><span>    =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ASS=
ERT(secondary-&gt;dco_status =3D=3D DCO_INSTALLED_PRIMARY);</span><br><span=
>             secondary-&gt;dco_status =3D DCO_INSTALLED_SECONDARY;</span><=
br><span>         }</span><br><span>     }</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/179=
5?usp=3Demail">change 1795</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1795?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchs=
et </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: I4d0887839b4a13a92e92250d1b315dec949698f3 </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 1795 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerr=
it-Owner: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--VwjCXuL4iKc=--


--===============1661158988199958819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1661158988199958819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1661158988199958819==--

