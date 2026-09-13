Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B010C88E65
	for <openvpn-devel@archiver.kernel.org>; Sun, 13 Sep 2026 13:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n1qC2PxiBgiX/qPfdyZ/QyDvH2wi0ah0HEpiaBUB7ac=; b=VZXrsLQC3ZRTosvwtHu+EJAqAl
	nsmCGgiIckK5SvuozWUmkcsYzK+vT2KNwTIRZQUlUnYzC73MdtiChWY9HmL6cW6MJkeynJK91Lj72
	YKwqlkeYe6XTMRVN94Ug2g5y+PyjBn//lcc43K1Io2n1v706BttKP7u9RmrCCvLAgjo4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5k1S-000572-Ix;
	Sun, 13 Sep 2026 13:13:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x5k1P-00056v-Jg
 for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 13:13:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=K2XLRK2+t6ClqP7ARUYRcKgUUUMEZgiklKK2tSJcgMo=; b=FfY+KflPfvOheJEPcuglDbAI+n
 fpBPfUVLofI7lpoS4z7VVfawRoPzz/A2PGAzVBPJsbumYHXIaXHBPHifw+6FVqjDa44QaF16Ec9PN
 HOYHDebC3XkyyOBKtLEHbbJ4GMUBOxWDcXXdWHjYG9bqwWNe0kmg+1vH0Y+4BAhtYTi4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=K2XLRK2+t6ClqP7ARUYRcKgUUUMEZgiklKK2tSJcgMo=; b=i
 cFioNnuGkon0izigaPIgFOkSYD2eLNJ91y7FRReTVaXJ6qdMPUHoifnC2Ja1hzZ7ci2WNFucwGc8p
 KFgPylsT4TkQusiQo027OF3hgeBwBsk+QFh7QsUSAMCQTx34SQ9x72QXUiiRNEgzbtG3swJvHmIRM
 6Xl3kBRoylTWzg2E=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x5k1P-0000a5-CQ for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 13:13:28 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ccff31419so9249775e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 13 Sep 2026 06:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789305201; x=1789910001; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=K2XLRK2+t6ClqP7ARUYRcKgUUUMEZgiklKK2tSJcgMo=;
 b=QBF8YOgIlKUl0QaN1PnpDHr3PUQJP5UKRxEmdT+aDYEc+tiUMBg2i704e/l9+GLy6F
 Aqvpm0+bEtmoB87t5CJwBuTjYO4C44G14pYOLDLngXtcB45BfM0a2z2f7rJebfvdEef9
 g4ZFZaHRgHfhrb/BVBN9yVh8kn5GTGfTZNtUXVdhViGkdzGcIPxEf5LUuX1+ksKuYhIU
 OxWrP/EibbZUGEOoAy0X1LQAApni7O62gZc795DEy7fRW/ITQVRiLaSm8j0ZbTg4zh1K
 HknX4iJr3uqpWdYiAXZZN/675vonGCHV/11f7RHdFjMkCw6uw1cW5zoQrz0MYmZ+FDCC
 FfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789305201; x=1789910001;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=K2XLRK2+t6ClqP7ARUYRcKgUUUMEZgiklKK2tSJcgMo=;
 b=NaQsqCJZ7ERLX+Dt/dqrOPbIJ7ocEXv5mzjHGZqY6xHsL8/4AqB8LLVPKaayEQc8OF
 6ZqsY+tosTknZs+FsVoQCxv4T3Na+NnDiZTxptsim764ejBEAsED5cbrTqFFF6lYdnp5
 Pa/zuuuWwK1ENmMuREpyI0GVPntZxJeeXLW9rMoy0U5jpbq6FMe+sob6V0jQ4LUJ6tXX
 5n730uehtRlaU2lT4yOQtTyqbRNfGDrx98N/g12pIkQ3fH4mE0jPkHJ7UhrM1NJEW+H+
 IRUuU9C7V0b6VvyR3K+ugu0Xn+8MDOJKFfmejJ4Lu9T2ViWNwNzaEYFn2ADjULwkDwy0
 yPQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbzTGTd9TUu20L7zXgnryq4o5NWM92U6pUmkD0rJHPhabd+Fd0TgdN7QnXX4AZqT1XuXplDtECIcy7mLio@lists.sourceforge.net
X-Gm-Message-State: AFuF++mNN2d1yTwWmnnaI43Z3guBL+ac2MjTnSdltjDnaAv4h3KFYGHk
 IYFeN6zmgiPqcJ6A3tJlLZGAvABpe28yGGZ1ZtsY3pt1cftLC3zKySMd8qKapuc0AxovD109wQt
 QSr86jmAdX55+sfcIZ1z4M+obwJZPVuHnxCSMaC1wvqmLMeFJ7bME6PN/cbEwomy6w8JGUxodfN
 WVBaF6OA==
