Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C1FC5AD7B
	for <openvpn-devel@archiver.kernel.org>; Mon, 10 Aug 2026 12:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qblvgfyYs/XfA0fL9jyckuFpyOc6FLf/z8ze7y+QruM=; b=EM3v6FFnaMFeiaDGD94PxbRFL/
	F8hKLXOdDE/VobtisB6LESknxYtsBYh198NyOwFHTtxD03O0LwnFOhZRd6wf1LP1Eau6O/HR66No9
	GxB+kom637KoML2vNeFDOdbfufK9tUz8AC2Y9Df3NbDfWMXghi94T6BS/4Y7vXRlmmEQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wtPDF-00072y-GO;
	Mon, 10 Aug 2026 12:34:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wtPDE-00072e-Ep
 for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 12:34:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=krK34fzJi3kgzw/xz0Pih+oxG9PXMMR2S6ObZKkp410=; b=kuQNp03ZrlfSAtmvJ2pRrUgSGv
 748dJDTd4ztWt1eNAz1gKj79O8jbUlmBQ+8u9YR6uzFd+Esu1gsTT0kb0p+qxm4F0vXGMA3LFce0P
 HpdvFhQINqObZVYp8+gN3+baV95Vw6Jp40oiG39a6ldGW+53nXc9+bg9fKMsVSuA73LE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=krK34fzJi3kgzw/xz0Pih+oxG9PXMMR2S6ObZKkp410=; b=I
 eyoYGNg1iuQ7Knkh2JZp1ggqdYqoJZzs/O9YpVJRRO8WszMPvQAlWfDikgcet0+BW4CMQQppAHlwl
 gJF/yHkZF/RRId4rkJdpmSS7nEiyrNDu4XV+QWEXkEMms7QQ/ubkAKiKP1saGW9T5nWVd1SiRltHI
 bNRsnZ39hU13dm6Y=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wtPCm-0002iW-1m for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 12:34:15 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so23639795e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 10 Aug 2026 05:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786365242; x=1786970042; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=krK34fzJi3kgzw/xz0Pih+oxG9PXMMR2S6ObZKkp410=;
 b=Obc00+Y13/PDUZsuKTBJhO6eVWLMxJD73jTkKrmTWXpk0k5Q6F37ZXYOG37X8DTzuC
 uzxoWd4FQNzSMZ+lR8gPjXTO/gM7u7/NIf7nQCq/quFH8vpKixjbaBEhbsWmywJLI3V2
 AK2a0ahs1eQ7f7lxU4gkr91Zbos1sVzICJXRsEDINPBx4zrLlpo3UDf1SlX42Egvx3Q9
 woCHFD1ToPVRt1Nho4jper7ojukUKYkndk73q5Z0eL5UdWTa6eLXqdCx3/7PBRQR84Ce
 Vwrx1xYU8DG9G7XTJoiwk+JqtFcxENGDJIwRWBBXgnD5eR9Dmmu7hcbRQg1izT5FxB1h
 gt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786365242; x=1786970042;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=krK34fzJi3kgzw/xz0Pih+oxG9PXMMR2S6ObZKkp410=;
 b=f3ecRbrOXfHUaX0C5pnENB010R0kNtGTf5drNEaerjHLrxvuIenZquXsQRtjLAKka7
 VL3jnr8twLREKBmJOdREjf8oTRN+NQ2u6GbxCoZJrdYEPHH8PvExe2xF58uZgnxRjtuW
 EZg8e9zaLwht5TMZEHhhXf56AeAHxt2TTzdqjSW8zXYyTqFJwypJFEDWRs1bnwFvH6gY
 YxTlFcE8HD+ysNBwIvNpXrpbjf5QtX6e7oVPnFdUvFqSWav0uu30AqcQTMecx+SMJjb7
 QqErhIHdvBnBkuaWoZAsfaesd1VhvylwjpJTBMUYigBberVesqRsAeXaxDRMhCHu6EBR
 shBg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq8K4Rmnk0ohEJyqjQrdbRNjqXttdr7dbBKKInyrmcvFl5fqqOc9t34Owzq3BbrPxuzfNvF/4OLb91FqJ2y@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwNtlicdH6paEbuHH1izJ0slo63fvPZJ7Imt/AWGwbweX10PzPK
 KR9qVZSIU5OQ1p0d+coEgbc62hGHcLnlSs3vbgiZlrXLSRvs5Sau2/oi30N4E/+ceVPk6hZ8IzF
 BouIFl8axGGpkNRhYmTRpkm0gikvFkq+K6Wd8KyajfxMYzk3oDMTpN1x0dFSC4WUVfHyU1nsEmf
 2wmIv7NA==
X-Gm-Gg: AR+sD110up+5oUpS+2+lgVgMy+xGJlRjc+WYsn4lzVwe43b2Js2mu0XKtPwyYeqIfZ2
 kI8b+459nZfdLstfDRNBA3zrG8kS7cm69tnnFvy54tyAJvng9fnsR2lpTt6jXEp/YjPmicAkWAP
 rZjTrXh5yEJLzDOmcR+fHl5XydIf8k40Z0DvGG39hkPrFI76OlmJMMzjZCztVcw8afmF5fp3Jm0
 BWhVI38RuksmE5efl6og0pIuFPwwJZdTm/dKRowF9arWV9RNhwifkv3xvyZLZ4y7Uqibh/Xyclf
 VqVrBGR3q7HIyfjxm1fPyTSW7PPcw6M/4Kf5b/F3OQLBreVrUbwyC7jSyGQ/agFBowwRdlffzlx
 y03vkzuHV9C8zQ+9nK9nERatSoMEFL2OBjqzJ7/Woiu9HGqk0oXAJ8MizwLKpQ7UDuo582ZE/aV
 gw3YuD52kKUMOqlAa9ixuwD2N/BUfWLAX/R3bZ65/McRjxKR4iGRNp2wA6UwosyZ5JRShzps6qc
 ZmHOyk0x9zZw7yGLcyiwdOQWspGs2oX7jktF3HXnRYC/Q6Nswx6QnpBiLvbg/VK0ZrS8CU/kbC6
 PznFc3k40aG8mPrnKHW7+hEJA3x0ZGGcMswIg+GgbAPjhC9B+4g=
X-Received: by 2002:a05:600c:c87:b0:493:f783:c46a with SMTP id
 5b1f17b1804b1-49962472d69mr174148595e9.6.1786365239644; 
 Mon, 10 Aug 2026 05:33:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995c8bcca6sm228515435e9.4.2026.08.10.05.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 05:33:59 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 10 Aug 2026 12:33:58 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I350ca5b08379ede1480b81055d35dd9a33e30cff
X-Gerrit-Change-Number: 1581
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1581?usp=email>
X-Gerrit-Commit: 21ef7fa82a39895a7b65459078fd78bdd3a43e27
In-Reply-To: <gerrit.1773842036000.I350ca5b08379ede1480b81055d35dd9a33e30cff@gerrit.openvpn.net>
References: <gerrit.1773842036000.I350ca5b08379ede1480b81055d35dd9a33e30cff@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczODQyMDM2MDAwLkkzNTBjYTViMDgzNzllZGUxNDgwYjgxMDU1ZDM1ZGQ5YTMzZTMwY2ZmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fffc4ecf77c6157d3d07c1017cce993771c93c88-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wtPCm-0002iW-1m
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: doc: add Doxygen
 documentation to buffer.h
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1391433051773263624=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1391433051773263624==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BvUf1RQHp2s="; charset=UTF-8

--BvUf1RQHp2s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1581?usp=3Demail )

Change subject: doc: add Doxygen documentation to b=
uffer=2Eh
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

d=
oc: add Doxygen documentation to buffer=2Eh

Document all previously undocu=
mented elements=2E

Github: Fixes #864
Change-Id: I350ca5b08379ede1480b8105=
5d35dd9a33e30cff
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>=

Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1581
Message-Id: <20260810120941=2E31423-1=
-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-dev=
el@lists=2Esourceforge=2Enet/msg38269=2Ehtml
Signed-off-by: Gert Doering <g=
ert@greenie=2Emuc=2Ede>
---
M src/openvpn/buffer=2Eh
1 file changed, 1,045 =
insertions(+), 65 deletions(-)




diff --git a/src/openvpn/buffer=2Eh b/sr=
c/openvpn/buffer=2Eh
index 743c3f4=2E=2E74c84b2 100644
--- a/src/openvpn/bu=
ffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -20,6 +20,15 @@
  *  with this pro=
gram; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
  */
 
+/**
+ * @f=
ile
+ * @brief Buffer management functions and garbage collection=2E
+ *
+ =
* This module provides the core \c buffer type used throughout OpenVPN to
+=
 * hold packet data, as well as a simple memory management system
+ * (\c g=
c_arena / \c gc_malloc()) and various string/memory utility functions=2E
+ =
*/
+
 #ifndef BUFFER_H
 #define BUFFER_H
 
@@ -27,6 +36,7 @@
 #include "err=
or=2Eh"
 #include "integer=2Eh"
 
+/** Maximum allowed size (in bytes) for =
a single buffer allocation=2E */
 #define BUF_SIZE_MAX 1000000
 
 /*
@@ -11=
5,51 +125,213 @@
  */
 struct gc_arena
 {
-    struct gc_entry *list; /**< =
First element of the linked list of
-                            *   \c gc_=
entry structures=2E */
-    struct gc_entry_special *list_special;
+    str=
uct gc_entry *list;                 /**< First element of the linked list o=
f
+                                            *   \c gc_entry structures=
=2E */
+    struct gc_entry_special *list_special; /**< First element of th=
e linked
+                                            *   list of \c gc_ent=
ry_special
+                                            *   structures for =
allocations
+                                            *   requiring a cu=
stom free
+                                            *   function=2E */
 =
};
 
 
+/** Return a pointer to the start of the buffer content=2E @see buf=
_bptr() */
 #define BPTR(buf)  (buf_bptr(buf))
+/** Return a pointer one pa=
st the end of the buffer content=2E @see buf_bend() */
 #define BEND(buf)  =
(buf_bend(buf))
+/** Return a pointer to the last byte of the buffer conten=
t, or NULL if empty=2E @see buf_blast() */
 #define BLAST(buf) (buf_blast(b=
uf))
+/** Return the length of the buffer content in bytes=2E @see buf_len(=
) */
 #define BLEN(buf)  (buf_len(buf))
+/** Return the length of the buffe=
r content as a \c size_t=2E @see buf_len() */
 #define BLENZ(buf) ((size_t)=
buf_len(buf))
+/** Return true iff the buffer is defined (has non-NULL data=
 pointer)=2E @see buf_defined() */
 #define BDEF(buf)  (buf_defined(buf))
+=
/** Return the buffer content pointer cast to \c char *=2E @see buf_str() *=
/
 #define BSTR(buf)  (buf_str(buf))
+/** Return the number of bytes availa=
ble for appending to the buffer=2E @see buf_forward_capacity() */
 #define =
BCAP(buf)  (buf_forward_capacity(buf))
 
+/**
+ * Zeroise and reset a buffe=
r=2E
+ *
+ * Sets all allocated memory to zero and resets \c offset and \c =
len to zero,
+ * but does not free the underlying memory=2E
+ *
+ * @param =
buf   The buffer to clear=2E
+ */
 void buf_clear(struct buffer *buf);
 
+/=
**
+ * Free the memory allocated for a buffer=2E
+ *
+ * Frees \c buf->data=
 and resets the buffer to an undefined state=2E
+ *
+ * @param buf   The bu=
ffer whose memory is to be freed=2E
+ */
 void free_buf(struct buffer *buf)=
;
 
+/**
+ * Assign the content of one buffer to another=2E
+ *
+ * Copies =
the content of \c src into \c dest=2E  The destination buffer must
+ * alre=
ady be allocated with sufficient capacity=2E
+ *
+ * @param dest  Destinati=
on buffer to write into=2E
+ * @param src   Source buffer to read from=2E
+=
 *
+ * @return true on success, false if \c dest has insufficient capacity=
=2E
+ */
 bool buf_assign(struct buffer *dest, const struct buffer *src);
 =

+/**
+ * Securely clear a null-terminated string=2E
+ *
+ * Overwrites all=
 characters of \c str with zeroes=2E
+ *
+ * @param str   The string to cle=
ar=2E
+ */
 void string_clear(char *str);
 
+/**
+ * Return the number of e=
lements in a NULL-terminated array of strings=2E
+ *
+ * @param array     N=
ULL-terminated array of string pointers=2E
+ *
+ * @return Number of non-NU=
LL elements=2E
+ */
 int string_array_len(const char **array);
 
+/**
+ * S=
afely compute the product of two sizes plus an extra amount=2E
+ *
+ * Each=
 of \c m1, \c m2, and \c extra, as well as the final result, are
+ * checke=
d against \c ALLOC_SIZE_MAX=2E  If any value exceeds the limit the
+ * func=
tion calls \c msg(M_FATAL) and does not return=2E
+ *
+ * @param m1    Firs=
t multiplicand=2E
+ * @param m2    Second multiplicand=2E
+ * @param extra =
Value to add to the product=2E
+ *
+ * @return \c m1 * \c m2 + \c extra=2E
=
+ */
 size_t array_mult_safe(const size_t m1, const size_t m2, const size_t=
 extra);
 
+/** Flag for print_argv(): wrap each argument in square bracket=
s=2E */
 #define PA_BRACKET (1 << 0)
+/**
+ * Format a NULL-terminated argu=
ment vector as a single string=2E
+ *
+ * @param p     NULL-terminated arra=
y of string pointers to format=2E
+ * @param gc    Garbage collection arena=
 for the returned string=2E
+ * @param flags Formatting flags (e=2Eg=2E \c =
PA_BRACKET)=2E
+ *
+ * @return Newly allocated string representation of \c =
p=2E
+ */
 char *print_argv(const char **p, struct gc_arena *gc, const unsi=
gned int flags);
 
+/**
+ * Report a buffer size error and abort=2E
+ *
+ *=
 Called when a requested buffer size exceeds \c BUF_SIZE_MAX or is otherwis=
e
+ * invalid=2E  Calls \c msg(M_FATAL) and does not return=2E
+ *
+ * @par=
am size  The invalid size that was requested=2E
+ */
 void buf_size_error(c=
onst size_t size);
 
+/**
+ * Allocate a buffer of the given size=2E
+ *
+ =
* Calls \c out_of_memory() if the allocation fails=2E The caller is respons=
ible
+ * for freeing the memory=2E
+ *
+ * @param size  Number of bytes to =
allocate=2E
+ *
+ * @return Newly allocated buffer of capacity \c size=2E
+=
 */
 struct buffer alloc_buf(size_t size);
 
-struct buffer alloc_buf_gc(si=
ze_t size,
-                           struct gc_arena *gc); /* allocate bu=
ffer with garbage collection */
+/**
+ * Allocate a buffer of the given siz=
e under garbage collection=2E
+ *
+ * The allocated memory is registered wi=
th \c gc so that it is freed when
+ * \c gc_free() is called on the arena=
=2E  Calls \c out_of_memory() if the
+ * allocation fails=2E
+ *
+ * @param=
 size  Number of bytes to allocate=2E
+ * @param gc    Garbage collection a=
rena to register the allocation with=2E
+ *
+ * @return Newly allocated buf=
fer of capacity \c size=2E
+ */
+struct buffer alloc_buf_gc(size_t size, st=
ruct gc_arena *gc);
 
+/**
+ * Duplicate a buffer, including its content=2E=

+ *
+ * Allocates a new buffer with the same capacity as \c buf and copies=
 its
+ * content=2E  Calls \c out_of_memory() if the allocation fails=2E
+ =
*
+ * @param buf   The buffer to duplicate=2E
+ *
+ * @return A newly alloc=
ated copy of \c buf=2E
+ */
 struct buffer clone_buf(const struct buffer *b=
uf);
 
+/**
+ * Allocate memory and, optionally, zero it=2E
+ *
+ * The all=
ocation is registered with \c a so that it is freed when
+ * \c gc_free() i=
s called on the arena=2E  Calls \c out_of_memory() if the
+ * allocation fa=
ils=2E
+ *
+ * @param size  Number of bytes to allocate=2E
+ * @param clear=
 If true, zeroise the allocated memory before returning=2E
+ * @param a    =
 Garbage collection arena to register the allocation with=2E
+ *
+ * @retur=
n Pointer to the newly allocated memory=2E
+ */
 void *gc_malloc(size_t siz=
e, bool clear, struct gc_arena *a);
 
