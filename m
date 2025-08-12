Date: Tue, 12 Aug 2025 11:49:15 +0200 (CEST)
Message-Id: <202508120949.57C9nFFi060795@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250811161323.1599-1-chipitsine@...277...>
References: <20250811161323.1599-1-chipitsine@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: GHA: limit 'Deploy Doxygen
 documentation' to main repo only
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
To: Ilia Shipitsin <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

For whatever reason, I never had problems with this (I think it was
explained to me how to disable this particular action) - but indeed, this
is a useful change, because it does not make sense outside the main
openvpn repo.

Your patch has been applied to the master branch.

commit c4f4f26d48babdf4f15a6cde837317c7216abbba
Author: Ilia Shipitsin
Date:   Mon Aug 11 18:13:23 2025 +0200

     GHA: limit 'Deploy Doxygen documentation' to main repo only

     Signed-off-by: Ilia Shipitsin <chipitsine@...277...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20250811161323.1599-1-chipitsine@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32598.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


