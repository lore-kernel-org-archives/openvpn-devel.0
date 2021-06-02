From: selva.nair@...277...
Date: Tue,  1 Jun 2021 23:42:51 -0400
Message-Id: <20210602034253.19984-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/2] AUTH_PENDING docs and related
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
To: openvpn-devel@lists.sourceforge.net

From: Selva Nair <selva.nair@...277...>

I couldn't figure out the details of how to use CR_TEXT or OPEN_URL
from the docs. This is an attempt to improve the documentation based
on my reading of the sources and some guess-work.

I might have edited somethings wrongly. If so, please correct.

Also found a minor parsing bug that will trigger only if the
client announces more than two keywords in IV_SSO.

Question: is the IV_SSO the keyword for PROXY_URL named proxy_url
or proxyurl or url_proxy? I would ahve guessed "proxyurl" based on
crtext and openurl but have settled for proxy_url. If there is
no established convention as yet, I suggest proxyurl without
the _.
 
Selva Nair (2):
  Improve documentation of AUTH_PENDING related directives
  Fix parsing of IV_SSO string

 doc/man-sections/server-options.rst |   4 ++
 doc/management-notes.txt            | 101 +++++++++++++++++-----------
 src/openvpn/ssl_verify.c            |   2 +-
 3 files changed, 68 insertions(+), 39 deletions(-)

-- 
2.20.1


