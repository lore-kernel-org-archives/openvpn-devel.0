Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A50BC9832A
	for <openvpn-devel@archiver.kernel.org>; Sun, 27 Sep 2026 02:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Content-Type:To:Message-ID:Date
	:From:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fUJXcsadriwJcqyV1WtDkUrz6dYP4iwOxMhJ4xNXQZA=; b=Qd+7CNYiQFV9kDrxi/4YLSLsyw
	sisaNDHgToAGhZ2Bc8cv1ptkMUe5LOZ33QqgVaP/nNz4nbBUh1zayrIKWMwP9wyRHLlgGqLdMFDdQ
	PKkng0p/mSHWE/Er9PzQ7YBiFHaK8tbX5qFfcOmYG0AVoCeSzWTGDgfbRQj/JjSQnT1w=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xAeu8-0000HU-TH;
	Sun, 27 Sep 2026 02:46:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <planetman1125@gmail.com>) id 1xAeu6-0000HJ-SX
 for openvpn-devel@lists.sourceforge.net;
 Sun, 27 Sep 2026 02:46:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:Subject:Message-ID:Date:From:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XTQi0RPSBYo+KkiZvBjckdiBZYt3Q9De5+9sk3ITUhc=; b=ITEgZcRYRuq6aPEX2gIEB6/zHU
 2NAuJ0te01cdZMu7NRAS7HUV+XIgSNHdIhQC/viNvpW5flY+QUwhR3q38q3l2I9mR+HFFV39qKOyx
 NYu0qvEzJ1OHPEiIAj9VH/NN1fiOhI/iHOdG5r4u0PB7KlaeFj0MgIt8lhwwsDbRpYnk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:Subject:Message-ID:Date:From:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XTQi0RPSBYo+KkiZvBjckdiBZYt3Q9De5+9sk3ITUhc=; b=h
 ytXTVLPZ/MGaHkAz4tZo7QhCs/d0qjd26HyuY5Ry5WVFSzAHgOUZ83rwPZPJaffVL5xZs3qfN1jbK
 f+XphPyAcvtTAL8oJpqjzVTDVwsFn4BpJBd6w5VwyAceKJeg3txbTILeKIg9MpF4xzLkMIKNzs1TY
 iGRLo6M+hJAzT4VI=;
