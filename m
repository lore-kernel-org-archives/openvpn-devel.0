Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F226C5AD55
	for <openvpn-devel@archiver.kernel.org>; Mon, 10 Aug 2026 11:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xtZ4Zoso+0olwQQKXhC6h+Dy/rHi+0PzVnOzu3CUefA=; b=WB1wr6vO34zIJPFRn4LgS97Y36
	bxdUAVzSAlomamEk5jG4nCVVm8I2/x/Y3m+hIVPxTumsWeBfQ03TDiYyVP5qavOxI2+rtRLCXVqVc
	iCqU9JUvbp/Av8Hl0Py1hY6KGDs5oEVtBYeLDHiLFmub8t5ppGD0909IN9/53ODfdDQM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wtOT6-0007rS-Ot;
	Mon, 10 Aug 2026 11:47:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wtOSw-0007r4-9k
 for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 11:46:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=eG7xSIKJBQlkR+Ht7ZzjAH9JD+MeuS2xuYEmxMo79vg=; b=LvFL/HbjhOaF+G0x5HacClssto
 tt7J26XrsoTdWGq4nzcO6UCQ88t9rDdTPz+meEIZ3H/3pp+3wYLI1orGEzXskI7bM9dA/j/JzjgoD
 xKGy4kuvK2uJSqsZZW9fJOWbLi5TWVzJBCrdAOT/5DkCmJu2J4FVa6ciOD8SF++BDfW8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=eG7xSIKJBQlkR+Ht7ZzjAH9JD+MeuS2xuYEmxMo79vg=; b=A
 x49AqHsBVyPsyzcPAXG9bNFzJO5hfLt3MTFTxWEk/Yuhhl9pEscglXud+Tvd/qdSeVfqrj0OPgwqr
 8q+DuObqcSZ5iFYOsRJSXUCo7x6i3Tlkml8iKsv5NnumrDjIIg79dEjShO4VsUIdjGjLbvUg7WvON
 hhw7Bq5iW0ROAQrw=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wtOSs-0000o0-QM for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 11:46:50 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4980dc26022so18193245e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 10 Aug 2026 04:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786362397; x=1786967197; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eG7xSIKJBQlkR+Ht7ZzjAH9JD+MeuS2xuYEmxMo79vg=;
 b=FONabZAJEx11vAc08WR2QmdYmJKG+pjJF5P/hC2y59VS9rq0lejoJaAAI93HxDO5Jl
 GstrOzziqxBsoM9wFww0QB82piyrewfQyTl9o6kDGe/VY2uHDaHrsFDk+8x+qGfq/fCp
 F8Te1ICM6HBhuPh43cD2kruGHeSmvSgNK3q0A2HZC30me/+CeIplY25fIARtgWyAG5oP
 fDDcxZ0gdcW7pEWpyb/g1NY2eaRqtj3hlDwssyhQY1I0x38ENe3F2bq+6UFAAlBX4R4+
 WQQTs1zjikazbNRYHGiWgtL6JLA9ykx4lC03m7qlBofmLnCUj7Db/EYiA3cqQLTPWFZR
 7NhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786362397; x=1786967197;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=eG7xSIKJBQlkR+Ht7ZzjAH9JD+MeuS2xuYEmxMo79vg=;
 b=olTWqxLEbZQeEJrTcIoIP+vGUmiKWYT1b93IwIjjV213pC6zJTR9qVr7K84416vZYM
 t+YbMrqzl/TatNq8KBEPrWydyYCXXPq9oYUy6FsvAZGzpiLoDbQY7m9V+WJoYqEojuNt
 djqaxLtQCZ4tH6YsIdVwrYY9hS+fnovxorgYFhe46gDS/VTkwmsDQJiqqAGQrtpU4jQv
 fmOADvb6rvOY1ODx95wPdosC2z/IPle26TBAqxDB5JloBPZjMMcvhURl8xv8tVBJyskr
 OHsQ/6fpgzo107FmXImzPUaj0zae/juHrR26qzxE/DKthyJgLNMEmQnaR8UjwL+bK1uA
 ORpQ==
X-Gm-Message-State: AOJu0YwnFGCWaIffedkyq07NJf+A4f6vVOxFm+okcXFupQE0ZJE/fQrM
 c4RrWSXD9SJVwMZKu+Cs284EiSNXHrgV5o2+kEj6/AeFHomUonDmn5+NrSY6rkGeI49ZFjORc8C
 H3ikFkJxvfxm+nGs9youdhR3jtP3tHRSTZlm3NL8JYtnc3jUE+XZPaq1WgcQUJzJPPDscdKtesD
 0sC4Fr0w==
X-Gm-Gg: AR+sD11n3RmE/cyhY9yXeEBlA3PwJt0m1w3SEpSQGzHJ3lIisiG43GfKZUxWdQOuhwP
 iMbme/Hi3bMLY/mEgbpBlmIHDwws+E4Xy443dcVrRwC9aQF0syY6UlH1gzHCAdeJOsUaUEwyvyS
 1firRinQNm/qwjWXUg52ZKLxfsYySq36ifI/Ivmmpnc0NFFvObfOb5WTkIsdwhs+k/9FuXjQAPX
 yJVHk9yQK9kS+9FEjlBi+ZpTr2aZlTu3WKyq/PUWq6V63/cT5UJ0znlQ2YaGwb2WsxTrkCzWQE4
 a/d6CsIrLA2o5FvO4UhqPeMbsJ9juXqPXwjGhmPa4KKN8UeOnHhG7W2MuRKfj2gmK9itTytGdbO
 YjWJmPI/boiVfUS1WR6akouaj/6wdSIHY4512we2VRIy7ZSWIM6mPI41e+WCWDcklOmlclgC/Vr
 VBl4yqVeQpDhaxurqCW9645ebbgpqbInRD0/mSf0Sz6VBhrvO3+/RF5+q3n/N7Z8zJCY5DxscDj
 rfu6MA45q3PBS3cs8QJeAcga6+PCsEpAnYoBMaRPM2sl2RK/w9kuy0UBZiv9MJdsOlASTPMGotB
 hbF17ByXrCXrgIN7Ez2Tf2H0NbmjOsx/n718jtuPHkHjEP8A79I=
X-Received: by 2002:a05:600c:4709:b0:498:28b:1045 with SMTP id
 5b1f17b1804b1-499727483ecmr11870525e9.3.1786362395568; 
 Mon, 10 Aug 2026 04:46:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995dee21dcsm297210185e9.0.2026.08.10.04.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 04:46:34 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 10 Aug 2026 11:46:32 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I350ca5b08379ede1480b81055d35dd9a33e30cff
X-Gerrit-Change-Number: 1581
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1581?usp=email>
X-Gerrit-Commit: 3f9752c66048ef840eaa0641294544606994e16c
In-Reply-To: <gerrit.1773842036000.I350ca5b08379ede1480b81055d35dd9a33e30cff@gerrit.openvpn.net>
References: <gerrit.1773842036000.I350ca5b08379ede1480b81055d35dd9a33e30cff@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczODQyMDM2MDAwLkkzNTBjYTViMDgzNzllZGUxNDgwYjgxMDU1ZDM1ZGQ5YTMzZTMwY2ZmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2f3adcfd2904c94890968da6153ba583a92366de-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wtOSs-0000o0-QM
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7515044496086800797=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7515044496086800797==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UI/YSsAeJpY="; charset=UTF-8

--UI/YSsAeJpY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello pla=
isthos, 

I'd like you to reexamine a change=2E Please visit

    http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1581?usp=3Demail

