Date: Fri, 29 Apr 2022 15:25:49 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1092698496.693105.1651238749643@...2642...>
In-Reply-To: <1078939443.692575.1651238286579@...2642...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
 <20220422142953.3805364-13-arne@...1227...>
 <877931381.691988.1651237887669@...2642...>
 <1078939443.692575.1651238286579@...2642...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 22/28] Implement HMAC based session id
 for tls-crypt v2
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

> Frank Lichtenheld <frank@...2641...> hat am 29.04.2022 15:18 geschrieben:
> > Frank Lichtenheld <frank@...2641...> hat am 29.04.2022 15:11 geschrieben:
> > > Arne Schwabe <arne@...1227...> hat am 22.04.2022 16:29 geschrieben:
> [...]
> > > diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
> > > index c4e23521d..184b88383 100644
> > > --- a/tests/unit_tests/openvpn/test_pkt.c
> > > +++ b/tests/unit_tests/openvpn/test_pkt.c
> > > @@ -531,7 +531,7 @@ test_generate_reset_packet_plain(void **ut_state)
> > >  
> > >      uint8_t header = 0 | (P_CONTROL_HARD_RESET_CLIENT_V2 << P_OPCODE_SHIFT);
> > >  
> > > -    struct buffer buf = tls_reset_standalone(&tas, &client_id, &server_id, header);
> > > +    struct buffer buf = tls_reset_standalone(&tas, &client_id, &server_id, header, 0, 0);
> > 
> > Nitpick: the second 0 should be "false" instead. Same for all further calls in this file.
> 
> Note: fixed in 23/28

Note: the issue here is worse than I initially assumed. Not only should the second 0 be false, the
first 0 is just completely wrong, since the second new parameter was added as the first parameter.

So the UT is actually broken in 22/28 and needs the fix from 23/28:

[ RUN      ] test_generate_reset_packet_plain
[  ERROR   ] --- ASSERT: buf_write(&buf, &net_pid, sizeof(net_pid))
[   LINE   ] --- ../../../src/openvpn/ssl_pkt.c:444: error: Failure!
[  FAILED  ] test_generate_reset_packet_plain
[ RUN      ] test_generate_reset_packet_tls_auth
[  ERROR   ] --- ASSERT: buf_write(&buf, &net_pid, sizeof(net_pid))
[   LINE   ] --- ../../../src/openvpn/ssl_pkt.c:444: error: Failure!
[  FAILED  ] test_generate_reset_packet_tls_auth

Regards,
--
Frank Lichtenheld

