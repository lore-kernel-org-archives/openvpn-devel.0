Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EF1C43458
	for <openvpn-devel@archiver.kernel.org>; Sat, 27 Jun 2026 20:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Reply-To:From:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:Content-Type:
	MIME-Version:Message-ID:To:Date:Sender:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rdozG8Ry/i16QXCfDbtgIUou74muA5GTpbgv8EbMHYg=; b=eVDlGD80xHamBl5W+VfJ16F7iN
	Os/uDQbsde+/DY4DytoLv5WrnkNrJSWoboR8OU3AZt2DUcB1YAKqyYMw1N9RTOeQDLh4HY3Oa7Dsx
	4vwITnKGvJoGCdq9Q4Ac/iQDW5h5HBb0tvc/ig6Jo+K1DndHmzmLo2ajdhs0RoviPZKM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wdZnX-00073o-Gy;
	Sat, 27 Jun 2026 20:38:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <samgithub@pm.me>) id 1wdZnB-00073Q-2d
 for openvpn-devel@lists.sourceforge.net;
 Sat, 27 Jun 2026 20:38:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:From:
 To:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5hXKeeY4ec++C+bMFscR85BjW53sLLKrfPoGclEh1P4=; b=Wjg7ld33hTPI4WbwmxNM4aXKin
 f0yCTG4j9FcZJtWqQoMs0Rj4HcNYtgACD0rTYeGN0P0inj0nVYJXn0jIThmzHcpCIff5ipgySLh0Q
 5UCBUWSxW//7WcG9SpUP3z7NCaVEa75uVdIoa+t54NmC9hdVZQ+9LMtKGxYAll/pjY1Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:To:Date:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5hXKeeY4ec++C+bMFscR85BjW53sLLKrfPoGclEh1P4=; b=S
 fYctVuyeTafjpqApZqfvW7u8gFQarxVmGyb8cTcl+UdIemWNqlsT3dPoajGDA+TD2lnIHE7BiqZzT
 MHH48eZYCYnCVo+0p6eB2w/al2lAmMBHvvCejqiIbY/adtNUyARt9D2PrXp/kNw3jQ/dzgNa0waQk
 wH+X70F/uTJH/8wc=;
Received: from mail-4316.protonmail.ch ([185.70.43.16])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wdZn0-0001T2-O6 for openvpn-devel@lists.sourceforge.net;
 Sat, 27 Jun 2026 20:38:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1782592679; x=1782851879;
 bh=5hXKeeY4ec++C+bMFscR85BjW53sLLKrfPoGclEh1P4=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=eaaww0bae6ph7ynrvzM+eWnmk+AzeoKt+AnFHJfIXGImIfXslE6yqGaKe55EQlhJI
 yMlAsS4mH+ZCseWbXNLnQ9KcT8Ag9Mut+n7kyyHsAf6G8nsactGA7SwZVw7+exH7Id
 D8pUggl43Ky2kIq8j2nC9rPwmz67cbEzyOdDqa9RyB+ybJecGsLQscDX8GVmG2kBvd
 6p/AxhEfAfvXYnUMtY4qb8MYYNdJY60+dn059PnFfMsLRik6SMdaqbxDJf4XacNqS5
 RCxdVophxnl1Nr/r++Um4dAL/LXyMWaVWYk7H6KczRSKjtEfw7/OF7ew7O8P1DWMzJ
 tTKYCrN1jyiTQ==
Date: Sat, 27 Jun 2026 20:37:55 +0000
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <q2D43uJoozPKtfJvLVuPcngp0-9sjp_HkGFBfdR3bpOTXmPGoi5Fz__jvpLGvsEWHXC5lBnqny8sXX-kkN3zXoRTJmTLjA0mzKb9yG5A4K4=@pm.me>
Feedback-ID: 192537181:user:proton
X-Pm-Message-ID: 6a0f41cc2331353f75805db48afc38b169f590a0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_JQn7RXvHP0qaGpW3vZsCloJrjgYtGB33EZ7GUN1Y"
X-Headers-End: 1wdZn0-0001T2-O6
Subject: [Openvpn-devel] [PATCH] Document --preresolve option
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
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--b1=_JQn7RXvHP0qaGpW3vZsCloJrjgYtGB33EZ7GUN1Y
Content-Type: multipart/alternative;
 boundary="b2=_JQn7RXvHP0qaGpW3vZsCloJrjgYtGB33EZ7GUN1Y"

--b2=_JQn7RXvHP0qaGpW3vZsCloJrjgYtGB33EZ7GUN1Y
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

