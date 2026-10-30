Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D94A606A31D
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZiYB0RIV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lVZjo+rM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=a/1biymN;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=EoEKJJYl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ueo1zvdHc6OYY0tTyHevmwzJksWUylfM+FNhGA0wArg=; b=ZiYB0RIVHKxarldHdIo3ZkEFvs
	uE6AjFvFeRuHBMSy5vvsSmpP7EFYIM87DtzDfm0UTi0Q7L7jSFj5VV7g3IzovayDS9hjOPZDz12aC
	yc05L1M3p7C6DBfLupCyKHSP6W3/tfqrjkoXNUswDGn8e4+80IpYNKBmzTnbTHwSJHzo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMuSH-0000000024r-3evo;
	Fri, 30 Oct 2026 21:48:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMuSG-0000000024l-15vy
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 21:48:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wF3UCJEI7Fsea5+ZFRlpwKlEIcy5ReZHOlbQcq8JMrs=; b=lVZjo+rMoKwtmcvAe5kwuO3KDC
 tVV4uwAw02hzeG2m04tc42AZtvJT6ByAnLrz5SDbZiHerLNxecHLY1BIUM85+817ifeeq5R93qrVT
 IAoQdQTVqzStU4Nw5IUO1jfMOzSkruIwrvyUncgaX8mClNhiuqCH4dJGxNQV+aHTwHzI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wF3UCJEI7Fsea5+ZFRlpwKlEIcy5ReZHOlbQcq8JMrs=; b=a/1biymNrZKqJkth4Ow6gw9cls
 EMYB745sh8nKt5tpF//CIeLy7xc/EDWLEFBwmw8Ryu8/6E4DbS2/khFbt1AyMssjIOE0ShImZnsTh
 gO/UkXYUBfcNxfMVxODI90fRRjc1kC63QL87rkwJB3E1RyIjdVvl5oMlJNyamCAIp70w=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMuSF-000000000ti-1T8I for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 21:48:08 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so976564f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 14:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793396881; x=1794001681; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wF3UCJEI7Fsea5+ZFRlpwKlEIcy5ReZHOlbQcq8JMrs=;
 b=EoEKJJYlRUytXhAdQdbiupZ1yJ+SIv5W5FRR8ZZeGYUtkIYGxQPu9aAQIjIzq1cCUi
 xzkMoqVTnYHjzEzJV+buVDJEZ4oMen1Zn75kIo5RC3gNbGtqc9vdQD29S27soh27aFrB
 zklQyNh1mrqfCqOpkFXwsdqrxBH9mng+gUhWXOKPG9uhtsjDSxdHozhySYYawpI+T2fh
 iQz6BjzoSKkEvj6OEpj48f8Oy2LULFf/a+tEgPxLHx/pOVV4pUa8IcdmqmzrTfOAjrgw
 j5560s+irQs3cXjAYmO27wo01uTNEagwKwmyF3gMzdMr2JRqFdZ/RUXEd749VTXpfx7b
 d1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793396881; x=1794001681;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wF3UCJEI7Fsea5+ZFRlpwKlEIcy5ReZHOlbQcq8JMrs=;
 b=pmExkPazx1S8l3G7KTl3aEXiBRX40TXR1+hoVGr2RqLeyon9etSQ4Z8lMhxeab9D07
 IA+DMwGSV6hdxXsEg5NjAJzozys81Epie0rISwrd7J5Bnql7GsTVbC5zWLtplb7tyBXx
 V7vcdmY4QLZASx92ZmsLU1cV3iV8aBB+ZAb6ONd/G3pmSysHHUFLL/6FEHqdIo8C/qZT
 LAA3ensEqkCfD5OCkbDh8e+uDeUNX9lpHc945lRnqQozrOg0QgxPGJEiE3VNtvY/wmAK
 8l8hkkMfL7ZSHZWte9/B6H6pTvBxV3DxhIGB5m+6b3uQLSXDxjq7+EDLAckOn0LXyG1L
 Z5Bg==
X-Forwarded-Encrypted: i=1;
 AKwUvByhTDRWJHslvevXjZJQFJpTHoUz7t9LE+/984EhgCeL635LZIJ8ruwk2LtULADZJZwKAhLU0RZLeUoo5dIk@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJTpmKaMXZ715CNX7PS8qpruCokHTmREgy3j39oBvicly+Q+j7D
 i6pWJ+HQkO8x4xeRqS5TJEVwf08m58LjZXQlIVZGfcjN4W2BV/8+GQKUbQsLHbxSkMl3cxhFJOb
 1QE15rWHSXRA2TCmSbhe0TiE11wXpAX8WWrBP1iL39WDqsCikZkriccVQ/DfrJeAdTfxn
