Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19ECCC2A09B
	for <openvpn-devel@archiver.kernel.org>; Fri,  7 Aug 2026 16:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j1ibU7aXUu/pBipSvEc+0+fpSMCr0hBkVjh6W003aM0=; b=BuMsM2j2nqbvaXCt7VF+7itpi+
	CU2JGH6TxrCiaPXSFcJ1NimfCIES0UR2T3NYuwdAVY33G55HIUODPMv+lHCBcq7X09eB5weViEQr2
	v5psLq0hpIWi5FIUHef0qBQx5zGH/npE6IrYWklXeNSIUVC6rsX1BqBtMaPa2PIFB3MY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsNJ3-0003bS-Ef;
	Fri, 07 Aug 2026 16:20:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsNJ2-0003bI-Gg
 for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 16:20:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=jd//Gpd98Nj591rG/oQMGTZD6G974pQlFAaGDRgKNWw=; b=b5JwDhzBzK3tySaJcCQXe/KWQT
 oXHO7+I7JHkIRr3EkEtJix7w0gPN9L5hSmLs8GBd/xBW7cmzAc6aj3m7XeS69/nEimDRSdVdX2CpS
 WlGpOvq/yVznmBYP3SYMolrRD5yxjJ8HIBpuTs6xDtA0RF6pWCKFEs4FdU1uwWedDCX8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jd//Gpd98Nj591rG/oQMGTZD6G974pQlFAaGDRgKNWw=; b=Y
 m0qlV9C9/7+I+n+nzB8z9Ylmpe14kkgThGHic5JymmYZYuy9SrIM2dYar/0gA57/T1xvbG7Oo45b3
 Ms/CI8y6lO2hZIrS+9jOsqKjuQLgljClyeY2Z3wzCV5vqUl/vvB4G6Ba878y3gy32YZpuB+Rx7QSy
 c3p4e5KM1Pm9kJTE=;
Received: from mail-ed1-f51.google.com ([209.85.208.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsNIv-0005uI-Qn for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 16:20:25 +0000
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6a144c8f01fso2339072a12.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 07 Aug 2026 09:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786119611; x=1786724411; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jd//Gpd98Nj591rG/oQMGTZD6G974pQlFAaGDRgKNWw=;
 b=d7bjJ0D/qpLVfSEUmo6ymdFoIxyg7vWDGWf4aSCfuQjEoJjFNjfVc/43/WUicQGYj2
 yf2QzDPZ/O5iHJ9171Fk9lmYX8R/pKa48YHC6T51WkWZW4q5A3gwmCLOHzrFORQJrRCx
 SVynTuA4h38f5dBtzKSP0IhFlLfAgqR+fC8USbzuCCG0dkJ2jK66wReMfbSTZNzSjMjk
 mRM2C2fdyVKClxKeyDeAeOpcdijfLK1pVdoLqIGcNGeRGwFQqlTNWIynMcahWxQjacQI
 k2/DhgF1nXXP4mhiJUZE+hi2/4AR9aeijv/oolAwcvn+Ya24x8QpsrI8WL/qp67cgnQc
 fn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786119611; x=1786724411;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jd//Gpd98Nj591rG/oQMGTZD6G974pQlFAaGDRgKNWw=;
 b=VRloURSRwaeik2OfvklfLtMBYp8Sbj0Kib4LAry+09hhNWJA4L8sqZEy7U+5aaNpkD
 eYIWmFCQB42rt3+zMzzpnNece0Hh7juBAewRjze8UjyzNTjyVC5jv/raL0TNxMPMqlEf
 cDnBhPJPIaA5wtx3qw52IYZeozTJOi5/+1SokYxMO6CpMtNq+s+gm9FwtD8GRA1/aaFk
 +6Swgw4gBJF99UbbNo0ytJfdw+Y2MtT6AtR2tw/bRyfafDoVpz2h0gvt5tzfPnG6J6Kz
 gXdnhxrlxHdBQB1yUecQoH+vbUqIAMdLvzR7ZrkdK7ZGgrUDa3rOi67tj5lZjqTYkFBW
 tT0Q==
X-Gm-Message-State: AOJu0Yxvkflqr70hx8qTt3aLJllHC9qlzXH3icTB0sH1iIo7Lv3lsbFX
 /sFjSc6Tr8U+ZFR/7NSgykVaTz6lNopmLawbUx5HAe0KfxCoeP+9n9fx+zjhkZV+WxjHYy87WY2
 6L4MGElWmK8jkhuhXdnhLZOSDseAq5eajE6p3MW5fmvcctZctMwBIEVztUDoUlWX8FC0zAcz77/
 RYEuEzVQ==
X-Gm-Gg: AR+sD11o2vTHqQt5JWWLsdqlWsqYnItg3tNwlNOaRyBqXqAMbpbv6+1xJNNotClAPNy
 kX5ryy58sdpp0FziRJNle6Dvy2hf6IfOP+bDh6Ap3TuUjPnQw/U04k9e2S5gS5cEJBJ2nfh/Kw/
 8M8D807wVdlt2+Q7dPcBFpqHQrfZoIzSY1VMVSGsP8KH9BQaTGRsg2e8W+7l5htguNfXpa0XfFq
 d14ds2aw1Zbgu67Y6iFnKE7V7eRDjklsdmiKY+JecLmB+6Tcbj+5nWRI08qsvey0bbs1osvgJTG
 anlgNlpT91N3+RAmB01iwqlrbM84HcFEPNR6jteb1O+/jyboGsfO7jLKz/r/RSJlI4ouCcrUb5p
 SSSU3IykzNde4ybvwJvu0wwvN8A6jTDSCwEncQ3bHWGyd/phokGy2kLBVqYTKIkbOGTjHJuVk/0
 hLht73vpuMU/bjXawhkihqyyaNBV2v6wnjTq4XklYNa+L07xGp//pNaMNrlW+60VbLxd+pmBauU
 ETmcYsqNXd+fvF+xtl2BAitGU9SBpbL2bEVwCQgtC9uX09kVmPpyudKPGc190sJVzvzqEsty2nJ
 VeINU+jqKkDTfNmwEQxj5Mp1UZxYt6SMcozVN+qko+gojpHpgYpPFzsZvrFv7qU=
X-Received: by 2002:a05:600c:468e:b0:499:596b:2e91 with SMTP id
 5b1f17b1804b1-499596b2ebbmr117136875e9.3.1786104848156; 
 Fri, 07 Aug 2026 05:14:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995bdc433bsm63646115e9.1.2026.08.07.05.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 05:14:07 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 7 Aug 2026 12:14:03 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I350ca5b08379ede1480b81055d35dd9a33e30cff
X-Gerrit-Change-Number: 1581
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1581?usp=email>
X-Gerrit-Commit: 5d7e824367219788ad9547e865123dfa2cba76a9
In-Reply-To: <gerrit.1773842036000.I350ca5b08379ede1480b81055d35dd9a33e30cff@gerrit.openvpn.net>
References: <gerrit.1773842036000.I350ca5b08379ede1480b81055d35dd9a33e30cff@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczODQyMDM2MDAwLkkzNTBjYTViMDgzNzllZGUxNDgwYjgxMDU1ZDM1ZGQ5YTMzZTMwY2ZmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c85c22609e0e804ecd5bebe5549c70fc2e36f86d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsNIv-0005uI-Qn
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
Content-Type: multipart/mixed; boundary="===============2862040789276920658=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2862040789276920658==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ccj21uU3UB0="; charset=UTF-8

--ccj21uU3UB0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1581?usp=3Demail

to look at the new patch set (#2)=2E

=

Change subject: doc: add Doxygen documentation to buffer=2Eh
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

doc: add Doxygen document=
ation to buffer=2Eh

Document all previously undocumented elements=2E

Gith=
ub: Fixes #864
Change-Id: I350ca5b08379ede1480b81055d35dd9a33e30cff
Signed-=
off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/buffe=
r=2Eh
1 file changed, 1,026 insertions(+), 63 deletions(-)


  git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/81/1581/2

diff --git =
a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index 22e045c=2E=2E07f3a2=
d 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -20,6=
 +20,15 @@
  *  with this program; if not, see <https://www=2Egnu=2Eorg/lic=
enses/>=2E
  */
 
+/**
+ * @file
+ * @brief Buffer management functions and=
 garbage collection=2E
+ *
+ * This module provides the core \c buffer type=
 used throughout OpenVPN to
+ * hold packet data, as well as a simple memor=
y management system
+ * (\c gc_arena / \c gc_malloc()) and various string/m=
emory utility functions=2E
+ */
+
 #ifndef BUFFER_H
 #define BUFFER_H
 
@@ =
-27,6 +36,7 @@
 #include "error=2Eh"
 #include "integer=2Eh"
 
+/** Maximum=
 allowed size (in bytes) for a single buffer allocation=2E */
 #define BUF_=
SIZE_MAX 1000000
 
 /*
@@ -115,51 +125,213 @@
  */
 struct gc_arena
 {
-   =
 struct gc_entry *list; /**< First element of the linked list of
-         =
                   *   \c gc_entry structures=2E */
-    struct gc_entry_sp=
ecial *list_special;
+    struct gc_entry *list;                 /**< First=
 element of the linked list of
+                                           =
 *   \c gc_entry structures=2E */
+    struct gc_entry_special *list_specia=
l; /**< First element of the linked
+                                      =
      *   list of \c gc_entry_special
+                                    =
        *   structures for allocations
+                                   =
         *   requiring a custom free
+                                     =
       *   function=2E */
 };
 
 
+/** Return a pointer to the start of the=
 buffer content=2E @see buf_bptr() */
 #define BPTR(buf)  (buf_bptr(buf))
+=
/** Return a pointer one past the end of the buffer content=2E @see buf_ben=
d() */
 #define BEND(buf)  (buf_bend(buf))
+/** Return a pointer to the las=
t byte of the buffer content, or NULL if empty=2E @see buf_blast() */
 #def=
ine BLAST(buf) (buf_blast(buf))
+/** Return the length of the buffer conten=
t in bytes=2E @see buf_len() */
 #define BLEN(buf)  (buf_len(buf))
+/** Ret=
urn the length of the buffer content as a \c size_t=2E @see buf_len() */
 #=
define BLENZ(buf) ((size_t)buf_len(buf))
+/** Return true iff the buffer is=
 defined (has non-NULL data pointer)=2E @see buf_defined() */
 #define BDEF=
(buf)  (buf_defined(buf))
+/** Return the buffer content pointer cast to \c=
 char *=2E @see buf_str() */
 #define BSTR(buf)  (buf_str(buf))
+/** Return=
 the number of bytes available for appending to the buffer=2E @see buf_forw=
ard_capacity() */
 #define BCAP(buf)  (buf_forward_capacity(buf))
 
+/**
+ =
* Zeroise and reset a buffer=2E
+ *
+ * Sets all allocated memory to zero a=
nd resets \c offset and \c len to zero,
+ * but does not free the underlyin=
g memory=2E
+ *
+ * @param buf   The buffer to clear=2E
+ */
 void buf_clea=
r(struct buffer *buf);
 
+/**
+ * Free the memory allocated for a buffer=2E=

+ *
+ * Frees \c buf->data and resets the buffer to an undefined state=2E
=
+ *
+ * @param buf   The buffer whose memory is to be freed=2E
+ */
 void f=
ree_buf(struct buffer *buf);
 
+/**
+ * Assign the content of one buffer to=
 another=2E
+ *
+ * Copies the content of \c src into \c dest=2E  The desti=
nation buffer must
+ * already be allocated with sufficient capacity=2E
+ *=

+ * @param dest  Destination buffer to write into=2E
+ * @param src   Sour=
ce buffer to read from=2E
+ *
+ * @return true on success, false if \c dest=
 has insufficient capacity=2E
+ */
 bool buf_assign(struct buffer *dest, co=
nst struct buffer *src);
 
+/**
+ * Securely clear a null-terminated string=
=2E
+ *
+ * Overwrites all characters of \c str with zeroes=2E
+ *
+ * @par=
am str   The string to clear=2E
+ */
 void string_clear(char *str);
 
+/**
=
+ * Return the number of elements in a NULL-terminated array of strings=2E
=
+ *
+ * @param array     NULL-terminated array of string pointers=2E
+ *
+ =
* @return Number of non-NULL elements=2E
+ */
 int string_array_len(const c=
har **array);
 
+/**
+ * Safely compute the product of two sizes plus an ex=
tra amount=2E
+ *
+ * Each of \c m1, \c m2, and \c extra, as well as the fi=
nal result, are
+ * checked against \c ALLOC_SIZE_MAX=2E  If any value exce=
eds the limit the
+ * function calls \c msg(M_FATAL) and does not return=2E=

+ *
+ * @param m1    First multiplicand=2E
+ * @param m2    Second multipl=
icand=2E
+ * @param extra Value to add to the product=2E
+ *
+ * @return \c=
 m1 * \c m2 + \c extra=2E
+ */
 size_t array_mult_safe(const size_t m1, con=
st size_t m2, const size_t extra);
 
+/** Flag for print_argv(): wrap each =
argument in square brackets=2E */
 #define PA_BRACKET (1 << 0)
+/**
+ * For=
mat a NULL-terminated argument vector as a single string=2E
+ *
+ * @param =
p     NULL-terminated array of string pointers to format=2E
+ * @param gc  =
  Garbage collection arena for the returned string=2E
+ * @param flags Form=
atting flags (e=2Eg=2E \c PA_BRACKET)=2E
+ *
+ * @return Newly allocated st=
ring representation of \c p=2E
+ */
 char *print_argv(const char **p, struc=
t gc_arena *gc, const unsigned int flags);
 
+/**
+ * Report a buffer size =
error and abort=2E
+ *
+ * Called when a requested buffer size exceeds \c B=
UF_SIZE_MAX or is otherwise
+ * invalid=2E  Calls \c msg(M_FATAL) and does =
not return=2E
+ *
+ * @param size  The invalid size that was requested=2E
+=
 */
 void buf_size_error(const size_t size);
 
+/**
+ * Allocate a buffer o=
f the given size=2E
+ *
+ * Calls \c out_of_memory() if the allocation fail=
s=2E The caller is responsible
+ * for freeing the memory=2E
+ *
+ * @param=
 size  Number of bytes to allocate=2E
+ *
+ * @return Newly allocated buffe=
r of capacity \c size=2E
+ */
 struct buffer alloc_buf(size_t size);
 
-str=
uct buffer alloc_buf_gc(size_t size,
-                           struct gc_=
arena *gc); /* allocate buffer with garbage collection */
+/**
+ * Allocate=
 a buffer of the given size under garbage collection=2E
+ *
+ * The allocat=
ed memory is registered with \c gc so that it is freed when
+ * \c gc_free(=
) is called on the arena=2E  Calls \c out_of_memory() if the
+ * allocation=
 fails=2E
+ *
+ * @param size  Number of bytes to allocate=2E
+ * @param gc=
    Garbage collection arena to register the allocation with=2E
+ *
+ * @re=
turn Newly allocated buffer of capacity \c size=2E
+ */
+struct buffer allo=
c_buf_gc(size_t size, struct gc_arena *gc);
 
+/**
+ * Duplicate a buffer, =
including its content=2E
+ *
+ * Allocates a new buffer with the same capac=
ity as \c buf and copies its
+ * content=2E  Calls \c out_of_memory() if th=
e allocation fails=2E
+ *
+ * @param buf   The buffer to duplicate=2E
+ *
+=
 * @return A newly allocated copy of \c buf=2E
+ */
 struct buffer clone_bu=
f(const struct buffer *buf);
 
+/**
+ * Allocate memory and, optionally, ze=
ro it=2E
+ *
+ * The allocation is registered with \c a so that it is freed=
 when
+ * \c gc_free() is called on the arena=2E  Calls \c out_of_memory() =
if the
+ * allocation fails=2E
+ *
+ * @param size  Number of bytes to allo=
cate=2E
+ * @param clear If true, zeroise the allocated memory before retur=
ning=2E
+ * @param a     Garbage collection arena to register the allocatio=
n with=2E
+ *
+ * @return Pointer to the newly allocated memory=2E
+ */
 vo=
id *gc_malloc(size_t size, bool clear, struct gc_arena *a);
 
+/**
+ * Dupl=
icate a string, allocating memory under garbage collection=2E
+ *
+ * @para=
m str   The string to duplicate=2E  May be NULL, in which case NULL
+ *    =
          is returned=2E
+ * @param gc    Garbage collection arena for the =
returned string, or NULL
+ *              to use plain \c malloc()=2E
+ *
+=
 * @return A newly allocated copy of \c str, or NULL if \c str is NULL=2E
+=
 */
 char *string_alloc(const char *str, struct gc_arena *gc);
 
+/**
+ * A=
llocate a buffer containing a copy of the given string=2E
+ *
+ * Wraps \c =
string_alloc(), so \c gc may be NULL (plain \c malloc() is used
+ * in that=
 case)=2E  The buffer \c len reflects the string length, excluding
+ * the =
null terminator, even though the terminator is present in the
+ * allocated=
 memory=2E
+ *
+ * @param str   The string to copy into the buffer=2E  Must=
 not be NULL=2E
+ * @param gc    Garbage collection arena for the allocatio=
n, or NULL=2E
+ *
+ * @return A buffer whose content is a copy of \c str=2E=

+ */
 struct buffer string_alloc_buf(const char *str, struct gc_arena *gc)=
;
 
+/**
+ * Register an address with a custom free function in a garbage c=
ollection
+ * arena=2E
+ *
+ * When \c gc_free() is called on \c a, \c free=
_function(addr) will be
+ * invoked to release the memory=2E  Use this for =
allocations that require
+ * something other than plain \c free(), such as =
\c freeaddrinfo()=2E
+ *
+ * @param addr          Pointer to the memory to =
register=2E
+ * @param free_function Function to call to free \c addr=2E
+ =
* @param a             Garbage collection arena to register with=2E
+ */
 v=
oid gc_addspecial(void *addr, void (*free_function)(void *), struct gc_aren=
a *a);
 
 /**
@@ -177,6 +349,7 @@
 
 #ifdef BUF_INIT_TRACKING
 #define buf_=
init(buf, offset) buf_init_debug(buf, offset, __FILE__, __LINE__)
+/** Debu=
g variant of \c buf_init_dowork() that records the call site for alignment =
verification=2E */
 bool buf_init_debug(struct buffer *buf, int offset, con=
st char *file, int line);
 
 #else
@@ -185,31 +358,62 @@
 
 
 /* inline fun=
ctions */
+
+/**
+ * Callback to free a \c struct \c addrinfo, suitable for=
 use with
+ * \c gc_addspecial()=2E
+ *
+ * @param addr  Pointer to the \c =
struct \c addrinfo to free=2E
+ */
 static inline void
 gc_freeaddrinfo_cal=
lback(void *addr)
 {
     freeaddrinfo((struct addrinfo *)addr);
 }
 
-/** =
Return an empty struct buffer */
+/** Return an empty, undefined \c struct =
\c buffer (all fields zero)=2E */
 static inline struct buffer
 clear_buf(v=
oid)
 {
     return (struct buffer){ 0 };
 }
 
+/**
+ * Return true iff \c =
buf has a non-NULL data pointer=2E
+ *
+ * A defined buffer has been alloca=
ted but may have zero length or negative
+ * len (i=2Ee=2E it is not necess=
arily valid)=2E
+ *
+ * @param buf   The buffer to test=2E
+ */
 static inl=
ine bool
 buf_defined(const struct buffer *buf)
 {
     return buf->data !=
=3D NULL;
 }
 
+/**
+ * Return true iff \c buf is valid=2E
+ *
+ * A buffer=
 is valid when its data pointer is non-NULL and its \c len is
+ * non-negat=
ive=2E
+ *
+ * @param buf   The buffer to test=2E
+ */
 static inline bool
=
 buf_valid(const struct buffer *buf)
 {
     return likely(buf->data !=3D N=
ULL) && likely(buf->len >=3D 0);
 }
 
+/**
+ * Return a pointer to the star=
t of the buffer content=2E
+ *
+ * @param buf   The buffer to query=2E
+ *
=
+ * @return Pointer to \c buf->data + \c buf->offset, or NULL if \c buf is
=
+ *         not valid=2E
+ */
 static inline uint8_t *
 buf_bptr(const stru=
ct buffer *buf)
 {
@@ -223,6 +427,13 @@
     }
 }
 
+/**
+ * Return the len=
gth of the buffer content=2E
+ *
+ * @param buf   The buffer to query=2E
+ =
*
+ * @return \c buf->len if \c buf is valid, otherwise 0=2E
+ */
 static i=
nt
 buf_len(const struct buffer *buf)
 {
@@ -236,12 +447,27 @@
     }
 }
 
=
+/**
+ * Return a pointer one past the end of the buffer content=2E
+ *
+ *=
 @param buf   The buffer to query=2E
+ *
+ * @return Pointer to the byte im=
mediately after the last content byte=2E
+ */
 static inline uint8_t *
 buf=
_bend(const struct buffer *buf)
 {
     return buf_bptr(buf) + buf_len(buf)=
;
 }
 
+/**
+ * Return a pointer to the last byte of the buffer content=2E
=
+ *
+ * @param buf   The buffer to query=2E
+ *
+ * @return Pointer to the =
last byte, or NULL if the buffer is empty or
+ *         invalid=2E
+ */
 s=
tatic inline uint8_t *
 buf_blast(const struct buffer *buf)
 {
@@ -255,24 +=
481,56 @@
     }
 }
 
