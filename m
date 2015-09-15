From: Arne Schwabe <arne@...1227...>
References: <1441985627-14822-1-git-send-email-gert@...1296...>
	<1441985627-14822-6-git-send-email-gert@...1296...>
Message-ID: <55F7E8CC.8000908@...1227...>
Date: Tue, 15 Sep 2015 10:45:48 +0100
MIME-Version: 1.0
In-Reply-To: <1441985627-14822-6-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 05/10] get_default_gateway_ipv6(): Linux
 / Netlink implementation.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net


+    CLEAR(rtreq);
+    rtreq.nh.nlmsg_type = RTM_GETROUTE;
+    rtreq.nh.nlmsg_flags = NLM_F_REQUEST;			/* XXX */

There should an indication why this is XXX, some kind of comment.
> +    rtreq.rtm.rtm_family = AF_INET6;
> +    rtreq.rtm.rtm_src_len = 0;
> +    rtreq.rtm.rtm_dst_len = 128;				/* exact dst */
> +    rtreq.rtm.rtm_table = RT_TABLE_MAIN;
> +    rtreq.rtm.rtm_protocol = RTPROT_UNSPEC;
> +    rtreq.nh.nlmsg_len = NLMSG_SPACE(sizeof(rtreq.rtm));
> +
> +    /* set RTA_DST for target IPv6 address we want */
> +    rta = (struct rtattr *)(((char *) &rtreq)+NLMSG_ALIGN(rtreq.nh.nlmsg_len));
> +    rta->rta_type = RTA_DST;
> +    rta->rta_len = RTA_LENGTH(16);
> +    rtreq.nh.nlmsg_len = NLMSG_ALIGN(rtreq.nh.nlmsg_len) +
> +                                             RTA_LENGTH(16);
> +
> +    if ( dest == NULL )			/* ::, unspecified */
> +	memset( RTA_DATA(rta), 0, 16 );	/* :: = all-zero */
> +    else
> +	memcpy( RTA_DATA(rta), (void *)dest, 16 );
> +
> +    /* send and receive reply */
> +    if ( send( nls, &rtreq, rtreq.nh.nlmsg_len, 0 ) < 0 )
> +	{ msg(M_WARN|M_ERRNO, "GDG6: send() failed" ); goto done; }
> +
> +    ssize = recv(nls, rtbuf, sizeof(rtbuf), MSG_TRUNC);
> +
> +    if (ssize < 0)
> +	{ msg(M_WARN|M_ERRNO, "GDG6: recv() failed" ); goto done; }
> +
> +    if (ssize > sizeof(rtbuf))
> +    {
> +	msg(M_WARN, "get_default_gateway_ipv6: returned message too big for buffer (%d>%d)", (int)ssize, (int)sizeof(rtbuf) );
> +	goto done;
> +    }
> +
> +    struct nlmsghdr *nh;
> +
> +    for (nh = (struct nlmsghdr *)rtbuf;
> +         NLMSG_OK(nh, ssize);
> +         nh = NLMSG_NEXT(nh, ssize))
> +    {
> +	struct rtmsg *rtm;
> +	int attrlen;
> +
> +	if (nh->nlmsg_type == NLMSG_DONE) { break; }
The coding style here is different ithan in other parts of OpenVPN.
> +
> +	if (nh->nlmsg_type == NLMSG_ERROR) {
> +	    struct nlmsgerr *ne = (struct nlmsgerr *)NLMSG_DATA(nh);
> +	    msg(M_WARN, "GDG6: NLSMG_ERROR: error %d\n", ne->error);
> +	    break;
> +	}
> +
> +	if (nh->nlmsg_type != RTM_NEWROUTE) {
> +	    /* shouldn't happen */
> +	    msg(M_WARN, "GDG6: unexpected msg_type %d", nh->nlmsg_type );
> +	    continue;
> +	}
> +
> +	rtm = (struct rtmsg *)NLMSG_DATA(nh);
> +	attrlen = RTM_PAYLOAD(nh);
> +
> +	/* we're only looking for routes in the main table, as "we have
> +	 * no IPv6" will lead to a lookup result in "Local" (::/0 reject)
> +	 */
> +	if (rtm->rtm_family != AF_INET6 ||
> +	    rtm->rtm_table != RT_TABLE_MAIN)
> +		{ continue; }		/* we're not interested */
> +
We night want to revisit this with more complex routing scenarios.
Android for example uses the main routing table only to jump more
specific routing tables. Other system might do the same.
> +	for (rta = RTM_RTA(rtm);
> +	     RTA_OK(rta, attrlen);
> +	     rta = RTA_NEXT(rta, attrlen))
> +	{
> +	    if (rta->rta_type == RTA_GATEWAY) {
> +		if ( RTA_PAYLOAD(rta) != sizeof(struct in6_addr) )
> +			{ msg(M_WARN, "GDG6: RTA_GW size mismatch"); continue; }
> +		rgi6->gateway.addr_ipv6 = *(struct in6_addr*) RTA_DATA(rta);
> +		rgi6->flags |= RGI_ADDR_DEFINED;
> +	    }
> +	    else if (rta->rta_type == RTA_OIF) {
> +		char ifname[IF_NAMESIZE+1];
> +		int oif;
> +		if ( RTA_PAYLOAD(rta) != sizeof(oif) )
> +			{ msg(M_WARN, "GDG6: oif size mismatch"); continue; }
> +
> +		memcpy(&oif, RTA_DATA(rta), sizeof(oif));
> +		if_indextoname(oif,ifname);
> +		strncpy( rgi6->iface, ifname, sizeof(rgi6->iface)-1 );
> +		rgi6->flags |= RGI_IFACE_DEFINED;
> +	    }
> +	}
> +    }
> +
> +    /* if we have an interface but no gateway, the destination is on-link */
> +    if ( ( rgi6->flags & (RGI_IFACE_DEFINED|RGI_ADDR_DEFINED) ) ==
> +              RGI_IFACE_DEFINED )
> +    {
> +	rgi6->flags |= (RGI_ADDR_DEFINED | RGI_ON_LINK);
> +	rgi6->gateway.addr_ipv6 = *dest;
> +    }
> +
> +  done:
> +    if (nls >= 0)
> +	close (nls);
>

Aside from these comment, this gets an ACK from me.

Arne

