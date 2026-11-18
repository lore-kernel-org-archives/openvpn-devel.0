Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0E7606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Nb3euApz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NKgYRT4T;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MTHfkip9;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=MoxmZnSL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tfLZnB+Z8c9Pc2SZkmDFsvXO8m4CFijY5Y+Id/0uhWw=; b=Nb3euApzstqNvC5XqGqSKjNRMw
	2DgYwtoJmu6qK8iHAEaYE8huHqoIDbfpg8tXvechUilAMrygzw/4ePNnJMldjxc2uonj2KqP03g46
	fEnjHUXArHzVUBac0Oe+jRdzaPdRmYnigO/F/los2Id6GpXiESKYgV8bVGEYq0LIlxh0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTdQ6-000000008Cb-2rlU;
	Wed, 18 Nov 2026 11:01:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTdQ4-000000008CU-0JEt
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 11:01:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O/2YRAStFdQgm6FRhUExNOF8OoVL5JRZS8Jkyh6epeo=; b=NKgYRT4TomY+MZgMWfFJxjChsR
 kFKCBHz8FW1giYRD+pUa/8F6UMcpsUKFqDUi4UXMLOmb2po4HWkkpfjzGwqqjSty9XJJ8V+5F6oSv
 JP2SweVu7A5KuZRhunAdrNWRkLDMybu817/4y1NYSy5XWo9q4QbLmDS1T6hcvyQkOeNI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O/2YRAStFdQgm6FRhUExNOF8OoVL5JRZS8Jkyh6epeo=; b=MTHfkip9Nv5RTfyp+aqMKlpgsN
 mOi9RgP8+Skll9ZjLd33F/b7csrLSoTCu3yAwiNpYFZpd2peuVQBGJpLLYSnDbSKfVktATXz1tljj
 zVWTjOYEVnwK6buK08Rjmjl1LWtTiWYWoz4kkW7xsnYFkGGzkHdQ54uAHm44r+5tOabE=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTdQ2-0000000073K-1Hyl for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 11:01:39 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so8421505e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 03:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794999692; x=1795604492; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=O/2YRAStFdQgm6FRhUExNOF8OoVL5JRZS8Jkyh6epeo=;
 b=MoxmZnSLXZSEadRWZTT2rOLXvVjDnTn0heGPIW4a/cArqduG1GVbMZ1P+vZJFi9ors
 MZK39LoI/ErUp5Zg44FRLT/nmKa3p0831gCfZeOHi2Z7n4kKlu8/Dbb5/4jF4JNYTDCy
 KAxSqEBAH4H2g6Iy4K7y+Plyg/2qMK0mdBh/UsLgCuIxwbvu3tRCOh604yFvsrSGtbE4
 Kvppf8X/n+C6ReTYWu9IlX6vbyK226hnUrddseXOpOMuvDiPakVC9wEzVAeDLdtgpD2Y
 chISFr4SjqS4rNC8xw7AI4k9m3rJ/QU6ekFI89A8J60WavUwovCcgwmBF9LO3fQvAcvC
 YeoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794999692; x=1795604492;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=O/2YRAStFdQgm6FRhUExNOF8OoVL5JRZS8Jkyh6epeo=;
 b=uAVwOMC+1zGmkLz7UsaiHoHpDR48rGPx1DIUVeWOkT7yfxEmb7+y287sEpgw8cCvyV
 rXkuiW7tFqBhKei/oVJefO3SDJ/HFT0phjBRgY3RnnYojJKxuG8L28guvgqdCNUYt1ZM
 r86f9sNzdXA9RZNo5PXd4A1FPgugujzLfLo2FqMNBuWigTpoZc8YAeFAHky8mpX8mh7A
 n55asTfN3NeFCKDQmlq6Zho1iNt1SLYixEgKsyKclQZNFG4JGHA5ERzFkSUPnNPK2CdI
 eTiyShp4XuEDspwSuF3FwzbWi7fkVvI5+Q6jSEgTg7wfbyNtw6zlzhS+BL4n2BxXRiPG
 Iu4A==
X-Gm-Message-State: APuU4Z/2o5py4cyJogL6sQ/uFZ/Bgr1e/3iJLmjTOXDx4Ooz4GIpbMDZ
 5cFtqJye1bGHyQMcnR8OaOLrCWMDBn1NiK7f89cLAJR0tw7AD83TsS592wVt4gCHX6DG3/ACBBj
 9B4gjDtmA7oS72dQxduGGKmSrCQ8I21ig5bu63VAmEOWGWGELkT3s5QaNMzIaNN4vRMhb
