Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA82C79FAD
	for <openvpn-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z8hZHru1QXp+uf87Lsx12lJqG56sbcDq3ceTJLvfZgM=; b=YoApyWsInCt1zdh/fi/bV3fC40
	JNY7XIB6t5mP3GVrT69NsK3PYl+JHQJsVcZ9mBAxABsiqXjEQwkjQDSfBZzGCSnE5SvrUBb7gZbze
	4HwMVJrK1d+qvxPQ24on8SMi0H62CtJZqGIn3nm7A/s4j8C6krboHFQwpz2An+FQs+Ys=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4IJ1-0007N8-Vr;
	Wed, 09 Sep 2026 13:25:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4IJ0-0007N0-Oh
 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 13:25:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=VAW0zcED1n6EeVpLZUVvjybUdynI1Ifaag7foT+NpD8=; b=ahPvZ4WIKb8y/dLHDCL+aaohDL
 8wTyJbUEKZKaoP2dYRu3pb87QbzB3QHl2k8QHkWOL4ZkBvfEB1tmmGT0BcKiYo9LXaP6C2v8Lzwoo
 YY/es6RtMOzZz9BqnjHKrio/ZYvScGUxuX/2UG/svJ0iivGH905fPL6G9/DX6U4x5qMI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VAW0zcED1n6EeVpLZUVvjybUdynI1Ifaag7foT+NpD8=; b=N
 oHqasiVh3CEy6u0r7lfLj1WmiVCysDeZdOqny0Bpyov4Omfw9sC1/ajzW4SLF7bbD4g0H+KgEHHsv
 QxZusnmEJDv6UxgLu3E5JNZGZT4zrfDb0aK/4FlNeK2Q9Ovh/n+m8hKhyWrDq/pQafEInPtOBOTzk
 ShWrmqESc6tpsmlo=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4IIx-0002A9-Bp for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 13:25:36 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-49b0d78a801so58212395e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 06:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788960329; x=1789565129; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VAW0zcED1n6EeVpLZUVvjybUdynI1Ifaag7foT+NpD8=;
 b=NaWA/z9nEycNDgSGaw6ORSxby7UGVDlLIsX/Z+BW/B1pt3nLkUPnfoiB7veAoOGcXw
 oBaHK4FVXYR9ypXEyB4iC00dN4QHK1sAAjA9MvgUrWwMpwFvqmUYjGy0Mv+5E52KceQ1
 m5KzzVzr7BrKbK3yGphTFdzfz4HVXGWLCu1XkXcsYmGjpqzbTIgx2AUCHb2vwIyaqIon
 /bXO8Dw7up5In5dsJurPCUNMVAluMU9XzD+E7rtfFdm3LYKEPDGbfh3+3Ea013qFfjJx
 GsmhuWpzA9/hDmiS4LD6td8g9YUsWjVJK0UdUP3aGgAEFIZ7I6NGwYnYzqMUGpFTu6iu
 K8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788960329; x=1789565129;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VAW0zcED1n6EeVpLZUVvjybUdynI1Ifaag7foT+NpD8=;
 b=OlJ4ZMmnRxvsW+Zbm8MCJQuKBGRJSvYe/CFIKX1O+ubpsgypAqjt1GhBa58BACNiu0
 dkGjTAsVf5pSy5kXD14BaYKU1c20r6Mufa8nBIDtZcfj4hCO+cn08Gw+SxashWuqh4s2
 3k7aT7iyG5HhCB1VcWrZR7GHw8skmoPvLl3NeiWE4iyqWS2+D8dlT/yyDBnoqiRyyQ1M
 nnQ50uOUMY6MkAEzkVD+cCa8iI8M6RwwsTEkkE+em/pKH6UM2MC6iLVjo06D3U8KZeNu
 uJBc8aaelN3EIMkOduQRmk4iy3hWNR2TGkbet73jr+t3OWV2zZsDjtO3s7EnChoilrNF
 94qw==
X-Gm-Message-State: AFuF++k5jv0heukEtn5UrmVWVf9snGof490nkShoumub1mVuOY/hLMVq
 SWio5LIo5H+n2swQHnPP1ZLhCqniLrceeSZwc3GkMNT9pVu0YoStKmQxhtl9WB95UVGAhQ3yU9j
 f8rDjualcSLYyME3mvDeEXW4UeHfhPkernQxuZuAGUYF9d+WTX0LMbm43RAM/CrLBwcmdfrADu4
 JczmkqfQ==
