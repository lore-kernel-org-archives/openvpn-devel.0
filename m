Date: Sat, 18 Jul 2020 11:00:28 +0200 (CEST)
Message-Id: <202007180900.06I90Sbw040928@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200717171544.21632-1-davids@...515...>
References: <20200717171544.21632-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove --no-iv
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

I have taken this one out of sequence (it is intended to
go after the --no-replay patch), because *this* one is simple,
and the other one is quite a bit above my pay grade - plus
it modifies stuff that Arne is working on (the frame adjustment
stuff), so that needs much more careful scrutiny.

The patch itself is conflict-free, but the patch context in 
Changes.rst and doc/man-sections/server-options.rst is different.

Your patch has been applied to the master branch.

commit 4b4b34da9811da9e6912c89cd68be3cfe1684a97
Author: David Sommerseth
Date:   Fri Jul 17 19:15:44 2020 +0200

     Remove --no-iv

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200717171544.21632-1-davids@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20460.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


