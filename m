Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4B9CCF2D6
	for <openvpn-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mxwyi8/jDWPfzvFcg3wN5O8+2cYOhF7r9aB+IHLExOA=; b=C+SCm6kfM+8xJikhRqHfm6tM3J
	8sJmXilL2TQVY6U+ToUCSlQ5hPLkKqNxhzJcfR2kSKfZ+4DYY3kuoLfaQ9qyJTebCUUu63LY19Iag
	f7blwZDMwwUrbOAhsIqI4SMt+qCYadqZ4s0NdigGAP3xRqELBQWUyLp/+Kn3zE3RxEdA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIn1G-0005uu-13;
	Mon, 19 Oct 2026 13:03:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIn1E-0005uk-FJ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:03:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=w5+/IplGJb8QtGpq11K4BBAPs8mB6vD8L/uNZyHmtjI=; b=CT/X896aQY6qAysOfnbTcrZpjR
 NICjhGMFtce/NwQtM+JbeeA7i/Z8Hl41FHRXUk5BFZH6uZhoRYh4WcT1shK6Okea+G9tt1UOoyZh5
 nXqZixhAdm2Qtc/KGXsMF/gdWcOsX6gUmrYN8AZjEhhVyNWRJKzcy7ERd2FfujHtuVtA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=w5+/IplGJb8QtGpq11K4BBAPs8mB6vD8L/uNZyHmtjI=; b=P
 KUq/VahXFH9O27f62lyioWamEf/rnwsS7sBbAGAXzYfL3L3l04Q8SBXVe0f/hVW5yfMrXZQ+xSQjW
 dvgmup8hikT5Jqo+IQP5Oy6tEhAsf5WxJuAV3lWGLTwipBYxACjtaGuR0svrVS7xAfbxIaa5KEHqU
 gkxkWVXRPV9CNlcY=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIn1A-0007cx-Ed for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:03:09 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a1efc90e7cso1785675e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 19 Oct 2026 06:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792414982; x=1793019782; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=w5+/IplGJb8QtGpq11K4BBAPs8mB6vD8L/uNZyHmtjI=;
 b=Xhiucj9uxa/dgn7hs+C+IPOMran66XDqekPsyXZcoQmuY0yEl4V5JWgTTE9jl0mrMv
 +Vg491DS0ZQpBaqpVZmVBAJh50CrR3ukI3jaK5eLajxdpfWAnDESDFae53N5m8jbLMr+
 zTxhRCh6qqpGuW+5ym33lI9sDyAv4vS1IYHsJmL26FS4QlXycHBw7r/W7aUnfZT09yUv
 irbxt/weFvFXISEBV3ITvFhnEZf4F1924rJRGJtQioGfG4bpOwnJtxrbTwCkCUHs6X6H
 vKN1eLuZLmWCMNFnxESJgZOujH9cpKHNNWVglHRTECYZ7LfaiSJlliAuNttOqL79MQOC
 uTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792414982; x=1793019782;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=w5+/IplGJb8QtGpq11K4BBAPs8mB6vD8L/uNZyHmtjI=;
 b=h3gdh8LbGXgMZOkCF3xW4/AF79O4e5jGjM4kkJ5QXhwba3f95BJEJFvMX0cLvrTPyl
 up8WXuMX9VdXXSn4Vy73h1IbPmGNiebADrf2Fx84PZeIfZKllfAc+XgdOhW/ebVPasJy
 lWx1hfbvW9MBK5qfaXDN+H7OiELdSbaZmnvDuDU5NBaBh3UnJioGcaAkx21dFeVrjolz
 iOI/JE2APk1mVN5PU+ofSPoRrmfLGPxICnRzJ8IZs1OcCcN/rCkS7q+uO9sF++WBNeZV
 T8JcDFJUOaLdH9GLQ59ixm9Ti3IYDpb7+9ZVXmyJaMVVuxbQOAKNf4uxkP5UvfPhr/MO
 RG7Q==
