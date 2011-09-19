Date: Mon, 19 Sep 2011 11:32:06 +0200
From: Davide Brini <dave_br@...1278...>
Message-ID: <20110919113206.2fe282f8@...1506...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Incorrect instructions in tester documentation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On the "TesterDocumentation" page, the instructions say

When testing this version of OpenVPN, we would appreciate if all deprecated
features would be disabled by default. We want to know how OpenVPN behaves
for you without these features. When doing the compile-time configuration
of OpenVPN, please make sure the following arguments are included:

    --disable-depr-random-resolv


However there doesn't appear to be such an option recognized by the
configure script:

$ ./configure --disable-depr-random-resolv 
configure: WARNING: unrecognized options: --disable-depr-random-resolv
...

Not sure whether I'm doing something wrong or the docs need to be updated.
Thanks!

-- 
D.

