Date: Mon, 13 Mar 2023 17:28:54 +0100 (CET)
Message-Id: <202303131628.32DGSsL8003142@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230309131419.29157-1-a@...2181...>
References: <20230309131419.29157-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: print version to log if
 available
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

I briefly tested this on a system with the dco-v2 kernel module
(and with the module unloaded).  It did what I expected:

 DCO version: 0.1.20230206-15-g580608e

or

 DCO version: N/A

On FreeBSD 12 (no DCO), it does not print anything, on FreeBSD 14
it prints

 DCO version: v0

(which will be addressed in a subsequent patch).

The code itself looks a bit overcomplicated, using a "struct buffer"
with all the macros, just to have something for fgets() to fill...
(it could use a on-stack char[] + capacity provided by the caller,
getting rid of the gc in the process...) but it has an ACK, it 
works, and I want the FreeBSD version patch done...


Your patch has been applied to the master and release/2.6 branch.

commit 3da238e677b7801607e6777d9d23eb61e38034c2 (master)
commit 9bd6fff74cf34892339fcab2fb3fc3cee54a2051 (release/2.6)
Author: Antonio Quartulli
Date:   Thu Mar 9 14:14:19 2023 +0100

     dco: print version to log if available

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20230309131419.29157-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26370.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