X-Gm-Message-State: AFq9FYJEbOcgZZvNaCIr26Odc2LgdlcSExO4+QRw4t/Ip1BREyz0ivSz
 hpGO3+yie5YVaqGosA7iC8g84o7cdcXUz4+ltQEuD4n9dGRL7eewxfa6oyp4Ty5TpFfJbeGL2vj
 utmlVEl/GO1r62dIX1r/1Lx+e13dSuPvsuKapuXQ239fbGGOd1ae4gwUS08q9+zbHylv/W7g4Q8
 tWUNNZ/w==
X-Gm-Gg: AYBFou3y8elBwIS/v3eFYOz+h7O3F3qYhJPZPSAZH2lETeDEVPuD+2Y+JkUi5/9qazW
 Kuw2v6ZbPfc6fQrF9WWo3Ev9rcucmpqTdu/2a4TYWWFTVWUAYEyrpsnylTJBrASwpyjpCdlO4/p
 Xwpo1+uYR3jbo4uTGeVBnfEMmT57RvUDSVswpf6OOCbN7mgrQC4g3lOGZgXxDNbkkQZhrsYscX0
 UpCbiLQxN9RhuWOgTteJfSzHeEfFbP1h2PonXdWjy4pd5YtPaXHVLdmTctc12urqR7khI6LXhc6
 Q+Vh5qraaoVzN2Kqla9B7CLg9AFIwNmadfXgeTQX4OyOYg43riRSiwn3NgoY4HOBo+aLGz4LSpP
 RpLtSOsnEK8mdsF2f/W0AgEASPzaZvepJzyGyDiAWRYzeF0S7UFqu1tP2pahmCt58uxtOpI67dc
 mUtlPyZ1LaoZNfdXY6vl9ONFvVJHc3AuMUwjYWLyv4EjYQr/AUOHjSNO8gtXeNwA44Rqqu8gtAo
 wPf+jUw+veTeNBxzlqYwjj99RMXxaSqmEHvJ0Yy6kvDZEJKUhydDJIj+7ndHku3t/D4QDQuGkAR
 vAVGgIVaeSWO5iDYl649vlyznxPsDAwjX24Rqz89kwpl0MxfNIMIAz4mDu7IEBBlmVVKDHk=
X-Received: by 2002:a05:600c:c8d:b0:49e:63cc:6324 with SMTP id
 5b1f17b1804b1-4a1d75f2bacmr176964675e9.6.1792414980146; 
 Mon, 19 Oct 2026 06:03:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1cf04ffe9sm193894395e9.0.2026.10.19.06.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 06:02:59 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 19 Oct 2026 13:02:58 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I0245175f2884d56838990f53cee6381b981b79c1
X-Gerrit-Change-Number: 2004
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2004?usp=email>
X-Gerrit-Commit: c005931524986bdab3e4f82b8b41756d49c24950
In-Reply-To: <gerrit.1792255622000.I0245175f2884d56838990f53cee6381b981b79c1@gerrit.openvpn.net>
References: <gerrit.1792255622000.I0245175f2884d56838990f53cee6381b981b79c1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU1NjIyMDAwLkkwMjQ1MTc1ZjI4ODRkNTY4Mzg5OTBmNTNjZWU2MzgxYjk4MWI3OWMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cd89f5e0f90372f40e8f54d524f8f88e0f750ee9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIn1A-0007cx-Ed
Subject: [Openvpn-devel] [S] Change in openvpn[master]: misc: Avoid
 conversion warnings in parse_auth_challenge
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7183394370509933777=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7183394370509933777==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IzmF34/zLlM="; charset=UTF-8

--IzmF34/zLlM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
004?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by Gert Doering, Code-Review+2 by R=C4=83zvan Cojocaru


Chang=
e subject: misc: Avoid conversion warnings in parse_auth_challenge
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