X-Gm-Gg: AYBFou2fDbRcuciuCfTEPUb9kUkyLwLxOdrd+hnyBSgiXLsakBrBfoiVDFL0RGw7yHU
 P4kbOCS2bDuHpA09qBVSZlP5Uegznlvi090geoOUrmGgkaLTzzw598VR+kOrVgYLs8YaTcBAQ4J
 ic9d3WL+GfmN0SnNrVUCpUyjM3ATT5a3CYbQxLaBH6LrfsmWQpABEUVIlUbFQvVPVEFATz3DPRR
 GxGcnQASXyqX5AObWDo/zCry02YuKKBi7jJodd2d4gu8udL/xwnrPgT4IYvTzKg3qNTJ8tPz7fv
 RxbIeGhhrB3JlSuIGRiY1qJRxBMRXqU9PhkNd5YCQUwQ1rxgI5BTVZAvtqY8o3QD6HNZA/B9QHB
 Y2CDUrsdWHUktD7WAnMdcp/VET+e7uoKEow7IIUe0rE/YIT71yGk8bK4EDox+FLPd5OfHDlxPkz
 ftEnPl8sdAaFW9/zjnU1szV9m0huaALVixM3yTghi1Vo5Rt4iIAOq9u0vGqU/4mISvEMOS1AR47
 kIWTwQwuCwe5V8+6KyJZdPkVdijXVm3J1jhcWHYKJupDsZdHDNJShIqMzT243KQ3YhbdT4mkvlj
 R7XmMRl1F0DESRa37mel4VnsvtdrLIM7/9DnNXH/wzzznRIuC/2X/DotyxFbufoHK/Yx9Wzl
X-Received: by 2002:a05:600c:3554:b0:49c:fa21:1c81 with SMTP id
 5b1f17b1804b1-49e6cbfbfb1mr57364805e9.22.1789305200668; 
 Sun, 13 Sep 2026 06:13:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb34f1f7sm19464810f8f.24.2026.09.13.06.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 06:13:20 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 13 Sep 2026 13:13:18 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3724236d4acc3d05d786274d6baf34a21c570594
X-Gerrit-Change-Number: 1914
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1914?usp=email>
X-Gerrit-Commit: 9115e6dbe9f30a0b4f23da3789328cb193c13150
In-Reply-To: <gerrit.1789291650000.I3724236d4acc3d05d786274d6baf34a21c570594@gerrit.openvpn.net>
References: <gerrit.1789291650000.I3724236d4acc3d05d786274d6baf34a21c570594@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5MjkxNjUwMDAwLkkzNzI0MjM2ZDRhY2MzZDA1ZDc4NjI3NGQ2YmFmMzRhMjFjNTcwNTk0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a8df8de99851fc26cd691b1d34f52efc931980fd-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x5k1P-0000a5-CQ
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: fix
 unsigned underflow when clearing domain_search_list
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
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3069475414132265238=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3069475414132265238==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qy/3JNc8wDc="; charset=UTF-8

--qy/3JNc8wDc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos=2E

Hello plaisthos,=
 

I'd like you to reexamine a change=2E Please visit

    http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1914?usp=3Demail

to look at the new patch set (#=
2)=2E


Change subject: options: fix unsigned underflow when clearing domai=
n_search_list
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


options: fix unsigned underflow when clearing domain_search_list

remove_=
option() and update_option() clear the domain search list with

    while (=
o->domain_search_list_len-- > 0)

domain_search_list_len is unsigned, and t=
he post-decrement runs on the
final test too=2E When the length reaches 0 t=
he condition is false but
the decrement has already wrapped it to UINT_MAX,=
 so the field is left
corrupted=2E The next reset then does

    o->domain_=
search_list[UINT_MAX] =3D NULL

and walks far out of bounds, writing NULL t=
hrough each slot=2E A server
can drive this reset path against a client wit=
h PUSH_UPDATE, so on
Windows and Android this is a remotely reachable out-o=
f-bounds write=2E

v2:
  Change to the semantics used for all the other lis=
ts there - set
  length to 0 and clear the list with CLEAR()=2E

Change-Id:=
 I3724236d4acc3d05d786274d6baf34a21c570594
