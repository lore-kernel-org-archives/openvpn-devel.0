Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA3CC88E53
	for <openvpn-devel@archiver.kernel.org>; Sat, 12 Sep 2026 13:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qwa1gTg/1veaEQGicbDdEKd601DO2QC84N+DFYY7jh8=; b=lOPjazxmwDskrfQqIGEQGAa0uQ
	MbsLA5op7dHoVQcQ90t4+2PNYxerP02JjXoZsTGqhLoknHp/DYivu/MY93o2AhDviucrh9fJuXHi3
	NcISjElsAC4biqoXSfmHq1EudkpKneBZALUEJ9WL97GPhzEfs0kGKTpWDeYKwOx/CpjQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5NT7-0000Xe-GW;
	Sat, 12 Sep 2026 13:08:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x5NT5-0000XO-75
 for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 13:08:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=rJc/7lM5/p3ii7wuppQrj3UKVqOKTw8VIEDWFGF3LWM=; b=AF1ZuaW+x7GU+THmRX4kxAkHhJ
 x76PTtdpl5Ks5560kGgIMwD0a0seIKXEEHbBr0ygvIzK0tYUoWo6n3dKR/Qdnqys7XZZfvrxE0NRP
 03zYnx5a9YrXbIv+yjnqQu0fG6G5eII3aYCS0f2lqIC6NQvyx1p4vLJHNrD6GsNsW74s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rJc/7lM5/p3ii7wuppQrj3UKVqOKTw8VIEDWFGF3LWM=; b=T
 YY+Vk0RgCjLfdPTAjxy+YzzVtPPs6My57npHABoC1vSPbfuQmxgBR901HUUAsMHawlaZON7kV6kE5
 WKJmDnsXE8xaiwcHnhAa9ntSbQ1k6XTY9C6IG+k7iFhWktMY2u5yMVOVhvzqZLXxu+3iAPCGurNkk
 p/xFbTQCIkrzXBQ0=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x5NSy-0006iQ-K4 for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 13:08:31 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48586861639so679986f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 12 Sep 2026 06:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789218498; x=1789823298; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rJc/7lM5/p3ii7wuppQrj3UKVqOKTw8VIEDWFGF3LWM=;
 b=GQaHk+sx1Bzl1fOGJDpL0C2YKTPc5cnK1Ri66VCO32bXFi1vkWS+RsuAUHi0jJDI/4
 G2cndT65wP5VMa4mPAhpPGOgZonMzdGH+mapbRxN/6LzrDh8jZhPfVrWtda1K3U9jlV5
 I+myV4ZEG2vR5G7v6JFILGesdDyLCrINmIvEyHNjw0zvCfVfIqzgtT0q91HytCYV5tBA
 d0l1GJVxvtT+xM3y84Nv5wI5r+7A7sUvKT500iqgjdQvTb0z6t18ZTtAJiQIunnmIRn6
 fkdimgEp4cqNRI5hBnxfSKmqz85bRH4HzzzGrahzpG+U3MWoWxa8KIB8km63BdrqBhdM
 R4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789218498; x=1789823298;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rJc/7lM5/p3ii7wuppQrj3UKVqOKTw8VIEDWFGF3LWM=;
 b=m+IgnRSx7mAhQff6ojT5/IzQegQC3tSIckog0w8zH/lyndgbD6GAzl0hGl+sASCAuh
 IX8qtonsEQ28C4G3HFR3pLKVT34VAzKlRg3dOsw2jZ3L+VMWrwZ1SvBq7anKmPV2ZRao
 vhFsiBTjkkhx04WpbmuTWBGZaR4h7iwy0QahwHmeMXCw2w57CtURRcGgdOVLi5k0kYOm
 ux70DuMEYj/eCTfq8Nzcuh5h8AvDi62TBWqpQ7ejvryM50FUEScY8YdFMS16Dqu4eFZq
 0woBOhQTg17lf/zHh/FXXdPGPidPHNzmJ/qVIJlSLaM+/WjIbMDdgxSTi5fB63MOWbNY
 yvfg==
X-Forwarded-Encrypted: i=1;
 AKwUvBys0jBQes/XHKf7CsRDaLvqzxplcMbZjWyMfN8xVQnAu6ycaRZy1VaLs003RIZhBzwa8DZa3duoH4ralo4S@lists.sourceforge.net
X-Gm-Message-State: AFuF++mhcBApulZrvy+7SQRnWzOFdUPtNdj8gHg5JhwHzZoyfXtlOGdY
 NjdYSwLlSfgsDQPf694KD2t7g5Y7k53NEMM0n74nxzSBx05azt3I5hOGMu6YVCaswhUGkznhp1I
 9NY7KUo8bYekP/ZSgA/C8Eisx30rMTocdKeftWvdedzesZwkcdGg2ODtLYZjr4Ql4/EHL
X-Gm-Gg: AYBFou1PkhLvoIwW0KOZaI5XlzKe1ALb+rxEVK4yyxQxW4sT68EG7JsmVbjeRl2K2L4
 NylQgJfazaC1caQsmPt8jw57iEgyafa3EE/UT9kYMtf5NotQv6OBXqjtOh0t8c4CH8ISg9xlqhV
 LKY1W3jJq9XK6toCG9O5dlYb8sOc6wyT2t2Ce3BsnH6vD3GdonF2wyLGRVL1oZL0feWllb+NKc1
 uEAoCPgU9vFp3bglFZjRcBcEKa5zMB93v6On0C6zkvfQgSM19nVLDhjBjNhIBvB2tfG14PDq6LX
 BHV5tB1Gx6vmwes4O7ikRTC3M2l+KHDUF7TCIOQUypxxPu03OpLgHgQW/tlkuis659S4CWb15pE
 UcdjJL2wI25bUpFHcoaZkwtxAoTt8AWEKvfB9BytkkmnxoUasxgEwVzDVmxBSWm1XUweBrdSsRh
 LPdBU9qeNpDSvvdMhIb295NLWWXvtqCzF8P/M3Hi2NUqUS+VR8TpmR/8mMsPDapQ01OAxdX0fvv
 CThg3+rK1kZCvwgXuwmYmZ47Mxafwa9h7/dXsSbU9LQYKEct2yB+UuVc6B0oJYhb26LTDxHDgPs
 n0ZqWEoeKP3+Y75d1Evovge8s55uG0hVJJe3v4HslwzX3fJQkVOoMb6KLoZmUQ==
X-Received: by 2002:a05:6000:38a:b0:485:8226:c699 with SMTP id
 ffacd0b85a97d-486e0f88c98mr17038688f8f.24.1789218497229; 
 Sat, 12 Sep 2026 06:08:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb350686sm13817406f8f.27.2026.09.12.06.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 06:08:16 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 12 Sep 2026 13:08:15 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e
X-Gerrit-Change-Number: 1904
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1904?usp=email>
X-Gerrit-Commit: e031978fd3e33b8f4b4e82d211c070b583e12b56
In-Reply-To: <gerrit.1788815035000.Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e@gerrit.openvpn.net>
References: <gerrit.1788815035000.Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODE1MDM1MDAwLkliNGFmNzYzOWNkZWJlODFlYmEwNWFiMDRlZmU2ZTg1ZTYzZGUwZjllQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <81781cbdd50eef9c6249a4bc5a7e051597eab573-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x5NSy-0006iQ-K4
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1484666397546668515=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1484666397546668515==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9xakRDEVTDs="; charset=UTF-8

--9xakRDEVTDs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1904?usp=3Demail )

Change subject: buffer: When extracting pointers fr=
om buffer, retain const
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

buffer: When extracting pointers from buffer, retain const

Curr=
ently you can use BPTR and similar to implicitly remove
const=2E That avoid=
s some warnings that we should get and
confuses tools like cppcheck into gi=
ving wrong suggestions=2E

So make sure that by default we only return a no=
n-const
pointer if the buffer pointer is not const=2E Change all call
sites=
 that threw warnings=2E

Change-Id: Ib4af7639cdebe81eba05ab04efe6e85e63de0f=
9e
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Raz=
van Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1904
Message-Id: <20260911204513=2E15692-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg39108=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M src/op=
envpn/crypto_backend=2Eh
M src/openvpn/crypto_mbedtls=2Ec
M src/openvpn/cry=
pto_mbedtls_legacy=2Ec
M src/openvpn/crypto_openssl=2Ec
M src/openvpn/forwa=
rd=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/mroute=2Ec
M src/openvpn/prot=
o=2Eh
M src/openvpn/ps=2Ec
M src/openvpn/push=2Ec
M src/openvpn/socket=2Ec
=
M src/openvpn/socket=2Eh
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_verify=
=2Ec
M src/openvpn/tls_crypt=2Ec
M src/openvpn/tun=2Eh
M src/openvpn/vlan=
=2Ec
M tests/unit_tests/openvpn/test_buffer=2Ec
M tests/unit_tests/openvpn/=
test_tls_crypt=2Ec
21 files changed, 165 insertions(+), 98 deletions(-)



=

diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index 5d00415=
=2E=2E21e113d 100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=
=2Ec
@@ -109,7 +109,7 @@
 #endif
     ret=2Edata =3D (uint8_t *)malloc(buf-=
>capacity);
     check_malloc_return(ret=2Edata);
-    memcpy(BPTR(&ret), B=
PTR(buf), BLENZ(buf));
+    memcpy(BPTR(&ret), CBPTR(buf), BLENZ(buf));
   =
  return ret;
 }
 
@@ -162,7 +162,7 @@
     {
         return false;
     }=

-    return buf_write(dest, BPTR(src), BLENZ(src));
+    return buf_write(=
dest, CBPTR(src), BLENZ(src));
 }
 
 void
@@ -293,7 +293,7 @@
         retu=
rn false;
     }
 
-    const ssize_t size =3D write(fd, BPTR(buf), (unsign=
ed int)BLEN(buf));
+    const ssize_t size =3D write(fd, CBPTR(buf), (unsig=
ned int)BLEN(buf));
     if (size !=3D BLEN(buf))
     {
         msg(M_ERR=
NO, "Write error on file '%s'", filename);
@@ -732,7 +732,7 @@
     {
     =
    return false;
     }
-    return memcmp(BPTR(src), match, size) =3D=3D =
0;
+    return memcmp(CBPTR(src), match, size) =3D=3D 0;
 }
 
 bool
@@ -103=
5,13 +1035,13 @@
 }
 
 bool
-string_check_buf(struct buffer *buf, const uns=
igned int inclusive, const unsigned int exclusive)
+string_check_buf(const =
struct buffer *buf, const unsigned int inclusive, const unsigned int exclus=
ive)
 {
     ASSERT(buf);
 
     for (int i =3D 0; i < BLEN(buf); i++)
    =
 {
-        char c =3D BSTR(buf)[i];
+        char c =3D CBSTR(buf)[i];
 
 =
        if (!char_inc_exc(c, inclusive, exclusive))
         {
@@ -1135,7 +=
1135,7 @@
     if (buf && buf->len)
     {
         msglvl_t msglevel =3D D=
_ALIGN_DEBUG;
-        const uintptr_t u =3D (uintptr_t)BPTR(buf);
+       =
 const uintptr_t u =3D (uintptr_t)CBPTR(buf);
 
         if (u & (PAYLOAD_A=
LIGN - 1))
         {
@@ -1393,16 +1393,16 @@
         return NULL;
     }
=
 
-    const uint8_t *seppos =3D memchr(BPTR(buf), sep, buf_len(buf));
+   =
 const uint8_t *seppos =3D memchr(CBPTR(buf), sep, buf_len(buf));
     if (=
!seppos)
     {
         return NULL;
     }
-    size_t field_len =3D sepp=
os - BPTR(buf);
+    size_t field_len =3D seppos - CBPTR(buf);
 
     char =
*field =3D gc_malloc(field_len + 1, false, gc);
 
-    memcpy(field, BPTR(b=
uf), field_len);
+    memcpy(field, CBPTR(buf), field_len);
     field[fiel=
d_len] =3D 0;
 
     buf_advance(buf, field_len + 1);
diff --git a/src/open=
vpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index 0a02e94=2E=2E22a8b74 100644
-=
-- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -136,21 +136,29=
 @@
 
 
 /** Return a pointer to the start of the buffer content=2E @see bu=
f_bptr() */
-#define BPTR(buf)  (buf_bptr(buf))
+#define BPTR(buf)   (buf_b=
ptr(buf))
+/** Return a const pointer to the start of the buffer content=2E=
 @see buf_cbptr() */
+#define CBPTR(buf)  (buf_cbptr(buf))
 /** Return a po=
inter one past the end of the buffer content=2E @see buf_bend() */
-#define=
 BEND(buf)  (buf_bend(buf))
+#define BEND(buf)   (buf_bend(buf))
+/** Retur=
n a const pointer one past the end of the buffer content=2E @see buf_cbend(=
) */
+#define CBEND(buf)  (buf_cbend(buf))
 /** Return a pointer to the las=
t byte of the buffer content, or NULL if empty=2E @see buf_blast() */
-#def=
ine BLAST(buf) (buf_blast(buf))
+#define BLAST(buf)  (buf_blast(buf))
+/** =
Return a const pointer to the last byte of the buffer content, or NULL if e=
mpty=2E @see buf_cblast() */
+#define CBLAST(buf) (buf_cblast(buf))
 /** Re=
turn the length of the buffer content in bytes=2E @see buf_len() */
-#defin=
e BLEN(buf)  (buf_len(buf))
+#define BLEN(buf)   (buf_len(buf))
 /** Return=
 the length of the buffer content as a \c size_t=2E @see buf_len() */
-#def=
ine BLENZ(buf) ((size_t)buf_len(buf))
+#define BLENZ(buf)  ((size_t)buf_len=
(buf))
 /** Return true iff the buffer is defined (has non-NULL data pointe=
r)=2E @see buf_defined() */
-#define BDEF(buf)  (buf_defined(buf))
+#define=
 BDEF(buf)   (buf_defined(buf))
 /** Return the buffer content pointer cast=
 to \c char *=2E @see buf_str() */
-#define BSTR(buf)  (buf_str(buf))
+#def=
ine BSTR(buf)   (buf_str(buf))
+/** Return the buffer content pointer cast =
to \c const char *=2E @see buf_cstr() */
+#define CBSTR(buf)  (buf_cstr(buf=
))
 /** Return the number of bytes available for appending to the buffer=2E=
 @see buf_forward_capacity() */