to look at the new patch=
 set (#4)=2E

The following approvals got outdated and were removed:
Code-R=
eview+2 by plaisthos

The change is no longer submittable: Code-Review and =
checks~ChecksSubmitRule are unsatisfied now=2E


Change subject: doc: add D=
oxygen documentation to buffer=2Eh
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

doc: add Doxygen documentation to buffer=2Eh

Docume=
nt all previously undocumented elements=2E

Github: Fixes #864
Change-Id: I=
350ca5b08379ede1480b81055d35dd9a33e30cff
Signed-off-by: Frank Lichtenheld <=
frank@lichtenheld=2Ecom>
---
M src/openvpn/buffer=2Eh
1 file changed, 1,045=
 insertions(+), 65 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/81/1581/4

diff --git a/src/openvpn/buffer=2Eh b/=
src/openvpn/buffer=2Eh
index 743c3f4=2E=2E74c84b2 100644
--- a/src/openvpn/=
buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -20,6 +20,15 @@
  *  with this p=
rogram; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
  */
 
+/**
+ * =
@file
+ * @brief Buffer management functions and garbage collection=2E
+ *
=
+ * This module provides the core \c buffer type used throughout OpenVPN to=

+ * hold packet data, as well as a simple memory management system
+ * (\c=
 gc_arena / \c gc_malloc()) and various string/memory utility functions=2E
=
+ */
+
 #ifndef BUFFER_H
 #define BUFFER_H
 
@@ -27,6 +36,7 @@
 #include "e=
rror=2Eh"
 #include "integer=2Eh"
 
+/** Maximum allowed size (in bytes) fo=
r a single buffer allocation=2E */
 #define BUF_SIZE_MAX 1000000
 
 /*
@@ -=
115,51 +125,213 @@
  */
 struct gc_arena
 {
-    struct gc_entry *list; /**=
< First element of the linked list of
-                            *   \c g=
c_entry structures=2E */
-    struct gc_entry_special *list_special;
+    s=
truct gc_entry *list;                 /**< First element of the linked list=
 of
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
Type: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I350ca5b08379ede1480b81055d35dd9a33e30cff
Gerrit-Change-Number: 1581=

Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenhe=
ld=2Ecom>

--UI/YSsAeJpY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>flichtenheld <stro=
ng>uploaded patch set #4</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1581?usp=3Demail">View Change</a></p><p=
>The following approvals got outdated and were removed:
Code-Review+2 by pl=
aisthos</p><p>The change is no longer submittable: Code-Review and checks~C=
hecksSubmitRule are unsatisfied now=2E</p><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">doc: add Doxygen do=
cumentation to buffer=2Eh<br><br>Document all previously undocumented eleme=
nts=2E<br><br>Github: Fixes #864<br>Change-Id: I350ca5b08379ede1480b81055d3=
5dd9a33e30cff<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ec=
om&gt;<br>---<br>M src/openvpn/buffer=2Eh<br>1 file changed, 1,045 insertio=
ns(+), 65 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/81/1581/4</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/=
openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><span>index 743c3f4=
=2E=2E74c84b2 100644</span><br><span>--- a/src/openvpn/buffer=2Eh</span><br=
><span>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -20,6 +20,15 @@</spa=
n><br><span>  *  with this program; if not, see &lt;https://www=2Egnu=2Eorg=
/licenses/&gt;=2E</span><br><span>  */</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @file</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @brief Buffer management functions and garbage collection=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * This module provides the core \c bu=
ffer type used throughout OpenVPN to</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * hold packet data, as well as a simple memory management=
 system</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * (\c gc_ar=
ena / \c gc_malloc()) and various string/memory utility functions=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifndef BUFFER_H</span>=
<br><span> #define BUFFER_H</span><br><span> </span><br><span>@@ -27,6 +36,=
7 @@</span><br><span> #include &quot;error=2Eh&quot;</span><br><span> #incl=
ude &quot;integer=2Eh&quot;</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/** Maximum allowed size (in bytes) for a single =
buffer allocation=2E */</span><br><span> #define BUF_SIZE_MAX 1000000</span=
><br><span> </span><br><span> /*</span><br><span>@@ -115,51 +125,213 @@</sp=
an><br><span>  */</span><br><span> struct gc_arena</span><br><span> {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_entry *list; =
/**&lt; First element of the linked list of</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                            *   \c gc_entry structure=
s=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_=
entry_special *list_special;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct gc_entry *list;                 /**&lt; First element o=
f the linked list of</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                            *   \c gc_entry structures=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_ent=
ry_special *list_special; /**&lt; First element of the linked</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
           *   list of \c gc_entry_special</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                            *   stru=
ctures for allocations</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                            *   requiring a custom free<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                        *   function=2E */</span><br><span> };</span><br><s=
pan> </span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/** Return a pointer to the start of the buffer content=2E @see buf_bpt=
r() */</span><br><span> #define BPTR(buf)  (buf_bptr(buf))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/** Return a pointer one past the en=
d of the buffer content=2E @see buf_bend() */</span><br><span> #define BEND=
(buf)  (buf_bend(buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/** Return a pointer to the last byte of the buffer content, or NULL if =
empty=2E @see buf_blast() */</span><br><span> #define BLAST(buf) (buf_blast=
(buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Return th=
e length of the buffer content in bytes=2E @see buf_len() */</span><br><spa=
n> #define BLEN(buf)  (buf_len(buf))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/** Return the length of the buffer content as a \c size_t=
=2E @see buf_len() */</span><br><span> #define BLENZ(buf) ((size_t)buf_len(=
buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Return tru=
e iff the buffer is defined (has non-NULL data pointer)=2E @see buf_defined=
() */</span><br><span> #define BDEF(buf)  (buf_defined(buf))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/** Return the buffer content poin=
ter cast to \c char *=2E @see buf_str() */</span><br><span> #define BSTR(bu=
f)  (buf_str(buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
** Return the number of bytes available for appending to the buffer=2E @see=
 buf_forward_capacity() */</span><br><span> #define BCAP(buf)  (buf_forward=
_capacity(buf))</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 Zeroise and reset a buffer=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Set=
s all allocated memory to zero and resets \c offset and \c len to zero,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * but does not free th=
e underlying memory=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf =
  The buffer to clear=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ */</span><br><span> void buf_clear(struct buffer *buf);</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * Free the memory allocated fo=
r a buffer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Frees \c buf-&gt;dat=
a and resets the buffer to an undefined state=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param buf   The buffer whose memory is to be freed=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> void=
 free_buf(struct buffer *buf);</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * Assign the content of one buffer to another=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Copies the content of \c src into \c dest=2E  =
The destination buffer must</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * already be allocated with sufficient capacity=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param dest  Destination buffer to write into=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param src   Sour=
ce buffer to read from=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return =
true on success, false if \c dest has insufficient capacity=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> bool buf_as=
sign(struct buffer *dest, const struct buffer *src);</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Securely clear a null-terminated stri=
ng=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * Overwrites all characters of=
 \c str with zeroes=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param str =
  The string to clear=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ */</span><br><span> void string_clear(char *str);</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * Return the number of elements in a=
 NULL-terminated array of strings=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param array     NULL-terminated array of string pointers=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @return Number of non-NULL elements=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> int s=
tring_array_len(const char **array);</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Safely compute the product of two sizes plus an extra=
 amount=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Each of \c m1, \c m2, a=
nd \c extra, as well as the final result, are</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * checked against \c ALLOC_SIZE_MAX=2E  If any v=
alue exceeds the limit the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * function calls \c msg(M_FATAL) and does not return=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param m1    First multiplicand=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param m2    Second multipl=
icand=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param e=
xtra Value to add to the product=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @return \c m1 * \c m2 + \c extra=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span> size_t array_mult_safe(const size_t =
m1, const size_t m2, const size_t extra);</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/** Flag for print_argv(): wrap eac=
h argument in square brackets=2E */</span><br><span> #define PA_BRACKET (1 =
&lt;&lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Format a NULL-termina=
ted argument vector as a single string=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param p     NULL-terminated array of string pointers to format=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param gc    Garb=
age collection arena for the returned string=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param flags Formatting flags (e=2Eg=2E \c P=
A_BRACKET)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return Newly alloca=
ted string representation of \c p=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ */</span><br><span> char *print_argv(const char **p, stru=
ct gc_arena *gc, const unsigned int flags);</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Report a buffer size error and abort=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Called when a requested buffer size ex=
ceeds \c BUF_SIZE_MAX or is otherwise</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * invalid=2E  Calls \c msg(M_FATAL) and does not return=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param size  The invalid size =
that was requested=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span> void buf_size_error(const size_t size);</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Allocate a buffer of the gi=
ven size=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Calls \c out_of_memory=
() if the allocation fails=2E The caller is responsible</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * for freeing the memory=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param size  Number of bytes to allocate=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @return Newly allocated buffer of =
capacity \c size=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span> struct buffer alloc_buf(size_t size);</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct buffer alloc_=
buf_gc(size_t size,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                         struct gc_arena *gc); /* allocate buffer with garb=
age collection */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Allocate a buff=
er of the given size under garbage collection=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * The allocated memory is registered with \c gc so that it is =
freed when</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * \c gc_=
free() is called on the arena=2E  Calls \c out_of_memory() if the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * allocation fails=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param size  Number of bytes to alloca=
te=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param gc  =
  Garbage collection arena to register the allocation with=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @return Newly allocated buffer of capacity \c s=
ize=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+struct buffer alloc_buf_gc(si=
ze_t size, struct gc_arena *gc);</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * Duplicate a buffer, including its content=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Allocates a new buffer with the same capacity =
as \c buf and copies its</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * content=2E  Calls \c out_of_memory() if the allocation fails=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer to duplicate=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @return A newly allocated copy=
 of \c buf=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span> struct buffer clone_buf(const struct buffer *buf);</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * Allocate memory and, opt=
ionally, zero it=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The allocation=
 is registered with \c a so that it is freed when</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * \c gc_free() is called on the arena=2E  Ca=
lls \c out_of_memory() if the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * allocation fails=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param size  Number of bytes to allocate=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param clear If true, zeroise the allocated memor=
y before returning=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param a     Garbage collection arena to register the allocation with=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @return Pointer to the newly a=
llocated memory=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span> void *gc_malloc(size_t size, bool clear, struct gc_aren=
a *a);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Duplicat=
e a string, allocating memory under garbage collection=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param str   The string to duplicate=2E  May be NUL=
L, in which case NULL</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *              is returned=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param gc    Garbage collection arena for the returned stri=
ng, or NULL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *      =
        to use plain \c malloc()=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @return A newly allocated copy of \c str, or NULL if \c str is NULL=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> c=
har *string_alloc(const char *str, struct gc_arena *gc);</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Allocate a buffer containing a co=
py of the given string=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Wraps \c=
 string_alloc(), so \c gc may be NULL (plain \c malloc() is used</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * in that case)=2E  The buffe=
r \c len reflects the string length, excluding</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * the null terminator, even though the terminat=
or is present in the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * allocated memory=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param str=
   The string to copy into the buffer=2E  Must not be NULL=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param gc    Garbage collectio=
n arena for the allocation, or NULL=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @return A buffer whose content is a copy of \c str=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> struct buffer s=
tring_alloc_buf(const char *str, struct gc_arena *gc);</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Register an address with a custom f=
ree function in a garbage collection</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * arena=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * When =
\c gc_free() is called on \c a, \c free_function(addr) will be</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * invoked to release the memory=
=2E  Use this for allocations that require</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * something other than plain \c free(), such as \c =
freeaddrinfo()=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param addr     =
     Pointer to the memory to register=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param free_function Function to call to free \c a=
ddr=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param a  =
           Garbage collection arena to register with=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> void gc_addspecial=
(void *addr, void (*free_function)(void *), struct gc_arena *a);</span><br>=
<span> </span><br><span> /**</span><br><span>@@ -177,6 +349,7 @@</span><br>=
<span> </span><br><span> #ifdef BUF_INIT_TRACKING</span><br><span> #define =
buf_init(buf, offset) buf_init_debug(buf, offset, __FILE__, __LINE__)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Debug variant of \c b=
uf_init_dowork() that records the call site for alignment verification=2E *=
/</span><br><span> bool buf_init_debug(struct buffer *buf, int offset, cons=
t char *file, int line);</span><br><span> </span><br><span> #else</span><br=
><span>@@ -185,31 +358,62 @@</span><br><span> </span><br><span> </span><br>=
<span> /* inline functions */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Callback to free a \c =
struct \c addrinfo, suitable for use with</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * \c gc_addspecial()=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param addr  Pointer to the \c struct \c addrinfo to free=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> =
static inline void</span><br><span> gc_freeaddrinfo_callback(void *addr)</s=
pan><br><span> {</span><br><span>     freeaddrinfo((struct addrinfo *)addr)=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-/** Return an empty struct buffer */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/** Return an empty, undefined \c struct =
\c buffer (all fields zero)=2E */</span><br><span> static inline struct buf=
fer</span><br><span> clear_buf(void)</span><br><span> {</span><br><span>   =
  return (struct buffer){ 0 };</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Return true iff \c buf has a non-NULL =
data pointer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * A defined buffer h=
as been allocated but may have zero length or negative</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * len (i=2Ee=2E it is not necessarily v=
alid)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer t=
o test=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span> static inline bool</span><br><span> buf_defined(const struct buf=
fer *buf)</span><br><span> {</span><br><span>     return buf-&gt;data !=3D =
NULL;</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Return true iff \c buf is valid=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * A buffer is valid when its data pointer is non-NULL and its \c l=
en is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * non-negativ=
e=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer to te=
st=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span> static inline bool</span><br><span> buf_valid(const struct buffer *b=
uf)</span><br><span> {</span><br><span>     return likely(buf-&gt;data !=3D=
 NULL) &amp;&amp; likely(buf-&gt;len &gt;=3D 0);</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return a pointer to th=
e start of the buffer content=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param buf   The buffer to query=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @return Pointer to \c buf-&gt;data + \c buf-&gt;offset, or NULL if \c buf =
is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         not va=
lid=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span> static inline uint8_t *</span><br><span> buf_bptr(const struct buff=
er *buf)</span><br><span> {</span><br><span>@@ -223,6 +427,13 @@</span><br>=
<span>     }</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Return the length of the buffer content=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param buf   The buffer to query=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @return \c buf-&gt;len if \c buf is valid, othe=
rwise 0=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span> static int</span><br><span> buf_len(const struct buffer *buf)</=
span><br><span> {</span><br><span>@@ -236,12 +447,27 @@</span><br><span>   =
  }</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Return a pointer one past the end of the buffer content=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param buf   The buffer to query=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return Pointer to the byte immediatel=
y after the last content byte=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ */</span><br><span> static inline uint8_t *</span><br><span> =
buf_bend(const struct buffer *buf)</span><br><span> {</span><br><span>     =
return buf_bptr(buf) + buf_len(buf);</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * Return a pointer to the last byte =
of the buffer content=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param bu=
f   The buffer to query=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return=
 Pointer to the last byte, or NULL if the buffer is empty or</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *         invalid=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inli=
ne uint8_t *</span><br><span> buf_blast(const struct buffer *buf)</span><br=
><span> {</span><br><span>@@ -255,24 +481,56 @@</span><br><span>     }</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
Return true iff \c size is within the allowed buffer size range=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param size  The size to check=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @return true if \c size &lt; \c BUF_SIZE_M=
AX=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span> static inline bool</span><br><span> buf_size_valid(const size_t size=
)</span><br><span> {</span><br><span>     return likely(size &lt; BUF_SIZE_=
MAX);</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Return true iff a signed \c size is within the allowed buffer siz=
e range=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Accepts negative values=
 (used for bidirectional length adjustments) as</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * long as the absolute value is below \c BUF_S=
IZE_MAX=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param size  The signed=
 size to check=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true if =
\c -BUF_SIZE_MAX &lt;=3D size &lt; \c BUF_SIZE_MAX=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inline bool</=
span><br><span> buf_size_valid_signed(const int size)</span><br><span> {</s=
pan><br><span>     return likely(size &gt;=3D -BUF_SIZE_MAX) &amp;&amp; lik=
ely(size &lt; BUF_SIZE_MAX);</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Return the buffer content pointer cast to =
\c char *=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buff=
er to query=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return The content=
 pointer as a \c char *, or NULL if \c buf is invalid=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inline cha=
r *</span><br><span> buf_str(const struct buffer *buf)</span><br><span> {</=
span><br><span>     return (char *)buf_bptr(buf);</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Reset a buffer to an =
undefined (unallocated) state=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * S=
ets all fields to zero/NULL without freeing any memory=2E  Use \c free_buf(=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * first if the bu=
ffer owns allocated memory=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am buf   The buffer to reset=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span> static inline void</span><br><span> buf_re=
set(struct buffer *buf)</span><br><span> {</span><br><span>@@ -282,6 +540,1=
4 @@</span><br><span>     buf-&gt;data =3D NULL;</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Reset the length and o=
ffset of a buffer to zero=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The u=
nderlying allocation is preserved and \c capacity is unchanged=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * Equivalent to rewinding th=
e buffer to the beginning for fresh writing=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param buf   The buffer to reset=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span> static inline void</span>=
<br><span> buf_reset_len(struct buffer *buf)</span><br><span> {</span><br><=
span>@@ -289,6 +555,18 @@</span><br><span>     buf-&gt;offset =3D 0;</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * In=
itialise a buffer with a given initial offset=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Sets \c buf-&gt;len to zero and \c buf-&gt;offset to \c offs=
et=2E  The buffer must</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * already be allocated=2E  Returns false (without modifying \c buf) if =
\c offset</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * is nega=
tive, exceeds the buffer capacity, or the data pointer is NULL=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param buf     The buffer to initialise=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param offset  In=
itial byte offset from the start of the allocated memory=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @return true on success, false if the parameters =
are invalid=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span> static inline bool</span><br><span> buf_init_dowork(struct =
buffer *buf, int offset)</span><br><span> {</span><br><span>@@ -301,6 +579,=
17 @@</span><br><span>     return true;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Initialise a buffer with an ext=
ernally provided writable memory region=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Sets up \c buf to use \c data as its backing store for writing=2E =
 The first</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * byte o=
f \c data is set to zero=2E  Calls \c buf_size_error() (which does not</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * return) if \c size ex=
ceeds \c BUF_SIZE_MAX=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param bu=
f   The buffer to initialise=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param data  Pointer to the memory region to use=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param size  Size of the =
memory region in bytes=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span> static inline void</span><br><span> buf_set_writ=
e(struct buffer *buf, uint8_t *data, int size)</span><br><span> {</span><br=
><span>@@ -318,6 +607,18 @@</span><br><span>     }</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Initialise a buffer =
with an externally provided read-only memory region=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Sets up \c buf so that the entire \c data region is th=
e buffer content</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
(offset is 0, len and capacity are both set to \c size)=2E  The data pointe=
r</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * is cast away fr=
om const=2E  Calls \c buf_size_error() (which does not return)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * if \c size exceeds \c BUF_SIZ=
E_MAX=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer t=
o initialise=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param data  Pointer to the read-only memory region=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param size  Size of the memory region=
 in bytes=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span> static inline void</span><br><span> buf_set_read(struct buffe=
r *buf, const uint8_t *data, size_t size)</span><br><span> {</span><br><spa=
n>@@ -330,7 +631,17 @@</span><br><span>     buf-&gt;data =3D (uint8_t *)dat=
a;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-/* Like strncpy but makes sure dest is always null termin=
ated */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * Like \c strncpy() but alw=
ays null-terminates the destination=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Copies at most \c maxlen - 1 characters from \c src into \c dest and</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * writes a null term=
inator at \c dest[\c maxlen - 1]=2E  Does nothing if</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * \c maxlen is zero=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param dest    Destination buffer=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param src     Source string=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param maxlen  S=
ize of the destination buffer in bytes=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span> static inline void</span><br><sp=
an> strncpynt(char *dest, const char *src, size_t maxlen)</span><br><span> =
{</span><br><span>@@ -341,7 +652,13 @@</span><br><span>     }</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-/* return true if string contains at least one numerical digit */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Return true if the string contains at =
least one decimal digit=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
src   The null-terminated string to scan=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @return true if any character in \c src satisfies \c isdigit()=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
> static inline bool</span><br><span> has_digit(const char *src)</span><br>=
<span> {</span><br><span>@@ -401,11 +718,20 @@</span><br><span> #endif</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * print=
f append to a buffer with overflow check,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * due to usage of vsnprintf, it will leave space for</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * a final null charact=
er and thus use only</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* capacity - 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * printf-style appen=
d to a buffer with overflow check=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * Formats a string and appends it to \c buf=2E  Due to the use of</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * \c vsnprintf(), one byte =
of forward capacity is reserved for a null</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * terminator, so at most \c buf_forward_capacity(bu=
f) - 1 bytes of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * f=
ormatted output are written=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram buf     The buffer to append to=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param format  printf-style format string=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =2E=2E=2E     Form=
at arguments=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true if th=
e entire formatted string fit in the buffer, false if</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *         it was truncated=2E</span><br>=
<span>  */</span><br><span> bool buf_printf(struct buffer *buf, const char =
*format, =2E=2E=2E)</span><br><span> #ifdef __GNUC__</span><br><span>@@ -41=
7,8 +743,13 @@</span><br><span> #endif</span><br><span>     ;</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * puts append to a buffer with over=
flow check</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Append a string to a b=
uffer with overflow check=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m buf   The buffer to append to=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param str   The null-terminated string to append=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return true if the string fit in the =
buffer, false if it was truncated=2E</span><br><span>  */</span><br><span> =
bool buf_puts(struct buffer *buf, const char *str);</span><br><span> </span=
><br><span>@@ -427,24 +758,78 @@</span><br><span>  * remove/add trailing ch=
aracters</span><br><span>  */</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Force a null terminator at the end of the buffer content=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * If there is free capacity, a &#39;=
\\0&#39; byte is appended=2E  If the buffer is</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * full, the last content byte is overwritten wi=
th &#39;\\0&#39; (i=2Ee=2E the last</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * character is truncated to make room)=2E  The function ha=
s no effect on an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 empty or invalid buffer=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 buf   The buffer to null-terminate=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span> void buf_null_terminate(struct buff=
er *buf);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Remov=
e trailing newline and carriage-return characters from a buffer=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param buf   The buffer to chomp=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> void =
buf_chomp(struct buffer *buf);</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * Remove all occurrences of a specific byte from the end of a=
 buffer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf     The buff=
er to modify=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param remove  The byte value to strip from the tail=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> void buf_rmtail(str=
uct buffer *buf, uint8_t remove);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * non-buffer string functions</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/** @name String Utility Functions</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  @brief Non-buffer string functio=
ns</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**@{*/</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Re=
move trailing newline and carriage-return characters from a string=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param str   The null-terminated strin=
g to chomp=2E</span><br><span>  */</span><br><span> void chomp(char *str);<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Remove all trai=
ling characters that appear in a given set=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param str             The null-terminated string to modify in =
place=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param w=
hat_to_delete  Null-terminated set of characters to strip=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> void rm_trail=
ing_chars(char *str, const char *what_to_delete);</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Return a pointer past any leading whit=
espace in a string=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param str  =
 The string to skip whitespace in=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @return Pointer to the first non-whitespace character, or to the null</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         terminator =
if \c str is all whitespace=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span> const char *skip_leading_whitespace(const c=
har *str);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Null=
-terminate a fixed-length string buffer=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Ensures that \c str[\c len] is &#39;\\0&#39;, clamping \c len to \=
c capacity - 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * if=
 necessary=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param str       The=
 character buffer to null-terminate=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param len       Current string length=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param capacity  Total size =
of the character buffer in bytes=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span> #ifdef _WIN32</span><br><span> void st=
ring_null_terminate(char *str, int len, int capacity);</span><br><span> #en=
dif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**@}*/</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* End of string utility fun=
ctions */</span><br><span> </span><br><span> /**</span><br><span>  * Write =
buffer contents to file=2E</span><br><span>@@ -456,40 +841,114 @@</span><br=
><span>  */</span><br><span> bool buffer_write_file(const char *filename, c=
onst struct buffer *buf);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * write a string to the end of a buffer that was</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * truncated by buf_printf</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Append a string to the physical end of a buffer t=
hat was truncated by</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * \c buf_printf()=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If the buff=
er&#39;s forward capacity is one byte or less (i=2Ee=2E it is full),</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * \c str is written at th=
e very end of the allocated memory to act as a</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * truncation marker, provided it fits within th=
e total buffer capacity=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * This is used to append a &quot;[more=2E=2E=2E]&quot; suffix after=
 hex-dump truncation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf=
   The buffer to append the truncation marker to=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param str   The null-terminated marke=
r string to write=2E</span><br><span>  */</span><br><span> void buf_catrunc=
(struct buffer *buf, const char *str);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * Parse a string based on a given delimiter char</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Extract the next token from a buffer, deli=
mited by a given character=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read=
s bytes from \c buf one at a time until \c delim or end-of-buffer is</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * encountered=2E  The tok=
en (without the delimiter) is written into \c line,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * which is always null-terminated=2E  Th=
e delimiter byte is consumed from</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * \c buf but not included in \c line=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param buf    Source buffer to parse=2E  The consumed =
portion is advanced=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param delim  Delimiter character=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param line   Output buffer for the extracted tok=
en=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param size=
   Size of \c line in bytes (must be &gt; 0)=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @return false only when end-of-buffer is reached and no chara=
cters were</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
  extracted; true otherwise (including when a delimiter was found</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *         or \c line was tru=
ncated)=2E</span><br><span>  */</span><br><span> bool buf_parse(struct buff=
er *buf, const int delim, char *line, const int size);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * Hex dump -- Output a binary buffer to a =
hex string and return it=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/** @name Hex Dump</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  @brief Output a binary buffer to a hex string and return it=2E</=
span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#d=
efine FHE_SPACE_BREAK_MASK 0xFF  /* space_break parameter in lower 8 bits *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define FHE_CAPS    =
         0x100 /* output hex in caps */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/**@{*/</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Mask fo=
r the space_break_flags field of \c format_hex_ex(): number of</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  bytes between separators (lo=
wer 8 bits)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine FHE_SPACE_BREAK_MASK 0xFF</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/** Flag for \c format_hex_ex(): output hex digits in upper cas=
e=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define FHE_=
CAPS             0x100</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Format a b=
inary buffer as a hex string=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram data              Pointer to the binary data to format=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param size              Numb=
er of bytes to format=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param maxoutput         Maximum number of output characters (0 =3D=
 unlimited)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
                       If the output is truncated, a &quot;[more=2E=2E=2E]&=
quot; suffix is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
                        appended via \c buf_catrunc()=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param space_break_flags Lower 8 bi=
ts (\c FHE_SPACE_BREAK_MASK) give the</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *                          number of bytes between \c se=
parator insertions=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *                          Use \c FHE_CAPS to output upper-case hex digi=
ts=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param sepa=
rator         String to insert between groups of bytes=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param gc                Garbage c=
ollection arena for the returned string=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @return Null-terminated hex string allocated from \c gc=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> char *=
format_hex_ex(const uint8_t *data, size_t size, size_t maxoutput, unsigned =
int space_break_flags,</span><br><span>                     const char *sep=
arator, struct gc_arena *gc);</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Format a binary buffer as a hex string with spaces every 4 b=
ytes=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * Convenience wrapper around=
 \c format_hex_ex()=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param data=
       Pointer to the binary data to format=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param size       Number of bytes to format=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param maxout=
put  Maximum number of output characters (0 =3D unlimited)=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param gc         Garbage coll=
ection arena for the returned string=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @return Null-terminated hex string allocated from \c gc=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static in=
line char *</span><br><span> format_hex(const uint8_t *data, size_t size, s=
ize_t maxoutput, struct gc_arena *gc)</span><br><span> {</span><br><span>  =
   return format_hex_ex(data, size, maxoutput, 4, &quot; &quot;, gc);</span=
><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**@}*=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* End of Hex Dump=
 */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Return a buffer =
that is a subset of another buffer=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Return a sub-buffer of another buffer=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Either allocates \c size bytes from the front or back of \c buf=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * shrinking \c bu=
f accordingly, and returns a buffer pointing into the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * same memory=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param buf      Source buffer to carve the sub-buffer f=
rom=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param siz=
e     Number of bytes to include in the sub-buffer=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param prepend  If true, take bytes fr=
om the front of \c buf (prepend</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *                 space); if false, take bytes from the end (a=
ppend space)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return A buffer r=
eferencing the allocated region, or an undefined buffer</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *         if \c buf has insufficient c=
apacity=2E</span><br><span>  */</span><br><span> struct buffer buf_sub(stru=
ct buffer *buf, int size, bool prepend);</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * Check if sufficient space to append to buffer=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Check whether \c len bytes can be appe=
nded to a buffer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   T=
he buffer to check=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param len   Number of bytes to append=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @return true if \c buf is valid, \c len is within the allowed =
range, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
  there is sufficient capacity after the current content=2E</span><br><span=
>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> static inline bool</span><br><span> buf_safe(const struct buffer *buf, si=
ze_t len)</span><br><span> {</span><br><span>@@ -497,6 +956,18 @@</span><br=
><span>            &amp;&amp; buf-&gt;offset + buf-&gt;len + (int)len &lt;=
=3D buf-&gt;capacity;</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Check whether \c len bytes can be added to or rem=
oved from a buffer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Accepts nega=
tive \c len to verify that bytes can be removed (length</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * decreased)=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param buf   The buffer to check=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param len   Number of bytes to add =
(positive) or remove (negative)=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @return true if the resulting length would remain non-negative and within<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         the alloc=
ated capacity=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */=
</span><br><span> static inline bool</span><br><span> buf_safe_bidir(const =
struct buffer *buf, int len)</span><br><span> {</span><br><span>@@ -511,6 +=
982,17 @@</span><br><span>     }</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Return the number of bytes that can st=
ill be appended to the buffer=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * T=
his is the space between the end of the current content and the end of</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the allocated memory=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer to que=
ry=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @return Number of bytes avai=
lable for appending, or 0 if \c buf is</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *         invalid=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span> static inline int</span><br><span=
> buf_forward_capacity(const struct buffer *buf)</span><br><span> {</span><=
br><span>@@ -529,6 +1011,17 @@</span><br><span>     }</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return the total =
number of bytes available from the current offset to the</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * end of the allocated memory=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Unlike \c buf_forward_capacity(), this=
 includes the bytes already occupied</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * by the current content=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param buf   The buffer to query=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @return Capacity minus offset, or 0 if \c buf is invalid=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> =
static inline int</span><br><span> buf_forward_capacity_total(const struct =
buffer *buf)</span><br><span> {</span><br><span>@@ -547,6 +1040,16 @@</span=
><br><span>     }</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Return the number of bytes available for prepending t=
o the buffer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This is the number=
 of bytes between the start of the allocated memory and</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * the current content start (i=2Ee=2E =
\c buf-&gt;offset)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf  =
 The buffer to query=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return \c=
 buf-&gt;offset, or 0 if \c buf is invalid=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span> static inline int</span><br>=
<span> buf_reverse_capacity(const struct buffer *buf)</span><br><span> {</s=
pan><br><span>@@ -560,6 +1063,17 @@</span><br><span>     }</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Increase or =
decrease the length of a buffer=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 Adjusts \c buf-&gt;len by \c inc bytes=2E  A negative \c inc shrinks the</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * buffer=2E  The ope=
ration is bounds-checked via \c buf_safe_bidir()=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param buf   The buffer to modify=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param inc   Number of bytes to add=
 to the length (may be negative)=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @return true on success, false if the adjustment would violate bounds=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span>=
 static inline bool</span><br><span> buf_inc_len(struct buffer *buf, int in=
c)</span><br><span> {</span><br><span>@@ -571,11 +1085,18 @@</span><br><spa=
n>     return true;</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * Make space to prepend to a buffer=2E</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * Return NULL if no space=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Make space at the front of a buffer for prep=
ending data=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Moves the content s=
tart backwards by \c size bytes, increasing \c len</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * and decreasing \c offset by the same amou=
nt=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer to m=
odify=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param s=
ize  Number of bytes to reserve for prepending=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @return Pointer to the newly reserved space (new content st=
art), or NULL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    =
     if \c buf is invalid or there is insufficient prepend capacity=2E</spa=
n><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> static inline uint8_t *</span><br><span> buf_prepend(struct bu=
ffer *buf, ssize_t size)</span><br><span> {</span><br><span>@@ -588,6 +1109=
,17 @@</span><br><span>     return BPTR(buf);</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * Advance the content start=
 of a buffer, consuming bytes from the front=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Increases \c offset and decreases \c len by \c size bytes=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer to advance=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param size  =
Number of bytes to skip=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return=
 true on success, false if \c buf is invalid or \c size exceeds</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *         the current length=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan> static inline bool</span><br><span> buf_advance(struct buffer *buf, ss=
ize_t size)</span><br><span> {</span><br><span>@@ -600,11 +1132,18 @@</span=
><br><span>     return true;</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * Return a pointer to allocated space inside a bu=
ffer=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Return NULL=
 if no space=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Reserve space at =
the end of a buffer for writing=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 Increases \c buf-&gt;len by \c size and returns a pointer to the start of<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the newly reserve=
d region=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffe=
r to allocate space in=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param size  Number of bytes to reserve=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return Pointer to the start of the reserved space, or =
NULL if there is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
        insufficient capacity=2E</span><br><span>  */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static inline uint8_t *</=
span><br><span> buf_write_alloc(struct buffer *buf, size_t size)</span><br>=
<span> {</span><br><span>@@ -618,6 +1157,18 @@</span><br><span>     return =
ret;</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Consume bytes from the front of a buffer for reading=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Returns a pointer to the current content sta=
rt and advances the buffer</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * by \c size bytes=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am buf   The buffer to read from=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @param size  Number of bytes to consume=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @return Pointer to the start of the consumed re=
gion, or NULL if \c size</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *         is negative or exceeds the current length=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inline=
 uint8_t *</span><br><span> buf_read_alloc(struct buffer *buf, int size)</s=
pan><br><span> {</span><br><span>@@ -632,6 +1183,17 @@</span><br><span>    =
 return ret;</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Append data to a buffer=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Copies \c size bytes from \c src to the end of \c dest=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param dest  Destination buffer=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param src   Data to ap=
pend=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param si=
ze  Number of bytes to append=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
return true on success, false if there is insufficient capacity=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static =
inline bool</span><br><span> buf_write(struct buffer *dest, const void *src=
, size_t size)</span><br><span> {</span><br><span>@@ -644,6 +1206,18 @@</sp=
an><br><span>     return true;</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Prepend data to a buffer=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Copies \c size bytes from \c src into the pr=
epend space at the front of</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * \c dest=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dest =
 Destination buffer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param src   Data to prepend=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param size  Number of bytes to prepend=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @return true on success, false if there is in=
sufficient prepend capacity=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span> static inline bool</span><br><span> buf_wri=
te_prepend(struct buffer *dest, const void *src, int size)</span><br><span>=
 {</span><br><span>@@ -656,12 +1230,28 @@</span><br><span>     return true;=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Append a uint8_t to a buffer=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param dest  Destination buffer=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param data  Byte to append=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return true on success, false if there is insufficient=
 capacity=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span> static inline bool</span><br><span> buf_write_u8(struct buffe=
r *dest, uint8_t data)</span><br><span> {</span><br><span>     return buf_w=
rite(dest, &amp;data, sizeof(uint8_t));</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Append a uint16_t to a buffer i=
n network byte order=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param des=
t  Destination buffer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param data  Value to append (converted with \c htons())=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @return true on success, false if there i=
s insufficient capacity=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span> static inline bool</span><br><span> buf_write_u=
16(struct buffer *dest, uint16_t data)</span><br><span> {</span><br><span>@=
@ -669,6 +1259,14 @@</span><br><span>     return buf_write(dest, &amp;u16, =
sizeof(uint16_t));</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Append a uint32_t to a buffer in network byte order=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param dest  Destination buffe=
r=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param data =
 Value to append (converted with \c htonl())=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @return true on success, false if there is insufficient capac=
ity=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span> static inline bool</span><br><span> buf_write_u32(struct buffer *de=
st, uint32_t data)</span><br><span> {</span><br><span>@@ -676,6 +1274,14 @@=
</span><br><span>     return buf_write(dest, &amp;u32, sizeof(uint32_t));</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * Append a uint64_t to a buffer in network byte order=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param dest  Destination buffer=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param data  Value to append (con=
verted with \c htonll())=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @retur=
n true on success, false if there is insufficient capacity=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inlin=
e bool</span><br><span> buf_write_u64(struct buffer *dest, uint64_t data)</=
span><br><span> {</span><br><span>@@ -683,12 +1289,32 @@</span><br><span>  =
   return buf_write(dest, &amp;u64, sizeof(uint64_t));</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Copy the content=
 of one buffer to the end of another=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param dest  Destination buffer=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param src   Source buffer=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return true on success, false if \c dest has insuffici=
ent capacity=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span> static inline bool</span><br><span> buf_copy(struct buffer=
 *dest, const struct buffer *src)</span><br><span> {</span><br><span>     r=
eturn buf_write(dest, BPTR(src), BLENZ(src));</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * Read \c n bytes from \c s=
rc and append them to \c dest=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * C=
onsumes the bytes from \c src=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param dest  Destination buffer=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param src   Source buffer (modified)=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param n     Number of bytes to co=
py=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, fal=
se if \c src has fewer than \c n bytes or</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *         \c dest has insufficient capacity=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> stat=
ic inline bool</span><br><span> buf_copy_n(struct buffer *dest, struct buff=
er *src, int n)</span><br><span> {</span><br><span>@@ -700,6 +1326,22 @@</s=
pan><br><span>     return buf_write(dest, cp, n);</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Copy a range of bytes=
 from one buffer into a specific position in another=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Copies \c src_len bytes starting at \c src_index with=
in \c src content</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 into \c dest at \c dest_index relative to the content start=2E  Updates</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * \c dest-&gt;len if =
the write extends beyond the current content=2E  Does not</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * advance either buffer&#39;s offset=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param dest        Destination=
 buffer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 dest_index  Byte offset within \c dest content to write at=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param src         Source buf=
fer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param src=
_index   Byte offset within \c src content to read from=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param src_len     Number of byte=
s to copy=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true on succe=
ss, false if any index or length is out of range=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inline bool</=
span><br><span> buf_copy_range(struct buffer *dest, int dest_index, const s=
truct buffer *src, int src_index,</span><br><span>                int src_l=
en)</span><br><span>@@ -717,7 +1359,19 @@</span><br><span>     return true;=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-/* truncate src to len, copy excess data beyond len to dest=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Truncate \c src to \c len byt=
es and copy any excess to \c dest=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * If \c src-&gt;len &gt; \c len, \c src is truncated to \c len bytes and t=
he</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * remaining byte=
s are appended to \c dest=2E  If \c src-&gt;len &lt;=3D \c len,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * nothing is copied and true i=
s returned=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dest  Destina=
tion buffer for the excess data=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param src   Source buffer to truncate=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param len   Maximum number of b=
ytes to keep in \c src=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return =
true on success, false if \c len is negative or copying fails=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static in=
line bool</span><br><span> buf_copy_excess(struct buffer *dest, struct buff=
er *src, int len)</span><br><span> {</span><br><span>@@ -741,6 +1395,17 @@<=
/span><br><span>     }</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * Read bytes from the front of a buffer into a cal=
ler-supplied destination=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Consum=
es \c size bytes from \c src and copies them to \c dest=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param src   Source buffer (modified)=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dest  Destination m=
emory=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param s=
ize  Number of bytes to read=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @r=
eturn true on success, false if \c src has fewer than \c size bytes=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> sta=
tic inline bool</span><br><span> buf_read(struct buffer *src, void *dest, i=
nt size)</span><br><span> {</span><br><span>@@ -753,6 +1418,14 @@</span><br=
><span>     return true;</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Return the first byte of the buffer without co=
nsuming it=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buf=
fer to peek at=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return The firs=
t byte as an unsigned value (0=E2=80=93255), or -1 if the buffer</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *         is empty=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static=
 inline int</span><br><span> buf_peek_u8(struct buffer *buf)</span><br><spa=
n> {</span><br><span>@@ -765,6 +1438,13 @@</span><br><span>     return ret;=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Read and consume a uint8_t from the front of a buffer=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param buf   The buffer to read from=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @return The byte value (0=E2=80=93255), o=
r -1 if the buffer is empty=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span> static inline int</span><br><span> buf_read=
_u8(struct buffer *buf)</span><br><span> {</span><br><span>@@ -776,6 +1456,=
16 @@</span><br><span>     return ret;</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * Read and consume a uint16_t from=
 the front of a buffer=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The valu=
e is converted from network byte order via \c ntohs()=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param buf   The buffer to read from=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @return The host-byte-order value, or -1 if th=
e buffer has fewer than 2</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *         bytes=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span> static inline int</span><br><span> buf_read_u16(=
struct buffer *buf)</span><br><span> {</span><br><span>@@ -787,6 +1477,17 @=
@</span><br><span>     return ntohs(ret);</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Read and consume a uint32_t f=
rom the front of a buffer=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The v=
alue is converted from network byte order via \c ntohl()=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param buf   The buffer to read from=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param good  If non-NULL, =
set to true on success or false on failure=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @return The host-byte-order value, or 0 if the buffer has fewer=
 than 4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         b=
ytes (check \c *good to distinguish from a legitimate zero)=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inli=
ne uint32_t</span><br><span> buf_read_u32(struct buffer *buf, bool *good)</=
span><br><span> {</span><br><span>@@ -809,8 +1510,17 @@</span><br><span>   =
  }</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-/* Read a 64-bit big-endian value (see buf_write_u64())=
=2E Sets *good to indicate</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * success, like buf_read_u32()=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Read and consume a uint64_t from the front of a buffer=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * The value is converted from network byte =
order via \c ntohll()=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param bu=
f   The buffer to read from=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param good  If non-NULL, set to true on success or false on =
failure=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return The host-byte-o=
rder value, or 0 if the buffer has fewer than 8</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *         bytes (check \c *good to distinguish=
 from a legitimate zero)=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ */</span><br><span> static inline uint64_t</span><br><span> buf_re=
ad_u64(struct buffer *buf, bool *good)</span><br><span> {</span><br><span>@=
@ -868,31 +1578,73 @@</span><br><span>     return memcmp(BPTR(src), match, =
size) =3D=3D 0;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Return true if the head of \c src matches the string \=
c match=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Compares the first \c s=
trlen(match) bytes of \c src content with \c match=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * *NOT* constant time=2E Do not use when=
 comparing HMACs=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param src    =
Buffer whose head is compared=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param match  Null-terminated string to compare against=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @return true if the buffer starts =
with \c match=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */=
</span><br><span> bool buf_string_match_head_str(const struct buffer *src, =
const char *match);</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Compare the head of \c src with \c match and advance past it if equal=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * If the buffer starts with \c m=
atch, the matched bytes are consumed from</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * \c src=2E  *NOT* constant time=2E Do not use when =
comparing HMACs=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param src    B=
uffer to compare and advance=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param match  Null-terminated string to compare against=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @return true if the buffer started =
with \c match (and was advanced)=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span> bool buf_string_compare_advance(struct=
 buffer *src, const char *match);</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Return the length of the next token in a buffer up to =
a delimiter=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Scans the buffer co=
ntent for \c delim and returns the number of bytes</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * up to (but not including) the delimiter, =
or the full buffer length if</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * the delimiter is not found=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param buf    The buffer to scan=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param delim  Delimiter byte to search for=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @return Number of bytes before the f=
irst occurrence of \c delim, or -1</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *         if the buffer is empty=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> int buf_substring_le=
n(const struct buffer *buf, int delim);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * Print a string which might be NULL</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Return a printable representation of a string that mi=
ght be NULL=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param str   String=
 to print, or NULL=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return \c s=
tr if non-NULL, otherwise the string \c &quot;[NULL]&quot;=2E</span><br><sp=
an>  */</span><br><span> const char *np(const char *str);</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* character classes =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/** @name Character classes</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  @brief Check or modify str=
ings based on classes of allowed</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *         or forbidden characters=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**@{*/</span><br><span> #define CC_ANY  (1 &lt;&lt; 0)     =
      /**&lt; any character */</span><br><span> #define CC_NULL (1 &lt;&lt;=
 1)           /**&lt; null character \0 */</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#define CC_ALNUM  (1 &lt;&lt; 2)    =
     /**&lt; alphanumeric isalnum() */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#define CC_ALPHA  (1 &lt;&lt; 3)         /**&lt; alphabeti=
c isalpha() */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne CC_ALNUM  (1 &lt;&lt; 2)         /**&lt; alphanumeric \c isalnum() */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CC_ALPHA  (1 &=
lt;&lt; 3)         /**&lt; alphabetic \c isalpha() */</span><br><span> #def=
ine CC_ASCII  (1 &lt;&lt; 4)         /**&lt; ASCII character */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define CC_CNTRL  (1 &lt;&lt; 5) =
        /**&lt; control character iscntrl() */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define CC_DIGIT  (1 &lt;&lt; 6)         /**&lt; d=
igit isdigit() */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine CC_CNTRL  (1 &lt;&lt; 5)         /**&lt; control character \c iscntrl=
() */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CC_DIG=
IT  (1 &lt;&lt; 6)         /**&lt; digit \c isdigit() */</span><br><span> #=
define CC_PRINT  (1 &lt;&lt; 7)         /**&lt; printable (&gt;=3D 32, !=3D=
 127) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_PU=
NCT  (1 &lt;&lt; 8)         /**&lt; punctuation ispunct() */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#define CC_SPACE  (1 &lt;&lt; 9)    =
     /**&lt; whitespace isspace() */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define CC_XDIGIT (1 &lt;&lt; 10)        /**&lt; hex digit i=
sxdigit() */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 CC_PUNCT  (1 &lt;&lt; 8)         /**&lt; punctuation \c ispunct() */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CC_SPACE  (1 &lt;=
&lt; 9)         /**&lt; whitespace \c isspace() */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define CC_XDIGIT (1 &lt;&lt; 10)        /**=
&lt; hex digit \c isxdigit() */</span><br><span> </span><br><span> #define =
CC_BLANK   (1 &lt;&lt; 11)       /**&lt; space or tab */</span><br><span> #=
define CC_NEWLINE (1 &lt;&lt; 12)       /**&lt; newline */</span><br><span>=
@@ -920,8 +1672,27 @@</span><br><span> #define CC_NAME (CC_ALNUM | CC_UNDER=
BAR) /**&lt; alphanumeric plus underscore */</span><br><span> #define CC_CR=
LF (CC_CR | CC_NEWLINE)     /**&lt; carriage return or newline */</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * Test whether a character=
 belongs to one or more character classes=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param c      The character to test=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param flags  Bitmask of \c CC_* character=
 class flags=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true if \c=
 c matches any of the classes specified in \c flags=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> bool char_class(con=
st unsigned char c, const unsigned int flags);</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Test whether all characters in a string sat=
isfy a character class filter=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param str        The null-terminated string to test=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param inclusive  Classes that are pe=
rmitted (characters must match at</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *                   least one of these)=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param exclusive  Classes that are=
 forbidden (characters must not match</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *                   any of these, even if they also matc=
h \c inclusive)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true if=
 every character in \c str is permitted=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span> bool string_class(const char *s=
tr, const unsigned int inclusive, const unsigned int exclusive);</span><br>=
<span> </span><br><span> /**</span><br><span>@@ -968,10 +1739,27 @@</span><=
br><span>  */</span><br><span> const char *string_mod_const(const char *str=
, const unsigned int inclusive,</span><br><span>                           =
   const unsigned int exclusive, const char replace, struct gc_arena *gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**@}*/</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Replace all leading occurre=
nces of a character in a string=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 Scans from the start of \c str and replaces every consecutive \c match</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * character with \c re=
place, stopping at the first character that does not</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * match=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param str      The null-terminated string to modify in place=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param match =
   The character to replace=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param replace  The replacement character=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> void string_rep=
lace_leading(char *str, const char match, const char replace);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/** Return true =
iff str starts with prefix */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Ret=
urn true iff \c str starts with \c prefix=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param str     The string to test=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param prefix  The prefix to look for=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> st=
atic inline bool</span><br><span> strprefix(const char *str, const char *pr=
efix)</span><br><span> {</span><br><span>@@ -1006,6 +1794,16 @@</span><br><=
span>  * Verify that a pointer is correctly aligned</span><br><span>  */</s=
pan><br><span> #ifdef VERIFY_ALIGNMENT</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Assert that the content pointer of \c buf is 4-byte aligned=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Only compiled in when \c VERIFY_ALIGNM=
ENT is defined=2E  Called via the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * \c verify_align_4() macro=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param buf   Buffer whose content pointer is to be checked=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param file  Sourc=
e file of the call site (for the error message)=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param line  Source line of the call site=
 (for the error message)=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ */</span><br><span> void valign4(const struct buffer *buf, const c=
har *file, const int line);</span><br><span> </span><br><span> #define veri=
fy_align_4(ptr) valign4(buf, __FILE__, __LINE__)</span><br><span>@@ -1013,2=
3 +1811,58 @@</span><br><span> #define verify_align_4(ptr)</span><br><span>=
 #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Very basic g=
arbage collection, mostly for routines that return</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * char ptrs to malloced strings=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/** @name Garbage Collection</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  @brief Basic garb=
age collection, mostly for routines that return</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *         char ptrs to malloced strings=2E</sp=
an><br><span>  */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*@{*/</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Move all =
allocations from one garbage collection arena to another=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * After the call \c src is empty and all entries pr=
eviously in \c src are</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * owned by \c dest=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param d=
est  Arena to move allocations into=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param src   Arena to move allocations from (emptied =
on return)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span> void gc_transfer(struct gc_arena *dest, struct gc_arena *src=
);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Free all pla=
in allocations in a garbage collection arena=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Internal implementation called by \c gc_free()=2E  Do not cal=
l directly=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param a  The arena =
whose \c list entries are to be freed=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span> void x_gc_free(struct gc_arena *a=
);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Free all spe=
cially-allocated entries in a garbage collection arena=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Internal implementation called by \c gc_free()=2E  =
Do not call directly=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Invokes the custom free function stored in each \c gc_entry_special=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param a  The arena whose \c l=
ist_special entries are to be freed=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span> void x_gc_freespecial(struct gc_are=
na *a);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return =
true iff the arena contains at least one allocation=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param a  The arena to test=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inline bool</=
span><br><span> gc_defined(struct gc_arena *a)</span><br><span> {</span><br=
><span>     return a-&gt;list !=3D NULL;</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Initialise a garbage collectio=
n arena to an empty state=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m a  The arena to initialise=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span> static inline void</span><br><span> gc_ini=
t(struct gc_arena *a)</span><br><span> {</span><br><span>@@ -1037,12 +1870,=
25 @@</span><br><span>     a-&gt;list_special =3D NULL;</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Detach all allo=
cations from an arena without freeing them=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * After this call the arena is empty=2E  The caller takes respons=
ibility for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * freei=
ng the previously registered allocations=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param a  The arena to detach=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span> static inline void</span><br><s=
pan> gc_detach(struct gc_arena *a)</span><br><span> {</span><br><span>     =
gc_init(a);</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * Allocate and return a new, empty garbage collection arena=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @return An initialised \c gc_a=
rena with empty lists=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ */</span><br><span> static inline struct gc_arena</span><br><span> gc=
_new(void)</span><br><span> {</span><br><span>@@ -1051,6 +1897,14 @@</span>=
<br><span>     return ret;</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Free all allocations in a garbage collection=
 arena=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * Calls \c x_gc_free() and=
 \c x_gc_freespecial() as needed to release all</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * registered memory=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param a  The arena to free=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inline void</spa=
n><br><span> gc_free(struct gc_arena *a)</span><br><span> {</span><br><span=
>@@ -1064,6 +1918,13 @@</span><br><span>     }</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * Free all allocations in =
a garbage collection arena and reinitialise it=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * Equivalent to calling \c gc_free() followed by \c gc_init()=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param a  The arena to reset=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan> static inline void</span><br><span> gc_reset(struct gc_arena *a)</span=
><br><span> {</span><br><span>@@ -1081,58 +1942,139 @@</span><br><span> /* =
1 GB on 32bit systems, they usually can only allocate 2 GB for the</span><b=
r><span>  * whole process=2E</span><br><span>  */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/** Maximum size for a single array allocatio=
n (checked by \c array_mult_safe())=2E */</span><br><span> #define ALLOC_SI=
ZE_MAX (1u &lt;&lt; 30)</span><br><span> #else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/** Maximum size for a single array allocation (=
checked by \c array_mult_safe())=2E */</span><br><span> #define ALLOC_SIZE_=
MAX ((size_t)1 &lt;&lt; 32) /* 4 GB */</span><br><span> #endif</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Allocate memory for a singl=
e object of the given type=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Call=
s \c check_malloc_return() to abort on allocation failure=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param dptr  Pointer variable that receives the =
allocation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram type  Type of the object to allocate=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ */</span><br><span> #define ALLOC_OBJ(dptr, type) =
                                      \</span><br><span>     {             =
                                                  \</span><br><span>       =
  check_malloc_return((dptr) =3D (type *)malloc(sizeof(type))); \</span><br=
><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * A=
llocate and zero-initialise memory for a single object of the given type=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param dptr  Pointer variable tha=
t receives the allocation=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param type  Type of the object to allocate=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> #define ALLOC_O=
BJ_CLEAR(dptr, type)      \</span><br><span>     {                         =
           \</span><br><span>         ALLOC_OBJ(dptr, type);           \</s=
pan><br><span>         memset((dptr), 0, sizeof(type)); \</span><br><span> =
    }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Allocate =
memory for an array of \c n elements of the given type=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Uses \c array_mult_safe() to guard against size ove=
rflow=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Calls \c=
 check_malloc_return() to abort on allocation failure=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param dptr  Pointer variable that receives the allo=
cation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
type  Element type of the array=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param n     Number of elements=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> #define ALLOC_ARRAY(=
dptr, type, n)                                                           \<=
/span><br><span>     {                                                     =
                                   \</span><br><span>         check_malloc_=
return((dptr) =3D (type *)malloc(array_mult_safe(sizeof(type), (n), 0))); \=
</span><br><span>     }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Allocate a garbage-collected array of \c n elements of the given t=
ype=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param dptr  Pointer variab=
le that receives the allocation=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param type  Element type of the array=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param n     Number of elements=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param gc    =
Garbage collection arena to register the allocation with=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> #define ALLOC_=
ARRAY_GC(dptr, type, n, gc)                                               \=
</span><br><span>     {                                                    =
                               \</span><br><span>         (dptr) =3D (type =
*)gc_malloc(array_mult_safe(sizeof(type), (n), 0), false, (gc)); \</span><b=
r><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
Allocate and zero-initialise an array of \c n elements of the given type=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param dptr  Pointer variable tha=
t receives the allocation=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param type  Element type of the array=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param n     Number of elements=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> #d=
efine ALLOC_ARRAY_CLEAR(dptr, type, n)                            \</span><=
br><span>     {                                                            =
   \</span><br><span>         ALLOC_ARRAY(dptr, type, n);                  =
               \</span><br><span>         memset((dptr), 0, (array_mult_saf=
e(sizeof(type), (n), 0))); \</span><br><span>     }</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Allocate and zero-initialise a garbage=
-collected array of \c n elements=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param dptr  Pointer variable that receives the allocation=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param type  Element type o=
f the array=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram n     Number of elements=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param gc    Garbage collection arena to register the alloc=
ation with=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span> #define ALLOC_ARRAY_CLEAR_GC(dptr, type, n, gc)             =
                           \</span><br><span>     {                        =
                                                          \</span><br><span=
>         (dptr) =3D (type *)gc_malloc(array_mult_safe(sizeof(type), (n), 0=
), true, (gc)); \</span><br><span>     }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Allocate and zero-initialise a garbage-collected =
variable-length structure=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Alloc=
ates \c sizeof(type) + \c n * \c sizeof(atype) bytes for a structure</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * that embeds a variable-=
length array of \c atype as its last member=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param dptr   Pointer variable that receives the allocation=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param type   Ty=
pe of the enclosing structure=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param atype  Element type of the variable-length array mem=
ber=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param n  =
    Number of array elements=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param gc     Garbage collection arena to register the alloc=
ation with=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span> #define ALLOC_VAR_ARRAY_CLEAR_GC(dptr, type, atype, n, gc)  =
                                       \</span><br><span>     {            =
                                                                           =
       \</span><br><span>         (dptr) =3D (type *)gc_malloc(array_mult_s=
afe(sizeof(atype), (n), sizeof(type)), true, (gc)); \</span><br><span>     =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Allocate a ga=
rbage-collected object of the given type (uninitialised)=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param dptr  Pointer variable that receives the a=
llocation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am type  Type of the object to allocate=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param gc    Garbage collection arena to register=
 the allocation with=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ */</span><br><span> #define ALLOC_OBJ_GC(dptr, type, gc)              =
             \</span><br><span>     {                                      =
                    \</span><br><span>         (dptr) =3D (type *)gc_malloc=
(sizeof(type), false, (gc)); \</span><br><span>     }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Allocate and zero-initialise a garba=
ge-collected object of the given type=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param dptr  Pointer variable that receives the allocation=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param type  Type of th=
e object to allocate=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param gc    Garbage collection arena to register the allocation wit=
h=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span> #define ALLOC_OBJ_CLEAR_GC(dptr, type, gc)                    \</span=
><br><span>     {                                                         \=
</span><br><span>         (dptr) =3D (type *)gc_malloc(sizeof(type), true, =
(gc)); \</span><br><span>     }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Abort if a memory allocation returned NULL=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param p  Return value from \c malloc() or sim=
ilar; calls \c out_of_memory()</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *           if \c p is NULL=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span> static inline void</span><br><s=
pan> check_malloc_return(void *p)</span><br><span> {</span><br><span>@@ -11=
41,22 +2083,28 @@</span><br><span>         out_of_memory();</span><br><span=
>     }</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/**@}*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* En=
d of GC */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Manage li=
sts of buffers</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** @=
name Buffer Lists</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  @brief Manage lists of buffers</span><br><span>  */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**@{*/</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/** One node in a \c buffer_list linked list=2E */</span><br><span> stru=
ct buffer_entry</span><br><span> {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    struct buffer buf;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    struct buffer_entry *next;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct buffer buf;         /**&lt; The buffer =
stored in this list node=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct buffer_entry *next; /**&lt; Pointer to the next node,=
 or NULL=2E */</span><br><span> };</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/** A singly-linked list of buffers, with=
 head/tail pointers for O(1) push=2E */</span><br><span> struct buffer_list=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  struct buffer_entry *head; /* next item to pop/peek */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    struct buffer_entry *tail; /* last i=
tem pushed */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size=
_t size;               /* current number of entries */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    size_t max_size;           /* maximum =
size list should grow to */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct buffer_entry *head; /**&lt; Next item to pop/peek=2E */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer_en=
try *tail; /**&lt; Last item pushed=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    size_t size;               /**&lt; Current number=
 of entries=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  size_t max_size;           /**&lt; Maximum number of entries allowed=2E *=
/</span><br><span> };</span><br><span> </span><br><span> /**</span><br><spa=
n>@@ -1217,8 +2165,24 @@</span><br><span>  */</span><br><span> struct buffe=
r *buffer_list_peek(struct buffer_list *ol);</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * Advance past \c n bytes in the head buffer, p=
opping it if it becomes empty=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * \=
c n must not exceed the length of the head buffer; passing a larger value</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * triggers an assert=
ion failure=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ol  The list=
 whose head buffer is to be advanced=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param n   Number of bytes to skip in the head buffe=
r=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span> void buffer_list_advance(struct buffer_list *ol, ssize_t n);</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Remove and free the hea=
d buffer of the list=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Does nothi=
ng if \c ol is NULL or empty=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram ol  The list to pop from=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ */</span><br><span> void buffer_list_pop(struct buffer_list *=
ol);</span><br><span> </span><br><span> /**</span><br><span>@@ -1246,6 +221=
0,20 @@</span><br><span>  */</span><br><span> void buffer_list_aggregate_se=
parator(struct buffer_list *bl, const size_t max_len, const char *sep);</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read a file into a=
 buffer list, one buffer per line=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * Opens \c fn for reading and pushes each line into a newly allocated buff=
er</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * list using \c =
fgets()=2E  Lines longer than \c max_line_len - 1 bytes are</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * split across multiple consecutiv=
e buffers=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param fn            =
Path to the file to read=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param max_line_len  Maximum number of bytes (including null ter=
minator)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         =
             read per \c fgets() call=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @return Pointer to the new buffer list, or NULL if the file could no=
t be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         open=
ed or memory allocation failed=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span> struct buffer_list *buffer_list_file(con=
st char *fn, int max_line_len);</span><br><span> </span><br><span> /**</spa=
n><br><span>@@ -1259,5 +2237,7 @@</span><br><span>  * error</span><br><span=
>  */</span><br><span> struct buffer buffer_read_from_file(const char *file=
name, struct gc_arena *gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/**@}*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* E=
nd of Buffer Lists */</span><br><span> </span><br><span> #endif /* BUFFER_H=
 */</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1581?usp=3Demail">change 1581</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1581?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I350ca5b08379e=
de1480b81055d35dd9a33e30cff </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1581 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--UI/YSsAeJpY=--


--===============7515044496086800797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7515044496086800797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7515044496086800797==--