misc: Avoid convers=
ion warnings in parse_auth_challenge

Make sure we have a sane length and c=
onvert it int=2E

Change-Id: I0245175f2884d56838990f53cee6381b981b79c1
Sign=
ed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Acked-by: Gert Doering <gert@greenie=2Emuc=2E=
de>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2004
Message-Id:=
 <20261018153738=2E23274-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email=
-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40030=2Ehtml
Sign=
ed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/misc=2E=
c
1 file changed, 13 insertions(+), 18 deletions(-)


  git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/04/2004/2

diff --git a/src/o=
penvpn/misc=2Ec b/src/openvpn/misc=2Ec
index b9cc6a2=2E=2E304a87e 100644
--=
- a/src/openvpn/misc=2Ec
+++ b/src/openvpn/misc=2Ec
@@ -72,11 +72,6 @@
 #en=
dif
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnost=
ic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 #ifdef EN=
ABLE_MANAGEMENT
 /* Get username/password from the management interface */
=
 static bool
@@ -127,19 +122,23 @@
 parse_auth_challenge(const char *auth_c=
hallenge, struct gc_arena *gc)
 {
     ASSERT(auth_challenge);
+    const s=
ize_t len =3D strlen(auth_challenge);
+    if (!buf_size_valid(len))
+    {=

+        return NULL;
+    }
 
-    struct auth_challenge_info *ac;
-    c=
onst int len =3D strlen(auth_challenge);
-    char *work =3D (char *)gc_mal=
loc(len + 1, false, gc);
-    const char *cp;
+    const int work_len =3D (=
int)len + 1;
+    char *work =3D (char *)gc_malloc(work_len, false, gc);
 
=
     struct buffer b;
     buf_set_read(&b, (const uint8_t *)auth_challenge=
, len);
 
+    struct auth_challenge_info *ac;
     ALLOC_OBJ_CLEAR_GC(ac, =
struct auth_challenge_info, gc);
 
     /* parse prefix */
-    if (!buf_pa=
rse(&b, ':', work, len))
+    if (!buf_parse(&b, ':', work, work_len))
    =
 {
         return NULL;
     }
@@ -149,11 +148,11 @@
     }
 
     /* pars=
e flags */
-    if (!buf_parse(&b, ':', work, len))
+    if (!buf_parse(&b,=
 ':', work, work_len))
     {
         return NULL;
     }
-    for (cp =3D=
 work; *cp !=3D '\0'; ++cp)