Received: from mail-qt1-f173.google.com ([209.85.160.173])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xAeu3-0002Ix-Vx for openvpn-devel@lists.sourceforge.net;
 Sun, 27 Sep 2026 02:46:12 +0000
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-53328262f7aso6892261cf.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 26 Sep 2026 19:46:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790477166; cv=none;
 d=google.com; s=arc-20260327;
 b=O1klgt8NkiVJfVsLtbUTgiXVaoBjstnmJ4oFC8cK09vruj82qmM8wC1mlJO+40An91
 OAPGhgQtql5/YQVHxr1e8BgkX+ryIg9dI1RQBzlXB694Cwd0U87yk2bRYxCUHcFGJrMz
 p0yhEuSZHLDU3e61haixK8VCLplNMt8cLZniPFg1HDlafyIDSfCGtOnbaqdm6Sy6IaWa
 Qecb/iAPm0wWYr4kinQn/7UrtyymfcsuLMpCrjVku1xVwT9IURaAqXqYX2L3YPa0+n4k
 XRYwC0WJMjPqPMX5BByLHFP3KMBYjdf4RN32sRG2L8ScRBIUAkJA+LQpnbxtoKeGAUDu
 Cptw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=XTQi0RPSBYo+KkiZvBjckdiBZYt3Q9De5+9sk3ITUhc=;
 fh=4NbAC/LsuMLI0S0hprUlLSLCiHwg6SCAifhH718Jh0Q=;
 b=hgCY+EPej4fcB3RngtRkCd4Xpy5dFxCPKUjMGskF+krbUwqsPJ/2ZZFOq3jjoeEMiF
 Lo3/qD0iBHl5GuX0Wua1RcLLQYIohXDCmJGRUVjTv2Zt0xEQTwFmWPRWXMHJ3n7B+4lI
 YDorQNEzlDIGssScg/XyrxIloGJ3ZuXIgw1N9UKw18CjIMR9CdHO125aq4rZWlOqjzzd
 N6I1Ab+uUg70iCmjjuYcmwNEEp+Uc5sJQLzvkZHpaY5GpOSiQMd28KFC+SVlyc5diFYO
 qTOWC2MFYLtod41F6ey5eBaezO93iDe4PTAjMSE9yzaDqUcizMP6aIAImsKKxrZFYZFo
 cuXw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790477166; x=1791081966; darn=lists.sourceforge.net;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XTQi0RPSBYo+KkiZvBjckdiBZYt3Q9De5+9sk3ITUhc=;
 b=PG/0Lva9MKOU4ZELxmAe5aGYbyB4rW5M17/CnSSV7hsSTZ+Ge7jAit0FvXIkE8M94s
 Dh5neOq0JXI0o+Vyjn4WeBjfBE69npz3Gd2jretsDw3JZAFuLB8Z8wDMLs7rLYIfed6j
 eHYMWME3SE3HOX4cRKl1sfUIUJfRQ4DOI/VywlnAMJDYX1GE/qa0LIOedMNvDaLM5MMe
 shUtBztpFsGiOpmAV/DcxrwUd8PEpx5RoknEHK8yLQUuI9lYmWeYXX7m7iaUISRyCUAX
 8csraKv1avrIujfislLU4vPbts2t+l0rfN6LtSZ9Ub+U3+mSeZe6TGpI2MIK/I8kpWVV
 WHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790477166; x=1791081966;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XTQi0RPSBYo+KkiZvBjckdiBZYt3Q9De5+9sk3ITUhc=;
 b=cmzN61Q5VLxl6woUA55EM8f9QpetG+5JlNGzvfPgWzv63lBI0KG67tqHDia57fZ2r9
 qx2ki/whdjztdR1eq1TC3YafudHuUp3Ctpgf9WLZ1QAms5NbqDzXGo16KfP0Zo7ZEyMk
 hBjCoYyRAANVER9ma5lFJAxFmZ3RmmAskHpY3yT0Tfa3R4RLdjkQHDSwiUCHbSMYAJPt
 3bVvdCEe8MufDokW/cXd+vcTwk/aLipbl0+WGo4oWI1dPw5+T/27WvkY2VZZO5wwDJVB
 +uvX8djvIL94YWvD2x3OcZQMPSKSjyCgd3fxdRIjRm46kaJy+8vkuPrQbVEHG5ZSrtQg
 SSgQ==
X-Gm-Message-State: AFuF++noNikljEXDtzGaQ/VvytnUEwKK5ZEu27es7jzo+3mzBjQtZikn
 jqyFeS+k3/ePtIIGvwVH+LoWZTpWCdJMLzsFlu62D+3x/JwapjLdADZSnoSZb5LYKbBjkvUISob
 ympEqM98XsPwf0TOslzoUIpoUP9KUKRfFJHPffc9g8g==
X-Gm-Gg: AYBFou2MnkVi2TKpwlk9oM2Cw4PjIkMR2r4XpEOdzWi2Ta1cluf5XakkWSLeKPLkiBF
 zzJLie0S/knEvQWK4xUhbz4Oa5hPwk1qPbvLYgRHkdxHzcOrl2zRp7JTs395DToNGxv43f4QfpX
 F+pI5jZORsTo8GxoUGCiN5mApSyX5KG26EkImqloBiIj3CJG/6wpNN3WfXmDCy/NHdUFN3/Qyhd
 Y6uUNndKvUL59kou+TPwBEuLm4Kni9hr6WFk/10y+uMFkOCZJHDY9i3ylGWEozuzN0w6OB7HHfh
 vAE4G16pMKRlzaWzNzJMA42643xxQQeHRQooTKoGsZ3nOjubYZ/yLvV3eG/WYVUI60uezaxEny6
 TUk1PgYAEH8JypLzjCu2yaxzTLQkLcCvU/MDftTI+NcKg6qdmMCgBQfY=
X-Received: by 2002:a05:622a:e344:10b0:533:286b:f7ee with SMTP id
 d75a77b69052e-533286c028amr34812301cf.9.1790477165952; Sat, 26 Sep 2026
 19:46:05 -0700 (PDT)
