Date: Thu, 12 Jul 2018 22:52:48 +0200 (CEST)
Message-Id: <201807122052.w6CKqmEO021695@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20180704175404.22371-2-steffan@...1856...>
References: <20180704175404.22371-2-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move execve/run_script helper
 functions to run_command.c
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

(I've done my own review, but Antonio beat me with the ACK :-) - but I 
can confirm that this is "just moved code" plus script_security now
hidden behind getter/setter functions, and it passes my tests)

commit bf97c00f7dba441b504881f38e40afcbb610a39f
Author: Steffan Karger
Date:   Wed Jul 4 19:53:57 2018 +0200

     Move execve/run_script helper functions to run_command.c

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20180704175404.22371-2-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17212.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


