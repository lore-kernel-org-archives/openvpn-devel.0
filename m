Date: Thu, 1 Dec 2022 14:36:31 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y4it32DtQNzL5atW@...2685...>
References: <20221122183706.12561-1-gert@...1296...>
 <20221130205718.79765-1-gert@...1296...>
MIME-Version: 1.0
In-Reply-To: <20221130205718.79765-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v14] Add DNS SRV remote host discovery
 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

I have several nitpicks with this patch which I can enumerate later, but there
is at least one critical issue which prevents me from ACKing this:

# src/openvpn/openvpn --client --tls-cert-profile insecure --ca ../ca.crt       --cert ../t_client.c\
rt --key ../t_client.key    --remote-cert-tls server --comp-lzo --verb 3  --dev tun --proto tcp4 --r\
emote-srv lichtenheld.net --writepid ../tests/t_client-flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7\
-20221201-141818/openvpn-1.pid --setenv TESTNUM 1 --setenv TOP_BUILDDIR .. --script-security 2 --up \
./update_t_client_ips.sh
2022-12-01 14:18:20 WARNING: Compression for receiving enabled. Compression has been used in the pas\
t to break encryption. Sent packets are not compressed unless "allow-compression yes" is also set.
2022-12-01 14:18:20 Note: --cipher is not set. OpenVPN versions before 2.5 defaulted to BF-CBC as fa\
llback when cipher negotiation failed in this case. If you need this fallback please add '--data-cip\
hers-fallback BF-CBC' to your configuration and/or add BF-CBC to --data-ciphers.
2022-12-01 14:18:20 OpenVPN 2.6_git [git:master/c98fe8b90271df5c] x86_64-pc-linux-gnu [SSL (OpenSSL)\
] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] built on Dec  1 2022
2022-12-01 14:18:20 library versions: OpenSSL 3.0.2 15 Mar 2022, LZO 2.10
2022-12-01 14:18:21 Resolved remote service host: conn-test-server.openvpn.org:51194,udp4 prio 0 wei\
ght 0
2022-12-01 14:18:21 Resolved remote service host: conn-test-server.openvpn.org:51194,tcp4-client pri\
o 0 weight 0
2022-12-01 14:18:21 NOTE: the current --script-security setting may allow this configuration to call\
 user-defined scripts
2022-12-01 14:18:21 TCP/UDP: Preserving recently used remote address: [AF_INET]199.102.77.82:51194
2022-12-01 14:18:21 Socket Buffers: R=[212992->212992] S=[212992->212992]
2022-12-01 14:18:21 UDPv4 link local: (not bound)
2022-12-01 14:18:21 UDPv4 link remote: [AF_INET]199.102.77.82:51194

As you can see it ignores the "--proto tcp4" if no proto was specified in --remote-srv.
This is inconsistent with how --remote works. I don't think this can be the desired
behaviour.

Regards,
-- 
  Frank Lichtenheld

