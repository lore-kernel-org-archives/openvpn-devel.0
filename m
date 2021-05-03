Date: Mon, 3 May 2021 08:53:47 +0200 (CEST)
Message-Id: <202105030653.1436rlIh037626@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210422152939.2134046-3-arne@...1227...>
References: <20210422152939.2134046-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move direct.h header where it
 is used
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

I seemed to remember having used <direct.h> before on "something not
WIN32" - and yeah, this was part of the DOS compat layer on SCO Unix :-)
.. which we certainly do not use.  So, makes sense.

Your patch has been applied to the master branch.

commit 8c18d7c9323084d1b346ea303cf8cfd60d280e56
Author: Arne Schwabe
Date:   Thu Apr 22 17:29:36 2021 +0200

     Move direct.h header where it is used

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210422152939.2134046-3-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22202.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