MIME-Version: 1.0
From: andrew gonzalez <planetman1125@gmail.com>
Date: Sat, 26 Sep 2026 22:45:54 -0400
X-Gm-Features: AclHuK-wKebZYaPHtxNDH4WGrfkFAX1zYB6vMX08pgoiRhZZU6wm4zQb0aYpn20
Message-ID: <CAKSN52KvZxMzq4bsW6WC9A2ZAi3KqPQ0KDP5hCgNJ6PVs7pXgQ@mail.gmail.com>
To: openvpn-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="00000000000074ee7b065c6df3ce"
X-Headers-End: 1xAeu3-0002Ix-Vx
Subject: [Openvpn-devel] [PATCH] buffer: make buf_valid() and buf_defined()
 NULL-safe
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
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--00000000000074ee7b065c6df3ce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is a hardening change, not a security fix =E2=80=94 I want to be clear
about that up front.

`buf_len()` looks like it tolerates an unusable buffer (it returns 0
when `buf_valid()` says no), but `buf_valid()` dereferences the
pointer before testing anything, so `buf_len(NULL)` faults inside its
own validity check. Eight helpers in `buffer.h` gate on `buf_valid()`.

bc7f77ea fixed a pre-auth SIGSEGV whose proximate cause was exactly
`buf_len(NULL)` on `tls_crypt_v2_wkc`. I checked that fix and it is
complete =E2=80=94 `CO_RESEND_WKC` has a single setter and it is now guarde=
d,
so both sinks are unreachable today. This patch just removes the edge
for the next caller.

The `likely()` markers keep the hot path unchanged. The regression
test is validated rather than vacuous: with only `buffer.h` reverted,
`buffer_testdriver` reports 22 run / 21 passed / 1 failed
(`test_buffer_null_predicates`); with the patch applied it is 22/22.
On current master, all 16 test drivers pass on macOS.

Happy to drop the `buf_defined()` half, or to narrow this to
`buf_len()` only, if you would rather not add a branch to
`buf_valid()`.

--00000000000074ee7b065c6df3ce
Content-Type: application/octet-stream; 
	name="0001-buffer-make-buf_valid-and-buf_defined-NULL-safe.patch"
Content-Disposition: attachment; 
	filename="0001-buffer-make-buf_valid-and-buf_defined-NULL-safe.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_muj7v8dz0>
X-Attachment-Id: f_muj7v8dz0

