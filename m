Date: Wed, 4 Mar 2026 14:10:56 +0100 (CET)
Message-Id: <202603041310.624DAurf059764@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260304105944.15386-1-gert@...1296...>
References: <20260304105944.15386-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: buffer: Add BLENZ macro that
 returns size_t and use it where required
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

While numerous, most of the changes are very straightforward and
improve code readability while at it :-) - the one write() call confused
me, but I was reminded that "windows wants an 'unsiged int' there, not
a 'size_t'".  *sigh*.

The hunk in socket.c:2263 collided with the steam_buf patch merged
this morning (struct buffer frag = ...) - but that was only "diff context"
so easily fixed.

Subjected to a full t_client/t_server test run, just for good measure.

Your patch has been applied to the master branch.

commit 28941473f32153a762db25a0ebe54aae321a8155
Author: Frank Lichtenheld
Date:   Wed Mar 4 11:59:38 2026 +0100

     buffer: Add BLENZ macro that returns size_t and use it where required

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1132
     Message-Id: <20260304105944.15386-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35870.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