SGksCgpQbGVhc2UgZmluZCBhdHRhY2hlZCBhIHNtYWxsIGRvY3VtZW50YXRpb24gcGF0Y2ggZm9y
IE9wZW5WUE4vb3BlbnZwbiM1MzIuCgpUaGFua3MsU2FtaQ==

--b2=_JQn7RXvHP0qaGpW3vZsCloJrjgYtGB33EZ7GUN1Y
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDE0
cHg7Ij48YnI+PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlm
OyBmb250LXNpemU6IDE0cHg7Ij48c3Bhbj5IaSw8L3NwYW4+PGRpdj48YnI+PC9kaXY+PGRpdj48
c3Bhbj5QbGVhc2UgZmluZCBhdHRhY2hlZCBhIHNtYWxsIGRvY3VtZW50YXRpb24gcGF0Y2ggZm9y
IE9wZW5WUE4vb3BlbnZwbiM1MzIuPC9zcGFuPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNw
YW4+VGhhbmtzLDwvc3Bhbj48L2Rpdj48c3Bhbj5TYW1pPC9zcGFuPjxicj48L2Rpdj4NCjxkaXYg
c3R5bGU9ImZvbnQtZmFtaWx5OiBBcmlhbCwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxNHB4OyIg
Y2xhc3M9InByb3Rvbm1haWxfc2lnbmF0dXJlX2Jsb2NrIHByb3Rvbm1haWxfc2lnbmF0dXJlX2Js
b2NrLWVtcHR5Ij4NCiAgICA8ZGl2IGNsYXNzPSJwcm90b25tYWlsX3NpZ25hdHVyZV9ibG9jay11
c2VyIHByb3Rvbm1haWxfc2lnbmF0dXJlX2Jsb2NrLWVtcHR5Ij48L2Rpdj4NCiAgICANCiAgICAg
ICAgICAgIDxkaXYgY2xhc3M9InByb3Rvbm1haWxfc2lnbmF0dXJlX2Jsb2NrLXByb3RvbiBwcm90
b25tYWlsX3NpZ25hdHVyZV9ibG9jay1lbXB0eSI+DQogICAgICAgIA0KICAgICAgICAgICAgPC9k
aXY+DQo8L2Rpdj4NCg==


--b2=_JQn7RXvHP0qaGpW3vZsCloJrjgYtGB33EZ7GUN1Y--

--b1=_JQn7RXvHP0qaGpW3vZsCloJrjgYtGB33EZ7GUN1Y
Content-Type: application/octet-stream; name=0001-Document-preresolve-option.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-Document-preresolve-option.patch

