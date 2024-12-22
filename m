Date: Sun, 22 Dec 2024 11:23:05 +0100 (CET)
Message-Id: <202412221023.4BMAN5k3081993@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241221222404.10266-1-gert@...1296...>
References: <20241221222404.10266-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement HKDF expand function
 based on RFC 8446
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

There is not much for me to test here - this is new code which is not
yet used anywhere.  But it does not break anything :-) - and the crypto
part has a +2 by MaxF in gerrit, which is most important.  Plus, it
brings a unit tests (using OpenSSL 3.0 to verify identical behaviour).

Since this introduces two new files, doing GHA builds with cmake and
autoconf also confirms that both build systems have been correctly
adjusted (and inclusion in openvpn_SOURCES will take care of "make dist").

Your patch has been applied to the master branch.

commit 5d3d2e42c332443e57eeff7d81c89ae8916815d9
Author: Arne Schwabe
Date:   Sat Dec 21 23:24:04 2024 +0100

     Implement HKDF expand function based on RFC 8446

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: MaxF <max@...2606...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20241221222404.10266-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30149.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