Signed-off-by: Cole Munz <Munzzy=
y1@proton=2Eme>
Github: OpenVPN/openvpn-private-issues#178
CVE: 2026-88964
=
---
M src/openvpn/options=2Ec
1 file changed, 6 insertions(+), 8 deletions(=
-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/14/=
1914/2

diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
inde=
x 25a3746=2E=2Ef6a5fe4 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openv=
pn/options=2Ec
@@ -3778,12 +3778,12 @@
         memset(o->ntp, 0, sizeof(o-=
>ntp));
         o->nbdd_len =3D 0;
         memset(o->nbdd, 0, sizeof(o->n=
bdd));
-        while (o->domain_search_list_len-- > 0)
-        {
-       =
     o->domain_search_list[o->domain_search_list_len] =3D NULL;
-        }
=
+        o->domain_search_list_len =3D 0;
+        CLEAR(o->domain_search_l=
ist);
         o->disable_nbt =3D 0;
         o->dhcp_options =3D 0;
+     =
   CLEAR(options->dns_options=2Efrom_dhcp);
+
 #if defined(TARGET_ANDROID)
=
         o->http_proxy_port =3D 0;
         o->http_proxy =3D NULL;
@@ -408=
2,10 +4082,8 @@
             CLEAR(o->ntp);
             o->nbdd_len =3D 0;=

             CLEAR(o->nbdd);
-            while (o->domain_search_list_len=
-- > 0)
-            {
-                o->domain_search_list[o->domain_sea=
rch_list_len] =3D NULL;
-            }
+            o->domain_search_list_l=
en =3D 0;
+            CLEAR(o->domain_search_list);
             o->disabl=
e_nbt =3D 0;
             o->dhcp_options =3D 0;
 

-- 
To view, visit http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1914?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I3724236d4acc3d05d786274d6baf34a21c570594=

Gerrit-Change-Number: 1914
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@gr=
eenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC=
: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>

--qy/3JNc8wDc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos=2E </p>
<p>cron2 <strong>uploaded pa=
tch set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1914?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">op=
tions: fix unsigned underflow when clearing domain_search_list<br><br>remov=
e_option() and update_option() clear the domain search list with<br><br>   =
 while (o-&gt;domain_search_list_len-- &gt; 0)<br><br>domain_search_list_le=
n is unsigned, and the post-decrement runs on the<br>final test too=2E When=
 the length reaches 0 the condition is false but<br>the decrement has alrea=
dy wrapped it to UINT_MAX, so the field is left<br>corrupted=2E The next re=
set then does<br><br>    o-&gt;domain_search_list[UINT_MAX] =3D NULL<br><br=
>and walks far out of bounds, writing NULL through each slot=2E A server<br=
>can drive this reset path against a client with PUSH_UPDATE, so on<br>Wind=
ows and Android this is a remotely reachable out-of-bounds write=2E<br><br>=
v2:<br>  Change to the semantics used for all the other lists there - set<b=
r>  length to 0 and clear the list with CLEAR()=2E<br><br>Change-Id: I37242=
36d4acc3d05d786274d6baf34a21c570594<br>Signed-off-by: Cole Munz &lt;Munzzyy=
1@proton=2Eme&gt;<br>Github: OpenVPN/openvpn-private-issues#178<br>CVE: 202=
6-88964<br>---<br>M src/openvpn/options=2Ec<br>1 file changed, 6 insertions=
(+), 8 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/14/1914/2</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/ope=
nvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 25a3746=2E=
=2Ef6a5fe4 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><=
span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -3778,12 +3778,12 @@<=
/span><br><span>         memset(o-&gt;ntp, 0, sizeof(o-&gt;ntp));</span><br=
><span>         o-&gt;nbdd_len =3D 0;</span><br><span>         memset(o-&gt=
;nbdd, 0, sizeof(o-&gt;nbdd));</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        while (o-&gt;domain_search_list_len-- &gt; 0)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            o-&gt;domain_search_list[o-&gt;dom=
ain_search_list_len] =3D NULL;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       o-&gt;domain_search_list_len =3D 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        CLEAR(o-&gt;domain_search_list);</span><br><=
span>         o-&gt;disable_nbt =3D 0;</span><br><span>         o-&gt;dhcp_=
options =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   CLEAR(options-&gt;dns_options=2Efrom_dhcp);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> #if defined(TARGET_ANDROID)</s=
pan><br><span>         o-&gt;http_proxy_port =3D 0;</span><br><span>       =
  o-&gt;http_proxy =3D NULL;</span><br><span>@@ -4082,10 +4082,8 @@</span><=
br><span>             CLEAR(o-&gt;ntp);</span><br><span>             o-&gt;=
nbdd_len =3D 0;</span><br><span>             CLEAR(o-&gt;nbdd);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            while (o-&gt;domain_s=
earch_list_len-- &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           o-&gt;domain_search_list[o-&gt;domain_search_list_len] =3D NULL;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            o-&gt;domain_se=
arch_list_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            CLEAR(o-&gt;domain_search_list);</span><br><span>             =
o-&gt;disable_nbt =3D 0;</span><br><span>             o-&gt;dhcp_options =
=3D 0;</span><br><span> </span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1914?usp=3Demail">cha=
nge 1914</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1914?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I3724236d4acc3d05d786274d6baf34a21c570594 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1914 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &l=
t;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razv=
anc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</bo=
dy></html>
--qy/3JNc8wDc=--


--===============3069475414132265238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3069475414132265238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3069475414132265238==--

