Date: Thu, 15 Jan 2026 10:21:04 +0100 (CET)
Message-Id: <202601150921.60F9L4Vq051280@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260115082807.18596-1-gert@...1296...>
References: <20260115082807.18596-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Ensure that all unit tests use
 unbuffered stdout and stderr
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

This and the next patch are necessary backports to make unit tests
in 2.6 more useful again - "show us the actual error" and "compile with
-Werror and libcmocka 2.0".  So thanks :-)

As it's cherrypicks, the change is fairly straightforward.  The commit
message has both the old and the new mailing list reference.

Your patch has been applied to the release/2.6 branch.

commit be76565f44a85bf4f7804049209fe23b4d4ae10a
Author: Arne Schwabe
Date:   Thu Jan 15 09:28:01 2026 +0100

     Ensure that all unit tests use unbuffered stdout and stderr

     Acked-by: Frank Lichtenheld <frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28122.html
     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1461
     Message-Id: <20260115082807.18596-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35272.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


