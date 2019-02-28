Date: Thu, 28 Feb 2019 17:00:04 +0100 (CET)
Message-Id: <201902281600.x1SG04Hb041873@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190220131906.22970-1-davids@...515...>
References: <20190220131906.22970-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: cleanup: Remove RPM
 openvpn.spec build approach
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

.. for the reasons given (as this is mostly removing non-code files, 
easy to review).  Thanks for the documentation pointers.

I have tested with "make distcheck" that autoconf still agrees with
you on "which files should be there for packaging" (it does).

Your patch has been applied to the master branch - I have no objections
against inclusion in 2.4, but it wouldn't trivially apply and I was a bit
too lazy to go fight the conflicts.  So if you think it should be in 2.4,
feel free to take my ACK and apply it yourself :-)

commit 57ec6cec85b92e6af35a7871d105d84a753d6549
Author: David Sommerseth
Date:   Wed Feb 20 14:19:06 2019 +0100

     cleanup: Remove RPM openvpn.spec build approach

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20190220131906.22970-1-davids@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18222.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


