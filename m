Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4BDC43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Cc:Reply-To:From:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GRc7ZREkQTqhY43MczQJufWbda1iZhcdLbddqkcVy3U=; b=NxI1ND9W1nYjKwa7zTYmt5ZOdO
	wtnY4IF8rgKy54o5o1rP6if2A6da8HiqeaIzzOF0Y3FpElp1+cHKDMhaifN5jzB8cE+RwVRJB/Ahr
	+BeUhfVRrkOsp5Iqw7+N2W6nC+a25l6gLutAbt/3/POvRpqfK36hjjxxAYuntjD+AOFY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weCBf-0003Ze-GZ;
	Mon, 29 Jun 2026 13:38:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <samgithub@pm.me>) id 1weCBd-0003ZN-JV
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 13:38:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:References:In-Reply-To:
 Message-ID:Subject:Cc:From:To:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=79KueTIMsWDMFjuXzXxPzYKdW9SwLqST4vqDQYIOU10=; b=KMqv7e/yXGUL8iCLwY45umPkd3
 R8P7TsI2BWRIU23H/rwK2EQ0NHOppgOeB9s2Y9dxPVA2qPUQoKZI13KQPf32+YuNw/YbOXxWOLWYA
 BIXKwyEaMlr3OKDdaPk8kZeP6DhL/uQt1AuDO2VVsDie873MpFZb1GLYRqpycBcz5v8Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:
 From:To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=79KueTIMsWDMFjuXzXxPzYKdW9SwLqST4vqDQYIOU10=; b=R2pydslwTiH9VZEyDK2zEp+yGe
 qvwOFRYp9dcpCnH33Ko/P/VDYejI2LHI+bTCAgwWbFgkFq3qV+JeHaGjL1FemdIw7KBzhF3sC9gBd
 eVEqEYkhZqTN5afOSZaMOnPQwB9SHBTGxxu1GCGAGOTO6EQ+w25UYbVfrB2bfVZS0Yao=;
Received: from mail-106110.protonmail.ch ([79.135.106.110])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1weCBa-00088H-FT for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 13:38:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1782739329; x=1782998529;
 bh=79KueTIMsWDMFjuXzXxPzYKdW9SwLqST4vqDQYIOU10=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=nvEZbrYXZjbG/mlkNUteg6Ge0IIsAMfFGDnOPfBjVxkRodtU5h1lVHXscbAipo284
 h3QPb9pIKBxZtOUJGCdkfRztoooMPEUX9nGZaWCYhkEY73btf/PJFBZYXlzTnsu4tj
 q7pYPXBMPA3ORCYIPvjRD/LSJaxCUG3Lw8R7Tb7l2B1iFZYR0ROd61sRNDNXJgkuA4
 whTxQ8Fub9YPEsMOiYTDGgg2ojumoxwEXfeT7bhy4/O5XKShzNNA+iw+kk/1Tvp9ON
 +q/FPp/eUmau4eI1w5XdxllK0ax+30JXdLc+xEIJdjQtXGboIri50YHHC9dQFNCVP5
 69IWol/LSADIA==
Date: Mon, 29 Jun 2026 13:22:03 +0000
To: Arne Schwabe <arne@rfc2549.org>
Message-ID: <_5bQ5LvkEmn_vaE7Ng8xPAcHJFWfy7td0Yvim0iLc3YVoer2RM1-PoBKAGPzHZKx1rsZP7Ht7kM_2eIUSidNkMW34yS7eT549_fSvcb-dl0=@pm.me>
In-Reply-To: <c6e935be-f655-47c6-b968-6962a3cfc58c@rfc2549.org>
References: <q2D43uJoozPKtfJvLVuPcngp0-9sjp_HkGFBfdR3bpOTXmPGoi5Fz__jvpLGvsEWHXC5lBnqny8sXX-kkN3zXoRTJmTLjA0mzKb9yG5A4K4=@pm.me>
 <c6e935be-f655-47c6-b968-6962a3cfc58c@rfc2549.org>
Feedback-ID: 192537181:user:proton
X-Pm-Message-ID: d98dc21030ee5b7bcbef1e3f796020c783ca3e34
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_V03EVsnzbrtbiyjj7XRZjksWsK0BC7ztMiTZrY"
X-Headers-End: 1weCBa-00088H-FT
Subject: [Openvpn-devel] [PATCH v2] Document --preresolve option
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
From: Sami Rusani via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Reply-To: Sami Rusani <samgithub@pm.me>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--b1=_V03EVsnzbrtbiyjj7XRZjksWsK0BC7ztMiTZrY
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Thanks, addressed in v2.

This version documents that --preresolve reuses resolved addresses on recon=
nects, and mentions the trade-off for dynamic DNS names and
DNS64/NAT64 roaming.

Sam

On Monday, June 29th, 2026 at 3:08 PM, Arne Schwabe <arne@rfc2549.org> wrot=
e:

