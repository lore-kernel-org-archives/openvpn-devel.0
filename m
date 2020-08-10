Date: Mon, 10 Aug 2020 18:35:06 +0200 (CEST)
Message-Id: <202008101635.07AGZ6mQ023413@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200810143707.5834-7-arne@...1227...>
References: <20200810143707.5834-7-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove a number of
 check/do_work wrapper calls from coarse_timers
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

This is a less trivial change than the previous patches, but 
actually more important for future code maintenance in "master"
with patches backported to "release/2.5".  Whacked on the server
testbed, whacked on the client, AND stared-at-code... :-)

(Something related but smaller got already merged, this is the 
larger set of the remaining check...dowork() function pairs, 
plus cleaning up the different "my timer is more special than
your timer" invocations [status_trigger_tv() ewwww])

I've reworded the commit message a bit.

Your patch has been applied to the master branch.

commit e963904474ad97e0f8dfb0c9ccb57b1440cfb8f6
Author: Arne Schwabe
Date:   Mon Aug 10 16:36:56 2020 +0200

     Remove a number of check/do_work wrapper calls from coarse_timers

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200810143707.5834-7-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20668.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


