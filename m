Date: Mon, 14 Nov 2022 13:37:30 +0100 (CET)
Message-Id: <202211141237.2AECbUHL096088@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221109154810.1268403-2-arne@...1227...>
References: <20221109154810.1268403-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Push server mtu to client when
 supported and support occ mtu
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Stared-at-code, discussed on IRC, and dropped "Changes.rst" entry, as
user-visible behaviour is no longer changed (no default-MTU change).

Tested on the server testbed, having one instance do "tun-mtu 1400 1500"
now, and depending on client version, have it push MTU or not.

The OCC lying feature works - tried "max-mtu 1400 1490" and got
  WARNING: 'tun-mtu' is used inconsistently, local='tun-mtu 1490', remote='tun-mtu 1500'

.. we need to do something about OCC and link-mtu, though...
  WARNING: 'link-mtu' is used inconsistently, local='link-mtu 1442', remote='link-mtu 1545'
(outside of this patch, but annoying)


Also tested with "--tun-mtu 2000 1500", to trigger the "client cannot
handle this" message... works.  Well, sort of - the server still sends
a too-big MTU...

194.97.140.21:50362 peer info: IV_MTU=1800
cron2-freebsd-tc-amd64/194.97.140.21:50362 Warning: reported maximum MTU from client (1800) is lower than MTU used on the server (2000). Add tun-max-mtu 2000 to client configuration.
cron2-freebsd-tc-amd64/194.97.140.21:50362 SENT CONTROL [cron2-freebsd-tc-amd64]: 'PUSH_REPLY,... cc-exit tls-ekm,tun-mtu 2000' (status=1)

.. but the client ignores this...

OPTIONS IMPORT: tun-mtu set to 2000
Server-pushed tun-mtu is too large, please add tun-mtu-max 2000 in the client configuration

.. and configures 1800 (configured --max-tun-mtu on the client).

tcpdump confirms that pings *inside* the tunnel go up to 1800 without
fragmentation...

13:29:57.041939 IP 10.204.2.6 > 10.204.0.1: ICMP echo request, id 49729, seq 31, length 1780
13:29:57.042693 IP 10.204.0.1 > 10.204.2.6: ICMP echo reply, id 49729, seq 31, length 1780

.. but if I go larger ("ping -s 2000") the MTU mismatch "server 2000,
client 1800" strikes, and I get

2022-11-14 13:30:13 tun packet too large on write (tried=1996,max=1968)

(--tun-mtu-max 2000 on the client will fix this).  This is expected -
there is some headroom, but not "200 bytes".  So when going large-mtu,
ensure your client configs are matching.


Your patch has been applied to the master branch.

commit 761575cb7b49e94f361c6aaf4bb43d7c7baa5b38
Author: Arne Schwabe
Date:   Wed Nov 9 16:48:10 2022 +0100

     Push server mtu to client when supported and support occ mtu

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221109154810.1268403-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25499.html
     Signed-off-by: Gert Doering <gert@...1296...>

--
kind regards,

Gert Doering