RnJvbSA3NmU0Y2QzN2FiNWZiMWQyOWZhZjJmNzExMTM3MDU5Yjc5OGNmYTQ4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZXcgR29uemFsZXogPHBsYW5ldG1hbjExMjVAZ21haWwu
Y29tPgpEYXRlOiBTYXQsIDI2IFNlcCAyMDI2IDE3OjA0OjAxIC0wNDAwClN1YmplY3Q6IFtQQVRD
SF0gYnVmZmVyOiBtYWtlIGJ1Zl92YWxpZCgpIGFuZCBidWZfZGVmaW5lZCgpIE5VTEwtc2FmZQoK
YnVmX2xlbigpIGlzIHdyaXR0ZW4gdG8gdG9sZXJhdGUgYW4gdW51c2FibGUgYnVmZmVyIC0tIGl0
IHJldHVybnMgMCB3aGVuCmJ1Zl92YWxpZCgpIHNheXMgbm8uIEl0IGNhbm5vdCwgYmVjYXVzZSBi
dWZfdmFsaWQoKSBkZXJlZmVyZW5jZXMgdGhlCnBvaW50ZXIgYmVmb3JlIHRlc3RpbmcgYW55dGhp
bmc6CgogICAgcmV0dXJuIGxpa2VseShidWYtPmRhdGEgIT0gTlVMTCkgJiYgbGlrZWx5KGJ1Zi0+
bGVuID49IDApOwoKU28gYnVmX2xlbihOVUxMKSBjcmFzaGVzIGluc2lkZSBpdHMgb3duIHZhbGlk
aXR5IGNoZWNrLCBhbmQgc28gZG9lcyBldmVyeQpvdGhlciBidWZfKiBoZWxwZXIgdGhhdCBnYXRl
cyBvbiBidWZfdmFsaWQoKS4gYnVmX2RlZmluZWQoKSBoYXMgdGhlIHNhbWUKc2hhcGUuCgpUaGlz
IGlzIG5vdCBoeXBvdGhldGljYWwuIENvbW1pdCBiYzdmNzdlYSAoInNzbDogZG8gbm90IHRydXN0
IHRoZSBwZWVyJ3MKcmVxdWVzdCB0byByZXNlbmQgdGhlIHdyYXBwZWQgY2xpZW50IGtleSIpIGZp
eGVkIGEgcHJlLWF1dGhlbnRpY2F0aW9uClNJR1NFR1Ygd2hvc2UgcHJveGltYXRlIGNhdXNlIHdh
cyBleGFjdGx5IHRoaXM6IGEgcGVlci1zdXBwbGllZApFQVJMWV9ORUdfRkxBR19SRVNFTkRfV0tD
IG1hZGUgY29udHJvbF9wYWNrZXRfbmVlZHNfd2tjKCkgdHJ1ZSBvbiBhIGNsaWVudAp3aXRob3V0
IC0tdGxzLWNyeXB0LXYyLCBhbmQgd3JpdGVfb3V0Z29pbmdfdGxzX2NpcGhlcnRleHQoKSB0aGVu
IGV2YWx1YXRlZAoKICAgIG1heGxlbiAtPSBidWZfbGVuKHNlc3Npb24tPnRsc193cmFwLnRsc19j
cnlwdF92Ml93a2MpOwoKd2l0aCBhIE5VTEwgdGxzX2NyeXB0X3YyX3drYy4gVGhhdCBmaXggcmVt
b3ZlZCB0aGUgb25lIHJvdXRlIHRvIHRoZSBzaW5rLAp3aGljaCB3YXMgY29ycmVjdCBhbmQgc3Vm
ZmljaWVudCBmb3IgdGhlIGJ1ZyBhdCBoYW5kLCBidXQgaXQgbGVmdCB0aGUKc2hhcnAgZWRnZSBp
biBwbGFjZSBmb3IgdGhlIG5leHQgY2FsbGVyOiBhIHByZWRpY2F0ZSBuYW1lZCAidmFsaWQiIHRo
YXQKZmF1bHRzIG9uIHRoZSBjb21tb25lc3QgaW52YWxpZCBpbnB1dC4KCkFkZCB0aGUgTlVMTCB0
ZXN0IHRvIGJvdGggcHJlZGljYXRlcy4gRWlnaHQgaGVscGVycyBpbiBidWZmZXIuaCBnYXRlIG9u
CmJ1Zl92YWxpZCgpLCBzbyB0aGV5IGFsbCBiZWNvbWUgTlVMTC10b2xlcmFudCwgYW5kIGNhbGxl
cnMgdGhhdCByZWFzb25hYmx5CmV4cGVjdCBidWZfbGVuKE5VTEwpID09IDAgZ2V0IGl0LiBUaGUg
Y2hlY2tzIGFyZSBtYXJrZWQgbGlrZWx5KCksIHNvIHRoZQpob3QgcGF0aCBpcyB1bmNoYW5nZWQu
CgpBZGQgYSByZWdyZXNzaW9uIHRlc3QgY292ZXJpbmcgTlVMTCBhbmQgZnJlZWQgYnVmZmVycyBm
b3IgYnVmX2RlZmluZWQoKSwKYnVmX3ZhbGlkKCkgYW5kIGJ1Zl9sZW4oKS4gSXQgZmFpbHMgYmVm
b3JlIHRoaXMgY2hhbmdlIGFuZCBwYXNzZXMgYWZ0ZXIuCgpTaWduZWQtb2ZmLWJ5OiBBbmRyZXcg
R29uemFsZXogPHBsYW5ldG1hbjExMjVAZ21haWwuY29tPgotLS0KIHNyYy9vcGVudnBuL2J1ZmZl
ci5oICAgICAgICAgICAgICAgICAgIHwgMTQgKysrKysrKystLS0tLS0KIHRlc3RzL3VuaXRfdGVz
dHMvb3BlbnZwbi90ZXN0X2J1ZmZlci5jIHwgMjMgKysrKysrKysrKysrKysrKysrKysrKysKIDIg
ZmlsZXMgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9zcmMvb3BlbnZwbi9idWZmZXIuaCBiL3NyYy9vcGVudnBuL2J1ZmZlci5oCmluZGV4IDIy
YThiNzQuLjU4ZTEwZjAgMTAwNjQ0Ci0tLSBhL3NyYy9vcGVudnBuL2J1ZmZlci5oCisrKyBiL3Ny
Yy9vcGVudnBuL2J1ZmZlci5oCkBAIC0zOTIsMjYgKzM5MiwyOCBAQCBjbGVhcl9idWYodm9pZCkK
ICAqIEEgZGVmaW5lZCBidWZmZXIgaGFzIGJlZW4gYWxsb2NhdGVkIGJ1dCBtYXkgaGF2ZSB6ZXJv
IGxlbmd0aCBvciBuZWdhdGl2ZQogICogbGVuIChpLmUuIGl0IGlzIG5vdCBuZWNlc3NhcmlseSB2
YWxpZCkuCiAgKgotICogQHBhcmFtIGJ1ZiAgIFRoZSBidWZmZXIgdG8gdGVzdC4KKyAqIEBwYXJh
bSBidWYgICBUaGUgYnVmZmVyIHRvIHRlc3QuIE1heSBiZSBOVUxMLCBpbiB3aGljaCBjYXNlIHRo
ZSBidWZmZXIgaXMKKyAqICAgICAgICAgICAgICBub3QgZGVmaW5lZC4KICAqLwogc3RhdGljIGlu
bGluZSBib29sCiBidWZfZGVmaW5lZChjb25zdCBzdHJ1Y3QgYnVmZmVyICpidWYpCiB7Ci0gICAg
cmV0dXJuIGJ1Zi0+ZGF0YSAhPSBOVUxMOworICAgIHJldHVybiBsaWtlbHkoYnVmICE9IE5VTEwp
ICYmIGJ1Zi0+ZGF0YSAhPSBOVUxMOwogfQogCiAvKioKICAqIFJldHVybiB0cnVlIGlmZiBcYyBi
dWYgaXMgdmFsaWQuCiAgKgotICogQSBidWZmZXIgaXMgdmFsaWQgd2hlbiBpdHMgZGF0YSBwb2lu
dGVyIGlzIG5vbi1OVUxMIGFuZCBpdHMgXGMgbGVuIGlzCi0gKiBub24tbmVnYXRpdmUuCisgKiBB
IGJ1ZmZlciBpcyB2YWxpZCB3aGVuIGl0IGlzIG5vbi1OVUxMLCBpdHMgZGF0YSBwb2ludGVyIGlz
IG5vbi1OVUxMIGFuZCBpdHMKKyAqIFxjIGxlbiBpcyBub24tbmVnYXRpdmUuCiAgKgotICogQHBh
cmFtIGJ1ZiAgIFRoZSBidWZmZXIgdG8gdGVzdC4KKyAqIEBwYXJhbSBidWYgICBUaGUgYnVmZmVy
IHRvIHRlc3QuIE1heSBiZSBOVUxMLCBpbiB3aGljaCBjYXNlIHRoZSBidWZmZXIgaXMKKyAqICAg
ICAgICAgICAgICBub3QgdmFsaWQuCiAgKi8KIHN0YXRpYyBpbmxpbmUgYm9vbAogYnVmX3ZhbGlk
KGNvbnN0IHN0cnVjdCBidWZmZXIgKmJ1ZikKIHsKLSAgICByZXR1cm4gbGlrZWx5KGJ1Zi0+ZGF0
YSAhPSBOVUxMKSAmJiBsaWtlbHkoYnVmLT5sZW4gPj0gMCk7CisgICAgcmV0dXJuIGxpa2VseShi
dWYgIT0gTlVMTCkgJiYgbGlrZWx5KGJ1Zi0+ZGF0YSAhPSBOVUxMKSAmJiBsaWtlbHkoYnVmLT5s
ZW4gPj0gMCk7CiB9CiAKIC8qKgpkaWZmIC0tZ2l0IGEvdGVzdHMvdW5pdF90ZXN0cy9vcGVudnBu
L3Rlc3RfYnVmZmVyLmMgYi90ZXN0cy91bml0X3Rlc3RzL29wZW52cG4vdGVzdF9idWZmZXIuYwpp
bmRleCA3YmQwYzQ1Li4yOTQ1ZThhIDEwMDY0NAotLS0gYS90ZXN0cy91bml0X3Rlc3RzL29wZW52
cG4vdGVzdF9idWZmZXIuYworKysgYi90ZXN0cy91bml0X3Rlc3RzL29wZW52cG4vdGVzdF9idWZm
ZXIuYwpAQCAtNTE4LDYgKzUxOCwyOCBAQCB0ZXN0X2J1ZmZlcl9udWxsX3Rlcm1pbmF0ZSh2b2lk
ICoqc3RhdGUpCiAvKiBmb3IgYnVpbGRpbmcgbG9uZyB0ZXh0cyAqLwogI2RlZmluZSBBX1RJTUVT
XzI1NiAiQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB
QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB
QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB
QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB
QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBTyIKIAorc3RhdGljIHZvaWQKK3Rlc3Rf
YnVmZmVyX251bGxfcHJlZGljYXRlcyh2b2lkICoqc3RhdGUpCit7CisgICAgc3RydWN0IGJ1ZmZl
ciBidWYgPSBhbGxvY19idWYoMTYpOworCisgICAgLyogVGhlIHZhbGlkaXR5IHByZWRpY2F0ZXMg
bXVzdCB0b2xlcmF0ZSBhIE5VTEwgYnVmZmVyIHBvaW50ZXIgcmF0aGVyIHRoYW4KKyAgICAgKiBk
ZXJlZmVyZW5jaW5nIGl0LCBzbyB0aGF0IHRoZSB3aG9sZSBidWZfKiBmYW1pbHkgaXMgTlVMTC1z
YWZlLiAqLworICAgIGFzc2VydF9mYWxzZShidWZfZGVmaW5lZChOVUxMKSk7CisgICAgYXNzZXJ0
X2ZhbHNlKGJ1Zl92YWxpZChOVUxMKSk7CisgICAgYXNzZXJ0X2ludF9lcXVhbChidWZfbGVuKE5V
TEwpLCAwKTsKKworICAgIGFzc2VydF90cnVlKGJ1Zl9kZWZpbmVkKCZidWYpKTsKKyAgICBhc3Nl
cnRfdHJ1ZShidWZfdmFsaWQoJmJ1ZikpOworCisgICAgZnJlZV9idWYoJmJ1Zik7CisKKyAgICAv
KiBBIGZyZWVkIGJ1ZmZlciBpcyBuZWl0aGVyIGRlZmluZWQgbm9yIHZhbGlkLiAqLworICAgIGFz
c2VydF9mYWxzZShidWZfZGVmaW5lZCgmYnVmKSk7CisgICAgYXNzZXJ0X2ZhbHNlKGJ1Zl92YWxp
ZCgmYnVmKSk7CisgICAgYXNzZXJ0X2ludF9lcXVhbChidWZfbGVuKCZidWYpLCAwKTsKK30KKwog
dm9pZAogdGVzdF9idWZmZXJfcGFyc2Uodm9pZCAqKnN0YXRlKQogewpAQCAtNTk2LDYgKzYxOCw3
IEBAIG1haW4odm9pZCkKICAgICAgICAgY21vY2thX3VuaXRfdGVzdCh0ZXN0X2NoZWNrZWRfc25w
cmludGYpLAogICAgICAgICBjbW9ja2FfdW5pdF90ZXN0KHRlc3RfYnVmZmVyX2Nob21wKSwKICAg
ICAgICAgY21vY2thX3VuaXRfdGVzdCh0ZXN0X2J1ZmZlcl9udWxsX3Rlcm1pbmF0ZSksCisgICAg
ICAgIGNtb2NrYV91bml0X3Rlc3QodGVzdF9idWZmZXJfbnVsbF9wcmVkaWNhdGVzKSwKICAgICAg
ICAgY21vY2thX3VuaXRfdGVzdCh0ZXN0X2J1ZmZlcl9wYXJzZSksCiAgICAgICAgIGNtb2NrYV91
bml0X3Rlc3QodGVzdF9idWZmZXJfZXh0cmFjdF9maWVsZCkKICAgICB9OwotLSAKMi41NS4wCgo=
--00000000000074ee7b065c6df3ce
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--00000000000074ee7b065c6df3ce
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--00000000000074ee7b065c6df3ce--

