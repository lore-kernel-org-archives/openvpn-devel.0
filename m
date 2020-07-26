Date: Sun, 26 Jul 2020 18:56:35 +0200 (CEST)
Message-Id: <202007261656.06QGuZIl012935@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200725234803.22058-2-arne@...1227...>
References: <20200725234803.22058-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Avoid sending push request
 after receving push reply
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

This is magic :-) - it's just a one liner (plus lots of documentation)
but the description makes sense, staring at the code for a while also
makes sense.  Plus, it works :-)

I have not tested the server side, as (to my understanding) this is 
basically "client side only" code.  I *have* tested p2p with --tls-client
(now! part of my t_client rig :-) ) and that still works - relevant, as
the code flows along the "established?  send pull?" path here.

The new code also works correctly with pre-fast-pull servers (the
"reference server" is - because I'm lazy - still running an older 
version).

I have merged the typo fixes from Richard as well (note: ommitted has
only one m!  I asked google!), and done a bit more bragging in the
Changes.rst wording ("significantly! improves connection time!").

Your patch has been applied to the master branch.

commit a3b21a76b87fedf045c409481f55c34486d8cd27
Author: Arne Schwabe
Date:   Sun Jul 26 01:48:03 2020 +0200

     Avoid sending push request after receving push reply

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200725234803.22058-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20589.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


