Date: Sun, 18 Apr 2021 16:19:19 +0200 (CEST)
Message-Id: <202104181419.13IEJJET072842@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210416120708.1532-1-themiron@...2010...>
References: <20210416120708.1532-1-themiron@...2010...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix IPv4 default gateway with
 multiple route tables
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
To: Vladislav Grishenko <themiron@...2010...>
Cc: openvpn-devel@lists.sourceforge.net

Code looks reasonable (though I won't claim to understand the nuances
of Netlink :-) ) - took me a bit to remember what is done here with
the callback function for matching, but yeah, seems to do what it says
on the lid.  Did some very basic testing on a system with just a single
route table and nothing breaks :-)

Your patch has been applied to the master and release/2.5 branch (bugfix).

commit c7f95891a4a0aabb64e7d4f3200525c1a2fcf433 (master)
commit 48ba0b059138dec7a94d2368375344d39c4e05e9 (release/2.5)
Author: Vladislav Grishenko
Date:   Fri Apr 16 17:07:07 2021 +0500

     Fix IPv4 default gateway with multiple route tables

     Signed-off-by: Vladislav Grishenko <themiron@...2010...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210416120708.1532-1-themiron@...2010...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22130.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


