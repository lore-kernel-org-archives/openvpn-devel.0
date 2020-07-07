Date: Tue, 7 Jul 2020 14:05:44 +0200 (CEST)
Message-Id: <202007071205.067C5ie9064884@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200706163516.11390-2-arne@...1227...>
References: <20200706163516.11390-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: merge key_state->authenticated
 and key_state->auth_deferred
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

I merged this somewhat by accident, so apologies for the confusion - I am
*not* ignoring Antonio's and Steffan's comments for improvement of this 
patch, but I had my trees mixed up from testing, and it got pushed out
with the "writepid" patch of today by accident.

So:

Acked-by: Gert Doering <gert@...1296...>

Stared-at-code (looks very reasonable), ran through the t_server test suite
which does "normal" and "async auth" (15s delay in plugin-auth-pam) and
it passes all tests.

Your patch has been applied to the master branch.

commit a5e6f2d217309969a835f21b73b4dc0fbc70c4aa
Author: Arne Schwabe
Date:   Mon Jul 6 18:35:16 2020 +0200

     merge key_state->authenticated and key_state->auth_deferred

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200706163516.11390-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20216.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