+/**
+ * Return true iff \c size is within the allowe=
d buffer size range=2E
+ *
+ * @param size  The size to check=2E
+ *
+ * @r=
eturn true if \c size < \c BUF_SIZE_MAX=2E
+ */
 static inline bool
 buf_si=
ze_valid(const size_t size)
 {
     return likely(size < BUF_SIZE_MAX);
 }
=
 
+/**
+ * Return true iff a signed \c size is within the allowed buffer si=
ze range=2E
+ *
+ * Accepts negative values (used for bidirectional length =
adjustments) as
+ * long as the absolute value is below \c BUF_SIZE_MAX=2E
=
+ *
+ * @param size  The signed size to check=2E
+ *
+ * @return true if \c=
 -BUF_SIZE_MAX <=3D size < \c BUF_SIZE_MAX=2E
+ */
 static inline bool
 buf=
_size_valid_signed(const int size)
 {
     return likely(size >=3D -BUF_SIZ=
E_MAX) && likely(size < BUF_SIZE_MAX);
 }
 
+/**
+ * Return the buffer cont=
ent pointer cast to \c char *=2E
+ *
+ * @param buf   The buffer to query=
=2E
+ *
+ * @return The content pointer as a \c char *, or NULL if \c buf i=
s invalid=2E
+ */
 static inline char *
 buf_str(const struct buffer *buf)
=
 {
     return (char *)buf_bptr(buf);
 }
 
+/**
+ * Reset a buffer to an un=
defined (unallocated) state=2E
+ *
+ * Sets all fields to zero/NULL without=
 freeing any memory=2E  Use \c free_buf()
+ * first if the buffer owns allo=
cated memory=2E
+ *
+ * @param buf   The buffer to reset=2E
+ */
 static in=
line void
 buf_reset(struct buffer *buf)
 {
@@ -282,6 +540,14 @@
     buf->=
data =3D NULL;
 }
 
+/**
+ * Reset the length and offset of a buffer to zer=
o=2E
+ *
+ * The underlying allocation is preserved and \c capacity is unch=
anged=2E
+ * Equivalent to rewinding the buffer to the beginning for fresh =
writing=2E
+ *
+ * @param buf   The buffer to reset=2E
+ */
 static inline =
void
 buf_reset_len(struct buffer *buf)
 {
@@ -289,6 +555,18 @@
     buf->o=
ffset =3D 0;
 }
 
+/**
+ * Initialise a buffer with a given initial offset=
=2E
+ *
+ * Sets \c buf->len to zero and \c buf->offset to \c offset=2E  Th=
e buffer must
+ * already be allocated=2E  Returns false (without modifying=
 \c buf) if \c offset
+ * is negative, exceeds the buffer capacity, or the =
data pointer is NULL=2E
+ *
+ * @param buf     The buffer to initialise=2E
=
+ * @param offset  Initial byte offset from the start of the allocated memo=
ry=2E
+ *
+ * @return true on success, false if the parameters are invalid=
=2E
+ */
 static inline bool
 buf_init_dowork(struct buffer *buf, int offse=
t)
 {
@@ -301,6 +579,17 @@
     return true;
 }
 
+/**
+ * Initialise a buf=
fer with an externally provided writable memory region=2E
+ *
+ * Sets up \=
c buf to use \c data as its backing store for writing=2E  The first
+ * byt=
e of \c data is set to zero=2E  Calls \c buf_size_error() (which does not
+=
 * return) if \c size exceeds \c BUF_SIZE_MAX=2E
+ *
+ * @param buf   The b=
uffer to initialise=2E
+ * @param data  Pointer to the memory region to use=
=2E
+ * @param size  Size of the memory region in bytes=2E
+ */
 static inl=
ine void
 buf_set_write(struct buffer *buf, uint8_t *data, int size)
 {
@@ =
-318,6 +607,18 @@
     }
 }
 
+/**
+ * Initialise a buffer with an external=
ly provided read-only memory region=2E
+ *
+ * Sets up \c buf so that the e=
ntire \c data region is the buffer content
+ * (offset is 0, len and capaci=
ty are both set to \c size)=2E  The data pointer
+ * is cast away from cons=
t=2E  Calls \c buf_size_error() (which does not return)
+ * if \c size exce=
eds \c BUF_SIZE_MAX=2E
+ *
+ * @param buf   The buffer to initialise=2E
+ *=
 @param data  Pointer to the read-only memory region=2E
+ * @param size  Si=
ze of the memory region in bytes=2E
+ */
 static inline void
 buf_set_read(=
struct buffer *buf, const uint8_t *data, size_t size)
 {
@@ -330,7 +631,17 =
@@
     buf->data =3D (uint8_t *)data;
 }
 
-/* Like strncpy but makes sure=
 dest is always null terminated */
+/**
+ * Like \c strncpy() but always nu=
ll-terminates the destination=2E
+ *
+ * Copies at most \c maxlen - 1 chara=
cters from \c src into \c dest and
+ * writes a null terminator at \c dest[=
\c maxlen - 1]=2E  Does nothing if
+ * \c maxlen is zero=2E
+ *
+ * @param =
dest    Destination buffer=2E
+ * @param src     Source string=2E
+ * @para=
m maxlen  Size of the destination buffer in bytes=2E
+ */
 static inline vo=
id
 strncpynt(char *dest, const char *src, size_t maxlen)
 {
@@ -341,7 +652=
,13 @@
     }
 }
 
