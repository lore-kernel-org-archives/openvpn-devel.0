Date: Wed, 29 Sep 2021 13:21:39 +0200 (CEST)
Message-Id: <202109291121.18TBLdrH038680@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210903161113.30498-1-a@...2181...>
References: <20210903161113.30498-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: networking: add and implement
 net_addr_ll_set() API
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

This basically does not give me much to test, as it just adds functions 
that are not called yet.  Those look reasonable, and the result passes
compilation on Linux and FreeBSD.

I do not like the "MAC_FMT" bit very much - it looks like "yeah, I saw
this in another project, and it looks cool", but it introduces an extra
"what is it doing here?" for the two cases where it is used (and the
extra _STRINGIFY() does not help make it easier to follow).  But we
discussed this on IRC, and seems we need to disagree here...

NOTE: I accidentially pushed out v1 of the patch, with the "wrong"
brackets.  We'll sort this out.

NOTE2: this is a bugfix (omission), so it is intended to go to 
release/2.5 as well - but with the wrong patch merged to master, I
think I'll just get them all in, and then squash together the 3
patches into a single one for 2.5.

Your patch has been applied to the master branch.

commit 98f524cbd58d24d09dee26160d7386d710c3564f
Author: Antonio Quartulli
Date:   Fri Sep 3 18:11:12 2021 +0200

     networking: add and implement net_addr_ll_set() API

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210903161113.30498-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22792.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