+/**
+ * Duplicate a string, allocati=
ng memory under garbage collection=2E
+ *
+ * @param str   The string to du=
plicate=2E  May be NULL, in which case NULL
+ *              is returned=2E=

+ * @param gc    Garbage collection arena for the returned string, or NULL=

+ *              to use plain \c malloc()=2E
+ *
+ * @return A newly alloc=
ated copy of \c str, or NULL if \c str is NULL=2E
+ */
 char *string_alloc(=
const char *str, struct gc_arena *gc);
 
+/**
+ * Allocate a buffer contain=
ing a copy of the given string=2E
+ *
+ * Wraps \c string_alloc(), so \c gc=
 may be NULL (plain \c malloc() is used
+ * in that case)=2E  The buffer \c=
 len reflects the string length, excluding
+ * the null terminator, even th=
ough the terminator is present in the
+ * allocated memory=2E
+ *
+ * @para=
m str   The string to copy into the buffer=2E  Must not be NULL=2E
+ * @par=
am gc    Garbage collection arena for the allocation, or NULL=2E
+ *
+ * @r=
eturn A buffer whose content is a copy of \c str=2E
+ */
 struct buffer str=
ing_alloc_buf(const char *str, struct gc_arena *gc);
 
+/**
+ * Register an=
 address with a custom free function in a garbage collection
+ * arena=2E
+=
 *
+ * When \c gc_free() is called on \c a, \c free_function(addr) will be
=
+ * invoked to release the memory=2E  Use this for allocations that require=

+ * something other than plain \c free(), such as \c freeaddrinfo()=2E
+ *=

+ * @param addr          Pointer to the memory to register=2E
+ * @param f=
ree_function Function to call to free \c addr=2E
+ * @param a             G=
arbage collection arena to register with=2E
+ */
 void gc_addspecial(void *=
addr, void (*free_function)(void *), struct gc_arena *a);
 
 /**
@@ -177,6 =
+349,7 @@
 
 #ifdef BUF_INIT_TRACKING
 #define buf_init(buf, offset) buf_in=
it_debug(buf, offset, __FILE__, __LINE__)
+/** Debug variant of \c buf_init=
_dowork() that records the call site for alignment verification=2E */
 bool=
 buf_init_debug(struct buffer *buf, int offset, const char *file, int line)=
;
 
 #else
@@ -185,31 +358,62 @@
 
 
 /* inline functions */
+
+/**
+ * Cal=
lback to free a \c struct \c addrinfo, suitable for use with
+ * \c gc_adds=
pecial()=2E
+ *
+ * @param addr  Pointer to the \c struct \c addrinfo to fr=
ee=2E
+ */
 static inline void
 gc_freeaddrinfo_callback(void *addr)
 {
   =
  freeaddrinfo((struct addrinfo *)addr);
 }
 
-/** Return an empty struct b=
uffer */
+/** Return an empty, undefined \c struct \c buffer (all fields ze=
ro)=2E */
 static inline struct buffer
 clear_buf(void)
 {
     return (str=
uct buffer){ 0 };
 }
 
+/**
+ * Return true iff \c buf has a non-NULL data =
pointer=2E
+ *
+ * A defined buffer has been allocated but may have zero le=
ngth or negative
+ * len (i=2Ee=2E it is not necessarily valid)=2E
+ *
+ * =
@param buf   The buffer to test=2E
+ */
 static inline bool
 buf_defined(co=
nst struct buffer *buf)
 {
     return buf->data !=3D NULL;
 }
 
+/**
+ * R=
eturn true iff \c buf is valid=2E
+ *
+ * A buffer is valid when its data p=
ointer is non-NULL and its \c len is
+ * non-negative=2E
+ *
+ * @param buf=
   The buffer to test=2E
+ */
 static inline bool
 buf_valid(const struct b=
uffer *buf)
 {
     return likely(buf->data !=3D NULL) && likely(buf->len >=
=3D 0);
 }
 
+/**
+ * Return a pointer to the start of the buffer content=
=2E
+ *
+ * @param buf   The buffer to query=2E
+ *
+ * @return Pointer to =
\c buf->data + \c buf->offset, or NULL if \c buf is
+ *         not valid=
=2E
+ */
 static inline uint8_t *
 buf_bptr(const struct buffer *buf)
 {
@@=
 -223,6 +427,13 @@
     }
 }
 
+/**
+ * Return the length of the buffer con=
tent=2E
+ *
+ * @param buf   The buffer to query=2E
+ *
+ * @return \c buf-=
>len if \c buf is valid, otherwise 0=2E
+ */
 static int
 buf_len(const str=
uct buffer *buf)
 {
@@ -236,12 +447,27 @@
     }
 }
 
+/**
+ * Return a poi=
nter one past the end of the buffer content=2E
+ *
+ * @param buf   The buf=
fer to query=2E
+ *
+ * @return Pointer to the byte immediately after the l=
ast content byte=2E
+ */
 static inline uint8_t *
 buf_bend(const struct bu=
ffer *buf)
 {
     return buf_bptr(buf) + buf_len(buf);
 }
 
+/**
+ * Retur=
n a pointer to the last byte of the buffer content=2E
+ *
+ * @param buf   =
The buffer to query=2E
+ *
+ * @return Pointer to the last byte, or NULL if=
 the buffer is empty or
+ *         invalid=2E
+ */
 static inline uint8_t =
*
 buf_blast(const struct buffer *buf)
 {
@@ -255,24 +481,56 @@
     }
 }
 =

+/**
+ * Return true iff \c size is within the allowed buffer size range=
=2E
+ *
+ * @param size  The size to check=2E
+ *
+ * @return true if \c si=
ze < \c BUF_SIZE_MAX=2E
+ */
 static inline bool
 buf_size_valid(const size=
_t size)
 {
     return likely(size < BUF_SIZE_MAX);
 }
 
+/**
+ * Return t=
rue iff a signed \c size is within the allowed buffer size range=2E
+ *
+ *=
 Accepts negative values (used for bidirectional length adjustments) as
+ *=
 long as the absolute value is below \c BUF_SIZE_MAX=2E
+ *
+ * @param size=
  The signed size to check=2E
+ *
+ * @return true if \c -BUF_SIZE_MAX <=3D=
 size < \c BUF_SIZE_MAX=2E
+ */
 static inline bool
 buf_size_valid_signed(=
const int size)
 {
     return likely(size >=3D -BUF_SIZE_MAX) && likely(si=
ze < BUF_SIZE_MAX);
 }
 
+/**
+ * Return the buffer content pointer cast to=
 \c char *=2E
+ *
+ * @param buf   The buffer to query=2E
+ *
+ * @return T=
he content pointer as a \c char *, or NULL if \c buf is invalid=2E
+ */
 st=
atic inline char *
 buf_str(const struct buffer *buf)
 {
     return (char =
*)buf_bptr(buf);
 }
 
+/**
+ * Reset a buffer to an undefined (unallocated)=
 state=2E
+ *
+ * Sets all fields to zero/NULL without freeing any memory=
=2E  Use \c free_buf()
+ * first if the buffer owns allocated memory=2E
+ *=

+ * @param buf   The buffer to reset=2E
+ */
 static inline void
 buf_rese=
t(struct buffer *buf)
 {
@@ -282,6 +540,14 @@
     buf->data =3D NULL;
 }
 =

+/**
+ * Reset the length and offset of a buffer to zero=2E
+ *
+ * The un=
derlying allocation is preserved and \c capacity is unchanged=2E
+ * Equiva=
lent to rewinding the buffer to the beginning for fresh writing=2E
+ *
+ * =
@param buf   The buffer to reset=2E
+ */
 static inline void
 buf_reset_len=
(struct buffer *buf)
 {
@@ -289,6 +555,18 @@
     buf->offset =3D 0;
 }
 
+=
/**
+ * Initialise a buffer with a given initial offset=2E
+ *
+ * Sets \c =
buf->len to zero and \c buf->offset to \c offset=2E  The buffer must
+ * al=
ready be allocated=2E  Returns false (without modifying \c buf) if \c offse=
t
+ * is negative, exceeds the buffer capacity, or the data pointer is NULL=
=2E
+ *
+ * @param buf     The buffer to initialise=2E
+ * @param offset  I=
nitial byte offset from the start of the allocated memory=2E
+ *
+ * @retur=
n true on success, false if the parameters are invalid=2E
+ */
 static inli=
ne bool
 buf_init_dowork(struct buffer *buf, int offset)
 {
@@ -301,6 +579,=
17 @@
     return true;
 }
 
+/**
+ * Initialise a buffer with an externall=
y provided writable memory region=2E
+ *
+ * Sets up \c buf to use \c data =
as its backing store for writing=2E  The first
+ * byte of \c data is set t=
o zero=2E  Calls \c buf_size_error() (which does not
+ * return) if \c size=
 exceeds \c BUF_SIZE_MAX=2E
+ *
+ * @param buf   The buffer to initialise=
=2E
+ * @param data  Pointer to the memory region to use=2E
+ * @param size=
  Size of the memory region in bytes=2E
+ */
 static inline void
 buf_set_w=
rite(struct buffer *buf, uint8_t *data, int size)
 {
@@ -318,6 +607,18 @@
 =
    }
 }
 
+/**
+ * Initialise a buffer with an externally provided read-on=
ly memory region=2E
+ *
+ * Sets up \c buf so that the entire \c data regio=
n is the buffer content
+ * (offset is 0, len and capacity are both set to =
\c size)=2E  The data pointer
+ * is cast away from const=2E  Calls \c buf_=
size_error() (which does not return)
+ * if \c size exceeds \c BUF_SIZE_MAX=
=2E
+ *
+ * @param buf   The buffer to initialise=2E
+ * @param data  Point=
er to the read-only memory region=2E
+ * @param size  Size of the memory re=
gion in bytes=2E
+ */
 static inline void
 buf_set_read(struct buffer *buf,=
 const uint8_t *data, size_t size)
 {
@@ -330,7 +631,17 @@
     buf->data =
=3D (uint8_t *)data;
 }
 
-/* Like strncpy but makes sure dest is always nu=
ll terminated */
+/**
+ * Like \c strncpy() but always null-terminates the =
destination=2E
+ *
+ * Copies at most \c maxlen - 1 characters from \c src =
into \c dest and
+ * writes a null terminator at \c dest[\c maxlen - 1]=2E =
 Does nothing if
+ * \c maxlen is zero=2E
+ *
+ * @param dest    Destinatio=
n buffer=2E
+ * @param src     Source string=2E
+ * @param maxlen  Size of =
the destination buffer in bytes=2E
+ */
 static inline void
 strncpynt(char=
 *dest, const char *src, size_t maxlen)
 {
@@ -341,7 +652,13 @@
     }
 }
 =

-/* return true if string contains at least one numerical digit */
+/**
+ =
* Return true if the string contains at least one decimal digit=2E
+ *
+ * =
@param src   The null-terminated string to scan=2E
+ *
+ * @return true if =
any character in \c src satisfies \c isdigit()=2E
+ */
 static inline bool
=
 has_digit(const char *src)
 {
@@ -401,11 +718,20 @@
 #endif
 }
 
-/*
- * p=
rintf append to a buffer with overflow check,
- * due to usage of vsnprintf=
, it will leave space for
- * a final null character and thus use only
- * =
capacity - 1
+/**
+ * printf-style append to a buffer with overflow check=
=2E
+ *
+ * Formats a string and appends it to \c buf=2E  Due to the use of=

+ * \c vsnprintf(), one byte of forward capacity is reserved for a null
+ =
* terminator, so at most \c buf_forward_capacity(buf) - 1 bytes of
+ * form=
atted output are written=2E
+ *
+ * @param buf     The buffer to append to=
=2E
+ * @param format  printf-style format string=2E
+ * @param =2E=2E=2E  =
   Format arguments=2E
+ *
+ * @return true if the entire formatted string =
fit in the buffer, false if
+ *         it was truncated=2E
  */
 bool buf_=
printf(struct buffer *buf, const char *format, =2E=2E=2E)
 #ifdef __GNUC__
=
@@ -417,8 +743,13 @@
 #endif
     ;
 
-/*
- * puts append to a buffer with =
overflow check
+/**
+ * Append a string to a buffer with overflow check=2E
=
+ *
+ * @param buf   The buffer to append to=2E
+ * @param str   The null-t=
erminated string to append=2E
+ *
+ * @return true if the string fit in the=
 buffer, false if it was truncated=2E
  */
 bool buf_puts(struct buffer *bu=
f, const char *str);
 
@@ -427,24 +758,78 @@
  * remove/add trailing charac=
ters
  */
 
+/**
+ * Force a null terminator at the end of the buffer conte=
nt=2E
+ *
+ * If there is free capacity, a '\\0' byte is appended=2E  If th=
e buffer is
+ * full, the last content byte is overwritten with '\\0' (i=2E=
e=2E the last
+ * character is truncated to make room)=2E  The function has=
 no effect on an
+ * empty or invalid buffer=2E
+ *
+ * @param buf   The bu=
ffer to null-terminate=2E
+ */
 void buf_null_terminate(struct buffer *buf)=
;
 
+/**
+ * Remove trailing newline and carriage-return characters from a =
buffer=2E
+ *
+ * @param buf   The buffer to chomp=2E
+ */
 void buf_chomp(=
struct buffer *buf);
 
+/**
+ * Remove all occurrences of a specific byte f=
rom the end of a buffer=2E
+ *
+ * @param buf     The buffer to modify=2E
+=
 * @param remove  The byte value to strip from the tail=2E
+ */
 void buf_r=
mtail(struct buffer *buf, uint8_t remove);
 
-/*
- * non-buffer string func=
tions
+/** @name String Utility Functions
+ *  @brief Non-buffer string fun=
ctions
+ */
+/**@{*/
+
+/**
+ * Remove trailing newline and carriage-return=
 characters from a string=2E
+ *
+ * @param str   The null-terminated strin=
g to chomp=2E
  */
 void chomp(char *str);
 
+/**
+ * Remove all trailing c=
haracters that appear in a given set=2E
+ *
+ * @param str             The =
null-terminated string to modify in place=2E
+ * @param what_to_delete  Nul=
l-terminated set of characters to strip=2E
+ */
 void rm_trailing_chars(cha=
r *str, const char *what_to_delete);
 
+/**
+ * Return a pointer past any l=
eading whitespace in a string=2E
+ *
+ * @param str   The string to skip wh=
itespace in=2E
+ *
+ * @return Pointer to the first non-whitespace characte=
r, or to the null
+ *         terminator if \c str is all whitespace=2E
+ *=
/
 const char *skip_leading_whitespace(const char *str);
 
+/**
+ * Null-te=
rminate a fixed-length string buffer=2E
+ *
+ * Ensures that \c str[\c len]=
 is '\\0', clamping \c len to \c capacity - 1
+ * if necessary=2E
+ *
+ * @=
param str       The character buffer to null-terminate=2E
+ * @param len   =
    Current string length=2E
+ * @param capacity  Total size of the charact=
er buffer in bytes=2E
+ */
 #ifdef _WIN32
 void string_null_terminate(char =
*str, int len, int capacity);
 #endif
+/**@}*/
+/* End of string utility fu=
nctions */
 
 /**
  * Write buffer contents to file=2E
@@ -456,40 +841,114 =
@@
  */
 bool buffer_write_file(const char *filename, const struct buffer *=
buf);
 
-/*
- * write a string to the end of a buffer that was
- * truncate=
d by buf_printf
+/**
+ * Append a string to the physical end of a buffer th=
at was truncated by
+ * \c buf_printf()=2E
+ *
+ * If the buffer's forward =
capacity is one byte or less (i=2Ee=2E it is full),
+ * \c str is written a=
t the very end of the allocated memory to act as a
+ * truncation marker, p=
rovided it fits within the total buffer capacity=2E
+ * This is used to app=
end a "[more=2E=2E=2E]" suffix after hex-dump truncation=2E
+ *
+ * @param =
buf   The buffer to append the truncation marker to=2E
+ * @param str   The=
 null-terminated marker string to write=2E
  */
 void buf_catrunc(struct bu=
ffer *buf, const char *str);
 
-/*
- * Parse a string based on a given deli=
miter char
+/**
+ * Extract the next token from a buffer, delimited by a gi=
ven character=2E
+ *
+ * Reads bytes from \c buf one at a time until \c del=
im or end-of-buffer is
+ * encountered=2E  The token (without the delimiter=
) is written into \c line,
+ * which is always null-terminated=2E  The deli=
miter byte is consumed from
+ * \c buf but not included in \c line=2E
+ *
+=
 * @param buf    Source buffer to parse=2E  The consumed portion is advance=
d=2E
+ * @param delim  Delimiter character=2E
+ * @param line   Output buff=
er for the extracted token=2E
+ * @param size   Size of \c line in bytes (m=
ust be > 0)=2E
+ *
+ * @return false only when end-of-buffer is reached and=
 no characters were
+ *         extracted; true otherwise (including when a=
 delimiter was found
+ *         or \c line was truncated)=2E
  */
 bool bu=
