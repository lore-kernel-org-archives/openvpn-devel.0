Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA72CD4F39
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 10:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LhJxmXOO/3cmjWqLgT4VXdG4jjNMFmLC8wg5v2An/Ns=; b=Kkv6UZzr1T9azuhP4lDL82kXyN
	54OmON+dMhHdXJ4+R6MmgB6notn0Bju1fF0FVIaciAjsmmhXWtEz2alR6/Ikw44azVj+5aEtTqFlh
	wwAmM64TVkHkcP6/TTFrh1sG74mXw4wnsQvwcL9FA2Uog+nCLpj9oXU/mGIiKXSUS7vI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNTVn-0000HU-T3;
	Thu, 14 May 2026 10:41:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wNTVm-0000HG-Mj
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 10:41:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=VxLV7czgno/3tNCWIugd5sgakxkDcaX3phHc+JExLt0=; b=OcOc09dCT/LLLIOebQPoIQZXzg
 akOa2SGPKUxvsLcHNqOw2ih6DLmxgEfUpRVXI3h2ultS9glNqyQv/BXHhc0V2J3TAQMmbodQXbMJA
 lp/BkZT7bBcnPPVTjsceawI0MzNkT/rhrOzoO9FMq3o71ZkL2OB3yd//yE4TOWR12ECo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VxLV7czgno/3tNCWIugd5sgakxkDcaX3phHc+JExLt0=; b=Z
 e8kul+VeKwIM7c7gobb3wjBx7AwBBZ/pLB8x0rffEt4wRi6l/mZQ9DfltqNTSr7aiPMyHTZJ+vJz1
 DwtK30uLDzPOKiwZxFe+iZJ4xOroPCUsF4k/G4/EvQ+ZoO4oKY4lK3ac01L3Bn3fPy6aTYaIThbj1
 g4A0EVqTkslUfErE=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wNTVi-0007Kj-0t for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 10:41:48 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so52537185e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 14 May 2026 03:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778755295; x=1779360095; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VxLV7czgno/3tNCWIugd5sgakxkDcaX3phHc+JExLt0=;
 b=RycaZ2PkvpUuL3LNM0G+Y3M8NlNi/UTn4SmS1FqHzHpDhf+NE4N6JeXk65MQ+lVf+e
 r8FXuZYOZZqPRkbTsZqvklZi2/+YII/sP769LInhBpy1VFPR7310On/3m5Z6jyWktjjI
 F9OPCa+gWjnyJgaIwrO+MhTSBaD3xxJN0F2t7sK2KVAky2o5nhzphU6OG8RuQfSxiK9z
 YrCzzFogx/GoqwmAts8TlICvOpT397I+goWXRWulzjj/GNrlmY1aaK4hhn6iqz50BznW
 SAkBmUjljSLqInQNf0G5O/e3+KMt3YVcrH33JAIly9tt9tELdnAEsB8zd+kl7MFgqfbT
 gBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778755295; x=1779360095;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VxLV7czgno/3tNCWIugd5sgakxkDcaX3phHc+JExLt0=;
 b=Kw/L5JSenVpDLaOALEEWxvtFwf96ewwjyKaDAHBx2bW8loANNdg9+l8yQ4QdrMJL40
 LOqzpCeyyqmeZ4bHW8LrLvaorFWZqEPd83r2XUcAuLhF5PMr2wGo3qfotrop9BraPH7r
 pwXNQa4PAVCs8lV8zmqNsMYytED4f5uk6GdIO41T58m7cx/JAgxfwqA/oXgFUcIJwtfY
 Lt+FW02AjukazIu8tib+ywvXXg/scWqspf8buZb1rPj+CbqJUih6yT//SWjPi7nFw0V4
 +v8/obr9/OjvBgzPgup1l7GrO+DWTODNEPnqdkEXD9kUnAvEDcbljBzo70vgwmkEfgtV
 75DA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wPQrTbbbUkhIvNgYm7efTEVRNZLUBVHeC2SgsyUtu0xHH2K+/3vGjMRh8DkzoHFAwLtqHJonBXOUkk++q@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw7/+1+0CtUplVUqwr06XYp16R2pS7SaxOLHxsolfcPYXfWxLOs
 kYSFIulmtbQa47j9o6PsaP432+T1rTIuJO5G3pcN28YZDP8IE7bGz5bcYcCPQ/MJJEvurflkNtF
 OwDh/VWvtzBLnzpa+KibAbF20ODz7utJDfYl4+jcBdc2tTtTSmoaeTUv/FpuV23FSYLwQ
