Date: Mon, 2 Oct 2017 20:21:44 +0200 (CEST)
Message-Id: <201710021821.v92ILi7X023945@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20171002161812.9376-1-davids@...515...>
References: <20171002161812.9376-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: lz4: Fix confused version check
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

ACK.  Makes sense, got tested on our problem child (Debian 8) already,
and I added more tests of my own (Ubuntu 14.04 with "too old lz4 library",
FreeBSD with 1.8.0, Gentoo with "no lz4 library") and everything worked
nicely.  thanks.

Your patch has been applied to the master and release/2.4 branch.

commit f91e4863bc138213a07a2cf53ad71d8a4532abef (master)
commit c8a7cc646571165101a43b02a3f0676661d4d011 (release/2.4)
Author: David Sommerseth
Date:   Mon Oct 2 18:18:12 2017 +0200

     lz4: Fix confused version check

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20171002161812.9376-1-davids@...515...>
     URL: https://www.mail-archive.com/search?l=mid&q=20171002161812.9376-1-davids@...515...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