f_parse(struct buffer *buf, const int delim, char *line, const int size);
 =

-/*
- * Hex dump -- Output a binary buffer to a hex string and return it=
=2E
+/** @name Hex Dump
+ *  @brief Output a binary buffer to a hex string =
and return it=2E
  */
-#define FHE_SPACE_BREAK_MASK 0xFF  /* space_break pa=
rameter in lower 8 bits */
-#define FHE_CAPS             0x100 /* output he=
x in caps */
+/**@{*/
+
+/** Mask for the space_break_flags field of \c for=
mat_hex_ex(): number of
+ *  bytes between separators (lower 8 bits)=2E */
=
+#define FHE_SPACE_BREAK_MASK 0xFF
+/** Flag for \c format_hex_ex(): output=
 hex digits in upper case=2E */
+#define FHE_CAPS             0x100
+/**
+ =
* Format a binary buffer as a hex string=2E
+ *
+ * @param data            =
  Pointer to the binary data to format=2E
+ * @param size              Numb=
er of bytes to format=2E
+ * @param maxoutput         Maximum number of out=
put characters (0 =3D unlimited)=2E
+ *                          If the out=
put is truncated, a "[more=2E=2E=2E]" suffix is
+ *                        =
  appended via \c buf_catrunc()=2E
+ * @param space_break_flags Lower 8 bit=
s (\c FHE_SPACE_BREAK_MASK) give the
+ *                          number of=
 bytes between \c separator insertions=2E
+ *                          Use =
\c FHE_CAPS to output upper-case hex digits=2E
+ * @param separator        =
 String to insert between groups of bytes=2E
+ * @param gc                G=
arbage collection arena for the returned string=2E
+ *
+ * @return Null-ter=
minated hex string allocated from \c gc=2E
+ */
 char *format_hex_ex(const =
uint8_t *data, size_t size, size_t maxoutput, unsigned int space_break_flag=
s,
                     const char *separator, struct gc_arena *gc);
 
+/**=

+ * Format a binary buffer as a hex string with spaces every 4 bytes=2E
+ =
*
+ * Convenience wrapper around \c format_hex_ex()=2E
+ *
+ * @param data =
      Pointer to the binary data to format=2E
+ * @param size       Number =
of bytes to format=2E
+ * @param maxoutput  Maximum number of output charac=
ters (0 =3D unlimited)=2E
+ * @param gc         Garbage collection arena fo=
r the returned string=2E
+ *
+ * @return Null-terminated hex string allocat=
ed from \c gc=2E
+ */
 static inline char *
 format_hex(const uint8_t *data=
, size_t size, size_t maxoutput, struct gc_arena *gc)
 {
     return format=
_hex_ex(data, size, maxoutput, 4, " ", gc);
 }
+/**@}*/
+/* End of Hex Dump=
 */
 
-/*
- * Return a buffer that is a subset of another buffer=2E
+/**
+ =
* Return a sub-buffer of another buffer=2E
+ *
+ * Either allocates \c size=
 bytes from the front or back of \c buf,
+ * shrinking \c buf accordingly, =
and returns a buffer pointing into the
+ * same memory=2E
+ *
+ * @param bu=
f      Source buffer to carve the sub-buffer from=2E
+ * @param size     Nu=
mber of bytes to include in the sub-buffer=2E
+ * @param prepend  If true, =
take bytes from the front of \c buf (prepend
+ *                 space); if=
 false, take bytes from the end (append space)=2E
+ *
+ * @return A buffer =
referencing the allocated region, or an undefined buffer
+ *         if \c =
buf has insufficient capacity=2E
  */
 struct buffer buf_sub(struct buffer =
*buf, int size, bool prepend);
 
-/*
- * Check if sufficient space to appen=
d to buffer=2E
+/**
+ * Check whether \c len bytes can be appended to a buf=
fer=2E
+ *
+ * @param buf   The buffer to check=2E
+ * @param len   Number =
of bytes to append=2E
+ *
+ * @return true if \c buf is valid, \c len is wi=
thin the allowed range, and
+ *         there is sufficient capacity after =
the current content=2E
  */
-
 static inline bool
 buf_safe(const struct bu=
ffer *buf, size_t len)
 {
@@ -497,6 +956,18 @@
            && buf->offset +=
 buf->len + (int)len <=3D buf->capacity;
 }
 
+/**
+ * Check whether \c len=
 bytes can be added to or removed from a buffer=2E
+ *
+ * Accepts negative=
 \c len to verify that bytes can be removed (length
+ * decreased)=2E
+ *
+=
 * @param buf   The buffer to check=2E
+ * @param len   Number of bytes to =
add (positive) or remove (negative)=2E
+ *
+ * @return true if the resultin=
g length would remain non-negative and within
+ *         the allocated cap=
acity=2E
+ */
 static inline bool
 buf_safe_bidir(const struct buffer *buf,=
 int len)
 {
@@ -511,6 +982,17 @@
     }
 }
 
+/**
+ * Return the number of=
 bytes that can still be appended to the buffer=2E
+ *
+ * This is the spac=
e between the end of the current content and the end of
+ * the allocated m=
emory=2E
+ *
+ * @param buf   The buffer to query=2E
+ *
+ * @return Number=
 of bytes available for appending, or 0 if \c buf is
+ *         invalid=2E=

+ */
 static inline int
 buf_forward_capacity(const struct buffer *buf)
 {=

@@ -529,6 +1011,17 @@
     }
 }
 
+/**
+ * Return the total number of byte=
s available from the current offset to the
+ * end of the allocated memory=
=2E
+ *
+ * Unlike \c buf_forward_capacity(), this includes the bytes alrea=
dy occupied
+ * by the current content=2E
+ *
+ * @param buf   The buffer t=
o query=2E
+ *
+ * @return Capacity minus offset, or 0 if \c buf is invalid=
=2E
+ */
 static inline int
 buf_forward_capacity_total(const struct buffer=
 *buf)
 {
@@ -547,6 +1040,16 @@
     }
 }
 
+/**
+ * Return the number of b=
ytes available for prepending to the buffer=2E
+ *
+ * This is the number o=
f bytes between the start of the allocated memory and
+ * the current conte=
nt start (i=2Ee=2E \c buf->offset)=2E
+ *
+ * @param buf   The buffer to qu=
ery=2E
+ *
+ * @return \c buf->offset, or 0 if \c buf is invalid=2E
+ */
 s=
tatic inline int
 buf_reverse_capacity(const struct buffer *buf)
 {
@@ -560=
,6 +1063,17 @@
     }
 }
 
+/**
+ * Increase or decrease the length of a bu=
ffer=2E
+ *
+ * Adjusts \c buf->len by \c inc bytes=2E  A negative \c inc s=
hrinks the
+ * buffer=2E  The operation is bounds-checked via \c buf_safe_b=
idir()=2E
+ *
+ * @param buf   The buffer to modify=2E
+ * @param inc   Num=
ber of bytes to add to the length (may be negative)=2E
+ *
+ * @return true=
 on success, false if the adjustment would violate bounds=2E
+ */
 static i=
nline bool
 buf_inc_len(struct buffer *buf, int inc)
 {
@@ -571,11 +1085,18=
 @@
     return true;
 }
 
-/*
- * Make space to prepend to a buffer=2E
- *=
 Return NULL if no space=2E
+/**
+ * Make space at the front of a buffer fo=
r prepending data=2E
+ *
+ * Moves the content start backwards by \c size b=
ytes, increasing \c len
+ * and decreasing \c offset by the same amount=2E
=
+ *
+ * @param buf   The buffer to modify=2E
+ * @param size  Number of byt=
es to reserve for prepending=2E
+ *
+ * @return Pointer to the newly reserv=
ed space (new content start), or NULL
+ *         if \c buf is invalid or t=
here is insufficient prepend capacity=2E
  */
-
 static inline uint8_t *
 b=
uf_prepend(struct buffer *buf, ssize_t size)
 {
@@ -588,6 +1109,17 @@
     =
return BPTR(buf);
 }
 
+/**
+ * Advance the content start of a buffer, cons=
uming bytes from the front=2E
+ *
+ * Increases \c offset and decreases \c =
len by \c size bytes=2E
+ *
+ * @param buf   The buffer to advance=2E
+ * @=
param size  Number of bytes to skip=2E
+ *
+ * @return true on success, fal=
se if \c buf is invalid or \c size exceeds
+ *         the current length=
=2E
+ */
 static inline bool
 buf_advance(struct buffer *buf, ssize_t size)=

 {
@@ -600,11 +1132,18 @@
     return true;
 }
 
-/*
- * Return a pointer =
to allocated space inside a buffer=2E
- * Return NULL if no space=2E
+/**
+=
 * Reserve space at the end of a buffer for writing=2E
+ *
+ * Increases \c=
 buf->len by \c size and returns a pointer to the start of
+ * the newly re=
served region=2E
+ *
+ * @param buf   The buffer to allocate space in=2E
+ =
* @param size  Number of bytes to reserve=2E
+ *
+ * @return Pointer to the=
 start of the reserved space, or NULL if there is
+ *         insufficient =
capacity=2E
  */
-
 static inline uint8_t *
 buf_write_alloc(struct buffer =
*buf, size_t size)
 {
@@ -618,6 +1157,18 @@
     return ret;
 }
 
+/**
+ * =
Consume bytes from the front of a buffer for reading=2E
+ *
+ * Returns a p=
ointer to the current content start and advances the buffer
+ * by \c size =
bytes=2E
+ *
+ * @param buf   The buffer to read from=2E
+ * @param size  N=
umber of bytes to consume=2E
+ *
+ * @return Pointer to the start of the co=
nsumed region, or NULL if \c size
+ *         is negative or exceeds the cu=
rrent length=2E
+ */
 static inline uint8_t *
 buf_read_alloc(struct buffer=
 *buf, int size)
 {
@@ -632,6 +1183,17 @@
     return ret;
 }
 
+/**
+ * Ap=
pend data to a buffer=2E
+ *
+ * Copies \c size bytes from \c src to the en=
d of \c dest=2E
+ *
+ * @param dest  Destination buffer=2E
+ * @param src  =
 Data to append=2E
+ * @param size  Number of bytes to append=2E
+ *
+ * @r=
eturn true on success, false if there is insufficient capacity=2E
+ */
 sta=
tic inline bool
 buf_write(struct buffer *dest, const void *src, size_t siz=
e)
 {
@@ -644,6 +1206,18 @@
     return true;
 }
 
+/**
+ * Prepend data to=
 a buffer=2E
+ *
+ * Copies \c size bytes from \c src into the prepend spac=
e at the front of
+ * \c dest=2E
+ *
+ * @param dest  Destination buffer=2E=

+ * @param src   Data to prepend=2E
+ * @param size  Number of bytes to pr=
epend=2E
+ *
+ * @return true on success, false if there is insufficient pr=
epend capacity=2E
+ */
 static inline bool
 buf_write_prepend(struct buffer=
 *dest, const void *src, int size)
 {
@@ -656,12 +1230,28 @@
     return tr=
ue;
 }
 
+/**
+ * Append a uint8_t to a buffer=2E
+ *
+ * @param dest  Dest=
ination buffer=2E
+ * @param data  Byte to append=2E
+ *
+ * @return true o=
n success, false if there is insufficient capacity=2E
+ */
 static inline b=
ool
 buf_write_u8(struct buffer *dest, uint8_t data)
 {
     return buf_wri=
te(dest, &data, sizeof(uint8_t));
 }
 
+/**
+ * Append a uint16_t to a buff=
er in network byte order=2E
+ *
+ * @param dest  Destination buffer=2E
+ * =
@param data  Value to append (converted with \c htons())=2E
+ *
+ * @return=
 true on success, false if there is insufficient capacity=2E
+ */
 static i=
nline bool
 buf_write_u16(struct buffer *dest, uint16_t data)
 {
@@ -669,6 =
+1259,14 @@
     return buf_write(dest, &u16, sizeof(uint16_t));
 }
 
+/**
=
+ * Append a uint32_t to a buffer in network byte order=2E
+ *
+ * @param d=
est  Destination buffer=2E
+ * @param data  Value to append (converted with=
 \c htonl())=2E
+ *
+ * @return true on success, false if there is insuffic=
ient capacity=2E
+ */
 static inline bool
 buf_write_u32(struct buffer *des=
t, uint32_t data)
 {
@@ -676,6 +1274,14 @@
     return buf_write(dest, &u32=
, sizeof(uint32_t));
 }
 
+/**
+ * Append a uint64_t to a buffer in network=
 byte order=2E
+ *
+ * @param dest  Destination buffer=2E
+ * @param data  =
Value to append (converted with \c htonll())=2E
+ *
+ * @return true on suc=
cess, false if there is insufficient capacity=2E
+ */
 static inline bool
 =
buf_write_u64(struct buffer *dest, uint64_t data)
 {
@@ -683,12 +1289,32 @@=

     return buf_write(dest, &u64, sizeof(uint64_t));
 }
 
+/**
+ * Copy th=
e content of one buffer to the end of another=2E
+ *
+ * @param dest  Desti=
nation buffer=2E
+ * @param src   Source buffer=2E
+ *
+ * @return true on =
success, false if \c dest has insufficient capacity=2E
+ */
 static inline =
bool
 buf_copy(struct buffer *dest, const struct buffer *src)
 {
     retur=
n buf_write(dest, BPTR(src), BLENZ(src));
 }
 
+/**
+ * Read \c n bytes fro=
m \c src and append them to \c dest=2E
+ *
+ * Consumes the bytes from \c s=
rc=2E
+ *
+ * @param dest  Destination buffer=2E
+ * @param src   Source bu=
ffer (modified)=2E
+ * @param n     Number of bytes to copy=2E
+ *
+ * @ret=
urn true on success, false if \c src has fewer than \c n bytes or
+ *      =
   \c dest has insufficient capacity=2E
+ */
 static inline bool
 buf_copy_=
n(struct buffer *dest, struct buffer *src, int n)
 {
@@ -700,6 +1326,22 @@
=
     return buf_write(dest, cp, n);
 }
 
+/**
+ * Copy a range of bytes fro=
m one buffer into a specific position in another=2E
+ *
+ * Copies \c src_l=
en bytes starting at \c src_index within \c src content
+ * into \c dest at=
 \c dest_index relative to the content start=2E  Updates
+ * \c dest->len i=
f the write extends beyond the current content=2E  Does not
+ * advance eit=
her buffer's offset=2E
+ *
+ * @param dest        Destination buffer=2E
+ *=
 @param dest_index  Byte offset within \c dest content to write at=2E
+ * @=
param src         Source buffer=2E
+ * @param src_index   Byte offset withi=
n \c src content to read from=2E
+ * @param src_len     Number of bytes to =
copy=2E
+ *
+ * @return true on success, false if any index or length is ou=
t of range=2E
+ */
 static inline bool
 buf_copy_range(struct buffer *dest,=
 int dest_index, const struct buffer *src, int src_index,
                i=
nt src_len)
@@ -717,7 +1359,19 @@
     return true;
 }
 
-/* truncate src t=
o len, copy excess data beyond len to dest */
+/**
+ * Truncate \c src to \=
c len bytes and copy any excess to \c dest=2E
+ *
+ * If \c src->len > \c l=
en, \c src is truncated to \c len bytes and the
+ * remaining bytes are app=
ended to \c dest=2E  If \c src->len <=3D \c len,
+ * nothing is copied and =
true is returned=2E
+ *
+ * @param dest  Destination buffer for the excess =
data=2E
+ * @param src   Source buffer to truncate=2E
+ * @param len   Maxi=
mum number of bytes to keep in \c src=2E
+ *
+ * @return true on success, f=
alse if \c len is negative or copying fails=2E
+ */
 static inline bool
 bu=
f_copy_excess(struct buffer *dest, struct buffer *src, int len)
 {
@@ -741,=
6 +1395,17 @@
     }
 }
 
+/**
+ * Read bytes from the front of a buffer in=
to a caller-supplied destination=2E
+ *
+ * Consumes \c size bytes from \c =
src and copies them to \c dest=2E
+ *
+ * @param src   Source buffer (modif=
ied)=2E
+ * @param dest  Destination memory=2E
+ * @param size  Number of b=
ytes to read=2E
+ *
+ * @return true on success, false if \c src has fewer =
than \c size bytes=2E
+ */
 static inline bool
 buf_read(struct buffer *src=
, void *dest, int size)
 {
@@ -753,6 +1418,14 @@
     return true;
 }
 
