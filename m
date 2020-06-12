Date: Fri, 12 Jun 2020 08:53:09 +0200 (CEST)
Message-Id: <202006120653.05C6r9JC075230@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200519220004.25136-4-arne@...1227...>
References: <20200519220004.25136-4-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement sending response to
 challenge via CR_RESPONSE
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

Your patch has been applied to the master branch.

doc/management-notes.txt has been re-quoted as requested.

(I have only done basic compile / t_client tests on this series, which
will not really excercise any of the new code bits - but at least makes
sure that nothing breaks there.  We need something in the test framework
that actually uses the management interface on both ends to test this...)

commit adb9bb918de6ceda1ab027aa02942e8c4efc3183
Author: Arne Schwabe
Date:   Wed May 20 00:00:02 2020 +0200

     Implement sending response to challenge via CR_RESPONSE

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20200519220004.25136-4-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19907.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


