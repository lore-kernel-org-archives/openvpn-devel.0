Date: Mon, 12 Feb 2024 18:10:36 +0100 (CET)
Message-Id: <202402121710.41CHAaHr086518@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240212132522.125903-1-juliusz@...2525...>
References: <20240212132522.125903-1-juliusz@...2525...>
Subject: [Openvpn-devel] [PATCH applied] Re: Change include order for tests
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
To: Juliusz Sosinowicz <juliusz@...2525...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for this updated patch, which fixes the issue in a much nicer
way.  I'm not sure if you observe the problem in release/2.6 as well
- if yes, I need a release/2.6-specific patch for that (as half the
new test drivers are not in that branch).

Quick test with an in-tree build on FreeBSD and GHA builds passes fine.

Your patch has been applied to the master branch.

commit 54475711eb119f6fbb263880fca08d4b10df752a
Author: Juliusz Sosinowicz
Date:   Mon Feb 12 14:25:22 2024 +0100

     Change include order for tests

     Signed-off-by: Juliusz Sosinowicz <juliusz@...2525...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20240212132522.125903-1-juliusz@...2525...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28229.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