+/*=
*
+ * Return the first byte of the buffer without consuming it=2E
+ *
+ * @=
param buf   The buffer to peek at=2E
+ *
+ * @return The first byte as an u=
nsigned value (0=E2=80=93255), or -1 if the buffer
+ *         is empty=2E
=
+ */
 static inline int
 buf_peek_u8(struct buffer *buf)
 {
@@ -765,6 +1438=
,13 @@
     return ret;
 }
 
+/**
+ * Read and consume a uint8_t from the f=
ront of a buffer=2E
+ *
+ * @param buf   The buffer to read from=2E
+ *
+ *=
 @return The byte value (0=E2=80=93255), or -1 if the buffer is empty=2E
+ =
*/
 static inline int
 buf_read_u8(struct buffer *buf)
 {
@@ -776,6 +1456,1=
6 @@
     return ret;
 }
 
+/**
+ * Read and consume a uint16_t from the fr=
ont of a buffer=2E
+ *
+ * The value is converted from network byte order v=
ia \c ntohs()=2E
+ *
+ * @param buf   The buffer to read from=2E
+ *
+ * @r=
eturn The host-byte-order value, or -1 if the buffer has fewer than 2
+ *  =
       bytes=2E
+ */
 static inline int
 buf_read_u16(struct buffer *buf)
 =
{
@@ -787,6 +1477,17 @@
     return ntohs(ret);
 }
 
+/**
+ * Read and cons=
ume a uint32_t from the front of a buffer=2E
+ *
+ * The value is converted=
 from network byte order via \c ntohl()=2E
+ *
+ * @param buf   The buffer =
to read from=2E
+ * @param good  If non-NULL, set to true on success or fal=
se on failure=2E
+ *
+ * @return The host-byte-order value, or 0 if the buf=
fer has fewer than 4
+ *         bytes (check \c *good to distinguish from =
a legitimate zero)=2E
+ */
 static inline uint32_t
 buf_read_u32(struct buf=
fer *buf, bool *good)
 {
@@ -809,8 +1510,17 @@
     }
 }
 
-/* Read a 64-bi=
t big-endian value (see buf_write_u64())=2E Sets *good to indicate
- * succ=
ess, like buf_read_u32()=2E */
+/**
+ * Read and consume a uint64_t from th=
e front of a buffer=2E
+ *
+ * The value is converted from network byte ord=
er via \c ntohll()=2E
+ *
+ * @param buf   The buffer to read from=2E
+ * @=
param good  If non-NULL, set to true on success or false on failure=2E
+ *
=
+ * @return The host-byte-order value, or 0 if the buffer has fewer than 8
=
+ *         bytes (check \c *good to distinguish from a legitimate zero)=2E=

+ */
 static inline uint64_t
 buf_read_u64(struct buffer *buf, bool *good)=

 {
@@ -868,31 +1578,73 @@
     return memcmp(BPTR(src), match, size) =3D=
=3D 0;
 }
 
+/**
+ * Return true if the head of \c src matches the string \=
c match=2E
+ *
+ * Compares the first \c strlen(match) bytes of \c src cont=
ent with \c match=2E
+ * *NOT* constant time=2E Do not use when comparing H=
MACs=2E
+ *
+ * @param src    Buffer whose head is compared=2E
+ * @param m=
atch  Null-terminated string to compare against=2E
+ *
+ * @return true if =
the buffer starts with \c match=2E
+ */
 bool buf_string_match_head_str(con=
st struct buffer *src, const char *match);
 
+/**
+ * Compare the head of \=
c src with \c match and advance past it if equal=2E
+ *
+ * If the buffer s=
tarts with \c match, the matched bytes are consumed from
+ * \c src=2E  *NO=
T* constant time=2E Do not use when comparing HMACs=2E
+ *
+ * @param src  =
  Buffer to compare and advance=2E
+ * @param match  Null-terminated string=
 to compare against=2E
+ *
+ * @return true if the buffer started with \c m=
atch (and was advanced)=2E
+ */
 bool buf_string_compare_advance(struct buf=
fer *src, const char *match);
 
+/**
+ * Return the length of the next toke=
n in a buffer up to a delimiter=2E
+ *
+ * Scans the buffer content for \c =
delim and returns the number of bytes
+ * up to (but not including) the del=
imiter, or the full buffer length if
+ * the delimiter is not found=2E
+ *
=
+ * @param buf    The buffer to scan=2E
+ * @param delim  Delimiter byte to=
 search for=2E
+ *
+ * @return Number of bytes before the first occurrence =
of \c delim, or -1
+ *         if the buffer is empty=2E
+ */
 int buf_subs=
tring_len(const struct buffer *buf, int delim);
 
-/*
- * Print a string wh=
ich might be NULL
+/**
+ * Return a printable representation of a string th=
at might be NULL=2E
+ *
+ * @param str   String to print, or NULL=2E
+ *
+ =
* @return \c str if non-NULL, otherwise the string \c "[NULL]"=2E
  */
 con=
st char *np(const char *str);
 
-/* character classes */
-
+/** @name Chara=
cter classes
+ *  @brief Check or modify strings based on classes of allowe=
d
+ *         or forbidden characters=2E
+ */
+/**@{*/
 #define CC_ANY  (1 =
<< 0)           /**< any character */
 #define CC_NULL (1 << 1)           /=
**< null character \0 */
 
-#define CC_ALNUM  (1 << 2)         /**< alphanu=
meric isalnum() */
-#define CC_ALPHA  (1 << 3)         /**< alphabetic isal=
pha() */
+#define CC_ALNUM  (1 << 2)         /**< alphanumeric \c isalnum()=
 */
+#define CC_ALPHA  (1 << 3)         /**< alphabetic \c isalpha() */
 #d=
efine CC_ASCII  (1 << 4)         /**< ASCII character */
-#define CC_CNTRL =
 (1 << 5)         /**< control character iscntrl() */
-#define CC_DIGIT  (1=
 << 6)         /**< digit isdigit() */
+#define CC_CNTRL  (1 << 5)         =
/**< control character \c iscntrl() */
+#define CC_DIGIT  (1 << 6)         =
/**< digit \c isdigit() */
 #define CC_PRINT  (1 << 7)         /**< printab=
le (>=3D 32, !=3D 127) */
-#define CC_PUNCT  (1 << 8)         /**< punctuat=
ion ispunct() */
-#define CC_SPACE  (1 << 9)         /**< whitespace isspac=
e() */
-#define CC_XDIGIT (1 << 10)        /**< hex digit isxdigit() */
+#d=
efine CC_PUNCT  (1 << 8)         /**< punctuation \c ispunct() */
+#define =
CC_SPACE  (1 << 9)         /**< whitespace \c isspace() */
+#define CC_XDIG=
IT (1 << 10)        /**< hex digit \c isxdigit() */
 
 #define CC_BLANK   (=
1 << 11)       /**< space or tab */
 #define CC_NEWLINE (1 << 12)       /**=
< newline */
@@ -920,8 +1672,27 @@
 #define CC_NAME (CC_ALNUM | CC_UNDERBAR=
) /**< alphanumeric plus underscore */
 #define CC_CRLF (CC_CR | CC_NEWLINE=
)     /**< carriage return or newline */
 
+/**
+ * Test whether a characte=
r belongs to one or more character classes=2E
+ *
+ * @param c      The cha=
racter to test=2E
+ * @param flags  Bitmask of \c CC_* character class flag=
s=2E
+ *
+ * @return true if \c c matches any of the classes specified in \=
c flags=2E
+ */
 bool char_class(const unsigned char c, const unsigned int =
flags);
 
+/**
+ * Test whether all characters in a string satisfy a charac=
ter class filter=2E
+ *
+ * @param str        The null-terminated string to=
 test=2E
+ * @param inclusive  Classes that are permitted (characters must =
match at
+ *                   least one of these)=2E
+ * @param exclusive =
 Classes that are forbidden (characters must not match
+ *                 =
  any of these, even if they also match \c inclusive)=2E
+ *
+ * @return tr=
ue if every character in \c str is permitted=2E
+ */
 bool string_class(con=
st char *str, const unsigned int inclusive, const unsigned int exclusive);
=
 
 /**
@@ -968,10 +1739,27 @@
  */
 const char *string_mod_const(const char=
 *str, const unsigned int inclusive,
                              const un=
signed int exclusive, const char replace, struct gc_arena *gc);
+/**@}*/
 
=
+/**
+ * Replace all leading occurrences of a character in a string=2E
+ *
=
+ * Scans from the start of \c str and replaces every consecutive \c match
=
+ * character with \c replace, stopping at the first character that does no=
t
+ * match=2E
+ *
+ * @param str      The null-terminated string to modify=
 in place=2E
+ * @param match    The character to replace=2E
+ * @param rep=
lace  The replacement character=2E
+ */
 void string_replace_leading(char *=
str, const char match, const char replace);
 
-/** Return true iff str star=
ts with prefix */
+/**
+ * Return true iff \c str starts with \c prefix=2E
=
+ *
+ * @param str     The string to test=2E
+ * @param prefix  The prefix =
to look for=2E
+ */
 static inline bool
 strprefix(const char *str, const c=
har *prefix)
 {
@@ -1006,6 +1794,16 @@
  * Verify that a pointer is correct=
ly aligned
  */
 #ifdef VERIFY_ALIGNMENT
+/**
+ * Assert that the content p=
ointer of \c buf is 4-byte aligned=2E
+ *
+ * Only compiled in when \c VERI=
FY_ALIGNMENT is defined=2E  Called via the
+ * \c verify_align_4() macro=2E=

+ *
+ * @param buf   Buffer whose content pointer is to be checked=2E
+ * =
@param file  Source file of the call site (for the error message)=2E
+ * @p=
aram line  Source line of the call site (for the error message)=2E
+ */
 vo=
id valign4(const struct buffer *buf, const char *file, const int line);
 
 =
#define verify_align_4(ptr) valign4(buf, __FILE__, __LINE__)
@@ -1013,23 +1=
811,58 @@
 #define verify_align_4(ptr)
 #endif
 
-/*
- * Very basic garbage=
 collection, mostly for routines that return
- * char ptrs to malloced stri=
ngs=2E
+/** @name Garbage Collection
+ *  @brief Basic garbage collection, =
mostly for routines that return
+ *         char ptrs to malloced strings=
=2E
  */
+/**@{*/
 
+/**
+ * Move all allocations from one garbage collecti=
on arena to another=2E
+ *
+ * After the call \c src is empty and all entri=
es previously in \c src are
+ * owned by \c dest=2E
+ *
+ * @param dest  Ar=
ena to move allocations into=2E
+ * @param src   Arena to move allocations =
from (emptied on return)=2E
+ */
 void gc_transfer(struct gc_arena *dest, s=
truct gc_arena *src);
 
+/**
+ * Free all plain allocations in a garbage co=
llection arena=2E
+ *
+ * Internal implementation called by \c gc_free()=2E=
  Do not call directly=2E
+ *
+ * @param a  The arena whose \c list entries=
 are to be freed=2E
+ */
 void x_gc_free(struct gc_arena *a);
 
+/**
+ * Fr=
ee all specially-allocated entries in a garbage collection arena=2E
+ *
+ *=
 Internal implementation called by \c gc_free()=2E  Do not call directly=2E=

+ * Invokes the custom free function stored in each \c gc_entry_special=2E=

+ *
+ * @param a  The arena whose \c list_special entries are to be freed=
=2E
+ */
 void x_gc_freespecial(struct gc_arena *a);
 
+/**
+ * Return true=
 iff the arena contains at least one allocation=2E
+ *
+ * @param a  The ar=
ena to test=2E
+ */
 static inline bool
 gc_defined(struct gc_arena *a)
 {
=
     return a->list !=3D NULL;
 }
 
+/**
+ * Initialise a garbage collectio=
n arena to an empty state=2E
+ *
+ * @param a  The arena to initialise=2E
+=
 */
 static inline void
 gc_init(struct gc_arena *a)
 {
@@ -1037,12 +1870,2=
5 @@
     a->list_special =3D NULL;
 }
 
+/**
+ * Detach all allocations fr=
om an arena without freeing them=2E
+ *
+ * After this call the arena is em=
pty=2E  The caller takes responsibility for
+ * freeing the previously regi=
stered allocations=2E
+ *
+ * @param a  The arena to detach=2E
+ */
 static=
 inline void
 gc_detach(struct gc_arena *a)
 {
     gc_init(a);
 }
 
+/**
+=
 * Allocate and return a new, empty garbage collection arena=2E
+ *
+ * @re=
turn An initialised \c gc_arena with empty lists=2E
+ */
 static inline str=
uct gc_arena
 gc_new(void)
 {
@@ -1051,6 +1897,14 @@
     return ret;
 }
 
=
+/**
+ * Free all allocations in a garbage collection arena=2E
+ *
+ * Call=
s \c x_gc_free() and \c x_gc_freespecial() as needed to release all
+ * reg=
istered memory=2E
+ *
+ * @param a  The arena to free=2E
+ */
 static inlin=
e void
 gc_free(struct gc_arena *a)
 {
@@ -1064,6 +1918,13 @@
     }
 }
 
+=
/**
+ * Free all allocations in a garbage collection arena and reinitialise=
 it=2E
+ *
+ * Equivalent to calling \c gc_free() followed by \c gc_init()=
=2E
+ *
+ * @param a  The arena to reset=2E
+ */
 static inline void
 gc_re=
set(struct gc_arena *a)
 {
@@ -1081,58 +1942,139 @@
 /* 1 GB on 32bit syste=
ms, they usually can only allocate 2 GB for the
  * whole process=2E
  */
+=
/** Maximum size for a single array allocation (checked by \c array_mult_sa=
fe())=2E */
 #define ALLOC_SIZE_MAX (1u << 30)
 #else
+/** Maximum size for=
 a single array allocation (checked by \c array_mult_safe())=2E */
 #define=
 ALLOC_SIZE_MAX ((size_t)1 << 32) /* 4 GB */
 #endif
 
+/**
+ * Allocate me=
mory for a single object of the given type=2E
+ *
+ * Calls \c check_malloc=
_return() to abort on allocation failure=2E
+ *
+ * @param dptr  Pointer va=
riable that receives the allocation=2E
+ * @param type  Type of the object =
to allocate=2E
+ */
 #define ALLOC_OBJ(dptr, type)                         =
              \
     {                                                     =
          \
         check_malloc_return((dptr) =3D (type *)malloc(sizeof(t=
ype))); \
     }
 
+/**
+ * Allocate and zero-initialise memory for a singl=
e object of the given type=2E
+ *
+ * @param dptr  Pointer variable that re=
ceives the allocation=2E
+ * @param type  Type of the object to allocate=2E=

+ */
 #define ALLOC_OBJ_CLEAR(dptr, type)      \
     {                   =
                 \
         ALLOC_OBJ(dptr, type);           \
         mem=
set((dptr), 0, sizeof(type)); \
     }
 
+/**
+ * Allocate memory for an ar=
ray of \c n elements of the given type=2E
+ *
+ * Uses \c array_mult_safe()=
 to guard against size overflow=2E
+ * Calls \c check_malloc_return() to ab=
ort on allocation failure=2E
+ *
+ * @param dptr  Pointer variable that rec=
eives the allocation=2E
+ * @param type  Element type of the array=2E
+ * @=
param n     Number of elements=2E
+ */
 #define ALLOC_ARRAY(dptr, type, n) =
                                                          \
     {         =
                                                                           =
    \
         check_malloc_return((dptr) =3D (type *)malloc(array_mult_saf=
e(sizeof(type), (n), 0))); \
     }
 
+/**
+ * Allocate a garbage-collected=
 array of \c n elements of the given type=2E
+ *
+ * @param dptr  Pointer v=
ariable that receives the allocation=2E
+ * @param type  Element type of th=
e array=2E
+ * @param n     Number of elements=2E
+ * @param gc    Garbage =
collection arena to register the allocation with=2E
+ */
 #define ALLOC_ARR=
AY_GC(dptr, type, n, gc)                                               \
  =
   {                                                                       =
            \
         (dptr) =3D (type *)gc_malloc(array_mult_safe(sizeof(=
type), (n), 0), false, (gc)); \
     }
 
+/**
+ * Allocate and zero-initial=
ise an array of \c n elements of the given type=2E
+ *
+ * @param dptr  Poi=
nter variable that receives the allocation=2E
+ * @param type  Element type=
 of the array=2E
+ * @param n     Number of elements=2E
+ */
 #define ALLOC=
_ARRAY_CLEAR(dptr, type, n)                            \
     {            =
                                                   \
         ALLOC_ARRAY(d=
ptr, type, n);                                 \
         memset((dptr), 0,=
 (array_mult_safe(sizeof(type), (n), 0))); \
     }
 
+/**
+ * Allocate and=
 zero-initialise a garbage-collected array of \c n elements=2E
+ *
+ * @par=
am dptr  Pointer variable that receives the allocation=2E
+ * @param type  =
Element type of the array=2E
+ * @param n     Number of elements=2E
+ * @pa=
ram gc    Garbage collection arena to register the allocation with=2E
+ */
=
 #define ALLOC_ARRAY_CLEAR_GC(dptr, type, n, gc)                           =
             \
     {                                                      =
                            \
         (dptr) =3D (type *)gc_malloc(array_m=
ult_safe(sizeof(type), (n), 0), true, (gc)); \
     }
 
+/**
+ * Allocate a=
nd zero-initialise a garbage-collected variable-length structure=2E
+ *
+ *=
 Allocates \c sizeof(type) + \c n * \c sizeof(atype) bytes for a structure
=
+ * that embeds a variable-length array of \c atype as its last member=2E
+=
 *
+ * @param dptr   Pointer variable that receives the allocation=2E
+ * @=
param type   Type of the enclosing structure=2E
+ * @param atype  Element t=
ype of the variable-length array member=2E
+ * @param n      Number of arra=
y elements=2E
+ * @param gc     Garbage collection arena to register the al=
location with=2E
+ */
 #define ALLOC_VAR_ARRAY_CLEAR_GC(dptr, type, atype, =
n, gc)                                         \
     {                    =
                                                                          \=

         (dptr) =3D (type *)gc_malloc(array_mult_safe(sizeof(atype), (n), =
sizeof(type)), true, (gc)); \
     }
 