RnJvbSBlYThiMGJiNWZlOTNkN2EyNDAxMzBjNTI5YTYxYTU1Y2E1MzY3MzA0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW1pIFJ1c2FuaSA8c2FtZ2l0aHViQHBtLm1lPgpEYXRlOiBT
YXQsIDI3IEp1biAyMDI2IDIxOjAzOjUxICswMjAwClN1YmplY3Q6IFtQQVRDSF0gRG9jdW1lbnQg
LS1wcmVyZXNvbHZlIG9wdGlvbgoKVGhlIG9wdGlvbiByZXNvbHZlcyBjb25maWd1cmVkIHJlbW90
ZSwgbG9jYWwsIGFuZCBwcm94eSBob3N0bmFtZXMgYXQKc3RhcnR1cCwgYnV0IGl0IHdhcyBtaXNz
aW5nIGZyb20gYm90aCB0aGUgdXNhZ2UgdGV4dCBhbmQgdGhlIGNsaWVudApvcHRpb25zIG1hbiBw
YWdlLgoKR2l0SHViOiBmaXhlcyBPcGVuVlBOL29wZW52cG4jNTMyCi0tLQogZG9jL21hbi1zZWN0
aW9ucy9jbGllbnQtb3B0aW9ucy5yc3QgfCA0ICsrKysKIHNyYy9vcGVudnBuL29wdGlvbnMuYyAg
ICAgICAgICAgICAgIHwgMSArCiAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL2RvYy9tYW4tc2VjdGlvbnMvY2xpZW50LW9wdGlvbnMucnN0IGIvZG9jL21hbi1z
ZWN0aW9ucy9jbGllbnQtb3B0aW9ucy5yc3QKaW5kZXggM2FkOTEwNC4uNWQwMTQ4YyAxMDA2NDQK
LS0tIGEvZG9jL21hbi1zZWN0aW9ucy9jbGllbnQtb3B0aW9ucy5yc3QKKysrIGIvZG9jL21hbi1z
ZWN0aW9ucy9jbGllbnQtb3B0aW9ucy5yc3QKQEAgLTU2OCw2ICs1NjgsMTAgQEAgY29uZmlndXJh
dGlvbi4KICAgQnkgZGVmYXVsdCwgYGAtLXJlc29sdi1yZXRyeSBpbmZpbml0ZWBgIGlzIGVuYWJs
ZWQuIFlvdSBjYW4gZGlzYWJsZSBieQogICBzZXR0aW5nIG49MC4KIAorLS1wcmVyZXNvbHZlCisg
IFJlc29sdmUgY29uZmlndXJlZCBgYC0tcmVtb3RlYGAsIGBgLS1sb2NhbGBgLCBgYC0taHR0cC1w
cm94eWBgLCBhbmQKKyAgYGAtLXNvY2tzLXByb3h5YGAgaG9zdG5hbWVzIGF0IHN0YXJ0dXAgYmVm
b3JlIG9wZW5pbmcgdGhlIGNvbm5lY3Rpb24uCisKIC0tc2luZ2xlLXNlc3Npb24KICAgQWZ0ZXIg
aW5pdGlhbGx5IGNvbm5lY3RpbmcgdG8gYSByZW1vdGUgcGVlciwgZGlzYWxsb3cgYW55IG5ldwog
ICBjb25uZWN0aW9ucy4gVXNpbmcgdGhpcyBvcHRpb24gbWVhbnMgdGhhdCBhIHJlbW90ZSBwZWVy
IGNhbm5vdCBjb25uZWN0LApkaWZmIC0tZ2l0IGEvc3JjL29wZW52cG4vb3B0aW9ucy5jIGIvc3Jj
L29wZW52cG4vb3B0aW9ucy5jCmluZGV4IGY0MTQwMjQuLjg3MjE4ZDQgMTAwNjQ0Ci0tLSBhL3Ny
Yy9vcGVudnBuL29wdGlvbnMuYworKysgYi9zcmMvb3BlbnZwbi9vcHRpb25zLmMKQEAgLTE3NSw2
ICsxNzUsNyBAQCBzdGF0aWMgY29uc3QgY2hhciB1c2FnZV9tZXNzYWdlW10gPQogICAgICItLXJl
c29sdi1yZXRyeSBuOiBJZiBob3N0bmFtZSByZXNvbHZlIGZhaWxzIGZvciAtLXJlbW90ZSwgcmV0
cnlcbiIKICAgICAiICAgICAgICAgICAgICAgICAgcmVzb2x2ZSBmb3IgbiBzZWNvbmRzIGJlZm9y
ZSBmYWlsaW5nIChkaXNhYmxlZCBieSBkZWZhdWx0KS5cbiIKICAgICAiICAgICAgICAgICAgICAg
ICAgU2V0IG49XCJpbmZpbml0ZVwiIHRvIHJldHJ5IGluZGVmaW5pdGVseS5cbiIKKyAgICAiLS1w
cmVyZXNvbHZlICAgIDogUmVzb2x2ZSBjb25maWd1cmVkIC0tcmVtb3RlLCAtLWxvY2FsLCBhbmQg
cHJveHkgaG9zdG5hbWVzIGF0IHN0YXJ0dXAuXG4iCiAgICAgIi0tZmxvYXQgICAgICAgICA6IEFs
bG93IHJlbW90ZSB0byBjaGFuZ2UgaXRzIElQIGFkZHJlc3MvcG9ydCwgc3VjaCBhcyB0aHJvdWdo
XG4iCiAgICAgIiAgICAgICAgICAgICAgICAgIERIQ1AgKHRoaXMgaXMgdGhlIGRlZmF1bHQgaWYg
LS1yZW1vdGUgaXMgbm90IHVzZWQpLlxuIgogICAgICItLWlwY2hhbmdlIGNtZCAgOiBSdW4gY29t
bWFuZCBjbWQgb24gcmVtb3RlIGlwIGFkZHJlc3MgaW5pdGlhbFxuIgotLSAKMi41My4wCgo=

--b1=_JQn7RXvHP0qaGpW3vZsCloJrjgYtGB33EZ7GUN1Y
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--b1=_JQn7RXvHP0qaGpW3vZsCloJrjgYtGB33EZ7GUN1Y
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--b1=_JQn7RXvHP0qaGpW3vZsCloJrjgYtGB33EZ7GUN1Y--


