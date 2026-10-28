Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD653606A31D
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 22:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KArP42ht;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VtpOkP1Z;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kwLDxnZp;
	dkim=neutral header.d=unstable.cc header.i=@unstable.cc header.a=rsa-sha256 header.s=MBO0001 header.b=wX1O/hEe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:From:References:To:
	MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2wRnRnAL/Ho3wQ2+SG2KVxW6Esb14PT8Z4HzpyDZaPY=; b=KArP42htNfVvPj8kjpRNuZriot
	N5+QB3SSd/okjcfZ/AArCySg1xjBQfOZXQUi37fLJ1FB4gEiXoU4rAf6t4SO0a30Re3L0YuWsmMUS
	9nLdMza5Xiu6VJ3v0YuFeMq4B0vIwBbfZaFB1gwBKuDDmSQbxly9UCldG9icSNdtEgk4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMBjL-000000004fr-1yTI;
	Wed, 28 Oct 2026 22:02:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <a@unstable.cc>) id 1xMBjJ-000000004fa-3FV9
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 22:02:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:From:References:Cc:To:Subject:
 MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/HKBc6qI7U28C2leEynd+16Ajzt+bvJi+fYAfSBB/Js=; b=V
 tpOkP1ZkGGAjl0OwReUWrzsV2kn7n2d4A0v01SAwr9f+fnjgkt1W5xw45L0egMXM9E4XIhHhhCum4
 ncnrqwYLf6nTEDltBN6xYnTj3X8naMlyXlQhL8b/MoI62BcrqfO0QvJNnwKQnO4YuC3PzzdGphhjl
 +eRMM0rJT2Kj+ucM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
 Content-Type:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/HKBc6qI7U28C2leEynd+16Ajzt+bvJi+fYAfSBB/Js=; b=kwLDxnZpLnobQidGbs3CarctnN
 Y7DELtHmyvnvGqx9PuwTltisvJ9neJlF1S6qqGEVLj9dhYLroMq6Gg9Mst7+0p1hoCvpbOh+EZ7Bd
 xtVqS0A/DJW1ReT94EMrO20vfcbEFce1DvFwHxLubI426cPcOO2RrfXVLOvPQsFFZGaM=;