-#define BCAP(buf)  (buf_forward_capacity(b=
uf))
+#define BCAP(buf)   (buf_forward_capacity(buf))
 
 /**
  * Zeroise an=
d reset a buffer=2E
@@ -407,15 +415,15 @@
 }
 
 /**
- * Return a pointer to=
 the start of the buffer content=2E
+ * Return a const pointer to the start=
 of the buffer content=2E
  *
  * @param buf   The buffer to query=2E
  *
 =
 * @return Pointer to \c buf->data + \c buf->offset, or NULL if \c buf is
 =
 *         not valid=2E
  */
-static inline uint8_t *
-buf_bptr(const struc=
t buffer *buf)
+static inline const uint8_t *
+buf_cbptr(const struct buffe=
r *buf)
 {
     if (buf_valid(buf))
     {
@@ -428,6 +436,20 @@
 }
 
 /**
+=
 * Return a pointer to the start of the buffer content=2E
+ *
+ * @param bu=
f   The buffer to query=2E
+ *
+ * @return Pointer to \c buf->data + \c buf=
->offset, or NULL if \c buf is
+ *         not valid=2E
+ */
+static inline=
 uint8_t *
+buf_bptr(struct buffer *buf)
+{
+    return (uint8_t *)buf_cbpt=
r(buf);
+}
+
+/**
  * Return the length of the buffer content=2E
  *
  * @p=
aram buf   The buffer to query=2E
@@ -455,12 +477,46 @@
  * @return Pointer=
 to the byte immediately after the last content byte=2E
  */
 static inline=
 uint8_t *
-buf_bend(const struct buffer *buf)
+buf_bend(struct buffer *buf=
)
 {
     return buf_bptr(buf) + buf_len(buf);
 }
 
 /**
+ * Return a const=
 pointer one past the end of the buffer content=2E
+ *
+ * @param buf   The=
 buffer to query=2E
+ *
+ * @return Pointer to the byte immediately after t=
he last content byte=2E
+ */
+static inline const uint8_t *
+buf_cbend(cons=
t struct buffer *buf)
+{
+    return buf_cbptr(buf) + buf_len(buf);
+}
+
+/=
**
+ * Return a const pointer to the last byte of the buffer content=2E
+ *=

+ * @param buf   The buffer to query=2E
+ *
+ * @return Pointer to the las=
t byte, or NULL if the buffer is empty or
+ *         invalid=2E
+ */
+stat=
ic inline const uint8_t *
+buf_cblast(const struct buffer *buf)
+{
+    if =
(buf_len(buf) > 0)
+    {
+        return buf_cbptr(buf) + buf_len(buf) - 1=
;
+    }
+    else
+    {
+        return NULL;
+    }
+}
+
+/**
  * Return=
 a pointer to the last byte of the buffer content=2E
  *
  * @param buf   T=
he buffer to query=2E
@@ -469,16 +525,9 @@
  *         invalid=2E
  */
 sta=
tic inline uint8_t *
-buf_blast(const struct buffer *buf)
+buf_blast(struct=
 buffer *buf)
 {
-    if (buf_len(buf) > 0)
-    {
-        return buf_bptr=
(buf) + buf_len(buf) - 1;
-    }
-    else
-    {
-        return NULL;
-  =
  }
+    return (uint8_t *)buf_cblast(buf);
 }
 
 /**
@@ -518,12 +567,25 @@=

  * @return The content pointer as a \c char *, or NULL if \c buf is inval=
id=2E
  */
 static inline char *
-buf_str(const struct buffer *buf)
+buf_st=
r(struct buffer *buf)
 {
     return (char *)buf_bptr(buf);
 }
 
 /**
+ * R=
eturn the buffer content pointer cast to \c const char *=2E
+ *
+ * @param =
buf   The buffer to query=2E
+ *
+ * @return The content pointer as a \c co=
nst char *, or NULL if \c buf is invalid=2E
+ */
+static inline const char =
*
+buf_cstr(const struct buffer *buf)
+{
+    return (const char *)buf_cbpt=
r(buf);
+}
+
+/**
  * Reset a buffer to an undefined (unallocated) state=2E=

  *
  * Sets all fields to zero/NULL without freeing any memory=2E  Use \c=
 free_buf()
@@ -1300,7 +1362,7 @@
 static inline bool
 buf_copy(struct buff=
er *dest, const struct buffer *src)
 {
-    return buf_write(dest, BPTR(src=
), BLENZ(src));
+    return buf_write(dest, CBPTR(src), BLENZ(src));
 }
 
 =
/**
@@ -1427,14 +1489,14 @@
  *         is empty=2E
  */
 static inline int=

-buf_peek_u8(struct buffer *buf)
+buf_peek_u8(const struct buffer *buf)
 {=

     int ret;
     if (BLEN(buf) < 1)
     {
         return -1;
     }
- =
   ret =3D *BPTR(buf);
+    ret =3D *CBPTR(buf);
     return ret;
 }
 
@@ -=
1547,7 +1609,7 @@
 static inline bool
 buf_equal(const struct buffer *a, co=
nst struct buffer *b)
 {
-    return BLEN(a) =3D=3D BLEN(b) && 0 =3D=3D mem=
cmp(BPTR(a), BPTR(b), BLENZ(a));
+    return BLEN(a) =3D=3D BLEN(b) && 0 =
=3D=3D memcmp(CBPTR(a), CBPTR(b), BLENZ(a));
 }
 
 /**
@@ -1561,7 +1623,7 @=
@
     {
         return false;
     }
-    return memcmp(BPTR(src), match,=
 size) =3D=3D 0;
+    return memcmp(CBPTR(src), match, size) =3D=3D 0;
 }
 =

 /**
@@ -1575,7 +1637,7 @@
     {
         return false;
     }
-    retur=
n memcmp(BPTR(src), match, size) =3D=3D 0;
+    return memcmp(CBPTR(src), m=
atch, size) =3D=3D 0;
 }
 
 /**
@@ -1720,7 +1782,7 @@
  * @param exclusive =
Character classes that are not allowed even if they are also in inclusive=
=2E
  * @return True if the string consists only of allowed characters, fal=
se otherwise=2E
  */
-bool string_check_buf(struct buffer *buf, const unsig=
ned int inclusive,
+bool string_check_buf(const struct buffer *buf, const u=
nsigned int inclusive,
                       const unsigned int exclusive)=
;
 
 /**
diff --git a/src/openvpn/crypto_backend=2Eh b/src/openvpn/crypto_b=
ackend=2Eh
index 17085d6=2E=2E7ef6ac4 100644
--- a/src/openvpn/crypto_backe=
nd=2Eh
+++ b/src/openvpn/crypto_backend=2Eh
@@ -445,7 +445,7 @@
  *
  * @re=
turn              \c 0 on failure, \c 1 on success=2E
  */
-int cipher_ctx_=
update(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len, uint8_t *src, int src=
_len);
+int cipher_ctx_update(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len=
, const uint8_t *src, int src_len);
 
 /**
  * Pads the final cipher block =
using PKCS padding, and output to the destination
diff --git a/src/openvpn/=
crypto_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec
index 6662def=2E=2E0c5b=
eb4 100644
--- a/src/openvpn/crypto_mbedtls=2Ec
+++ b/src/openvpn/crypto_mb=
edtls=2Ec
@@ -512,7 +512,7 @@
 }
 
 int
-cipher_ctx_update(cipher_ctx_t *ct=
x, uint8_t *dst, int *dst_len, uint8_t *src, int src_len)
+cipher_ctx_updat=
e(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len, const uint8_t *src, int sr=
c_len)
 {
     if (src_len < 0)
     {
@@ -1093,7 +1093,7 @@
 
     size_t =
out_len =3D 0;
     if (MBEDTLS_ERR_BASE64_BUFFER_TOO_SMALL
-        !=3D m=
bedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(src), NULL, 0, &out=
_len))
+        !=3D mbedtls_pem_write_buffer(header, footer, CBPTR(src), B=
LEN(src), NULL, 0, &out_len))
     {
         return false;
     }
@@ -1101=
,7 +1101,7 @@
     /* We set the size buf to out_len-1 to NOT include the 0=
 byte that
      * mbedtls_pem_write_buffer in its length calculation */
  =
   *dst =3D alloc_buf_gc(out_len, gc);
-    if (!mbed_ok(mbedtls_pem_write_=
buffer(header, footer, BPTR(src), BLEN(src), BPTR(dst),
+    if (!mbed_ok(m=
bedtls_pem_write_buffer(header, footer, CBPTR(src), BLEN(src), BPTR(dst),
 =
                                          BCAP(dst), &out_len))
         ||=
 !(out_len < INT_MAX && out_len > 1)
         || !buf_inc_len(dst, (int)out=
_len - 1))
diff --git a/src/openvpn/crypto_mbedtls_legacy=2Ec b/src/openvpn=
/crypto_mbedtls_legacy=2Ec
index 9e47c26=2E=2Ebbd012f6 100644
--- a/src/ope=
nvpn/crypto_mbedtls_legacy=2Ec
+++ b/src/openvpn/crypto_mbedtls_legacy=2Ec
=
@@ -249,7 +249,7 @@
 
     size_t out_len =3D 0;
     if (MBEDTLS_ERR_BASE6=
4_BUFFER_TOO_SMALL
-        !=3D mbedtls_pem_write_buffer(header, footer, B=
PTR(src), BLEN(src), NULL, 0, &out_len))
+        !=3D mbedtls_pem_write_bu=
ffer(header, footer, CBPTR(src), BLEN(src), NULL, 0, &out_len))
     {
    =
     return false;
     }
@@ -257,7 +257,7 @@
     /* We set the size buf t=
o out_len-1 to NOT include the 0 byte that
      * mbedtls_pem_write_buffer=
 in its length calculation */
     *dst =3D alloc_buf_gc(out_len, gc);
-   =
 if (!mbed_ok(mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(src)=
, BPTR(dst),
+    if (!mbed_ok(mbedtls_pem_write_buffer(header, footer, CBP=
TR(src), BLEN(src), BPTR(dst),
                                           B=
CAP(dst), &out_len))
         || !buf_inc_len(dst, out_len - 1))
     {
@@ =
-684,7 +684,7 @@
 }
 
 int
-cipher_ctx_update(mbedtls_cipher_context_t *ctx=
, uint8_t *dst, int *dst_len, uint8_t *src,
+cipher_ctx_update(mbedtls_ciph=
er_context_t *ctx, uint8_t *dst, int *dst_len, const uint8_t *src,
        =
           int src_len)
 {
     size_t s_dst_len =3D *dst_len;
diff --git a=
/src/openvpn/crypto_openssl=2Ec b/src/openvpn/crypto_openssl=2Ec
index 2019=
280=2E=2E29c5fa6 100644
--- a/src/openvpn/crypto_openssl=2Ec
+++ b/src/open=
vpn/crypto_openssl=2Ec
@@ -465,7 +465,7 @@
 {
     bool ret =3D false;
    =
 BIO *bio =3D BIO_new(BIO_s_mem());
-    if (!bio || !PEM_write_bio(bio, na=
me, "", BPTR(src), BLEN(src)))
+    if (!bio || !PEM_write_bio(bio, name, "=
", CBPTR(src), BLEN(src)))
     {
         ret =3D false;
         goto cle=
anup;
@@ -492,7 +492,7 @@
 {
     bool ret =3D false;
 
-    BIO *bio =3D B=
IO_new_mem_buf((char *)BPTR(src), BLEN(src));
+    BIO *bio =3D BIO_new_mem=
_buf(CBPTR(src), BLEN(src));
     if (!bio)
     {
         crypto_msg(M_FA=
TAL, "Cannot open memory BIO for PEM decode");
@@ -941,7 +941,7 @@
 }
 
 in=
t
-cipher_ctx_update(EVP_CIPHER_CTX *ctx, uint8_t *dst, int *dst_len, uint8=
_t *src, int src_len)
+cipher_ctx_update(EVP_CIPHER_CTX *ctx, uint8_t *dst,=
 int *dst_len, const uint8_t *src, int src_len)
 {
     if (!EVP_CipherUpda=
te(ctx, dst, dst_len, src, src_len))
     {
diff --git a/src/openvpn/forwar=
d=2Ec b/src/openvpn/forward=2Ec
index 2ade321=2E=2Ead43d40 100644
--- a/src=
/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -271,7 +271,7 @@
    =
 }
     else
     {
-        msg(D_PUSH_ERRORS, "WARNING: Received unknown =
control message: %s", BSTR(buf));
+        msg(D_PUSH_ERRORS, "WARNING: Rec=
eived unknown control message: %s", CBSTR(buf));
     }
 }
 
@@ -1646,7 +16=
46,7 @@
             return;
         }
 
-        const struct openvpn_eth=
hdr *orig_ethhdr =3D (struct openvpn_ethhdr *)BPTR(buf);
+        const str=
uct openvpn_ethhdr *orig_ethhdr =3D (const struct openvpn_ethhdr *)CBPTR(bu=
f);
 
         /* Copy frametype and reverse source/destination for the res=
ponse */
         struct openvpn_ethhdr ethhdr;
diff --git a/src/openvpn/ma=
nage=2Ec b/src/openvpn/manage=2Ec
index 310d2e1=2E=2Ec301687 100644
--- a/s=
rc/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -2278,7 +2278,7 @@
 
=
 #ifdef TARGET_ANDROID
 static ssize_t
-man_send_with_fd(int fd, void *ptr,=
 size_t nbytes, int flags, int sendfd)
+man_send_with_fd(int fd, const void=
 *ptr, size_t nbytes, int flags, int sendfd)
 {
     struct msghdr msg =3D =
{ 0 };
     struct iovec iov[1];
@@ -2302,12 +2302,14 @@
     msg=2Emsg_nam=
e =3D NULL;
     msg=2Emsg_namelen =3D 0;
 
-    iov[0]=2Eiov_base =3D ptr;=

+    /* sendmsg takes a const msghdr, but we can't construct that here
+  =
     directly, so cast */
+    iov[0]=2Eiov_base =3D (void *)ptr;
     iov[=
0]=2Eiov_len =3D nbytes;
     msg=2Emsg_iov =3D iov;
     msg=2Emsg_iovlen =
=3D 1;
 
-    return (sendmsg(fd, &msg, flags));
+    return sendmsg(fd, &m=
sg, flags);
 }
 
 static ssize_t
@@ -2512,24 +2514,23 @@
 {
     const int =
size_hint =3D 1024;
     ssize_t sent =3D 0;
-    const struct buffer *buf;=

 
     buffer_list_aggregate(man->connection=2Eout, size_hint);
-    buf =
=3D buffer_list_peek(man->connection=2Eout);
+    const struct buffer *buf =
=3D buffer_list_peek(man->connection=2Eout);
     if (buf && BLEN(buf))
   =
  {
         const int len =3D min_int(size_hint, BLEN(buf));
 #ifdef TARGE=
T_ANDROID
         if (man->connection=2Efdtosend > 0)
         {
-        =
    sent =3D man_send_with_fd(man->connection=2Esd_cli, BPTR(buf), len, MSG=
_NOSIGNAL,
+            sent =3D man_send_with_fd(man->connection=2Esd_cli,=
 CBPTR(buf), len, MSG_NOSIGNAL,
                                     man->c=
onnection=2Efdtosend);
             man->connection=2Efdtosend =3D -1;
    =
     }
         else
 #endif
         {
-            sent =3D send(man->con=
nection=2Esd_cli, (const void *)BPTR(buf), len, MSG_NOSIGNAL);
+           =
 sent =3D send(man->connection=2Esd_cli, CBSTR(buf), len, MSG_NOSIGNAL);
  =
       }
         if (sent >=3D 0)
         {
diff --git a/src/openvpn/mrou=
te=2Ec b/src/openvpn/mroute=2Ec
index edf8239=2E=2E39fa482 100644
--- a/src=
/openvpn/mroute=2Ec
+++ b/src/openvpn/mroute=2Ec
@@ -150,12 +150,12 @@
    =
 unsigned int ret =3D 0;
     if (BLEN(buf) >=3D 1)
     {
-        switch =
(OPENVPN_IPH_GET_VER(*BPTR(buf)))
+        switch (OPENVPN_IPH_GET_VER(*CBP=
TR(buf)))
         {
             case 4:
                 if (BLENZ(buf) >=
=3D sizeof(struct openvpn_iphdr))
                 {
-                    c=
onst struct openvpn_iphdr *ip =3D (const struct openvpn_iphdr *)BPTR(buf);
=
+                    const struct openvpn_iphdr *ip =3D (const struct openv=
pn_iphdr *)CBPTR(buf);
 
                     mroute_get_in_addr_t(src, ip-=
>saddr);
                     mroute_get_in_addr_t(dest, ip->daddr);
@@ -17=
9,7 +179,7 @@
             case 6:
                 if (BLENZ(buf) >=3D siz=
eof(struct openvpn_ipv6hdr))
                 {
-                    const =
struct openvpn_ipv6hdr *ipv6 =3D (const struct openvpn_ipv6hdr *)BPTR(buf);=

+                    const struct openvpn_ipv6hdr *ipv6 =3D (const struct =
openvpn_ipv6hdr *)CBPTR(buf);
 #if 0 /* very basic debug */
               =
      struct gc_arena gc =3D gc_new();
                     msg( M_INFO, "I=
Pv6 packet! src=3D%s, dst=3D%s",
@@ -202,7 +202,7 @@
 
             default=
:
                 msg(M_WARN, "IP packet with unknown IP version=3D%d seen=
",
-                    OPENVPN_IPH_GET_VER(*BPTR(buf)));
+                =
    OPENVPN_IPH_GET_VER(*CBPTR(buf)));
         }
     }
     return ret;
@=
@ -226,7 +226,7 @@
     unsigned int ret =3D 0;
     if (BLEN(buf) >=3D (in=
t)sizeof(struct openvpn_ethhdr))
     {
-        const struct openvpn_ethhd=
r *eth =3D (const struct openvpn_ethhdr *)BPTR(buf);
+        const struct =
openvpn_ethhdr *eth =3D (const struct openvpn_ethhdr *)CBPTR(buf);
        =
 if (src)
         {
             mroute_copy_ether_to_addr(src, eth->sourc=
e, vid);
diff --git a/src/openvpn/proto=2Eh b/src/openvpn/proto=2Eh
index 3=
570582=2E=2E9bb0866 100644
--- a/src/openvpn/proto=2Eh
+++ b/src/openvpn/pr=
oto=2Eh
@@ -258,7 +258,7 @@
         *ip_hdr_offset =3D 0;
         if (lik=
ely(BLEN(buf) >=3D (int)sizeof(struct openvpn_iphdr)))
         {
-        =
    ip_ver =3D OPENVPN_IPH_GET_VER(*BPTR(buf));
+            ip_ver =3D OPE=
NVPN_IPH_GET_VER(*CBPTR(buf));
         }
     }
     else if (tunnel_type =
=3D=3D DEV_TYPE_TAP)
@@ -267,7 +267,7 @@
         /* for tap get ip version=
 from eth header */
         if (likely(BLEN(buf) >=3D *ip_hdr_offset))
   =
      {
-            const struct openvpn_ethhdr *eh =3D (const struct open=
vpn_ethhdr *)BPTR(buf);
+            const struct openvpn_ethhdr *eh =3D (c=
onst struct openvpn_ethhdr *)CBPTR(buf);
             uint16_t proto =3D nt=
ohs(eh->proto);
             if (proto =3D=3D OPENVPN_ETH_P_IPV6)
         =
    {
diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec
index be91a99=2E=
=2E08c2673 100644
--- a/src/openvpn/ps=2Ec
+++ b/src/openvpn/ps=2Ec
@@ -208=
,7 +208,9 @@
 
         if (head)
         {
-            iov[1]=2Eiov_base=
 =3D BPTR(head);
+            /* sendmsg takes a const msghdr, but we can't=
 construct that here
+               directly, so cast */
+            iov[=
1]=2Eiov_base =3D (char *)CBPTR(head);
             iov[1]=2Eiov_len =3D BL=
ENZ(head);
             mesg=2Emsg_iovlen =3D 2;
         }
@@ -964,7 +966,=
7 @@
 bool
 is_openvpn_protocol(const struct buffer *buf)
 {
-    const uns=
igned char *p =3D (const unsigned char *)BSTR(buf);
+    const unsigned cha=
r *p =3D (const unsigned char *)CBSTR(buf);
     const int len =3D BLEN(buf=
);
     if (len >=3D 3)
     {
diff --git a/src/openvpn/push=2Ec b/src/open=
vpn/push=2Ec
index da2bb9f=2E=2E761a59e 100644
--- a/src/openvpn/push=2Ec
+=
++ b/src/openvpn/push=2Ec
@@ -47,7 +47,7 @@
 void
 receive_auth_failed(stru=
ct context *c, const struct buffer *buffer)
 {
-    msg(M_VERB0, "AUTH: Rec=
eived control message: %s", BSTR(buffer));
+    msg(M_VERB0, "AUTH: Receive=
d control message: %s", CBSTR(buffer));
     c->options=2Eno_advance =3D tr=
ue;
 
     if (!c->options=2Epull)
@@ -64,7 +64,7 @@
     const char *reaso=
n =3D NULL;
     if (authfail_extended && BLEN(&buf))
     {
-        reaso=
n =3D BSTR(&buf);
+        reason =3D CBSTR(&buf);
     }
 
     if (authfa=
il_extended && buf_string_match_head_str(&buf, "TEMP"))
@@ -116,7 +116,7 @@=

      */
     if (authfail_extended && buf_string_match_head_str(&buf, "CR=
V1:") && BLEN(&buf))
     {
-        ssl_put_auth_challenge(BSTR(&buf));
+ =
       ssl_put_auth_challenge(CBSTR(&buf));
     }
 #endif /* ifdef ENABLE_=
MANAGEMENT */
 }
@@ -508,7 +508,7 @@
     uint64_t option_types_found =3D 0=
;
 
     msg(D_PUSH, "PUSH: Received control message: '%s'",
-        sanit=
ize_control_message(BSTR(buffer), &gc));
+        sanitize_control_message(=
CBSTR(buffer), &gc));
 
     int status =3D process_incoming_push_msg(c, bu=
ffer, c->options=2Epull, pull_permission_mask(c),
                         =
                   &option_types_found);
@@ -516,7 +516,7 @@
     if (statu=
s =3D=3D PUSH_MSG_ERROR)
     {
         msg(D_PUSH_ERRORS, "WARNING: Recei=
ved bad push/pull message: %s",
-            sanitize_control_message(BSTR(=
buffer), &gc));
+            sanitize_control_message(CBSTR(buffer), &gc));=

     }
     else if (status =3D=3D PUSH_MSG_REPLY || status =3D=3D PUSH_MS=
G_UPDATE
              || status =3D=3D PUSH_MSG_CONTINUATION)
diff --git a=
/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index 7c6217a=2E=2E7f39268=
 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -2446,=
7 +2446,9 @@
     struct cmsghdr *cmsg;
     uint8_t pktinfo_buf[PKTINFO_BU=
F_SIZE];
 
-    iov=2Eiov_base =3D BPTR(buf);
+    /* sendmsg takes a const=
 msghdr, but we can't construct that here
+       directly, so cast */
+   =
 iov=2Eiov_base =3D (char *)CBPTR(buf);
     iov=2Eiov_len =3D BLENZ(buf);
=
     mesg=2Emsg_iov =3D &iov;
     mesg=2Emsg_iovlen =3D 1;
diff --git a/sr=
c/openvpn/socket=2Eh b/src/openvpn/socket=2Eh
index 89465bc=2E=2Ec6a29f4 10=
0644
--- a/src/openvpn/socket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -709,14 +=
709,14 @@
     }
     else
 #endif
-        return sendto(sock->sd, BPTR(bu=
f), BLENZ(buf), 0, (struct sockaddr *)&to->dest=2Eaddr=2Esa,
+        retur=
n sendto(sock->sd, CBPTR(buf), BLENZ(buf), 0, (struct sockaddr *)&to->dest=
=2Eaddr=2Esa,
                       (socklen_t)af_addr_size(to->dest=2Eadd=
r=2Esa=2Esa_family));
 }
 
 static inline ssize_t
 link_socket_write_tcp_po=
six(struct link_socket *sock, struct buffer *buf)
 {
-    return send(sock-=
>sd, BPTR(buf), BLENZ(buf), MSG_NOSIGNAL);
+    return send(sock->sd, CBPTR=
(buf), BLENZ(buf), MSG_NOSIGNAL);
 }
 
 #endif /* ifdef _WIN32 */
@@ -761,7=
 +761,7 @@
 {
     if (sock && ipbuf)
     {
-        const struct openvpn_=
iphdr *iph =3D (struct openvpn_iphdr *)BPTR(ipbuf);
+        const struct o=
penvpn_iphdr *iph =3D (const struct openvpn_iphdr *)CBPTR(ipbuf);
         =
sock->ptos =3D iph->tos;
         sock->ptos_defined =3D true;
     }
diff =
--git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index 6a6d9f9=2E=
=2E90b2aec 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=
=2Ec
@@ -305,7 +305,7 @@
     }
 
     /* get opcode and key ID */
-    uin=
t8_t pkt_firstbyte =3D *BPTR(buf);
+    uint8_t pkt_firstbyte =3D *CBPTR(bu=
f);
     int op =3D pkt_firstbyte >> P_OPCODE_SHIFT;
     int key_id =3D pk=
t_firstbyte & P_KEY_ID_MASK;
 
diff --git a/src/openvpn/ssl_verify=2Ec b/sr=
c/openvpn/ssl_verify=2Ec
index 063fa5d=2E=2E3653eb4 100644
--- a/src/openvp=
n/ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -207,7 +207,7 @@
 
   =
      struct cert_hash *ch =3D session->cert_hash_set->ch[error_depth];
   =
      ASSERT(sizeof(ch->sha256_hash) =3D=3D BLEN(cert_hash));
-        memc=
py(ch->sha256_hash, BPTR(cert_hash), sizeof(ch->sha256_hash));
+        mem=
cpy(ch->sha256_hash, CBPTR(cert_hash), sizeof(ch->sha256_hash));
     }
 }
=
 
diff --git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec
index =
47f5ac5=2E=2E23c7975 100644
--- a/src/openvpn/tls_crypt=2Ec
+++ b/src/openv=
pn/tls_crypt=2Ec
@@ -148,7 +148,7 @@
 
     gc_init(&gc);
 
-    dmsg(D_PAC=
KET_CONTENT, "TLS-CRYPT WRAP FROM: %s", format_hex(BPTR(src), BLEN(src), 80=
, &gc));
+    dmsg(D_PACKET_CONTENT, "TLS-CRYPT WRAP FROM: %s", format_hex(=
CBPTR(src), BLEN(src), 80, &gc));
 
     /* Get packet ID */
     if (!pack=
et_id_write(&opt->packet_id=2Esend, dst, true, false))
@@ -157,7 +157,7 @@
=
         goto err;
     }
 
-    dmsg(D_PACKET_CONTENT, "TLS-CRYPT WRAP AD:=
 %s", format_hex(BPTR(dst), BLEN(dst), 0, &gc));
+    dmsg(D_PACKET_CONTENT=
, "TLS-CRYPT WRAP AD: %s", format_hex(CBPTR(dst), BLEN(dst), 0, &gc));
 
  =
   /* Buffer overflow check */
     if (!buf_safe(dst, BLENZ(src) + TLS_CRY=
PT_BLOCK_SIZE + TLS_CRYPT_TAG_SIZE))
@@ -173,8 +173,8 @@
     {
         ui=
nt8_t *tag =3D NULL;
         hmac_ctx_reset(ctx->hmac);
-        hmac_ctx_=
update(ctx->hmac, BPTR(dst), BLEN(dst));
-        hmac_ctx_update(ctx->hmac=
, BPTR(src), BLEN(src));
+        hmac_ctx_update(ctx->hmac, CBPTR(dst), BL=
EN(dst));
+        hmac_ctx_update(ctx->hmac, CBPTR(src), BLEN(src));
 
   =
      ASSERT(tag =3D buf_write_alloc(dst, TLS_CRYPT_TAG_SIZE));
         hm=
ac_ctx_final(ctx->hmac, tag);
@@ -189,7 +189,7 @@
     /* Encrypt src */
  =
   {
         int outlen =3D 0;
-        ASSERT(cipher_ctx_update(ctx->ciph=
er, BEND(dst), &outlen, BPTR(src), BLEN(src)));
+        ASSERT(cipher_ctx_=
update(ctx->cipher, BEND(dst), &outlen, CBPTR(src), BLEN(src)));
         A=
SSERT(buf_inc_len(dst, outlen));
         ASSERT(cipher_ctx_final(ctx->ciph=
er, BPTR(dst), &outlen));
         ASSERT(buf_inc_len(dst, outlen));
@@ -22=
0,7 +220,7 @@
     ASSERT(ctx->cipher);
     ASSERT(packet_id_initialized(&=
opt->packet_id) || (opt->flags & CO_IGNORE_PACKET_ID));
 
-    dmsg(D_PACKE=
T_CONTENT, "TLS-CRYPT UNWRAP FROM: %s", format_hex(BPTR(src), BLEN(src), 80=
, &gc));
+    dmsg(D_PACKET_CONTENT, "TLS-CRYPT UNWRAP FROM: %s", format_he=
x(CBPTR(src), BLEN(src), 80, &gc));
 
     if (BLENZ(src) < TLS_CRYPT_OFF_C=
T)
     {
@@ -237,11 +237,11 @@
             CRYPT_ERROR("potential buffer =
overflow");
         }
 
-        if (!cipher_ctx_reset(ctx->cipher, BPTR(s=
rc) + TLS_CRYPT_OFF_TAG))
+        if (!cipher_ctx_reset(ctx->cipher, CBPTR=
(src) + TLS_CRYPT_OFF_TAG))
         {
             CRYPT_ERROR("cipher res=
et failed");
         }
-        if (!cipher_ctx_update(ctx->cipher, BPTR(d=
st), &outlen, BPTR(src) + TLS_CRYPT_OFF_CT,
+        if (!cipher_ctx_update=
(ctx->cipher, BPTR(dst), &outlen, CBPTR(src) + TLS_CRYPT_OFF_CT,
          =
                      BLEN(src) - (int)TLS_CRYPT_OFF_CT))
         {
      =
       CRYPT_ERROR("cipher update failed");
@@ -256,17 +256,17 @@
 
     /*=
 Check authentication */
     {
-        const uint8_t *tag =3D BPTR(src) +=
 TLS_CRYPT_OFF_TAG;
+        const uint8_t *tag =3D CBPTR(src) + TLS_CRYPT_=
OFF_TAG;
         uint8_t tag_check[TLS_CRYPT_TAG_SIZE] =3D { 0 };
 
      =
   dmsg(D_PACKET_CONTENT, "TLS-CRYPT UNWRAP AD: %s",
-             format_h=
ex(BPTR(src), TLS_CRYPT_OFF_TAG, 0, &gc));
+             format_hex(CBPTR(s=
rc), TLS_CRYPT_OFF_TAG, 0, &gc));
         dmsg(D_PACKET_CONTENT, "TLS-CRYP=
T UNWRAP TO: %s",
-             format_hex(BPTR(dst), BLEN(dst), 80, &gc));=

+             format_hex(CBPTR(dst), BLEN(dst), 80, &gc));
 
         hmac=
_ctx_reset(ctx->hmac);
-        hmac_ctx_update(ctx->hmac, BPTR(src), TLS_C=
RYPT_OFF_TAG);
-        hmac_ctx_update(ctx->hmac, BPTR(dst), BLEN(dst));
+=
        hmac_ctx_update(ctx->hmac, CBPTR(src), TLS_CRYPT_OFF_TAG);
+       =
 hmac_ctx_update(ctx->hmac, CBPTR(dst), BLEN(dst));
         hmac_ctx_final=
(ctx->hmac, tag_check);
 
         if (memcmp_constant_time(tag, tag_check,=
 sizeof(tag_check)))
@@ -384,7 +384,7 @@
     hmac_ctx_reset(hmac_ctx);
   =
  hmac_ctx_update(hmac_ctx, (void *)&net_len, sizeof(net_len));
     hmac_c=
tx_update(hmac_ctx, (void *)src_key->keys, sizeof(src_key->keys));
-    hma=
c_ctx_update(hmac_ctx, BPTR(src_metadata), BLEN(src_metadata));
+    hmac_c=
tx_update(hmac_ctx, CBPTR(src_metadata), BLEN(src_metadata));
     hmac_ctx=
_final(hmac_ctx, tag);
 
     dmsg(D_CRYPTO_DEBUG, "TLS-CRYPT WRAP TAG: %s"=
, format_hex(tag, TLS_CRYPT_TAG_SIZE, 0, gc));
@@ -405,7 +405,7 @@
     ASS=
ERT(cipher_ctx_update(cipher_ctx, BEND(&work), &outlen, (void *)src_key->ke=
ys,
                              sizeof(src_key->keys)));
     ASSERT(buf_=
inc_len(&work, outlen));
-    ASSERT(cipher_ctx_update(cipher_ctx, BEND(&wo=
rk), &outlen, BPTR(src_metadata),
+    ASSERT(cipher_ctx_update(cipher_ctx,=
 BEND(&work), &outlen, CBPTR(src_metadata),
                              B=
LEN(src_metadata)));
     ASSERT(buf_inc_len(&work, outlen));
     ASSERT(c=
ipher_ctx_final(cipher_ctx, BEND(&work), &outlen));
@@ -529,7 +529,7 @@
   =
      return false;
     }
 
-    const uint8_t *metadata =3D buf_bptr(tls_=
crypt_v2_metadata);
+    const uint8_t *metadata =3D CBPTR(tls_crypt_v2_met=
adata);
     if (*metadata !=3D TLS_CRYPT_METADATA_TYPE_TIMESTAMP)
     {
 =
        msg(M_WARN, "ERROR: Client key does not have a timestamp=2E");
diff=
 --git a/src/openvpn/tun=2Eh b/src/openvpn/tun=2Eh
index 931e54d=2E=2E24775=
60 100644
--- a/src/openvpn/tun=2Eh
+++ b/src/openvpn/tun=2Eh
@@ -504,7 +50=
4,7 @@
 static inline bool
 is_ip_packet_valid(const struct buffer *buf)
 {=

-    const struct openvpn_iphdr *ih =3D (const struct openvpn_iphdr *)BPTR=
(buf);
+    const struct openvpn_iphdr *ih =3D (const struct openvpn_iphdr =
*)CBPTR(buf);
 
     if (OPENVPN_IPH_GET_VER(ih->version_len) =3D=3D 4)
   =
  {
diff --git a/src/openvpn/vlan=2Ec b/src/openvpn/vlan=2Ec
index bffc60e=
=2E=2E69ac10d 100644
--- a/src/openvpn/vlan=2Ec
+++ b/src/openvpn/vlan=2Ec
=
@@ -269,7 +269,7 @@
         return false;
     }
 
-    vlanhdr =3D (const=
 struct openvpn_8021qhdr *)BPTR(buf);
+    vlanhdr =3D (const struct openvp=
n_8021qhdr *)CBPTR(buf);
 
     if (ntohs(vlanhdr->tpid) !=3D OPENVPN_ETH_P=
_8021Q)
     {
diff --git a/tests/unit_tests/openvpn/test_buffer=2Ec b/test=
s/unit_tests/openvpn/test_buffer=2Ec
index 7fb9162=2E=2E7bd0c45 100644
--- =
a/tests/unit_tests/openvpn/test_buffer=2Ec
+++ b/tests/unit_tests/openvpn/t=
est_buffer=2Ec
@@ -51,7 +51,7 @@
 
 #define assert_buf_equals_str(buf, str)=
        \
     assert_int_equal(BLENZ(buf), strlen(str)); \
-    assert_mem=
ory_equal(BPTR(buf), str, BLENZ(buf));
+    assert_memory_equal(CBPTR(buf),=
 str, BLENZ(buf));
 
 static void
 test_buffer_printf_catrunc(void **state)=

diff --git a/tests/unit_tests/openvpn/test_tls_crypt=2Ec b/tests/unit_test=
s/openvpn/test_tls_crypt=2Ec
index db03437=2E=2Ef648e13 100644
--- a/tests/=
unit_tests/openvpn/test_tls_crypt=2Ec
+++ b/tests/unit_tests/openvpn/test_t=
ls_crypt=2Ec
@@ -130,7 +130,7 @@
 bool
 __wrap_buffer_write_file(const char=
 *filename, const struct buffer *buf)
 {
-    const char *pem =3D BSTR(buf)=
;
+    const char *pem =3D CBSTR(buf);
     check_expected_ptr(filename);
 =
    check_expected_ptr(pem);
 

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1904?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-C=
hange-Id: Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e
Gerrit-Change-Number: 1=
904
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>=

Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: r=
azvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>

--9xakRDEVTDs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1904?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">buffer: When extracting pointers from buff=
er, retain const<br><br>Currently you can use BPTR and similar to implicitl=
y remove<br>const=2E That avoids some warnings that we should get and<br>co=
nfuses tools like cppcheck into giving wrong suggestions=2E<br><br>So make =
sure that by default we only return a non-const<br>pointer if the buffer po=
inter is not const=2E Change all call<br>sites that threw warnings=2E<br><b=
r>Change-Id: Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e<br>Signed-off-by: Fr=
ank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1904<br>Message-Id: &lt;20260911204513=2E15692-1-gert@greeni=
e=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lis=
ts=2Esourceforge=2Enet/msg39108=2Ehtml<br>Signed-off-by: Gert Doering &lt;g=
ert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>M src/open=
vpn/buffer=2Eh<br>M src/openvpn/crypto_backend=2Eh<br>M src/openvpn/crypto_=
mbedtls=2Ec<br>M src/openvpn/crypto_mbedtls_legacy=2Ec<br>M src/openvpn/cry=
pto_openssl=2Ec<br>M src/openvpn/forward=2Ec<br>M src/openvpn/manage=2Ec<br=
>M src/openvpn/mroute=2Ec<br>M src/openvpn/proto=2Eh<br>M src/openvpn/ps=2E=
c<br>M src/openvpn/push=2Ec<br>M src/openvpn/socket=2Ec<br>M src/openvpn/so=
cket=2Eh<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_verify=2Ec<br>M =
src/openvpn/tls_crypt=2Ec<br>M src/openvpn/tun=2Eh<br>M src/openvpn/vlan=2E=
c<br>M tests/unit_tests/openvpn/test_buffer=2Ec<br>M tests/unit_tests/openv=
pn/test_tls_crypt=2Ec<br>21 files changed, 165 insertions(+), 98 deletions(=
-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffe=
r=2Ec</span><br><span>index 5d00415=2E=2E21e113d 100644</span><br><span>---=
 a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec</spa=
n><br><span>@@ -109,7 +109,7 @@</span><br><span> #endif</span><br><span>   =
  ret=2Edata =3D (uint8_t *)malloc(buf-&gt;capacity);</span><br><span>     =
check_malloc_return(ret=2Edata);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    memcpy(BPTR(&amp;ret), BPTR(buf), BLENZ(buf));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    memcpy(BPTR(&amp;ret), CBPTR(=
buf), BLENZ(buf));</span><br><span>     return ret;</span><br><span> }</spa=
n><br><span> </span><br><span>@@ -162,7 +162,7 @@</span><br><span>     {</s=
pan><br><span>         return false;</span><br><span>     }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    return buf_write(dest, BPTR(src),=
 BLENZ(src));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn buf_write(dest, CBPTR(src), BLENZ(src));</span><br><span> }</span><br>=
<span> </span><br><span> void</span><br><span>@@ -293,7 +293,7 @@</span><br=
><span>         return false;</span><br><span>     }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    const ssize_t size =3D=
 write(fd, BPTR(buf), (unsigned int)BLEN(buf));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const ssize_t size =3D write(fd, CBPTR(buf)=
, (unsigned int)BLEN(buf));</span><br><span>     if (size !=3D BLEN(buf))</=
span><br><span>     {</span><br><span>         msg(M_ERRNO, &quot;Write err=
or on file &#39;%s&#39;&quot;, filename);</span><br><span>@@ -732,7 +732,7 =
@@</span><br><span>     {</span><br><span>         return false;</span><br>=
<span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retur=
n memcmp(BPTR(src), match, size) =3D=3D 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return memcmp(CBPTR(src), match, size) =3D=3D 0;=
</span><br><span> }</span><br><span> </span><br><span> bool</span><br><span=
>@@ -1035,13 +1035,13 @@</span><br><span> }</span><br><span> </span><br><sp=
an> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-string_check_=
buf(struct buffer *buf, const unsigned int inclusive, const unsigned int ex=
clusive)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+string_chec=
k_buf(const struct buffer *buf, const unsigned int inclusive, const unsigne=
d int exclusive)</span><br><span> {</span><br><span>     ASSERT(buf);</span=
><br><span> </span><br><span>     for (int i =3D 0; i &lt; BLEN(buf); i++)<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        char c =3D BSTR(buf)[i];</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        char c =3D CBSTR(buf)[i];</span><br><span> </span><br=
><span>         if (!char_inc_exc(c, inclusive, exclusive))</span><br><span=
>         {</span><br><span>@@ -1135,7 +1135,7 @@</span><br><span>     if (=
buf &amp;&amp; buf-&gt;len)</span><br><span>     {</span><br><span>        =
 msglvl_t msglevel =3D D_ALIGN_DEBUG;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        const uintptr_t u =3D (uintptr_t)BPTR(buf);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        const uintptr_t u =
=3D (uintptr_t)CBPTR(buf);</span><br><span> </span><br><span>         if (u=
 &amp; (PAYLOAD_ALIGN - 1))</span><br><span>         {</span><br><span>@@ -=
1393,16 +1393,16 @@</span><br><span>         return NULL;</span><br><span> =
    }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    const uint8_t *seppos =3D memchr(BPTR(buf), sep, buf_len(buf));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *seppos=
 =3D memchr(CBPTR(buf), sep, buf_len(buf));</span><br><span>     if (!seppo=
s)</span><br><span>     {</span><br><span>         return NULL;</span><br><=
span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t=
 field_len =3D seppos - BPTR(buf);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    size_t field_len =3D seppos - CBPTR(buf);</span><br><spa=
n> </span><br><span>     char *field =3D gc_malloc(field_len + 1, false, gc=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   memcpy(field, BPTR(buf), field_len);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    memcpy(field, CBPTR(buf), field_len);</span><br><sp=
an>     field[field_len] =3D 0;</span><br><span> </span><br><span>     buf_=
advance(buf, field_len + 1);</span><br><span>diff --git a/src/openvpn/buffe=
r=2Eh b/src/openvpn/buffer=2Eh</span><br><span>index 0a02e94=2E=2E22a8b74 1=
00644</span><br><span>--- a/src/openvpn/buffer=2Eh</span><br><span>+++ b/sr=
c/openvpn/buffer=2Eh</span><br><span>@@ -136,21 +136,29 @@</span><br><span>=
 </span><br><span> </span><br><span> /** Return a pointer to the start of t=
he buffer content=2E @see buf_bptr() */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#define BPTR(buf)  (buf_bptr(buf))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define BPTR(buf)   (buf_bptr(buf))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Return a const pointe=
r to the start of the buffer content=2E @see buf_cbptr() */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define CBPTR(buf)  (buf_cbptr(buf)=
)</span><br><span> /** Return a pointer one past the end of the buffer cont=
ent=2E @see buf_bend() */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define BEND(buf)  (buf_bend(buf))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define BEND(buf)   (buf_bend(buf))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/** Return a const pointer one past the =
end of the buffer content=2E @see buf_cbend() */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define CBEND(buf)  (buf_cbend(buf))</span><br=
><span> /** Return a pointer to the last byte of the buffer content, or NUL=
L if empty=2E @see buf_blast() */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#define BLAST(buf) (buf_blast(buf))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define BLAST(buf)  (buf_blast(buf))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/** Return a const pointer to =
the last byte of the buffer content, or NULL if empty=2E @see buf_cblast() =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CBLAST(bu=
f) (buf_cblast(buf))</span><br><span> /** Return the length of the buffer c=
ontent in bytes=2E @see buf_len() */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define BLEN(buf)  (buf_len(buf))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define BLEN(buf)   (buf_len(buf))</span><br><=
span> /** Return the length of the buffer content as a \c size_t=2E @see bu=
f_len() */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define BLE=
NZ(buf) ((size_t)buf_len(buf))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define BLENZ(buf)  ((size_t)buf_len(buf))</span><br><span> /** =
Return true iff the buffer is defined (has non-NULL data pointer)=2E @see b=
uf_defined() */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defin=
e BDEF(buf)  (buf_defined(buf))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define BDEF(buf)   (buf_defined(buf))</span><br><span> /** Ret=
urn the buffer content pointer cast to \c char *=2E @see buf_str() */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define BSTR(buf)  (buf_str=
(buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define BSTR(=
buf)   (buf_str(buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/** Return the buffer content pointer cast to \c const char *=2E @see buf=
_cstr() */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define C=
BSTR(buf)  (buf_cstr(buf))</span><br><span> /** Return the number of bytes =
available for appending to the buffer=2E @see buf_forward_capacity() */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#define BCAP(buf)  (buf_f=
orward_capacity(buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define BCAP(buf)   (buf_forward_capacity(buf))</span><br><span> </span><=
br><span> /**</span><br><span>  * Zeroise and reset a buffer=2E</span><br><=
span>@@ -407,15 +415,15 @@</span><br><span> }</span><br><span> </span><br><=
span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Return a =
pointer to the start of the buffer content=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Return a const pointer to the start of the buf=
fer content=2E</span><br><span>  *</span><br><span>  * @param buf   The buf=
fer to query=2E</span><br><span>  *</span><br><span>  * @return Pointer to =
\c buf-&gt;data + \c buf-&gt;offset, or NULL if \c buf is</span><br><span> =
 *         not valid=2E</span><br><span>  */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-static inline uint8_t *</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-buf_bptr(const struct buffer *buf)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static inline const uint8_t *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+buf_cbptr(const struct bu=
ffer *buf)</span><br><span> {</span><br><span>     if (buf_valid(buf))</spa=
n><br><span>     {</span><br><span>@@ -428,6 +436,20 @@</span><br><span> }<=
/span><br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Return a pointer to the start of the buffer content=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer to que=
ry=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @return Pointer to \c buf-&g=
t;data + \c buf-&gt;offset, or NULL if \c buf is</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *         not valid=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static inline uint8_t *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+buf_bptr(struct buffer *buf)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    return (uint8_t *)buf_cbptr(buf);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</s=
pan><br><span>  * Return the length of the buffer content=2E</span><br><spa=
n>  *</span><br><span>  * @param buf   The buffer to query=2E</span><br><sp=
an>@@ -455,12 +477,46 @@</span><br><span>  * @return Pointer to the byte im=
mediately after the last content byte=2E</span><br><span>  */</span><br><sp=
an> static inline uint8_t *</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-buf_bend(const struct buffer *buf)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+buf_bend(struct buffer *buf)</span><br><span> {</span>=
<br><span>     return buf_bptr(buf) + buf_len(buf);</span><br><span> }</spa=
n><br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * Return a const pointer one past the end of the buffer con=
tent=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer to=
 query=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return Pointer to the b=
yte immediately after the last content byte=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static inline const uint8_t *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+buf_cbend(const struct buffer *buf)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return buf_cbptr(buf) + buf_len(buf);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return a =
const pointer to the last byte of the buffer content=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param buf   The buffer to query=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @return Pointer to the last byte, or NULL if the bu=
ffer is empty or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
        invalid=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline con=
st uint8_t *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buf_cbl=
ast(const struct buffer *buf)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
buf_len(buf) &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n buf_cbptr(buf) + buf_len(buf) - 1;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return NULL;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/**</span><br><span>  * Return a pointer to the last byte of the buffer =
content=2E</span><br><span>  *</span><br><span>  * @param buf   The buffer =
to query=2E</span><br><span>@@ -469,16 +525,9 @@</span><br><span>  *       =
  invalid=2E</span><br><span>  */</span><br><span> static inline uint8_t *<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-buf_blast(const struct=
 buffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buf_bl=
ast(struct buffer *buf)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (buf_len(buf) &gt; 0)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        return buf_bptr(buf) + buf_len(buf) - 1;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  return NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (uint8_t *=
)buf_cblast(buf);</span><br><span> }</span><br><span> </span><br><span> /**=
</span><br><span>@@ -518,12 +567,25 @@</span><br><span>  * @return The cont=
ent pointer as a \c char *, or NULL if \c buf is invalid=2E</span><br><span=
>  */</span><br><span> static inline char *</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-buf_str(const struct buffer *buf)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+buf_str(struct buffer *buf)</span><br><=
span> {</span><br><span>     return (char *)buf_bptr(buf);</span><br><span>=
 }</span><br><span> </span><br><span> /**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Return the buffer content pointer cast to \c const=
 char *=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer=
 to query=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return The content p=
ointer as a \c const char *, or NULL if \c buf is invalid=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static inline const char *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+buf_cstr(const struct buffer *buf)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return (const char *)buf_cbptr(buf);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span>  * Reset a buffer to an undefined (unal=
located) state=2E</span><br><span>  *</span><br><span>  * Sets all fields t=
o zero/NULL without freeing any memory=2E  Use \c free_buf()</span><br><spa=
n>@@ -1300,7 +1362,7 @@</span><br><span> static inline bool</span><br><span=
> buf_copy(struct buffer *dest, const struct buffer *src)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return buf_write=
(dest, BPTR(src), BLENZ(src));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return buf_write(dest, CBPTR(src), BLENZ(src));</span><br><s=
pan> }</span><br><span> </span><br><span> /**</span><br><span>@@ -1427,14 +=
1489,14 @@</span><br><span>  *         is empty=2E</span><br><span>  */</sp=
an><br><span> static inline int</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-buf_peek_u8(struct buffer *buf)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+buf_peek_u8(const struct buffer *buf)</span><br><span=
> {</span><br><span>     int ret;</span><br><span>     if (BLEN(buf) &lt; 1=
)</span><br><span>     {</span><br><span>         return -1;</span><br><spa=
n>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D *=
BPTR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =
=3D *CBPTR(buf);</span><br><span>     return ret;</span><br><span> }</span>=
<br><span> </span><br><span>@@ -1547,7 +1609,7 @@</span><br><span> static i=
nline bool</span><br><span> buf_equal(const struct buffer *a, const struct =
buffer *b)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    return BLEN(a) =3D=3D BLEN(b) &amp;&amp; 0 =3D=3D memcmp(BPTR(a=
), BPTR(b), BLENZ(a));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return BLEN(a) =3D=3D BLEN(b) &amp;&amp; 0 =3D=3D memcmp(CBPTR(a), C=
BPTR(b), BLENZ(a));</span><br><span> }</span><br><span> </span><br><span> /=
**</span><br><span>@@ -1561,7 +1623,7 @@</span><br><span>     {</span><br><=
span>         return false;</span><br><span>     }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    return memcmp(BPTR(src), match, size) =3D=
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return me=
mcmp(CBPTR(src), match, size) =3D=3D 0;</span><br><span> }</span><br><span>=
 </span><br><span> /**</span><br><span>@@ -1575,7 +1637,7 @@</span><br><spa=
n>     {</span><br><span>         return false;</span><br><span>     }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    return memcmp(BPTR(src=
), match, size) =3D=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return memcmp(CBPTR(src), match, size) =3D=3D 0;</span><br><span>=
 }</span><br><span> </span><br><span> /**</span><br><span>@@ -1720,7 +1782,=
7 @@</span><br><span>  * @param exclusive Character classes that are not al=
lowed even if they are also in inclusive=2E</span><br><span>  * @return Tru=
e if the string consists only of allowed characters, false otherwise=2E</sp=
an><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool=
 string_check_buf(struct buffer *buf, const unsigned int inclusive,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+bool string_check_buf(const=
 struct buffer *buf, const unsigned int inclusive,</span><br><span>        =
               const unsigned int exclusive);</span><br><span> </span><br><=
span> /**</span><br><span>diff --git a/src/openvpn/crypto_backend=2Eh b/src=
/openvpn/crypto_backend=2Eh</span><br><span>index 17085d6=2E=2E7ef6ac4 1006=
44</span><br><span>--- a/src/openvpn/crypto_backend=2Eh</span><br><span>+++=
 b/src/openvpn/crypto_backend=2Eh</span><br><span>@@ -445,7 +445,7 @@</span=
><br><span>  *</span><br><span>  * @return              \c 0 on failure, \c=
 1 on success=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-int cipher_ctx_update(cipher_ctx_t *ctx, uint8_t *dst, int =
*dst_len, uint8_t *src, int src_len);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+int cipher_ctx_update(cipher_ctx_t *ctx, uint8_t *dst, in=
t *dst_len, const uint8_t *src, int src_len);</span><br><span> </span><br><=
span> /**</span><br><span>  * Pads the final cipher block using PKCS paddin=
g, and output to the destination</span><br><span>diff --git a/src/openvpn/c=
rypto_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec</span><br><span>index 66=
62def=2E=2E0c5beb4 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls=
=2Ec</span><br><span>+++ b/src/openvpn/crypto_mbedtls=2Ec</span><br><span>@=
@ -512,7 +512,7 @@</span><br><span> }</span><br><span> </span><br><span> in=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cipher_ctx_update(ci=
pher_ctx_t *ctx, uint8_t *dst, int *dst_len, uint8_t *src, int src_len)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_update(ciphe=
r_ctx_t *ctx, uint8_t *dst, int *dst_len, const uint8_t *src, int src_len)<=
/span><br><span> {</span><br><span>     if (src_len &lt; 0)</span><br><span=
>     {</span><br><span>@@ -1093,7 +1093,7 @@</span><br><span> </span><br><=
span>     size_t out_len =3D 0;</span><br><span>     if (MBEDTLS_ERR_BASE64=
_BUFFER_TOO_SMALL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    !=3D mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(src), NUL=
L, 0, &amp;out_len))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        !=3D mbedtls_pem_write_buffer(header, footer, CBPTR(src), BLEN(src=
), NULL, 0, &amp;out_len))</span><br><span>     {</span><br><span>         =
return false;</span><br><span>     }</span><br><span>@@ -1101,7 +1101,7 @@<=
/span><br><span>     /* We set the size buf to out_len-1 to NOT include the=
 0 byte that</span><br><span>      * mbedtls_pem_write_buffer in its length=
 calculation */</span><br><span>     *dst =3D alloc_buf_gc(out_len, gc);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls=
_pem_write_buffer(header, footer, BPTR(src), BLEN(src), BPTR(dst),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (!mbed_ok(mbedtls_pem=
_write_buffer(header, footer, CBPTR(src), BLEN(src), BPTR(dst),</span><br><=
span>                                           BCAP(dst), &amp;out_len))</=
span><br><span>         || !(out_len &lt; INT_MAX &amp;&amp; out_len &gt; 1=
)</span><br><span>         || !buf_inc_len(dst, (int)out_len - 1))</span><b=
r><span>diff --git a/src/openvpn/crypto_mbedtls_legacy=2Ec b/src/openvpn/cr=
ypto_mbedtls_legacy=2Ec</span><br><span>index 9e47c26=2E=2Ebbd012f6 100644<=
/span><br><span>--- a/src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span=
>+++ b/src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>@@ -249,7 +249=
,7 @@</span><br><span> </span><br><span>     size_t out_len =3D 0;</span><b=
r><span>     if (MBEDTLS_ERR_BASE64_BUFFER_TOO_SMALL</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        !=3D mbedtls_pem_write_buffer(heade=
r, footer, BPTR(src), BLEN(src), NULL, 0, &amp;out_len))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        !=3D mbedtls_pem_write_buffer(=
header, footer, CBPTR(src), BLEN(src), NULL, 0, &amp;out_len))</span><br><s=
pan>     {</span><br><span>         return false;</span><br><span>     }</s=
pan><br><span>@@ -257,7 +257,7 @@</span><br><span>     /* We set the size b=
uf to out_len-1 to NOT include the 0 byte that</span><br><span>      * mbed=
tls_pem_write_buffer in its length calculation */</span><br><span>     *dst=
 =3D alloc_buf_gc(out_len, gc);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    if (!mbed_ok(mbedtls_pem_write_buffer(header, footer, BPTR(sr=
c), BLEN(src), BPTR(dst),</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!mbed_ok(mbedtls_pem_write_buffer(header, footer, CBPTR(src),=
 BLEN(src), BPTR(dst),</span><br><span>                                    =
       BCAP(dst), &amp;out_len))</span><br><span>         || !buf_inc_len(d=
st, out_len - 1))</span><br><span>     {</span><br><span>@@ -684,7 +684,7 @=
@</span><br><span> }</span><br><span> </span><br><span> int</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-cipher_ctx_update(mbedtls_cipher_cont=
ext_t *ctx, uint8_t *dst, int *dst_len, uint8_t *src,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_update(mbedtls_cipher_context_=
t *ctx, uint8_t *dst, int *dst_len, const uint8_t *src,</span><br><span>   =
                int src_len)</span><br><span> {</span><br><span>     size_t=
 s_dst_len =3D *dst_len;</span><br><span>diff --git a/src/openvpn/crypto_op=
enssl=2Ec b/src/openvpn/crypto_openssl=2Ec</span><br><span>index 2019280=2E=
=2E29c5fa6 100644</span><br><span>--- a/src/openvpn/crypto_openssl=2Ec</spa=
n><br><span>+++ b/src/openvpn/crypto_openssl=2Ec</span><br><span>@@ -465,7 =
+465,7 @@</span><br><span> {</span><br><span>     bool ret =3D false;</span=
><br><span>     BIO *bio =3D BIO_new(BIO_s_mem());</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (!bio || !PEM_write_bio(bio, name, &quo=
t;&quot;, BPTR(src), BLEN(src)))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (!bio || !PEM_write_bio(bio, name, &quot;&quot;, CBPTR(=
src), BLEN(src)))</span><br><span>     {</span><br><span>         ret =3D f=
alse;</span><br><span>         goto cleanup;</span><br><span>@@ -492,7 +492=
,7 @@</span><br><span> {</span><br><span>     bool ret =3D false;</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    BIO *bio =
=3D BIO_new_mem_buf((char *)BPTR(src), BLEN(src));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    BIO *bio =3D BIO_new_mem_buf(CBPTR(src),=
 BLEN(src));</span><br><span>     if (!bio)</span><br><span>     {</span><b=
r><span>         crypto_msg(M_FATAL, &quot;Cannot open memory BIO for PEM d=
ecode&quot;);</span><br><span>@@ -941,7 +941,7 @@</span><br><span> }</span>=
<br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-cipher_ctx_update(EVP_CIPHER_CTX *ctx, uint8_t *dst, int *dst_le=
n, uint8_t *src, int src_len)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+cipher_ctx_update(EVP_CIPHER_CTX *ctx, uint8_t *dst, int *dst_len=
, const uint8_t *src, int src_len)</span><br><span> {</span><br><span>     =
if (!EVP_CipherUpdate(ctx, dst, dst_len, src, src_len))</span><br><span>   =
  {</span><br><span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forw=
ard=2Ec</span><br><span>index 2ade321=2E=2Ead43d40 100644</span><br><span>-=
-- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec<=
/span><br><span>@@ -271,7 +271,7 @@</span><br><span>     }</span><br><span>=
     else</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        msg(D_PUSH_ERRORS, &quot;WARNING: Received unknown contr=
ol message: %s&quot;, BSTR(buf));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        msg(D_PUSH_ERRORS, &quot;WARNING: Received unknown co=
ntrol message: %s&quot;, CBSTR(buf));</span><br><span>     }</span><br><spa=
n> }</span><br><span> </span><br><span>@@ -1646,7 +1646,7 @@</span><br><spa=
n>             return;</span><br><span>         }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        const struct openvpn_=
ethhdr *orig_ethhdr =3D (struct openvpn_ethhdr *)BPTR(buf);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        const struct openvpn_ethhdr=
 *orig_ethhdr =3D (const struct openvpn_ethhdr *)CBPTR(buf);</span><br><spa=
n> </span><br><span>         /* Copy frametype and reverse source/destinati=
on for the response */</span><br><span>         struct openvpn_ethhdr ethhd=
r;</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=
=2Ec</span><br><span>index 310d2e1=2E=2Ec301687 100644</span><br><span>--- =
a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span=
><br><span>@@ -2278,7 +2278,7 @@</span><br><span> </span><br><span> #ifdef =
TARGET_ANDROID</span><br><span> static ssize_t</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-man_send_with_fd(int fd, void *ptr, size_t nbytes,=
 int flags, int sendfd)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+man_send_with_fd(int fd, const void *ptr, size_t nbytes, int flags, int=
 sendfd)</span><br><span> {</span><br><span>     struct msghdr msg =3D { 0 =
};</span><br><span>     struct iovec iov[1];</span><br><span>@@ -2302,12 +2=
302,14 @@</span><br><span>     msg=2Emsg_name =3D NULL;</span><br><span>   =
  msg=2Emsg_namelen =3D 0;</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    iov[0]=2Eiov_base =3D ptr;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* sendmsg takes a const msghdr, but =
we can&#39;t construct that here</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+       directly, so cast */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    iov[0]=2Eiov_base =3D (void *)ptr;</span><br><span=
>     iov[0]=2Eiov_len =3D nbytes;</span><br><span>     msg=2Emsg_iov =3D i=
ov;</span><br><span>     msg=2Emsg_iovlen =3D 1;</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    return (sendmsg(fd, &amp;m=
sg, flags));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn sendmsg(fd, &amp;msg, flags);</span><br><span> }</span><br><span> </spa=
n><br><span> static ssize_t</span><br><span>@@ -2512,24 +2514,23 @@</span><=
br><span> {</span><br><span>     const int size_hint =3D 1024;</span><br><s=
pan>     ssize_t sent =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    const struct buffer *buf;</span><br><span> </span><br><span>    =
 buffer_list_aggregate(man-&gt;connection=2Eout, size_hint);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    buf =3D buffer_list_peek(man-&gt=
;connection=2Eout);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const struct buffer *buf =3D buffer_list_peek(man-&gt;connection=2Eout)=
;</span><br><span>     if (buf &amp;&amp; BLEN(buf))</span><br><span>     {=
</span><br><span>         const int len =3D min_int(size_hint, BLEN(buf));<=
/span><br><span> #ifdef TARGET_ANDROID</span><br><span>         if (man-&gt=
;connection=2Efdtosend &gt; 0)</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            sent =3D man_send_with_fd(m=
an-&gt;connection=2Esd_cli, BPTR(buf), len, MSG_NOSIGNAL,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            sent =3D man_send_with_fd=
(man-&gt;connection=2Esd_cli, CBPTR(buf), len, MSG_NOSIGNAL,</span><br><spa=
n>                                     man-&gt;connection=2Efdtosend);</spa=
n><br><span>             man-&gt;connection=2Efdtosend =3D -1;</span><br><s=
pan>         }</span><br><span>         else</span><br><span> #endif</span>=
<br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           sent =3D send(man-&gt;connection=2Esd_cli, (const void *)BPTR(bu=
f), len, MSG_NOSIGNAL);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            sent =3D send(man-&gt;connection=2Esd_cli, CBSTR(buf), len,=
 MSG_NOSIGNAL);</span><br><span>         }</span><br><span>         if (sen=
t &gt;=3D 0)</span><br><span>         {</span><br><span>diff --git a/src/op=
envpn/mroute=2Ec b/src/openvpn/mroute=2Ec</span><br><span>index edf8239=2E=
=2E39fa482 100644</span><br><span>--- a/src/openvpn/mroute=2Ec</span><br><s=
pan>+++ b/src/openvpn/mroute=2Ec</span><br><span>@@ -150,12 +150,12 @@</spa=
n><br><span>     unsigned int ret =3D 0;</span><br><span>     if (BLEN(buf)=
 &gt;=3D 1)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        switch (OPENVPN_IPH_GET_VER(*BPTR(buf)))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        switch (OPENVPN_IPH_GET_V=
ER(*CBPTR(buf)))</span><br><span>         {</span><br><span>             ca=
se 4:</span><br><span>                 if (BLENZ(buf) &gt;=3D sizeof(struct=
 openvpn_iphdr))</span><br><span>                 {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    const struct openvpn_ip=
hdr *ip =3D (const struct openvpn_iphdr *)BPTR(buf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    const struct openvpn_=
iphdr *ip =3D (const struct openvpn_iphdr *)CBPTR(buf);</span><br><span> </=
span><br><span>                     mroute_get_in_addr_t(src, ip-&gt;saddr)=
;</span><br><span>                     mroute_get_in_addr_t(dest, ip-&gt;da=
ddr);</span><br><span>@@ -179,7 +179,7 @@</span><br><span>             case=
 6:</span><br><span>                 if (BLENZ(buf) &gt;=3D sizeof(struct o=
penvpn_ipv6hdr))</span><br><span>                 {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    const struct openvpn_ip=
v6hdr *ipv6 =3D (const struct openvpn_ipv6hdr *)BPTR(buf);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    const struct ope=
nvpn_ipv6hdr *ipv6 =3D (const struct openvpn_ipv6hdr *)CBPTR(buf);</span><b=
r><span> #if 0 /* very basic debug */</span><br><span>                     =
struct gc_arena gc =3D gc_new();</span><br><span>                     msg( =
M_INFO, &quot;IPv6 packet! src=3D%s, dst=3D%s&quot;,</span><br><span>@@ -20=
2,7 +202,7 @@</span><br><span> </span><br><span>             default:</span=
><br><span>                 msg(M_WARN, &quot;IP packet with unknown IP ver=
sion=3D%d seen&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                    OPENVPN_IPH_GET_VER(*BPTR(buf)));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    OPENVPN_IPH_GET_VER(*=
CBPTR(buf)));</span><br><span>         }</span><br><span>     }</span><br><=
span>     return ret;</span><br><span>@@ -226,7 +226,7 @@</span><br><span> =
    unsigned int ret =3D 0;</span><br><span>     if (BLEN(buf) &gt;=3D (int=
)sizeof(struct openvpn_ethhdr))</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        const struct openvpn_ethhdr *eth =
=3D (const struct openvpn_ethhdr *)BPTR(buf);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        const struct openvpn_ethhdr *eth =3D (con=
st struct openvpn_ethhdr *)CBPTR(buf);</span><br><span>         if (src)</s=
pan><br><span>         {</span><br><span>             mroute_copy_ether_to_=
addr(src, eth-&gt;source, vid);</span><br><span>diff --git a/src/openvpn/pr=
oto=2Eh b/src/openvpn/proto=2Eh</span><br><span>index 3570582=2E=2E9bb0866 =
100644</span><br><span>--- a/src/openvpn/proto=2Eh</span><br><span>+++ b/sr=
c/openvpn/proto=2Eh</span><br><span>@@ -258,7 +258,7 @@</span><br><span>   =
      *ip_hdr_offset =3D 0;</span><br><span>         if (likely(BLEN(buf) &=
gt;=3D (int)sizeof(struct openvpn_iphdr)))</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            ip_ver =3D OPEN=
VPN_IPH_GET_VER(*BPTR(buf));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            ip_ver =3D OPENVPN_IPH_GET_VER(*CBPTR(buf));</span><br=
><span>         }</span><br><span>     }</span><br><span>     else if (tunn=
el_type =3D=3D DEV_TYPE_TAP)</span><br><span>@@ -267,7 +267,7 @@</span><br>=
<span>         /* for tap get ip version from eth header */</span><br><span=
>         if (likely(BLEN(buf) &gt;=3D *ip_hdr_offset))</span><br><span>   =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            co=
nst struct openvpn_ethhdr *eh =3D (const struct openvpn_ethhdr *)BPTR(buf);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            const s=
truct openvpn_ethhdr *eh =3D (const struct openvpn_ethhdr *)CBPTR(buf);</sp=
an><br><span>             uint16_t proto =3D ntohs(eh-&gt;proto);</span><br=
><span>             if (proto =3D=3D OPENVPN_ETH_P_IPV6)</span><br><span>  =
           {</span><br><span>diff --git a/src/openvpn/ps=2Ec b/src/openvpn/=
ps=2Ec</span><br><span>index be91a99=2E=2E08c2673 100644</span><br><span>--=
- a/src/openvpn/ps=2Ec</span><br><span>+++ b/src/openvpn/ps=2Ec</span><br><=
span>@@ -208,7 +208,9 @@</span><br><span> </span><br><span>         if (hea=
d)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            iov[1]=2Eiov_base =3D BPTR(head);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* sendmsg takes a const msgh=
dr, but we can&#39;t construct that here</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+               directly, so cast */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            iov[1]=2Eiov_base =3D (cha=
r *)CBPTR(head);</span><br><span>             iov[1]=2Eiov_len =3D BLENZ(he=
ad);</span><br><span>             mesg=2Emsg_iovlen =3D 2;</span><br><span>=
         }</span><br><span>@@ -964,7 +966,7 @@</span><br><span> bool</span>=
<br><span> is_openvpn_protocol(const struct buffer *buf)</span><br><span> {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const unsigned ch=
ar *p =3D (const unsigned char *)BSTR(buf);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const unsigned char *p =3D (const unsigned char=
 *)CBSTR(buf);</span><br><span>     const int len =3D BLEN(buf);</span><br>=
<span>     if (len &gt;=3D 3)</span><br><span>     {</span><br><span>diff -=
-git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>index da=
2bb9f=2E=2E761a59e 100644</span><br><span>--- a/src/openvpn/push=2Ec</span>=
<br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -47,7 +47,7 @@</spa=
n><br><span> void</span><br><span> receive_auth_failed(struct context *c, c=
onst struct buffer *buffer)</span><br><span> {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    msg(M_VERB0, &quot;AUTH: Received control mess=
age: %s&quot;, BSTR(buffer));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    msg(M_VERB0, &quot;AUTH: Received control message: %s&quot;, =
CBSTR(buffer));</span><br><span>     c-&gt;options=2Eno_advance =3D true;</=
span><br><span> </span><br><span>     if (!c-&gt;options=2Epull)</span><br>=
<span>@@ -64,7 +64,7 @@</span><br><span>     const char *reason =3D NULL;</=
span><br><span>     if (authfail_extended &amp;&amp; BLEN(&amp;buf))</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   reason =3D BSTR(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        reason =3D CBSTR(&amp;buf);</span><br><span>     }</span>=
<br><span> </span><br><span>     if (authfail_extended &amp;&amp; buf_strin=
g_match_head_str(&amp;buf, &quot;TEMP&quot;))</span><br><span>@@ -116,7 +11=
6,7 @@</span><br><span>      */</span><br><span>     if (authfail_extended =
&amp;&amp; buf_string_match_head_str(&amp;buf, &quot;CRV1:&quot;) &amp;&amp=
; BLEN(&amp;buf))</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        ssl_put_auth_challenge(BSTR(&amp;buf));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        ssl_put_auth_challen=
ge(CBSTR(&amp;buf));</span><br><span>     }</span><br><span> #endif /* ifde=
f ENABLE_MANAGEMENT */</span><br><span> }</span><br><span>@@ -508,7 +508,7 =
@@</span><br><span>     uint64_t option_types_found =3D 0;</span><br><span>=
 </span><br><span>     msg(D_PUSH, &quot;PUSH: Received control message: &#=
39;%s&#39;&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    sanitize_control_message(BSTR(buffer), &amp;gc));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        sanitize_control_message(CBSTR(bu=
ffer), &amp;gc));</span><br><span> </span><br><span>     int status =3D pro=
cess_incoming_push_msg(c, buffer, c-&gt;options=2Epull, pull_permission_mas=
k(c),</span><br><span>                                            &amp;opti=
on_types_found);</span><br><span>@@ -516,7 +516,7 @@</span><br><span>     i=
f (status =3D=3D PUSH_MSG_ERROR)</span><br><span>     {</span><br><span>   =
      msg(D_PUSH_ERRORS, &quot;WARNING: Received bad push/pull message: %s&=
quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            san=
itize_control_message(BSTR(buffer), &amp;gc));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            sanitize_control_message(CBSTR(buffe=
r), &amp;gc));</span><br><span>     }</span><br><span>     else if (status =
=3D=3D PUSH_MSG_REPLY || status =3D=3D PUSH_MSG_UPDATE</span><br><span>    =
          || status =3D=3D PUSH_MSG_CONTINUATION)</span><br><span>diff --gi=
t a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index 7=
c6217a=2E=2E7f39268 100644</span><br><span>--- a/src/openvpn/socket=2Ec</sp=
an><br><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -2446,7 +2446,=
9 @@</span><br><span>     struct cmsghdr *cmsg;</span><br><span>     uint8_=
t pktinfo_buf[PKTINFO_BUF_SIZE];</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    iov=2Eiov_base =3D BPTR(buf);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* sendmsg takes a const msg=
hdr, but we can&#39;t construct that here</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+       directly, so cast */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    iov=2Eiov_base =3D (char *)CBPTR(buf);</s=
pan><br><span>     iov=2Eiov_len =3D BLENZ(buf);</span><br><span>     mesg=
=2Emsg_iov =3D &amp;iov;</span><br><span>     mesg=2Emsg_iovlen =3D 1;</spa=
n><br><span>diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</s=
pan><br><span>index 89465bc=2E=2Ec6a29f4 100644</span><br><span>--- a/src/o=
penvpn/socket=2Eh</span><br><span>+++ b/src/openvpn/socket=2Eh</span><br><s=
pan>@@ -709,14 +709,14 @@</span><br><span>     }</span><br><span>     else<=
/span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        return sendto(sock-&gt;sd, BPTR(buf), BLENZ(buf), 0, (struct sock=
addr *)&amp;to-&gt;dest=2Eaddr=2Esa,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return sendto(sock-&gt;sd, CBPTR(buf), BLENZ(buf),=
 0, (struct sockaddr *)&amp;to-&gt;dest=2Eaddr=2Esa,</span><br><span>      =
                 (socklen_t)af_addr_size(to-&gt;dest=2Eaddr=2Esa=2Esa_famil=
y));</span><br><span> }</span><br><span> </span><br><span> static inline ss=
ize_t</span><br><span> link_socket_write_tcp_posix(struct link_socket *sock=
, struct buffer *buf)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    return send(sock-&gt;sd, BPTR(buf), BLENZ(buf), MSG_=
NOSIGNAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n send(sock-&gt;sd, CBPTR(buf), BLENZ(buf), MSG_NOSIGNAL);</span><br><span>=
 }</span><br><span> </span><br><span> #endif /* ifdef _WIN32 */</span><br><=
span>@@ -761,7 +761,7 @@</span><br><span> {</span><br><span>     if (sock &=
amp;&amp; ipbuf)</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        const struct openvpn_iphdr *iph =3D (struct openv=
pn_iphdr *)BPTR(ipbuf);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        const struct openvpn_iphdr *iph =3D (const struct openvpn_iphdr=
 *)CBPTR(ipbuf);</span><br><span>         sock-&gt;ptos =3D iph-&gt;tos;</s=
pan><br><span>         sock-&gt;ptos_defined =3D true;</span><br><span>    =
 }</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_p=
kt=2Ec</span><br><span>index 6a6d9f9=2E=2E90b2aec 100644</span><br><span>--=
- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</=
span><br><span>@@ -305,7 +305,7 @@</span><br><span>     }</span><br><span> =
</span><br><span>     /* get opcode and key ID */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    uint8_t pkt_firstbyte =3D *BPTR(buf);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t pkt_firstbyte=
 =3D *CBPTR(buf);</span><br><span>     int op =3D pkt_firstbyte &gt;&gt; P_=
OPCODE_SHIFT;</span><br><span>     int key_id =3D pkt_firstbyte &amp; P_KEY=
_ID_MASK;</span><br><span> </span><br><span>diff --git a/src/openvpn/ssl_ve=
rify=2Ec b/src/openvpn/ssl_verify=2Ec</span><br><span>index 063fa5d=2E=2E36=
53eb4 100644</span><br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><sp=
an>+++ b/src/openvpn/ssl_verify=2Ec</span><br><span>@@ -207,7 +207,7 @@</sp=
an><br><span> </span><br><span>         struct cert_hash *ch =3D session-&g=
t;cert_hash_set-&gt;ch[error_depth];</span><br><span>         ASSERT(sizeof=
(ch-&gt;sha256_hash) =3D=3D BLEN(cert_hash));</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        memcpy(ch-&gt;sha256_hash, BPTR(cert_hash),=
 sizeof(ch-&gt;sha256_hash));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        memcpy(ch-&gt;sha256_hash, CBPTR(cert_hash), sizeof(ch-&g=
t;sha256_hash));</span><br><span>     }</span><br><span> }</span><br><span>=
 </span><br><span>diff --git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_=
crypt=2Ec</span><br><span>index 47f5ac5=2E=2E23c7975 100644</span><br><span=
>--- a/src/openvpn/tls_crypt=2Ec</span><br><span>+++ b/src/openvpn/tls_cryp=
t=2Ec</span><br><span>@@ -148,7 +148,7 @@</span><br><span> </span><br><span=
>     gc_init(&amp;gc);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    dmsg(D_PACKET_CONTENT, &quot;TLS-CRYPT WRAP FROM: %=
s&quot;, format_hex(BPTR(src), BLEN(src), 80, &amp;gc));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_PACKET_CONTENT, &quot;TLS-C=
RYPT WRAP FROM: %s&quot;, format_hex(CBPTR(src), BLEN(src), 80, &amp;gc));<=
/span><br><span> </span><br><span>     /* Get packet ID */</span><br><span>=
     if (!packet_id_write(&amp;opt-&gt;packet_id=2Esend, dst, true, false))=
</span><br><span>@@ -157,7 +157,7 @@</span><br><span>         goto err;</sp=
an><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    dmsg(D_PACKET_CONTENT, &quot;TLS-CRYPT WRAP AD: %s&quot=
;, format_hex(BPTR(dst), BLEN(dst), 0, &amp;gc));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    dmsg(D_PACKET_CONTENT, &quot;TLS-CRYPT WR=
AP AD: %s&quot;, format_hex(CBPTR(dst), BLEN(dst), 0, &amp;gc));</span><br>=
<span> </span><br><span>     /* Buffer overflow check */</span><br><span>  =
   if (!buf_safe(dst, BLENZ(src) + TLS_CRYPT_BLOCK_SIZE + TLS_CRYPT_TAG_SIZ=
E))</span><br><span>@@ -173,8 +173,8 @@</span><br><span>     {</span><br><s=
pan>         uint8_t *tag =3D NULL;</span><br><span>         hmac_ctx_reset=
(ctx-&gt;hmac);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  hmac_ctx_update(ctx-&gt;hmac, BPTR(dst), BLEN(dst));</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        hmac_ctx_update(ctx-&gt;hmac, BPTR=
(src), BLEN(src));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       hmac_ctx_update(ctx-&gt;hmac, CBPTR(dst), BLEN(dst));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        hmac_ctx_update(ctx-&gt;hm=
ac, CBPTR(src), BLEN(src));</span><br><span> </span><br><span>         ASSE=
RT(tag =3D buf_write_alloc(dst, TLS_CRYPT_TAG_SIZE));</span><br><span>     =
    hmac_ctx_final(ctx-&gt;hmac, tag);</span><br><span>@@ -189,7 +189,7 @@<=
/span><br><span>     /* Encrypt src */</span><br><span>     {</span><br><sp=
an>         int outlen =3D 0;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        ASSERT(cipher_ctx_update(ctx-&gt;cipher, BEND(dst), &amp;ou=
tlen, BPTR(src), BLEN(src)));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        ASSERT(cipher_ctx_update(ctx-&gt;cipher, BEND(dst), &amp;=
outlen, CBPTR(src), BLEN(src)));</span><br><span>         ASSERT(buf_inc_le=
n(dst, outlen));</span><br><span>         ASSERT(cipher_ctx_final(ctx-&gt;c=
ipher, BPTR(dst), &amp;outlen));</span><br><span>         ASSERT(buf_inc_le=
n(dst, outlen));</span><br><span>@@ -220,7 +220,7 @@</span><br><span>     A=
SSERT(ctx-&gt;cipher);</span><br><span>     ASSERT(packet_id_initialized(&a=
mp;opt-&gt;packet_id) || (opt-&gt;flags &amp; CO_IGNORE_PACKET_ID));</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D=
_PACKET_CONTENT, &quot;TLS-CRYPT UNWRAP FROM: %s&quot;, format_hex(BPTR(src=
), BLEN(src), 80, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    dmsg(D_PACKET_CONTENT, &quot;TLS-CRYPT UNWRAP FROM: %s&quot;, =
format_hex(CBPTR(src), BLEN(src), 80, &amp;gc));</span><br><span> </span><b=
r><span>     if (BLENZ(src) &lt; TLS_CRYPT_OFF_CT)</span><br><span>     {</=
span><br><span>@@ -237,11 +237,11 @@</span><br><span>             CRYPT_ERR=
OR(&quot;potential buffer overflow&quot;);</span><br><span>         }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (!cipher_ctx_reset(ctx-&gt;cipher, BPTR(src) + TLS_CRYPT_OFF_TAG))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!cipher_ctx_re=
set(ctx-&gt;cipher, CBPTR(src) + TLS_CRYPT_OFF_TAG))</span><br><span>      =
   {</span><br><span>             CRYPT_ERROR(&quot;cipher reset failed&quo=
t;);</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (!cipher_ctx_update(ctx-&gt;cipher, BPTR(dst), &amp;ou=
tlen, BPTR(src) + TLS_CRYPT_OFF_CT,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (!cipher_ctx_update(ctx-&gt;cipher, BPTR(dst), &=
amp;outlen, CBPTR(src) + TLS_CRYPT_OFF_CT,</span><br><span>                =
                BLEN(src) - (int)TLS_CRYPT_OFF_CT))</span><br><span>       =
  {</span><br><span>             CRYPT_ERROR(&quot;cipher update failed&quo=
t;);</span><br><span>@@ -256,17 +256,17 @@</span><br><span> </span><br><spa=
n>     /* Check authentication */</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        const uint8_t *tag =3D BPTR(src)=
 + TLS_CRYPT_OFF_TAG;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        const uint8_t *tag =3D CBPTR(src) + TLS_CRYPT_OFF_TAG;</span><br>=
<span>         uint8_t tag_check[TLS_CRYPT_TAG_SIZE] =3D { 0 };</span><br><=
span> </span><br><span>         dmsg(D_PACKET_CONTENT, &quot;TLS-CRYPT UNWR=
AP AD: %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
        format_hex(BPTR(src), TLS_CRYPT_OFF_TAG, 0, &amp;gc));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+             format_hex(CBPTR(sr=
c), TLS_CRYPT_OFF_TAG, 0, &amp;gc));</span><br><span>         dmsg(D_PACKET=
_CONTENT, &quot;TLS-CRYPT UNWRAP TO: %s&quot;,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-             format_hex(BPTR(dst), BLEN(dst), 80, =
&amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
    format_hex(CBPTR(dst), BLEN(dst), 80, &amp;gc));</span><br><span> </spa=
n><br><span>         hmac_ctx_reset(ctx-&gt;hmac);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        hmac_ctx_update(ctx-&gt;hmac, BPTR(src=
), TLS_CRYPT_OFF_TAG);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        hmac_ctx_update(ctx-&gt;hmac, BPTR(dst), BLEN(dst));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        hmac_ctx_update(ctx-&gt;h=
mac, CBPTR(src), TLS_CRYPT_OFF_TAG);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        hmac_ctx_update(ctx-&gt;hmac, CBPTR(dst), BLEN(dst=
));</span><br><span>         hmac_ctx_final(ctx-&gt;hmac, tag_check);</span=
><br><span> </span><br><span>         if (memcmp_constant_time(tag, tag_che=
ck, sizeof(tag_check)))</span><br><span>@@ -384,7 +384,7 @@</span><br><span=
>     hmac_ctx_reset(hmac_ctx);</span><br><span>     hmac_ctx_update(hmac_c=
tx, (void *)&amp;net_len, sizeof(net_len));</span><br><span>     hmac_ctx_u=
pdate(hmac_ctx, (void *)src_key-&gt;keys, sizeof(src_key-&gt;keys));</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_update(hmac_ctx=
, BPTR(src_metadata), BLEN(src_metadata));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    hmac_ctx_update(hmac_ctx, CBPTR(src_metadata), B=
LEN(src_metadata));</span><br><span>     hmac_ctx_final(hmac_ctx, tag);</sp=
an><br><span> </span><br><span>     dmsg(D_CRYPTO_DEBUG, &quot;TLS-CRYPT WR=
AP TAG: %s&quot;, format_hex(tag, TLS_CRYPT_TAG_SIZE, 0, gc));</span><br><s=
pan>@@ -405,7 +405,7 @@</span><br><span>     ASSERT(cipher_ctx_update(ciphe=
r_ctx, BEND(&amp;work), &amp;outlen, (void *)src_key-&gt;keys,</span><br><s=
pan>                              sizeof(src_key-&gt;keys)));</span><br><sp=
an>     ASSERT(buf_inc_len(&amp;work, outlen));</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    ASSERT(cipher_ctx_update(cipher_ctx, BEND(&am=
p;work), &amp;outlen, BPTR(src_metadata),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ASSERT(cipher_ctx_update(cipher_ctx, BEND(&amp;wo=
rk), &amp;outlen, CBPTR(src_metadata),</span><br><span>                    =
          BLEN(src_metadata)));</span><br><span>     ASSERT(buf_inc_len(&am=
p;work, outlen));</span><br><span>     ASSERT(cipher_ctx_final(cipher_ctx, =
BEND(&amp;work), &amp;outlen));</span><br><span>@@ -529,7 +529,7 @@</span><=
br><span>         return false;</span><br><span>     }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    const uint8_t *metad=
ata =3D buf_bptr(tls_crypt_v2_metadata);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const uint8_t *metadata =3D CBPTR(tls_crypt_v2_met=
adata);</span><br><span>     if (*metadata !=3D TLS_CRYPT_METADATA_TYPE_TIM=
ESTAMP)</span><br><span>     {</span><br><span>         msg(M_WARN, &quot;E=
RROR: Client key does not have a timestamp=2E&quot;);</span><br><span>diff =
--git a/src/openvpn/tun=2Eh b/src/openvpn/tun=2Eh</span><br><span>index 931=
e54d=2E=2E2477560 100644</span><br><span>--- a/src/openvpn/tun=2Eh</span><b=
r><span>+++ b/src/openvpn/tun=2Eh</span><br><span>@@ -504,7 +504,7 @@</span=
><br><span> static inline bool</span><br><span> is_ip_packet_valid(const st=
ruct buffer *buf)</span><br><span> {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    const struct openvpn_iphdr *ih =3D (const struct openvpn=
_iphdr *)BPTR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const struct openvpn_iphdr *ih =3D (const struct openvpn_iphdr *)CBPTR(=
buf);</span><br><span> </span><br><span>     if (OPENVPN_IPH_GET_VER(ih-&gt=
;version_len) =3D=3D 4)</span><br><span>     {</span><br><span>diff --git a=
/src/openvpn/vlan=2Ec b/src/openvpn/vlan=2Ec</span><br><span>index bffc60e=
=2E=2E69ac10d 100644</span><br><span>--- a/src/openvpn/vlan=2Ec</span><br><=
span>+++ b/src/openvpn/vlan=2Ec</span><br><span>@@ -269,7 +269,7 @@</span><=
br><span>         return false;</span><br><span>     }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    vlanhdr =3D (const s=
truct openvpn_8021qhdr *)BPTR(buf);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    vlanhdr =3D (const struct openvpn_8021qhdr *)CBPTR(buf)=
;</span><br><span> </span><br><span>     if (ntohs(vlanhdr-&gt;tpid) !=3D O=
PENVPN_ETH_P_8021Q)</span><br><span>     {</span><br><span>diff --git a/tes=
ts/unit_tests/openvpn/test_buffer=2Ec b/tests/unit_tests/openvpn/test_buffe=
r=2Ec</span><br><span>index 7fb9162=2E=2E7bd0c45 100644</span><br><span>---=
 a/tests/unit_tests/openvpn/test_buffer=2Ec</span><br><span>+++ b/tests/uni=
t_tests/openvpn/test_buffer=2Ec</span><br><span>@@ -51,7 +51,7 @@</span><br=
><span> </span><br><span> #define assert_buf_equals_str(buf, str)        \<=
/span><br><span>     assert_int_equal(BLENZ(buf), strlen(str)); \</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    assert_memory_equal(BPTR(bu=
f), str, BLENZ(buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_memory_equal(CBPTR(buf), str, BLENZ(buf));</span><br><span> </=
span><br><span> static void</span><br><span> test_buffer_printf_catrunc(voi=
d **state)</span><br><span>diff --git a/tests/unit_tests/openvpn/test_tls_c=
rypt=2Ec b/tests/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>inde=
x db03437=2E=2Ef648e13 100644</span><br><span>--- a/tests/unit_tests/openvp=
n/test_tls_crypt=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_tl=
s_crypt=2Ec</span><br><span>@@ -130,7 +130,7 @@</span><br><span> bool</span=
><br><span> __wrap_buffer_write_file(const char *filename, const struct buf=
fer *buf)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    const char *pem =3D BSTR(buf);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const char *pem =3D CBSTR(buf);</span><br><span> =
    check_expected_ptr(filename);</span><br><span>     check_expected_ptr(p=
em);</span><br><span> </span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904?usp=3Demail">chang=
e 1904</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 1904 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld =
&lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--9xakRDEVTDs=--


--===============1484666397546668515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1484666397546668515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1484666397546668515==--