-/* return true if string contains at least one numerica=
l digit */
+/**
+ * Return true if the string contains at least one decimal=
 digit=2E
+ *
+ * @param src   The null-terminated string to scan=2E
+ *
+ =
* @return true if any character in \c src satisfies \c isdigit()=2E
+ */
 s=
tatic inline bool
 has_digit(const char *src)
 {
@@ -401,11 +718,20 @@
 #en=
dif
 }
 
-/*
- * printf append to a buffer with overflow check,
- * due to =
usage of vsnprintf, it will leave space for
- * a final null character and =
thus use only
- * capacity - 1
+/**
+ * printf-style append to a buffer wit=
h overflow check=2E
+ *
+ * Formats a string and appends it to \c buf=2E  D=
ue to the use of
+ * \c vsnprintf(), one byte of forward capacity is reserv=
ed for a null
+ * terminator, so at most \c buf_forward_capacity(buf) - 1 b=
ytes of
+ * formatted output are written=2E
+ *
+ * @param buf     The buff=
er to append to=2E
+ * @param format  printf-style format string=2E
+ * @pa=
ram =2E=2E=2E     Format arguments=2E
+ *
+ * @return true if the entire fo=
rmatted string fit in the buffer, false if
+ *         it was truncated=2E
=
  */
 bool buf_printf(struct buffer *buf, const char *format, =2E=2E=2E)
 #=
ifdef __GNUC__
@@ -417,8 +743,13 @@
 #endif
     ;
 
-/*
- * puts append to=
 a buffer with overflow check
+/**
+ * Append a string to a buffer with ove=
rflow check=2E
+ *
+ * @param buf   The buffer to append to=2E
+ * @param s=
tr   The null-terminated string to append=2E
+ *
+ * @return true if the st=
ring fit in the buffer, false if it was truncated=2E
  */
 bool buf_puts(st=
ruct buffer *buf, const char *str);
 
@@ -427,22 +758,76 @@
  * remove/add =
trailing characters
  */
 
+/**
+ * Force a null terminator at the end of t=
he buffer content=2E
+ *
+ * If there is free capacity, a '\\0' byte is app=
ended=2E  If the buffer is
+ * full, the last content byte is overwritten w=
ith '\\0' (i=2Ee=2E the last
+ * character is truncated to make room)=2E  T=
he function has no effect on an
+ * empty or invalid buffer=2E
+ *
+ * @par=
am buf   The buffer to null-terminate=2E
+ */
 void buf_null_terminate(stru=
ct buffer *buf);
 
+/**
+ * Remove trailing newline and carriage-return cha=
racters from a buffer=2E
+ *
+ * @param buf   The buffer to chomp=2E
+ */
 =
void buf_chomp(struct buffer *buf);
 
+/**
+ * Remove all occurrences of a =
specific byte from the end of a buffer=2E
+ *
+ * @param buf     The buffer=
 to modify=2E
+ * @param remove  The byte value to strip from the tail=2E
+=
 */
 void buf_rmtail(struct buffer *buf, uint8_t remove);
 
-/*
- * non-buf=
fer string functions
+/** @name String Utility Functions
+ *  @brief Non-bu=
ffer string functions
+ */
+/**@{*/
+
+/**
+ * Remove trailing newline and =
carriage-return characters from a string=2E
+ *
+ * @param str   The null-t=
erminated string to chomp=2E
  */
 void chomp(char *str);
 
+/**
+ * Remove=
 all trailing characters that appear in a given set=2E
+ *
+ * @param str  =
           The null-terminated string to modify in place=2E
+ * @param what=
_to_delete  Null-terminated set of characters to strip=2E
+ */
 void rm_tra=
iling_chars(char *str, const char *what_to_delete);
 
+/**
+ * Return a poi=
nter past any leading whitespace in a string=2E
+ *
+ * @param str   The st=
ring to skip whitespace in=2E
+ *
+ * @return Pointer to the first non-whit=
espace character, or to the null
+ *         terminator if \c str is all wh=
itespace=2E
+ */
 const char *skip_leading_whitespace(const char *str);
 
+=
/**
+ * Null-terminate a fixed-length string buffer=2E
+ *
+ * Ensures that=
 \c str[\c len] is '\\0', clamping \c len to \c capacity - 1
+ * if necessa=
ry=2E
+ *
+ * @param str       The character buffer to null-terminate=2E
+ =
* @param len       Current string length=2E
+ * @param capacity  Total size=
 of the character buffer in bytes=2E
+ */
 void string_null_terminate(char =
*str, int len, int capacity);
+/**@}*/
+/* End of string utility functions =
*/
 
 /**
  * Write buffer contents to file=2E
@@ -454,40 +839,114 @@
  */
=
 bool buffer_write_file(const char *filename, const struct buffer *buf);
 
=
-/*
- * write a string to the end of a buffer that was
- * truncated by buf=
_printf
+/**
+ * Append a string to the physical end of a buffer that was t=
runcated by
+ * \c buf_printf()=2E
+ *
+ * If the buffer's forward capacity=
 is one byte or less (i=2Ee=2E it is full),
+ * \c str is written at the ve=
ry end of the allocated memory to act as a
+ * truncation marker, provided =
it fits within the total buffer capacity=2E
+ * This is used to append a "[=
more=2E=2E=2E]" suffix after hex-dump truncation=2E
+ *
+ * @param buf   Th=
e buffer to append the truncation marker to=2E
+ * @param str   The null-te=
rminated marker string to write=2E
  */
 void buf_catrunc(struct buffer *bu=
f, const char *str);
 
-/*
- * Parse a string based on a given delimiter ch=
ar
+/**
+ * Extract the next token from a buffer, delimited by a given char=
acter=2E
+ *
+ * Reads bytes from \c buf one at a time until \c delim or en=
d-of-buffer is
+ * encountered=2E  The token (without the delimiter) is wri=
tten into \c line,
+ * which is always null-terminated=2E  The delimiter by=
te is consumed from
+ * \c buf but not included in \c line=2E
+ *
+ * @para=
m buf    Source buffer to parse=2E  The consumed portion is advanced=2E
+ *=
 @param delim  Delimiter character=2E
+ * @param line   Output buffer for t=
he extracted token=2E
+ * @param size   Size of \c line in bytes (must be >=
 0)=2E
+ *
+ * @return false only when end-of-buffer is reached and no char=
acters were
+ *         extracted; true otherwise (including when a delimit=
er was found
+ *         or \c line was truncated)=2E
  */
 bool buf_parse(=
struct buffer *buf, const int delim, char *line, const int size);
 
-/*
- *=
 Hex dump -- Output a binary buffer to a hex string and return it=2E
+/** @=
name Hex Dump
+ *  @brief Output a binary buffer to a hex string and return=
 it=2E
  */
-#define FHE_SPACE_BREAK_MASK 0xFF  /* space_break parameter in=
 lower 8 bits */
-#define FHE_CAPS             0x100 /* output hex in caps =
*/
+/**@{*/
+
+/** Mask for the space_break_flags field of \c format_hex_ex=
(): number of
+ *  bytes between separators (lower 8 bits)=2E */
+#define F=
HE_SPACE_BREAK_MASK 0xFF
+/** Flag for \c format_hex_ex(): output hex digit=
s in upper case=2E */
+#define FHE_CAPS             0x100
+/**
+ * Format a=
 binary buffer as a hex string=2E
+ *
+ * @param data              Pointer =
to the binary data to format=2E
+ * @param size              Number of byte=
s to format=2E
+ * @param maxoutput         Maximum number of output charac=
ters (0 =3D unlimited)=2E
+ *                          If the output is tru=
ncated, a "[more=2E=2E=2E]" suffix is
+ *                          appended=
 via \c buf_catrunc()=2E
+ * @param space_break_flags Lower 8 bits (\c FHE_=
SPACE_BREAK_MASK) give the
+ *                          number of bytes bet=
ween \c separator insertions=2E
+ *                          Use \c FHE_CAP=
S to output upper-case hex digits=2E
+ * @param separator         String to=
 insert between groups of bytes=2E
+ * @param gc                Garbage col=
lection arena for the returned string=2E
+ *
+ * @return Null-terminated he=
x string allocated from \c gc=2E
+ */
 char *format_hex_ex(const uint8_t *d=
ata, size_t size, size_t maxoutput, unsigned int space_break_flags,
       =
              const char *separator, struct gc_arena *gc);
 
+/**
+ * Forma=
t a binary buffer as a hex string with spaces every 4 bytes=2E
+ *
+ * Conv=
enience wrapper around \c format_hex_ex()=2E
+ *
+ * @param data       Poin=
ter to the binary data to format=2E
+ * @param size       Number of bytes t=
o format=2E
+ * @param maxoutput  Maximum number of output characters (0 =
=3D unlimited)=2E
+ * @param gc         Garbage collection arena for the re=
turned string=2E
+ *
+ * @return Null-terminated hex string allocated from =
\c gc=2E
+ */
 static inline char *
 format_hex(const uint8_t *data, size_t=
 size, size_t maxoutput, struct gc_arena *gc)
 {
     return format_hex_ex(=
data, size, maxoutput, 4, " ", gc);
 }
+/**@}*/
+/* End of Hex Dump */
 
-/=
*
- * Return a buffer that is a subset of another buffer=2E
+/**
+ * Return=
 a sub-buffer of another buffer=2E
+ *
+ * Either allocates \c size bytes f=
rom the front or back of \c buf,
+ * shrinking \c buf accordingly, and retu=
rns a buffer pointing into the
+ * same memory=2E
+ *
+ * @param buf      S=
ource buffer to carve the sub-buffer from=2E
+ * @param size     Number of =
bytes to include in the sub-buffer=2E
+ * @param prepend  If true, take byt=
es from the front of \c buf (prepend
+ *                 space); if false, =
take bytes from the end (append space)=2E
+ *
+ * @return A buffer referenc=
ing the allocated region, or an undefined buffer
+ *         if \c buf has =
insufficient capacity=2E
  */
 struct buffer buf_sub(struct buffer *buf, in=
t size, bool prepend);
 
-/*
- * Check if sufficient space to append to buf=
fer=2E
+/**
+ * Check whether \c len bytes can be appended to a buffer=2E
+=
 *
+ * @param buf   The buffer to check=2E
+ * @param len   Number of bytes=
 to append=2E
+ *
+ * @return true if \c buf is valid, \c len is within the=
 allowed range, and
+ *         there is sufficient capacity after the curr=
ent content=2E
  */
-
 static inline bool
 buf_safe(const struct buffer *bu=
f, size_t len)
 {
@@ -495,6 +954,18 @@
            && buf->offset + buf->le=
n + (int)len <=3D buf->capacity;
 }
 
+/**
+ * Check whether \c len bytes c=
an be added to or removed from a buffer=2E
+ *
+ * Accepts negative \c len =
to verify that bytes can be removed (length
+ * decreased)=2E
+ *
+ * @para=
m buf   The buffer to check=2E
+ * @param len   Number of bytes to add (pos=
itive) or remove (negative)=2E
+ *
+ * @return true if the resulting length=
 would remain non-negative and within
+ *         the allocated capacity=2E=

+ */
 static inline bool
 buf_safe_bidir(const struct buffer *buf, int len=
)
 {
@@ -509,6 +980,17 @@
     }
 }
 
+/**
+ * Return the number of bytes t=
hat can still be appended to the buffer=2E
+ *
+ * This is the space betwee=
n the end of the current content and the end of
+ * the allocated memory=2E=

+ *
+ * @param buf   The buffer to query=2E
+ *
+ * @return Number of byte=
s available for appending, or 0 if \c buf is
+ *         invalid=2E
+ */
 s=
tatic inline int
 buf_forward_capacity(const struct buffer *buf)
 {
@@ -527=
,6 +1009,17 @@
     }
 }
 
+/**
+ * Return the total number of bytes availa=
ble from the current offset to the
+ * end of the allocated memory=2E
+ *
+=
 * Unlike \c buf_forward_capacity(), this includes the bytes already occupi=
ed
+ * by the current content=2E
+ *
+ * @param buf   The buffer to query=
=2E
+ *
+ * @return Capacity minus offset, or 0 if \c buf is invalid=2E
+ *=
/
 static inline int
 buf_forward_capacity_total(const struct buffer *buf)
=
 {
@@ -545,6 +1038,16 @@
     }
 }
 
+/**
+ * Return the number of bytes av=
ailable for prepending to the buffer=2E
+ *
+ * This is the number of bytes=
 between the start of the allocated memory and
+ * the current content star=
t (i=2Ee=2E \c buf->offset)=2E
+ *
+ * @param buf   The buffer to query=2E
=
+ *
+ * @return \c buf->offset, or 0 if \c buf is invalid=2E
+ */
 static i=
nline int
 buf_reverse_capacity(const struct buffer *buf)
 {
@@ -558,6 +106=
1,17 @@
     }
 }
 
+/**
+ * Increase or decrease the length of a buffer=2E=

+ *
+ * Adjusts \c buf->len by \c inc bytes=2E  A negative \c inc shrinks =
the
+ * buffer=2E  The operation is bounds-checked via \c buf_safe_bidir()=
=2E
+ *
+ * @param buf   The buffer to modify=2E
+ * @param inc   Number of=
 bytes to add to the length (may be negative)=2E
+ *
+ * @return true on su=
ccess, false if the adjustment would violate bounds=2E
+ */
 static inline =