Received: from mout-p-201.mailbox.org ([80.241.56.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMBjI-000000005ch-16Fm for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 22:02:45 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jFLvH40nzzMlNf;
 Wed, 28 Oct 2026 23:02:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1793224955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/HKBc6qI7U28C2leEynd+16Ajzt+bvJi+fYAfSBB/Js=;
 b=wX1O/hEeE/AOFR2fvzKfGM2rdNdCM55hBOiH5VN2qn2WY1yIyw/0u/bkczbc7MnZSMJ0af
 WKTnY2H9Nn2F4QN2rUlecwM89xOHilfNnETT4BMPKm2UJctD1NEnMKk+o1rRoQTdOc8RdV
 xaGBnAZZdq+EWwRPI64I5Ky0h+jGnj2IwQxdJiHq6O/dVX/ZdRHxpZDkk5cyBmxaE6ifmE
 qDaiyZ3KunTtU33vfESKaVvYlZScql2vhaSZ4usD9nhqT+05Dq11Rw1H/wb9Huor8L1fFY
 97zFHmdv3GSKhd6WoGoh3zF4sTFF1ROd39N7qq4fMkWDeLSlSGcQOSSie/616w==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=a@unstable.cc
Content-Type: multipart/mixed; boundary="------------ctKOJIKLIJqDZeW0PeDODiFr"
Message-ID: <7739d9ee-d0cd-4226-afbb-6e3703d68727@unstable.cc>
Date: Wed, 28 Oct 2026 23:02:33 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Bernhard Schmidt <berni@birkenwald.de>
References: <ea6e57f3-3d91-4d3f-9c28-471dc1021bcd@birkenwald.de>
 <auJj5Ld6uMjPb2eS@fliwatuet.svr02.mucip.net>
 <60758dd9-bc8e-4cda-b62c-11aeca9230a1@unstable.cc>
 <auJvKPCANjcH5OMd@fliwatuet.svr02.mucip.net>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <auJvKPCANjcH5OMd@fliwatuet.svr02.mucip.net>
X-Rspamd-Queue-Id: 4jFLvH40nzzMlNf
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMBjI-000000005ch-16Fm
Subject: Re: [Openvpn-devel] Kernel lockup in ovpn ovpn_tcp_send_skb
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a multi-part message in MIME format.
--------------ctKOJIKLIJqDZeW0PeDODiFr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/10/2026 22:54, Bernhard Schmidt wrote:
> On 28/10/26 10:42 PM, Antonio Quartulli wrote:
> 
>> So, it seems this is a deadlock due to an OpenVPN TCP transport packet that
>> is routed back into the ovpn device, thus hitting the lock that was already
>> held on the TCP socket.
>>
>> We just confirmed the theory locally in a VM by artificially forcing the
>> above scenario.
>>
>>
>> It may happen when a client with an already established tunnel attempts a
>> reconnection to the same server over the existing tunnel (i.e. due to
>> traffic redirection).
>>
>> This scenario should lead to what you have witnessed because the server
>> records the VPN IP as transport IP, thus triggering the re-injection.
>>
>> But this is just speculation - you may have hit another case that triggers
>> the same "re-injection" behaviour.
>>
>> In any case, what triggers it is not important for fixing the bug.
>> We basically lack a loop avoidance mechanism for TCP.
> 
> Indeed, that's the culprit. I missed it, but the last connect before the
> lockup is coming from the address assigned to the client.

Thanks for confirming the theory.

I am attaching a patch for this issue, in case it becomes too annoying 
and you want to stop the behaviour ASAP.


I'll now also send it to the list for further review/merge.


Regards,

-- 
Antonio Quartulli

--------------ctKOJIKLIJqDZeW0PeDODiFr
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-ovpn-drop-packets-looping-back-into-their-own-TCP-tr.patch"
Content-Disposition: attachment;
 filename*0="0001-ovpn-drop-packets-looping-back-into-their-own-TCP-tr.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA1NTczM2ZlZDhmMjFjNDIzM2ExYTE0NDQ3MTMzNjI2ZjY1NWZmZThiIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBBbnRvbmlvIFF1YXJ0dWxsaSA8YW50b25pb0BvcGVu
dnBuLm5ldD4KRGF0ZTogV2VkLCAyOCBPY3QgMjAyNiAyMjo0NDowMSArMDEwMApTdWJqZWN0
OiBbUEFUQ0hdIG92cG46IGRyb3AgcGFja2V0cyBsb29waW5nIGJhY2sgaW50byB0aGVpciBv
d24gVENQIHRyYW5zcG9ydAogc29ja2V0CgpJZiB0aGUgb3V0ZXIgcGFja2V0cyBvZiBhIFRD
UCBwZWVyIGFyZSByb3V0ZWQgaW50byB0aGUgb3ZwbiBpbnRlcmZhY2UsCm92cG5fbmV0X3ht
aXQoKSBzZWxlY3RzIHRoYXQgc2FtZSBwZWVyIGFuZCBvdnBuX3RjcF9zZW5kX3NrYigpIHRy
aWVzIHRvCnRha2Ugc2stPnNrX2xvY2suc2xvY2ssIHdoaWNoIHRoZSBUQ1AgdHJhbnNtaXQg
cGF0aCBhbHJlYWR5IGhvbGRzLgpUaGUgQ1BVIGRlYWRsb2Nrcy4KCkRyb3Agc3VjaCBwYWNr
ZXRzIGluIG92cG5fbmV0X3htaXQoKS4KCkZpeGVzOiAxMTg1MWNiZDYwZWEgKCJvdnBuOiBp
bXBsZW1lbnQgVENQIHRyYW5zcG9ydCIpCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnClJl
cG9ydGVkLWJ5OiBCZXJuaGFyZCBTY2htaWR0IDxiZXJuaUBiaXJrZW53YWxkLmRlPgpDbG9z
ZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29wZW52cG4tZGV2ZWwvYXVKajVMZDZ1TWpQ
YjJlU0BmbGl3YXR1ZXQuc3ZyMDIubXVjaXAubmV0LwpBc3Npc3RlZC1ieTogQ2xhdWRlOmNs
YXVkZS1vcHVzLTUtNQpTaWduZWQtb2ZmLWJ5OiBBbnRvbmlvIFF1YXJ0dWxsaSA8YW50b25p
b0BvcGVudnBuLm5ldD4KLS0tCiBkcml2ZXJzL25ldC9vdnBuL2lvLmMgfCAzMiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDMyIGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9vdnBuL2lvLmMgYi9kcml2ZXJzL25l
dC9vdnBuL2lvLmMKaW5kZXggZjE0ZWI0ZTZjNDZhLi41N2NkZWE0NWRjZTcgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvbmV0L292cG4vaW8uYworKysgYi9kcml2ZXJzL25ldC9vdnBuL2lvLmMK
QEAgLTM0OSw2ICszNDksMzEgQEAgc3RhdGljIHZvaWQgb3Zwbl9zZW5kKHN0cnVjdCBvdnBu
X3ByaXYgKm92cG4sIHN0cnVjdCBza19idWZmICpza2IsCiAJb3Zwbl9wZWVyX3B1dChwZWVy
KTsKIH0KIAorLyoqCisgKiBvdnBuX3NrYl9pc19sb29waW5nIC0gY2hlY2sgaWYgc2tiIGNv
bWVzIGZyb20gdGhlIHBlZXIncyBvd24gc29ja2V0CisgKiBAcGVlcjogdGhlIHBlZXIgdGhl
IHNrYiBpcyBhYm91dCB0byBiZSBzZW50IHRvCisgKiBAc2tiOiB0aGUgcGFja2V0IHRvIGNo
ZWNrCisgKgorICogUmV0dXJuOiB0cnVlIGlmIEBza2Igd2FzIGdlbmVyYXRlZCBieSB0aGUg
dHJhbnNwb3J0IHNvY2tldCBvZiBAcGVlciwKKyAqIGZhbHNlIG90aGVyd2lzZQorICovCitz
dGF0aWMgYm9vbCBvdnBuX3NrYl9pc19sb29waW5nKHN0cnVjdCBvdnBuX3BlZXIgKnBlZXIs
CisJCQkJY29uc3Qgc3RydWN0IHNrX2J1ZmYgKnNrYikKK3sKKwlzdHJ1Y3Qgb3Zwbl9zb2Nr
ZXQgKnNvY2s7CisJYm9vbCByZXQ7CisKKwlpZiAoIXNrYi0+c2spCisJCXJldHVybiBmYWxz
ZTsKKworCXJjdV9yZWFkX2xvY2soKTsKKwlzb2NrID0gcmN1X2RlcmVmZXJlbmNlKHBlZXIt
PnNvY2spOworCXJldCA9IHNvY2sgJiYgc29jay0+c2sgPT0gc2tiLT5zazsKKwlyY3VfcmVh
ZF91bmxvY2soKTsKKworCXJldHVybiByZXQ7Cit9CisKIC8qIFNlbmQgdXNlciBkYXRhIHRv
IHRoZSBuZXR3b3JrCiAgKi8KIG5ldGRldl90eF90IG92cG5fbmV0X3htaXQoc3RydWN0IHNr
X2J1ZmYgKnNrYiwgc3RydWN0IG5ldF9kZXZpY2UgKmRldikKQEAgLTM4Niw2ICs0MTEsMTMg
QEAgbmV0ZGV2X3R4X3Qgb3Zwbl9uZXRfeG1pdChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1
Y3QgbmV0X2RldmljZSAqZGV2KQogCQl9CiAJCWdvdG8gZHJvcF9ub19wZWVyOwogCX0KKwor
CWlmICh1bmxpa2VseShvdnBuX3NrYl9pc19sb29waW5nKHBlZXIsIHNrYikpKSB7CisJCW5l
dF93YXJuX3JhdGVsaW1pdGVkKCIlczogcmVjdXJzaXZlIHJvdXRpbmcgZGV0ZWN0ZWQsIGRy
b3BwaW5nIFRDUCBwYWNrZXQgdG8gcGVlciAldVxuIiwKKwkJCQkgICAgIG5ldGRldl9uYW1l
KG92cG4tPmRldiksIHBlZXItPmlkKTsKKwkJZ290byBkcm9wOworCX0KKwogCS8qIGRzdCB3
YXMgbmVlZGVkIGZvciBwZWVyIHNlbGVjdGlvbiAtIGl0IGNhbiBub3cgYmUgZHJvcHBlZCAq
LwogCXNrYl9kc3RfZHJvcChza2IpOwogCi0tIAoyLjU1LjAKCg==

--------------ctKOJIKLIJqDZeW0PeDODiFr
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------ctKOJIKLIJqDZeW0PeDODiFr
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--------------ctKOJIKLIJqDZeW0PeDODiFr--

