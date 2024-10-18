Date: Fri, 18 Oct 2024 09:01:22 +0200 (CEST)
Message-Id: <202410180701.49I71MlH084067@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241018063717.14629-1-gert@...1296...>
References: <20241018063717.14629-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove a large number of unused
 structs and functions
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

Stared at the changes, scratched my head, checked individual "things"
with "git grep", and also had GH do a test build on platforms that
buildbot doesn't cover (BB is all green) - GH also all green.

Your patch has been applied to the master branch.

commit fcbb62375c3fe02549da57b05afb871bf44df338
Author: Arne Schwabe
Date:   Fri Oct 18 08:37:17 2024 +0200

     Remove a large number of unused structs and functions

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20241018063717.14629-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29594.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


