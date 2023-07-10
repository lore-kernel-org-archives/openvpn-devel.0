Date: Mon, 10 Jul 2023 19:13:28 +0200 (CEST)
Message-Id: <202307101713.36AHDSvp035491@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230522091231.2837468-1-arne@...1227...>
References: <20230522091231.2837468-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Print a more user-friendly
 error when tls-crypt-v2 client auth fails
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

I find this a useful addition - with all these crypto stuff it can be
quite hard to figure out what particular detail is not right.

The patch is trivial, just adding a msg(), so I did not really test
it beyond "compile?" and "does it have a space before or after the
wrap?" (it has).

Your patch has been applied to the master branch.

commit 7a477c16a7c2a7016c7b15ea98fe3c40e8ef675b (master)
commit 66f51e80b981f08ebc3c38f3fac7d0c88caeb85d (release/2.6)
Author: Arne Schwabe
Date:   Mon May 22 11:12:31 2023 +0200

     Print a more user-friendly error when tls-crypt-v2 client auth fails

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230522091231.2837468-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26718.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


