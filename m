Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1D6606A324
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jNEC1fep;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hUqdw9dJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=miXgfbjw;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=hF3d+1s3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pIZZkq+2aEA3jSUr4TaPCQUNRHlzb0HacBmPFJgZV5s=; b=jNEC1fepnzp3WcgFOyQnaAC99/
	ZYxwqt8ou61j8wFLA7ZMXX9jU+1FTupnW5oHbaaO9dUuxQfeHnwOo3qqWJc00tbfEc5EiK0QywQ3n
	cxin0OqFI4k4dsNURyi9OJb2RYjPySHmXkDz9JBIicHGCfEzq4nwbBdDriq14Ef9+Pjs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNpgy-000000000x1-334R;
	Mon, 02 Nov 2026 10:55:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNpgx-000000000wq-3jW8
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 10:55:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EdyEDxDLx2P8YWjeCevwyhrX+gpFGQW7RQ4ywfErrS8=; b=hUqdw9dJQUlEGJ5QxeSTNLnTdD
 SDe4Vw9+S9VdMYDRK3Oq6UzWhrxFHgEXkBA5z9Ucu9MZe/nfxU66VERjtn2xVBWkyrKTFsTi611wl
 lxgVx7mUBc7FnoCBYUCdDY5stFJgxGa78gEwIsQ4nmrXVMKKXhmjPhwnV5ltJhRGjtwc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EdyEDxDLx2P8YWjeCevwyhrX+gpFGQW7RQ4ywfErrS8=; b=miXgfbjwPrncyuEd3Id39sMB1e
 aRwyJIgfT/rmlT1TyoOCKq7odHzy87IbIlc3Xz5Nv0KS4osNCRld3v9wRzPx2GpE8L7x7mF5JD9T8
 rauPi8K1CUe1aCC4E+tXg6OaOaa5m3W4T0jRBkKEiqZlZRWbfLeUoi4lKD0xK6aUBcmE=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNpgw-000000003r7-17sQ for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 10:55:07 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so36820335e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 02:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793616900; x=1794221700; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EdyEDxDLx2P8YWjeCevwyhrX+gpFGQW7RQ4ywfErrS8=;
 b=hF3d+1s3kd/x2TZEY8ueitFG/iCUAih0frSxmdkJ5qI1GF/zSBdTHaRs1waY/DASuG
 T0uRACmKM2W2f57SpAKBi2VBLFnrsjzledwVTPgYBUll9CaRFHaIfH7ho8prH+pW+Rei
 hGqGOQogKQK71K2zopnrWfdr8HWjLp1I055p82yQ9V3GUaP4XibYeWP8xCpcykKd4apK
 GaWFPYvwlSOnfe1bFzvZUqPgB7TfcwgtfAHlKMDZ/Q00qaKH2W0V2NEjmoVtnay9fxVG
 x0Fmxdq/WiM+C85K029fY5ykH+1M9mFE7uRmS9UMvZhCaTtw4glir6nWtEiZB8gMHFN3
 SxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793616900; x=1794221700;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EdyEDxDLx2P8YWjeCevwyhrX+gpFGQW7RQ4ywfErrS8=;
 b=Nit9uwMq8iCvmADZjaso0/qVE5P2YZL2TMR51GkDUvGKItF2H5x3wJsJuEKxiGaPr/
 pziFdT776+k2nnUjo4fjVevDhjVw0XywvtvUl3VPYapW2iitTtr+nX4+dCKh7BL+sLQ8
 Phf+bTekFKXjmrxAwnE6iuXP8sS9WuMW7WDVl2l0mSSt3KOD+KK6cUnhc2kq4y4f2l3S
 ZP/jGIVv2dw6nSHuo0Pehlo6LNdkckhWtQiNvjAaXcj3NpZ2iJ7JPSYkbTnTYAPouK2C
 GLvLwU7yBQ+3kNrd6TZhkvY9k5M8rHMVMJlFR63EU7v1ks1C3llpQBVGlOR2x5efaVPB
 jojQ==
X-Gm-Message-State: AFq9FYIH4KGCS3JRjJHH0z5mBvNcTuxUIGdW0fnoXY+0yyLf8OD3S/SQ
 Ec/cWSuy2PWhmP9CaAMNNN/VaLfvMPdp8LMmnRVWAVAKcSlSz2dR2k0OeRd7ieiuCnF4PY+RV6X
 hZkWjtuu/icPi9ivOK29cmsHWn2cZqTfzFHLQD8Z6F3pgI9RLv4/eV7GNm5oAgupwf1Um