X-Gm-Gg: AYBFou1ZXqcmYDaVu3hp646nybekXz2JbQYUw32hq/bLo60GS6fZ6tiYslQXgHTYvVH
 GQa36EcQQ8bR7lUcOV3R1T4AMLjqyr0TDZD5gloP4kIbWMszpOyJ6ihDtStTKEpJUyY7USzG4Hw
 yQjaDGr3heMK6K5+532zkGSvWTYnWaaLf2XnROcnatWq53VbMysIL4YNYA50JkCqL41nenGek/o
 52myyf6MqHMaD2TAh5SxGEKF+KDY5HbxQXbRNS/l6FQJ+ZemkdiPcwCSCpP9c9NMmE62QenOghi
 XqjydoIjLjjY/evXrC+hCwnrftekyKgWWA84stzqglyKmfyTmRYZp94J/XD8UbgqyUmJH9y4axp
 HRdecLQeROqhivgLLm6IUSh2dlkUhD28eewFqYcWyd7vP2gwn9Ag76t7hqmybuDYU3GhrHXPVTB
 UoBB0vctWDt2xPtNgrcwVKXabGly0N/i2+ojx6forOcTfpKgSuYxgNriVV1uTttfGXUsWt3Lepr
 wdoEN9Wz+p3bppvyOVxzmD9Fe5zqMto9fSeIqqufEbvuAQvpcHo0IxhPlhYbyirLe7ogDTxCNoD
 jBT8uivkn0TVLDDLprDrnLj4h6reOgO2vrHjIRm1o+6TqAteEfX6eBpvOgtrhoexo9ouswJKZZJ
 g9RSsARt4JB8W0yRCE1pO7RGFTD0oUn58xDzTVhHTkqcIDobHjFO028+08jlJ6x8b7S1s5GuSk6
 W5ZJnKTSa0aGKXIy4=
X-Received: by 2002:a5d:64c4:0:b0:48b:9ed:b81f with SMTP id
 ffacd0b85a97d-48e6e2e768fmr8463630f8f.10.1793396880709; 
 Fri, 30 Oct 2026 14:48:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80ecbsm5428000f8f.35.2026.10.30.14.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:48:00 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 21:47:59 +0000
To: Heiko Hund <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib40b439ad84a08fe6d5d4407da18ed78151327e7
X-Gerrit-Change-Number: 2039
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2039?usp=email>
X-Gerrit-Commit: 5d555d00109296f9642d2a59528aeee13c5ec541
In-Reply-To: <gerrit.1793047006000.Ib40b439ad84a08fe6d5d4407da18ed78151327e7@gerrit.openvpn.net>
References: <gerrit.1793047006000.Ib40b439ad84a08fe6d5d4407da18ed78151327e7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDQ3MDA2MDAwLkliNDBiNDM5YWQ4NGEwOGZlNmQ1ZDQ0MDdkYTE4ZWQ3ODE1MTMyN2U3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8cd299aedfa0d13b73d9fbabe332c77c63429ddf-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMuSF-000000000ti-1T8I
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: plugin: detect too
 long plugin paths on Windows
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7101754009441494656=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7101754009441494656==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YVvss2+jh7s="; charset=UTF-8

--YVvss2+jh7s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2039?usp=3Demail )

Change subject: plugin: detect too long plu=
gin paths on Windows
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

plugin: detect too long plugin paths on Windows

GetFullPathNameW()=
 returns the required buffer size if the normalized
path doesn't fit=2E Thi=
s case is currently not checked, so a normalized
path longer than MAX_PATH =
left the buffer empty and the plugin was
then rejected with the misleading =
message that it is not located in
a trusted directory=2E

Treat a return va=
lue that does not fit into the buffer as failure, so
that the error says th=
at the path could not be normalized=2E Since
GetFullPathNameW() sets no err=
or code, set ERROR_FILENAME_EXCED_RANGE
manually before logging=2E

Change-=
Id: Ib40b439ad84a08fe6d5d4407da18ed78151327e7
Signed-off-by: Heiko Hund <he=
iko@ist=2Eeigentlich=2Enet>
Acked-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2039
Message=
-Id: <20261027130028=2E2220-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Em=
ail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40215=2Ehtml
S=
igned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/plug=
in=2Ec
1 file changed, 7 insertions(+), 1 deletion(-)




