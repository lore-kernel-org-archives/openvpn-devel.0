Date: Mon, 22 Mar 2021 11:51:11 +0100 (CET)
Message-Id: <202103221051.12MApB50017438@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210322102119.14322-1-arne@...1227...>
References: <20210322102119.14322-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove empty dummy functions
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

"I have always wondered why we need these..." - and if Windows isn't
it (anymore), out that stuff goes.  It might break old Solaris compilers,
but gcc exists... and I tested on our OpenIndiana buildslave, and that one
is happy with the change.

Your patch has been applied to the master branch.

commit 1b71f8597f9de843b14c500d03bb7c9f99859667
Author: Arne Schwabe
Date:   Mon Mar 22 11:21:19 2021 +0100

     Remove empty dummy functions

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210322102119.14322-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21787.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