X-Gm-Gg: AYBFou1MP7b3bdekWG9GL1DYnmGpFlrVVrv11LzTsUHy/KZXLQ8nGpKsiG48NzoB4QO
 scYZ/4cIJbRCHEfqMkhbhM22IlSBo1p3AQIluVnRocggMZJJ+vl74QA9reE6KVutsNV4IHLzwMQ
 BkGUfD4oBh75u6HwtbnpoolF2zHzuCo+4MGSTSUHB+8X9HMrXgqNBgmZCUEAmHbjQYhWOgiBIdx
 l97gxBnkz8WMy2NnvpeuwpRYV91Ov3Tu1RpJDhgQWnfdVVpyx8Vv8C69tKLIPq/FvOIv/LdtKXd
 IvboorMQIok8wyc2SzCDeUz6hKA/YSyt80VFKcGXSHxUoyLoqbKGEL0I3w1Odn70x4B3JlgjhUb
 gRu/uCzW0Tx3ivEhgRd3OYC2LU24enWVphUD2HaEOK55op12paVEfv7swtwZqnGo4AdZRjlohbg
 Wnz3Cq8LwhiGAyLKjpH8wd5zOw/aJq2TNldTs4dwPfEPLNSKb4OgXvqSr0qwW+MTYOGapPFLJf2
 1ca/kwtgbWvfSELcmah4sZ6TC3wGmVhk4nNMC5bVKV07Ig+YQAsBFzaZkuSY6SRVCcTU2Too28X
 /LHoD+Zcwyi2mZkGl7pCyv5MWm3lnlbBDUIkM+lZ34h8Oe7gUc2tVzCFrlrph8zBRU2nO+RuBCO
 9pfd7tGeZSf0caqbK+3EqVISac6ExZsUs7gD/kBMuPI8zOxSIFju4mIOdEpvBrTYliRj44oh2ig
 kZKA9TkrxQiiNekw==
X-Received: by 2002:a05:600c:64c9:b0:4a2:180a:3417 with SMTP id
 5b1f17b1804b1-4ac14dd1debmr230539255e9.1.1793616899407; 
 Mon, 02 Nov 2026 02:54:59 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac0a66caefsm213911455e9.5.2026.11.02.02.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 02:54:58 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 10:54:57 +0000
To: Laptops <jeff@incrediblybased.co>, Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Icf890b018b9950c698e46cc44b39edaa0c6ec566
X-Gerrit-Change-Number: 2034
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2034?usp=email>
X-Gerrit-Commit: 16c3f4df69f51ffcf403527fbe0bc8c0bffd9417
In-Reply-To: <gerrit.1793032811000.Icf890b018b9950c698e46cc44b39edaa0c6ec566@gerrit.openvpn.net>
References: <gerrit.1793032811000.Icf890b018b9950c698e46cc44b39edaa0c6ec566@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDMyODExMDAwLkljZjg5MGIwMThiOTk1MGM2OThlNDZjYzQ0YjM5ZWRhYTBjNmVjNTY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f4adfc053d25af43c34be58ee2dfb28200ccd3dc-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNpgw-000000003r7-17sQ
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: restructure
 some loops and assignments
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 jeff@incrediblybased.co
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============9201025385707837150=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9201025385707837150==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hxFY9tO0+To="; charset=UTF-8

--hxFY9tO0+To=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Lapt=
ops=2E

Gert Doering has uploaded a new patch set (#2) to the change origin=
ally created by Laptops=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/203=
4?usp=3Demail )

The following approvals got outdated and were removed:
Cod=
e-Review+2 by Arne Schwabe, Code-Review+2 by Frank Lichtenheld

The change =
is no longer submittable: Code-Review and checks~ChecksSubmitRule are unsat=
isfied now=2E


Change subject: buffer: restructure some loops and assignme=
nts
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

buffer:=
 restructure some loops and assignments

Small cleanups in buffer=2Ec that =
do not change behaviour, in preparation
for building it with -fbounds-safet=
y:

- alloc_buf(), alloc_buf_gc(), clone_buf(): assign buf=2Edata before
  =
