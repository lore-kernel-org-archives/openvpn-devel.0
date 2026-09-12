Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4950DC79FB6
	for <openvpn-devel@archiver.kernel.org>; Sat, 12 Sep 2026 13:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NwCzNUYFbj7RbV6UKWHxBo2ZrUmmjpR61ngY70UBbAA=; b=YkaT6OcxHkqOEWyR73vDvr6w7N
	oAIW2QSqNc9gbmIXV0+8gXF02XXQAuy3WTTwPlexuJpQoXJsCBf8fWBa4fUpN6mSs3douvg6+Wu4E
	DLI875MKHU3RpP2qno3LZJ57ySXQwpwXbs5FtzrCdDAraBc2HKbF5OEFys3FpScriFDA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5NT5-0002AQ-Sn;
	Sat, 12 Sep 2026 13:08:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x5NT4-0002AK-IZ
 for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 13:08:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=LrKHADZNtPhhpeD2rgYHh+Opc9n0wWzRUAIEDiOwPAM=; b=lrN/Se5PD2rf+ipknEI6u8jx5S
 ohhUR9sjDnG/C/ETUakHcuFoLqgxuTWfI+YuxnG4yDh3a0NeJK2x1Wnv/hluZFrQxUcpLKUBgoDKY
 ofvY8uaFVBk9dd47nBgaE5quAUra4u82YKXwzA8tajl/gVGyJJfGhTXgnnhaMZ6pmfag=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LrKHADZNtPhhpeD2rgYHh+Opc9n0wWzRUAIEDiOwPAM=; b=b
 8/SnBqEWqNg9U5DC6dIGk9OmBGYi4ubOYG+H2c93ybOSeFIPwbEo74tdUr/czxxZf32GsjvqiiO7w
 fRuQF0oH9MhMsda/IqV6g3/MqM+FFkfa3iFbkzzZeNMowqTvJKvkvZdchXKgoMjXv7fwnqRdV3670
 HEYTCk79D4tIqvmY=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x5NSw-0000lF-Ry for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 13:08:30 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-485888b3c3dso1741157f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 12 Sep 2026 06:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789218496; x=1789823296; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LrKHADZNtPhhpeD2rgYHh+Opc9n0wWzRUAIEDiOwPAM=;
 b=VSj/We5MD0sQp5TDBi8OaydPjCs1TBPwZVUQ1AW0phsSCtq0D2BBhtfIWmi4W36+TD
 /xuBOVBb98dJfptHd3YQ76tGUgq6lceI2mtSfAJ9qChxXfyPEmJQRHnAmDxkgnVjjzyo
 CNxHfIZI7yV4XJlc3KJ5ugShsjOFQPS+bsI+S1PDjDdybJPX9jQQ0KUxlbV2rwKv0A9N
 bu/iY7f7EtRkZwywGMx3urlWfpuTCMqOms4noeSWmyQC4ryWszK2GT3CWsVitNIn61yg
 1+qixsfCy+8xlaCyr+gGaxIlkxpgcaJJmSi9X6Q+J4dhJLAl3qF+n7LN3gf3yRK1+Xrl
 bL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789218496; x=1789823296;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LrKHADZNtPhhpeD2rgYHh+Opc9n0wWzRUAIEDiOwPAM=;
 b=OICs/2av9RHmJlLAIl06qKs6ssHrKJJmoSTNQb4fnrhF93haR0am84Ol0xpcqtrgqD
 xGvXOxuaXjjTBgS3T/D5uGZuikrqUdzwH+KiVfudRiHYz385NJE7Q20IwoJtoL7mn4qe
 ld7lpOH4cMgF6KPX2xXQt/aBRgWOqeFK07A/e5uxEgiTfnZ9AJ+nmlqCzfj96Hr1u90f
 Vtqjk4KhL5sRWtXk3tOqMqQgoMTwrInI0Anzccs3SorT+Hw1BmewbctjcdtT/XvEEFDs
 7lzNv24itme1mhqNnS802PeKZjXKFMzi42R8En2RBd9qKw2OKAdydboc/lC3oU7bD0i5
 x9Bg==
X-Gm-Message-State: AFuF++ntxzK4PnIBUcMGruP61gC3+bV4cxRXcSxkPF7s7FEpkOsMPXmI
 xN1+h17KlIPspktO/lMnfYFBs6VaKpXOXf0oF2Y3oMW51XxFNIGseuOuIl5GWVQ0SMInoHV22xa
 s1ssxPJCQMWpTxNxxEAsFMJyj35UDeBhkSIWVFxfQOEH2X7M2Rm7hQjx/xA38TsmwA3yJ
X-Gm-Gg: AYBFou1gDbBOIo1CBdfDt1cepdEJzD3KRdlU2AzbNSmiLSfb6973iZ7ySew2UIhrLYc
 4AB19IxaGNBrw8rRXnDYr4YVyB1K/fpILDvbPrdw8CuOvLN1lfj0VkR7PkXjWk8be9bY5+I452R
 ythe4gMzbndaaY2potFFGGnFZaH85KXJifTDc8gEjeEeoxjnIt1JAhQAyFnY9h4NhCwX/dA3JyE
 jZGldH9VIO4FF+v+iLdDXxocKctypDVwAVDJV90WJTL0DrVSyp51BNW7MsPXnrV2W4wL3K43dZV
 /1Sjk0mMmx1Srtla99cowyhaWfVbCaFzzZXIjnt/YDvjDhkrO/CC74ngMKUWNtVFHJ6+QGXnyYg
 bw6lL0rmZ+z54oX73N4d/nLS8n8W2+x/Mg0IiCVDr/jePp3v3HVCaQqBE+bVRNdYI+iI3hh9Ggn
 CrAJw3RIlDX9AKtXjgPMQM24MCsUT6lARLs0zAlEce+bnUPTmA/uWSFqENa+opMMI/BUOAYAfWq
 1KJAcNbqnj+pdr/RojSlh1OQr5gVTi/+oZzB0hGstWfhXsVk52vhAt28h9N7VfEWIG9GL/Z19pI
 ifpNHM0k7mzN87sg+lY9Nw1e+ftVRE2886nkDm2AaIHoR8m+BQbihIwmQIb1WQ==
X-Received: by 2002:a05:6000:654:b0:486:e737:d94b with SMTP id
 ffacd0b85a97d-486eb31118bmr7665000f8f.51.1789218495652; 
 Sat, 12 Sep 2026 06:08:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb34e74esm12991385f8f.25.2026.09.12.06.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 06:08:14 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 12 Sep 2026 13:08:12 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e
X-Gerrit-Change-Number: 1904
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1904?usp=email>
X-Gerrit-Commit: e031978fd3e33b8f4b4e82d211c070b583e12b56
In-Reply-To: <gerrit.1788815035000.Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e@gerrit.openvpn.net>
References: <gerrit.1788815035000.Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODE1MDM1MDAwLkliNGFmNzYzOWNkZWJlODFlYmEwNWFiMDRlZmU2ZTg1ZTYzZGUwZjllQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <81781cbdd50eef9c6249a4bc5a7e051597eab573-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x5NSw-0000lF-Ry
Subject: [Openvpn-devel] [L] Change in openvpn[master]: buffer: When
 extracting pointers from buffer, retain const
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
Content-Type: multipart/mixed; boundary="===============7091104835325259719=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7091104835325259719==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="512pWxHSG80="; charset=UTF-8

--512pWxHSG80=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: buffer: When extracting pointers from buffer, =
retain const
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


buffer: When extracting pointers from buffer, retain const

Currently you=
 can use BPTR and similar to implicitly remove
const=2E That avoids some wa=
rnings that we should get and
confuses tools like cppcheck into giving wron=
g suggestions=2E

So make sure that by default we only return a non-const
p=
ointer if the buffer pointer is not const=2E Change all call
sites that thr=
ew warnings=2E

Change-Id: Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e
Signed=
-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1904
Message-Id: <20260911204513=2E15692-1-gert@greenie=2Emuc=2Ede>=

URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2E=
net/msg39108=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
-=
--
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M src/openvpn/crypto_b=
ackend=2Eh
M src/openvpn/crypto_mbedtls=2Ec
M src/openvpn/crypto_mbedtls_le=
gacy=2Ec
M src/openvpn/crypto_openssl=2Ec
M src/openvpn/forward=2Ec
M src/o=
penvpn/manage=2Ec
M src/openvpn/mroute=2Ec
M src/openvpn/proto=2Eh
M src/op=
envpn/ps=2Ec
M src/openvpn/push=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/=
socket=2Eh
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_verify=2Ec
M src/ope=
nvpn/tls_crypt=2Ec
M src/openvpn/tun=2Eh
M src/openvpn/vlan=2Ec
M tests/uni=
t_tests/openvpn/test_buffer=2Ec
M tests/unit_tests/openvpn/test_tls_crypt=
=2Ec
21 files changed, 165 insertions(+), 98 deletions(-)


  git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/04/1904/5

diff --git a=
/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index 5d00415=2E=2E21e113d=
 100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -109,7=
 +109,7 @@
 #endif
     ret=2Edata =3D (uint8_t *)malloc(buf->capacity);
  =
   check_malloc_return(ret=2Edata);
-    memcpy(BPTR(&ret), BPTR(buf), BLEN=
Z(buf));
+    memcpy(BPTR(&ret), CBPTR(buf), BLENZ(buf));
     return ret;
=
 }
 
@@ -162,7 +162,7 @@
     {
         return false;
     }
-    return b=
uf_write(dest, BPTR(src), BLENZ(src));
+    return buf_write(dest, CBPTR(sr=
c), BLENZ(src));
 }
 
 void
@@ -293,7 +293,7 @@
         return false;
    =
 }
 
-    const ssize_t size =3D write(fd, BPTR(buf), (unsigned int)BLEN(bu=
f));
+    const ssize_t size =3D write(fd, CBPTR(buf), (unsigned int)BLEN(b=
uf));
     if (size !=3D BLEN(buf))
     {
         msg(M_ERRNO, "Write err=
or on file '%s'", filename);
@@ -732,7 +732,7 @@
     {
         return fal=
se;
     }
-    return memcmp(BPTR(src), match, size) =3D=3D 0;
+    return=
 memcmp(CBPTR(src), match, size) =3D=3D 0;
 }
 
 bool
@@ -1035,13 +1035,13 =
@@
 }
 
 bool