bool
 buf_inc_len(struct buffer *buf, int inc)
 {
@@ -569,11 +1083,18 @@
  =
   return true;
 }
 
-/*
- * Make space to prepend to a buffer=2E
- * Retur=
n NULL if no space=2E
+/**
+ * Make space at the front of a buffer for prep=
ending data=2E
+ *
+ * Moves the content start backwards by \c size bytes, =
increasing \c len
+ * and decreasing \c offset by the same amount=2E
+ *
+ =
* @param buf   The buffer to modify=2E
+ * @param size  Number of bytes to =
reserve for prepending=2E
+ *
+ * @return Pointer to the newly reserved spa=
ce (new content start), or NULL
+ *         if \c buf is invalid or there i=
s insufficient prepend capacity=2E
  */
-
 static inline uint8_t *
 buf_pre=
pend(struct buffer *buf, ssize_t size)
 {
@@ -586,6 +1107,17 @@
     return=
 BPTR(buf);
 }
 
+/**
+ * Advance the content start of a buffer, consuming =
bytes from the front=2E
+ *
+ * Increases \c offset and decreases \c len by=
 \c size bytes=2E
+ *
+ * @param buf   The buffer to advance=2E
+ * @param =
size  Number of bytes to skip=2E
+ *
+ * @return true on success, false if =
\c buf is invalid or \c size exceeds
+ *         the current length=2E
+ */=

 static inline bool
 buf_advance(struct buffer *buf, ssize_t size)
 {
@@ -=
598,11 +1130,18 @@
     return true;
 }
 
-/*
- * Return a pointer to alloc=
ated space inside a buffer=2E
- * Return NULL if no space=2E
+/**
+ * Reser=
ve space at the end of a buffer for writing=2E
+ *
+ * Increases \c buf->le=
n by \c size and returns a pointer to the start of
+ * the newly reserved r=
egion=2E
+ *
+ * @param buf   The buffer to allocate space in=2E
+ * @param=
 size  Number of bytes to reserve=2E
+ *
+ * @return Pointer to the start o=
f the reserved space, or NULL if there is
+ *         insufficient capacity=
=2E
  */
-
 static inline uint8_t *
 buf_write_alloc(struct buffer *buf, si=
ze_t size)
 {
@@ -616,6 +1155,18 @@
     return ret;
 }
 
+/**
+ * Consume =
bytes from the front of a buffer for reading=2E
+ *
+ * Returns a pointer t=
o the current content start and advances the buffer
+ * by \c size bytes=2E=

+ *
+ * @param buf   The buffer to read from=2E
+ * @param size  Number of=
 bytes to consume=2E
+ *
+ * @return Pointer to the start of the consumed r=
egion, or NULL if \c size
+ *         is negative or exceeds the current le=
ngth=2E
+ */
 static inline uint8_t *
 buf_read_alloc(struct buffer *buf, i=
nt size)
 {
@@ -630,6 +1181,17 @@
     return ret;
 }
 
+/**
+ * Append dat=
a to a buffer=2E
+ *
+ * Copies \c size bytes from \c src to the end of \c =
dest=2E
+ *
+ * @param dest  Destination buffer=2E
+ * @param src   Data to=
 append=2E
+ * @param size  Number of bytes to append=2E
+ *
+ * @return tr=
ue on success, false if there is insufficient capacity=2E
+ */
 static inli=
ne bool
 buf_write(struct buffer *dest, const void *src, size_t size)
 {
@@=
 -642,6 +1204,18 @@
     return true;
 }
 
+/**
+ * Prepend data to a buffe=
r=2E
+ *
+ * Copies \c size bytes from \c src into the prepend space at the=
 front of
+ * \c dest=2E
+ *
+ * @param dest  Destination buffer=2E
+ * @pa=
ram src   Data to prepend=2E
+ * @param size  Number of bytes to prepend=2E=

+ *
+ * @return true on success, false if there is insufficient prepend ca=
pacity=2E
+ */
 static inline bool
 buf_write_prepend(struct buffer *dest, =
const void *src, int size)
 {
@@ -654,12 +1228,28 @@
     return true;
 }
 =

+/**
+ * Append a uint8_t to a buffer=2E
+ *
+ * @param dest  Destination =
buffer=2E
+ * @param data  Byte to append=2E
+ *
+ * @return true on succes=
s, false if there is insufficient capacity=2E
+ */
 static inline bool
 buf=
_write_u8(struct buffer *dest, uint8_t data)
 {
     return buf_write(dest,=
 &data, sizeof(uint8_t));
 }
 
+/**
+ * Append a uint16_t to a buffer in ne=
twork byte order=2E
+ *
+ * @param dest  Destination buffer=2E
+ * @param d=
ata  Value to append (converted with \c htons())=2E
+ *
+ * @return true on=
 success, false if there is insufficient capacity=2E
+ */
 static inline bo=
ol
 buf_write_u16(struct buffer *dest, uint16_t data)
 {
@@ -667,6 +1257,14=
 @@
     return buf_write(dest, &u16, sizeof(uint16_t));
 }
 
+/**
+ * Appe=
nd a uint32_t to a buffer in network byte order=2E
+ *
+ * @param dest  Des=
tination buffer=2E
+ * @param data  Value to append (converted with \c hton=
l())=2E
+ *
+ * @return true on success, false if there is insufficient cap=
acity=2E
+ */
 static inline bool
 buf_write_u32(struct buffer *dest, uint3=
2_t data)
 {
@@ -674,6 +1272,14 @@
     return buf_write(dest, &u32, sizeof=
(uint32_t));
 }
 
+/**
+ * Copy the content of one buffer to the end of ano=
ther=2E
+ *
+ * @param dest  Destination buffer=2E
+ * @param src   Source =
buffer=2E
+ *
+ * @return true on success, false if \c dest has insufficien=
t capacity=2E
+ */
 static inline bool
 buf_write_u64(struct buffer *dest, =
uint64_t data)
 {
@@ -687,6 +1293,18 @@
     return buf_write(dest, BPTR(sr=
c), BLENZ(src));
 }
 
+/**
+ * Read \c n bytes from \c src and append them =
to \c dest=2E
+ *
+ * Consumes the bytes from \c src=2E
+ *
+ * @param dest=
  Destination buffer=2E
+ * @param src   Source buffer (modified)=2E
+ * @p=
aram n     Number of bytes to copy=2E
+ *
+ * @return true on success, fals=
e if \c src has fewer than \c n bytes or
+ *         \c dest has insufficie=
nt capacity=2E
+ */
 static inline bool
 buf_copy_n(struct buffer *dest, st=
ruct buffer *src, int n)
 {
@@ -698,6 +1316,22 @@
     return buf_write(des=
t, cp, n);
 }
 
+/**
+ * Copy a range of bytes from one buffer into a speci=
fic position in another=2E
+ *
+ * Copies \c src_len bytes starting at \c s=
rc_index within \c src content
+ * into \c dest at \c dest_index relative t=
o the content start=2E  Updates
+ * \c dest->len if the write extends beyon=
d the current content=2E  Does not
+ * advance either buffer's offset=2E
+ =
*
+ * @param dest        Destination buffer=2E
+ * @param dest_index  Byte =
offset within \c dest content to write at=2E
+ * @param src         Source =
buffer=2E
+ * @param src_index   Byte offset within \c src content to read =
from=2E
+ * @param src_len     Number of bytes to copy=2E
+ *
+ * @return t=
rue on success, false if any index or length is out of range=2E
+ */
 stati=
c inline bool
 buf_copy_range(struct buffer *dest, int dest_index, const st=
ruct buffer *src, int src_index,
                int src_len)
@@ -715,7 +13=
49,19 @@
     return true;
 }
 
-/* truncate src to len, copy excess data b=
eyond len to dest */
+/**
+ * Truncate \c src to \c len bytes and copy any =
excess to \c dest=2E
+ *
+ * If \c src->len > \c len, \c src is truncated t=
o \c len bytes and the
+ * remaining bytes are appended to \c dest=2E  If \=
c src->len <=3D \c len,
+ * nothing is copied and true is returned=2E
+ *
+=
 * @param dest  Destination buffer for the excess data=2E
+ * @param src   =
Source buffer to truncate=2E
+ * @param len   Maximum number of bytes to ke=
ep in \c src=2E
+ *
+ * @return true on success, false if \c len is negativ=
e or copying fails=2E
+ */
 static inline bool
 buf_copy_excess(struct buff=
er *dest, struct buffer *src, int len)
 {
@@ -739,6 +1385,17 @@
     }
 }
 =

+/**
+ * Read bytes from the front of a buffer into a caller-supplied dest=
ination=2E
+ *
+ * Consumes \c size bytes from \c src and copies them to \c=
 dest=2E
+ *
+ * @param src   Source buffer (modified)=2E
+ * @param dest  =
Destination memory=2E
+ * @param size  Number of bytes to read=2E
+ *
+ * @=
return true on success, false if \c src has fewer than \c size bytes=2E
+ *=
/
 static inline bool
 buf_read(struct buffer *src, void *dest, int size)
 =
{
@@ -751,6 +1408,14 @@
     return true;
 }
 
+/**
+ * Return the first by=
te of the buffer without consuming it=2E
+ *
+ * @param buf   The buffer to=
 peek at=2E
+ *
+ * @return The first byte as an unsigned value (0=E2=80=93=
255), or -1 if the buffer
+ *         is empty=2E
+ */
 static inline int
 =
buf_peek_u8(struct buffer *buf)
 {
@@ -763,6 +1428,13 @@
     return ret;
 =
}
 
+/**
+ * Read and consume a uint8_t from the front of a buffer=2E
+ *
+=
 * @param buf   The buffer to read from=2E
+ *
+ * @return The byte value (=
0=E2=80=93255), or -1 if the buffer is empty=2E
+ */
 static inline int
 bu=
f_read_u8(struct buffer *buf)
 {
@@ -774,6 +1446,16 @@
     return ret;
 }
=
 
+/**
+ * Read and consume a uint16_t from the front of a buffer=2E
+ *
+ =
* The value is converted from network byte order via \c ntohs()=2E
+ *
+ * =
@param buf   The buffer to read from=2E
+ *
+ * @return The host-byte-order=
 value, or -1 if the buffer has fewer than 2
+ *         bytes=2E
+ */
 sta=
tic inline int
 buf_read_u16(struct buffer *buf)
 {
@@ -785,6 +1467,17 @@
 =
    return ntohs(ret);
 }
 
+/**
+ * Read and consume a uint32_t from the f=
ront of a buffer=2E
+ *
+ * The value is converted from network byte order =
via \c ntohl()=2E
+ *
+ * @param buf   The buffer to read from=2E
+ * @para=
m good  If non-NULL, set to true on success or false on failure=2E
+ *
+ * =
@return The host-byte-order value, or 0 if the buffer has fewer than 4
+ * =
        bytes (check \c *good to distinguish from a legitimate zero)=2E
+ *=
/
 static inline uint32_t
 buf_read_u32(struct buffer *buf, bool *good)
 {
=
@@ -866,31 +1559,73 @@
     return memcmp(BPTR(src), match, size) =3D=3D 0;=

 }
 
+/**
+ * Return true if the head of \c src matches the string \c matc=
h=2E
+ *
+ * Compares the first \c strlen(match) bytes of \c src content wi=
th \c match=2E
+ * *NOT* constant time=2E Do not use when comparing HMACs=
=2E
+ *
+ * @param src    Buffer whose head is compared=2E
+ * @param match=
  Null-terminated string to compare against=2E
+ *
+ * @return true if the =
buffer starts with \c match=2E
+ */
 bool buf_string_match_head_str(const s=
truct buffer *src, const char *match);
 
+/**
+ * Compare the head of \c sr=
c with \c match and advance past it if equal=2E
+ *
+ * If the buffer start=
s with \c match, the matched bytes are consumed from
+ * \c src=2E  *NOT* c=
onstant time=2E Do not use when comparing HMACs=2E
+ *
+ * @param src    Bu=
ffer to compare and advance=2E
+ * @param match  Null-terminated string to =
compare against=2E
+ *
+ * @return true if the buffer started with \c match=
 (and was advanced)=2E
+ */
 bool buf_string_compare_advance(struct buffer =
*src, const char *match);
 
+/**
+ * Return the length of the next token in=
 a buffer up to a delimiter=2E
+ *
+ * Scans the buffer content for \c deli=
m and returns the number of bytes
+ * up to (but not including) the delimit=
er, or the full buffer length if
+ * the delimiter is not found=2E
+ *
+ * =
@param buf    The buffer to scan=2E
+ * @param delim  Delimiter byte to sea=
rch for=2E
+ *
+ * @return Number of bytes before the first occurrence of \=
c delim, or -1
+ *         if the buffer is empty=2E
+ */
 int buf_substrin=
g_len(const struct buffer *buf, int delim);
 
-/*
- * Print a string which =
might be NULL
+/**
+ * Return a printable representation of a string that m=
ight be NULL=2E
+ *
+ * @param str   String to print, or NULL=2E
+ *
+ * @r=
eturn \c str if non-NULL, otherwise the string \c "[NULL]"=2E
  */
 const c=
har *np(const char *str);
 
-/* character classes */
-
+/** @name Character=
 classes
+ *  @brief Check or modify strings based on classes of allowed
+ =
*         or forbidden characters=2E
+ */
+/**@{*/
 #define CC_ANY  (1 << 0=
)           /**< any character */
 #define CC_NULL (1 << 1)           /**< =
