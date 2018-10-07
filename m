Date: Sun, 7 Oct 2018 22:19:49 +0200 (CEST)
Message-Id: <201810072019.w97KJn4R092615@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181007175215.25009-1-steffan@...1856...>
References: <20181007175215.25009-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Don't print OCC warnings about
 'key-method', 'keydir' and 'tls-auth'
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

I have not actually bothered to find a constellation that *would* trigger
an OCC warning (how?) but it compiles and passes tests, and the code looks
reasonable.  With added msg() calls I verified that it actually ignores 
the options this time.

I have taken the liberty to remove the space after "tun-ipv6" to make it 
actually match (no arguments, so no space) and learned something new about 
the treasures in our sources (strprefix())... :-) 

Your patch has been applied to the master and release/2.4 branch
(long-term compatibility and not very intrusive).

commit 3baae9ba52187166b7d0b05901732666477a2acb (master)
commit 266178b7b6280d5f32403ba8780ddbb517e3ac6a (release/2.4)
Author: Steffan Karger
Date:   Sun Oct 7 19:52:15 2018 +0200

     Don't print OCC warnings about 'key-method', 'keydir' and 'tls-auth'

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20181007175215.25009-1-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17618.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


