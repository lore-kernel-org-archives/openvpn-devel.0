Date: Sun, 11 Jun 2017 11:52:45 +0200 (CEST)
Message-Id: <201706110952.v5B9qjLj037753@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <CAO5O-E+HdfHNAK=--55054AB374U-Ky4q_-3M114makfPdSnBw@...278...>
References: <CAO5O-E+HdfHNAK=--55054AB374U-Ky4q_-3M114makfPdSnBw@...278...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix memory leak in add_option()
 for option 'connection'
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
To: Guido Vranken <guidovranken@...277...>
Cc: openvpn-devel@lists.sourceforge.net

ACK, thanks.  

(The actual "init_options()" bit is not the real cause of the memory 
leak here, as gc_init() doesn't allocate anything yet, but the 
read_config_string(...&sub...) will use the gc arena...  interesting
enough, the *final* uninit_options(&sub) in this function is a NO-OP,
as gc_transfer() has moved all the allocated memory pointers to the
top layer GC arena, and nothing is left in "sub" to cleanup...)

As another side note: while this is a memory leak in the case of errors, 
it's somewhat in the "it does not really matter" category, as an option 
parsing error *here* always leads to program end.  This code can never 
be executed for server-pushed options (where parsing errors would be 
considered "warning" and a mem-leak would persist).

Your patch has been applied to the master, release/2.4 and release/2.3 branch.

commit d89e14d92623731d2fa6343a11072caab32e13cd (master)
commit 42fc73b969f4e34fd985a0be59d162fb2ee498e1 (release/2.4)
commit 64933bf444fd83a6f04a1a13f0b2a67caa43a2cb (release/2.3)
Author: Guido Vranken
Date:   Fri Jun 9 00:04:36 2017 +0200

     Fix memory leak in add_option() for option 'connection'

     Signed-off-by: Guido Vranken <guidovranken@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <CAO5O-E+HdfHNAK=--55054AB374U-Ky4q_-3M114makfPdSnBw@...278...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14764.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


