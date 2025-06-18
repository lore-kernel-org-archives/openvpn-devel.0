Date: Wed, 18 Jun 2025 16:08:16 +0200 (CEST)
Message-Id: <202506181408.55IE8GLJ099682@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250618140016.2766-1-gert@...1296...>
References: <20250618140016.2766-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Multi-socket: local_list
 clean-up
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
To: Gianmarco De Gregori <gianmarco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Stared-at-code, looks good.  Tested on the server instance with lots of
--local lines (+ some msg() calls to see l->len and l_capacity), and it
does what it promises.  Thanks :-)

Your patch has been applied to the master branch.

commit 9bb02bc34f5ecc85364fa7ab64e52b6c5c918055
Author: Gianmarco De Gregori
Date:   Wed Jun 18 16:00:09 2025 +0200

     Multi-socket: local_list clean-up

     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250618140016.2766-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31927.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