diff --git a/src/=
openvpn/plugin=2Ec b/src/openvpn/plugin=2Ec
index a94f07b=2E=2E9826510 1006=
44
--- a/src/openvpn/plugin=2Ec
+++ b/src/openvpn/plugin=2Ec
@@ -284,8 +284=
,14 @@
     WCHAR *wpath =3D wide_string(p->so_pathname, &gc);
     WCHAR n=
ormalized_plugin_path[MAX_PATH] =3D { 0 };
     /* Normalize the plugin pat=
h, converting any relative paths to absolute paths=2E */
-    if (!GetFullP=
athNameW(wpath, MAX_PATH, normalized_plugin_path, NULL))
+    DWORD len =3D=
 GetFullPathNameW(wpath, _countof(normalized_plugin_path), normalized_plugi=
n_path, NULL);
+    if (len =3D=3D 0 || len >=3D _countof(normalized_plugin=
_path))
     {
+        /* GetFullPathNameW() sets no error code if the buf=
fer is too small */
+        if (len !=3D 0)
+        {
+            SetLas=
tError(ERROR_FILENAME_EXCED_RANGE);
+        }
         msg(M_ERR, "PLUGIN_=
INIT: could not load plugin DLL: %ls=2E Failed to normalize plugin path=2E"=
,
             wpath);
     }

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2039?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: Ib40b439ad84a08fe6d5d4407da18ed78151327e7
Gerrit-Change-Number: =
2039
Gerrit-PatchSet: 2
Gerrit-Owner: Heiko Hund <heiko@openvpn=2Enet>
Gerr=
it-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Fra=
nk Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Lev Stipakov <lst=
ipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>

--YVvss2+jh7s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2039?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">plugin: detect too long plugin pat=
hs on Windows<br><br>GetFullPathNameW() returns the required buffer size if=
 the normalized<br>path doesn&#39;t fit=2E This case is currently not check=
ed, so a normalized<br>path longer than MAX_PATH left the buffer empty and =
the plugin was<br>then rejected with the misleading message that it is not =
located in<br>a trusted directory=2E<br><br>Treat a return value that does =
not fit into the buffer as failure, so<br>that the error says that the path=
 could not be normalized=2E Since<br>GetFullPathNameW() sets no error code,=
 set ERROR_FILENAME_EXCED_RANGE<br>manually before logging=2E<br><br>Change=
-Id: Ib40b439ad84a08fe6d5d4407da18ed78151327e7<br>Signed-off-by: Heiko Hund=
 &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>Acked-by: Frank Lichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2039<br>Message-Id: &lt;20261027130028=2E2220-1-gert@greenie=2Emuc=
=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg40215=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/plugin=2Ec<br>1 file changed, 7=
 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/plu=
gin=2Ec b/src/openvpn/plugin=2Ec</span><br><span>index a94f07b=2E=2E9826510=
 100644</span><br><span>--- a/src/openvpn/plugin=2Ec</span><br><span>+++ b/=
src/openvpn/plugin=2Ec</span><br><span>@@ -284,8 +284,14 @@</span><br><span=
>     WCHAR *wpath =3D wide_string(p-&gt;so_pathname, &amp;gc);</span><br><=
span>     WCHAR normalized_plugin_path[MAX_PATH] =3D { 0 };</span><br><span=
>     /* Normalize the plugin path, converting any relative paths to absolu=
te paths=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(!GetFullPathNameW(wpath, MAX_PATH, normalized_plugin_path, NULL))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD len =3D GetFullPat=
hNameW(wpath, _countof(normalized_plugin_path), normalized_plugin_path, NUL=
L);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (len =3D=
=3D 0 || len &gt;=3D _countof(normalized_plugin_path))</span><br><span>    =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* GetFul=
lPathNameW() sets no error code if the buffer is too small */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (len !=3D 0)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            SetLastError(ERROR_FILENAME=
_EXCED_RANGE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span>         msg(M_ERR, &quot;PLUGIN_INIT: could not load =
plugin DLL: %ls=2E Failed to normalize plugin path=2E&quot;,</span><br><spa=
n>             wpath);</span><br><span>     }</span><br></pre><p>To view, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2039?usp=3Demail=
">change 2039</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
039?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: Ib40b439ad84a08fe6d5d4407da18ed78151327e7 </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 2039 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko =
Hund &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Lev Stipak=
ov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

=
</body></html>
--YVvss2+jh7s=--


--===============7101754009441494656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7101754009441494656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7101754009441494656==--