X-Gm-Gg: AYBFou11cvJMSdIRyMjNVXWvBPYvM9OAGc89hE6qUFshCQySyJ2bCO/trjbMabUfj0f
 I9DePYY4nSL5CdEFuw25wFFgrY5gLRRtmwmCtWphBkulre2P8Qcb8auUD19DNh/lj67MIPrF6NH
 HU6KLo3YhNYe8CBoJygeNEukXEO8EcSrbtLBfyqdrNp/x4eFfHTMYBOunb8MekSOHbgS6RNIpwO
 zObaLdIVkqmbQ0HpT9gfj3AaFhb7LcGTN7P9JVq32o16k0YqK5mrdg64H3y7LOUZ6QWq328L7vd
 ojiufnKXN7Ck5xFJUErqJJ5plgu+PXZoLhRWL+pbBzzkTc3zee24gL1piShIKhqo4r8LvS1DLs9
 cB4dEaIhBobp5DN0IJJbBkWsYLF7TxeKxaC/59xUMm3B9xqNLO/WSD/eqaTst7Hf6qoMYVv21Xg
 MPxtUw1PmXuDaAZVNIW0YivTgxtqc2nLRmxJBMh4OkRQJVWTKf/NXmHA4zREXtU1fj+ygXanLfk
 1bQE9BU1T4KvvL70jEhELeXdNvGUop5x3rJtbvvO3Ze9v8vc23CdVdViGq6aaxM6Q0wzKf+ZhmI
 JAzgaKlzKGOQwfYPacaQ7WHIa4npfJT34Bsp0e1PXxRymkAcxzWc9qHvLCLU8Q==
X-Received: by 2002:a05:600c:c494:b0:49d:286:83d5 with SMTP id
 5b1f17b1804b1-49d028683f3mr279342255e9.13.1788960328554; 
 Wed, 09 Sep 2026 06:25:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d08144037sm388660785e9.7.2026.09.09.06.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 06:25:28 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 9 Sep 2026 13:25:26 +0000
To: d12fk <heiko@openvpn.net>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182
X-Gerrit-Change-Number: 1907
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1907?usp=email>
X-Gerrit-Commit: a453210da741209545b1b6d026a6487151789341
In-Reply-To: <gerrit.1788885240000.Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182@gerrit.openvpn.net>
References: <gerrit.1788885240000.Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODg1MjQwMDAwLkljOTgzYTNiZjFlZThkNGVmOThmMzg4M2Q1ZTVkZGYyMzQ2OTZhMTgyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <332e55e9273b447659bc09d9b555c3c612899d63-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4IIx-0002A9-Bp
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: openvpnserv:
 harden CheckConfigPath() a bit more
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
From: "MaxF \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1201907746256160386=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1201907746256160386==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ho3zLE07cv0="; charset=UTF-8

--Ho3zLE07cv0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, d12fk, plaisthos, razvanc=2E

=
Hello cron2, d12fk, plaisthos, razvanc, 

I'd like you to reexamine a chang=
e=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1907?usp=
=3Demail

