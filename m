Date: Mon, 3 Nov 2025 16:10:38 +0100 (CET)
Message-Id: <202511031510.5A3FAccs005869@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251103115945.6615-1-gert@...1296...>
References: <20251103115945.6615-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: iservice: fix DNS address list
 generation
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks.  Patch looks good, trivial enough :-) - the discussion about
the issue and the patch was in the private repo we have for possibly
security related issues (which this isn't, it will just effectively
ignore the 3rd and 4th nameserver IP).

Your patch has been applied to the master branch.

The bug is not in release/2.6 as it came in with the "use registry 
and no longer netsh" windows DNS rewrite for 2.7

commit 235aa8858b9999c14603ff1d12c91c855d5dcf94
Author: Heiko Hund
Date:   Mon Nov 3 12:59:40 2025 +0100

     iservice: fix DNS address list generation

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1339
     Message-Id: <20251103115945.6615-1-gert@...1296...>
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