buf=2Ecapacity and drop the redundant casts of the allocator result
- free_=
buf_gc(): compare the entry address arithmetically instead of
  stepping a =
struct gc_entry pointer past its object
- buf_printf(): bound the length of=
 the written string by the capacity
  passed to vsnprintf()
- string_array_=
len(), print_argv(), string_class(), string_substitute():
  walk NUL-termin=
ated strings and arrays by advancing the pointer
- string_mod(): write thro=
ugh a separate output pointer
- string_alloc_buf(): use a temporary for the=
 copied string
- buf_parse(): check for an empty line without strlen()

Cha=
nge-Id: Icf890b018b9950c698e46cc44b39edaa0c6ec566
Signed-off-by: Jeff Binde=
l <jeff@incrediblybased=2Eco>
Acked-by: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2034
Messag=
e-Id: <20261027130252=2E2457-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2E=
mail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40197=2Ehtml
=
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/buf=
fer=2Ec
1 file changed, 26 insertions(+), 34 deletions(-)


  git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/34/2034/2

diff --git a=
/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index c683f8e=2E=2E8813fa5=
 100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -66,8 =
+66,8 @@
     {
         buf_size_error(size);
     }
-    buf=2Ecapacity =
=3D (int)size;
     buf=2Edata =3D calloc(1, size);
+    buf=2Ecapacity =3D=
 (int)size;
     check_malloc_return(buf=2Edata);
 
     return buf;
@@ -83=
,8 +83,8 @@
     {
         buf_size_error(size);
     }
+    buf=2Edata =
=3D gc_malloc(size, false, gc);
     buf=2Ecapacity =3D (int)size;