+/**
+ * Allocate a garbage-collecte=
d object of the given type (uninitialised)=2E
+ *
+ * @param dptr  Pointer =
variable that receives the allocation=2E
+ * @param type  Type of the objec=
t to allocate=2E
+ * @param gc    Garbage collection arena to register the =
allocation with=2E
+ */
 #define ALLOC_OBJ_GC(dptr, type, gc)              =
             \
     {                                                      =
    \
         (dptr) =3D (type *)gc_malloc(sizeof(type), false, (gc)); \
 =
    }
 
+/**
+ * Allocate and zero-initialise a garbage-collected object of=
 the given type=2E
+ *
+ * @param dptr  Pointer variable that receives the =
allocation=2E
+ * @param type  Type of the object to allocate=2E
+ * @param=
 gc    Garbage collection arena to register the allocation with=2E
+ */
 #d=
efine ALLOC_OBJ_CLEAR_GC(dptr, type, gc)                    \
     {       =
                                                  \
         (dptr) =3D (ty=
pe *)gc_malloc(sizeof(type), true, (gc)); \
     }
 
+/**
+ * Abort if a me=
mory allocation returned NULL=2E
+ *
+ * @param p  Return value from \c mal=
loc() or similar; calls \c out_of_memory()
+ *           if \c p is NULL=2E=

+ */
 static inline void
 check_malloc_return(void *p)
 {
@@ -1141,22 +208=
3,28 @@
         out_of_memory();
     }
 }
+/**@}*/
+/* End of GC */
 
-/*=

- * Manage lists of buffers
+/** @name Buffer Lists
+ *  @brief Manage lis=
ts of buffers
  */
+/**@{*/
+
+/** One node in a \c buffer_list linked list=
=2E */
 struct buffer_entry
 {
-    struct buffer buf;
-    struct buffer_e=
ntry *next;
+    struct buffer buf;         /**< The buffer stored in this =
list node=2E */
+    struct buffer_entry *next; /**< Pointer to the next no=
de, or NULL=2E */
 };
 
+/** A singly-linked list of buffers, with head/tai=
l pointers for O(1) push=2E */
 struct buffer_list
 {
-    struct buffer_en=
try *head; /* next item to pop/peek */
-    struct buffer_entry *tail; /* l=
ast item pushed */
-    size_t size;               /* current number of ent=
ries */
-    size_t max_size;           /* maximum size list should grow to=
 */
+    struct buffer_entry *head; /**< Next item to pop/peek=2E */
+    s=
truct buffer_entry *tail; /**< Last item pushed=2E */
+    size_t size;    =
           /**< Current number of entries=2E */
+    size_t max_size;      =
     /**< Maximum number of entries allowed=2E */
 };
 
 /**
@@ -1217,8 +21=
65,24 @@
  */
 struct buffer *buffer_list_peek(struct buffer_list *ol);
 
+=
/**
+ * Advance past \c n bytes in the head buffer, popping it if it become=
s empty=2E
+ *
+ * \c n must not exceed the length of the head buffer; pass=
ing a larger value
+ * triggers an assertion failure=2E
+ *
+ * @param ol  =
The list whose head buffer is to be advanced=2E
+ * @param n   Number of by=
tes to skip in the head buffer=2E
+ */
 void buffer_list_advance(struct buf=
fer_list *ol, ssize_t n);
 
+/**
+ * Remove and free the head buffer of the=
 list=2E
+ *
+ * Does nothing if \c ol is NULL or empty=2E
+ *
+ * @param o=
l  The list to pop from=2E
+ */
 void buffer_list_pop(struct buffer_list *o=
l);
 
 /**
@@ -1246,6 +2210,20 @@
  */
 void buffer_list_aggregate_separato=
r(struct buffer_list *bl, const size_t max_len, const char *sep);
 
+/**
+ =
* Read a file into a buffer list, one buffer per line=2E
+ *
+ * Opens \c f=
n for reading and pushes each line into a newly allocated buffer
+ * list u=
sing \c fgets()=2E  Lines longer than \c max_line_len - 1 bytes are
+ * spl=
it across multiple consecutive buffers=2E
+ *
+ * @param fn            Path=
 to the file to read=2E
+ * @param max_line_len  Maximum number of bytes (i=
ncluding null terminator)
+ *                      read per \c fgets() call=
=2E
+ *
+ * @return Pointer to the new buffer list, or NULL if the file cou=
ld not be
+ *         opened or memory allocation failed=2E
+ */
 struct bu=
ffer_list *buffer_list_file(const char *fn, int max_line_len);
 
 /**
@@ -1=
259,5 +2237,7 @@
  * error
  */
 struct buffer buffer_read_from_file(const =
char *filename, struct gc_arena *gc);
+/**@}*/
+/* End of Buffer Lists */
 =

 #endif /* BUFFER_H */

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1581?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I350ca5b08379ede1480b81055d35dd9a33e30cff
Gerrit-Change-Number: 1581
Gerr=
it-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>

--BvUf1RQHp2s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1581?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">doc: add Doxygen documentation to buffer=
=2Eh<br><br>Document all previously undocumented elements=2E<br><br>Github:=
 Fixes #864<br>Change-Id: I350ca5b08379ede1480b81055d35dd9a33e30cff<br>Sign=
ed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: A=
rne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1581<br>Message-Id: &lt;20260810120941=2E3142=
3-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/op=
envpn-devel@lists=2Esourceforge=2Enet/msg38269=2Ehtml<br>Signed-off-by: Ger=
t Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/buffer=2E=
h<br>1 file changed, 1,045 insertions(+), 65 deletions(-)<br><br></pre>
<pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><spa=
n>index 743c3f4=2E=2E74c84b2 100644</span><br><span>--- a/src/openvpn/buffe=
r=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -20,6=
 +20,15 @@</span><br><span>  *  with this program; if not, see &lt;https://=
www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span>  */</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @file</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @brief Buffer management functions and garbage =
collection=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This module provides=
 the core \c buffer type used throughout OpenVPN to</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * hold packet data, as well as a simple =
memory management system</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * (\c gc_arena / \c gc_malloc()) and various string/memory utility fu=
nctions=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifndef=
 BUFFER_H</span><br><span> #define BUFFER_H</span><br><span> </span><br><sp=
an>@@ -27,6 +36,7 @@</span><br><span> #include &quot;error=2Eh&quot;</span>=
<br><span> #include &quot;integer=2Eh&quot;</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/** Maximum allowed size (in byte=
s) for a single buffer allocation=2E */</span><br><span> #define BUF_SIZE_M=
AX 1000000</span><br><span> </span><br><span> /*</span><br><span>@@ -115,51=
 +125,213 @@</span><br><span>  */</span><br><span> struct gc_arena</span><b=
r><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct =
gc_entry *list; /**&lt; First element of the linked list of</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                            *   \c gc=
_entry structures=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    struct gc_entry_special *list_special;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct gc_entry *list;                 /**&lt;=
 First element of the linked list of</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                            *   \c gc_entr=
y structures=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct gc_entry_special *list_special; /**&lt; First element of the link=
ed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
                           *   list of \c gc_entry_special</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                    =
        *   structures for allocations</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                            *   requirin=
g a custom free</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                                        *   function=2E */</span><br><span>=
 };</span><br><span> </span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/** Return a pointer to the start of the buffer content=
=2E @see buf_bptr() */</span><br><span> #define BPTR(buf)  (buf_bptr(buf))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Return a pointer=
 one past the end of the buffer content=2E @see buf_bend() */</span><br><sp=
