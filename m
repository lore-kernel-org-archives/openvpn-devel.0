Date: Thu, 8 Oct 2020 17:02:18 +0200 (CEST)
Message-Id: <202010081502.098F2Ijl037836@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201008115959.21151-1-arne@...1227...>
References: <20201008115959.21151-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Allow 'none' cipher being
 specified in --data-ciphers
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

I have added two new cases to my server test suite: client with 
"--data-ciphers none" and "--ncp-disable --cipher none", against 
a server instance that permits "none" as part of its data-ciphers.

The first case failed on the client side ("unrecognized
cipher: none"), the second case was refused by the server side 
("No common cipher... client supports cipher '[null-cipher]').

Of course the server side *also* needs the patch to accept
"none" as part of --data-ciphers :-)

Then, this works:

2020-10-04 15:04:28 us=208824 2001:608:4:0:669a:56c1:4175:2c5b peer info: IV_CIPHERS=none
2020-10-04 15:04:28 us=251968 Data Channel: using negotiated cipher 'none'
2020-10-04 15:04:28 us=252006 ******* WARNING *******: '--cipher none' was ...

The warning in the logs is very clear and explicit - and I think
this is good.  This is a very special-use setting, and should
only be used with sufficient information and consideration.


Big IPv4 packets (t_client test with 3000 bytes) do not work - something
is wrong in our mtu/overhead calcululation.  But this is not something 
new (as the v3 commit message rightly points out) - if I do "client 
connects with --data-cipher DES-EDE3-CBC" (non AEAD) I get the same 

  TCP/UDP packet too large on write to ... (tried=1544,max=1542)

error as I have with "none" (there, it is tried=1529,max=1526).  Strange 
enough this only happens for IPv4 packets.


Your patch has been applied to the master and release/2.5 branch.

commit c018fc00be25aee5921d234531f87753a3a7aec7 (master)
commit f308251acdc539acb370aeccf46b0ec5587129c1 (release/2.5)
Author: Arne Schwabe
Date:   Thu Oct 8 13:59:59 2020 +0200

     Allow 'none' cipher being specified in --data-ciphers

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20201008115959.21151-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21181.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


