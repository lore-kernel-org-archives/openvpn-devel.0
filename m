Date: Fri, 29 Apr 2022 15:34:59 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <613700148.693810.1651239299897@...2642...>
In-Reply-To: <19ea8bac-8dc5-8e6b-2db3-615565f2a04e@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220427223419.241904-1-arne@...1227...>
 <20220427223419.241904-2-arne@...1227...>
 <2127738744.675772.1651228104970@...2642...>
 <19ea8bac-8dc5-8e6b-2db3-615565f2a04e@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2] Implement stateless,
 HMAC basedsesssion id three way handshake
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

> Arne Schwabe <arne@...1227...> hat am 29.04.2022 13:31 geschrieben:
> Am 29.04.22 um 12:28 schrieb Frank Lichtenheld:
> >> Instead of allocating a connection for each client on the initial packet
> >> OpenVPN will now send back a response that contains an HMAC based cookie
> >> that the client will need to respond to. This eliminates the amplification
> >> attack and resource exhaustion attacks. For tls-crypt-v2 client HMAC based
> >> handshake is not used yet.
> > 
> > I think this is not very helpful in understanding the change. In trying to
> > understand it, this is my personal explanation I came up with. Not sure
> > whether it is correct, but maybe it can be useful:
> > 
> > "Instead of allocating a connection for each client on the initial
> > HARD_RESET_CLIENT packet OpenVPN server will now create its own session id
> > for the HARD_RESET_SERVER packet as an HMAC of client data. This way it can
> > verify the session id on the second packet of
> > the client (ACK or CONTROL) and only create the connection then."
> > 
> > "This eliminates the amplification [...]" (unchanged)
> 
> 
> New try:
> 
> Instead of allocating a connection for each client on the initial packet
> OpenVPN will now calculate a session id based on a HMAC that serves as
> verifiable cookie that can be checked for authenticity when the client
> responds with it. This eliminates the amplification attack and resource
> exhaustion attacks. For tls-crypt-v2 clients the HMAC based handshake
> is not used yet.

I'm not sure why you are against including more low-level details here,
but I think this is good enough to not warrant further discussion.

> >> +
> >> +        bool ret = check_session_id_hmac(state, from, hmac, handwindow);
> >> +
> >> +        const char *peer = print_link_socket_actual(&m->top.c2.from, &gc);
> >> +        if (!ret)
> >> +        {
> >> +
> >> +            msg(D_MULTI_MEDIUM, "Packet with invalid or missing SID from %s", peer);
> > 
> > Not a review, but rather a question: What actually happens to the connection in this
> > code path?
> 
> The packet is simply dropped. This can happen when clients send ACK + 
> CONTROL_V1 (clienthello) as response and the ACK (that contains the 
> session id) and the ACK gets lost. OpenVPN 3 client already combine the 
> packet and do not suffer the problem and for OpenVPN 2.x the later 
> patches in the series also ensure that all packets have the session id 
> in them.
> 
> This is will be an extra resend for the affected clients.

Okay, thanks.

Regards,
--
Frank Lichtenheld