null character \0 */
 
-#define CC_ALNUM  (1 << 2)         /**< alphanumeri=
c isalnum() */
-#define CC_ALPHA  (1 << 3)         /**< alphabetic isalpha(=
) */
+#define CC_ALNUM  (1 << 2)         /**< alphanumeric \c isalnum() */
=
+#define CC_ALPHA  (1 << 3)         /**< alphabetic \c isalpha() */
 #defin=
e CC_ASCII  (1 << 4)         /**< ASCII character */
-#define CC_CNTRL  (1 =
<< 5)         /**< control character iscntrl() */
-#define CC_DIGIT  (1 << =
6)         /**< digit isdigit() */
+#define CC_CNTRL  (1 << 5)         /**<=
 control character \c iscntrl() */
+#define CC_DIGIT  (1 << 6)         /**<=
 digit \c isdigit() */
 #define CC_PRINT  (1 << 7)         /**< printable (=
>=3D 32, !=3D 127) */
-#define CC_PUNCT  (1 << 8)         /**< punctuation =
ispunct() */
-#define CC_SPACE  (1 << 9)         /**< whitespace isspace() =
*/
-#define CC_XDIGIT (1 << 10)        /**< hex digit isxdigit() */
+#defin=
e CC_PUNCT  (1 << 8)         /**< punctuation \c ispunct() */
+#define CC_S=
PACE  (1 << 9)         /**< whitespace \c isspace() */
+#define CC_XDIGIT (=
1 << 10)        /**< hex digit \c isxdigit() */
 
 #define CC_BLANK   (1 <<=
 11)       /**< space or tab */
 #define CC_NEWLINE (1 << 12)       /**< ne=
wline */
@@ -918,8 +1653,27 @@
 #define CC_NAME (CC_ALNUM | CC_UNDERBAR) /*=
*< alphanumeric plus underscore */
 #define CC_CRLF (CC_CR | CC_NEWLINE)   =
  /**< carriage return or newline */
 
+/**
+ * Test whether a character be=
longs to one or more character classes=2E
+ *
+ * @param c      The charact=
er to test=2E
+ * @param flags  Bitmask of \c CC_* character class flags=2E=

+ *
+ * @return true if \c c matches any of the classes specified in \c fl=
ags=2E
+ */
 bool char_class(const unsigned char c, const unsigned int flag=
s);
 
+/**
+ * Test whether all characters in a string satisfy a character =
class filter=2E
+ *
+ * @param str        The null-terminated string to tes=
t=2E
+ * @param inclusive  Classes that are permitted (characters must matc=
h at
+ *                   least one of these)=2E
+ * @param exclusive  Cla=
sses that are forbidden (characters must not match
+ *                   an=
y of these, even if they also match \c inclusive)=2E
+ *
+ * @return true i=
f every character in \c str is permitted=2E
+ */
 bool string_class(const c=
har *str, const unsigned int inclusive, const unsigned int exclusive);
 
 /=
**
@@ -966,10 +1720,27 @@
  */
 const char *string_mod_const(const char *st=
r, const unsigned int inclusive,
                              const unsign=
ed int exclusive, const char replace, struct gc_arena *gc);
+/**@}*/
 
+/**=

+ * Replace all leading occurrences of a character in a string=2E
+ *
+ * =
Scans from the start of \c str and replaces every consecutive \c match
+ * =
character with \c replace, stopping at the first character that does not
+ =
* match=2E
+ *
+ * @param str      The null-terminated string to modify in =
place=2E
+ * @param match    The character to replace=2E
+ * @param replace=
  The replacement character=2E
+ */
 void string_replace_leading(char *str,=
 const char match, const char replace);
 
-/** Return true iff str starts w=
ith prefix */
+/**
+ * Return true iff \c str starts with \c prefix=2E
+ *
=
+ * @param str     The string to test=2E
+ * @param prefix  The prefix to l=
ook for=2E
+ */
 static inline bool
 strprefix(const char *str, const char =
*prefix)
 {
@@ -1004,6 +1775,16 @@
  * Verify that a pointer is correctly a=
ligned
  */
 #ifdef VERIFY_ALIGNMENT
+/**
+ * Assert that the content point=
er of \c buf is 4-byte aligned=2E
+ *
+ * Only compiled in when \c VERIFY_A=
LIGNMENT is defined=2E  Called via the
+ * \c verify_align_4() macro=2E
+ *=

+ * @param buf   Buffer whose content pointer is to be checked=2E
+ * @par=
am file  Source file of the call site (for the error message)=2E
+ * @param=
 line  Source line of the call site (for the error message)=2E
+ */
 void v=
align4(const struct buffer *buf, const char *file, const int line);
 
 #def=
ine verify_align_4(ptr) valign4(buf, __FILE__, __LINE__)
@@ -1011,23 +1792,=
58 @@
 #define verify_align_4(ptr)
 #endif
 
-/*
- * Very basic garbage col=
lection, mostly for routines that return
- * char ptrs to malloced strings=
=2E
+/** @name Garbage Collection
+ *  @brief Basic garbage collection, mos=
tly for routines that return
+ *         char ptrs to malloced strings=2E
 =
 */
+/**@{*/
 
+/**
+ * Move all allocations from one garbage collection ar=
ena to another=2E
+ *
+ * After the call \c src is empty and all entries pr=
eviously in \c src are
+ * owned by \c dest=2E
+ *
+ * @param dest  Arena t=
o move allocations into=2E
+ * @param src   Arena to move allocations from =
(emptied on return)=2E
+ */
 void gc_transfer(struct gc_arena *dest, struct=
 gc_arena *src);
 
+/**
+ * Free all plain allocations in a garbage collect=
ion arena=2E
+ *
+ * Internal implementation called by \c gc_free()=2E  Do =
not call directly=2E
+ *
+ * @param a  The arena whose \c list entries are =
to be freed=2E
+ */
 void x_gc_free(struct gc_arena *a);
 
+/**
+ * Free al=
l specially-allocated entries in a garbage collection arena=2E
+ *
+ * Inte=
rnal implementation called by \c gc_free()=2E  Do not call directly=2E
+ * =
Invokes the custom free function stored in each \c gc_entry_special=2E
+ *
=
+ * @param a  The arena whose \c list_special entries are to be freed=2E
+ =
*/
 void x_gc_freespecial(struct gc_arena *a);
 
+/**
+ * Return true iff t=
he arena contains at least one allocation=2E
+ *
+ * @param a  The arena to=
 test=2E
+ */
 static inline bool
 gc_defined(struct gc_arena *a)
 {
     r=
eturn a->list !=3D NULL;
 }
 
+/**
+ * Initialise a garbage collection aren=
a to an empty state=2E
+ *
+ * @param a  The arena to initialise=2E
+ */
 s=
tatic inline void
 gc_init(struct gc_arena *a)
 {
@@ -1035,12 +1851,25 @@
 =
    a->list_special =3D NULL;
 }
 
+/**
+ * Detach all allocations from an =
arena without freeing them=2E
+ *
+ * After this call the arena is empty=2E=
  The caller takes responsibility for
+ * freeing the previously registered=
 allocations=2E
+ *
+ * @param a  The arena to detach=2E
+ */
 static inlin=
e void
 gc_detach(struct gc_arena *a)
 {
     gc_init(a);
 }
 
+/**
+ * All=
ocate and return a new, empty garbage collection arena=2E
+ *
+ * @return A=
n initialised \c gc_arena with empty lists=2E
+ */
 static inline struct gc=
_arena
 gc_new(void)
 {
@@ -1049,6 +1878,14 @@
     return ret;
 }
 
+/**
+=
 * Free all allocations in a garbage collection arena=2E
+ *
+ * Calls \c x=
_gc_free() and \c x_gc_freespecial() as needed to release all
+ * registere=
d memory=2E
+ *
+ * @param a  The arena to free=2E
+ */
 static inline void=

 gc_free(struct gc_arena *a)
 {
@@ -1062,6 +1899,13 @@
     }
 }
 
+/**
+ =
* Free all allocations in a garbage collection arena and reinitialise it=2E=

+ *
+ * Equivalent to calling \c gc_free() followed by \c gc_init()=2E
+ *=

+ * @param a  The arena to reset=2E
+ */
 static inline void
 gc_reset(str=
uct gc_arena *a)
 {
@@ -1079,58 +1923,139 @@
 /* 1 GB on 32bit systems, the=
y usually can only allocate 2 GB for the
  * whole process=2E
  */
+/** Max=
imum size for a single array allocation (checked by \c array_mult_safe())=
=2E */
 #define ALLOC_SIZE_MAX (1u << 30)
 #else
+/** Maximum size for a si=
ngle array allocation (checked by \c array_mult_safe())=2E */
 #define ALLO=
C_SIZE_MAX ((size_t)1 << 32) /* 4 GB */
 #endif
 
+/**
+ * Allocate memory =
for a single object of the given type=2E
+ *
+ * Calls \c check_malloc_retu=
rn() to abort on allocation failure=2E
+ *
+ * @param dptr  Pointer variabl=
e that receives the allocation=2E
+ * @param type  Type of the object to al=
locate=2E
+ */
 #define ALLOC_OBJ(dptr, type)                              =
         \
     {                                                          =
     \
         check_malloc_return((dptr) =3D (type *)malloc(sizeof(type))=
); \
     }
 
+/**
+ * Allocate and zero-initialise memory for a single obj=
ect of the given type=2E
+ *
+ * @param dptr  Pointer variable that receive=
s the allocation=2E
+ * @param type  Type of the object to allocate=2E
+ */=

 #define ALLOC_OBJ_CLEAR(dptr, type)      \
     {                        =
            \
         ALLOC_OBJ(dptr, type);           \
         memset((=
dptr), 0, sizeof(type)); \
     }
 
+/**
+ * Allocate memory for an array o=
f \c n elements of the given type=2E
+ *
+ * Uses \c array_mult_safe() to g=
uard against size overflow=2E
+ * Calls \c check_malloc_return() to abort o=
n allocation failure=2E
+ *
+ * @param dptr  Pointer variable that receives=
 the allocation=2E
+ * @param type  Element type of the array=2E
+ * @param=
 n     Number of elements=2E
+ */
 #define ALLOC_ARRAY(dptr, type, n)      =
                                                     \
     {              =
                                                                          \=

         check_malloc_return((dptr) =3D (type *)malloc(array_mult_safe(siz=
eof(type), (n), 0))); \
     }
 
+/**
+ * Allocate a garbage-collected arra=
y of \c n elements of the given type=2E
+ *
+ * @param dptr  Pointer variab=
le that receives the allocation=2E
+ * @param type  Element type of the arr=
ay=2E
+ * @param n     Number of elements=2E
+ * @param gc    Garbage colle=
ction arena to register the allocation with=2E
+ */
 #define ALLOC_ARRAY_GC=
(dptr, type, n, gc)                                               \
     { =
                                                                           =
       \
         (dptr) =3D (type *)gc_malloc(array_mult_safe(sizeof(type)=
, (n), 0), false, (gc)); \
     }
 
+/**
+ * Allocate and zero-initialise a=
n array of \c n elements of the given type=2E
+ *
+ * @param dptr  Pointer =
variable that receives the allocation=2E
+ * @param type  Element type of t=
he array=2E
+ * @param n     Number of elements=2E
+ */
 #define ALLOC_ARRA=
Y_CLEAR(dptr, type, n)                            \
     {                 =
                                              \
         ALLOC_ARRAY(dptr, =
type, n);                                 \
         memset((dptr), 0, (arr=
ay_mult_safe(sizeof(type), (n), 0))); \
     }
 
+/**
+ * Allocate and zero=
-initialise a garbage-collected array of \c n elements=2E
+ *
+ * @param dp=
tr  Pointer variable that receives the allocation=2E
+ * @param type  Eleme=
nt type of the array=2E
+ * @param n     Number of elements=2E
+ * @param g=
c    Garbage collection arena to register the allocation with=2E
+ */
 #def=
ine ALLOC_ARRAY_CLEAR_GC(dptr, type, n, gc)                                =
        \
     {                                                           =
                       \
         (dptr) =3D (type *)gc_malloc(array_mult_s=
afe(sizeof(type), (n), 0), true, (gc)); \
     }
 
+/**
+ * Allocate and ze=
ro-initialise a garbage-collected variable-length structure=2E
+ *
+ * Allo=
cates \c sizeof(type) + \c n * \c sizeof(atype) bytes for a structure
+ * t=
hat embeds a variable-length array of \c atype as its last member=2E
+ *
+ =
* @param dptr   Pointer variable that receives the allocation=2E
+ * @param=
 type   Type of the enclosing structure=2E
+ * @param atype  Element type o=
f the variable-length array member=2E
+ * @param n      Number of array ele=
ments=2E
+ * @param gc     Garbage collection arena to register the allocat=
ion with=2E
+ */
 #define ALLOC_VAR_ARRAY_CLEAR_GC(dptr, type, atype, n, gc=
)                                         \
     {                         =
                                                                     \
    =
     (dptr) =3D (type *)gc_malloc(array_mult_safe(sizeof(atype), (n), sizeo=
f(type)), true, (gc)); \
     }
 
+/**
+ * Allocate a garbage-collected obj=
ect of the given type (uninitialised)=2E
+ *
+ * @param dptr  Pointer varia=
ble that receives the allocation=2E
+ * @param type  Type of the object to =
allocate=2E
+ * @param gc    Garbage collection arena to register the alloc=
ation with=2E
+ */
 #define ALLOC_OBJ_GC(dptr, type, gc)                   =
        \
     {                                                          \=

         (dptr) =3D (type *)gc_malloc(sizeof(type), false, (gc)); \
     }=

 
