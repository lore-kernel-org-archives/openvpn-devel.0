Date: Thu, 5 May 2022 16:09:46 +0200 (CEST)
Message-Id: <202205051409.245E9kaU040678@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220504111802.1050648-1-arne@...1227...>
References: <20220504111802.1050648-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove workaround for Android
 4.4
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

I have not actually investigated this in more detail - but this is 
something the Android GUI controls, so if you say "it will never send
this message anymore" we can remove the code from openvpn core.

I did wonder (on IRC) if we can get rid of ANDROID_OPEN_BEFORE_CLOSE at
the same time - but looking more close, I see that we still have two
variants, ANDROID_KEEP_OLD_TUN and ANDROID_OPEN_BEFORE_CLOSE.  So, yes, 
as long as the GUI can send both, we need both in the core...

Your patch has been applied to the master branch.

commit 44517fd7694012502318975173b1d0c05045d388
Author: Arne Schwabe
Date:   Wed May 4 13:18:02 2022 +0200

     Remove workaround for Android 4.4

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220504111802.1050648-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24276.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


