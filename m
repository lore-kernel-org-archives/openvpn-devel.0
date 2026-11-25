Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E58606A321
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 20:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=nCuBqFe1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OQ3TW4dc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PQFgTQ4H;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UChj4Kof
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Content-Type:To:Message-ID:Date
	:From:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=YrXkkNpxoJaklGR/mZFUEmDfj7HVxWEZBVFiNCqJj+4=; b=nCuBqFe1VAYmle9nOVm1PPz1xX
	uHxdBkPIfo5fQM0Na+mDtYDSTqAubLUUDmKV6yykuwGrc95Vtkoloo6DHzBtpsG2G6d2CY6b1RXpv
	5bq3ujpwbsqiSS+k0+nryC+JdvpnRjQ1BV7Y/+92Hywgqy2j4EK2lZelTVVERT3vk5YA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWJsY-0000000006k-1yUP;
	Wed, 25 Nov 2026 20:46:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <farshidrezaiyan@gmail.com>)
 id 1xWJsX-0000000006e-0Wp0 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 20:46:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:Subject:Message-ID:Date:From:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LZDZkffs5sZyS+19q2DaWOLCHIadnub2BnMVbvV+AKA=; b=OQ3TW4dcY/XOPQxl4ut3hk83vJ
 HxUx4SzrGb3tTRwYQqMOWOsWGKgjcggrwdiF2pXDpIyzocPNq2rOoWZbMy5xggk/uYeyQsmpL5axs
 /uJQLpBomIFovAvW5TTBTPQvm5pcwcykZBWMnjjPIIMX+GSXzfD2ohPoCGjyPBK0AlD0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:Subject:Message-ID:Date:From:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LZDZkffs5sZyS+19q2DaWOLCHIadnub2BnMVbvV+AKA=; b=PQFgTQ4HGVSWvxv8Jjgvnwv6s8
 mGRQl3Rg1DhClcv+oCICvED8aD3ZAQIP59sZsiUYaKbL0FioYp5MZYDUi2Uu0bH+FN0wGdarYJ6bA
 okBq8QzkaWFuAvNe7qmWyDYD++iueABpKwJofi6x1qgavOrPtLkfvJyoVkhIAzaf5Y70=;