+/**
+ * Allocate and zero-initialise a garbage-collected object of the =
given type=2E
+ *
+ * @param dptr  Pointer variable that receives the alloc=
ation=2E
+ * @param type  Type of the object to allocate=2E
+ * @param gc  =
  Garbage collection arena to register the allocation with=2E
+ */
 #define=
 ALLOC_OBJ_CLEAR_GC(dptr, type, gc)                    \
     {            =
                                             \
         (dptr) =3D (type *)=
gc_malloc(sizeof(type), true, (gc)); \
     }
 
+/**
+ * Abort if a memory =
allocation returned NULL=2E
+ *
+ * @param p  Return value from \c malloc()=
 or similar; calls \c out_of_memory()
+ *           if \c p is NULL=2E
+ */=

 static inline void
 check_malloc_return(void *p)
 {
@@ -1139,22 +2064,28 =
@@
         out_of_memory();
     }
 }
+/**@}*/
+/* End of GC */
 
-/*
- * =
Manage lists of buffers
+/** @name Buffer Lists
+ *  @brief Manage lists of=
 buffers
  */
+/**@{*/
+
+/** One node in a \c buffer_list linked list=2E *=
/
 struct buffer_entry
 {
-    struct buffer buf;
-    struct buffer_entry =
*next;
+    struct buffer buf;         /**< The buffer stored in this list =
node=2E */
+    struct buffer_entry *next; /**< Pointer to the next node, o=
r NULL=2E */
 };
 
+/** A singly-linked list of buffers, with head/tail poi=
nters for O(1) push=2E */
 struct buffer_list
 {
-    struct buffer_entry *=
head; /* next item to pop/peek */
-    struct buffer_entry *tail; /* last i=
tem pushed */
-    size_t size;               /* current number of entries =
*/
-    size_t max_size;           /* maximum size list should grow to */
+=
    struct buffer_entry *head; /**< Next item to pop/peek=2E */
+    struct=
 buffer_entry *tail; /**< Last item pushed=2E */
+    size_t size;         =
      /**< Current number of entries=2E */
+    size_t max_size;           =
/**< Maximum number of entries allowed=2E */
 };
 
 /**
@@ -1215,8 +2146,24=
 @@
  */
 struct buffer *buffer_list_peek(struct buffer_list *ol);
 
+/**
+=
 * Advance past \c n bytes in the head buffer, popping it if it becomes emp=
ty=2E
+ *
+ * \c n must not exceed the length of the head buffer; passing a=
 larger value
+ * triggers an assertion failure=2E
+ *
+ * @param ol  The l=
ist whose head buffer is to be advanced=2E
+ * @param n   Number of bytes t=
o skip in the head buffer=2E
+ */
 void buffer_list_advance(struct buffer_l=
ist *ol, ssize_t n);
 
+/**
+ * Remove and free the head buffer of the list=
=2E
+ *
+ * Does nothing if \c ol is NULL or empty=2E
+ *
+ * @param ol  Th=
e list to pop from=2E
+ */
 void buffer_list_pop(struct buffer_list *ol);
 =

 /**
@@ -1244,6 +2191,20 @@
  */
 void buffer_list_aggregate_separator(str=
uct buffer_list *bl, const size_t max_len, const char *sep);
 
+/**
+ * Rea=
d a file into a buffer list, one buffer per line=2E
+ *
+ * Opens \c fn for=
 reading and pushes each line into a newly allocated buffer
+ * list using =
\c fgets()=2E  Lines longer than \c max_line_len - 1 bytes are
+ * split ac=
ross multiple consecutive buffers=2E
+ *
+ * @param fn            Path to t=
he file to read=2E
+ * @param max_line_len  Maximum number of bytes (includ=
ing null terminator)
+ *                      read per \c fgets() call=2E
+=
 *
+ * @return Pointer to the new buffer list, or NULL if the file could no=
t be
+ *         opened or memory allocation failed=2E
+ */
 struct buffer_=
list *buffer_list_file(const char *fn, int max_line_len);
 
 /**
@@ -1257,5=
 +2218,7 @@
  * error
  */
 struct buffer buffer_read_from_file(const char =
*filename, struct gc_arena *gc);
+/**@}*/
+/* End of Buffer Lists */
 
 #en=
dif /* BUFFER_H */

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1581?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I350ca5b08379ede1480b81055d35dd9a33e30cff
Gerrit-Change-Number: 1581
Gerr=
it-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-=
openvpn@rfc2549=2Eorg>

--ccj21uU3UB0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld <strong>uploaded pa=
tch set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1581?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">do=
c: add Doxygen documentation to buffer=2Eh<br><br>Document all previously u=
ndocumented elements=2E<br><br>Github: Fixes #864<br>Change-Id: I350ca5b083=
79ede1480b81055d35dd9a33e30cff<br>Signed-off-by: Frank Lichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/buffer=2Eh<br>1 file change=
d, 1,026 insertions(+), 63 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/81/1581/2</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><spa=
n>index 22e045c=2E=2E07f3a2d 100644</span><br><span>--- a/src/openvpn/buffe=
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
n><br><span> </span><br><span>@@ -427,22 +758,76 @@</span><br><span>  * rem=
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
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> void string_null_ter=
minate(char *str, int len, int capacity);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/**@}*/</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* End of string utility functions */</span><br><span> </span><br=
><span> /**</span><br><span>  * Write buffer contents to file=2E</span><br>=
<span>@@ -454,40 +839,114 @@</span><br><span>  */</span><br><span> bool buf=
fer_write_file(const char *filename, const struct buffer *buf);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * write a string to the end of a =
buffer that was</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * tru=
ncated by buf_printf</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Append a str=
ing to the physical end of a buffer that was truncated by</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * \c buf_printf()=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * If the buffer&#39;s forward capacity is one byte =
or less (i=2Ee=2E it is full),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * \c str is written at the very end of the allocated memory to =
act as a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * truncati=
on marker, provided it fits within the total buffer capacity=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * This is used to append a &qu=
ot;[more=2E=2E=2E]&quot; suffix after hex-dump truncation=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param buf   The buffer to append the truncation=
 marker to=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram str   The null-terminated marker string to write=2E</span><br><span>  *=
/</span><br><span> void buf_catrunc(struct buffer *buf, const char *str);</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * Parse a string based =
on a given delimiter char</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Extract=
 the next token from a buffer, delimited by a given character=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Reads bytes from \c buf one at a time until =
\c delim or end-of-buffer is</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * encountered=2E  The token (without the delimiter) is written in=
to \c line,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * which=
 is always null-terminated=2E  The delimiter byte is consumed from</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * \c buf but not included i=
n \c line=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf    Source =
buffer to parse=2E  The consumed portion is advanced=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param delim  Delimiter character=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param line   Ou=
tput buffer for the extracted token=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param size   Size of \c line in bytes (must be &gt; =
0)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @return false only when end-=
of-buffer is reached and no characters were</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *         extracted; true otherwise (including whe=
n a delimiter was found</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *         or \c line was truncated)=2E</span><br><span>  */</span><br>=
<span> bool buf_parse(struct buffer *buf, const int delim, char *line, cons=
t int size);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Hex dum=
p -- Output a binary buffer to a hex string and return it=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/** @name Hex Dump</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  @brief Output a binary buffer t=
o a hex string and return it=2E</span><br><span>  */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define FHE_SPACE_BREAK_MASK 0xFF  /* space=
_break parameter in lower 8 bits */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#define FHE_CAPS             0x100 /* output hex in caps */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**@{*/</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/** Mask for the space_break_flags field of \c forma=
t_hex_ex(): number of</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  bytes between separators (lower 8 bits)=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define FHE_SPACE_BREAK_MASK 0xFF</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/** Flag for \c format_hex_=
ex(): output hex digits in upper case=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define FHE_CAPS             0x100</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Format a binary buffer as a hex string=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param data              Pointer to the b=
inary data to format=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param size              Number of bytes to format=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param maxoutput         Maximu=
m number of output characters (0 =3D unlimited)=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *                          If the output is=
 truncated, a &quot;[more=2E=2E=2E]&quot; suffix is</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *                          appended via =
\c buf_catrunc()=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param space_break_flags Lower 8 bits (\c FHE_SPACE_BREAK_MASK) give the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                 =
         number of bytes between \c separator insertions=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *                          Use \c =
FHE_CAPS to output upper-case hex digits=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param separator         String to insert betwee=
n groups of bytes=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param gc                Garbage collection arena for the returned stri=
ng=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @return Null-terminated hex =
string allocated from \c gc=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span> char *format_hex_ex(const uint8_t *data, si=
ze_t size, size_t maxoutput, unsigned int space_break_flags,</span><br><spa=
n>                     const char *separator, struct gc_arena *gc);</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Format a binary buffer=
 as a hex string with spaces every 4 bytes=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Convenience wrapper around \c format_hex_ex()=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param data       Pointer to the binary data to =
format=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
size       Number of bytes to format=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param maxoutput  Maximum number of output character=
s (0 =3D unlimited)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param gc         Garbage collection arena for the returned string=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @return Null-terminated hex strin=
g allocated from \c gc=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span> static inline char *</span><br><span> format_hex=
(const uint8_t *data, size_t size, size_t maxoutput, struct gc_arena *gc)</=
span><br><span> {</span><br><span>     return format_hex_ex(data, size, max=
output, 4, &quot; &quot;, gc);</span><br><span> }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**@}*/</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* End of Hex Dump */</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * Return a buffer that is a subset of another buffer=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * Return a sub-buffer of another buf=
fer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Either allocates \c size by=
tes from the front or back of \c buf,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * shrinking \c buf accordingly, and returns a buffer poi=
nting into the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * sa=
me memory=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf      Sourc=
e buffer to carve the sub-buffer from=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param size     Number of bytes to include in the s=
ub-buffer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am prepend  If true, take bytes from the front of \c buf (prepend</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *                 space); if=
 false, take bytes from the end (append space)=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @return A buffer referencing the allocated region, or an un=
defined buffer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
      if \c buf has insufficient capacity=2E</span><br><span>  */</span><br=
