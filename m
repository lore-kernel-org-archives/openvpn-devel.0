Date: Sat, 26 Nov 2022 11:04:29 +0100 (CET)
Message-Id: <202211261004.2AQA4TXx015159@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221126090851.8656-1-kprovost@...2661...>
References: <20221126090851.8656-1-kprovost@...2661...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: pass control packets
 through the socket on FreeBSD
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
To: Kristof Provost <kp@...1376...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Straightforward enough :-) - we discussed this at the hackathon today,
and FreeBSD DCO does not "consume" the socket, it just hooks into it and
takes out "interesting" packet - so normal userland operation is still
possible.  Support for "floating client control message" is still missing,
but that's shared with Linux DCO (and we'll see an API show up soonish).

Tested (v1) on FreeBSD 14 "-CURRENT a few weeks old", and unsurprisingly,
everything still works fine.  v2 only differs in assert(false) vs. ASSERT(0),
so not tested again.

TODO on me: actually come up with an automated test case for float clients.

Your patch has been applied to the master branch.

commit 4cf58f4920b430481b772e5f9e9877f9686d3995
Author: Kristof Provost
Date:   Sat Nov 26 10:08:51 2022 +0100

     dco: pass control packets through the socket on FreeBSD

     Signed-off-by: Kristof Provost <kprovost@...2661...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221126090851.8656-1-kprovost@...2661...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25542.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