Received: from mail-qt1-f182.google.com ([209.85.160.182])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWJsV-000000004Dh-2wbr for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 20:46:09 +0000
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-5365d26ccbdso69500451cf.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 12:46:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795639562; cv=none;
 d=google.com; s=arc-20260327;
 b=p9rzLWhZRlLVEq/WoD89pVPyMCeXqyXsIB2cs6NjjzwA0LMSsbmqjQCCzBIdqmIT7k
 MIEaQW0g2Ub2VigQUUGWTm0EioQrJiRWOwCpgUH/pStCTdUmSGUfcukzPIhjANHLy15C
 m2V6KUNpo1WxIsndnGQ0pdXYTtqMACoFMg9u2smC4vxOsKMPxtMmB7ptIgh7dEm/YLeH
 TEAG0IsUs2Q8+XQNLeHb1AX59XxGLbKVUbHXUsdBRCGhzB35tfquEgVFlU7BMHHPAmrj
 96V3MvOaFq9OrlF240RTMtcEOQWLAR2kMaoJR3kyvj7UgS2yNwdpUUP15Eceq4W5DfEX
 TTFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=LZDZkffs5sZyS+19q2DaWOLCHIadnub2BnMVbvV+AKA=;
 fh=4NbAC/LsuMLI0S0hprUlLSLCiHwg6SCAifhH718Jh0Q=;
 b=BrP3Le245LzCVSrxgmJwEbne93A8eEBxe9sOQZ1GHbZj2ft/0MiKkqFKJ+d0shT+e5
 Hww6BplFhiwHXA1F+QNsli4Ees+kc69TUHRYITXDxkAbrYnZ90ur7we6AAPnmykDciuW
 ju+1H+iCwAJUISJnotTlA2rKlTmOtJWkrSmKge5H3nJnNpBxX4k/3DvpLwq78auKx7Ly
 t/M2mCzdRVUF7deb2AjElXY79O1tDzAhhQqrKCleYxmbOQtv8jW6nqIJ9C9sNMuYXJsS
 weDxRJfor5Q6w7pT0CI8QUu9zeLfeurBZCApMJZrM+RT+ccLZkr+TkmK9hl1N0GGvgKP
 +/ug==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795639562; x=1796244362; darn=lists.sourceforge.net;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LZDZkffs5sZyS+19q2DaWOLCHIadnub2BnMVbvV+AKA=;
 b=UChj4Kofqgghusda5LWrVk9n5f21C6TgNo5yfMTjSo5qqwpny8D+kCuY3EwLwbg8Bl
 tdYyP2ZKzemma0WFEy2r0ne/1IlJ5RpX6IMPvdtdMEJNwzEufAIkxTh2GoLj+gjV8Wlc
 UXY/AXG6PVU1WZ8gcsklXeQbm41YVDkBmwGnOZbo2jhzwvRGOPlXPOInijwoUUXh38sr
 1kBVfVR1IFndBYPYKOjFQGnNKFBPmD3ugzbcNiV/kRC0Kq7GNsY2/KZirLM73nf+njp8
 vMMznu3FY254mcux1VAr3RXQzKLPGugEgm9P+PDYlFTVfBOmaN6VUVrKgbAZcZ7+/GqF
 b3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795639562; x=1796244362;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LZDZkffs5sZyS+19q2DaWOLCHIadnub2BnMVbvV+AKA=;
 b=mjruxr7SnKMbQEA4bQnO34NcvEX4IL61cJ6V4M61IMKGoRWAQWG2kxDwkNorgifvah
 Q9jdO+mu7p0hrzv0LbK1G4i9ahPrNsYcIM3xCk/LKLU5DuRNq+87pKhsStRJONHQydU/
 CC3V3ElSV4r0lXsSLnp91OZsE8JW3BingCxnNSd2gism1x+lHVTL62PoIquz+pkXS2r9
 c+ZyNJte4jNNCe9K9sodzWPB0UaFOlwAORExXNRvtI/Qqa5tpVqYq8oHonOETgZ3d5H9
 zVYKxGGm6iPr+xrO9yVGUdk4Nm5tOdtGiSl3Qd27NZ/bHYfHV3MVQMadAeEUd0Oy+LIf
 9FnA==
X-Gm-Message-State: APuU4Z8LyQqWF9rOCurWstUdINxjAdYrYKq1DFey79SKVFRfidi/P5qM
 tQyUQml+81D0crAN0VKoYthSPQaDelMBCbteDjfaRB9gCqRRth2oXyLDAlmsCqAlurDi3ZfU0UC
 P3X2+L+cvb1ax50gMY4zuwbSMhhsmZKA0OxCQQFmF8Q==
X-Gm-Gg: AZFdTZcSHVNhlSC4MkXRJJIpyhWKdnjki1KvY+h02zlld8+uG1c+EHV3zUAuxGvifDH
 HvbFey4Jz5CQT7KqKQv6d1TyXH390hJZZZYphCz5ICTqutZO2TDPkJBXLZhVUaWA9w51sIps5gO
 g55DyaOhScfZxleIsmfbqDHKHZRUXaee7zxZfiRm0ZrOh5Sz1J+80k3nSi0rQG/Sos3qAhQMxQL
 HYQfk3Xr85CugZXg/d0NtYmpZj9Jl6GAn+DYC2Kx2rjYGCEZwsXS2y0nsC7xU10gejbvStZnIA6
 V+TamdtlHd2LHEM6Z9F0C7/GZualabWOyihsgXCYED6j09QX//K/DGS0NSpPW/NV8GTzl3g3ze7
 TuhZfhL1A4gLrywF/qeGcDtLj6Rov1900DLATGnJiQm50l7+AmxTEuKgRbzE2uy8Z0FtVkX+pio
 8Bq895Cof01LdwIFpTJdfL
X-Received: by 2002:a05:622a:a10:b0:535:84e3:b165 with SMTP id
 d75a77b69052e-55d768a3030mr357162691cf.9.1795639561728; Wed, 25 Nov 2026
 12:46:01 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Farshid Rezaiyan <farshidrezaiyan@gmail.com>