><span> struct buffer buf_sub(struct buffer *buf, int size, bool prepend);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Check if sufficient =
space to append to buffer=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Chec=
k whether \c len bytes can be appended to a buffer=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param buf   The buffer to check=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param len   Number of bytes to appe=
nd=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @return true if \c buf is va=
lid, \c len is within the allowed range, and</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *         there is sufficient capacity after the =
current content=2E</span><br><span>  */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span> static inline bool</span><br><span> buf=
_safe(const struct buffer *buf, size_t len)</span><br><span> {</span><br><s=
pan>@@ -495,6 +954,18 @@</span><br><span>            &amp;&amp; buf-&gt;off=
set + buf-&gt;len + (int)len &lt;=3D buf-&gt;capacity;</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Check whether \c=
 len bytes can be added to or removed from a buffer=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Accepts negative \c len to verify that bytes can be re=
moved (length</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * dec=
reased)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer=
 to check=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am len   Number of bytes to add (positive) or remove (negative)=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @return true if the resulting length would=
 remain non-negative and within</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *         the allocated capacity=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span> static inline bool</span>=
<br><span> buf_safe_bidir(const struct buffer *buf, int len)</span><br><spa=
n> {</span><br><span>@@ -509,6 +980,17 @@</span><br><span>     }</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return=
 the number of bytes that can still be appended to the buffer=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * This is the space between the end of the cur=
rent content and the end of</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * the allocated memory=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param buf   The buffer to query=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @return Number of bytes available for appending, or 0 if \c buf is</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         invalid=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> st=
atic inline int</span><br><span> buf_forward_capacity(const struct buffer *=
buf)</span><br><span> {</span><br><span>@@ -527,6 +1009,17 @@</span><br><sp=
an>     }</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Return the total number of bytes available from the current o=
ffset to the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * end =
of the allocated memory=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Unlike =
\c buf_forward_capacity(), this includes the bytes already occupied</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * by the current content=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer to que=
ry=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @return Capacity minus offse=
t, or 0 if \c buf is invalid=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span> static inline int</span><br><span> buf_for=
ward_capacity_total(const struct buffer *buf)</span><br><span> {</span><br>=
<span>@@ -545,6 +1038,16 @@</span><br><span>     }</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return the number of=
 bytes available for prepending to the buffer=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * This is the number of bytes between the start of the allocat=
ed memory and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the=
 current content start (i=2Ee=2E \c buf-&gt;offset)=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param buf   The buffer to query=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @return \c buf-&gt;offset, or 0 if \c buf is invalid=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan> static inline int</span><br><span> buf_reverse_capacity(const struct b=
uffer *buf)</span><br><span> {</span><br><span>@@ -558,6 +1061,17 @@</span>=
<br><span>     }</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Increase or decrease the length of a buffer=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * Adjusts \c buf-&gt;len by \c inc bytes=2E=
  A negative \c inc shrinks the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * buffer=2E  The operation is bounds-checked via \c buf_safe_b=
idir()=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer =
to modify=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am inc   Number of bytes to add to the length (may be negative)=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @return true on success, false if the adju=
stment would violate bounds=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span> static inline bool</span><br><span> buf_inc=
_len(struct buffer *buf, int inc)</span><br><span> {</span><br><span>@@ -56=
9,11 +1083,18 @@</span><br><span>     return true;</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * Make space to prepend to =
a buffer=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Return =
NULL if no space=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Make space at=
 the front of a buffer for prepending data=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Moves the content start backwards by \c size bytes, increasing =
\c len</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * and decrea=
sing \c offset by the same amount=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param buf   The buffer to modify=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param size  Number of bytes to reserve for prependi=
ng=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @return Pointer to the newly=
 reserved space (new content start), or NULL</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *         if \c buf is invalid or there is insuff=
icient prepend capacity=2E</span><br><span>  */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span> static inline uint8_t *</span><=
br><span> buf_prepend(struct buffer *buf, ssize_t size)</span><br><span> {<=
/span><br><span>@@ -586,6 +1107,17 @@</span><br><span>     return BPTR(buf)=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Advance the content start of a buffer, consuming bytes from the front=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Increases \c offset and decrea=
ses \c len by \c size bytes=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram buf   The buffer to advance=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param size  Number of bytes to skip=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @return true on success, false if \c buf is invalid=
 or \c size exceeds</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *         the current length=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ */</span><br><span> static inline bool</span><br><span> buf_a=
dvance(struct buffer *buf, ssize_t size)</span><br><span> {</span><br><span=
>@@ -598,11 +1130,18 @@</span><br><span>     return true;</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Return a pointer t=
o allocated space inside a buffer=2E</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * Return NULL if no space=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Reserve space at the end of a buffer for writing=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * Increases \c buf-&gt;len by \c size and retur=
ns a pointer to the start of</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * the newly reserved region=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param buf   The buffer to allocate space in=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param size  Number of bytes to reser=
ve=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @return Pointer to the start=
 of the reserved space, or NULL if there is</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *         insufficient capacity=2E</span><br><span=
>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> static inline uint8_t *</span><br><span> buf_write_alloc(struct buffer *b=
uf, size_t size)</span><br><span> {</span><br><span>@@ -616,6 +1155,18 @@</=
span><br><span>     return ret;</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Consume bytes from the front of a buff=
er for reading=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Returns a pointe=
r to the current content start and advances the buffer</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * by \c size bytes=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param buf   The buffer to read from=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param size  Number of bytes=
 to consume=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return Pointer to =
the start of the consumed region, or NULL if \c size</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *         is negative or exceeds the cur=
rent length=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span> static inline uint8_t *</span><br><span> buf_read_alloc(str=
uct buffer *buf, int size)</span><br><span> {</span><br><span>@@ -630,6 +11=
81,17 @@</span><br><span>     return ret;</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Append data to a buffer=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Copies \c size bytes from \c src to =
the end of \c dest=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dest =
 Destination buffer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param src   Data to append=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param size  Number of bytes to append=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @return true on success, false if there is insu=
fficient capacity=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ */</span><br><span> static inline bool</span><br><span> buf_write(struct =
buffer *dest, const void *src, size_t size)</span><br><span> {</span><br><s=
pan>@@ -642,6 +1204,18 @@</span><br><span>     return true;</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Prepend dat=
a to a buffer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Copies \c size by=
tes from \c src into the prepend space at the front of</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * \c dest=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param dest  Destination buffer=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param src   Data to prepend=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param size  Number of byte=
s to prepend=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true on su=
ccess, false if there is insufficient prepend capacity=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inline bo=
ol</span><br><span> buf_write_prepend(struct buffer *dest, const void *src,=
 int size)</span><br><span> {</span><br><span>@@ -654,12 +1228,28 @@</span>=
<br><span>     return true;</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Append a uint8_t to a buffer=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param dest  Destination buffer=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param data  Byte to append=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, false=
 if there is insufficient capacity=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span> static inline bool</span><br><span> =
buf_write_u8(struct buffer *dest, uint8_t data)</span><br><span> {</span><b=
r><span>     return buf_write(dest, &amp;data, sizeof(uint8_t));</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Append=
 a uint16_t to a buffer in network byte order=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param dest  Destination buffer=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param data  Value to append (converted wi=
th \c htons())=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true on =
success, false if there is insufficient capacity=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inline bool</=
span><br><span> buf_write_u16(struct buffer *dest, uint16_t data)</span><br=
><span> {</span><br><span>@@ -667,6 +1257,14 @@</span><br><span>     return=
 buf_write(dest, &amp;u16, sizeof(uint16_t));</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * Append a uint32_t to a bu=
ffer in network byte order=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am dest  Destination buffer=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param data  Value to append (converted with \c htonl())=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, false if t=
here is insufficient capacity=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ */</span><br><span> static inline bool</span><br><span> buf_w=
rite_u32(struct buffer *dest, uint32_t data)</span><br><span> {</span><br><=
span>@@ -674,6 +1272,14 @@</span><br><span>     return buf_write(dest, &amp=
;u32, sizeof(uint32_t));</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Copy the content of one buffer to the end of a=
nother=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dest  Destination=
 buffer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 src   Source buffer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return tr=
ue on success, false if \c dest has insufficient capacity=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inline=
 bool</span><br><span> buf_write_u64(struct buffer *dest, uint64_t data)</s=
pan><br><span> {</span><br><span>@@ -687,6 +1293,18 @@</span><br><span>    =
 return buf_write(dest, BPTR(src), BLENZ(src));</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read \c n bytes from \c=
 src and append them to \c dest=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 Consumes the bytes from \c src=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param dest  Destination buffer=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @param src   Source buffer (modified)=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param n     Number of bytes to =
copy=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, f=
alse if \c src has fewer than \c n bytes or</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *         \c dest has insufficient capacity=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> st=
atic inline bool</span><br><span> buf_copy_n(struct buffer *dest, struct bu=
ffer *src, int n)</span><br><span> {</span><br><span>@@ -698,6 +1316,22 @@<=
/span><br><span>     return buf_write(dest, cp, n);</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Copy a range of byt=
es from one buffer into a specific position in another=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Copies \c src_len bytes starting at \c src_index wi=
thin \c src content</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * into \c dest at \c dest_index relative to the content start=2E  Updates<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * \c dest-&gt;len i=
f the write extends beyond the current content=2E  Does not</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * advance either buffer&#39;s offs=
et=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param dest        Destinati=
on buffer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am dest_index  Byte offset within \c dest content to write at=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param src         Source b=
uffer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param s=
rc_index   Byte offset within \c src content to read from=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param src_len     Number of by=
tes to copy=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true on suc=
cess, false if any index or length is out of range=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inline bool</=
span><br><span> buf_copy_range(struct buffer *dest, int dest_index, const s=
truct buffer *src, int src_index,</span><br><span>                int src_l=
en)</span><br><span>@@ -715,7 +1349,19 @@</span><br><span>     return true;=
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
er *src, int len)</span><br><span> {</span><br><span>@@ -739,6 +1385,17 @@<=
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
nt size)</span><br><span> {</span><br><span>@@ -751,6 +1408,14 @@</span><br=
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
n> {</span><br><span>@@ -763,6 +1428,13 @@</span><br><span>     return ret;=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Read and consume a uint8_t from the front of a buffer=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param buf   The buffer to read from=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @return The byte value (0=E2=80=93255), o=
r -1 if the buffer is empty=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span> static inline int</span><br><span> buf_read=
_u8(struct buffer *buf)</span><br><span> {</span><br><span>@@ -774,6 +1446,=
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
struct buffer *buf)</span><br><span> {</span><br><span>@@ -785,6 +1467,17 @=
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
span><br><span> {</span><br><span>@@ -866,31 +1559,73 @@</span><br><span>  =
   return memcmp(BPTR(src), match, size) =3D=3D 0;</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return true if the h=
ead of \c src matches the string \c match=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Compares the first \c strlen(match) bytes of \c src content with=
 \c match=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * *NOT=
* constant time=2E Do not use when comparing HMACs=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param src    Buffer whose head is compared=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param match  Null-termin=
ated string to compare against=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@return true if the buffer starts with \c match=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span> bool buf_string_match_h=
ead_str(const struct buffer *src, const char *match);</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Compare the head of \c src with \c m=
atch and advance past it if equal=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * If the buffer starts with \c match, the matched bytes are consumed from<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * \c src=2E  *NOT* =
constant time=2E Do not use when comparing HMACs=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param src    Buffer to compare and advance=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param match  Null-termin=
ated string to compare against=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@return true if the buffer started with \c match (and was advanced)=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> boo=
l buf_string_compare_advance(struct buffer *src, const char *match);</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return the length of =
the next token in a buffer up to a delimiter=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Scans the buffer content for \c delim and returns the number =
of bytes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * up to (b=
ut not including) the delimiter, or the full buffer length if</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * the delimiter is not found=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param buf    The buffer to scan=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param delim =
 Delimiter byte to search for=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
return Number of bytes before the first occurrence of \c delim, or -1</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         if the buffer =
is empty=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</spa=
n><br><span> int buf_substring_len(const struct buffer *buf, int delim);</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * Print a string which m=
ight be NULL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return a printable r=
epresentation of a string that might be NULL=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param str   String to print, or NULL=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @return \c str if non-NULL, otherwise the string \c &q=
uot;[NULL]&quot;=2E</span><br><span>  */</span><br><span> const char *np(co=
nst char *str);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-/* character classes */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** @=
name Character classes</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  @brief Check or modify strings based on classes of allowed</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *         or forbidden chara=
cters=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/**@{*/</span><br><span> #d=
efine CC_ANY  (1 &lt;&lt; 0)           /**&lt; any character */</span><br><=
span> #define CC_NULL (1 &lt;&lt; 1)           /**&lt; null character \0 */=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#de=
fine CC_ALNUM  (1 &lt;&lt; 2)         /**&lt; alphanumeric isalnum() */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_ALPHA  (1 &lt;=
&lt; 3)         /**&lt; alphabetic isalpha() */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define CC_ALNUM  (1 &lt;&lt; 2)         /**&lt=
; alphanumeric \c isalnum() */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define CC_ALPHA  (1 &lt;&lt; 3)         /**&lt; alphabetic \c i=
salpha() */</span><br><span> #define CC_ASCII  (1 &lt;&lt; 4)         /**&l=
t; ASCII character */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define CC_CNTRL  (1 &lt;&lt; 5)         /**&lt; control character iscntrl(=
) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_DIGIT =
 (1 &lt;&lt; 6)         /**&lt; digit isdigit() */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define CC_CNTRL  (1 &lt;&lt; 5)         /**=
&lt; control character \c iscntrl() */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define CC_DIGIT  (1 &lt;&lt; 6)         /**&lt; digit \=
c isdigit() */</span><br><span> #define CC_PRINT  (1 &lt;&lt; 7)         /*=
*&lt; printable (&gt;=3D 32, !=3D 127) */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define CC_PUNCT  (1 &lt;&lt; 8)         /**&lt; punctu=
ation ispunct() */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#de=
fine CC_SPACE  (1 &lt;&lt; 9)         /**&lt; whitespace isspace() */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_XDIGIT (1 &lt;&l=
t; 10)        /**&lt; hex digit isxdigit() */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define CC_PUNCT  (1 &lt;&lt; 8)         /**&lt; =
punctuation \c ispunct() */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define CC_SPACE  (1 &lt;&lt; 9)         /**&lt; whitespace \c issp=
ace() */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CC_=
XDIGIT (1 &lt;&lt; 10)        /**&lt; hex digit \c isxdigit() */</span><br>=
<span> </span><br><span> #define CC_BLANK   (1 &lt;&lt; 11)       /**&lt; s=
pace or tab */</span><br><span> #define CC_NEWLINE (1 &lt;&lt; 12)       /*=
*&lt; newline */</span><br><span>@@ -918,8 +1653,27 @@</span><br><span> #de=
fine CC_NAME (CC_ALNUM | CC_UNDERBAR) /**&lt; alphanumeric plus underscore =
*/</span><br><span> #define CC_CRLF (CC_CR | CC_NEWLINE)     /**&lt; carria=
ge return or newline */</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Test whether a character belongs to one or more character classes=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param c      The character to=
 test=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param f=
lags  Bitmask of \c CC_* character class flags=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @return true if \c c matches any of the classes specified i=
n \c flags=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span> bool char_class(const unsigned char c, const unsigned int fl=
ags);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Test whet=
her all characters in a string satisfy a character class filter=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param str        The null-terminated stri=
ng to test=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram inclusive  Classes that are permitted (characters must match at</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *                   least =
one of these)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param exclusive  Classes that are forbidden (characters must not match</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                   an=
y of these, even if they also match \c inclusive)=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return true if every character in \c str is permitted=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan> bool string_class(const char *str, const unsigned int inclusive, const=
 unsigned int exclusive);</span><br><span> </span><br><span> /**</span><br>=
<span>@@ -966,10 +1720,27 @@</span><br><span>  */</span><br><span> const ch=
ar *string_mod_const(const char *str, const unsigned int inclusive,</span><=
br><span>                              const unsigned int exclusive, const =
char replace, struct gc_arena *gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/**@}*/</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Replace all leading occurrences of a character in a string=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Scans from the start of \c str and rep=
laces every consecutive \c match</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * character with \c replace, stopping at the first character =
that does not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * mat=
ch=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param str      The null-ter=
minated string to modify in place=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param match    The character to replace=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param replace  The replacem=
ent character=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */=
</span><br><span> void string_replace_leading(char *str, const char match, =
const char replace);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-/** Return true iff str starts with prefix */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * Return true iff \c str starts with \c prefix=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param str     The string to t=
est=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param pre=
fix  The prefix to look for=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span> static inline bool</span><br><span> strpref=
ix(const char *str, const char *prefix)</span><br><span> {</span><br><span>=
@@ -1004,6 +1775,16 @@</span><br><span>  * Verify that a pointer is correct=
ly aligned</span><br><span>  */</span><br><span> #ifdef VERIFY_ALIGNMENT</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Assert that the content pointer of =
\c buf is 4-byte aligned=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Only c=
ompiled in when \c VERIFY_ALIGNMENT is defined=2E  Called via the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * \c verify_align_4() macro=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   Buffer whose cont=
ent pointer is to be checked=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param file  Source file of the call site (for the error mes=
sage)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param l=
ine  Source line of the call site (for the error message)=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> void valign4(=
const struct buffer *buf, const char *file, const int line);</span><br><spa=
n> </span><br><span> #define verify_align_4(ptr) valign4(buf, __FILE__, __L=
INE__)</span><br><span>@@ -1011,23 +1792,58 @@</span><br><span> #define ver=
ify_align_4(ptr)</span><br><span> #endif</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * Very basic garbage collection, mostly for routines tha=
t return</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * char ptrs =
to malloced strings=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/** @name Garbage Collection</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  @brief Basic garbage collection, mostly for routines that r=
eturn</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         cha=
r ptrs to malloced strings=2E</span><br><span>  */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/**@{*/</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Move all allocations from one garbage collection ar=
ena to another=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * After the call \=
c src is empty and all entries previously in \c src are</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * owned by \c dest=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param dest  Arena to move allocations into=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param src   Arena t=
o move allocations from (emptied on return)=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span> void gc_transfer(struct gc_=
arena *dest, struct gc_arena *src);</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Free all plain allocations in a garbage collection are=
na=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * Internal implementation call=
ed by \c gc_free()=2E  Do not call directly=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param a  The arena whose \c list entries are to be freed=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> =
void x_gc_free(struct gc_arena *a);</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Free all specially-allocated entries in a garbage coll=
ection arena=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Internal implement=
ation called by \c gc_free()=2E  Do not call directly=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Invokes the custom free function st=
ored in each \c gc_entry_special=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param a  The arena whose \c list_special entries are to be freed=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> voi=
d x_gc_freespecial(struct gc_arena *a);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Return true iff the arena contains at least one al=
location=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param a  The arena to=
 test=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><=
br><span> static inline bool</span><br><span> gc_defined(struct gc_arena *a=
)</span><br><span> {</span><br><span>     return a-&gt;list !=3D NULL;</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
Initialise a garbage collection arena to an empty state=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param a  The arena to initialise=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inlin=
e void</span><br><span> gc_init(struct gc_arena *a)</span><br><span> {</spa=
n><br><span>@@ -1035,12 +1851,25 @@</span><br><span>     a-&gt;list_special=
 =3D NULL;</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Detach all allocations from an arena without freeing them=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * After this call the arena is empt=
y=2E  The caller takes responsibility for</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * freeing the previously registered allocations=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param a  The arena to detach=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> s=
tatic inline void</span><br><span> gc_detach(struct gc_arena *a)</span><br>=
<span> {</span><br><span>     gc_init(a);</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Allocate and return a new, em=
pty garbage collection arena=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @r=
eturn An initialised \c gc_arena with empty lists=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inline struct=
 gc_arena</span><br><span> gc_new(void)</span><br><span> {</span><br><span>=
@@ -1049,6 +1878,14 @@</span><br><span>     return ret;</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Free all alloca=
tions in a garbage collection arena=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Calls \c x_gc_free() and \c x_gc_freespecial() as needed to release al=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * registered memo=
ry=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param a  The arena to free=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan> static inline void</span><br><span> gc_free(struct gc_arena *a)</span>=
<br><span> {</span><br><span>@@ -1062,6 +1899,13 @@</span><br><span>     }<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Free all allocations in a garbage collection arena and reinitialise it=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Equivalent to calling \c gc_fr=
ee() followed by \c gc_init()=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param a  The arena to reset=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span> static inline void</span><br><span> gc_rese=
t(struct gc_arena *a)</span><br><span> {</span><br><span>@@ -1079,58 +1923,=
139 @@</span><br><span> /* 1 GB on 32bit systems, they usually can only all=
ocate 2 GB for the</span><br><span>  * whole process=2E</span><br><span>  *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Maximum size f=
or a single array allocation (checked by \c array_mult_safe())=2E */</span>=
<br><span> #define ALLOC_SIZE_MAX (1u &lt;&lt; 30)</span><br><span> #else</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Maximum size for =
a single array allocation (checked by \c array_mult_safe())=2E */</span><br=
><span> #define ALLOC_SIZE_MAX ((size_t)1 &lt;&lt; 32) /* 4 GB */</span><br=
><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
Allocate memory for a single object of the given type=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Calls \c check_malloc_return() to abort on allocatio=
n failure=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dptr  Pointer =
variable that receives the allocation=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param type  Type of the object to allocate=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> #de=
fine ALLOC_OBJ(dptr, type)                                       \</span><b=
r><span>     {                                                             =
  \</span><br><span>         check_malloc_return((dptr) =3D (type *)malloc(=
sizeof(type))); \</span><br><span>     }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Allocate and zero-initialise memory for a single =
object of the given type=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 dptr  Pointer variable that receives the allocation=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param type  Type of the object to a=
llocate=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span> #define ALLOC_OBJ_CLEAR(dptr, type)      \</span><br><span>    =
 {                                    \</span><br><span>         ALLOC_OBJ(=
dptr, type);           \</span><br><span>         memset((dptr), 0, sizeof(=
type)); \</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * Allocate memory for an array of \c n elements of the give=
n type=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * Uses \c array_mult_safe(=
) to guard against size overflow=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * Calls \c check_malloc_return() to abort on allocation fa=
ilure=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dptr  Pointer vari=
able that receives the allocation=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param type  Element type of the array=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param n     Number of element=
s=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span> #define ALLOC_ARRAY(dptr, type, n)                                   =
                        \</span><br><span>     {                           =
                                                             \</span><br><s=
pan>         check_malloc_return((dptr) =3D (type *)malloc(array_mult_safe(=
sizeof(type), (n), 0))); \</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Allocate a garbage-collected array of =
\c n elements of the given type=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param dptr  Pointer variable that receives the allocation=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param type  Element type of =
the array=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am n     Number of elements=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param gc    Garbage collection arena to register the allocat=
ion with=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</spa=
n><br><span> #define ALLOC_ARRAY_GC(dptr, type, n, gc)                     =
                          \</span><br><span>     {                         =
                                                          \</span><br><span=
>         (dptr) =3D (type *)gc_malloc(array_mult_safe(sizeof(type), (n), 0=
), false, (gc)); \</span><br><span>     }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * Allocate and zero-initialise an array of \c n el=
ements of the given type=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 dptr  Pointer variable that receives the allocation=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param type  Element type of the arr=
ay=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param n   =
  Number of elements=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ */</span><br><span> #define ALLOC_ARRAY_CLEAR(dptr, type, n)          =
                  \</span><br><span>     {                                 =
                              \</span><br><span>         ALLOC_ARRAY(dptr, =
type, n);                                 \</span><br><span>         memset=
((dptr), 0, (array_mult_safe(sizeof(type), (n), 0))); \</span><br><span>   =
  }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Allocate an=
d zero-initialise a garbage-collected array of \c n elements=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param dptr  Pointer variable that receives t=
he allocation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param type  Element type of the array=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param n     Number of elements=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param gc    Garbage collection =
arena to register the allocation with=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span> #define ALLOC_ARRAY_CLEAR_GC(dptr=
, type, n, gc)                                        \</span><br><span>   =
  {                                                                        =
          \</span><br><span>         (dptr) =3D (type *)gc_malloc(array_mul=
t_safe(sizeof(type), (n), 0), true, (gc)); \</span><br><span>     }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Allocate and zero-init=
ialise a garbage-collected variable-length structure=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Allocates \c sizeof(type) + \c n * \c sizeof(atype) b=
ytes for a structure</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * that embeds a variable-length array of \c atype as its last member=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param dptr   Pointer variable that=
 receives the allocation=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param type   Type of the enclosing structure=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param atype  Element type of th=
e variable-length array member=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param n      Number of array elements=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param gc     Garbage collection =
arena to register the allocation with=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span> #define ALLOC_VAR_ARRAY_CLEAR_GC(=
dptr, type, atype, n, gc)                                         \</span><=
br><span>     {                                                            =
                                  \</span><br><span>         (dptr) =3D (ty=
pe *)gc_malloc(array_mult_safe(sizeof(atype), (n), sizeof(type)), true, (gc=
)); \</span><br><span>     }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Allocate a garbage-collected object of the given type (uninit=
ialised)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dptr  Pointer v=
ariable that receives the allocation=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param type  Type of the object to allocate=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param gc    Garbage c=
ollection arena to register the allocation with=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span> #define ALLOC_OBJ_GC(dp=
tr, type, gc)                           \</span><br><span>     {           =
                                               \</span><br><span>         (=
dptr) =3D (type *)gc_malloc(sizeof(type), false, (gc)); \</span><br><span> =
    }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Allocate =
and zero-initialise a garbage-collected object of the given type=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param dptr  Pointer variable that receiv=
es the allocation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param type  Type of the object to allocate=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param gc    Garbage collection arena to =
register the allocation with=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span> #define ALLOC_OBJ_CLEAR_GC(dptr, type, gc)=
                    \</span><br><span>     {                               =
                          \</span><br><span>         (dptr) =3D (type *)gc_=
malloc(sizeof(type), true, (gc)); \</span><br><span>     }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Abort if a memory allocation re=
turned NULL=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param p  Return va=
lue from \c malloc() or similar; calls \c out_of_memory()</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *           if \c p is NULL=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> stat=
ic inline void</span><br><span> check_malloc_return(void *p)</span><br><spa=
n> {</span><br><span>@@ -1139,22 +2064,28 @@</span><br><span>         out_o=
f_memory();</span><br><span>     }</span><br><span> }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**@}*/</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* End of GC */</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * Manage lists of buffers</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/** @name Buffer Lists</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  @brief Manage lists of buffers</span><br><span=
>  */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**@{*/</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/** One node in a \c buffer_list linked list=
=2E */</span><br><span> struct buffer_entry</span><br><span> {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    struct buffer buf;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer_entry *next;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf;=
         /**&lt; The buffer stored in this list node=2E */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct buffer_entry *next; /**&l=
t; Pointer to the next node, or NULL=2E */</span><br><span> };</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** A singly-l=
inked list of buffers, with head/tail pointers for O(1) push=2E */</span><b=
r><span> struct buffer_list</span><br><span> {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    struct buffer_entry *head; /* next item to pop=
/peek */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct bu=
ffer_entry *tail; /* last item pushed */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    size_t size;               /* current number of entr=
ies */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t max_=
size;           /* maximum size list should grow to */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct buffer_entry *head; /**&lt; N=
ext item to pop/peek=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct buffer_entry *tail; /**&lt; Last item pushed=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t size;          =
     /**&lt; Current number of entries=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    size_t max_size;           /**&lt; Maximum num=
ber of entries allowed=2E */</span><br><span> };</span><br><span> </span><b=
r><span> /**</span><br><span>@@ -1215,8 +2146,24 @@</span><br><span>  */</s=
pan><br><span> struct buffer *buffer_list_peek(struct buffer_list *ol);</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Advance past \c n =
bytes in the head buffer, popping it if it becomes empty=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * \c n must not exceed the length of the head buffe=
r; passing a larger value</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * triggers an assertion failure=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param ol  The list whose head buffer is to be advanced=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param n   Number of byte=
s to skip in the head buffer=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span> void buffer_list_advance(struct buffer_lis=
t *ol, ssize_t n);</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Remove and free the head buffer of the list=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Does nothing if \c ol is NULL or empty=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param ol  The list to pop from=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> void buffer_li=
st_pop(struct buffer_list *ol);</span><br><span> </span><br><span> /**</spa=
n><br><span>@@ -1244,6 +2191,20 @@</span><br><span>  */</span><br><span> vo=
id buffer_list_aggregate_separator(struct buffer_list *bl, const size_t max=
_len, const char *sep);</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Read a file into a buffer list, one buffer per line=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * Opens \c fn for reading and pushes each line =
into a newly allocated buffer</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * list using \c fgets()=2E  Lines longer than \c max_line_len - =
1 bytes are</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * split=
 across multiple consecutive buffers=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param fn            Path to the file to read=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param max_line_len  Maximum number o=
f bytes (including null terminator)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *                      read per \c fgets() call=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @return Pointer to the new buffer list, o=
r NULL if the file could not be</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *         opened or memory allocation failed=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> struct buffer=
_list *buffer_list_file(const char *fn, int max_line_len);</span><br><span>=
 </span><br><span> /**</span><br><span>@@ -1257,5 +2218,7 @@</span><br><spa=
n>  * error</span><br><span>  */</span><br><span> struct buffer buffer_read=
_from_file(const char *filename, struct gc_arena *gc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/**@}*/</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/* End of Buffer Lists */</span><br><span> </span><b=
r><span> #endif /* BUFFER_H */</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1581?usp=3Demai=
l">change 1581</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/15=
81?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: I350ca5b08379ede1480b81055d35dd9a33e30cff </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 1581 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: fl=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--ccj21uU3UB0=--


--===============2862040789276920658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2862040789276920658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2862040789276920658==--