to look at the new patch set (#3)=2E


Change subject: openvpnser=
v: harden CheckConfigPath() a bit more
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: harden CheckConfigPath() a bit more
=

If the config_path retrieved from the Registry doesn't end with a path
sep=
atator, the prefix check could be satisfied by a sibling directory
that sta=
rts with the same substring, e=2Eg=2E "config" vs=2E "configx"=2E While
cod=
e in common=2Ec ensures this, that code could disappear in the future
leavi=
ng the check vulnerable=2E Instead spend the few CPU cycles to be
absolutel=
y sure, we're doing the right thing here=2E

Discovered and reported by Bre=
achX Zero Day Labs, using Typhon AI Mil v2=2E
Contributing Researcher: Vive=
k Parikh=2E

Reported-by: Vivek Parikh <vivek=2Eparikh@breachx=2Eai>
Tested=
-by: Vivek Parikh <vivek=2Eparikh@breachx=2Eai>
CVE: 2026-78043
Change-Id: =
Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182
Signed-off-by: Heiko Hund <heiko@=
ist=2Eeigentlich=2Enet>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
A=
cked-by: Arne Schwabe <arne@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1886
Message-Id: <20260831184709=2E3359-1-gert@green=
ie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2E=
sourceforge=2Enet/msg38854=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
(cherry picked from commit 588af513aac1d2d774fd3fde1716384e350=
1a5a1)
---
M src/openvpnserv/validate=2Ec
1 file changed, 7 insertions(+), =
4 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/07/1907/3

diff --git a/src/openvpnserv/validate=2Ec b/src/openvpn=
serv/validate=2Ec
index a59f9b1=2E=2E0f3a1ab 100644
--- a/src/openvpnserv/v=
alidate=2Ec
+++ b/src/openvpnserv/validate=2Ec
@@ -65,8 +65,14 @@
 {
     W=
CHAR tmp[MAX_PATH];
     const WCHAR *config_file =3D NULL;
-    const WCHA=
R *config_dir =3D NULL;
+    const WCHAR *config_dir =3D s->config_dir;
+  =
  size_t config_dir_len =3D wcslen(config_dir);
 
+    /* config_dir must e=
nd with a '\' or the prefix check below could be satisfied by a sibling dir=
ectory */
+    if (config_dir_len =3D=3D 0 || s->config_dir[config_dir_len =
- 1] !=3D L'\\')
+    {
+        return FALSE;
+    }
     /* fname =3D std=
in is special: do not treat it as a relative path */
     if (wcscmp(fname,=
 L"stdin") =3D=3D 0)
     {
@@ -88,9 +94,6 @@
         config_file =3D fnam=
e;
     }
 
-    config_dir =3D s->config_dir;
-    size_t config_dir_len =
=3D wcslen(config_dir);
-
     /* check for a path separator after config_d=
ir */
     if (config_dir_len && config_dir_len < wcslen(config_file)
     =
    && config_dir[config_dir_len - 1] !=3D L'\\'

-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1907?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-B=
ranch: release/2=2E6
Gerrit-Change-Id: Ic983a3bf1ee8d4ef98f3883d5e5ddf23469=
6a182
Gerrit-Change-Number: 1907
Gerrit-PatchSet: 3
Gerrit-Owner: MaxF <max=
@max-fillinger=2Enet>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerr=
it-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@=
greenie=2Emuc=2Ede>
Gerrit-Attention: d12fk <heiko@openvpn=2Enet>
Gerrit-At=
tention: razvanc <razvanc@mailbox=2Eorg>

--Ho3zLE07cv0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, d12fk, plaisthos, razvanc=2E </p>
<p>MaxF <str=
ong>uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1907?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">openvpnserv: harden CheckConfigPath() a bit more<br><br>If the=
 config_path retrieved from the Registry doesn&#39;t end with a path<br>sep=
atator, the prefix check could be satisfied by a sibling directory<br>that =
starts with the same substring, e=2Eg=2E &quot;config&quot; vs=2E &quot;con=
figx&quot;=2E While<br>code in common=2Ec ensures this, that code could dis=
appear in the future<br>leaving the check vulnerable=2E Instead spend the f=
ew CPU cycles to be<br>absolutely sure, we&#39;re doing the right thing her=
e=2E<br><br>Discovered and reported by BreachX Zero Day Labs, using Typhon =
AI Mil v2=2E<br>Contributing Researcher: Vivek Parikh=2E<br><br>Reported-by=
: Vivek Parikh &lt;vivek=2Eparikh@breachx=2Eai&gt;<br>Tested-by: Vivek Pari=
kh &lt;vivek=2Eparikh@breachx=2Eai&gt;<br>CVE: 2026-78043<br>Change-Id: Ic9=
83a3bf1ee8d4ef98f3883d5e5ddf234696a182<br>Signed-off-by: Heiko Hund &lt;hei=
ko@ist=2Eeigentlich=2Enet&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt;<br>Acked-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Gerri=
t URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1886<br>Message-Id: &lt;2=
0260831184709=2E3359-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Ema=
il-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38854=2Ehtml<br=
>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>(cherry pic=
ked from commit 588af513aac1d2d774fd3fde1716384e3501a5a1)<br>---<br>M src/o=
penvpnserv/validate=2Ec<br>1 file changed, 7 insertions(+), 4 deletions(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/07/1907/3</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/validate=2E=
c b/src/openvpnserv/validate=2Ec</span><br><span>index a59f9b1=2E=2E0f3a1ab=
 100644</span><br><span>--- a/src/openvpnserv/validate=2Ec</span><br><span>=
+++ b/src/openvpnserv/validate=2Ec</span><br><span>@@ -65,8 +65,14 @@</span=
><br><span> {</span><br><span>     WCHAR tmp[MAX_PATH];</span><br><span>   =
  const WCHAR *config_file =3D NULL;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    const WCHAR *config_dir =3D NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const WCHAR *config_dir =3D s-&gt;con=
fig_dir;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t =
config_dir_len =3D wcslen(config_dir);</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* config_dir must end with a &#39=
;\&#39; or the prefix check below could be satisfied by a sibling directory=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (config_d=
ir_len =3D=3D 0 || s-&gt;config_dir[config_dir_len - 1] !=3D L&#39;\\&#39;)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return FALSE;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     /* f=
name =3D stdin is special: do not treat it as a relative path */</span><br>=
<span>     if (wcscmp(fname, L&quot;stdin&quot;) =3D=3D 0)</span><br><span>=
     {</span><br><span>@@ -88,9 +94,6 @@</span><br><span>         config_fi=
le =3D fname;</span><br><span>     }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    config_dir =3D s-&gt;config_dir;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t config_dir_len =
=3D wcslen(config_dir);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span>     /* check for a path separator after config_dir */</=
span><br><span>     if (config_dir_len &amp;&amp; config_dir_len &lt; wcsle=
n(config_file)</span><br><span>         &amp;&amp; config_dir[config_dir_le=
n - 1] !=3D L&#39;\\&#39;</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1907?usp=3Demail">ch=
ange 1907</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1907?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: release/2=2E6 </div>
<div style=3D"display:none"> G=
errit-Change-Id: Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182 </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 1907 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner=
: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &=
lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body=
></html>
--Ho3zLE07cv0=--


--===============1201907746256160386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1201907746256160386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1201907746256160386==--

