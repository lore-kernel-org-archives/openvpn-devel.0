Date: Tue, 12 May 2020 20:26:48 +0200 (CEST)
Message-Id: <202005121826.04CIQmDD062873@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200512124344.15929-1-arne@...1227...>
References: <20200512124344.15929-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix session id and initial
 timestamp not being preserved
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

Discussed with Arne, change makes sense, old code did not do what it
tried to.  Plus documentation enhancements, always welcome.

I haven't tested this in any "real" aspect (server-side), just basic
compile/client tests (which unsurprisingly didn't turn up anything).


Your patch has been applied to the master branch.

I have reworded / rewrapped the comments slightly, and also rewrapped
the patched if() statement onto 3 lines, to keep to the line length
limit.  No code space, just whitespace and comments.

commit 15d0331e5731c7559cfe95e6bb62dc3f3654b08e
Author: Arne Schwabe
Date:   Tue May 12 14:43:44 2020 +0200

     Fix session id and initial timestamp not begin preserved

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200512124344.15929-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19878.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


