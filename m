Date: Tue, 6 Dec 2022 16:54:38 +0100 (CET)
Message-Id: <202212061554.2B6Fscpj021683@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221206133647.954724-1-arne@...1227...>
References: <20221206133647.954724-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix connection cookie not
 including address and fix endianness in test
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

Stared-at-code, ran unit tests beforehand on FreeBSD/amd64 and
AIX/PowerPC, verified that it *failed* on PowerPC.  Ran unit tests
again with the patch, and both FreeBSD/amd64 and AIX/PowerPC succeeded
now, so endianness is taken into account now.

I have not server-tested this, as it "should not" make a difference,
and Arne did test this on s390.  The full server tests will run
tonight, though.

As agreed on IRC, I've removed the comment from test_pkt.c that
says "we do not use htons..." because now we do :-)

Your patch has been applied to the master and release/2.6 branch.

commit 67bef0357280040b83f2185c91c4f830ba542d6b (master)
commit 3e63dc9b184b17674dfea3cea7eb55ce15779fb2 (release/2.6)
Author: Arne Schwabe
Date:   Tue Dec 6 14:36:47 2022 +0100

     Fix connection cookie not including address and fix endianness in test

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221206133647.954724-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25619.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