X-Gm-Gg: Acq92OHBSSQzGmns5K0R10OXym2ExNRPg2TjOmH78xq1etwSvH5AnMNLiloHhmdIWiK
 OZR+LF8fLDKb4mi59NOoScmwSUVw/xkZKjdcdbB8+0Rc4d3Dsov+sbiJoRPwEScl0EcGwLbI7oW
 QfZtVCdpCPeqwe3R+94GgkyRomMkDbZu/4Rkel25jc4XNqur8Q57NQYF5k/vE4ltLTJm1Dy3XvB
 r7qvrcZcd2U7hEC0aDEt3RduzSTeOp93p9u1rZMYXh9zAY1vCfeRFgljSlhVONiMZLqgGN4IuAy
 CsqN3ZSck/a5UnIeXi4lXTM4vk3LAWTKsUa/ToF71hOTYJlyqllv9e62QWDTmiADxy/jtpRoFfu
 bt/9grpiz/o9FKVsn45schEXTj88AzBN7W+gqhATYl2XU1295xpUGDvLWCBZvYY8+oMVUaZT1a/
 svtw7EA4MXZ6IdlrtoZFXIn/AA5Ne6KPY+0ELY6KFR0bc7VsottJ75ZhGa/QxzecO526SWjj3E7
 +fLA0vVQBSBqayH7J+wX/OzqkadIzS050WIH/W3ZVB0oV2NBBcvcOvwgeezhHnbwVblEz8MJ6jE
 T2h81jNh3I1DLQ==
X-Received: by 2002:a05:600c:a07:b0:48a:79d8:a8d6 with SMTP id
 5b1f17b1804b1-48fe2476bd7mr5544025e9.7.1778755294522; 
 Thu, 14 May 2026 03:41:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd6498a7esm53702555e9.4.2026.05.14.03.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 03:41:34 -0700 (PDT)
From: "cron2 (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 14 May 2026 10:41:33 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I3ecb76d9022dcd7dae92eb5e9d62e5f018744883
X-Gerrit-Change-Number: 1666
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1666?usp=email>
X-Gerrit-Commit: b6f09d015191eef75607653f47333c770d74db61
In-Reply-To: <gerrit.1778102459000.I3ecb76d9022dcd7dae92eb5e9d62e5f018744883@gerrit.openvpn.net>
References: <gerrit.1778102459000.I3ecb76d9022dcd7dae92eb5e9d62e5f018744883@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MTAyNDU5MDAwLkkzZWNiNzZkOTAyMmRjZDdkYWU5MmViNWU5ZDYyZTVmMDE4NzQ0ODgzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0ff68376923c27e155fe2fe7f95a5f652f28c250-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wNTVi-0007Kj-0t
Subject: [Openvpn-devel] [S] Change in openvpn[master]: buffer: Fix some
 issues with -DVERIFY_ALIGNMENT
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0162446872328549871=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0162446872328549871==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/p3cCBHlkZM="; charset=UTF-8

--/p3cCBHlkZM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1666?usp=3Demail )

Change subject: buffer: Fix some issues with -DVERI=
FY_ALIGNMENT
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


buffer: Fix some issues with -DVERIFY_ALIGNMENT

