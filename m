Date: Wed, 12 Nov 2025 14:02:43 +0100 (CET)
Message-Id: <202511121302.5ACD2hwt040453@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251112112133.1325-1-gert@...1296...>
References: <20251112112133.1325-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Do not underestimate number of
 encrypted/decrypted AEAD blocks
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

I agree with SR-Labs that this is a bug - thanks for fixing.

I also do agree with Arne that this is not CVE worthy, as this is a new
safety margin added to 2.7, which is only really relevant if you are
talking about "sustained utilization of >> 10 Gbit/s to the same peer,
exceeding sane AEAD block limits, and not going into tls-renegotiation due
to any other trigger (reneg-sec etc)" - so the chance to actually have
a setup that would hit this is very close to zero, and then you're no 
worse than with 2.6 - or any of the other TLS/AEAD implementations.

Stared at code ("make sense"), fed into the t_server testbed ("just to
be sure").  BB and GHA agree that it compiles and tests fine everywhere.

Your patch has been applied to the master branch.

commit 5e6d478fb6246465fb81060e60348bb0061a94fa
Author: Arne Schwabe
Date:   Wed Nov 12 12:21:27 2025 +0100

     Do not underestimate number of encrypted/decrypted AEAD blocks

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1358
     Message-Id: <20251112112133.1325-1-gert@...1296...>
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


