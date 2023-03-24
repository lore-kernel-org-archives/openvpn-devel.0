Date: Fri, 24 Mar 2023 12:14:59 +0100 (CET)
Message-Id: <202303241114.32OBExpR082008@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230324100640.1340535-1-arne@...1227...>
References: <20230324100640.1340535-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add 'allow-compression
 stub-only' internally for DCO
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

This is the actual thing we want to fix: if a server pushes 'comp-lzo no',
a non-DCO client will enable compression framing, while a DCO client can
not do this, and silently stays on "no framing" - and then both sides
will drop all data packets because "incorrect format".   We can not "make
it work", but we *can* abort the connection with a clear message so
the VPN provider / server operator can fix their setup.

This change also removes sending of all IV_COMP* variables to the server
if DCO is active - so a "server that cares" knows that it must not send
any compression settings.


I have run this through the t_client/t_server tests on DCO and non DCO
hosts, with and without compression, and all the existing setups still
work fine, including compatibility to older versions.

I have also tested pushed options and ccd/ options on "no compression
enabled" setups

 - pushing 'comp-lzo no' with no DCO --> accepted, do "stub" framing

 - pushing 'comp-lzo no' with DCO active --> refused, SIGUSR1 restart

   2023-03-24 09:09:48 Compression or compression stub framing is not 
     allowed since data-channel offloading is enabled.
   2023-03-24 09:09:48 OPTIONS ERROR: server pushed compression settings 
     that are not allowed and will result in a non-working connection.
     See also allow-compression in the manual.

 - pushing 'compress lz4' is refused in both cases, unless
   "allow-compression asym/yes" is set

 - ccd file producing 'comp-lzo no'
 - ccd file producing 'compress stub-v2'
 - ccd file producing 'compress lz4'
   --> this all works as expected (refusing the client with AUTH_FAILED), 
       though we have started to be "just a bit" chatty about this...

    tun-udp-p2mp[564755]: peer-id=1 OPTIONS IMPORT: reading client specific options from: ccd/freebsd-14-amd64
    tun-udp-p2mp[564755]: peer-id=1 Note: '--allow-compression' is not set to 'no', disabling data channel offload.
    tun-udp-p2mp[564755]: peer-id=1 MULTI: client has been rejected due to incompatible DCO options
    tun-udp-p2mp[564755]: peer-id=1 Compression or compression stub framing is not allowed since data-channel offloading is enabled.
    tun-udp-p2mp[564755]: peer-id=1 MULTI: client has been rejected due to invalid compression options


Compilation with --disable-lzo --disable-lz4 is still broken with this
commit - this was overlooked in part 2/4, and will be fixed in 4/4.

Your patch has been applied to the master and release/2.6 branch.

commit 4117d950788eebfaf6c9b5dde278e3a81b9e805d (master)
commit 2ac91ea73b76dd17d5cdf78740790ed928e08bff (release/2.6)
Author: Arne Schwabe
Date:   Fri Mar 24 11:06:40 2023 +0100

     Add 'allow-compression stub-only' internally for DCO

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230324100640.1340535-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26509.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


