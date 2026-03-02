Date: Mon, 2 Mar 2026 22:50:32 +0100 (CET)
Message-Id: <202603022150.622LoWGd023886@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260302142045.5954-1-gert@...1296...>
References: <20260302142045.5954-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Avoid unbounded allocations in
 pkcs11_mbedtls.c
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
To: Max Fillinger <maximilian.fillinger@...2918...>
Cc: openvpn-devel@lists.sourceforge.net

This is somewhat of a "minibug", but we decided that we want to have
a bit of a safeguard against a pkcs#11 provider that requests us to
allocate impossible amounts of memory.  Of course there are other ways
it could crash, but this one is a bit of "good housekeeping".

I have not tested it beyond "does it compile" - have no smartcard, and
especially not one that misbehaves (and do not feel like setting up
SoftHSM and stuff to test this for real).

Your patch has been applied to the master and release/2.7 branch (minibug).

commit 0a8e80aaf9c96718903251a828bc3e8055014160 (master)
commit bf7f8548c7bfd31f0e6fed880890d5106c2ab982 (release/2.7)
Author: Max Fillinger
Date:   Mon Mar 2 15:20:39 2026 +0100

     Avoid unbounded allocations in pkcs11_mbedtls.c

     Signed-off-by: Max Fillinger <maximilian.fillinger@...2918...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1549
     Message-Id: <20260302142045.5954-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35807.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


