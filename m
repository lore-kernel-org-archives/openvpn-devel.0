Date: Tue, 27 Jun 2023 22:32:41 +0200 (CEST)
Message-Id: <202306272032.35RKWfAO003365@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230620135310.94455-5-frank@...2641...>
References: <20230620135310.94455-5-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: CMake: Add /Brepro to MSVC link
 options
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Whatever this does, it only affecst Windows builds, and both GHA and
Lev agree that it still works...

Your patch has been applied to the master branch.

commit 5e94e8de4bfaf6637124947a3489710b591e5e26
Author: Frank Lichtenheld
Date:   Tue Jun 20 15:53:09 2023 +0200

     CMake: Add /Brepro to MSVC link options

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20230620135310.94455-5-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26757.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