X-Gm-Gg: AYBFou23jMwTInqFtXZvMLuLQ5XOdqGntrvVcIf4BIp8KqQdE7ngE9s5TkBb9t+4S/e
 Cu5yV2INJfYPq7wZqplQ6vD+38c7K4XBruPQTO+GfwBWVK6MdqVotuwDNzI94F9uQOagruN1XrE
 RpfCIYeq8MJfvdXHaeCKpu6/Na2dgGNQorrjyR4X0uR3BXONdx20rT+JeJk9nyJlEVvuo32n8mm
 cEwXEBcQ8kFlJgR00n45kCNZJurb1J9lwV3LiXxSm6/qX9msbLNJQAGHFQqeaXgtTa9PZBrTxCG
 yIpLrBRTaA2Ocw3W67GIs66K1Hj/TL4I1cfLaE35I43NS505hfb8+7Ysj+N+OGR5BsZEkJGXZO+
 J+u3g2sK5BjBn8Wt/Hx0suMgY/gu7HM3mEHTs2ezvHMrsYqQgYzqKMj9pCk681afxaOpww4F4uW
 keJg1rI5Jy33+Dk24Z6gP4U8kkPs7u6PYS/Zor7/C4vlulajsMilwpn8ZXUuPVx/weU2ihb0oX6
 chVs+r1XsnYidE0PX43EeWCb8E8UkhRFog+QNmE/cojIB/ft5lSJHaXbSuwGyBjKniripdRvSvi
 3nWLWgb1sjSFxXdetsbkVISjYMo4zgixO+hN0IpxRAaglOnGCptOFXac0JCNGRRLHZ4MHMudUAf
 mjA4QaxHulO1Vcq5FQCSadJX/8hPXEvagVmSbYdfyh6kkgyeuGqNL6BW6BOOBKd8CpWg+Z3mmMX
 iJJPjocv2EMEcmlBY=
X-Received: by 2002:a05:600c:6986:b0:4a3:5a98:c279 with SMTP id
 5b1f17b1804b1-4bb7da0c19dmr36067515e9.8.1794999691521; 
 Wed, 18 Nov 2026 03:01:31 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d2abfc4sm59209075e9.7.2026.11.18.03.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 03:01:31 -0800 (PST)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 11:01:21 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I06302e82cdc7c98503430500daa4ec95f5ce961f
X-Gerrit-Change-Number: 2212
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2212?usp=email>
X-Gerrit-Commit: 72f4ea6e1403cbbdc90cf746c5650030099ff713
In-Reply-To: <gerrit.1794924454000.I06302e82cdc7c98503430500daa4ec95f5ce961f@gerrit.openvpn.net>
References: <gerrit.1794924454000.I06302e82cdc7c98503430500daa4ec95f5ce961f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTI0NDU0MDAwLkkwNjMwMmU4MmNkYzdjOTg1MDM0MzA1MDBkYWE0ZWM5NWY1Y2U5NjFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a161ed228a8a7d58483f0bab97529281bbb6e436-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTdQ2-0000000073K-1Hyl
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: stop polling
 the listen socket while a client is connected
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2103197693772629193=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2103197693772629193==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="U9w9GKrqZCw="; charset=UTF-8

--U9w9GKrqZCw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to reexamine a c=
hange=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2212?=
usp=3Demail

to look at the new patch set (#3)=2E

The change is no longer =
submittable: checks~ChecksSubmitRule is unsatisfied now=2E


Change subject=
: manage: stop polling the listen socket while a client is connected
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

manage: stop pollin=
g the listen socket while a client is connected

In server mode the managem=
ent listen socket stays in the persistent
event set after a client is accep=
ted=2E A second connection queued on it
keeps it readable, so every event w=
ait returns immediately for the
management, management_io() finds nothing t=
o do on the client socket,
and the server spins at 100% CPU while timers st=
arve=2E

Remove sd_top from the event set on accept; it is re-added when th=
e
state goes back to MS_LISTEN=2E Reset the cached state on removal, so the=

next update registers the right socket even after an accept or close in
a =
standalone management loop, and skip the removal when nothing is
registered=
=2E

Trac: #681
Change-Id: I06302e82cdc7c98503430500daa4ec95f5ce961f
Signed=
-off-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
---
M src/openvpn=
/manage=2Ec
M src/openvpn/multi=2Ec
2 files changed, 16 insertions(+), 5 de=
letions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/12/2212/3

diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2E=
c
index bada1ae=2E=2Ea3e8be6a 100644
--- a/src/openvpn/manage=2Ec
+++ b/src=
/openvpn/manage=2Ec
@@ -344,6 +344,17 @@
 #endif
 }
 
+#ifndef _WIN32
+stat=
ic void
+man_delete_event(struct management *man, const socket_descriptor_t=
 sd)
+{
+    if (man->persist=2Ecallback=2Edelete_event)
+    {
+        (*=
man->persist=2Ecallback=2Edelete_event)(man->persist=2Ecallback=2Earg, sd);=

+    }
+}
+#endif
+
 static void
 man_close_socket(struct management *man,=
 const socket_descriptor_t sd)
 {
@@ -352,10 +363,7 @@
      * Windows does=
n't need this because the ne32 event is permanently
      * enabled at stru=
ct management scope=2E
      */
-    if (man->persist=2Ecallback=2Edelete_e=
vent)
-    {
-        (*man->persist=2Ecallback=2Edelete_event)(man->persis=
t=2Ecallback=2Earg, sd);
-    }
+    man_delete_event(man, sd);
 #endif
   =
  openvpn_close_socket(sd);
 }