> Am 27.06.26 um 22:37 schrieb Sami Rusani via Openvpn-devel:
> >
> > Hi,
> >
> > Please find attached a small documentation patch for OpenVPN/openvpn#53=
2.
>=20
> Thanks. This is a good start but I think we can improve this to give a
> bit more context:
>=20
> +--preresolve
> +  Resolve configured ``--remote``, ``--local``, ``--http-proxy``, and
> +  ``--socks-proxy`` hostnames at startup before opening the connection.
> +
>=20
>=20
> I think we should mention that this also causes OpenVPN to never
> reresolve the hostnames on reconnect. Which is a good thing if you use
> something like persist-tun and DNS will not work while the VPN is down
> but maybe is counter-productive if you have a dyndns name for your VPN
> server or roaming to/from DNS64/NAT64 network where the IP address might
> change.
>=20
> Arne
> 
--b1=_V03EVsnzbrtbiyjj7XRZjksWsK0BC7ztMiTZrY
Content-Type: application/octet-stream; name=v2-0001-Document-preresolve-option.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=v2-0001-Document-preresolve-option.patch

RnJvbSBjYTFiZjNjNjk2MWJkZjliY2NmMTJlMTllYmZlZjQ2ZGZhNjIxZDBhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW1pIFJ1c2FuaSA8c2FtZ2l0aHViQHBtLm1lPgpEYXRlOiBT
YXQsIDI3IEp1biAyMDI2IDIxOjAzOjUxICswMjAwClN1YmplY3Q6IFtQQVRDSCB2Ml0gRG9jdW1l
bnQgLS1wcmVyZXNvbHZlIG9wdGlvbgoKVGhlIG9wdGlvbiByZXNvbHZlcyBjb25maWd1cmVkIHJl
bW90ZSwgbG9jYWwsIGFuZCBwcm94eSBob3N0bmFtZXMgYXQKc3RhcnR1cCBhbmQgcmV1c2VzIHRo
b3NlIHJlc29sdmVkIGFkZHJlc3NlcyBvbiByZWNvbm5lY3RzLgoKRG9jdW1lbnQgaXQgaW4gdGhl
IHVzYWdlIHRleHQgYW5kIGNsaWVudCBvcHRpb25zIG1hbiBwYWdlLCBpbmNsdWRpbmcKdGhlIHJl
Y29ubmVjdCB0cmFkZS1vZmYgZm9yIGNvbmZpZ3VyYXRpb25zIHRoYXQgcmVseSBvbiBjaGFuZ2lu
ZyBETlMKYW5zd2Vycy4KCkdpdEh1YjogZml4ZXMgT3BlblZQTi9vcGVudnBuIzUzMgotLS0KQ2hh
bmdlcyBpbiB2MjoKLSBEb2N1bWVudCB0aGF0IHJlc29sdmVkIGhvc3RuYW1lcyBhcmUgcmV1c2Vk
IG9uIHJlY29ubmVjdHMuCi0gTWVudGlvbiB0aGUgdHJhZGUtb2ZmIGZvciBkeW5hbWljIEROUyBu
YW1lcyBhbmQgRE5TNjQvTkFUNjQgcm9hbWluZy4KCiBkb2MvbWFuLXNlY3Rpb25zL2NsaWVudC1v
cHRpb25zLnJzdCB8IDExICsrKysrKysrKysrCiBzcmMvb3BlbnZwbi9vcHRpb25zLmMgICAgICAg
ICAgICAgICB8ICAxICsKIDIgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL2RvYy9tYW4tc2VjdGlvbnMvY2xpZW50LW9wdGlvbnMucnN0IGIvZG9jL21hbi1zZWN0
aW9ucy9jbGllbnQtb3B0aW9ucy5yc3QKaW5kZXggM2FkOTEwNC4uODdjMTM4YSAxMDA2NDQKLS0t
IGEvZG9jL21hbi1zZWN0aW9ucy9jbGllbnQtb3B0aW9ucy5yc3QKKysrIGIvZG9jL21hbi1zZWN0
aW9ucy9jbGllbnQtb3B0aW9ucy5yc3QKQEAgLTU2OCw2ICs1NjgsMTcgQEAgY29uZmlndXJhdGlv
bi4KICAgQnkgZGVmYXVsdCwgYGAtLXJlc29sdi1yZXRyeSBpbmZpbml0ZWBgIGlzIGVuYWJsZWQu
IFlvdSBjYW4gZGlzYWJsZSBieQogICBzZXR0aW5nIG49MC4KIAorLS1wcmVyZXNvbHZlCisgIFJl
c29sdmUgY29uZmlndXJlZCBgYC0tcmVtb3RlYGAsIGBgLS1sb2NhbGBgLCBgYC0taHR0cC1wcm94
eWBgLCBhbmQKKyAgYGAtLXNvY2tzLXByb3h5YGAgaG9zdG5hbWVzIGF0IHN0YXJ0dXAgYmVmb3Jl
IG9wZW5pbmcgdGhlIGNvbm5lY3Rpb24uCisKKyAgVGhlIHJlc29sdmVkIGFkZHJlc3NlcyBhcmUg
Y2FjaGVkIGFuZCByZXVzZWQgZm9yIHJlY29ubmVjdHMsIHNvIE9wZW5WUE4KKyAgd2lsbCBub3Qg
cmUtcmVzb2x2ZSB0aGVzZSBob3N0bmFtZXMgYWZ0ZXIgdGhlIGluaXRpYWwgY29ubmVjdGlvbiBh
dHRlbXB0LgorICBUaGlzIGNhbiBoZWxwIGNvbmZpZ3VyYXRpb25zIHdoZXJlIEROUyBpcyB1bmF2
YWlsYWJsZSB3aGlsZSB0aGUgVlBOIGlzCisgIGRvd24sIGJ1dCBjYW4gYmUgY291bnRlci1wcm9k
dWN0aXZlIGZvciBkeW5hbWljIEROUyBuYW1lcyBvciB3aGVuIHJvYW1pbmcKKyAgYmV0d2VlbiBu
ZXR3b3JrcyB3aGVyZSBhZGRyZXNzIGZhbWlseSBhdmFpbGFiaWxpdHkgY2hhbmdlcywgc3VjaCBh
cworICBETlM2NC9OQVQ2NC4KKwogLS1zaW5nbGUtc2Vzc2lvbgogICBBZnRlciBpbml0aWFsbHkg
Y29ubmVjdGluZyB0byBhIHJlbW90ZSBwZWVyLCBkaXNhbGxvdyBhbnkgbmV3CiAgIGNvbm5lY3Rp
b25zLiBVc2luZyB0aGlzIG9wdGlvbiBtZWFucyB0aGF0IGEgcmVtb3RlIHBlZXIgY2Fubm90IGNv
bm5lY3QsCmRpZmYgLS1naXQgYS9zcmMvb3BlbnZwbi9vcHRpb25zLmMgYi9zcmMvb3BlbnZwbi9v
cHRpb25zLmMKaW5kZXggZjQxNDAyNC4uODcyMThkNCAxMDA2NDQKLS0tIGEvc3JjL29wZW52cG4v
b3B0aW9ucy5jCisrKyBiL3NyYy9vcGVudnBuL29wdGlvbnMuYwpAQCAtMTc1LDYgKzE3NSw3IEBA
IHN0YXRpYyBjb25zdCBjaGFyIHVzYWdlX21lc3NhZ2VbXSA9CiAgICAgIi0tcmVzb2x2LXJldHJ5
IG46IElmIGhvc3RuYW1lIHJlc29sdmUgZmFpbHMgZm9yIC0tcmVtb3RlLCByZXRyeVxuIgogICAg
ICIgICAgICAgICAgICAgICAgICByZXNvbHZlIGZvciBuIHNlY29uZHMgYmVmb3JlIGZhaWxpbmcg
KGRpc2FibGVkIGJ5IGRlZmF1bHQpLlxuIgogICAgICIgICAgICAgICAgICAgICAgICBTZXQgbj1c
ImluZmluaXRlXCIgdG8gcmV0cnkgaW5kZWZpbml0ZWx5LlxuIgorICAgICItLXByZXJlc29sdmUg
ICAgOiBSZXNvbHZlIGNvbmZpZ3VyZWQgLS1yZW1vdGUsIC0tbG9jYWwsIGFuZCBwcm94eSBob3N0
bmFtZXMgYXQgc3RhcnR1cC5cbiIKICAgICAiLS1mbG9hdCAgICAgICAgIDogQWxsb3cgcmVtb3Rl
IHRvIGNoYW5nZSBpdHMgSVAgYWRkcmVzcy9wb3J0LCBzdWNoIGFzIHRocm91Z2hcbiIKICAgICAi
ICAgICAgICAgICAgICAgICAgREhDUCAodGhpcyBpcyB0aGUgZGVmYXVsdCBpZiAtLXJlbW90ZSBp
cyBub3QgdXNlZCkuXG4iCiAgICAgIi0taXBjaGFuZ2UgY21kICA6IFJ1biBjb21tYW5kIGNtZCBv
biByZW1vdGUgaXAgYWRkcmVzcyBpbml0aWFsXG4iCi0tIAoyLjUzLjAK

--b1=_V03EVsnzbrtbiyjj7XRZjksWsK0BC7ztMiTZrY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--b1=_V03EVsnzbrtbiyjj7XRZjksWsK0BC7ztMiTZrY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--b1=_V03EVsnzbrtbiyjj7XRZjksWsK0BC7ztMiTZrY--


