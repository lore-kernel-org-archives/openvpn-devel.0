Date: Wed, 11 Sep 2024 14:25:42 +0200 (CEST)
Message-Id: <202409111225.48BCPgIW067972@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240911104941.19429-1-gert@...1296...>
References: <20240911104941.19429-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Do not stop reading from
 file/uri when OPENSSL_STORE_load() returns error
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for fixing this so quickly.  Now this seems to be an... interesting 
API to work with... :-)

I do not have something really interesting set up in terms of cert files
and storage, so I just did basic client side testing with OSSL 3.x (works).

Your patch has been applied to the master branch
(bugfix, but offending code not in 2.6).

commit e9ad1b31a04799de98f15220eb39225c3d9eaa64
Author: Selva Nair
Date:   Wed Sep 11 12:49:41 2024 +0200

     Do not stop reading from file/uri when OPENSSL_STORE_load() returns error

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20240911104941.19429-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29187.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


