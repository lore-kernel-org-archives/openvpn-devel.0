Date: Thu, 7 May 2020 15:21:31 +0200 (CEST)
Message-Id: <202005071321.047DLV8i023123@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200416113930.15192-1-arne@...1227...>
References: <20200416113930.15192-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use crypto library functions
 for const time memcmp when possible
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

I still feel it hurts my eyes, and is way overcomplicating things, but
if this is what mbedtls is using internally (why are they not exporting
it??!), it should be good enough for us.   Further, as it's not being
used for AEAD anyway, I withdraw my "performance" argument (Steffan 
could have just ACKed it... :-) ).

Stared at the code (awww!), test-built with openssl and mbedtls, passed
t_client tests.

We do not have a unit test for this, and crypto.c::test_crypto() actually
does the "compare bytes loop" manually (to be able to print differences).
Volunteers...?

Your patch has been applied to the master branch.

commit 4dddca52a8432095dd85ff652fae61a2aedb3785
Author: Arne Schwabe
Date:   Thu Apr 16 13:39:28 2020 +0200

     Use crypto library functions for const time memcmp when possible

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200416113930.15192-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19749.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