-    buf=
=2Edata =3D (uint8_t *)gc_malloc(size, false, gc);
     if (size)
     {
  =
       *buf=2Edata =3D 0;
@@ -100,15 +100,15 @@
 #endif
 {
     struct buff=
er ret;
+    ret=2Edata =3D malloc(buf->capacity);
     ret=2Ecapacity =3D =
buf->capacity;
+    check_malloc_return(ret=2Edata);
     ret=2Eoffset =3D =
buf->offset;
     ret=2Elen =3D buf->len;
 #ifdef BUF_INIT_TRACKING
     re=
t=2Edebug_file =3D buf->debug_file;
     ret=2Edebug_line =3D buf->debug_li=
ne;
 #endif
-    ret=2Edata =3D (uint8_t *)malloc(buf->capacity);
-    chec=
k_malloc_return(ret=2Edata);
     memcpy(BPTR(&ret), CBPTR(buf), BLENZ(buf)=
);
     return ret;
 }
@@ -182,7 +182,7 @@
         while (*e)
         {
 =
            /* check if this object is the one we want to delete */
-      =
      if ((uint8_t *)(*e + 1) =3D=3D buf->data)
+            if ((uintptr_t=
)*e + sizeof(struct gc_entry) =3D=3D (uintptr_t)buf->data)
             {
 =
                struct gc_entry *to_delete =3D *e;
 
@@ -238,7 +238,7 @@
  =
           va_start(arglist, format);
             stat =3D vsnprintf(ptr, =
cap, format, arglist);
             va_end(arglist);
-            buf->len =
+=3D (int)strlen(ptr);
+            buf->len +=3D (int)strnlen(ptr, cap);
 =
            if (stat >=3D 0 && stat < cap)
             {
                 =
ret =3D true;
@@ -607,7 +607,7 @@
 
         if (gc)
         {
-          =
  ret =3D (char *)gc_malloc(n, false, gc);
+            ret =3D gc_malloc(n=
, false, gc);
         }
         else
         {
@@ -648,7 +648,7 @@
     =
int i =3D 0;
     if (array)
     {
-        while (array[i])
+        for =
(; *array; ++array)
         {
             ++i;
         }
@@ -661,13 +661=
,9 @@
 {
     struct buffer out =3D alloc_buf_gc(256, gc);
     int i =3D 0=
;
-    for (;;)
+    for (; *p; ++p)
     {
-        const char *cp =3D *p+=
+;
-        if (!cp)
-        {
-            break;
-        }
+        con=
st char *cp =3D *p;
         if (i)
         {
             buf_printf(&out=
, " ");
@@ -695,7 +691,8 @@
 
     ASSERT(str);
 
-    buf_set_read(&buf, (=
uint8_t *)string_alloc(str, gc), strlen(str) + 1);
+    const char *copy =
=3D string_alloc(str, gc);
+    buf_set_read(&buf, (const uint8_t *)copy, s=
trlen(str) + 1);
 
     if (buf=2Elen > 0) /* Don't count trailing '\0' as =
part of length */
     {
@@ -789,7 +786,7 @@
     } while (c);
 
     line[=
size - 1] =3D '\0';
-    return !(eol && !strlen(line));
+    return !(eol =
&& line[0] =3D=3D '\0');
 }
 
 /*
@@ -970,11 +967,10 @@
 bool
 string_class=
(const char *str, const unsigned int inclusive, const unsigned int exclusiv=
e)
 {
-    char c;
     ASSERT(str);
-    while ((c =3D *str++))
+    for (=
; *str; ++str)
     {
-        if (!char_inc_exc(c, inclusive, exclusive))
=
+        if (!char_inc_exc(*str, inclusive, exclusive))
         {
        =
     return false;
         }
@@ -990,11 +986,12 @@
 string_mod(char *str, =
const unsigned int inclusive, const unsigned int exclusive,
            con=
st char replace)
 {
-    const char *in =3D str;
-    bool ret =3D true;
-
=
     ASSERT(str);
 
+    char *out =3D str;
+    const char *in =3D out;
+ =
   bool ret =3D true;
+
     while (true)
     {
         char c =3D *in++;=

@@ -1007,12 +1004,12 @@
             }
             if (c)
             {
=
-                *str++ =3D c;
+                *out++ =3D c;
             =
}
         }
         else
         {
-            *str =3D '\0';
+        =
    *out =3D '\0';
             break;
         }
     }
@@ -1103,19 +1100,=
14 @@
 char *
 string_substitute(const char *src, char from, char to, struc=
t gc_arena *gc)
 {
-    char *ret =3D (char *)gc_malloc(strlen(src) + 1, tr=
ue, gc);
+    char *ret =3D gc_malloc(strlen(src) + 1, true, gc);
     char=
 *dest =3D ret;
-    char c;
 
-    do
+    for (; *src; ++src)
     {
-   =
     c =3D *src++;
-        if (c =3D=3D from)
-        {
-            c =
=3D to;
-        }
-        *dest++ =3D c;
-    } while (c);
+        *dest=
++ =3D (*src =3D=3D from) ? to : *src;
+    }
+    *dest =3D '\0';
     ret=
urn ret;
 }
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2034?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: ne=
wpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
cf890b018b9950c698e46cc44b39edaa0c6ec566
Gerrit-Change-Number: 2034
Gerrit-=
PatchSet: 2
Gerrit-Owner: Laptops <jeff@incrediblybased=2Eco>
Gerrit-Review=
er: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: Laptops <jeff@incrediblybased=2Ec=
o>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Atten=
tion: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--hxFY9tO0+To=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Laptops=2E </p>
<p>G=
ert Doering <strong>uploaded patch set #2</strong> to the change originally=
 created by Laptops=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2034?usp=3Demail">View Change</a></p><p>The following approvals got=
 outdated and were removed:
Code-Review+2 by Arne Schwabe, Code-Review+2 by=
 Frank Lichtenheld</p><p>The change is no longer submittable: Code-Review a=
nd checks~ChecksSubmitRule are unsatisfied now=2E</p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">buffer: =
restructure some loops and assignments<br><br>Small cleanups in buffer=2Ec =
that do not change behaviour, in preparation<br>for building it with -fboun=
ds-safety:<br><br>- alloc_buf(), alloc_buf_gc(), clone_buf(): assign buf=2E=
data before<br>  buf=2Ecapacity and drop the redundant casts of the allocat=
or result<br>- free_buf_gc(): compare the entry address arithmetically inst=
ead of<br>  stepping a struct gc_entry pointer past its object<br>- buf_pri=
ntf(): bound the length of the written string by the capacity<br>  passed t=
o vsnprintf()<br>- string_array_len(), print_argv(), string_class(), string=
_substitute():<br>  walk NUL-terminated strings and arrays by advancing the=
 pointer<br>- string_mod(): write through a separate output pointer<br>- st=
ring_alloc_buf(): use a temporary for the copied string<br>- buf_parse(): c=
heck for an empty line without strlen()<br><br>Change-Id: Icf890b018b9950c6=
98e46cc44b39edaa0c6ec566<br>Signed-off-by: Jeff Bindel &lt;jeff@incrediblyb=
ased=2Eco&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2034<br>Message=
-Id: &lt;20261027130252=2E2457-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https:=
//www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40197=
=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>-=
--<br>M src/openvpn/buffer=2Ec<br>1 file changed, 26 insertions(+), 34 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/34/2034/2</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/buffer=
=2Ec b/src/openvpn/buffer=2Ec</span><br><span>index c683f8e=2E=2E8813fa5 10=
0644</span><br><span>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src=
/openvpn/buffer=2Ec</span><br><span>@@ -66,8 +66,8 @@</span><br><span>     =
{</span><br><span>         buf_size_error(size);</span><br><span>     }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf=2Ecapacity =3D (i=
nt)size;</span><br><span>     buf=2Edata =3D calloc(1, size);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    buf=2Ecapacity =3D (int)size;=
</span><br><span>     check_malloc_return(buf=2Edata);</span><br><span> </s=
pan><br><span>     return buf;</span><br><span>@@ -83,8 +83,8 @@</span><br>=
<span>     {</span><br><span>         buf_size_error(size);</span><br><span=
>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf=2Eda=
ta =3D gc_malloc(size, false, gc);</span><br><span>     buf=2Ecapacity =3D =
(int)size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf=2Ed=
ata =3D (uint8_t *)gc_malloc(size, false, gc);</span><br><span>     if (siz=
e)</span><br><span>     {</span><br><span>         *buf=2Edata =3D 0;</span=
><br><span>@@ -100,15 +100,15 @@</span><br><span> #endif</span><br><span> {=
</span><br><span>     struct buffer ret;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    ret=2Edata =3D malloc(buf-&gt;capacity);</span><br=
><span>     ret=2Ecapacity =3D buf-&gt;capacity;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    check_malloc_return(ret=2Edata);</span><br=
><span>     ret=2Eoffset =3D buf-&gt;offset;</span><br><span>     ret=2Elen=
 =3D buf-&gt;len;</span><br><span> #ifdef BUF_INIT_TRACKING</span><br><span=
>     ret=2Edebug_file =3D buf-&gt;debug_file;</span><br><span>     ret=2Ed=
ebug_line =3D buf-&gt;debug_line;</span><br><span> #endif</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    ret=2Edata =3D (uint8_t *)malloc(bu=
f-&gt;capacity);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c=
heck_malloc_return(ret=2Edata);</span><br><span>     memcpy(BPTR(&amp;ret),=
 CBPTR(buf), BLENZ(buf));</span><br><span>     return ret;</span><br><span>=
 }</span><br><span>@@ -182,7 +182,7 @@</span><br><span>         while (*e)<=
/span><br><span>         {</span><br><span>             /* check if this ob=
ject is the one we want to delete */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            if ((uint8_t *)(*e + 1) =3D=3D buf-&gt;data)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            if ((uintpt=
r_t)*e + sizeof(struct gc_entry) =3D=3D (uintptr_t)buf-&gt;data)</span><br>=
<span>             {</span><br><span>                 struct gc_entry *to_d=
elete =3D *e;</span><br><span> </span><br><span>@@ -238,7 +238,7 @@</span><=
br><span>             va_start(arglist, format);</span><br><span>          =
   stat =3D vsnprintf(ptr, cap, format, arglist);</span><br><span>         =
    va_end(arglist);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           buf-&gt;len +=3D (int)strlen(ptr);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            buf-&gt;len +=3D (int)strnlen(ptr, ca=
p);</span><br><span>             if (stat &gt;=3D 0 &amp;&amp; stat &lt; ca=
p)</span><br><span>             {</span><br><span>                 ret =3D =
true;</span><br><span>@@ -607,7 +607,7 @@</span><br><span> </span><br><span=
>         if (gc)</span><br><span>         {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            ret =3D (char *)gc_malloc(n, false, gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ret =3D=
 gc_malloc(n, false, gc);</span><br><span>         }</span><br><span>      =
   else</span><br><span>         {</span><br><span>@@ -648,7 +648,7 @@</spa=
n><br><span>     int i =3D 0;</span><br><span>     if (array)</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        whil=
e (array[i])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 for (; *array; ++array)</span><br><span>         {</span><br><span>       =
      ++i;</span><br><span>         }</span><br><span>@@ -661,13 +661,9 @@<=
/span><br><span> {</span><br><span>     struct buffer out =3D alloc_buf_gc(=
256, gc);</span><br><span>     int i =3D 0;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    for (;;)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    for (; *p; ++p)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        const char *cp =3D *p++;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!cp)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        const char *cp =3D *p;</span><br><span>         =
if (i)</span><br><span>         {</span><br><span>             buf_printf(&=
amp;out, &quot; &quot;);</span><br><span>@@ -695,7 +691,8 @@</span><br><spa=
n> </span><br><span>     ASSERT(str);</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    buf_set_read(&amp;buf, (uint8_t *)str=
ing_alloc(str, gc), strlen(str) + 1);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const char *copy =3D string_alloc(str, gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;buf, (c=
onst uint8_t *)copy, strlen(str) + 1);</span><br><span> </span><br><span>  =
   if (buf=2Elen &gt; 0) /* Don&#39;t count trailing &#39;\0&#39; as part o=
f length */</span><br><span>     {</span><br><span>@@ -789,7 +786,7 @@</spa=
n><br><span>     } while (c);</span><br><span> </span><br><span>     line[s=
ize - 1] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    return !(eol &amp;&amp; !strlen(line));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return !(eol &amp;&amp; line[0] =3D=3D &#3=
9;\0&#39;);</span><br><span> }</span><br><span> </span><br><span> /*</span>=
<br><span>@@ -970,11 +967,10 @@</span><br><span> bool</span><br><span> stri=
ng_class(const char *str, const unsigned int inclusive, const unsigned int =
exclusive)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    char c;</span><br><span>     ASSERT(str);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    while ((c =3D *str++))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    for (; *str; ++str)</span><br><s=
pan>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if =
(!char_inc_exc(c, inclusive, exclusive))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (!char_inc_exc(*str, inclusive, exclusive))=
</span><br><span>         {</span><br><span>             return false;</spa=
n><br><span>         }</span><br><span>@@ -990,11 +986,12 @@</span><br><spa=
n> string_mod(char *str, const unsigned int inclusive, const unsigned int e=
xclusive,</span><br><span>            const char replace)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *in =
=3D str;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =
=3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span>     ASSERT(str);</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    char *out =3D str;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const char *in =3D out;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D true;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     while (true)</sp=
an><br><span>     {</span><br><span>         char c =3D *in++;</span><br><s=
pan>@@ -1007,12 +1004,12 @@</span><br><span>             }</span><br><span>=
             if (c)</span><br><span>             {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                *str++ =3D c;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                *out++ =3D c;</span>=
<br><span>             }</span><br><span>         }</span><br><span>       =
  else</span><br><span>         {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            *str =3D &#39;\0&#39;;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            *out =3D &#39;\0&#39;;</span><br><sp=
an>             break;</span><br><span>         }</span><br><span>     }</s=
pan><br><span>@@ -1103,19 +1100,14 @@</span><br><span> char *</span><br><sp=
an> string_substitute(const char *src, char from, char to, struct gc_arena =
*gc)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    char *ret =3D (char *)gc_malloc(strlen(src) + 1, true, gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    char *ret =3D gc_malloc(s=
trlen(src) + 1, true, gc);</span><br><span>     char *dest =3D ret;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    char c;</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    do</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    for (; *src; ++src)</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c=
 =3D *src++;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (c =3D=3D from)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            c =
=3D to;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        *dest++ =3D c;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    } while (c);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        *dest++ =3D (*src =
=3D=3D from) ? to : *src;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *des=
t =3D &#39;\0&#39;;</span><br><span>     return ret;</span><br><span> }</sp=
an><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2034?usp=3Demail">change 2034</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2034?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Icf890b018b9950c698e46cc44b39edaa0c=
6ec566 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2034 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Laptops &lt;jeff@incrediblybased=2Eco&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Fran=
k Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Laptops &lt;jeff=
@incrediblybased=2Eco&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>

</body></html>
--hxFY9tO0+To=--


--===============9201025385707837150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9201025385707837150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9201025385707837150==--