Date: Thu, 26 Nov 2026 00:15:50 +0330
X-Gm-Features: Aa3M54ro1ilJudsVCrcb20fuEfBq7tbCWxrttGZkZGeqRsmszGoUYmXa-HYriy4
Message-ID: <CADJo8AbsiVxntM2bXe+RsjA756MvwiTqw9FLa7d5KT1q0YT3+g@mail.gmail.com>
To: openvpn-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="0000000000003929e906611fea17"
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xWJsV-000000004Dh-2wbr
Subject: [Openvpn-devel] [PATCH] multi: call client-disconnect handlers when
 late client setup fails
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000003929e906611fea17
Content-Type: text/plain; charset="UTF-8"

multi_client_connect_late_setup() is only reached after all
client-connect handlers (scripts and plugins) have succeeded. It sets
the state to CAS_CONNECT_DONE and then downgrades it to CAS_FAILED if
setting the protocol options, adding the DCO peer or generating the
data channel keys fails.

multi_close_instance() only calls the client-disconnect handlers for
instances in state CAS_CONNECT_DONE, so for such a client the
client-connect handlers have run but client-disconnect never does.
Anything that pairs the two calls gets out of sync. For example, a
RADIUS accounting plugin that sends Accounting-Start on connect and
Accounting-Stop on disconnect keeps the session open forever.