- Fix some uninitalised =
fields due to BUF_INIT_TRACKING
  (found by cppcheck and the original reaso=
n for this
   change)=2E
- Fix "unused functions" if only BUF_INIT_TRACKING=
 is
  defined=2E
- Fix conversion error

Change-Id: I3ecb76d9022dcd7dae92eb=
5e9d62e5f018744883
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Eco=
m>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1666
Message-Id: <20260513092251=2E28857-1-=
gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-deve=
l@lists=2Esourceforge=2Enet/msg36901=2Ehtml
Signed-off-by: Gert Doering <ge=
rt@greenie=2Emuc=2Ede>
---
M src/openvpn/buffer=2Ec
1 file changed, 10 inse=
rtions(+), 5 deletions(-)




diff --git a/src/openvpn/buffer=2Ec b/src/ope=
nvpn/buffer=2Ec
index 71f3769=2E=2E1e19137 100644
--- a/src/openvpn/buffer=
=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -64,14 +64,13 @@
 #endif
 {
     struc=
t buffer buf;
+    CLEAR(buf);
 
     if (!buf_size_valid(size))
     {
   =
      buf_size_error(size);
     }
     buf=2Ecapacity =3D (int)size;
-    =
buf=2Eoffset =3D 0;
-    buf=2Elen =3D 0;
 #ifdef DMALLOC
     buf=2Edata =
=3D openvpn_dmalloc(file, line, size);
 #else
@@ -90,13 +89,13 @@
 #endif
 =
{
     struct buffer buf;
+    CLEAR(buf);
+
     if (!buf_size_valid(size)=
)
     {
         buf_size_error(size);
     }
     buf=2Ecapacity =3D (int=
)size;
-    buf=2Eoffset =3D 0;
-    buf=2Elen =3D 0;
 #ifdef DMALLOC
     =
buf=2Edata =3D (uint8_t *)gc_malloc_debug(size, false, gc, file, line);
 #e=
lse
@@ -120,6 +119,10 @@
     ret=2Ecapacity =3D buf->capacity;
     ret=2E=
offset =3D buf->offset;
     ret=2Elen =3D buf->len;
+#ifdef BUF_INIT_TRACK=
ING
+    ret=2Edebug_file =3D buf->debug_file;
+    ret=2Edebug_line =3D bu=
f->debug_line;
+#endif
 #ifdef DMALLOC
     ret=2Edata =3D (uint8_t *)openv=
pn_dmalloc(file, line, buf->capacity);
 #else
@@ -140,6 +143,7 @@
     retu=
rn buf_init_dowork(buf, offset);
 }
 
+#ifdef VERIFY_ALIGNMENT
 static inli=
ne int
 buf_debug_line(const struct buffer *buf)
 {
@@ -151,6 +155,7 @@
 {
=
     return buf->debug_file;
 }
+#endif
 
 #else /* ifdef BUF_INIT_TRACKING=
 */
 
@@ -1152,7 +1157,7 @@
     if (buf && buf->len)
     {
         msglv=
l_t msglevel =3D D_ALIGN_DEBUG;
-        const unsigned int u =3D (unsigned=
 int)BPTR(buf);
+        const uintptr_t u =3D (uintptr_t)BPTR(buf);
 
    =
     if (u & (PAYLOAD_ALIGN - 1))
         {

-- 
To view, visit http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1666?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: I3ecb76d9022dcd7dae92eb5e9d62e5f018744883
Gerrit-Cha=
nge-Number: 1666
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Revie=
wer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>

--/p3cCBHlkZM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1666?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">buffer: Fix some issues with -DVERIFY_ALIG=
NMENT<br><br>- Fix some uninitalised fields due to BUF_INIT_TRACKING<br>  (=
found by cppcheck and the original reason for this<br>   change)=2E<br>- Fi=
x &quot;unused functions&quot; if only BUF_INIT_TRACKING is<br>  defined=2E=
<br>- Fix conversion error<br><br>Change-Id: I3ecb76d9022dcd7dae92eb5e9d62e=
5f018744883<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom=
&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit UR=
L: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1666<br>Message-Id: &lt;20260=
513092251=2E28857-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-=
archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg36901=2Ehtml<br>Si=
gned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/o=
penvpn/buffer=2Ec<br>1 file changed, 10 insertions(+), 5 deletions(-)<br><b=
r></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</s=
pan><br><span>index 71f3769=2E=2E1e19137 100644</span><br><span>--- a/src/o=
penvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><s=
pan>@@ -64,14 +64,13 @@</span><br><span> #endif</span><br><span> {</span><b=
r><span>     struct buffer buf;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    CLEAR(buf);</span><br><span> </span><br><span>     if (!buf=
_size_valid(size))</span><br><span>     {</span><br><span>         buf_size=
_error(size);</span><br><span>     }</span><br><span>     buf=2Ecapacity =
=3D (int)size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf=
=2Eoffset =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    b=
uf=2Elen =3D 0;</span><br><span> #ifdef DMALLOC</span><br><span>     buf=2E=
data =3D openvpn_dmalloc(file, line, size);</span><br><span> #else</span><b=
r><span>@@ -90,13 +89,13 @@</span><br><span> #endif</span><br><span> {</spa=
n><br><span>     struct buffer buf;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    CLEAR(buf);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span>     if (!buf_size_valid(size))</span><br><spa=
n>     {</span><br><span>         buf_size_error(size);</span><br><span>   =
  }</span><br><span>     buf=2Ecapacity =3D (int)size;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    buf=2Eoffset =3D 0;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    buf=2Elen =3D 0;</span><br><span> #i=
fdef DMALLOC</span><br><span>     buf=2Edata =3D (uint8_t *)gc_malloc_debug=
(size, false, gc, file, line);</span><br><span> #else</span><br><span>@@ -1=
20,6 +119,10 @@</span><br><span>     ret=2Ecapacity =3D buf-&gt;capacity;</=
span><br><span>     ret=2Eoffset =3D buf-&gt;offset;</span><br><span>     r=
et=2Elen =3D buf-&gt;len;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#ifdef BUF_INIT_TRACKING</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    ret=2Edebug_file =3D buf-&gt;debug_file;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ret=2Edebug_line =3D buf-&gt;debug_=
line;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><=
br><span> #ifdef DMALLOC</span><br><span>     ret=2Edata =3D (uint8_t *)ope=
nvpn_dmalloc(file, line, buf-&gt;capacity);</span><br><span> #else</span><b=
r><span>@@ -140,6 +143,7 @@</span><br><span>     return buf_init_dowork(buf=
, offset);</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#ifdef VERIFY_ALIGNMENT</span><br><span> static=
 inline int</span><br><span> buf_debug_line(const struct buffer *buf)</span=
><br><span> {</span><br><span>@@ -151,6 +155,7 @@</span><br><span> {</span>=
<br><span>     return buf-&gt;debug_file;</span><br><span> }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br=
><span> #else /* ifdef BUF_INIT_TRACKING */</span><br><span> </span><br><sp=
an>@@ -1152,7 +1157,7 @@</span><br><span>     if (buf &amp;&amp; buf-&gt;le=
n)</span><br><span>     {</span><br><span>         msglvl_t msglevel =3D D_=
ALIGN_DEBUG;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c=
onst unsigned int u =3D (unsigned int)BPTR(buf);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        const uintptr_t u =3D (uintptr_t)BPTR(=
buf);</span><br><span> </span><br><span>         if (u &amp; (PAYLOAD_ALIGN=
 - 1))</span><br><span>         {</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1666?usp=3De=
mail">change 1666</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1666?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I3ecb76d9022dcd7dae92eb5e9d62e5f018744883 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 1666 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--/p3cCBHlkZM=--


--===============0162446872328549871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0162446872328549871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0162446872328549871==--