an> #define BEND(buf)  (buf_bend(buf))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/** Return a pointer to the last byte of the buffer cont=
ent, or NULL if empty=2E @see buf_blast() */</span><br><span> #define BLAST=
(buf) (buf_blast(buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/** Return the length of the buffer content in bytes=2E @see buf_len() *=
/</span><br><span> #define BLEN(buf)  (buf_len(buf))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/** Return the length of the buffer conte=
nt as a \c size_t=2E @see buf_len() */</span><br><span> #define BLENZ(buf) =
((size_t)buf_len(buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/** Return true iff the buffer is defined (has non-NULL data pointer)=2E=
 @see buf_defined() */</span><br><span> #define BDEF(buf)  (buf_defined(buf=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Return the bu=
ffer content pointer cast to \c char *=2E @see buf_str() */</span><br><span=
> #define BSTR(buf)  (buf_str(buf))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/** Return the number of bytes available for appending to t=
he buffer=2E @see buf_forward_capacity() */</span><br><span> #define BCAP(b=
uf)  (buf_forward_capacity(buf))</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * Zeroise and reset a buffer=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Sets all allocated memory to zero and resets \c offset and \c=
 len to zero,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * but=
 does not free the underlying memory=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param buf   The buffer to clear=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span> void buf_clear(struct buffer *bu=
f);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Free the me=
mory allocated for a buffer=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Fre=
es \c buf-&gt;data and resets the buffer to an undefined state=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param buf   The buffer whose memory is to =
be freed=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</spa=
n><br><span> void free_buf(struct buffer *buf);</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Assign the content of one buffer to anothe=
r=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Copies the content of \c src =
into \c dest=2E  The destination buffer must</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * already be allocated with sufficient capacity=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param dest  Destination buffe=
r to write into=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param src   Source buffer to read from=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @return true on success, false if \c dest has insufficient capac=
ity=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span> bool buf_assign(struct buffer *dest, const struct buffer *src);</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Securely clear a n=
ull-terminated string=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Overwrite=
s all characters of \c str with zeroes=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param str   The string to clear=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ */</span><br><span> void string_clear(char *str);<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return the numb=
er of elements in a NULL-terminated array of strings=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param array     NULL-terminated array of string poin=
ters=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @return Number of non-NULL=
 elements=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span> int string_array_len(const char **array);</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * Safely compute the product of two =
sizes plus an extra amount=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Each=
 of \c m1, \c m2, and \c extra, as well as the final result, are</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * checked against \c ALLOC_SI=
ZE_MAX=2E  If any value exceeds the limit the</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * function calls \c msg(M_FATAL) and does not re=
turn=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param m1    First multipl=
icand=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param m=
2    Second multiplicand=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param extra Value to add to the product=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @return \c m1 * \c m2 + \c extra=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> size_t array_mult=
_safe(const size_t m1, const size_t m2, const size_t extra);</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Flag for pri=
nt_argv(): wrap each argument in square brackets=2E */</span><br><span> #de=
fine PA_BRACKET (1 &lt;&lt; 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Fo=
rmat a NULL-terminated argument vector as a single string=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param p     NULL-terminated array of string poi=
nters to format=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param gc    Garbage collection arena for the returned string=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param flags Formatting f=
lags (e=2Eg=2E \c PA_BRACKET)=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
return Newly allocated string representation of \c p=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> char *print_argv(c=
onst char **p, struct gc_arena *gc, const unsigned int flags);</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Report a buffer size error =
and abort=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Called when a request=
ed buffer size exceeds \c BUF_SIZE_MAX or is otherwise</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * invalid=2E  Calls \c msg(M_FATAL) and=
 does not return=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param size  T=
he invalid size that was requested=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span> void buf_size_error(const size_t siz=
e);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Allocate a =
buffer of the given size=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Calls =
\c out_of_memory() if the allocation fails=2E The caller is responsible</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * for freeing the memo=
ry=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param size  Number of bytes=
 to allocate=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return Newly allo=
cated buffer of capacity \c size=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span> struct buffer alloc_buf(size_t size);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-stru=
ct buffer alloc_buf_gc(size_t size,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                           struct gc_arena *gc); /* allocate =
buffer with garbage collection */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 Allocate a buffer of the given size under garbage collection=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * The allocated memory is registered with \c g=
c so that it is freed when</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * \c gc_free() is called on the arena=2E  Calls \c out_of_memory() =
if the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * allocation=
 fails=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param size  Number of b=
ytes to allocate=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param gc    Garbage collection arena to register the allocation with=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @return Newly allocated buffer of=
 capacity \c size=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct buffer a=
lloc_buf_gc(size_t size, struct gc_arena *gc);</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Duplicate a buffer, including its content=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Allocates a new buffer with th=
e same capacity as \c buf and copies its</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * content=2E  Calls \c out_of_memory() if the allocat=
ion fails=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buff=
er to duplicate=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return A newly=
 allocated copy of \c buf=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span> struct buffer clone_buf(const struct buffer *=
buf);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Allocate =
memory and, optionally, zero it=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 The allocation is registered with \c a so that it is freed when</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * \c gc_free() is called on t=
he arena=2E  Calls \c out_of_memory() if the</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * allocation fails=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param size  Number of bytes to allocate=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param clear If true, zeroise the =
allocated memory before returning=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param a     Garbage collection arena to register the a=
llocation with=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return Pointer =
to the newly allocated memory=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ */</span><br><span> void *gc_malloc(size_t size, bool clear, =
struct gc_arena *a);</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Duplicate a string, allocating memory under garbage collection=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param str   The string to duplicate=
=2E  May be NULL, in which case NULL</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *              is returned=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param gc    Garbage collection arena for th=
e returned string, or NULL</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *              to use plain \c malloc()=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @return A newly allocated copy of \c str, or NULL if \c st=
r is NULL=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span> char *string_alloc(const char *str, struct gc_arena *gc);</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Allocate a buffer =
containing a copy of the given string=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Wraps \c string_alloc(), so \c gc may be NULL (plain \c malloc() is =
used</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * in that case=
)=2E  The buffer \c len reflects the string length, excluding</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * the null terminator, even thou=
gh the terminator is present in the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * allocated memory=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param str   The string to copy into the buffer=2E  Must not be NULL=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param gc    =
Garbage collection arena for the allocation, or NULL=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @return A buffer whose content is a copy of \c str=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
> struct buffer string_alloc_buf(const char *str, struct gc_arena *gc);</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Register an addres=
s with a custom free function in a garbage collection</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * arena=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * When \c gc_free() is called on \c a, \c free_function(addr) wil=
l be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * invoked to r=
elease the memory=2E  Use this for allocations that require</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * something other than plain \c fr=
ee(), such as \c freeaddrinfo()=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param addr          Pointer to the memory to register=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param free_function Function to =
call to free \c addr=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param a             Garbage collection arena to register with=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> v=
oid gc_addspecial(void *addr, void (*free_function)(void *), struct gc_aren=
a *a);</span><br><span> </span><br><span> /**</span><br><span>@@ -177,6 +34=
9,7 @@</span><br><span> </span><br><span> #ifdef BUF_INIT_TRACKING</span><b=
r><span> #define buf_init(buf, offset) buf_init_debug(buf, offset, __FILE__=
, __LINE__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Debu=
g variant of \c buf_init_dowork() that records the call site for alignment =
verification=2E */</span><br><span> bool buf_init_debug(struct buffer *buf,=
 int offset, const char *file, int line);</span><br><span> </span><br><span=
> #else</span><br><span>@@ -185,31 +358,62 @@</span><br><span> </span><br><=
span> </span><br><span> /* inline functions */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Callb=
ack to free a \c struct \c addrinfo, suitable for use with</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * \c gc_addspecial()=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param addr  Pointer to the \c struct \c addr=
info to free=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span> static inline void</span><br><span> gc_freeaddrinfo_callba=
ck(void *addr)</span><br><span> {</span><br><span>     freeaddrinfo((struct=
 addrinfo *)addr);</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-/** Return an empty struct buffer */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Return an empty, und=
efined \c struct \c buffer (all fields zero)=2E */</span><br><span> static =
inline struct buffer</span><br><span> clear_buf(void)</span><br><span> {</s=
pan><br><span>     return (struct buffer){ 0 };</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return true iff \c buf =
has a non-NULL data pointer=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * A d=
efined buffer has been allocated but may have zero length or negative</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * len (i=2Ee=2E it is no=
t necessarily valid)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf=
   The buffer to test=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ */</span><br><span> static inline bool</span><br><span> buf_defined(c=
onst struct buffer *buf)</span><br><span> {</span><br><span>     return buf=
-&gt;data !=3D NULL;</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Return true iff \c buf is valid=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * A buffer is valid when its data pointer is non-NU=
LL and its \c len is</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * non-negative=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   T=
he buffer to test=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ */</span><br><span> static inline bool</span><br><span> buf_valid(const s=
truct buffer *buf)</span><br><span> {</span><br><span>     return likely(bu=
f-&gt;data !=3D NULL) &amp;&amp; likely(buf-&gt;len &gt;=3D 0);</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return =
a pointer to the start of the buffer content=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param buf   The buffer to query=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @return Pointer to \c buf-&gt;data + \c buf-&gt;offset, or =
NULL if \c buf is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
         not valid=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span> static inline uint8_t *</span><br><span> buf_bptr(co=
nst struct buffer *buf)</span><br><span> {</span><br><span>@@ -223,6 +427,1=
3 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Return the length of the buffer content=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer to query=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @return \c buf-&gt;len if \c b=
uf is valid, otherwise 0=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ */</span><br><span> static int</span><br><span> buf_len(const stru=
ct buffer *buf)</span><br><span> {</span><br><span>@@ -236,12 +447,27 @@</s=
pan><br><span>     }</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Return a pointer one past the end of the buffer co=
ntent=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer t=
o query=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return Pointer to the =
byte immediately after the last content byte=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span> static inline uint8_t *</s=
pan><br><span> buf_bend(const struct buffer *buf)</span><br><span> {</span>=
<br><span>     return buf_bptr(buf) + buf_len(buf);</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return a pointer to=
 the last byte of the buffer content=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param buf   The buffer to query=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @return Pointer to the last byte, or NULL if the buffer is empty or=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         invalid=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan> static inline uint8_t *</span><br><span> buf_blast(const struct buffer=
 *buf)</span><br><span> {</span><br><span>@@ -255,24 +481,56 @@</span><br><=
span>     }</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * Return true iff \c size is within the allowed buffer size r=
ange=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param size  The size to c=
heck=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true if \c size &l=
t; \c BUF_SIZE_MAX=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span> static inline bool</span><br><span> buf_size_valid(c=
onst size_t size)</span><br><span> {</span><br><span>     return likely(siz=
e &lt; BUF_SIZE_MAX);</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Return true iff a signed \c size is within the al=
lowed buffer size range=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Accepts=
 negative values (used for bidirectional length adjustments) as</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * long as the absolute value i=
s below \c BUF_SIZE_MAX=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
size  The signed size to check=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@return true if \c -BUF_SIZE_MAX &lt;=3D size &lt; \c BUF_SIZE_MAX=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> stat=
ic inline bool</span><br><span> buf_size_valid_signed(const int size)</span=
><br><span> {</span><br><span>     return likely(size &gt;=3D -BUF_SIZE_MAX=
) &amp;&amp; likely(size &lt; BUF_SIZE_MAX);</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * Return the buffer content =
pointer cast to \c char *=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m buf   The buffer to query=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @re=
turn The content pointer as a \c char *, or NULL if \c buf is invalid=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> s=
tatic inline char *</span><br><span> buf_str(const struct buffer *buf)</spa=
n><br><span> {</span><br><span>     return (char *)buf_bptr(buf);</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Reset=
 a buffer to an undefined (unallocated) state=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Sets all fields to zero/NULL without freeing any memory=2E  =
Use \c free_buf()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 first if the buffer owns allocated memory=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param buf   The buffer to reset=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span> static inline void</span><=
br><span> buf_reset(struct buffer *buf)</span><br><span> {</span><br><span>=
@@ -282,6 +540,14 @@</span><br><span>     buf-&gt;data =3D NULL;</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Reset =
the length and offset of a buffer to zero=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * The underlying allocation is preserved and \c capacity is unchan=
ged=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Equivalent=
 to rewinding the buffer to the beginning for fresh writing=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param buf   The buffer to reset=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static in=
line void</span><br><span> buf_reset_len(struct buffer *buf)</span><br><spa=
n> {</span><br><span>@@ -289,6 +555,18 @@</span><br><span>     buf-&gt;offs=
et =3D 0;</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Initialise a buffer with a given initial offset=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Sets \c buf-&gt;len to zero and \c buf-&gt;o=
ffset to \c offset=2E  The buffer must</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * already be allocated=2E  Returns false (without modif=
ying \c buf) if \c offset</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * is negative, exceeds the buffer capacity, or the data pointer is N=
ULL=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf     The buffer t=
o initialise=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param offset  Initial byte offset from the start of the allocated memory=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, false if=
 the parameters are invalid=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span> static inline bool</span><br><span> buf_ini=
t_dowork(struct buffer *buf, int offset)</span><br><span> {</span><br><span=
>@@ -301,6 +579,17 @@</span><br><span>     return true;</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Initialise a bu=
ffer with an externally provided writable memory region=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Sets up \c buf to use \c data as its backing store=
 for writing=2E  The first</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * byte of \c data is set to zero=2E  Calls \c buf_size_error() (whi=
ch does not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * retur=
n) if \c size exceeds \c BUF_SIZE_MAX=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param buf   The buffer to initialise=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param data  Pointer to the memory region to=
 use=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param si=
ze  Size of the memory region in bytes=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span> static inline void</span><br><sp=
an> buf_set_write(struct buffer *buf, uint8_t *data, int size)</span><br><s=
pan> {</span><br><span>@@ -318,6 +607,18 @@</span><br><span>     }</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Init=
ialise a buffer with an externally provided read-only memory region=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Sets up \c buf so that the entire \c d=
ata region is the buffer content</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * (offset is 0, len and capacity are both set to \c size)=2E =
 The data pointer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 is cast away from const=2E  Calls \c buf_size_error() (which does not retu=
rn)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * if \c size ex=
ceeds \c BUF_SIZE_MAX=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param bu=
f   The buffer to initialise=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param data  Pointer to the read-only memory region=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param size  Size of t=
he memory region in bytes=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span> static inline void</span><br><span> buf_set_r=
ead(struct buffer *buf, const uint8_t *data, size_t size)</span><br><span> =
{</span><br><span>@@ -330,7 +631,17 @@</span><br><span>     buf-&gt;data =
=3D (uint8_t *)data;</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-/* Like strncpy but makes sure dest is =
always null terminated */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Like \c=
 strncpy() but always null-terminates the destination=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Copies at most \c maxlen - 1 characters from \c src =
into \c dest and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
writes a null terminator at \c dest[\c maxlen - 1]=2E  Does nothing if</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * \c maxlen is zero=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param dest    Destination buffer=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param src   =
  Source string=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param maxlen  Size of the destination buffer in bytes=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inline =
void</span><br><span> strncpynt(char *dest, const char *src, size_t maxlen)=
</span><br><span> {</span><br><span>@@ -341,7 +652,13 @@</span><br><span>  =
   }</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-/* return true if string contains at least one numerica=
l digit */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return true if the str=
ing contains at least one decimal digit=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param src   The null-terminated string to scan=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @return true if any character in \c src satisfies=
 \c isdigit()=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */=
</span><br><span> static inline bool</span><br><span> has_digit(const char =
*src)</span><br><span> {</span><br><span>@@ -401,11 +718,20 @@</span><br><s=
pan> #endif</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * printf append to a buffer with overflow check,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * due to usage of vsnprintf, it will l=
eave space for</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * a fi=
nal null character and thus use only</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * capacity - 1</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * pr=
intf-style append to a buffer with overflow check=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * Formats a string and appends it to \c buf=2E  Due to th=
e use of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * \c vsnpr=
intf(), one byte of forward capacity is reserved for a null</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * terminator, so at most \c buf_fo=
rward_capacity(buf) - 1 bytes of</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * formatted output are written=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param buf     The buffer to append to=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param format  printf-style format s=
tring=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
=2E=2E=2E     Format arguments=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@return true if the entire formatted string fit in the buffer, false if</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         it was trunc=
ated=2E</span><br><span>  */</span><br><span> bool buf_printf(struct buffer=
 *buf, const char *format, =2E=2E=2E)</span><br><span> #ifdef __GNUC__</spa=
n><br><span>@@ -417,8 +743,13 @@</span><br><span> #endif</span><br><span>  =
   ;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * puts append to =
a buffer with overflow check</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Appe=
nd a string to a buffer with overflow check=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param buf   The buffer to append to=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param str   The null-terminated strin=
g to append=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true if the=
 string fit in the buffer, false if it was truncated=2E</span><br><span>  *=
/</span><br><span> bool buf_puts(struct buffer *buf, const char *str);</spa=
n><br><span> </span><br><span>@@ -427,24 +758,78 @@</span><br><span>  * rem=
ove/add trailing characters</span><br><span>  */</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * Force a null terminator at the end of the=
 buffer content=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If there is fre=
e capacity, a &#39;\\0&#39; byte is appended=2E  If the buffer is</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * full, the last content byt=
e is overwritten with &#39;\\0&#39; (i=2Ee=2E the last</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * character is truncated to make room)=
=2E  The function has no effect on an</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * empty or invalid buffer=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param buf   The buffer to null-terminate=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> void buf_null_t=
erminate(struct buffer *buf);</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Remove trailing newline and carriage-return characters from =
a buffer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffe=
r to chomp=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span> void buf_chomp(struct buffer *buf);</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Remove all occurrences of a specific b=
yte from the end of a buffer=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram buf     The buffer to modify=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param remove  The byte value to strip from the tail=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
> void buf_rmtail(struct buffer *buf, uint8_t remove);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * non-buffer string functions</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/** @name String Utility Functio=
ns</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  @brief Non-bu=
ffer string functions</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**@{*/</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Remove trailing newline and carriage-return characters fro=
m a string=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param str   The nul=
l-terminated string to chomp=2E</span><br><span>  */</span><br><span> void =
chomp(char *str);</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * Remove all trailing characters that appear in a given set=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param str             The null-terminated st=
ring to modify in place=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param what_to_delete  Null-terminated set of characters to strip=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan> void rm_trailing_chars(char *str, const char *what_to_delete);</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return a pointer past =
any leading whitespace in a string=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param str   The string to skip whitespace in=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return Pointer to the first non-whitespace character, =
or to the null</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
      terminator if \c str is all whitespace=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span> const char *skip_leading_w=
hitespace(const char *str);</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * Null-terminate a fixed-length string buffer=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Ensures that \c str[\c len] is &#39;\\0&#39;, cla=
mping \c len to \c capacity - 1</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * if necessary=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram str       The character buffer to null-terminate=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param len       Current string leng=
th=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param capa=
city  Total size of the character buffer in bytes=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> #ifdef _WIN32</span>=
<br><span> void string_null_terminate(char *str, int len, int capacity);</s=
pan><br><span> #endif</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/**@}*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* End of =
string utility functions */</span><br><span> </span><br><span> /**</span><b=
r><span>  * Write buffer contents to file=2E</span><br><span>@@ -456,40 +84=
1,114 @@</span><br><span>  */</span><br><span> bool buffer_write_file(const=
 char *filename, const struct buffer *buf);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * write a string to the end of a buffer that was</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * truncated by buf_printf=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * Append a string to the physical =
end of a buffer that was truncated by</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * \c buf_printf()=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * If the buffer&#39;s forward capacity is one byte or less (i=2Ee=2E it=
 is full),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * \c str=
 is written at the very end of the allocated memory to act as a</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * truncation marker, provided =
it fits within the total buffer capacity=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * This is used to append a &quot;[more=2E=2E=2E]&q=
uot; suffix after hex-dump truncation=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param buf   The buffer to append the truncation marker to=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param str   The null-t=
erminated marker string to write=2E</span><br><span>  */</span><br><span> v=
oid buf_catrunc(struct buffer *buf, const char *str);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * Parse a string based on a given delimite=
r char</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * Extract the next token fro=
m a buffer, delimited by a given character=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Reads bytes from \c buf one at a time until \c delim or end-of-=
buffer is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * encount=
ered=2E  The token (without the delimiter) is written into \c line,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * which is always null-ter=
minated=2E  The delimiter byte is consumed from</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * \c buf but not included in \c line=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param buf    Source buffer to parse=
=2E  The consumed portion is advanced=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param delim  Delimiter character=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param line   Output buffer for=
 the extracted token=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param size   Size of \c line in bytes (must be &gt; 0)=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @return false only when end-of-buffer is re=
ached and no characters were</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *         extracted; true otherwise (including when a delimiter w=
as found</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         =
or \c line was truncated)=2E</span><br><span>  */</span><br><span> bool buf=
_parse(struct buffer *buf, const int delim, char *line, const int size);</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * Hex dump -- Output a b=
inary buffer to a hex string and return it=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/** @name Hex Dump</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  @brief Output a binary buffer to a hex string =
and return it=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define FHE_SPACE_BREAK_MASK 0xFF  /* space_break parameter=
 in lower 8 bits */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#d=
efine FHE_CAPS             0x100 /* output hex in caps */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/**@{*/</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/** Mask for the space_break_flags field of \c format_hex_ex(): numb=
er of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  bytes betw=
een separators (lower 8 bits)=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define FHE_SPACE_BREAK_MASK 0xFF</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/** Flag for \c format_hex_ex(): output hex d=
igits in upper case=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define FHE_CAPS             0x100</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Format a binary buffer as a hex string=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param data              Pointer to the binary data to form=
at=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param size=
              Number of bytes to format=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param maxoutput         Maximum number of output=
 characters (0 =3D unlimited)=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *                          If the output is truncated, a &quo=
t;[more=2E=2E=2E]&quot; suffix is</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *                          appended via \c buf_catrunc()=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param space_brea=
k_flags Lower 8 bits (\c FHE_SPACE_BREAK_MASK) give the</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *                          number of b=
ytes between \c separator insertions=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *                          Use \c FHE_CAPS to output u=
pper-case hex digits=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param separator         String to insert between groups of bytes=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param gc       =
         Garbage collection arena for the returned string=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @return Null-terminated hex string allocated fro=
m \c gc=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span> char *format_hex_ex(const uint8_t *data, size_t size, size_t ma=
xoutput, unsigned int space_break_flags,</span><br><span>                  =
   const char *separator, struct gc_arena *gc);</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Format a binary buffer as a hex string wit=
h spaces every 4 bytes=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Convenie=
nce wrapper around \c format_hex_ex()=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param data       Pointer to the binary data to format=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param size       Number of=
 bytes to format=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param maxoutput  Maximum number of output characters (0 =3D unlimited)=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param gc    =
     Garbage collection arena for the returned string=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @return Null-terminated hex string allocated from \c=
 gc=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span> static inline char *</span><br><span> format_hex(const uint8_t *dat=
a, size_t size, size_t maxoutput, struct gc_arena *gc)</span><br><span> {</=
span><br><span>     return format_hex_ex(data, size, maxoutput, 4, &quot; &=
quot;, gc);</span><br><span> }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/**@}*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* End of Hex Dump */</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 Return a buffer that is a subset of another buffer=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Return a sub-buffer of another buffer=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Either allocates \c size bytes from the front =
or back of \c buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* shrinking \c buf accordingly, and returns a buffer pointing into the</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * same memory=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param buf      Source buffer to carve=
 the sub-buffer from=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param size     Number of bytes to include in the sub-buffer=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param prepend  If tr=
ue, take bytes from the front of \c buf (prepend</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *                 space); if false, take byte=
s from the end (append space)=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
return A buffer referencing the allocated region, or an undefined buffer</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         if \c buf h=
as insufficient capacity=2E</span><br><span>  */</span><br><span> struct bu=
ffer buf_sub(struct buffer *buf, int size, bool prepend);</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * Check if sufficient space to append t=
o buffer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Check whether \c len =
bytes can be appended to a buffer=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param buf   The buffer to check=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param len   Number of bytes to append=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @return true if \c buf is valid, \c len is wi=
thin the allowed range, and</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *         there is sufficient capacity after the current content=
=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span> static inline bool</span><br><span> buf_safe(const str=
uct buffer *buf, size_t len)</span><br><span> {</span><br><span>@@ -497,6 +=
956,18 @@</span><br><span>            &amp;&amp; buf-&gt;offset + buf-&gt;l=
en + (int)len &lt;=3D buf-&gt;capacity;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Check whether \c len bytes can =
be added to or removed from a buffer=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Accepts negative \c len to verify that bytes can be removed (length</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * decreased)=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer to check=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param len   Number=
 of bytes to add (positive) or remove (negative)=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return true if the resulting length would remain non-n=
egative and within</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*         the allocated capacity=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span> static inline bool</span><br><span> bu=
f_safe_bidir(const struct buffer *buf, int len)</span><br><span> {</span><b=
r><span>@@ -511,6 +982,17 @@</span><br><span>     }</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return the number o=
f bytes that can still be appended to the buffer=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * This is the space between the end of the current conten=
t and the end of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
the allocated memory=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf=
   The buffer to query=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return =
Number of bytes available for appending, or 0 if \c buf is</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *         invalid=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inline=
 int</span><br><span> buf_forward_capacity(const struct buffer *buf)</span>=
<br><span> {</span><br><span>@@ -529,6 +1011,17 @@</span><br><span>     }</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * Return the total number of bytes available from the current offset to th=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * end of the allo=
cated memory=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Unlike \c buf_forw=
ard_capacity(), this includes the bytes already occupied</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * by the current content=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param buf   The buffer to query=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @return Capacity minus offset, or 0 if \c=
 buf is invalid=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span> static inline int</span><br><span> buf_forward_capacity=
_total(const struct buffer *buf)</span><br><span> {</span><br><span>@@ -547=
,6 +1040,16 @@</span><br><span>     }</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Return the number of bytes availa=
ble for prepending to the buffer=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* This is the number of bytes between the start of the allocated memory and=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the current cont=
ent start (i=2Ee=2E \c buf-&gt;offset)=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param buf   The buffer to query=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @return \c buf-&gt;offset, or 0 if \c buf is invalid=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static i=
nline int</span><br><span> buf_reverse_capacity(const struct buffer *buf)</=
span><br><span> {</span><br><span>@@ -560,6 +1063,17 @@</span><br><span>   =
  }</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Increase or decrease the length of a buffer=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Adjusts \c buf-&gt;len by \c inc bytes=2E  A negative =
\c inc shrinks the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* buffer=2E  The operation is bounds-checked via \c buf_safe_bidir()=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer to modify=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param inc   Numb=
er of bytes to add to the length (may be negative)=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return true on success, false if the adjustment would =
violate bounds=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
/</span><br><span> static inline bool</span><br><span> buf_inc_len(struct b=
uffer *buf, int inc)</span><br><span> {</span><br><span>@@ -571,11 +1085,18=
 @@</span><br><span>     return true;</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * Make space to prepend to a buffer=2E</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Return NULL if no sp=
ace=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * Make space at the front of=
 a buffer for prepending data=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * M=
oves the content start backwards by \c size bytes, increasing \c len</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * and decreasing \c offse=
t by the same amount=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf=
   The buffer to modify=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param size  Number of bytes to reserve for prepending=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @return Pointer to the newly reserved spa=
ce (new content start), or NULL</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *         if \c buf is invalid or there is insufficient prepen=
d capacity=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span> static inline uint8_t *</span><br><span> buf=
_prepend(struct buffer *buf, ssize_t size)</span><br><span> {</span><br><sp=
an>@@ -588,6 +1109,17 @@</span><br><span>     return BPTR(buf);</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Advance=
 the content start of a buffer, consuming bytes from the front=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Increases \c offset and decreases \c len by=
 \c size bytes=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The=
 buffer to advance=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param size  Number of bytes to skip=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @return true on success, false if \c buf is invalid or \c size e=
xceeds</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         th=
e current length=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span> static inline bool</span><br><span> buf_advance(struct=
 buffer *buf, ssize_t size)</span><br><span> {</span><br><span>@@ -600,11 +=
1132,18 @@</span><br><span>     return true;</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * Return a pointer to allocated s=
pace inside a buffer=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * Return NULL if no space=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * R=
eserve space at the end of a buffer for writing=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Increases \c buf-&gt;len by \c size and returns a pointer =
to the start of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * t=
he newly reserved region=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 buf   The buffer to allocate space in=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param size  Number of bytes to reserve=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @return Pointer to the start of the reser=
ved space, or NULL if there is</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *         insufficient capacity=2E</span><br><span>  */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static inli=
ne uint8_t *</span><br><span> buf_write_alloc(struct buffer *buf, size_t si=
ze)</span><br><span> {</span><br><span>@@ -618,6 +1157,18 @@</span><br><spa=
n>     return ret;</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Consume bytes from the front of a buffer for reading=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Returns a pointer to the curre=
nt content start and advances the buffer</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * by \c size bytes=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param buf   The buffer to read from=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param size  Number of bytes to consume=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @return Pointer to the start of t=
he consumed region, or NULL if \c size</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *         is negative or exceeds the current length=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span>=
 static inline uint8_t *</span><br><span> buf_read_alloc(struct buffer *buf=
, int size)</span><br><span> {</span><br><span>@@ -632,6 +1183,17 @@</span>=
<br><span>     return ret;</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Append data to a buffer=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Copies \c size bytes from \c src to the end of \c d=
est=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param dest  Destination bu=
ffer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param sr=
c   Data to append=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param size  Number of bytes to append=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @return true on success, false if there is insufficient capaci=
ty=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span> static inline bool</span><br><span> buf_write(struct buffer *dest, c=
onst void *src, size_t size)</span><br><span> {</span><br><span>@@ -644,6 +=
1206,18 @@</span><br><span>     return true;</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * Prepend data to a buffer=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Copies \c size bytes from \c s=
rc into the prepend space at the front of</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * \c dest=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param dest  Destination buffer=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param src   Data to prepend=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param size  Number of bytes to prepen=
d=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, fals=
e if there is insufficient prepend capacity=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span> static inline bool</span><b=
r><span> buf_write_prepend(struct buffer *dest, const void *src, int size)<=
/span><br><span> {</span><br><span>@@ -656,12 +1230,28 @@</span><br><span> =
    return true;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Append a uint8_t to a buffer=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param dest  Destination buffer=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param data  Byte to append=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, false if ther=
e is insufficient capacity=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span> static inline bool</span><br><span> buf_writ=
e_u8(struct buffer *dest, uint8_t data)</span><br><span> {</span><br><span>=
     return buf_write(dest, &amp;data, sizeof(uint8_t));</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Append a uint1=
6_t to a buffer in network byte order=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param dest  Destination buffer=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param data  Value to append (converted with \c ht=
ons())=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true on success,=
 false if there is insufficient capacity=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ */</span><br><span> static inline bool</span><br><=
span> buf_write_u16(struct buffer *dest, uint16_t data)</span><br><span> {<=
/span><br><span>@@ -669,6 +1259,14 @@</span><br><span>     return buf_write=
(dest, &amp;u16, sizeof(uint16_t));</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Append a uint32_t to a buffer in ne=
twork byte order=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dest  D=
estination buffer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param data  Value to append (converted with \c htonl())=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @return true on success, false if there is in=
sufficient capacity=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ */</span><br><span> static inline bool</span><br><span> buf_write_u32(s=
truct buffer *dest, uint32_t data)</span><br><span> {</span><br><span>@@ -6=
76,6 +1274,14 @@</span><br><span>     return buf_write(dest, &amp;u32, size=
of(uint32_t));</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Append a uint64_t to a buffer in network byte order=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param dest  Destination buffer=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param data  =
Value to append (converted with \c htonll())=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @return true on success, false if there is insufficient capac=
ity=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span> static inline bool</span><br><span> buf_write_u64(struct buffer *de=
st, uint64_t data)</span><br><span> {</span><br><span>@@ -683,12 +1289,32 @=
@</span><br><span>     return buf_write(dest, &amp;u64, sizeof(uint64_t));<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Copy the content of one buffer to the end of another=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param dest  Destination buffer=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param src   Source buffer=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, false if \=
c dest has insufficient capacity=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span> static inline bool</span><br><span> bu=
f_copy(struct buffer *dest, const struct buffer *src)</span><br><span> {</s=
pan><br><span>     return buf_write(dest, BPTR(src), BLENZ(src));</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read =
\c n bytes from \c src and append them to \c dest=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * Consumes the bytes from \c src=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param dest  Destination buffer=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param src   Source buffer (modified)=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param n     =
Number of bytes to copy=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return=
 true on success, false if \c src has fewer than \c n bytes or</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *         \c dest has insuffici=
ent capacity=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span> static inline bool</span><br><span> buf_copy_n(struct buff=
er *dest, struct buffer *src, int n)</span><br><span> {</span><br><span>@@ =
-700,6 +1326,22 @@</span><br><span>     return buf_write(dest, cp, n);</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
Copy a range of bytes from one buffer into a specific position in another=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Copies \c src_len bytes starti=
ng at \c src_index within \c src content</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * into \c dest at \c dest_index relative to the conte=
nt start=2E  Updates</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * \c dest-&gt;len if the write extends beyond the current content=2E  Doe=
s not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * advance eit=
her buffer&#39;s offset=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
dest        Destination buffer=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param dest_index  Byte offset within \c dest content to w=
rite at=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 src         Source buffer=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param src_index   Byte offset within \c src content to read f=
rom=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param src=
_len     Number of bytes to copy=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @return true on success, false if any index or length is out of range=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span>=
 static inline bool</span><br><span> buf_copy_range(struct buffer *dest, in=
t dest_index, const struct buffer *src, int src_index,</span><br><span>    =
            int src_len)</span><br><span>@@ -717,7 +1359,19 @@</span><br><s=
pan>     return true;</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-/* truncate src to len, copy excess da=
ta beyond len to dest */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Truncate=
 \c src to \c len bytes and copy any excess to \c dest=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * If \c src-&gt;len &gt; \c len, \c src is truncated =
to \c len bytes and the</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * remaining bytes are appended to \c dest=2E  If \c src-&gt;len &lt;=
=3D \c len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * nothi=
ng is copied and true is returned=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param dest  Destination buffer for the excess data=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param src   Source buffer to trun=
cate=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param le=
n   Maximum number of bytes to keep in \c src=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @return true on success, false if \c len is negative or copy=
ing fails=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span> static inline bool</span><br><span> buf_copy_excess(struct bu=
ffer *dest, struct buffer *src, int len)</span><br><span> {</span><br><span=
>@@ -741,6 +1395,17 @@</span><br><span>     }</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * Read bytes from the front=
 of a buffer into a caller-supplied destination=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Consumes \c size bytes from \c src and copies them to \c d=
est=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param src   Source buffer =
(modified)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram dest  Destination memory=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param size  Number of bytes to read=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @return true on success, false if \c src has fewer tha=
n \c size bytes=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span> static inline bool</span><br><span> buf_read(struct buf=
fer *src, void *dest, int size)</span><br><span> {</span><br><span>@@ -753,=
6 +1418,14 @@</span><br><span>     return true;</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return the first byte o=
f the buffer without consuming it=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param buf   The buffer to peek at=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @return The first byte as an unsigned value (0=E2=80=93255), or -1 i=
f the buffer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
    is empty=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span> static inline int</span><br><span> buf_peek_u8(struct buff=
er *buf)</span><br><span> {</span><br><span>@@ -765,6 +1438,13 @@</span><br=
><span>     return ret;</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * Read and consume a uint8_t from the front of a =
buffer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer =
to read from=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return The byte v=
alue (0=E2=80=93255), or -1 if the buffer is empty=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inline int</s=
pan><br><span> buf_read_u8(struct buffer *buf)</span><br><span> {</span><br=
><span>@@ -776,6 +1456,16 @@</span><br><span>     return ret;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read and =
consume a uint16_t from the front of a buffer=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * The value is converted from network byte order via \c ntohs(=
)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer to re=
ad from=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return The host-byte-o=
rder value, or -1 if the buffer has fewer than 2</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *         bytes=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span> static inline int</span><=
br><span> buf_read_u16(struct buffer *buf)</span><br><span> {</span><br><sp=
an>@@ -787,6 +1477,17 @@</span><br><span>     return ntohs(ret);</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read a=
nd consume a uint32_t from the front of a buffer=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * The value is converted from network byte order via \c n=
tohl()=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer =
to read from=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param good  If non-NULL, set to true on success or false on failure=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return The host-byte-order value, or =
0 if the buffer has fewer than 4</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *         bytes (check \c *good to distinguish from a legitim=
ate zero)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span> static inline uint32_t</span><br><span> buf_read_u32(struct b=
uffer *buf, bool *good)</span><br><span> {</span><br><span>@@ -809,8 +1510,=
17 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-/* Read a 64-bit big-endian val=
ue (see buf_write_u64())=2E Sets *good to indicate</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * success, like buf_read_u32()=2E */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * Read and consume a uint64_t from the fron=
t of a buffer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The value is conv=
erted from network byte order via \c ntohll()=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param buf   The buffer to read from=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param good  If non-NULL, set to true=
 on success or false on failure=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @return The host-byte-order value, or 0 if the buffer has fewer than 8</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         bytes (check=
 \c *good to distinguish from a legitimate zero)=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inline uint64=
_t</span><br><span> buf_read_u64(struct buffer *buf, bool *good)</span><br>=
<span> {</span><br><span>@@ -868,31 +1578,73 @@</span><br><span>     return=
 memcmp(BPTR(src), match, size) =3D=3D 0;</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Return true if the head of \c=
 src matches the string \c match=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Compares the first \c strlen(match) bytes of \c src content with \c match=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * *NOT* constan=
t time=2E Do not use when comparing HMACs=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param src    Buffer whose head is compared=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param match  Null-terminated stri=
ng to compare against=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return t=
rue if the buffer starts with \c match=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span> bool buf_string_match_head_str(c=
onst struct buffer *src, const char *match);</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * Compare the head of \c src with \c match and =
advance past it if equal=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If the=
 buffer starts with \c match, the matched bytes are consumed from</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * \c src=2E  *NOT* constant =
time=2E Do not use when comparing HMACs=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param src    Buffer to compare and advance=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param match  Null-terminated string=
 to compare against=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return tru=
e if the buffer started with \c match (and was advanced)=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> bool buf_strin=
g_compare_advance(struct buffer *src, const char *match);</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * Return the length of the next to=
ken in a buffer up to a delimiter=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * Scans the buffer content for \c delim and returns the number of bytes</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * up to (but not incl=
uding) the delimiter, or the full buffer length if</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * the delimiter is not found=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param buf    The buffer to scan=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param delim  Delimiter by=
te to search for=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return Number=
 of bytes before the first occurrence of \c delim, or -1</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *         if the buffer is empty=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> =
int buf_substring_len(const struct buffer *buf, int delim);</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * Print a string which might be NULL<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Return a printable representation=
 of a string that might be NULL=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param str   String to print, or NULL=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @return \c str if non-NULL, otherwise the string \c &quot;[NULL]&qu=
ot;=2E</span><br><span>  */</span><br><span> const char *np(const char *str=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/=
* character classes */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** @name Characte=
r classes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  @brief=
 Check or modify strings based on classes of allowed</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *         or forbidden characters=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/**@{*/</span><br><span> #define CC_ANY=
  (1 &lt;&lt; 0)           /**&lt; any character */</span><br><span> #defin=
e CC_NULL (1 &lt;&lt; 1)           /**&lt; null character \0 */</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_ALNU=
M  (1 &lt;&lt; 2)         /**&lt; alphanumeric isalnum() */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define CC_ALPHA  (1 &lt;&lt; 3)     =
    /**&lt; alphabetic isalpha() */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define CC_ALNUM  (1 &lt;&lt; 2)         /**&lt; alphanumer=
ic \c isalnum() */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define CC_ALPHA  (1 &lt;&lt; 3)         /**&lt; alphabetic \c isalpha() */<=
/span><br><span> #define CC_ASCII  (1 &lt;&lt; 4)         /**&lt; ASCII cha=
racter */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_C=
NTRL  (1 &lt;&lt; 5)         /**&lt; control character iscntrl() */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_DIGIT  (1 &lt;&lt;=
 6)         /**&lt; digit isdigit() */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define CC_CNTRL  (1 &lt;&lt; 5)         /**&lt; control=
 character \c iscntrl() */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define CC_DIGIT  (1 &lt;&lt; 6)         /**&lt; digit \c isdigit() =
*/</span><br><span> #define CC_PRINT  (1 &lt;&lt; 7)         /**&lt; printa=
ble (&gt;=3D 32, !=3D 127) */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define CC_PUNCT  (1 &lt;&lt; 8)         /**&lt; punctuation ispunc=
t() */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_SPAC=
E  (1 &lt;&lt; 9)         /**&lt; whitespace isspace() */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#define CC_XDIGIT (1 &lt;&lt; 10)      =
  /**&lt; hex digit isxdigit() */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define CC_PUNCT  (1 &lt;&lt; 8)         /**&lt; punctuation =
\c ispunct() */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine CC_SPACE  (1 &lt;&lt; 9)         /**&lt; whitespace \c isspace() */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CC_XDIGIT (1 &l=
t;&lt; 10)        /**&lt; hex digit \c isxdigit() */</span><br><span> </spa=
n><br><span> #define CC_BLANK   (1 &lt;&lt; 11)       /**&lt; space or tab =
*/</span><br><span> #define CC_NEWLINE (1 &lt;&lt; 12)       /**&lt; newlin=
e */</span><br><span>@@ -920,8 +1672,27 @@</span><br><span> #define CC_NAME=
 (CC_ALNUM | CC_UNDERBAR) /**&lt; alphanumeric plus underscore */</span><br=
><span> #define CC_CRLF (CC_CR | CC_NEWLINE)     /**&lt; carriage return or=
 newline */</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Tes=
t whether a character belongs to one or more character classes=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param c      The character to test=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param flags  Bitmask=
 of \c CC_* character class flags=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @return true if \c c matches any of the classes specified in \c flags=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
> bool char_class(const unsigned char c, const unsigned int flags);</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Test whether all chara=
cters in a string satisfy a character class filter=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param str        The null-terminated string to test=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param inclusive=
  Classes that are permitted (characters must match at</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *                   least one of these)=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param exclus=
ive  Classes that are forbidden (characters must not match</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *                   any of these, e=
ven if they also match \c inclusive)=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @return true if every character in \c str is permitted=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> bool strin=
g_class(const char *str, const unsigned int inclusive, const unsigned int e=
xclusive);</span><br><span> </span><br><span> /**</span><br><span>@@ -968,1=
0 +1739,27 @@</span><br><span>  */</span><br><span> const char *string_mod_=
const(const char *str, const unsigned int inclusive,</span><br><span>      =
                        const unsigned int exclusive, const char replace, s=
truct gc_arena *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/**@}*/</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Replac=
e all leading occurrences of a character in a string=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Scans from the start of \c str and replaces every con=
secutive \c match</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 character with \c replace, stopping at the first character that does not</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * match=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param str      The null-terminated string =
to modify in place=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param match    The character to replace=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param replace  The replacement character=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan> void string_replace_leading(char *str, const char match, const char re=
place);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-/** Return true iff str starts with prefix */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Return true iff \c str starts with \c prefix=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param str     The string to test=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param prefix  The prefi=
x to look for=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */=
</span><br><span> static inline bool</span><br><span> strprefix(const char =
*str, const char *prefix)</span><br><span> {</span><br><span>@@ -1006,6 +17=
94,16 @@</span><br><span>  * Verify that a pointer is correctly aligned</sp=
an><br><span>  */</span><br><span> #ifdef VERIFY_ALIGNMENT</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Assert that the content pointer of \c buf is 4-by=
te aligned=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Only compiled in whe=
n \c VERIFY_ALIGNMENT is defined=2E  Called via the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * \c verify_align_4() macro=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param buf   Buffer whose content pointer i=
s to be checked=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param file  Source file of the call site (for the error message)=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param line  Source l=
ine of the call site (for the error message)=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span> void valign4(const struct =
buffer *buf, const char *file, const int line);</span><br><span> </span><br=
><span> #define verify_align_4(ptr) valign4(buf, __FILE__, __LINE__)</span>=
<br><span>@@ -1013,23 +1811,58 @@</span><br><span> #define verify_align_4(p=
tr)</span><br><span> #endif</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * Very basic garbage collection, mostly for routines that return</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * char ptrs to malloced s=
trings=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** @name =
Garbage Collection</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  @brief Basic garbage collection, mostly for routines that return</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *         char ptrs to mal=
loced strings=2E</span><br><span>  */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**@{*/</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Move all allocations from one garbage collection arena to anothe=
r=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * After the call \c src is empt=
y and all entries previously in \c src are</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * owned by \c dest=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param dest  Arena to move allocations into=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param src   Arena to move alloca=
tions from (emptied on return)=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span> void gc_transfer(struct gc_arena *dest, =
struct gc_arena *src);</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Free all plain allocations in a garbage collection arena=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * Internal implementation called by \c gc_f=
ree()=2E  Do not call directly=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param a  The arena whose \c list entries are to be freed=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> void x_gc_fre=
e(struct gc_arena *a);</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Free all specially-allocated entries in a garbage collection arena=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Internal implementation called=
 by \c gc_free()=2E  Do not call directly=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * Invokes the custom free function stored in each=
 \c gc_entry_special=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param a  =
The arena whose \c list_special entries are to be freed=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> void x_gc_frees=
pecial(struct gc_arena *a);</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * Return true iff the arena contains at least one allocation=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param a  The arena to test=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> st=
atic inline bool</span><br><span> gc_defined(struct gc_arena *a)</span><br>=
<span> {</span><br><span>     return a-&gt;list !=3D NULL;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Initialise a=
 garbage collection arena to an empty state=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param a  The arena to initialise=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span> static inline void</span=
><br><span> gc_init(struct gc_arena *a)</span><br><span> {</span><br><span>=
@@ -1037,12 +1870,25 @@</span><br><span>     a-&gt;list_special =3D NULL;</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * Detach all allocations from an arena without freeing them=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * After this call the arena is empty=2E  The ca=
ller takes responsibility for</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * freeing the previously registered allocations=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param a  The arena to detach=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inline=
 void</span><br><span> gc_detach(struct gc_arena *a)</span><br><span> {</sp=
an><br><span>     gc_init(a);</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * Allocate and return a new, empty garbage =
collection arena=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return An ini=
tialised \c gc_arena with empty lists=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span> static inline struct gc_arena</sp=
an><br><span> gc_new(void)</span><br><span> {</span><br><span>@@ -1051,6 +1=
897,14 @@</span><br><span>     return ret;</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * Free all allocations in a ga=
rbage collection arena=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Calls \c=
 x_gc_free() and \c x_gc_freespecial() as needed to release all</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * registered memory=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param a  The arena to free=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static in=
line void</span><br><span> gc_free(struct gc_arena *a)</span><br><span> {</=
span><br><span>@@ -1064,6 +1918,13 @@</span><br><span>     }</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Free all a=
llocations in a garbage collection arena and reinitialise it=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * Equivalent to calling \c gc_free() followed b=
y \c gc_init()=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param a  The ar=
ena to reset=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span> static inline void</span><br><span> gc_reset(struct gc_are=
na *a)</span><br><span> {</span><br><span>@@ -1081,58 +1942,139 @@</span><b=
r><span> /* 1 GB on 32bit systems, they usually can only allocate 2 GB for =
the</span><br><span>  * whole process=2E</span><br><span>  */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/** Maximum size for a single arr=
ay allocation (checked by \c array_mult_safe())=2E */</span><br><span> #def=
ine ALLOC_SIZE_MAX (1u &lt;&lt; 30)</span><br><span> #else</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/** Maximum size for a single array =
allocation (checked by \c array_mult_safe())=2E */</span><br><span> #define=
 ALLOC_SIZE_MAX ((size_t)1 &lt;&lt; 32) /* 4 GB */</span><br><span> #endif<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Allocate memory=
 for a single object of the given type=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Calls \c check_malloc_return() to abort on allocation failure=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param dptr  Pointer variable that r=
eceives the allocation=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param type  Type of the object to allocate=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> #define ALLOC_OBJ(=
dptr, type)                                       \</span><br><span>     { =
                                                              \</span><br><=
span>         check_malloc_return((dptr) =3D (type *)malloc(sizeof(type)));=
 \</span><br><span>     }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Allocate and zero-initialise memory for a single object of the g=
iven type=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dptr  Pointer =
variable that receives the allocation=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param type  Type of the object to allocate=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> #de=
fine ALLOC_OBJ_CLEAR(dptr, type)      \</span><br><span>     {             =
                       \</span><br><span>         ALLOC_OBJ(dptr, type);   =
        \</span><br><span>         memset((dptr), 0, sizeof(type)); \</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * Allocate memory for an array of \c n elements of the given type=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Uses \c array_mult_safe() to guard aga=
inst size overflow=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Calls \c check_malloc_return() to abort on allocation failure=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param dptr  Pointer variable that rec=
eives the allocation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param type  Element type of the array=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param n     Number of elements=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> #define=
 ALLOC_ARRAY(dptr, type, n)                                                =
           \</span><br><span>     {                                        =
                                                \</span><br><span>         =
check_malloc_return((dptr) =3D (type *)malloc(array_mult_safe(sizeof(type),=
 (n), 0))); \</span><br><span>     }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Allocate a garbage-collected array of \c n elements o=
f the given type=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dptr  P=
ointer variable that receives the allocation=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param type  Element type of the array=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param n     Number=
 of elements=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param gc    Garbage collection arena to register the allocation with=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> #d=
efine ALLOC_ARRAY_GC(dptr, type, n, gc)                                    =
           \</span><br><span>     {                                        =
                                           \</span><br><span>         (dptr=
) =3D (type *)gc_malloc(array_mult_safe(sizeof(type), (n), 0), false, (gc))=
; \</span><br><span>     }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Allocate and zero-initialise an array of \c n elements of the g=
iven type=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dptr  Pointer =
variable that receives the allocation=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param type  Element type of the array=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param n     Number of ele=
ments=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><=
br><span> #define ALLOC_ARRAY_CLEAR(dptr, type, n)                         =
   \</span><br><span>     {                                                =
               \</span><br><span>         ALLOC_ARRAY(dptr, type, n);      =
                           \</span><br><span>         memset((dptr), 0, (ar=
ray_mult_safe(sizeof(type), (n), 0))); \</span><br><span>     }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * Allocate and zero-initiali=
se a garbage-collected array of \c n elements=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param dptr  Pointer variable that receives the allocation=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param type  =
Element type of the array=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param n     Number of elements=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param gc    Garbage collection arena to regi=
ster the allocation with=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ */</span><br><span> #define ALLOC_ARRAY_CLEAR_GC(dptr, type, n, gc=
)                                        \</span><br><span>     {          =
                                                                        \</=
span><br><span>         (dptr) =3D (type *)gc_malloc(array_mult_safe(sizeof=
(type), (n), 0), true, (gc)); \</span><br><span>     }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Allocate and zero-initialise a garb=
age-collected variable-length structure=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Allocates \c sizeof(type) + \c n * \c sizeof(atype) bytes for a st=
ructure</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * that embe=
ds a variable-length array of \c atype as its last member=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param dptr   Pointer variable that receives the=
 allocation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram type   Type of the enclosing structure=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param atype  Element type of the variable-le=
ngth array member=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param n      Number of array elements=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param gc     Garbage collection arena to regi=
ster the allocation with=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ */</span><br><span> #define ALLOC_VAR_ARRAY_CLEAR_GC(dptr, type, a=
type, n, gc)                                         \</span><br><span>    =
 {                                                                         =
                     \</span><br><span>         (dptr) =3D (type *)gc_mallo=
c(array_mult_safe(sizeof(atype), (n), sizeof(type)), true, (gc)); \</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 Allocate a garbage-collected object of the given type (uninitialised)=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param dptr  Pointer variable that =
receives the allocation=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param type  Type of the object to allocate=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param gc    Garbage collection are=
na to register the allocation with=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span> #define ALLOC_OBJ_GC(dptr, type, gc)=
                           \</span><br><span>     {                        =
                                  \</span><br><span>         (dptr) =3D (ty=
pe *)gc_malloc(sizeof(type), false, (gc)); \</span><br><span>     }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Allocate and zero-init=
ialise a garbage-collected object of the given type=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param dptr  Pointer variable that receives the alloca=
tion=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ty=
pe  Type of the object to allocate=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param gc    Garbage collection arena to register the =
allocation with=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span> #define ALLOC_OBJ_CLEAR_GC(dptr, type, gc)             =
       \</span><br><span>     {                                            =
             \</span><br><span>         (dptr) =3D (type *)gc_malloc(sizeof=
(type), true, (gc)); \</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Abort if a memory allocation returned NULL=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param p  Return value from \c=
 malloc() or similar; calls \c out_of_memory()</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *           if \c p is NULL=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inline v=
oid</span><br><span> check_malloc_return(void *p)</span><br><span> {</span>=
<br><span>@@ -1141,22 +2083,28 @@</span><br><span>         out_of_memory();=
</span><br><span>     }</span><br><span> }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**@}*/</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/* End of GC */</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * Manage lists of buffers</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/** @name Buffer Lists</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  @brief Manage lists of buffers</span><br><span>  */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/**@{*/</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/** One node in a \c buffer_list linked list=2E */</span=
><br><span> struct buffer_entry</span><br><span> {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    struct buffer buf;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct buffer_entry *next;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf;         /=
**&lt; The buffer stored in this list node=2E */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct buffer_entry *next; /**&lt; Pointer=
 to the next node, or NULL=2E */</span><br><span> };</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/** A singly-linked list=
 of buffers, with head/tail pointers for O(1) push=2E */</span><br><span> s=
truct buffer_list</span><br><span> {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    struct buffer_entry *head; /* next item to pop/peek */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer_entry=
 *tail; /* last item pushed */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    size_t size;               /* current number of entries */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t max_size;     =
      /* maximum size list should grow to */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct buffer_entry *head; /**&lt; Next item t=
o pop/peek=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct buffer_entry *tail; /**&lt; Last item pushed=2E */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    size_t size;               /**&l=
t; Current number of entries=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    size_t max_size;           /**&lt; Maximum number of ent=
ries allowed=2E */</span><br><span> };</span><br><span> </span><br><span> /=
**</span><br><span>@@ -1217,8 +2165,24 @@</span><br><span>  */</span><br><s=
pan> struct buffer *buffer_list_peek(struct buffer_list *ol);</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * Advance past \c n bytes in t=
he head buffer, popping it if it becomes empty=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * \c n must not exceed the length of the head buffer; passing=
 a larger value</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * t=
riggers an assertion failure=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram ol  The list whose head buffer is to be advanced=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param n   Number of bytes to skip =
in the head buffer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span> void buffer_list_advance(struct buffer_list *ol, ssi=
ze_t n);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Remove=
 and free the head buffer of the list=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Does nothing if \c ol is NULL or empty=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param ol  The list to pop from=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span> void buffer_list_pop(str=
uct buffer_list *ol);</span><br><span> </span><br><span> /**</span><br><spa=
n>@@ -1246,6 +2210,20 @@</span><br><span>  */</span><br><span> void buffer_=
list_aggregate_separator(struct buffer_list *bl, const size_t max_len, cons=
t char *sep);</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * R=
ead a file into a buffer list, one buffer per line=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * Opens \c fn for reading and pushes each line into a new=
ly allocated buffer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * list using \c fgets()=2E  Lines longer than \c max_line_len - 1 bytes ar=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * split across mu=
ltiple consecutive buffers=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am fn            Path to the file to read=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param max_line_len  Maximum number of bytes (i=
ncluding null terminator)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *                      read per \c fgets() call=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @return Pointer to the new buffer list, or NULL if =
the file could not be</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *         opened or memory allocation failed=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span> struct buffer_list *buf=
fer_list_file(const char *fn, int max_line_len);</span><br><span> </span><b=
r><span> /**</span><br><span>@@ -1259,5 +2237,7 @@</span><br><span>  * erro=
r</span><br><span>  */</span><br><span> struct buffer buffer_read_from_file=
(const char *filename, struct gc_arena *gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/**@}*/</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/* End of Buffer Lists */</span><br><span> </span><br><span> #=
endif /* BUFFER_H */</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1581?usp=3Demail">change =
1581</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1581?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3=
50ca5b08379ede1480b81055d35dd9a33e30cff </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1581 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;=
frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--BvUf1RQHp2s=--


--===============1391433051773263624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1391433051773263624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1391433051773263624==--

