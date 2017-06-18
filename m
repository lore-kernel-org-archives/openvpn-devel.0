Date: Sun, 18 Jun 2017 13:55:22 +0200
Message-Id: <201706181155.v5IBtMbi004642@...1729...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170618105740.10090-1-steffan@...1856...>
References: <20170618105740.10090-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add a DSA test key/cert pair to
 sample-keys
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  No code changes to openvpn itself, and it's good to have all 
supported cert/key types around for testing.

Tested on FreeBSD, and it generates something that looks like DSA :-)

  Generating DSA parameters, 2048 bit long prime
  ...
  Generating a 2048 bit DSA private key
  writing new private key to 'sample-ca/server-dsa.key'
  ...
  Generating a 2048 bit DSA private key
  writing new private key to 'sample-ca/client-dsa.key'


Your patch has been applied to the master and release/2.4 branch.

commit 3d215d4c9d107fa153082e2bba8a3a9c8865be5d (master)
commit d937bb7eccc77ceb668cf64a8b2109329ed2aecd (release/2.4)
Author: Steffan Karger
Date:   Sun Jun 18 12:57:40 2017 +0200

     Add a DSA test key/cert pair to sample-keys

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20170618105740.10090-1-steffan@...1856...>
     URL: https://www.mail-archive.com/search?l=mid&q=20170618105740.10090-1-steffan@...1856...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


