Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7678CC6B03
	for <openvpn-devel@archiver.kernel.org>; Tue, 13 Oct 2026 12:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M8pyXzvn2BZ70+5CYL4babcNMqH1AOt/U0PZc5917yI=; b=BjtNlhD6xOPQzyco49cOZo93qg
	NsYBccy8JDmSscc5P1bZKQtocR+gGf4hhp2URkOtQbsc0G6gqVu5xXNGhOqp2pA7STmCFoszxxAfu
	MImrZF1T5MmyFwFWh/umh/csXZGJ3xEs5207R1SbhiYYOGRSxZEm+YhnXuq9LCTUmlO0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGbTk-0001xH-J1;
	Tue, 13 Oct 2026 12:19:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sd@queasysnail.net>) id 1xGbTi-0001x8-50
 for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 12:19:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SsLpsCddq9dHzH+FkRKI5zBJf/KqSCXm34jjS9vUyd0=; b=K9XsNDeI8qTQTA2dm916PQcFDx
 92/jgSqsWIDhbdcolYqlDIoo0qFjnsATLw3O/9R0aOwp6+jKmsH1qm2GJrUaIq0hD26E+xc2MqroF
 FoM9ErW11U4sgEKMuH3GN+QSwY3XuDLX3NRzLGhvjs+6Ch41EuJ4mExbkDVhLuz7r2Lg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SsLpsCddq9dHzH+FkRKI5zBJf/KqSCXm34jjS9vUyd0=; b=KvbO8pwjxZuPe+Ip6acTiXx7c8
 3d3m9zeO28eio6JK7Y0BQ1Bpa2JkLd7W94tCD9DxCi0n7CBFU/bpxcQURMxYnXEbu3B5zwv6ZMrPU
 xy/JdE6PylBIyb3axfJsBNo3zz6ccw0R8EltTm6yKxs/gNtX84tazPNfoEXCKs5H8gNY=;
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGbTe-0002E9-IB for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 12:19:34 +0000
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id CE536140014C
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 08:19:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Tue, 13 Oct 2026 08:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1791893964; x=
 1791980364; bh=SsLpsCddq9dHzH+FkRKI5zBJf/KqSCXm34jjS9vUyd0=; b=g
 sdOinLsGXjfG5Sxn9+l1NnwhtEWvKDrtFbcB0kZ8+uYtrSO1F8bzNjR8Pd01xFvj
 uGeoBywQsGyDVhyjLQdNriJ0DpPtN+xKda7a0DDMjhZiag4zo/MaL7Hf38OQpoTM
 EgZ2kUxQ5gadAgyUVfXGdnbsksFyC7D09DVTwoobY3dUHUzYiOgAq37ckFEnnq8U
 CUe7kN2p6pi3ppO4fyRlABcCpYuCw+aaJUnpj8WvOInqmYLgPhS7g8gAAAbmvm7J
 hBNQeRQdRGc6GheUaR06WOblr+2tnX4L4us/mgH2Aq1cl1sfXulEk5Yn062CUMw8
 Fyek+nNIMUDvMIa906Iqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1791893964; x=1791980364; bh=SsLpsCddq9dHzH+FkRKI5zBJf/KqSCXm34j
 jS9vUyd0=; b=K719eRotTfx31dCUeYhkzK82VnVXiZBquDKnyPv7BJM8ZhvMn0F
 LPgmOPpWTqGSOTgQFnTUwE/ZRLr/ePmPDF9DCQ+rNCTfuygnDqy9SFGAmAuzvEoK
 lxQ2HFv7I7EG7pjhyE4OpCu5apX7VlDHfgjApEsFglGfO0GKFA5Wsyzp6QO+tJU1
 1muV7qc4wcUvzuL2KFB4vH2YGmxhmkgA+IsVpA34tOaI7WtSx8jGisA5XeVhSZJP
 XB4L8afWq5BLO6OpGtVQl03oXSrGKqoT35M6iC/4dJ/DgATklMpIYJFyWSYISjz/
 sWE6cjiSgNI0JlMrhNKVxrsqQFWWl3RIlYw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=queasysnail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791893964; d=queasysnail.net;
 mf=PHNkQHF1ZWFzeXNuYWlsLm5ldD4=;
 rt=PG9wZW52cG4tZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Pg==;
 s=fm3:rsa-sha256:kOkQlbI5IH8ms/zTa+h33Vd3nA3zazIT2YivKALxbJ1y03l
 A3spyRazqjLvEfoSA1YF77/s319CTt9emx+rznRZ/oV55fSFm8uTygPFl/Fu0Baf
 nzeE3nUAUxHIbt01V8664sCnhslhtsZNOWbXHP6BfvY9W/zdQR26cFXLsYisRMa0
 dbkKkLnUjH8QuiRzuJTTtgE0XWaRSZqDyVTtSDhsdbl6ai4MrgE0AHaee6NBUozp
 SekKJd/TuHhRQIOk5pksvk6cF3zHGtMXm4BDcAMP0w/8HEtVtV/yGdN0kmPAeWYz
 3UVVNCytOOdA/jJB1fGxIpfibD/4MyezypK/qdw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-disposition,content-type,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:13imiPxzLa+i08bVb/L5gbsxwih3onycWvoXRkFq/Lg=:C/nRm9vqUIP+Pck0tWCwOhUJN/nJS3qnW3A3xcdLLQ0=;