+    for (const char *cp =3D work; *cp !=3D '\0=
'; ++cp)
     {
         const char c =3D *cp;
         if (c =3D=3D 'E')
@=
@ -167,14 +166,14 @@
     }
 
     /* parse state ID */
-    if (!buf_parse=
(&b, ':', work, len))
+    if (!buf_parse(&b, ':', work, work_len))
     {
=
         return NULL;
     }
     ac->state_id =3D string_alloc(work, gc);
=
 
     /* parse user name */
-    if (!buf_parse(&b, ':', work, len))
+    =
if (!buf_parse(&b, ':', work, work_len))
     {
         return NULL;
     =
}
@@ -189,10 +188,6 @@
 
 #endif /* ifdef ENABLE_MANAGEMENT */
 
-#if defin=
ed(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /=
*
  * Get and store a username/password
  */

-- 
To view, visit https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2004?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I0245175f2884d56838990f53cee6381b981b79c1
Ge=
rrit-Change-Number: 2004
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-R=
eviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>

--IzmF34/zLlM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2004?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by Gert Doering, Code-Review+2 by R=C4=
=83zvan Cojocaru</p><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">misc: Avoid conversion warnings in parse_=
auth_challenge<br><br>Make sure we have a sane length and convert it int=2E=
<br><br>Change-Id: I0245175f2884d56838990f53cee6381b981b79c1<br>Signed-off-=
by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan C=
ojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Gert Doering &lt;gert@gr=
eenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2004<br>Message-Id: &lt;20261018153738=2E23274-1-gert@greenie=2Emuc=2Ed=
e&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esource=
forge=2Enet/msg40030=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/misc=2Ec<br>1 file changed, 13 inse=
rtions(+), 18 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/04/2004/2</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec</span><br><span>index b9cc6a2=
=2E=2E304a87e 100644</span><br><span>--- a/src/openvpn/misc=2Ec</span><br><=
span>+++ b/src/openvpn/misc=2Ec</span><br><span>@@ -72,11 +72,6 @@</span><b=
r><span> #endif</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span> /* Get user=
name/password from the management interface */</span><br><span> static bool=
</span><br><span>@@ -127,19 +122,23 @@</span><br><span> parse_auth_challeng=
e(const char *auth_challenge, struct gc_arena *gc)</span><br><span> {</span=
><br><span>     ASSERT(auth_challenge);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const size_t len =3D strlen(auth_challenge);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_size_valid(le=
n))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return NULL;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct auth_challenge_i=
nfo *ac;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int=
 len =3D strlen(auth_challenge);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    char *work =3D (char *)gc_malloc(len + 1, false, gc);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *cp;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const int work_len =3D (=
int)len + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cha=
r *work =3D (char *)gc_malloc(work_len, false, gc);</span><br><span> </span=
><br><span>     struct buffer b;</span><br><span>     buf_set_read(&amp;b, =
(const uint8_t *)auth_challenge, len);</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct auth_challenge_info *ac;</s=
pan><br><span>     ALLOC_OBJ_CLEAR_GC(ac, struct auth_challenge_info, gc);<=
/span><br><span> </span><br><span>     /* parse prefix */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (!buf_parse(&amp;b, &#39;:&#39;,=
 work, len))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(!buf_parse(&amp;b, &#39;:&#39;, work, work_len))</span><br><span>     {</s=
pan><br><span>         return NULL;</span><br><span>     }</span><br><span>=
@@ -149,11 +148,11 @@</span><br><span>     }</span><br><span> </span><br><s=
pan>     /* parse flags */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (!buf_parse(&amp;b, &#39;:&#39;, work, len))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (!buf_parse(&amp;b, &#39;:&#39;=
, work, work_len))</span><br><span>     {</span><br><span>         return N=
ULL;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    for (cp =3D work; *cp !=3D &#39;\0&#39;; ++cp)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    for (const char *cp =3D work; *cp =
!=3D &#39;\0&#39;; ++cp)</span><br><span>     {</span><br><span>         co=
nst char c =3D *cp;</span><br><span>         if (c =3D=3D &#39;E&#39;)</spa=
n><br><span>@@ -167,14 +166,14 @@</span><br><span>     }</span><br><span> <=
/span><br><span>     /* parse state ID */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (!buf_parse(&amp;b, &#39;:&#39;, work, len))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_parse(&amp=
;b, &#39;:&#39;, work, work_len))</span><br><span>     {</span><br><span>  =
       return NULL;</span><br><span>     }</span><br><span>     ac-&gt;stat=
e_id =3D string_alloc(work, gc);</span><br><span> </span><br><span>     /* =
parse user name */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (!buf_parse(&amp;b, &#39;:&#39;, work, len))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (!buf_parse(&amp;b, &#39;:&#39;, work, =
work_len))</span><br><span>     {</span><br><span>         return NULL;</sp=
an><br><span>     }</span><br><span>@@ -189,10 +188,6 @@</span><br><span> <=
/span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || =
defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pr=
agma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> /*</span><br><span>  * Get and store a username/password</span><br><sp=
an>  */</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2004?usp=3Demail">change 2004</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2004?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I0245175f2884d56838990f=
53cee6381b981b79c1 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 2004 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mai=
lbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--IzmF34/zLlM=--


--===============7183394370509933777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7183394370509933777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7183394370509933777==--