-string_check_buf(struct buffer *buf, const unsigned int incl=
usive, const unsigned int exclusive)
+string_check_buf(const struct buffer =
*buf, const unsigned int inclusive, const unsigned int exclusive)
 {
     A=
SSERT(buf);
 
     for (int i =3D 0; i < BLEN(buf); i++)
     {
-        ch=
ar c =3D BSTR(buf)[i];
+        char c =3D CBSTR(buf)[i];
 
         if (!c=
har_inc_exc(c, inclusive, exclusive))
         {
@@ -1135,7 +1135,7 @@
    =
 if (buf && buf->len)
     {
         msglvl_t msglevel =3D D_ALIGN_DEBUG;
=
-        const uintptr_t u =3D (uintptr_t)BPTR(buf);
+        const uintptr=
_t u =3D (uintptr_t)CBPTR(buf);
 
         if (u & (PAYLOAD_ALIGN - 1))
   =
      {
@@ -1393,16 +1393,16 @@
         return NULL;
     }
 
-    const u=
int8_t *seppos =3D memchr(BPTR(buf), sep, buf_len(buf));
+    const uint8_t=
 *seppos =3D memchr(CBPTR(buf), sep, buf_len(buf));
     if (!seppos)
     =
{
         return NULL;
     }
-    size_t field_len =3D seppos - BPTR(buf)=
;
+    size_t field_len =3D seppos - CBPTR(buf);
 
     char *field =3D gc_=
malloc(field_len + 1, false, gc);
 
-    memcpy(field, BPTR(buf), field_len=
);
+    memcpy(field, CBPTR(buf), field_len);
     field[field_len] =3D 0;
=
 
     buf_advance(buf, field_len + 1);
diff --git a/src/openvpn/buffer=2Eh=
 b/src/openvpn/buffer=2Eh
index 0a02e94=2E=2E22a8b74 100644
--- a/src/openv=
pn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -136,21 +136,29 @@
 
 
 /** R=
eturn a pointer to the start of the buffer content=2E @see buf_bptr() */
-#=
define BPTR(buf)  (buf_bptr(buf))
+#define BPTR(buf)   (buf_bptr(buf))
+/**=
 Return a const pointer to the start of the buffer content=2E @see buf_cbpt=
r() */
+#define CBPTR(buf)  (buf_cbptr(buf))
 /** Return a pointer one past=
 the end of the buffer content=2E @see buf_bend() */
-#define BEND(buf)  (b=
uf_bend(buf))
+#define BEND(buf)   (buf_bend(buf))
+/** Return a const poin=
ter one past the end of the buffer content=2E @see buf_cbend() */
+#define =
CBEND(buf)  (buf_cbend(buf))
 /** Return a pointer to the last byte of the =
buffer content, or NULL if empty=2E @see buf_blast() */
-#define BLAST(buf)=
 (buf_blast(buf))
+#define BLAST(buf)  (buf_blast(buf))
+/** Return a const=
 pointer to the last byte of the buffer content, or NULL if empty=2E @see b=
uf_cblast() */
+#define CBLAST(buf) (buf_cblast(buf))
 /** Return the lengt=
h of the buffer content in bytes=2E @see buf_len() */
-#define BLEN(buf)  (=
buf_len(buf))
+#define BLEN(buf)   (buf_len(buf))
 /** Return the length of=
 the buffer content as a \c size_t=2E @see buf_len() */
-#define BLENZ(buf)=
 ((size_t)buf_len(buf))
+#define BLENZ(buf)  ((size_t)buf_len(buf))
 /** Re=
turn true iff the buffer is defined (has non-NULL data pointer)=2E @see buf=
_defined() */
-#define BDEF(buf)  (buf_defined(buf))
+#define BDEF(buf)   (=
buf_defined(buf))
 /** Return the buffer content pointer cast to \c char *=
=2E @see buf_str() */
-#define BSTR(buf)  (buf_str(buf))
+#define BSTR(buf)=
   (buf_str(buf))
+/** Return the buffer content pointer cast to \c const c=
har *=2E @see buf_cstr() */
+#define CBSTR(buf)  (buf_cstr(buf))
 /** Retur=
n the number of bytes available for appending to the buffer=2E @see buf_for=
ward_capacity() */
-#define BCAP(buf)  (buf_forward_capacity(buf))
+#define=
 BCAP(buf)   (buf_forward_capacity(buf))
 
 /**
  * Zeroise and reset a buf=
fer=2E
@@ -407,15 +415,15 @@
 }
 
 /**
- * Return a pointer to the start of=
 the buffer content=2E
+ * Return a const pointer to the start of the buffe=
r content=2E
  *
  * @param buf   The buffer to query=2E
  *
  * @return Po=
inter to \c buf->data + \c buf->offset, or NULL if \c buf is
  *         no=
t valid=2E
  */
-static inline uint8_t *
-buf_bptr(const struct buffer *buf=
)
+static inline const uint8_t *
+buf_cbptr(const struct buffer *buf)
 {
  =
   if (buf_valid(buf))
     {
@@ -428,6 +436,20 @@
 }
 
 /**
+ * Return a p=
ointer to the start of the buffer content=2E
+ *
+ * @param buf   The buffe=
r to query=2E
+ *
+ * @return Pointer to \c buf->data + \c buf->offset, or =
NULL if \c buf is
+ *         not valid=2E
+ */
+static inline uint8_t *
+b=
uf_bptr(struct buffer *buf)
+{
+    return (uint8_t *)buf_cbptr(buf);
+}
+
=
+/**
  * Return the length of the buffer content=2E
  *
  * @param buf   Th=
e buffer to query=2E
@@ -455,12 +477,46 @@
  * @return Pointer to the byte =
immediately after the last content byte=2E
  */
 static inline uint8_t *
-b=
uf_bend(const struct buffer *buf)
+buf_bend(struct buffer *buf)
 {
     ret=
urn buf_bptr(buf) + buf_len(buf);
 }
 
 /**
+ * Return a const pointer one =
past the end of the buffer content=2E
+ *
+ * @param buf   The buffer to qu=
ery=2E
+ *
+ * @return Pointer to the byte immediately after the last conte=
nt byte=2E
+ */
+static inline const uint8_t *
+buf_cbend(const struct buff=
er *buf)
+{
+    return buf_cbptr(buf) + buf_len(buf);
+}
+
+/**
+ * Return=
 a const pointer to the last byte of the buffer content=2E
+ *
+ * @param b=
uf   The buffer to query=2E
+ *
+ * @return Pointer to the last byte, or NU=
LL if the buffer is empty or
+ *         invalid=2E
+ */
+static inline con=
st uint8_t *
+buf_cblast(const struct buffer *buf)
+{
+    if (buf_len(buf)=
 > 0)
+    {
+        return buf_cbptr(buf) + buf_len(buf) - 1;
+    }
+   =
 else
+    {
+        return NULL;
+    }
+}
+
+/**
  * Return a pointer to=
 the last byte of the buffer content=2E
  *
  * @param buf   The buffer to =
query=2E
@@ -469,16 +525,9 @@
  *         invalid=2E
  */
 static inline ui=
nt8_t *
-buf_blast(const struct buffer *buf)
+buf_blast(struct buffer *buf)=

 {
-    if (buf_len(buf) > 0)
-    {
-        return buf_bptr(buf) + buf_l=
en(buf) - 1;
-    }
-    else
-    {
-        return NULL;
-    }
+    retu=
rn (uint8_t *)buf_cblast(buf);
 }
 
 /**
@@ -518,12 +567,25 @@
  * @return =
The content pointer as a \c char *, or NULL if \c buf is invalid=2E
  */
 s=
tatic inline char *
-buf_str(const struct buffer *buf)
+buf_str(struct buff=
er *buf)
 {
     return (char *)buf_bptr(buf);
 }
 
 /**
+ * Return the buf=
fer content pointer cast to \c const char *=2E
+ *
+ * @param buf   The buf=
fer to query=2E
+ *
+ * @return The content pointer as a \c const char *, o=
r NULL if \c buf is invalid=2E
+ */
+static inline const char *
+buf_cstr(c=
onst struct buffer *buf)
+{
+    return (const char *)buf_cbptr(buf);
+}
+
=
+/**
  * Reset a buffer to an undefined (unallocated) state=2E
  *
  * Sets=
 all fields to zero/NULL without freeing any memory=2E  Use \c free_buf()
@=
@ -1300,7 +1362,7 @@
 static inline bool
 buf_copy(struct buffer *dest, con=
st struct buffer *src)
 {
-    return buf_write(dest, BPTR(src), BLENZ(src)=
);
+    return buf_write(dest, CBPTR(src), BLENZ(src));
 }
 
 /**
@@ -1427,=
14 +1489,14 @@
  *         is empty=2E
  */
 static inline int
-buf_peek_u8=
(struct buffer *buf)
+buf_peek_u8(const struct buffer *buf)
 {
     int ret=
;
     if (BLEN(buf) < 1)
     {
         return -1;
     }
-    ret =3D *B=
PTR(buf);
+    ret =3D *CBPTR(buf);
     return ret;
 }
 
@@ -1547,7 +1609,=
7 @@
 static inline bool
 buf_equal(const struct buffer *a, const struct bu=
ffer *b)
 {
-    return BLEN(a) =3D=3D BLEN(b) && 0 =3D=3D memcmp(BPTR(a), =
BPTR(b), BLENZ(a));
+    return BLEN(a) =3D=3D BLEN(b) && 0 =3D=3D memcmp(C=
BPTR(a), CBPTR(b), BLENZ(a));
 }
 
 /**
@@ -1561,7 +1623,7 @@
     {
      =
   return false;
     }
-    return memcmp(BPTR(src), match, size) =3D=3D 0=
;
+    return memcmp(CBPTR(src), match, size) =3D=3D 0;
 }
 
 /**
@@ -1575,=
7 +1637,7 @@
     {
         return false;
     }
-    return memcmp(BPTR(s=
rc), match, size) =3D=3D 0;
+    return memcmp(CBPTR(src), match, size) =3D=
=3D 0;
 }
 
 /**
@@ -1720,7 +1782,7 @@
  * @param exclusive Character class=
es that are not allowed even if they are also in inclusive=2E
  * @return T=
rue if the string consists only of allowed characters, false otherwise=2E
 =
 */
-bool string_check_buf(struct buffer *buf, const unsigned int inclusive=
,
+bool string_check_buf(const struct buffer *buf, const unsigned int inclu=
sive,
                       const unsigned int exclusive);
 
 /**
diff --g=
it a/src/openvpn/crypto_backend=2Eh b/src/openvpn/crypto_backend=2Eh
index =
17085d6=2E=2E7ef6ac4 100644
--- a/src/openvpn/crypto_backend=2Eh
+++ b/src/=
openvpn/crypto_backend=2Eh
@@ -445,7 +445,7 @@
  *
  * @return             =
 \c 0 on failure, \c 1 on success=2E
  */
-int cipher_ctx_update(cipher_ctx=
_t *ctx, uint8_t *dst, int *dst_len, uint8_t *src, int src_len);
+int ciphe=
r_ctx_update(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len, const uint8_t *=
src, int src_len);
 
 /**
  * Pads the final cipher block using PKCS paddin=
g, and output to the destination
diff --git a/src/openvpn/crypto_mbedtls=2E=
c b/src/openvpn/crypto_mbedtls=2Ec
index 6662def=2E=2E0c5beb4 100644
--- a/=
src/openvpn/crypto_mbedtls=2Ec
+++ b/src/openvpn/crypto_mbedtls=2Ec
@@ -512=
,7 +512,7 @@
 }
 
 int
-cipher_ctx_update(cipher_ctx_t *ctx, uint8_t *dst, =
int *dst_len, uint8_t *src, int src_len)
+cipher_ctx_update(cipher_ctx_t *c=
tx, uint8_t *dst, int *dst_len, const uint8_t *src, int src_len)
 {
     if=
 (src_len < 0)
     {
@@ -1093,7 +1093,7 @@
 
     size_t out_len =3D 0;
  =
   if (MBEDTLS_ERR_BASE64_BUFFER_TOO_SMALL
-        !=3D mbedtls_pem_write_=
buffer(header, footer, BPTR(src), BLEN(src), NULL, 0, &out_len))
+        !=
=3D mbedtls_pem_write_buffer(header, footer, CBPTR(src), BLEN(src), NULL, 0=
, &out_len))
     {
         return false;
     }
@@ -1101,7 +1101,7 @@
   =
  /* We set the size buf to out_len-1 to NOT include the 0 byte that
      =
* mbedtls_pem_write_buffer in its length calculation */
     *dst =3D alloc=
_buf_gc(out_len, gc);
-    if (!mbed_ok(mbedtls_pem_write_buffer(header, fo=
oter, BPTR(src), BLEN(src), BPTR(dst),
+    if (!mbed_ok(mbedtls_pem_write_=
buffer(header, footer, CBPTR(src), BLEN(src), BPTR(dst),
                  =
                         BCAP(dst), &out_len))
         || !(out_len < INT_=
MAX && out_len > 1)
         || !buf_inc_len(dst, (int)out_len - 1))
diff -=
-git a/src/openvpn/crypto_mbedtls_legacy=2Ec b/src/openvpn/crypto_mbedtls_l=
egacy=2Ec
index 9e47c26=2E=2Ebbd012f6 100644
--- a/src/openvpn/crypto_mbedt=
ls_legacy=2Ec
+++ b/src/openvpn/crypto_mbedtls_legacy=2Ec
@@ -249,7 +249,7 =
@@
 
     size_t out_len =3D 0;
     if (MBEDTLS_ERR_BASE64_BUFFER_TOO_SMAL=
L
-        !=3D mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(sr=
c), NULL, 0, &out_len))
+        !=3D mbedtls_pem_write_buffer(header, foot=
er, CBPTR(src), BLEN(src), NULL, 0, &out_len))
     {
         return false=
;
     }
@@ -257,7 +257,7 @@
     /* We set the size buf to out_len-1 to NO=
T include the 0 byte that
      * mbedtls_pem_write_buffer in its length ca=
lculation */
     *dst =3D alloc_buf_gc(out_len, gc);
-    if (!mbed_ok(mbe=
dtls_pem_write_buffer(header, footer, BPTR(src), BLEN(src), BPTR(dst),
+   =
 if (!mbed_ok(mbedtls_pem_write_buffer(header, footer, CBPTR(src), BLEN(src=
), BPTR(dst),
                                           BCAP(dst), &out_le=
n))
         || !buf_inc_len(dst, out_len - 1))
     {
@@ -684,7 +684,7 @@
=
 }
 
 int
-cipher_ctx_update(mbedtls_cipher_context_t *ctx, uint8_t *dst, i=
nt *dst_len, uint8_t *src,
+cipher_ctx_update(mbedtls_cipher_context_t *ctx=
, uint8_t *dst, int *dst_len, const uint8_t *src,
                   int sr=
c_len)
 {
     size_t s_dst_len =3D *dst_len;
diff --git a/src/openvpn/cryp=
to_openssl=2Ec b/src/openvpn/crypto_openssl=2Ec
index 2019280=2E=2E29c5fa6 =
100644
--- a/src/openvpn/crypto_openssl=2Ec
+++ b/src/openvpn/crypto_openss=
l=2Ec
@@ -465,7 +465,7 @@
 {
     bool ret =3D false;
     BIO *bio =3D BIO=
_new(BIO_s_mem());
-    if (!bio || !PEM_write_bio(bio, name, "", BPTR(src)=
, BLEN(src)))
+    if (!bio || !PEM_write_bio(bio, name, "", CBPTR(src), BL=
EN(src)))
     {
         ret =3D false;
         goto cleanup;
@@ -492,7 +=
492,7 @@
 {
     bool ret =3D false;
 
-    BIO *bio =3D BIO_new_mem_buf((c=
har *)BPTR(src), BLEN(src));
+    BIO *bio =3D BIO_new_mem_buf(CBPTR(src), =
BLEN(src));
     if (!bio)
     {
         crypto_msg(M_FATAL, "Cannot open=
 memory BIO for PEM decode");
@@ -941,7 +941,7 @@
 }
 
 int
-cipher_ctx_upd=
ate(EVP_CIPHER_CTX *ctx, uint8_t *dst, int *dst_len, uint8_t *src, int src_=
len)
+cipher_ctx_update(EVP_CIPHER_CTX *ctx, uint8_t *dst, int *dst_len, co=
nst uint8_t *src, int src_len)
 {
     if (!EVP_CipherUpdate(ctx, dst, dst_=
len, src, src_len))
     {
diff --git a/src/openvpn/forward=2Ec b/src/openv=
pn/forward=2Ec
index 2ade321=2E=2Ead43d40 100644
--- a/src/openvpn/forward=
=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -271,7 +271,7 @@
     }
     else
   =
  {
-        msg(D_PUSH_ERRORS, "WARNING: Received unknown control message:=
 %s", BSTR(buf));
+        msg(D_PUSH_ERRORS, "WARNING: Received unknown co=
ntrol message: %s", CBSTR(buf));
     }
 }
 
@@ -1646,7 +1646,7 @@
        =
     return;
         }
 
-        const struct openvpn_ethhdr *orig_ethhdr=
 =3D (struct openvpn_ethhdr *)BPTR(buf);
+        const struct openvpn_ethh=
dr *orig_ethhdr =3D (const struct openvpn_ethhdr *)CBPTR(buf);
 
         /=
* Copy frametype and reverse source/destination for the response */
       =
  struct openvpn_ethhdr ethhdr;
diff --git a/src/openvpn/manage=2Ec b/src/o=
penvpn/manage=2Ec
index 310d2e1=2E=2Ec301687 100644
--- a/src/openvpn/manag=
e=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -2278,7 +2278,7 @@
 
 #ifdef TARGET_A=
NDROID
 static ssize_t
-man_send_with_fd(int fd, void *ptr, size_t nbytes, =
int flags, int sendfd)
+man_send_with_fd(int fd, const void *ptr, size_t nb=
ytes, int flags, int sendfd)
 {
     struct msghdr msg =3D { 0 };
     stru=
ct iovec iov[1];
@@ -2302,12 +2302,14 @@
     msg=2Emsg_name =3D NULL;
    =
 msg=2Emsg_namelen =3D 0;
 
-    iov[0]=2Eiov_base =3D ptr;
+    /* sendmsg=
 takes a const msghdr, but we can't construct that here
+       directly, s=
o cast */
+    iov[0]=2Eiov_base =3D (void *)ptr;
     iov[0]=2Eiov_len =3D=
 nbytes;
     msg=2Emsg_iov =3D iov;
     msg=2Emsg_iovlen =3D 1;
 
-    re=
turn (sendmsg(fd, &msg, flags));
+    return sendmsg(fd, &msg, flags);
 }
 =

 static ssize_t
@@ -2512,24 +2514,23 @@
 {
     const int size_hint =3D 10=
24;
     ssize_t sent =3D 0;
-    const struct buffer *buf;
 
     buffer_l=
ist_aggregate(man->connection=2Eout, size_hint);
-    buf =3D buffer_list_p=
eek(man->connection=2Eout);
+    const struct buffer *buf =3D buffer_list_p=
eek(man->connection=2Eout);
     if (buf && BLEN(buf))
     {
         cons=
t int len =3D min_int(size_hint, BLEN(buf));
 #ifdef TARGET_ANDROID
       =
  if (man->connection=2Efdtosend > 0)
         {
-            sent =3D man_=
send_with_fd(man->connection=2Esd_cli, BPTR(buf), len, MSG_NOSIGNAL,
+     =
       sent =3D man_send_with_fd(man->connection=2Esd_cli, CBPTR(buf), len,=
 MSG_NOSIGNAL,
                                     man->connection=2Efdtos=
end);
             man->connection=2Efdtosend =3D -1;
         }
         e=
lse
 #endif
         {
-            sent =3D send(man->connection=2Esd_cli,=
 (const void *)BPTR(buf), len, MSG_NOSIGNAL);
+            sent =3D send(ma=
n->connection=2Esd_cli, CBSTR(buf), len, MSG_NOSIGNAL);
         }
        =
 if (sent >=3D 0)
         {
diff --git a/src/openvpn/mroute=2Ec b/src/open=
vpn/mroute=2Ec
index edf8239=2E=2E39fa482 100644
--- a/src/openvpn/mroute=
=2Ec
+++ b/src/openvpn/mroute=2Ec
@@ -150,12 +150,12 @@
     unsigned int r=
et =3D 0;
     if (BLEN(buf) >=3D 1)
     {
-        switch (OPENVPN_IPH_GE=
T_VER(*BPTR(buf)))
+        switch (OPENVPN_IPH_GET_VER(*CBPTR(buf)))
     =
    {
             case 4:
                 if (BLENZ(buf) >=3D sizeof(stru=
ct openvpn_iphdr))
                 {
-                    const struct ope=
nvpn_iphdr *ip =3D (const struct openvpn_iphdr *)BPTR(buf);
+              =
      const struct openvpn_iphdr *ip =3D (const struct openvpn_iphdr *)CBPT=
R(buf);
 
                     mroute_get_in_addr_t(src, ip->saddr);
      =
               mroute_get_in_addr_t(dest, ip->daddr);
@@ -179,7 +179,7 @@
 =
            case 6:
                 if (BLENZ(buf) >=3D sizeof(struct open=
vpn_ipv6hdr))
                 {
-                    const struct openvpn_=
ipv6hdr *ipv6 =3D (const struct openvpn_ipv6hdr *)BPTR(buf);
+             =
       const struct openvpn_ipv6hdr *ipv6 =3D (const struct openvpn_ipv6hdr=
 *)CBPTR(buf);
 #if 0 /* very basic debug */
                     struct gc=
_arena gc =3D gc_new();
                     msg( M_INFO, "IPv6 packet! src=
=3D%s, dst=3D%s",
@@ -202,7 +202,7 @@
 
             default:
             =
    msg(M_WARN, "IP packet with unknown IP version=3D%d seen",
-           =
         OPENVPN_IPH_GET_VER(*BPTR(buf)));
+                    OPENVPN_IPH=
_GET_VER(*CBPTR(buf)));
         }
     }
     return ret;
@@ -226,7 +226,7=
 @@
     unsigned int ret =3D 0;
     if (BLEN(buf) >=3D (int)sizeof(struct=
 openvpn_ethhdr))
     {
-        const struct openvpn_ethhdr *eth =3D (con=
st struct openvpn_ethhdr *)BPTR(buf);
+        const struct openvpn_ethhdr =
*eth =3D (const struct openvpn_ethhdr *)CBPTR(buf);
         if (src)
     =
    {
             mroute_copy_ether_to_addr(src, eth->source, vid);
diff -=
-git a/src/openvpn/proto=2Eh b/src/openvpn/proto=2Eh
index 3570582=2E=2E9bb=
0866 100644
--- a/src/openvpn/proto=2Eh
+++ b/src/openvpn/proto=2Eh
@@ -258=
,7 +258,7 @@
         *ip_hdr_offset =3D 0;
         if (likely(BLEN(buf) >=
=3D (int)sizeof(struct openvpn_iphdr)))
         {
-            ip_ver =3D =
OPENVPN_IPH_GET_VER(*BPTR(buf));
+            ip_ver =3D OPENVPN_IPH_GET_VE=
R(*CBPTR(buf));
         }
     }
     else if (tunnel_type =3D=3D DEV_TYPE=
_TAP)
@@ -267,7 +267,7 @@
         /* for tap get ip version from eth heade=
r */
         if (likely(BLEN(buf) >=3D *ip_hdr_offset))
         {
-      =
      const struct openvpn_ethhdr *eh =3D (const struct openvpn_ethhdr *)BP=
TR(buf);
+            const struct openvpn_ethhdr *eh =3D (const struct ope=
nvpn_ethhdr *)CBPTR(buf);
             uint16_t proto =3D ntohs(eh->proto);=

             if (proto =3D=3D OPENVPN_ETH_P_IPV6)
             {
diff --gi=
t a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec
index be91a99=2E=2E08c2673 1006=
44
--- a/src/openvpn/ps=2Ec
+++ b/src/openvpn/ps=2Ec
@@ -208,7 +208,9 @@
 
=
         if (head)
         {
-            iov[1]=2Eiov_base =3D BPTR(head)=
;
+            /* sendmsg takes a const msghdr, but we can't construct that=
 here
+               directly, so cast */
+            iov[1]=2Eiov_base =
=3D (char *)CBPTR(head);
             iov[1]=2Eiov_len =3D BLENZ(head);
   =
          mesg=2Emsg_iovlen =3D 2;
         }
@@ -964,7 +966,7 @@
 bool
 is=
_openvpn_protocol(const struct buffer *buf)
 {
-    const unsigned char *p =
=3D (const unsigned char *)BSTR(buf);
+    const unsigned char *p =3D (cons=
t unsigned char *)CBSTR(buf);
     const int len =3D BLEN(buf);
     if (le=
n >=3D 3)
     {
diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
i=
ndex da2bb9f=2E=2E761a59e 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openv=
pn/push=2Ec
@@ -47,7 +47,7 @@
 void
 receive_auth_failed(struct context *c,=
 const struct buffer *buffer)
 {
-    msg(M_VERB0, "AUTH: Received control =
message: %s", BSTR(buffer));
+    msg(M_VERB0, "AUTH: Received control mess=
age: %s", CBSTR(buffer));
     c->options=2Eno_advance =3D true;
 
     if =
(!c->options=2Epull)
@@ -64,7 +64,7 @@
     const char *reason =3D NULL;
  =
   if (authfail_extended && BLEN(&buf))
     {
-        reason =3D BSTR(&bu=
f);
+        reason =3D CBSTR(&buf);
     }
 
     if (authfail_extended &&=
 buf_string_match_head_str(&buf, "TEMP"))
@@ -116,7 +116,7 @@
      */
    =
 if (authfail_extended && buf_string_match_head_str(&buf, "CRV1:") && BLEN(=
&buf))
     {
-        ssl_put_auth_challenge(BSTR(&buf));
+        ssl_put=
_auth_challenge(CBSTR(&buf));
     }
 #endif /* ifdef ENABLE_MANAGEMENT */
=
 }
@@ -508,7 +508,7 @@
     uint64_t option_types_found =3D 0;
 
     msg(D=
_PUSH, "PUSH: Received control message: '%s'",
-        sanitize_control_me=
ssage(BSTR(buffer), &gc));
+        sanitize_control_message(CBSTR(buffer),=
 &gc));
 
     int status =3D process_incoming_push_msg(c, buffer, c->optio=
ns=2Epull, pull_permission_mask(c),
                                       =
     &option_types_found);
@@ -516,7 +516,7 @@
     if (status =3D=3D PUSH_=
MSG_ERROR)
     {
         msg(D_PUSH_ERRORS, "WARNING: Received bad push/p=
ull message: %s",
-            sanitize_control_message(BSTR(buffer), &gc))=
;
+            sanitize_control_message(CBSTR(buffer), &gc));
     }
     e=
lse if (status =3D=3D PUSH_MSG_REPLY || status =3D=3D PUSH_MSG_UPDATE
     =
         || status =3D=3D PUSH_MSG_CONTINUATION)
diff --git a/src/openvpn/s=
ocket=2Ec b/src/openvpn/socket=2Ec
index 7c6217a=2E=2E7f39268 100644
--- a/=
src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -2446,7 +2446,9 @@
 =
    struct cmsghdr *cmsg;
     uint8_t pktinfo_buf[PKTINFO_BUF_SIZE];
 
-  =
  iov=2Eiov_base =3D BPTR(buf);
+    /* sendmsg takes a const msghdr, but w=
e can't construct that here
+       directly, so cast */
+    iov=2Eiov_bas=
e =3D (char *)CBPTR(buf);
     iov=2Eiov_len =3D BLENZ(buf);
     mesg=2Ems=
g_iov =3D &iov;
     mesg=2Emsg_iovlen =3D 1;
diff --git a/src/openvpn/sock=
et=2Eh b/src/openvpn/socket=2Eh
index 89465bc=2E=2Ec6a29f4 100644
--- a/src=
/openvpn/socket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -709,14 +709,14 @@
    =
 }
     else
 #endif
-        return sendto(sock->sd, BPTR(buf), BLENZ(buf)=
, 0, (struct sockaddr *)&to->dest=2Eaddr=2Esa,
+        return sendto(sock-=
>sd, CBPTR(buf), BLENZ(buf), 0, (struct sockaddr *)&to->dest=2Eaddr=2Esa,
 =
                      (socklen_t)af_addr_size(to->dest=2Eaddr=2Esa=2Esa_fam=
ily));
 }
 
 static inline ssize_t
 link_socket_write_tcp_posix(struct link=
_socket *sock, struct buffer *buf)
 {
-    return send(sock->sd, BPTR(buf),=
 BLENZ(buf), MSG_NOSIGNAL);
+    return send(sock->sd, CBPTR(buf), BLENZ(bu=
f), MSG_NOSIGNAL);
 }
 
 #endif /* ifdef _WIN32 */
@@ -761,7 +761,7 @@
 {
 =
    if (sock && ipbuf)
     {
-        const struct openvpn_iphdr *iph =3D =
(struct openvpn_iphdr *)BPTR(ipbuf);
+        const struct openvpn_iphdr *i=
ph =3D (const struct openvpn_iphdr *)CBPTR(ipbuf);
         sock->ptos =3D =
iph->tos;
         sock->ptos_defined =3D true;
     }
diff --git a/src/ope=
nvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index 6a6d9f9=2E=2E90b2aec 10064=
4
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -305,7 +30=
5,7 @@
     }
 
     /* get opcode and key ID */
-    uint8_t pkt_firstbyte=
 =3D *BPTR(buf);
+    uint8_t pkt_firstbyte =3D *CBPTR(buf);
     int op =
=3D pkt_firstbyte >> P_OPCODE_SHIFT;
     int key_id =3D pkt_firstbyte & P_=
KEY_ID_MASK;
 
diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_ve=
rify=2Ec
index 063fa5d=2E=2E3653eb4 100644
--- a/src/openvpn/ssl_verify=2Ec=

+++ b/src/openvpn/ssl_verify=2Ec
@@ -207,7 +207,7 @@
 
         struct cer=
t_hash *ch =3D session->cert_hash_set->ch[error_depth];
         ASSERT(siz=
eof(ch->sha256_hash) =3D=3D BLEN(cert_hash));
-        memcpy(ch->sha256_ha=
sh, BPTR(cert_hash), sizeof(ch->sha256_hash));
+        memcpy(ch->sha256_h=
ash, CBPTR(cert_hash), sizeof(ch->sha256_hash));
     }
 }
 
diff --git a/s=
rc/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec
index 47f5ac5=2E=2E23c=
7975 100644
--- a/src/openvpn/tls_crypt=2Ec
+++ b/src/openvpn/tls_crypt=2Ec=

@@ -148,7 +148,7 @@
 
     gc_init(&gc);
 
-    dmsg(D_PACKET_CONTENT, "TL=
S-CRYPT WRAP FROM: %s", format_hex(BPTR(src), BLEN(src), 80, &gc));
+    dm=
sg(D_PACKET_CONTENT, "TLS-CRYPT WRAP FROM: %s", format_hex(CBPTR(src), BLEN=
(src), 80, &gc));
 
     /* Get packet ID */
     if (!packet_id_write(&opt=
->packet_id=2Esend, dst, true, false))
@@ -157,7 +157,7 @@
         goto er=
r;
     }
 
-    dmsg(D_PACKET_CONTENT, "TLS-CRYPT WRAP AD: %s", format_hex=
(BPTR(dst), BLEN(dst), 0, &gc));
+    dmsg(D_PACKET_CONTENT, "TLS-CRYPT WRA=
P AD: %s", format_hex(CBPTR(dst), BLEN(dst), 0, &gc));
 
     /* Buffer ove=
rflow check */
     if (!buf_safe(dst, BLENZ(src) + TLS_CRYPT_BLOCK_SIZE + =
TLS_CRYPT_TAG_SIZE))
@@ -173,8 +173,8 @@
     {
         uint8_t *tag =3D N=
ULL;
         hmac_ctx_reset(ctx->hmac);
-        hmac_ctx_update(ctx->hmac=
, BPTR(dst), BLEN(dst));
-        hmac_ctx_update(ctx->hmac, BPTR(src), BLE=
N(src));
+        hmac_ctx_update(ctx->hmac, CBPTR(dst), BLEN(dst));
+     =
   hmac_ctx_update(ctx->hmac, CBPTR(src), BLEN(src));
 
         ASSERT(tag=
 =3D buf_write_alloc(dst, TLS_CRYPT_TAG_SIZE));
         hmac_ctx_final(ctx=
->hmac, tag);
@@ -189,7 +189,7 @@
     /* Encrypt src */
     {
         in=
t outlen =3D 0;
-        ASSERT(cipher_ctx_update(ctx->cipher, BEND(dst), &=
outlen, BPTR(src), BLEN(src)));
+        ASSERT(cipher_ctx_update(ctx->ciph=
er, BEND(dst), &outlen, CBPTR(src), BLEN(src)));
         ASSERT(buf_inc_le=
n(dst, outlen));
         ASSERT(cipher_ctx_final(ctx->cipher, BPTR(dst), &=
outlen));
         ASSERT(buf_inc_len(dst, outlen));
@@ -220,7 +220,7 @@
  =
   ASSERT(ctx->cipher);
     ASSERT(packet_id_initialized(&opt->packet_id) =
|| (opt->flags & CO_IGNORE_PACKET_ID));
 
-    dmsg(D_PACKET_CONTENT, "TLS-=
CRYPT UNWRAP FROM: %s", format_hex(BPTR(src), BLEN(src), 80, &gc));
+    dm=
sg(D_PACKET_CONTENT, "TLS-CRYPT UNWRAP FROM: %s", format_hex(CBPTR(src), BL=
EN(src), 80, &gc));
 
     if (BLENZ(src) < TLS_CRYPT_OFF_CT)
     {
@@ -23=
7,11 +237,11 @@
             CRYPT_ERROR("potential buffer overflow");
    =
     }
 
-        if (!cipher_ctx_reset(ctx->cipher, BPTR(src) + TLS_CRYPT_=
OFF_TAG))
+        if (!cipher_ctx_reset(ctx->cipher, CBPTR(src) + TLS_CRYP=
T_OFF_TAG))
         {
             CRYPT_ERROR("cipher reset failed");
   =
      }
-        if (!cipher_ctx_update(ctx->cipher, BPTR(dst), &outlen, BP=
TR(src) + TLS_CRYPT_OFF_CT,
+        if (!cipher_ctx_update(ctx->cipher, BP=
TR(dst), &outlen, CBPTR(src) + TLS_CRYPT_OFF_CT,
                          =
      BLEN(src) - (int)TLS_CRYPT_OFF_CT))
         {
             CRYPT_ERR=
OR("cipher update failed");
@@ -256,17 +256,17 @@
 
     /* Check authentic=
ation */
     {
-        const uint8_t *tag =3D BPTR(src) + TLS_CRYPT_OFF_T=
AG;
+        const uint8_t *tag =3D CBPTR(src) + TLS_CRYPT_OFF_TAG;
       =
  uint8_t tag_check[TLS_CRYPT_TAG_SIZE] =3D { 0 };
 
         dmsg(D_PACKET=
_CONTENT, "TLS-CRYPT UNWRAP AD: %s",
-             format_hex(BPTR(src), TL=
S_CRYPT_OFF_TAG, 0, &gc));
+             format_hex(CBPTR(src), TLS_CRYPT_O=
FF_TAG, 0, &gc));
         dmsg(D_PACKET_CONTENT, "TLS-CRYPT UNWRAP TO: %s"=
,
-             format_hex(BPTR(dst), BLEN(dst), 80, &gc));
+             f=
ormat_hex(CBPTR(dst), BLEN(dst), 80, &gc));
 
         hmac_ctx_reset(ctx->=
hmac);
-        hmac_ctx_update(ctx->hmac, BPTR(src), TLS_CRYPT_OFF_TAG);
-=
        hmac_ctx_update(ctx->hmac, BPTR(dst), BLEN(dst));
+        hmac_ctx=
_update(ctx->hmac, CBPTR(src), TLS_CRYPT_OFF_TAG);
+        hmac_ctx_update=
(ctx->hmac, CBPTR(dst), BLEN(dst));
         hmac_ctx_final(ctx->hmac, tag_=
check);
 
         if (memcmp_constant_time(tag, tag_check, sizeof(tag_chec=
k)))
@@ -384,7 +384,7 @@
     hmac_ctx_reset(hmac_ctx);
     hmac_ctx_updat=
e(hmac_ctx, (void *)&net_len, sizeof(net_len));
     hmac_ctx_update(hmac_c=
tx, (void *)src_key->keys, sizeof(src_key->keys));
-    hmac_ctx_update(hma=
c_ctx, BPTR(src_metadata), BLEN(src_metadata));
+    hmac_ctx_update(hmac_c=
tx, CBPTR(src_metadata), BLEN(src_metadata));
     hmac_ctx_final(hmac_ctx,=
 tag);
 
     dmsg(D_CRYPTO_DEBUG, "TLS-CRYPT WRAP TAG: %s", format_hex(tag=
, TLS_CRYPT_TAG_SIZE, 0, gc));
@@ -405,7 +405,7 @@
     ASSERT(cipher_ctx_u=
pdate(cipher_ctx, BEND(&work), &outlen, (void *)src_key->keys,
            =
                  sizeof(src_key->keys)));
     ASSERT(buf_inc_len(&work, o=
utlen));
-    ASSERT(cipher_ctx_update(cipher_ctx, BEND(&work), &outlen, BP=
TR(src_metadata),
+    ASSERT(cipher_ctx_update(cipher_ctx, BEND(&work), &o=
utlen, CBPTR(src_metadata),
                              BLEN(src_metadata=
)));
     ASSERT(buf_inc_len(&work, outlen));
     ASSERT(cipher_ctx_final(=
cipher_ctx, BEND(&work), &outlen));
@@ -529,7 +529,7 @@
         return fal=
se;
     }
 
-    const uint8_t *metadata =3D buf_bptr(tls_crypt_v2_metadat=
a);
+    const uint8_t *metadata =3D CBPTR(tls_crypt_v2_metadata);
     if =
(*metadata !=3D TLS_CRYPT_METADATA_TYPE_TIMESTAMP)
     {
         msg(M_WA=
RN, "ERROR: Client key does not have a timestamp=2E");
diff --git a/src/ope=
nvpn/tun=2Eh b/src/openvpn/tun=2Eh
index 931e54d=2E=2E2477560 100644
--- a/=
src/openvpn/tun=2Eh
+++ b/src/openvpn/tun=2Eh
@@ -504,7 +504,7 @@
 static i=
nline bool
 is_ip_packet_valid(const struct buffer *buf)
 {
-    const stru=
ct openvpn_iphdr *ih =3D (const struct openvpn_iphdr *)BPTR(buf);
+    cons=
t struct openvpn_iphdr *ih =3D (const struct openvpn_iphdr *)CBPTR(buf);
 
=
     if (OPENVPN_IPH_GET_VER(ih->version_len) =3D=3D 4)
     {
diff --git a=
/src/openvpn/vlan=2Ec b/src/openvpn/vlan=2Ec
index bffc60e=2E=2E69ac10d 100=
644
--- a/src/openvpn/vlan=2Ec
+++ b/src/openvpn/vlan=2Ec
@@ -269,7 +269,7 =
@@
         return false;
     }
 
-    vlanhdr =3D (const struct openvpn_8=
021qhdr *)BPTR(buf);
+    vlanhdr =3D (const struct openvpn_8021qhdr *)CBPT=
R(buf);
 
     if (ntohs(vlanhdr->tpid) !=3D OPENVPN_ETH_P_8021Q)
     {
di=
ff --git a/tests/unit_tests/openvpn/test_buffer=2Ec b/tests/unit_tests/open=
vpn/test_buffer=2Ec
index 7fb9162=2E=2E7bd0c45 100644
--- a/tests/unit_test=
s/openvpn/test_buffer=2Ec
+++ b/tests/unit_tests/openvpn/test_buffer=2Ec
@@=
 -51,7 +51,7 @@
 
 #define assert_buf_equals_str(buf, str)        \
     as=
sert_int_equal(BLENZ(buf), strlen(str)); \
-    assert_memory_equal(BPTR(bu=
f), str, BLENZ(buf));
+    assert_memory_equal(CBPTR(buf), str, BLENZ(buf))=
;
 
 static void
 test_buffer_printf_catrunc(void **state)
diff --git a/tes=
ts/unit_tests/openvpn/test_tls_crypt=2Ec b/tests/unit_tests/openvpn/test_tl=
s_crypt=2Ec
index db03437=2E=2Ef648e13 100644
--- a/tests/unit_tests/openvp=
n/test_tls_crypt=2Ec
+++ b/tests/unit_tests/openvpn/test_tls_crypt=2Ec
@@ -=
130,7 +130,7 @@
 bool
 __wrap_buffer_write_file(const char *filename, const=
 struct buffer *buf)
 {
-    const char *pem =3D BSTR(buf);
+    const char=
 *pem =3D CBSTR(buf);
     check_expected_ptr(filename);
     check_expecte=
d_ptr(pem);
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1904?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newp=
atchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib4=
af7639cdebe81eba05ab04efe6e85e63de0f9e
Gerrit-Change-Number: 1904
Gerrit-Pa=
tchSet: 5
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revie=
wer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razva=
nc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>

--512pWxHSG80=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #5</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">buffer: When extracting =
pointers from buffer, retain const<br><br>Currently you can use BPTR and si=
milar to implicitly remove<br>const=2E That avoids some warnings that we sh=
ould get and<br>confuses tools like cppcheck into giving wrong suggestions=
=2E<br><br>So make sure that by default we only return a non-const<br>point=
er if the buffer pointer is not const=2E Change all call<br>sites that thre=
w warnings=2E<br><br>Change-Id: Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e<b=
r>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked=
-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1904<br>Message-Id: &lt;20260911204513=2E=
15692-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Eco=
m/openvpn-devel@lists=2Esourceforge=2Enet/msg39108=2Ehtml<br>Signed-off-by:=
 Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/buffe=
r=2Ec<br>M src/openvpn/buffer=2Eh<br>M src/openvpn/crypto_backend=2Eh<br>M =
src/openvpn/crypto_mbedtls=2Ec<br>M src/openvpn/crypto_mbedtls_legacy=2Ec<b=
r>M src/openvpn/crypto_openssl=2Ec<br>M src/openvpn/forward=2Ec<br>M src/op=
envpn/manage=2Ec<br>M src/openvpn/mroute=2Ec<br>M src/openvpn/proto=2Eh<br>=
M src/openvpn/ps=2Ec<br>M src/openvpn/push=2Ec<br>M src/openvpn/socket=2Ec<=
br>M src/openvpn/socket=2Eh<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/s=
sl_verify=2Ec<br>M src/openvpn/tls_crypt=2Ec<br>M src/openvpn/tun=2Eh<br>M =
src/openvpn/vlan=2Ec<br>M tests/unit_tests/openvpn/test_buffer=2Ec<br>M tes=
ts/unit_tests/openvpn/test_tls_crypt=2Ec<br>21 files changed, 165 insertion=
s(+), 98 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/04/1904/5</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><span>index 5d00415=2E=
=2E21e113d 100644</span><br><span>--- a/src/openvpn/buffer=2Ec</span><br><s=
pan>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -109,7 +109,7 @@</span>=
<br><span> #endif</span><br><span>     ret=2Edata =3D (uint8_t *)malloc(buf=
-&gt;capacity);</span><br><span>     check_malloc_return(ret=2Edata);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    memcpy(BPTR(&amp;ret), =
BPTR(buf), BLENZ(buf));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    memcpy(BPTR(&amp;ret), CBPTR(buf), BLENZ(buf));</span><br><span>   =
  return ret;</span><br><span> }</span><br><span> </span><br><span>@@ -162,=
7 +162,7 @@</span><br><span>     {</span><br><span>         return false;</=
span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    return buf_write(dest, BPTR(src), BLENZ(src));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return buf_write(dest, CBPTR(src), BLENZ=
(src));</span><br><span> }</span><br><span> </span><br><span> void</span><b=
r><span>@@ -293,7 +293,7 @@</span><br><span>         return false;</span><b=
r><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    const ssize_t size =3D write(fd, BPTR(buf), (unsigned int)BL=
EN(buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
ssize_t size =3D write(fd, CBPTR(buf), (unsigned int)BLEN(buf));</span><br>=
<span>     if (size !=3D BLEN(buf))</span><br><span>     {</span><br><span>=
         msg(M_ERRNO, &quot;Write error on file &#39;%s&#39;&quot;, filenam=
e);</span><br><span>@@ -732,7 +732,7 @@</span><br><span>     {</span><br><s=
pan>         return false;</span><br><span>     }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    return memcmp(BPTR(src), match, size) =3D=
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return me=
mcmp(CBPTR(src), match, size) =3D=3D 0;</span><br><span> }</span><br><span>=
 </span><br><span> bool</span><br><span>@@ -1035,13 +1035,13 @@</span><br><=
span> }</span><br><span> </span><br><span> bool</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-string_check_buf(struct buffer *buf, const unsign=
ed int inclusive, const unsigned int exclusive)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+string_check_buf(const struct buffer *buf, cons=
t unsigned int inclusive, const unsigned int exclusive)</span><br><span> {<=
/span><br><span>     ASSERT(buf);</span><br><span> </span><br><span>     fo=
r (int i =3D 0; i &lt; BLEN(buf); i++)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        char c =3D BSTR(buf)[i];</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        char c =3D CBS=
TR(buf)[i];</span><br><span> </span><br><span>         if (!char_inc_exc(c,=
 inclusive, exclusive))</span><br><span>         {</span><br><span>@@ -1135=
,7 +1135,7 @@</span><br><span>     if (buf &amp;&amp; buf-&gt;len)</span><b=
r><span>     {</span><br><span>         msglvl_t msglevel =3D D_ALIGN_DEBUG=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const uintpt=
r_t u =3D (uintptr_t)BPTR(buf);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        const uintptr_t u =3D (uintptr_t)CBPTR(buf);</span><br>=
<span> </span><br><span>         if (u &amp; (PAYLOAD_ALIGN - 1))</span><br=
><span>         {</span><br><span>@@ -1393,16 +1393,16 @@</span><br><span> =
        return NULL;</span><br><span>     }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    const uint8_t *seppos =3D memch=
r(BPTR(buf), sep, buf_len(buf));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const uint8_t *seppos =3D memchr(CBPTR(buf), sep, buf_len(=
buf));</span><br><span>     if (!seppos)</span><br><span>     {</span><br><=
span>         return NULL;</span><br><span>     }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    size_t field_len =3D seppos - BPTR(buf);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t field_len =
=3D seppos - CBPTR(buf);</span><br><span> </span><br><span>     char *field=
 =3D gc_malloc(field_len + 1, false, gc);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    memcpy(field, BPTR(buf), field_le=
n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(field=
, CBPTR(buf), field_len);</span><br><span>     field[field_len] =3D 0;</spa=
n><br><span> </span><br><span>     buf_advance(buf, field_len + 1);</span><=
br><span>diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span=
><br><span>index 0a02e94=2E=2E22a8b74 100644</span><br><span>--- a/src/open=
vpn/buffer=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><br><span=
>@@ -136,21 +136,29 @@</span><br><span> </span><br><span> </span><br><span>=
 /** Return a pointer to the start of the buffer content=2E @see buf_bptr()=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define BPTR(buf) =
 (buf_bptr(buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine BPTR(buf)   (buf_bptr(buf))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/** Return a const pointer to the start of the buffer content=
=2E @see buf_cbptr() */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define CBPTR(buf)  (buf_cbptr(buf))</span><br><span> /** Return a poin=
ter one past the end of the buffer content=2E @see buf_bend() */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#define BEND(buf)  (buf_bend(buf=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define BEND(buf)=
   (buf_bend(buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
** Return a const pointer one past the end of the buffer content=2E @see bu=
f_cbend() */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 CBEND(buf)  (buf_cbend(buf))</span><br><span> /** Return a pointer to the =
last byte of the buffer content, or NULL if empty=2E @see buf_blast() */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#define BLAST(buf) (buf_=
blast(buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
BLAST(buf)  (buf_blast(buf))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/** Return a const pointer to the last byte of the buffer content,=
 or NULL if empty=2E @see buf_cblast() */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define CBLAST(buf) (buf_cblast(buf))</span><br><span=
> /** Return the length of the buffer content in bytes=2E @see buf_len() */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define BLEN(buf)  (b=
uf_len(buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 BLEN(buf)   (buf_len(buf))</span><br><span> /** Return the length of the b=
uffer content as a \c size_t=2E @see buf_len() */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define BLENZ(buf) ((size_t)buf_len(buf))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define BLENZ(buf)  ((siz=
e_t)buf_len(buf))</span><br><span> /** Return true iff the buffer is define=
d (has non-NULL data pointer)=2E @see buf_defined() */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#define BDEF(buf)  (buf_defined(buf))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define BDEF(buf)   (buf=
_defined(buf))</span><br><span> /** Return the buffer content pointer cast =
to \c char *=2E @see buf_str() */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#define BSTR(buf)  (buf_str(buf))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define BSTR(buf)   (buf_str(buf))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/** Return the buffer content poin=
ter cast to \c const char *=2E @see buf_cstr() */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define CBSTR(buf)  (buf_cstr(buf))</span><br=
><span> /** Return the number of bytes available for appending to the buffe=
r=2E @see buf_forward_capacity() */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#define BCAP(buf)  (buf_forward_capacity(buf))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define BCAP(buf)   (buf_forward_c=
apacity(buf))</span><br><span> </span><br><span> /**</span><br><span>  * Ze=
roise and reset a buffer=2E</span><br><span>@@ -407,15 +415,15 @@</span><br=
><span> }</span><br><span> </span><br><span> /**</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * Return a pointer to the start of the buffer c=
ontent=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return =
a const pointer to the start of the buffer content=2E</span><br><span>  *</=
span><br><span>  * @param buf   The buffer to query=2E</span><br><span>  *<=
/span><br><span>  * @return Pointer to \c buf-&gt;data + \c buf-&gt;offset,=
 or NULL if \c buf is</span><br><span>  *         not valid=2E</span><br><s=
pan>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline=
 uint8_t *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-buf_bptr(co=
nst struct buffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static inline const uint8_t *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+buf_cbptr(const struct buffer *buf)</span><br><span> {</span>=
<br><span>     if (buf_valid(buf))</span><br><span>     {</span><br><span>@=
@ -428,6 +436,20 @@</span><br><span> }</span><br><span> </span><br><span> /=
**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return a point=
er to the start of the buffer content=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param buf   The buffer to query=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @return Pointer to \c buf-&gt;data + \c buf-&gt;offset, or NULL if=
 \c buf is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
  not valid=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline uint8_t=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buf_bptr(struct b=
uffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return (uint8_t *)buf_=
cbptr(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Return the length of =
the buffer content=2E</span><br><span>  *</span><br><span>  * @param buf   =
The buffer to query=2E</span><br><span>@@ -455,12 +477,46 @@</span><br><spa=
n>  * @return Pointer to the byte immediately after the last content byte=
=2E</span><br><span>  */</span><br><span> static inline uint8_t *</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-buf_bend(const struct buffer *b=
uf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buf_bend(struct =
buffer *buf)</span><br><span> {</span><br><span>     return buf_bptr(buf) +=
 buf_len(buf);</span><br><span> }</span><br><span> </span><br><span> /**</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return a const poin=
ter one past the end of the buffer content=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param buf   The buffer to query=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @return Pointer to the byte immediately after the last conten=
t byte=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static inline const uint8_=
t *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buf_cbend(const =
struct buffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return buf_cbp=
tr(buf) + buf_len(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Return a const pointer to the last byte of the=
 buffer content=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   Th=
e buffer to query=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return Point=
er to the last byte, or NULL if the buffer is empty or</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *         invalid=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static inline const uint8_t *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+buf_cblast(const struct buffer *buf)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (buf_len(buf) &gt; 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return buf_cbptr(buf) + buf_len(buf) - 1;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return NULL;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Return a p=
ointer to the last byte of the buffer content=2E</span><br><span>  *</span>=
<br><span>  * @param buf   The buffer to query=2E</span><br><span>@@ -469,1=
6 +525,9 @@</span><br><span>  *         invalid=2E</span><br><span>  */</sp=
an><br><span> static inline uint8_t *</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-buf_blast(const struct buffer *buf)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+buf_blast(struct buffer *buf)</span><br><=
span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (buf_le=
n(buf) &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return buf_bptr=
(buf) + buf_len(buf) - 1;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        return NULL;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return (uint8_t *)buf_cblast(buf);</span><br><span> =
}</span><br><span> </span><br><span> /**</span><br><span>@@ -518,12 +567,25=
 @@</span><br><span>  * @return The content pointer as a \c char *, or NULL=
 if \c buf is invalid=2E</span><br><span>  */</span><br><span> static inlin=
e char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-buf_str(const=
 struct buffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+buf_str(struct buffer *buf)</span><br><span> {</span><br><span>     return=
 (char *)buf_bptr(buf);</span><br><span> }</span><br><span> </span><br><spa=
n> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return the=
 buffer content pointer cast to \c const char *=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param buf   The buffer to query=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return The content pointer as a \c const char *, or NU=
LL if \c buf is invalid=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static in=
line const char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bu=
f_cstr(const struct buffer *buf)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn (const char *)buf_cbptr(buf);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span> =
 * Reset a buffer to an undefined (unallocated) state=2E</span><br><span>  =
*</span><br><span>  * Sets all fields to zero/NULL without freeing any memo=
ry=2E  Use \c free_buf()</span><br><span>@@ -1300,7 +1362,7 @@</span><br><s=
pan> static inline bool</span><br><span> buf_copy(struct buffer *dest, cons=
t struct buffer *src)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    return buf_write(dest, BPTR(src), BLENZ(src));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return buf_write(dest=
, CBPTR(src), BLENZ(src));</span><br><span> }</span><br><span> </span><br><=
span> /**</span><br><span>@@ -1427,14 +1489,14 @@</span><br><span>  *      =
   is empty=2E</span><br><span>  */</span><br><span> static inline int</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-buf_peek_u8(struct buffer =
*buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buf_peek_u8(co=
nst struct buffer *buf)</span><br><span> {</span><br><span>     int ret;</s=
pan><br><span>     if (BLEN(buf) &lt; 1)</span><br><span>     {</span><br><=
span>         return -1;</span><br><span>     }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    ret =3D *BPTR(buf);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    ret =3D *CBPTR(buf);</span><br><span>    =
 return ret;</span><br><span> }</span><br><span> </span><br><span>@@ -1547,=
7 +1609,7 @@</span><br><span> static inline bool</span><br><span> buf_equal=
(const struct buffer *a, const struct buffer *b)</span><br><span> {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    return BLEN(a) =3D=3D BLE=
N(b) &amp;&amp; 0 =3D=3D memcmp(BPTR(a), BPTR(b), BLENZ(a));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return BLEN(a) =3D=3D BLEN(b) =
&amp;&amp; 0 =3D=3D memcmp(CBPTR(a), CBPTR(b), BLENZ(a));</span><br><span> =
}</span><br><span> </span><br><span> /**</span><br><span>@@ -1561,7 +1623,7=
 @@</span><br><span>     {</span><br><span>         return false;</span><br=
><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retu=
rn memcmp(BPTR(src), match, size) =3D=3D 0;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return memcmp(CBPTR(src), match, size) =3D=3D 0=
;</span><br><span> }</span><br><span> </span><br><span> /**</span><br><span=
>@@ -1575,7 +1637,7 @@</span><br><span>     {</span><br><span>         retu=
rn false;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    return memcmp(BPTR(src), match, size) =3D=3D 0;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return memcmp(CBPTR(src), ma=
tch, size) =3D=3D 0;</span><br><span> }</span><br><span> </span><br><span> =
/**</span><br><span>@@ -1720,7 +1782,7 @@</span><br><span>  * @param exclus=
ive Character classes that are not allowed even if they are also in inclusi=
ve=2E</span><br><span>  * @return True if the string consists only of allow=
ed characters, false otherwise=2E</span><br><span>  */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-bool string_check_buf(struct buffer *buf, =
const unsigned int inclusive,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+bool string_check_buf(const struct buffer *buf, const unsigned in=
t inclusive,</span><br><span>                       const unsigned int excl=
usive);</span><br><span> </span><br><span> /**</span><br><span>diff --git a=
/src/openvpn/crypto_backend=2Eh b/src/openvpn/crypto_backend=2Eh</span><br>=
<span>index 17085d6=2E=2E7ef6ac4 100644</span><br><span>--- a/src/openvpn/c=
rypto_backend=2Eh</span><br><span>+++ b/src/openvpn/crypto_backend=2Eh</spa=
n><br><span>@@ -445,7 +445,7 @@</span><br><span>  *</span><br><span>  * @re=
turn              \c 0 on failure, \c 1 on success=2E</span><br><span>  */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-int cipher_ctx_update(=
cipher_ctx_t *ctx, uint8_t *dst, int *dst_len, uint8_t *src, int src_len);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+int cipher_ctx_updat=
e(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len, const uint8_t *src, int sr=
c_len);</span><br><span> </span><br><span> /**</span><br><span>  * Pads the=
 final cipher block using PKCS padding, and output to the destination</span=
><br><span>diff --git a/src/openvpn/crypto_mbedtls=2Ec b/src/openvpn/crypto=
_mbedtls=2Ec</span><br><span>index 6662def=2E=2E0c5beb4 100644</span><br><s=
pan>--- a/src/openvpn/crypto_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/=
crypto_mbedtls=2Ec</span><br><span>@@ -512,7 +512,7 @@</span><br><span> }</=
span><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-cipher_ctx_update(cipher_ctx_t *ctx, uint8_t *dst, int *dst=
_len, uint8_t *src, int src_len)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+cipher_ctx_update(cipher_ctx_t *ctx, uint8_t *dst, int *dst_le=
n, const uint8_t *src, int src_len)</span><br><span> {</span><br><span>    =
 if (src_len &lt; 0)</span><br><span>     {</span><br><span>@@ -1093,7 +109=
3,7 @@</span><br><span> </span><br><span>     size_t out_len =3D 0;</span><=
br><span>     if (MBEDTLS_ERR_BASE64_BUFFER_TOO_SMALL</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        !=3D mbedtls_pem_write_buffer(heade=
r, footer, BPTR(src), BLEN(src), NULL, 0, &amp;out_len))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        !=3D mbedtls_pem_write_buffer(=
header, footer, CBPTR(src), BLEN(src), NULL, 0, &amp;out_len))</span><br><s=
pan>     {</span><br><span>         return false;</span><br><span>     }</s=
pan><br><span>@@ -1101,7 +1101,7 @@</span><br><span>     /* We set the size=
 buf to out_len-1 to NOT include the 0 byte that</span><br><span>      * mb=
edtls_pem_write_buffer in its length calculation */</span><br><span>     *d=
st =3D alloc_buf_gc(out_len, gc);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (!mbed_ok(mbedtls_pem_write_buffer(header, footer, BPTR(=
src), BLEN(src), BPTR(dst),</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (!mbed_ok(mbedtls_pem_write_buffer(header, footer, CBPTR(src=
), BLEN(src), BPTR(dst),</span><br><span>                                  =
         BCAP(dst), &amp;out_len))</span><br><span>         || !(out_len &l=
t; INT_MAX &amp;&amp; out_len &gt; 1)</span><br><span>         || !buf_inc_=
len(dst, (int)out_len - 1))</span><br><span>diff --git a/src/openvpn/crypto=
_mbedtls_legacy=2Ec b/src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span=
>index 9e47c26=2E=2Ebbd012f6 100644</span><br><span>--- a/src/openvpn/crypt=
o_mbedtls_legacy=2Ec</span><br><span>+++ b/src/openvpn/crypto_mbedtls_legac=
y=2Ec</span><br><span>@@ -249,7 +249,7 @@</span><br><span> </span><br><span=
>     size_t out_len =3D 0;</span><br><span>     if (MBEDTLS_ERR_BASE64_BUF=
FER_TOO_SMALL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
!=3D mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(src), NULL, 0=
, &amp;out_len))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     !=3D mbedtls_pem_write_buffer(header, footer, CBPTR(src), BLEN(src), N=
ULL, 0, &amp;out_len))</span><br><span>     {</span><br><span>         retu=
rn false;</span><br><span>     }</span><br><span>@@ -257,7 +257,7 @@</span>=
<br><span>     /* We set the size buf to out_len-1 to NOT include the 0 byt=
e that</span><br><span>      * mbedtls_pem_write_buffer in its length calcu=
lation */</span><br><span>     *dst =3D alloc_buf_gc(out_len, gc);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_pem_w=
rite_buffer(header, footer, BPTR(src), BLEN(src), BPTR(dst),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (!mbed_ok(mbedtls_pem_write=
_buffer(header, footer, CBPTR(src), BLEN(src), BPTR(dst),</span><br><span> =
                                          BCAP(dst), &amp;out_len))</span><=
br><span>         || !buf_inc_len(dst, out_len - 1))</span><br><span>     {=
</span><br><span>@@ -684,7 +684,7 @@</span><br><span> }</span><br><span> </=
span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ci=
pher_ctx_update(mbedtls_cipher_context_t *ctx, uint8_t *dst, int *dst_len, =
uint8_t *src,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher=
_ctx_update(mbedtls_cipher_context_t *ctx, uint8_t *dst, int *dst_len, cons=
t uint8_t *src,</span><br><span>                   int src_len)</span><br><=
span> {</span><br><span>     size_t s_dst_len =3D *dst_len;</span><br><span=
>diff --git a/src/openvpn/crypto_openssl=2Ec b/src/openvpn/crypto_openssl=
=2Ec</span><br><span>index 2019280=2E=2E29c5fa6 100644</span><br><span>--- =
a/src/openvpn/crypto_openssl=2Ec</span><br><span>+++ b/src/openvpn/crypto_o=
penssl=2Ec</span><br><span>@@ -465,7 +465,7 @@</span><br><span> {</span><br=
><span>     bool ret =3D false;</span><br><span>     BIO *bio =3D BIO_new(B=
IO_s_mem());</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!=
bio || !PEM_write_bio(bio, name, &quot;&quot;, BPTR(src), BLEN(src)))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!bio || !PEM_writ=
e_bio(bio, name, &quot;&quot;, CBPTR(src), BLEN(src)))</span><br><span>    =
 {</span><br><span>         ret =3D false;</span><br><span>         goto cl=
eanup;</span><br><span>@@ -492,7 +492,7 @@</span><br><span> {</span><br><sp=
an>     bool ret =3D false;</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    BIO *bio =3D BIO_new_mem_buf((char *)BPTR(src),=
 BLEN(src));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    BIO=
 *bio =3D BIO_new_mem_buf(CBPTR(src), BLEN(src));</span><br><span>     if (=
!bio)</span><br><span>     {</span><br><span>         crypto_msg(M_FATAL, &=
quot;Cannot open memory BIO for PEM decode&quot;);</span><br><span>@@ -941,=
7 +941,7 @@</span><br><span> }</span><br><span> </span><br><span> int</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-cipher_ctx_update(EVP_CIPHE=
R_CTX *ctx, uint8_t *dst, int *dst_len, uint8_t *src, int src_len)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_update(EVP_CIPHER=
_CTX *ctx, uint8_t *dst, int *dst_len, const uint8_t *src, int src_len)</sp=
an><br><span> {</span><br><span>     if (!EVP_CipherUpdate(ctx, dst, dst_le=
n, src, src_len))</span><br><span>     {</span><br><span>diff --git a/src/o=
penvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index 2ade321=
=2E=2Ead43d40 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><b=
r><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -271,7 +271,7 @@</=
span><br><span>     }</span><br><span>     else</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_PUSH_ERRORS,=
 &quot;WARNING: Received unknown control message: %s&quot;, BSTR(buf));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_ERRO=
RS, &quot;WARNING: Received unknown control message: %s&quot;, CBSTR(buf));=
</span><br><span>     }</span><br><span> }</span><br><span> </span><br><spa=
n>@@ -1646,7 +1646,7 @@</span><br><span>             return;</span><br><spa=
n>         }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        const struct openvpn_ethhdr *orig_ethhdr =3D (struct openv=
pn_ethhdr *)BPTR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        const struct openvpn_ethhdr *orig_ethhdr =3D (const struct openv=
pn_ethhdr *)CBPTR(buf);</span><br><span> </span><br><span>         /* Copy =
frametype and reverse source/destination for the response */</span><br><spa=
n>         struct openvpn_ethhdr ethhdr;</span><br><span>diff --git a/src/o=
penvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 310d2e1=2E=
=2Ec301687 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><s=
pan>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -2278,7 +2278,7 @@</spa=
n><br><span> </span><br><span> #ifdef TARGET_ANDROID</span><br><span> stati=
c ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-man_send_wit=
h_fd(int fd, void *ptr, size_t nbytes, int flags, int sendfd)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+man_send_with_fd(int fd, const vo=
id *ptr, size_t nbytes, int flags, int sendfd)</span><br><span> {</span><br=
><span>     struct msghdr msg =3D { 0 };</span><br><span>     struct iovec =
iov[1];</span><br><span>@@ -2302,12 +2302,14 @@</span><br><span>     msg=2E=
msg_name =3D NULL;</span><br><span>     msg=2Emsg_namelen =3D 0;</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    iov[0]=2Ei=
ov_base =3D ptr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* sendmsg takes a const msghdr, but we can&#39;t construct that here</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+       directly, so cast=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    iov[0]=2Eiov=
_base =3D (void *)ptr;</span><br><span>     iov[0]=2Eiov_len =3D nbytes;</s=
pan><br><span>     msg=2Emsg_iov =3D iov;</span><br><span>     msg=2Emsg_io=
vlen =3D 1;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    return (sendmsg(fd, &amp;msg, flags));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return sendmsg(fd, &amp;msg, flags);</sp=
an><br><span> }</span><br><span> </span><br><span> static ssize_t</span><br=
><span>@@ -2512,24 +2514,23 @@</span><br><span> {</span><br><span>     cons=
t int size_hint =3D 1024;</span><br><span>     ssize_t sent =3D 0;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    const struct buffer *buf;<=
/span><br><span> </span><br><span>     buffer_list_aggregate(man-&gt;connec=
tion=2Eout, size_hint);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    buf =3D buffer_list_peek(man-&gt;connection=2Eout);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const struct buffer *buf =3D buff=
er_list_peek(man-&gt;connection=2Eout);</span><br><span>     if (buf &amp;&=
amp; BLEN(buf))</span><br><span>     {</span><br><span>         const int l=
en =3D min_int(size_hint, BLEN(buf));</span><br><span> #ifdef TARGET_ANDROI=
D</span><br><span>         if (man-&gt;connection=2Efdtosend &gt; 0)</span>=
<br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           sent =3D man_send_with_fd(man-&gt;connection=2Esd_cli, BPTR(buf)=
, len, MSG_NOSIGNAL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            sent =3D man_send_with_fd(man-&gt;connection=2Esd_cli, CBPTR(b=
uf), len, MSG_NOSIGNAL,</span><br><span>                                   =
  man-&gt;connection=2Efdtosend);</span><br><span>             man-&gt;conn=
ection=2Efdtosend =3D -1;</span><br><span>         }</span><br><span>      =
   else</span><br><span> #endif</span><br><span>         {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            sent =3D send(man-&gt;conn=
ection=2Esd_cli, (const void *)BPTR(buf), len, MSG_NOSIGNAL);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            sent =3D send(man-&gt=
;connection=2Esd_cli, CBSTR(buf), len, MSG_NOSIGNAL);</span><br><span>     =
    }</span><br><span>         if (sent &gt;=3D 0)</span><br><span>        =
 {</span><br><span>diff --git a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=
=2Ec</span><br><span>index edf8239=2E=2E39fa482 100644</span><br><span>--- =
a/src/openvpn/mroute=2Ec</span><br><span>+++ b/src/openvpn/mroute=2Ec</span=
><br><span>@@ -150,12 +150,12 @@</span><br><span>     unsigned int ret =3D =
0;</span><br><span>     if (BLEN(buf) &gt;=3D 1)</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        switch (OPENVPN_I=
PH_GET_VER(*BPTR(buf)))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        switch (OPENVPN_IPH_GET_VER(*CBPTR(buf)))</span><br><span>     =
    {</span><br><span>             case 4:</span><br><span>                =
 if (BLENZ(buf) &gt;=3D sizeof(struct openvpn_iphdr))</span><br><span>     =
            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            const struct openvpn_iphdr *ip =3D (const struct openvpn_iphdr =
*)BPTR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             const struct openvpn_iphdr *ip =3D (const struct openvpn_iphdr=
 *)CBPTR(buf);</span><br><span> </span><br><span>                     mrout=
e_get_in_addr_t(src, ip-&gt;saddr);</span><br><span>                     mr=
oute_get_in_addr_t(dest, ip-&gt;daddr);</span><br><span>@@ -179,7 +179,7 @@=
</span><br><span>             case 6:</span><br><span>                 if (=
BLENZ(buf) &gt;=3D sizeof(struct openvpn_ipv6hdr))</span><br><span>        =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         const struct openvpn_ipv6hdr *ipv6 =3D (const struct openvpn_ipv6h=
dr *)BPTR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                const struct openvpn_ipv6hdr *ipv6 =3D (const struct openvp=
n_ipv6hdr *)CBPTR(buf);</span><br><span> #if 0 /* very basic debug */</span=
><br><span>                     struct gc_arena gc =3D gc_new();</span><br>=
<span>                     msg( M_INFO, &quot;IPv6 packet! src=3D%s, dst=3D=
%s&quot;,</span><br><span>@@ -202,7 +202,7 @@</span><br><span> </span><br><=
span>             default:</span><br><span>                 msg(M_WARN, &qu=
ot;IP packet with unknown IP version=3D%d seen&quot;,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    OPENVPN_IPH_GET_VER(*BP=
TR(buf)));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           OPENVPN_IPH_GET_VER(*CBPTR(buf)));</span><br><span>         }</s=
pan><br><span>     }</span><br><span>     return ret;</span><br><span>@@ -2=
26,7 +226,7 @@</span><br><span>     unsigned int ret =3D 0;</span><br><span=
>     if (BLEN(buf) &gt;=3D (int)sizeof(struct openvpn_ethhdr))</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        co=
nst struct openvpn_ethhdr *eth =3D (const struct openvpn_ethhdr *)BPTR(buf)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const stru=
ct openvpn_ethhdr *eth =3D (const struct openvpn_ethhdr *)CBPTR(buf);</span=
><br><span>         if (src)</span><br><span>         {</span><br><span>   =
          mroute_copy_ether_to_addr(src, eth-&gt;source, vid);</span><br><s=
pan>diff --git a/src/openvpn/proto=2Eh b/src/openvpn/proto=2Eh</span><br><s=
pan>index 3570582=2E=2E9bb0866 100644</span><br><span>--- a/src/openvpn/pro=
to=2Eh</span><br><span>+++ b/src/openvpn/proto=2Eh</span><br><span>@@ -258,=
7 +258,7 @@</span><br><span>         *ip_hdr_offset =3D 0;</span><br><span>=
         if (likely(BLEN(buf) &gt;=3D (int)sizeof(struct openvpn_iphdr)))</=
span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            ip_ver =3D OPENVPN_IPH_GET_VER(*BPTR(buf));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            ip_ver =3D OPENVPN_IPH_=
GET_VER(*CBPTR(buf));</span><br><span>         }</span><br><span>     }</sp=
an><br><span>     else if (tunnel_type =3D=3D DEV_TYPE_TAP)</span><br><span=
>@@ -267,7 +267,7 @@</span><br><span>         /* for tap get ip version fro=
m eth header */</span><br><span>         if (likely(BLEN(buf) &gt;=3D *ip_h=
dr_offset))</span><br><span>         {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            const struct openvpn_ethhdr *eh =3D (const str=
uct openvpn_ethhdr *)BPTR(buf);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            const struct openvpn_ethhdr *eh =3D (const struct o=
penvpn_ethhdr *)CBPTR(buf);</span><br><span>             uint16_t proto =3D=
 ntohs(eh-&gt;proto);</span><br><span>             if (proto =3D=3D OPENVPN=
_ETH_P_IPV6)</span><br><span>             {</span><br><span>diff --git a/sr=
c/openvpn/ps=2Ec b/src/openvpn/ps=2Ec</span><br><span>index be91a99=2E=2E08=
c2673 100644</span><br><span>--- a/src/openvpn/ps=2Ec</span><br><span>+++ b=
/src/openvpn/ps=2Ec</span><br><span>@@ -208,7 +208,9 @@</span><br><span> </=
span><br><span>         if (head)</span><br><span>         {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            iov[1]=2Eiov_base =3D BP=
TR(head);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  /* sendmsg takes a const msghdr, but we can&#39;t construct that here</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+               directly=
, so cast */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     iov[1]=2Eiov_base =3D (char *)CBPTR(head);</span><br><span>           =
  iov[1]=2Eiov_len =3D BLENZ(head);</span><br><span>             mesg=2Emsg=
_iovlen =3D 2;</span><br><span>         }</span><br><span>@@ -964,7 +966,7 =
@@</span><br><span> bool</span><br><span> is_openvpn_protocol(const struct =
buffer *buf)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    const unsigned char *p =3D (const unsigned char *)BSTR(buf);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const unsigned c=
har *p =3D (const unsigned char *)CBSTR(buf);</span><br><span>     const in=
t len =3D BLEN(buf);</span><br><span>     if (len &gt;=3D 3)</span><br><spa=
n>     {</span><br><span>diff --git a/src/openvpn/push=2Ec b/src/openvpn/pu=
sh=2Ec</span><br><span>index da2bb9f=2E=2E761a59e 100644</span><br><span>--=
- a/src/openvpn/push=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><=
br><span>@@ -47,7 +47,7 @@</span><br><span> void</span><br><span> receive_a=
uth_failed(struct context *c, const struct buffer *buffer)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(M_VERB0, &q=
uot;AUTH: Received control message: %s&quot;, BSTR(buffer));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    msg(M_VERB0, &quot;AUTH: Recei=
ved control message: %s&quot;, CBSTR(buffer));</span><br><span>     c-&gt;o=
ptions=2Eno_advance =3D true;</span><br><span> </span><br><span>     if (!c=
-&gt;options=2Epull)</span><br><span>@@ -64,7 +64,7 @@</span><br><span>    =
 const char *reason =3D NULL;</span><br><span>     if (authfail_extended &a=
mp;&amp; BLEN(&amp;buf))</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        reason =3D BSTR(&amp;buf);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        reason =3D CBSTR(&amp;buf)=
;</span><br><span>     }</span><br><span> </span><br><span>     if (authfai=
l_extended &amp;&amp; buf_string_match_head_str(&amp;buf, &quot;TEMP&quot;)=
)</span><br><span>@@ -116,7 +116,7 @@</span><br><span>      */</span><br><s=
pan>     if (authfail_extended &amp;&amp; buf_string_match_head_str(&amp;bu=
f, &quot;CRV1:&quot;) &amp;&amp; BLEN(&amp;buf))</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        ssl_put_auth_chal=
lenge(BSTR(&amp;buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        ssl_put_auth_challenge(CBSTR(&amp;buf));</span><br><span>     }<=
/span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> }</s=
pan><br><span>@@ -508,7 +508,7 @@</span><br><span>     uint64_t option_type=
s_found =3D 0;</span><br><span> </span><br><span>     msg(D_PUSH, &quot;PUS=
H: Received control message: &#39;%s&#39;&quot;,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        sanitize_control_message(BSTR(buffer), &=
amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sa=
nitize_control_message(CBSTR(buffer), &amp;gc));</span><br><span> </span><b=
r><span>     int status =3D process_incoming_push_msg(c, buffer, c-&gt;opti=
ons=2Epull, pull_permission_mask(c),</span><br><span>                      =
                      &amp;option_types_found);</span><br><span>@@ -516,7 +=
516,7 @@</span><br><span>     if (status =3D=3D PUSH_MSG_ERROR)</span><br><=
span>     {</span><br><span>         msg(D_PUSH_ERRORS, &quot;WARNING: Rece=
ived bad push/pull message: %s&quot;,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            sanitize_control_message(BSTR(buffer), &amp;gc)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            sanit=
ize_control_message(CBSTR(buffer), &amp;gc));</span><br><span>     }</span>=
<br><span>     else if (status =3D=3D PUSH_MSG_REPLY || status =3D=3D PUSH_=
MSG_UPDATE</span><br><span>              || status =3D=3D PUSH_MSG_CONTINUA=
TION)</span><br><span>diff --git a/src/openvpn/socket=2Ec b/src/openvpn/soc=
ket=2Ec</span><br><span>index 7c6217a=2E=2E7f39268 100644</span><br><span>-=
-- a/src/openvpn/socket=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</s=
pan><br><span>@@ -2446,7 +2446,9 @@</span><br><span>     struct cmsghdr *cm=
sg;</span><br><span>     uint8_t pktinfo_buf[PKTINFO_BUF_SIZE];</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    iov=2Eiov_b=
ase =3D BPTR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* sendmsg takes a const msghdr, but we can&#39;t construct that here</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+       directly, so ca=
st */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    iov=2Eiov_=
base =3D (char *)CBPTR(buf);</span><br><span>     iov=2Eiov_len =3D BLENZ(b=
uf);</span><br><span>     mesg=2Emsg_iov =3D &amp;iov;</span><br><span>    =
 mesg=2Emsg_iovlen =3D 1;</span><br><span>diff --git a/src/openvpn/socket=
=2Eh b/src/openvpn/socket=2Eh</span><br><span>index 89465bc=2E=2Ec6a29f4 10=
0644</span><br><span>--- a/src/openvpn/socket=2Eh</span><br><span>+++ b/src=
/openvpn/socket=2Eh</span><br><span>@@ -709,14 +709,14 @@</span><br><span> =
    }</span><br><span>     else</span><br><span> #endif</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        return sendto(sock-&gt;sd, BPTR(b=
uf), BLENZ(buf), 0, (struct sockaddr *)&amp;to-&gt;dest=2Eaddr=2Esa,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return sendto(sock=
-&gt;sd, CBPTR(buf), BLENZ(buf), 0, (struct sockaddr *)&amp;to-&gt;dest=2Ea=
ddr=2Esa,</span><br><span>                       (socklen_t)af_addr_size(to=
-&gt;dest=2Eaddr=2Esa=2Esa_family));</span><br><span> }</span><br><span> </=
span><br><span> static inline ssize_t</span><br><span> link_socket_write_tc=
p_posix(struct link_socket *sock, struct buffer *buf)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    return send(sock-&gt=
;sd, BPTR(buf), BLENZ(buf), MSG_NOSIGNAL);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return send(sock-&gt;sd, CBPTR(buf), BLENZ(buf),=
 MSG_NOSIGNAL);</span><br><span> }</span><br><span> </span><br><span> #endi=
f /* ifdef _WIN32 */</span><br><span>@@ -761,7 +761,7 @@</span><br><span> {=
</span><br><span>     if (sock &amp;&amp; ipbuf)</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        const struct open=
vpn_iphdr *iph =3D (struct openvpn_iphdr *)BPTR(ipbuf);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        const struct openvpn_iphdr *iph=
 =3D (const struct openvpn_iphdr *)CBPTR(ipbuf);</span><br><span>         s=
ock-&gt;ptos =3D iph-&gt;tos;</span><br><span>         sock-&gt;ptos_define=
d =3D true;</span><br><span>     }</span><br><span>diff --git a/src/openvpn=
/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span>index 6a6d9f9=2E=2E9=
0b2aec 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span=
>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -305,7 +305,7 @@</span><b=
r><span>     }</span><br><span> </span><br><span>     /* get opcode and key=
 ID */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t pkt=
_firstbyte =3D *BPTR(buf);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    uint8_t pkt_firstbyte =3D *CBPTR(buf);</span><br><span>     int =
op =3D pkt_firstbyte &gt;&gt; P_OPCODE_SHIFT;</span><br><span>     int key_=
id =3D pkt_firstbyte &amp; P_KEY_ID_MASK;</span><br><span> </span><br><span=
>diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec</span=
><br><span>index 063fa5d=2E=2E3653eb4 100644</span><br><span>--- a/src/open=
vpn/ssl_verify=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify=2Ec</span><=
br><span>@@ -207,7 +207,7 @@</span><br><span> </span><br><span>         str=
uct cert_hash *ch =3D session-&gt;cert_hash_set-&gt;ch[error_depth];</span>=
<br><span>         ASSERT(sizeof(ch-&gt;sha256_hash) =3D=3D BLEN(cert_hash)=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        memcpy(ch-&=
gt;sha256_hash, BPTR(cert_hash), sizeof(ch-&gt;sha256_hash));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        memcpy(ch-&gt;sha256_hash=
, CBPTR(cert_hash), sizeof(ch-&gt;sha256_hash));</span><br><span>     }</sp=
an><br><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/=
tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec</span><br><span>index 47f5ac5=2E=
=2E23c7975 100644</span><br><span>--- a/src/openvpn/tls_crypt=2Ec</span><br=
><span>+++ b/src/openvpn/tls_crypt=2Ec</span><br><span>@@ -148,7 +148,7 @@<=
/span><br><span> </span><br><span>     gc_init(&amp;gc);</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_PACKET_CONT=
ENT, &quot;TLS-CRYPT WRAP FROM: %s&quot;, format_hex(BPTR(src), BLEN(src), =
80, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    d=
msg(D_PACKET_CONTENT, &quot;TLS-CRYPT WRAP FROM: %s&quot;, format_hex(CBPTR=
(src), BLEN(src), 80, &amp;gc));</span><br><span> </span><br><span>     /* =
Get packet ID */</span><br><span>     if (!packet_id_write(&amp;opt-&gt;pac=
ket_id=2Esend, dst, true, false))</span><br><span>@@ -157,7 +157,7 @@</span=
><br><span>         goto err;</span><br><span>     }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_PACKET_CONTENT,=
 &quot;TLS-CRYPT WRAP AD: %s&quot;, format_hex(BPTR(dst), BLEN(dst), 0, &am=
p;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_P=
ACKET_CONTENT, &quot;TLS-CRYPT WRAP AD: %s&quot;, format_hex(CBPTR(dst), BL=
EN(dst), 0, &amp;gc));</span><br><span> </span><br><span>     /* Buffer ove=
rflow check */</span><br><span>     if (!buf_safe(dst, BLENZ(src) + TLS_CRY=
PT_BLOCK_SIZE + TLS_CRYPT_TAG_SIZE))</span><br><span>@@ -173,8 +173,8 @@</s=
pan><br><span>     {</span><br><span>         uint8_t *tag =3D NULL;</span>=
<br><span>         hmac_ctx_reset(ctx-&gt;hmac);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        hmac_ctx_update(ctx-&gt;hmac, BPTR(dst),=
 BLEN(dst));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        h=
mac_ctx_update(ctx-&gt;hmac, BPTR(src), BLEN(src));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        hmac_ctx_update(ctx-&gt;hmac, CBP=
TR(dst), BLEN(dst));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        hmac_ctx_update(ctx-&gt;hmac, CBPTR(src), BLEN(src));</span><br><s=
pan> </span><br><span>         ASSERT(tag =3D buf_write_alloc(dst, TLS_CRYP=
T_TAG_SIZE));</span><br><span>         hmac_ctx_final(ctx-&gt;hmac, tag);</=
span><br><span>@@ -189,7 +189,7 @@</span><br><span>     /* Encrypt src */</=
span><br><span>     {</span><br><span>         int outlen =3D 0;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(cipher_ctx_update=
(ctx-&gt;cipher, BEND(dst), &amp;outlen, BPTR(src), BLEN(src)));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(cipher_ctx_upda=
te(ctx-&gt;cipher, BEND(dst), &amp;outlen, CBPTR(src), BLEN(src)));</span><=
br><span>         ASSERT(buf_inc_len(dst, outlen));</span><br><span>       =
  ASSERT(cipher_ctx_final(ctx-&gt;cipher, BPTR(dst), &amp;outlen));</span><=
br><span>         ASSERT(buf_inc_len(dst, outlen));</span><br><span>@@ -220=
,7 +220,7 @@</span><br><span>     ASSERT(ctx-&gt;cipher);</span><br><span> =
    ASSERT(packet_id_initialized(&amp;opt-&gt;packet_id) || (opt-&gt;flags =
&amp; CO_IGNORE_PACKET_ID));</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    dmsg(D_PACKET_CONTENT, &quot;TLS-CRYPT UNWRAP =
FROM: %s&quot;, format_hex(BPTR(src), BLEN(src), 80, &amp;gc));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_PACKET_CONTENT, &quo=
t;TLS-CRYPT UNWRAP FROM: %s&quot;, format_hex(CBPTR(src), BLEN(src), 80, &a=
mp;gc));</span><br><span> </span><br><span>     if (BLENZ(src) &lt; TLS_CRY=
PT_OFF_CT)</span><br><span>     {</span><br><span>@@ -237,11 +237,11 @@</sp=
an><br><span>             CRYPT_ERROR(&quot;potential buffer overflow&quot;=
);</span><br><span>         }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        if (!cipher_ctx_reset(ctx-&gt;cipher, BPT=
R(src) + TLS_CRYPT_OFF_TAG))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (!cipher_ctx_reset(ctx-&gt;cipher, CBPTR(src) + TLS_CRY=
PT_OFF_TAG))</span><br><span>         {</span><br><span>             CRYPT_=
ERROR(&quot;cipher reset failed&quot;);</span><br><span>         }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        if (!cipher_ctx_update=
(ctx-&gt;cipher, BPTR(dst), &amp;outlen, BPTR(src) + TLS_CRYPT_OFF_CT,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!cipher_ctx_=
update(ctx-&gt;cipher, BPTR(dst), &amp;outlen, CBPTR(src) + TLS_CRYPT_OFF_C=
T,</span><br><span>                                BLEN(src) - (int)TLS_CRY=
PT_OFF_CT))</span><br><span>         {</span><br><span>             CRYPT_E=
RROR(&quot;cipher update failed&quot;);</span><br><span>@@ -256,17 +256,17 =
@@</span><br><span> </span><br><span>     /* Check authentication */</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   const uint8_t *tag =3D BPTR(src) + TLS_CRYPT_OFF_TAG;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        const uint8_t *tag =3D CBPTR(s=
rc) + TLS_CRYPT_OFF_TAG;</span><br><span>         uint8_t tag_check[TLS_CRY=
PT_TAG_SIZE] =3D { 0 };</span><br><span> </span><br><span>         dmsg(D_P=
ACKET_CONTENT, &quot;TLS-CRYPT UNWRAP AD: %s&quot;,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-             format_hex(BPTR(src), TLS_CRYP=
T_OFF_TAG, 0, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+             format_hex(CBPTR(src), TLS_CRYPT_OFF_TAG, 0, &amp;gc));</=
span><br><span>         dmsg(D_PACKET_CONTENT, &quot;TLS-CRYPT UNWRAP TO: %=
s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
format_hex(BPTR(dst), BLEN(dst), 80, &amp;gc));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+             format_hex(CBPTR(dst), BLEN(dst), =
80, &amp;gc));</span><br><span> </span><br><span>         hmac_ctx_reset(ct=
x-&gt;hmac);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        h=
mac_ctx_update(ctx-&gt;hmac, BPTR(src), TLS_CRYPT_OFF_TAG);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        hmac_ctx_update(ctx-&gt;hmac,=
 BPTR(dst), BLEN(dst));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        hmac_ctx_update(ctx-&gt;hmac, CBPTR(src), TLS_CRYPT_OFF_TAG);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        hmac_ctx_upda=
te(ctx-&gt;hmac, CBPTR(dst), BLEN(dst));</span><br><span>         hmac_ctx_=
final(ctx-&gt;hmac, tag_check);</span><br><span> </span><br><span>         =
if (memcmp_constant_time(tag, tag_check, sizeof(tag_check)))</span><br><spa=
n>@@ -384,7 +384,7 @@</span><br><span>     hmac_ctx_reset(hmac_ctx);</span>=
<br><span>     hmac_ctx_update(hmac_ctx, (void *)&amp;net_len, sizeof(net_l=
en));</span><br><span>     hmac_ctx_update(hmac_ctx, (void *)src_key-&gt;ke=
ys, sizeof(src_key-&gt;keys));</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    hmac_ctx_update(hmac_ctx, BPTR(src_metadata), BLEN(src_metadat=
a));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hmac_ctx_up=
date(hmac_ctx, CBPTR(src_metadata), BLEN(src_metadata));</span><br><span>  =
   hmac_ctx_final(hmac_ctx, tag);</span><br><span> </span><br><span>     dm=
sg(D_CRYPTO_DEBUG, &quot;TLS-CRYPT WRAP TAG: %s&quot;, format_hex(tag, TLS_=
CRYPT_TAG_SIZE, 0, gc));</span><br><span>@@ -405,7 +405,7 @@</span><br><spa=
n>     ASSERT(cipher_ctx_update(cipher_ctx, BEND(&amp;work), &amp;outlen, (=
void *)src_key-&gt;keys,</span><br><span>                              size=
of(src_key-&gt;keys)));</span><br><span>     ASSERT(buf_inc_len(&amp;work, =
outlen));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(c=
ipher_ctx_update(cipher_ctx, BEND(&amp;work), &amp;outlen, BPTR(src_metadat=
a),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(ciphe=
r_ctx_update(cipher_ctx, BEND(&amp;work), &amp;outlen, CBPTR(src_metadata),=
</span><br><span>                              BLEN(src_metadata)));</span>=
<br><span>     ASSERT(buf_inc_len(&amp;work, outlen));</span><br><span>    =
 ASSERT(cipher_ctx_final(cipher_ctx, BEND(&amp;work), &amp;outlen));</span>=
<br><span>@@ -529,7 +529,7 @@</span><br><span>         return false;</span>=
<br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    const uint8_t *metadata =3D buf_bptr(tls_crypt_v2_metadata=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t=
 *metadata =3D CBPTR(tls_crypt_v2_metadata);</span><br><span>     if (*meta=
data !=3D TLS_CRYPT_METADATA_TYPE_TIMESTAMP)</span><br><span>     {</span><=
br><span>         msg(M_WARN, &quot;ERROR: Client key does not have a times=
tamp=2E&quot;);</span><br><span>diff --git a/src/openvpn/tun=2Eh b/src/open=
vpn/tun=2Eh</span><br><span>index 931e54d=2E=2E2477560 100644</span><br><sp=
an>--- a/src/openvpn/tun=2Eh</span><br><span>+++ b/src/openvpn/tun=2Eh</spa=
n><br><span>@@ -504,7 +504,7 @@</span><br><span> static inline bool</span><=
br><span> is_ip_packet_valid(const struct buffer *buf)</span><br><span> {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const struct openvp=
n_iphdr *ih =3D (const struct openvpn_iphdr *)BPTR(buf);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const struct openvpn_iphdr *ih =3D=
 (const struct openvpn_iphdr *)CBPTR(buf);</span><br><span> </span><br><spa=
n>     if (OPENVPN_IPH_GET_VER(ih-&gt;version_len) =3D=3D 4)</span><br><spa=
n>     {</span><br><span>diff --git a/src/openvpn/vlan=2Ec b/src/openvpn/vl=
an=2Ec</span><br><span>index bffc60e=2E=2E69ac10d 100644</span><br><span>--=
- a/src/openvpn/vlan=2Ec</span><br><span>+++ b/src/openvpn/vlan=2Ec</span><=
br><span>@@ -269,7 +269,7 @@</span><br><span>         return false;</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    vlanhdr =3D (const struct openvpn_8021qhdr *)BPTR(buf);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    vlanhdr =3D (const =
struct openvpn_8021qhdr *)CBPTR(buf);</span><br><span> </span><br><span>   =
  if (ntohs(vlanhdr-&gt;tpid) !=3D OPENVPN_ETH_P_8021Q)</span><br><span>   =
  {</span><br><span>diff --git a/tests/unit_tests/openvpn/test_buffer=2Ec b=
/tests/unit_tests/openvpn/test_buffer=2Ec</span><br><span>index 7fb9162=2E=
=2E7bd0c45 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_buffe=
r=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_buffer=2Ec</span>=
<br><span>@@ -51,7 +51,7 @@</span><br><span> </span><br><span> #define asse=
rt_buf_equals_str(buf, str)        \</span><br><span>     assert_int_equal(=
BLENZ(buf), strlen(str)); \</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    assert_memory_equal(BPTR(buf), str, BLENZ(buf));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(CBPTR(buf), =
str, BLENZ(buf));</span><br><span> </span><br><span> static void</span><br>=
<span> test_buffer_printf_catrunc(void **state)</span><br><span>diff --git =
a/tests/unit_tests/openvpn/test_tls_crypt=2Ec b/tests/unit_tests/openvpn/te=
st_tls_crypt=2Ec</span><br><span>index db03437=2E=2Ef648e13 100644</span><b=
r><span>--- a/tests/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>+=
++ b/tests/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>@@ -130,7 =
+130,7 @@</span><br><span> bool</span><br><span> __wrap_buffer_write_file(c=
onst char *filename, const struct buffer *buf)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    const char *pem =3D BSTR(bu=
f);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *=
pem =3D CBSTR(buf);</span><br><span>     check_expected_ptr(filename);</spa=
n><br><span>     check_expected_ptr(pem);</span><br><span> </span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1904?usp=3Demail">change 1904</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1904?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: Ib4af7639cdebe81eba05ab04efe6e8=
5e63de0f9e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1904 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"=
display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>

</body></html>
--512pWxHSG80=--


--===============7091104835325259719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7091104835325259719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7091104835325259719==--