X-ME-Sender: <xms:zCHOao005fsjm919zbmpZd0MlfmnaaecqN6VFXn7r_qFjsYHHLl9-w>
 <xme:zCHOapGtXb6n1qVhyeBD0LArSV58yPVUwTp5Du1w7DiLbcmW5E5hF7dulRgL3qBr5
 bgWvbz2Mko5REKkgNzDzBCL3gHdAvHVaTu0HKHjHQRxSRT4Gh4DDzoQJQ>
X-ME-Received: <xmr:zCHOaugiyCtD1WUENJIlUMr7zompeGFNFNIFH-LIfhZI12v-AEwNziDtdco>
X-ME-Proxy-Cause: dmFkZTGowJGuJI9q5oQhiuJeL+VkQOPBkWPuDwTSjjX9/smKFqrqUkv5KN7so2U328XtSz
 JcQturCfhcXqgyD2fiQ0oC2xAQOq2SZH9gndJ2iFf9VjM8Gyy+ptaRqhJFANUMqenzXiFg
 FKrmhjTQ5pvXafXkAfS+tiPa7ZbiWwJF+FTSlG9P+UK8cPioqKLHPa4nqhM7uq/cK/KCok
 ih4iumzOfITlDV88t1zlcLnVhQ+CEGn4t0fE3IczQjHOJWLv3TZsHkMpemS87VDWcdh4KL
 uGecZ3hQjjsrDo03ftOteD9AqctOo+R3ZATcFVLNmRpRqQwk/W7XRTs8SgIciT/H+h8stJ
 qSW1G5PvyxAj6DPHXl9Bakc82VgoxUJY2ugdO/H3FKAIx7BSAHdUjBj5LqVBVsoQ2LSseu
 f1L1gSuQAFYx1SFshkmlw6MdZ0nR6NERPg/iYOsUgP90dhGWqH9Cg/N5xPoRg8EOlX8VSA
 3sy4R+sGNLcdfF5wPz6veUNTqpaGJWWny0M0I40EIAWhUc+RkALHlzt5TyqU56yNbfbaHn
 LdhH2AnGsubkgKA0jsrHxe43bgWr3HJ8FX6FicYGEu41W8hc2O0xvkNab1nV/M6Xf9iQ2j
 CvnqeAq8clk+1ewfJw6fduPjiUyIzwhxHV3Qv65/o6zktTneaxiq//q3jkNA