This is easy to hit with DCO on Linux and TCP: if the client closes
the TCP connection while a client-connect handler is running, the
kernel refuses to attach the socket ("provided TCP socket is not in
ESTABLISHED state") and dco_multi_add_new_peer() fails.

Remember in the new did_client_connect flag that a client-connect
plugin or script was called with success. This is the case if one is
defined, because multi_client_connect_late_setup() is only reached
when all client-connect handlers have succeeded.
multi_close_instance() then also calls the disconnect handlers for an
instance in CAS_FAILED that has this flag set. So they run on instance
shutdown and exactly once, as for any other client, and only after a
successful client-connect.

GitHub: closes OpenVPN/openvpn#1155
Signed-off-by: Farshid Rezaiyan <farshidrezaiyan@gmail.com>
---
This is the squashed patch of GitHub PR #1156, as asked there:
https://github.com/OpenVPN/openvpn/pull/1156

The patch made with git format-patch is attached, because the Gmail
web interface wraps long lines. It applies to master (99ee0917).

Tested on Linux 6.8 with DCO (ovpn-backports), TCP and UDP, with
client-connect / client-disconnect scripts and a small test plugin.
The test cases are listed in the PR.

 src/openvpn/multi.c | 14 +++++++++++++-
 src/openvpn/multi.h |  3 +++
 2 files changed, 16 insertions(+), 1 deletion(-)

--0000000000003929e906611fea17
Content-Type: text/plain; charset="US-ASCII"; 
	name="0001-multi-call-client-disconnect-handlers-when-late-clie.patch.txt"
Content-Disposition: attachment; 
	filename="0001-multi-call-client-disconnect-handlers-when-late-clie.patch.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mwwl6ypy0>
X-Attachment-Id: f_mwwl6ypy0

RnJvbSAzNGMxZjBlZjJiZjFhZDUzNjEzMWRkZDYwNTJlZjgwZjYxNmI2NWNkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGYXJzaGlkIFJlemFpeWFuIDxmYXJzaGlkcmV6YWl5YW5AZ21h
aWwuY29tPgpEYXRlOiBXZWQsIDI1IE5vdiAyMDI2IDIzOjU2OjU5ICswMzMwClN1YmplY3Q6IFtQ
QVRDSF0gbXVsdGk6IGNhbGwgY2xpZW50LWRpc2Nvbm5lY3QgaGFuZGxlcnMgd2hlbiBsYXRlIGNs
aWVudCBzZXR1cAogZmFpbHMKCm11bHRpX2NsaWVudF9jb25uZWN0X2xhdGVfc2V0dXAoKSBpcyBv
bmx5IHJlYWNoZWQgYWZ0ZXIgYWxsCmNsaWVudC1jb25uZWN0IGhhbmRsZXJzIChzY3JpcHRzIGFu
ZCBwbHVnaW5zKSBoYXZlIHN1Y2NlZWRlZC4gSXQgc2V0cwp0aGUgc3RhdGUgdG8gQ0FTX0NPTk5F
Q1RfRE9ORSBhbmQgdGhlbiBkb3duZ3JhZGVzIGl0IHRvIENBU19GQUlMRUQgaWYKc2V0dGluZyB0
aGUgcHJvdG9jb2wgb3B0aW9ucywgYWRkaW5nIHRoZSBEQ08gcGVlciBvciBnZW5lcmF0aW5nIHRo
ZQpkYXRhIGNoYW5uZWwga2V5cyBmYWlscy4KCm11bHRpX2Nsb3NlX2luc3RhbmNlKCkgb25seSBj
YWxscyB0aGUgY2xpZW50LWRpc2Nvbm5lY3QgaGFuZGxlcnMgZm9yCmluc3RhbmNlcyBpbiBzdGF0
ZSBDQVNfQ09OTkVDVF9ET05FLCBzbyBmb3Igc3VjaCBhIGNsaWVudCB0aGUKY2xpZW50LWNvbm5l
Y3QgaGFuZGxlcnMgaGF2ZSBydW4gYnV0IGNsaWVudC1kaXNjb25uZWN0IG5ldmVyIGRvZXMuCkFu
eXRoaW5nIHRoYXQgcGFpcnMgdGhlIHR3byBjYWxscyBnZXRzIG91dCBvZiBzeW5jLiBGb3IgZXhh
bXBsZSwgYQpSQURJVVMgYWNjb3VudGluZyBwbHVnaW4gdGhhdCBzZW5kcyBBY2NvdW50aW5nLVN0
YXJ0IG9uIGNvbm5lY3QgYW5kCkFjY291bnRpbmctU3RvcCBvbiBkaXNjb25uZWN0IGtlZXBzIHRo
ZSBzZXNzaW9uIG9wZW4gZm9yZXZlci4KClRoaXMgaXMgZWFzeSB0byBoaXQgd2l0aCBEQ08gb24g
TGludXggYW5kIFRDUDogaWYgdGhlIGNsaWVudCBjbG9zZXMKdGhlIFRDUCBjb25uZWN0aW9uIHdo
aWxlIGEgY2xpZW50LWNvbm5lY3QgaGFuZGxlciBpcyBydW5uaW5nLCB0aGUKa2VybmVsIHJlZnVz
ZXMgdG8gYXR0YWNoIHRoZSBzb2NrZXQgKCJwcm92aWRlZCBUQ1Agc29ja2V0IGlzIG5vdCBpbgpF
U1RBQkxJU0hFRCBzdGF0ZSIpIGFuZCBkY29fbXVsdGlfYWRkX25ld19wZWVyKCkgZmFpbHMuCgpS
ZW1lbWJlciBpbiB0aGUgbmV3IGRpZF9jbGllbnRfY29ubmVjdCBmbGFnIHRoYXQgYSBjbGllbnQt
Y29ubmVjdApwbHVnaW4gb3Igc2NyaXB0IHdhcyBjYWxsZWQgd2l0aCBzdWNjZXNzLiBUaGlzIGlz
IHRoZSBjYXNlIGlmIG9uZSBpcwpkZWZpbmVkLCBiZWNhdXNlIG11bHRpX2NsaWVudF9jb25uZWN0
X2xhdGVfc2V0dXAoKSBpcyBvbmx5IHJlYWNoZWQKd2hlbiBhbGwgY2xpZW50LWNvbm5lY3QgaGFu
ZGxlcnMgaGF2ZSBzdWNjZWVkZWQuCm11bHRpX2Nsb3NlX2luc3RhbmNlKCkgdGhlbiBhbHNvIGNh
bGxzIHRoZSBkaXNjb25uZWN0IGhhbmRsZXJzIGZvciBhbgppbnN0YW5jZSBpbiBDQVNfRkFJTEVE
IHRoYXQgaGFzIHRoaXMgZmxhZyBzZXQuIFNvIHRoZXkgcnVuIG9uIGluc3RhbmNlCnNodXRkb3du
IGFuZCBleGFjdGx5IG9uY2UsIGFzIGZvciBhbnkgb3RoZXIgY2xpZW50LCBhbmQgb25seSBhZnRl
ciBhCnN1Y2Nlc3NmdWwgY2xpZW50LWNvbm5lY3QuCgpHaXRIdWI6IGNsb3NlcyBPcGVuVlBOL29w
ZW52cG4jMTE1NQpTaWduZWQtb2ZmLWJ5OiBGYXJzaGlkIFJlemFpeWFuIDxmYXJzaGlkcmV6YWl5
YW5AZ21haWwuY29tPgotLS0KIHNyYy9vcGVudnBuL211bHRpLmMgfCAxNCArKysrKysrKysrKysr
LQogc3JjL29wZW52cG4vbXVsdGkuaCB8ICAzICsrKwogMiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL29wZW52cG4vbXVsdGku
YyBiL3NyYy9vcGVudnBuL211bHRpLmMKaW5kZXggOTAwYjVhM2IuLjcwNjE5NWFjIDEwMDY0NAot
LS0gYS9zcmMvb3BlbnZwbi9tdWx0aS5jCisrKyBiL3NyYy9vcGVudnBuL211bHRpLmMKQEAgLTcx
OCw3ICs3MTgsMTAgQEAgbXVsdGlfY2xvc2VfaW5zdGFuY2Uoc3RydWN0IG11bHRpX2NvbnRleHQg
Km0sIHN0cnVjdCBtdWx0aV9pbnN0YW5jZSAqbWksIGJvb2wgc2gKICAgICBzZXRfY2NfY29uZmln
KG1pLCBOVUxMKTsKICNlbmRpZgogCi0gICAgaWYgKG1pLT5jb250ZXh0LmMyLnRsc19tdWx0aS0+
bXVsdGlfc3RhdGUgPj0gQ0FTX0NPTk5FQ1RfRE9ORSkKKyAgICAvKiBBIGNsaWVudCB0aGF0IGZh
aWxlZCBpbiBtdWx0aV9jbGllbnRfY29ubmVjdF9sYXRlX3NldHVwKCkgaXMgaW4KKyAgICAgKiBD
QVNfRkFJTEVELCBidXQgaXRzIGNsaWVudC1jb25uZWN0IGhhbmRsZXJzIGRpZCBzdWNjZWVkICov
CisgICAgaWYgKG1pLT5jb250ZXh0LmMyLnRsc19tdWx0aS0+bXVsdGlfc3RhdGUgPj0gQ0FTX0NP
Tk5FQ1RfRE9ORQorICAgICAgICB8fCAobWktPmRpZF9jbGllbnRfY29ubmVjdCAmJiBtaS0+Y29u
dGV4dC5jMi50bHNfbXVsdGktPm11bHRpX3N0YXRlID09IENBU19GQUlMRUQpKQogICAgIHsKICAg
ICAgICAgbXVsdGlfY2xpZW50X2Rpc2Nvbm5lY3Rfc2NyaXB0KG1pKTsKICAgICB9CkBAIC0yNDE0
LDYgKzI0MTcsMTUgQEAgbXVsdGlfY2xpZW50X2Nvbm5lY3RfbGF0ZV9zZXR1cChzdHJ1Y3QgbXVs
dGlfY29udGV4dCAqbSwgc3RydWN0IG11bHRpX2luc3RhbmNlICoKICAgICAvKiBzZXQgY29udGV4
dC1sZXZlbCBhdXRoZW50aWNhdGlvbiBmbGFnICovCiAgICAgbWktPmNvbnRleHQuYzIudGxzX211
bHRpLT5tdWx0aV9zdGF0ZSA9IENBU19DT05ORUNUX0RPTkU7CiAKKyAgICAvKiBXZSBvbmx5IGdl
dCBoZXJlIGlmIGFsbCBjbGllbnQtY29ubmVjdCBoYW5kbGVycyBzdWNjZWVkZWQsIHNvIGEKKyAg
ICAgKiBkZWZpbmVkIGNsaWVudC1jb25uZWN0IHBsdWdpbiBvciBzY3JpcHQgaGFzIGJlZW4gY2Fs
bGVkIHdpdGgKKyAgICAgKiBzdWNjZXNzLiBSZW1lbWJlciB0aGlzLCBhcyB0aGUgc3RlcHMgYmVs
b3cgbWF5IHN0aWxsIHNldAorICAgICAqIENBU19GQUlMRUQsIGFuZCB0aGUgY2xpZW50LWRpc2Nv
bm5lY3QgaGFuZGxlcnMgbXVzdCB0aGVuIGJlIGNhbGxlZAorICAgICAqIHdoZW4gdGhlIGluc3Rh
bmNlIGlzIGNsb3NlZC4gKi8KKyAgICBtaS0+ZGlkX2NsaWVudF9jb25uZWN0ID0gcGx1Z2luX2Rl
ZmluZWQobWktPmNvbnRleHQucGx1Z2lucywgT1BFTlZQTl9QTFVHSU5fQ0xJRU5UX0NPTk5FQ1Qp
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHx8IHBsdWdpbl9kZWZpbmVkKG1pLT5jb250
ZXh0LnBsdWdpbnMsIE9QRU5WUE5fUExVR0lOX0NMSUVOVF9DT05ORUNUX1YyKQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8fCBtaS0+Y29udGV4dC5vcHRpb25zLmNsaWVudF9jb25uZWN0
X3NjcmlwdCAhPSBOVUxMOworCiAgICAgLyogU2luY2UgZGNvLXdpbiBtYWludGFpbnMgaXJvdXRl
IHJvdXRpbmcgdGFibGUgKHN1Ym5ldCAtPiBwZWVyKSwKICAgICAgKiBwZWVyIG11c3QgYmUgYWRk
ZWQgYmVmb3JlIGlyb3V0ZXMuIEZvciBvdGhlciBwbGF0Zm9ybXMgaXQgZG9lc24ndCBtYXR0ZXIu
ICovCiAKZGlmZiAtLWdpdCBhL3NyYy9vcGVudnBuL211bHRpLmggYi9zcmMvb3BlbnZwbi9tdWx0
aS5oCmluZGV4IDNkMmU5MzIxLi45Y2M5ODZjOSAxMDA2NDQKLS0tIGEvc3JjL29wZW52cG4vbXVs
dGkuaAorKysgYi9zcmMvb3BlbnZwbi9tdWx0aS5oCkBAIC0xNDUsNiArMTQ1LDkgQEAgc3RydWN0
IG11bHRpX2luc3RhbmNlCiAgICAgc3RydWN0IGJ1ZmZlcl9saXN0ICpjY19jb25maWc7CiAjZW5k
aWYKICAgICBib29sIGRpZF9pcm91dGVzOworICAgIC8qKiBhIGNsaWVudC1jb25uZWN0IHBsdWdp
biBvciBzY3JpcHQgd2FzIGNhbGxlZCBhbmQgc3VjY2VlZGVkLCBzbworICAgICAqIGNsaWVudC1k
aXNjb25uZWN0IG11c3QgYmUgY2FsbGVkIHdoZW4gdGhlIGluc3RhbmNlIGlzIGNsb3NlZCAqLwor
ICAgIGJvb2wgZGlkX2NsaWVudF9jb25uZWN0OwogICAgIGludCBuX2NsaWVudHNfZGVsdGE7ICAg
IC8qIGFkZGVkIHRvIG11bHRpX2NvbnRleHQubl9jbGllbnRzIHdoZW4gaW5zdGFuY2UgaXMgY2xv
c2VkICovCiAKICAgICBzdHJ1Y3QgY29udGV4dCBjb250ZXh0OyAvKio8IFRoZSBjb250ZXh0IHN0
cnVjdHVyZSBzdG9yaW5nIHN0YXRlCi0tIAoyLjU0LjAgKEFwcGxlIEdpdC0xNTcpCgo=
--0000000000003929e906611fea17
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0000000000003929e906611fea17
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--0000000000003929e906611fea17--