@@ -2070,6 +2078,8 @@
         {
 #ifdef _WI=
N32
             man_stop_ne32(man);
+#else
+            man_delete_event(m=
an, man->connection=2Esd_top);
 #endif
         }
 
diff --git a/src/openvp=
n/multi=2Ec b/src/openvpn/multi=2Ec
index 900b5a3=2E=2E4113f26 100644
--- a=
/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -4057,9 +4057,10 @@
 =
management_delete_event(void *arg, event_t event)
 {
     struct multi_cont=
ext *m =3D (struct multi_context *)arg;
-    if (m->multi_io)
+    if (m->m=
ulti_io && m->multi_io->management_persist_flags)
     {
         multi_io_=
delete_event(m->multi_io, event);
+        m->multi_io->management_persist_=
flags =3D 0;
     }
 }
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2212?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-C=
hange-Id: I06302e82cdc7c98503430500daa4ec95f5ce961f
Gerrit-Change-Number: 2=
212
Gerrit-PatchSet: 3
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandel=
bit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Sch=
wabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gianmarco De Gregori <g=
ianmarco@mandelbit=2Ecom>

--U9w9GKrqZCw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>Gianmar=
co De Gregori <strong>uploaded patch set #3</strong> to this change=2E</p><=
p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2212?usp=3Demail">V=
iew Change</a></p><p>The change is no longer submittable: checks~ChecksSubm=
itRule is unsatisfied now=2E</p><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">manage: stop polling the list=
en socket while a client is connected<br><br>In server mode the management =
listen socket stays in the persistent<br>event set after a client is accept=
ed=2E A second connection queued on it<br>keeps it readable, so every event=
 wait returns immediately for the<br>management, management_io() finds noth=
ing to do on the client socket,<br>and the server spins at 100% CPU while t=
imers starve=2E<br><br>Remove sd_top from the event set on accept; it is re=
-added when the<br>state goes back to MS_LISTEN=2E Reset the cached state o=
n removal, so the<br>next update registers the right socket even after an a=
ccept or close in<br>a standalone management loop, and skip the removal whe=
n nothing is<br>registered=2E<br><br>Trac: #681<br>Change-Id: I06302e82cdc7=
c98503430500daa4ec95f5ce961f<br>Signed-off-by: Gianmarco De Gregori &lt;gia=
nmarco@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/manage=2Ec<br>M src/open=
vpn/multi=2Ec<br>2 files changed, 16 insertions(+), 5 deletions(-)<br><br><=
/pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/12/2212/3</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/src/openvpn/manage=2Ec b/src/openvp=
n/manage=2Ec</span><br><span>index bada1ae=2E=2Ea3e8be6a 100644</span><br><=
span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=
=2Ec</span><br><span>@@ -344,6 +344,17 @@</span><br><span> #endif</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#ifndef _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_d=
elete_event(struct management *man, const socket_descriptor_t sd)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (man-&gt;persist=2Ecallback=2Edelete_eve=
nt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        (*man-&gt;persist=2Eca=
llback=2Edelete_event)(man-&gt;persist=2Ecallback=2Earg, sd);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> static void</span><br><span> man_close_socket(struct managem=
ent *man, const socket_descriptor_t sd)</span><br><span> {</span><br><span>=
@@ -352,10 +363,7 @@</span><br><span>      * Windows doesn&#39;t need this =
because the ne32 event is permanently</span><br><span>      * enabled at st=
ruct management scope=2E</span><br><span>      */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (man-&gt;persist=2Ecallback=2Edelete_eve=
nt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        (*man-&gt;persist=2Ecallba=
ck=2Edelete_event)(man-&gt;persist=2Ecallback=2Earg, sd);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    man_delete_event(man, sd);</span><br><span> #endi=
f</span><br><span>     openvpn_close_socket(sd);</span><br><span> }</span><=
br><span>@@ -2070,6 +2078,8 @@</span><br><span>         {</span><br><span> =
#ifdef _WIN32</span><br><span>             man_stop_ne32(man);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            man_delete_event(man, man-&gt;conn=
ection=2Esd_top);</span><br><span> #endif</span><br><span>         }</span>=
<br><span> </span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvp=
n/multi=2Ec</span><br><span>index 900b5a3=2E=2E4113f26 100644</span><br><sp=
an>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec<=
/span><br><span>@@ -4057,9 +4057,10 @@</span><br><span> management_delete_e=
vent(void *arg, event_t event)</span><br><span> {</span><br><span>     stru=
ct multi_context *m =3D (struct multi_context *)arg;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (m-&gt;multi_io)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (m-&gt;multi_io &amp;&amp; m-&gt=
;multi_io-&gt;management_persist_flags)</span><br><span>     {</span><br><s=
pan>         multi_io_delete_event(m-&gt;multi_io, event);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        m-&gt;multi_io-&gt;managemen=
t_persist_flags =3D 0;</span><br><span>     }</span><br><span> }</span><br>=
</pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2212?usp=3Demail">change 2212</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2212?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I06302e82cdc7c98503430500daa4ec95f5ce961f=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2212 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; <=
/div>

</body></html>
--U9w9GKrqZCw=--


--===============2103197693772629193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2103197693772629193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2103197693772629193==--