X-ME-Proxy: <xmx:zCHOas-VTfkec7AztgzTFatDpEOrT9wfwCrGg333vtr44qxMff_rTw>
 <xmx:zCHOatpAO2Fns2B6-pp2b3W2c9NpbdKXHYQ_bU_-bLhKMB3Z2DrgGg>
 <xmx:zCHOaj9kDhW3-cE1udEBtb77MaXvgB-fhw9b2Ci_x1V25niIwjb_ug>
 <xmx:zCHOapX72czrcPxtY851Ty9LlfLENNUxPqL1ebupvQ-0kO4niZiNCQ>
 <xmx:zCHOaokhoFYzknuQDPLQ8XNfyVR7c3bMNJORREIq1UP17sCrHij3lM9J>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 08:19:23 -0400 (EDT)
Date: Tue, 13 Oct 2026 14:19:22 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Ralf Lici <ralf@mandelbit.com>
Message-ID: <as4hyq85bV916Ktb@krikkit>
References: <cover.1790843153.git.ralf@mandelbit.com>
 <47eee3045f402b2baf7db759bc9cfd35dee8f73d.1790843153.git.ralf@mandelbit.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47eee3045f402b2baf7db759bc9cfd35dee8f73d.1790843153.git.ralf@mandelbit.com>
X-Headers-End: 1xGbTe-0002E9-IB
Subject: Re: [Openvpn-devel] [PATCH ovpn net-next 4/8] ovpn: convert GSO
 input into UDP GSO output
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
Cc: openvpn-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

2026-10-01, 10:41:23 +0200, Ralf Lici wrote:
>  void ovpn_encrypt_post(void *data, int ret)
>  {
> +	unsigned int orig_len, packets = 1;
>  	struct ovpn_crypto_key_slot *ks;
>  	struct sk_buff *skb = data;
>  	struct ovpn_socket *sock;
> +	struct ovpn_cb *batch_cb;
>  	struct ovpn_peer *peer;
> -	unsigned int orig_len;
> +	struct sk_buff *batch;
>  
>  	/* encryption is happening asynchronously. This function will be
>  	 * called later by the crypto callback with a proper return value
> @@ -249,15 +259,19 @@ void ovpn_encrypt_post(void *data, int ret)
>  	if (unlikely(ret == -EINPROGRESS))
>  		return;
>  
> -	ks = ovpn_skb_cb(skb)->ks;
> +	/* ordinary encryption leaves batch zeroed; a GSO input uses it to find
> +	 * the aggregate whose lifetime is shared by all segment requests
> +	 */
> +	batch = ovpn_skb_cb(skb)->batch;
>  	peer = ovpn_skb_cb(skb)->peer;
> +	ks = ovpn_skb_cb(skb)->ks;
>  
>  	/* crypto is done, cleanup skb CB and its members */
>  	kfree(ovpn_skb_cb(skb)->crypto_tmp);
>  
>  	if (unlikely(ret == -ERANGE)) {
>  		/* we ran out of IVs and we must kill the key as it can't be
> -		 * use anymore
> +		 * used anymore
>  		 */
>  		netdev_warn(peer->ovpn->dev,
>  			    "killing key %u for peer %u\n", ks->key_id,
> @@ -265,8 +279,30 @@ void ovpn_encrypt_post(void *data, int ret)
>  		if (ovpn_crypto_kill_key(&peer->crypto, ks->key_id))
>  			/* let userspace know so that a new key must be negotiated */
>  			ovpn_nl_key_swap_notify(peer, ks->key_id);
> +	}
>  
> -		goto err;
> +	if (batch) {
> +		batch_cb = ovpn_skb_cb(batch);
> +		/* every segment publishes its result before releasing its
> +		 * pending count and only the final completion continues with
> +		 * the aggregate
> +		 */
> +		if (unlikely(ret < 0))
> +			atomic_set(&batch_cb->batch_state.failed, 1);
> +
> +		kfree_skb(skb);
> +		if (!atomic_dec_and_test(&batch_cb->batch_state.pending))
> +			return;

Without reviewing the whole thing in detail:

You're getting into the same kind of horrible mess that ktls had to
deal with because of async crypto... maybe AI reviews manage to make
this type of code actually work now, but I wouldn't bet my life on
that.

-- 
Sabrina


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
