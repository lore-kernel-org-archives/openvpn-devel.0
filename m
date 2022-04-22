Date: Fri, 22 Apr 2022 13:48:32 +0200 (CEST)
Message-Id: <202204221148.23MBmWDw089532@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220421131909.32053-1-a@...2181...>
References: <20220421131909.32053-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: auth-pam.c: add missing include
 limits.h
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Sounds reasonable, and <limits.h> is standard.  Test compiled on FreeBSD.

Your patch has been applied to the master and release/2.5 branch.

commit 0fed64a91d894b46105bf7e8b16edea4d90ab70c (master)
commit 70b6c69c8255ebd6e789e59b0fe8e106a35e9ad8 (release/2.5)
Author: Antonio Quartulli
Date:   Thu Apr 21 15:19:09 2022 +0200

     auth-pam.c: add missing include limits.h

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220421131909.32053-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24136.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


