Date: Tue, 1 Oct 2019 12:34:37 +0200 (CEST)
Message-Id: <201910011034.x91AYbLk062437@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190917121004.13685-1-arne@...1227...>
References: <20190917121004.13685-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Rewrite auth-token-gen to be
 based on HMAC based tokens
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

Your patch has been applied to the master branch.

I have lightly tested client-side builds and t_client runs (and I'm aware
that half our buildbot cloud is down, but I do not expect any system-
dependent breakages - compiler flags, possibly, but nothing like "on
OpenBSD, <x> will not work").

There's a few typos in the comments, so a native english speaker might
want to have a look (and I'd welcome a followup patch) - I've decided 
to merge it "as it is" for now, though.  Get this series done.

commit 1b9a88a2c38a6a29f8ccbec4fd529d7b363bfc06
Author: Arne Schwabe
Date:   Tue Sep 17 14:10:04 2019 +0200

     Rewrite auth-token-gen to be based on HMAC based tokens

     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20190917121004.13685-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18818.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


