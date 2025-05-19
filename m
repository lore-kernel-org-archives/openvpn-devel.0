Date: Mon, 19 May 2025 11:52:02 +0200 (CEST)
Message-Id: <202505190952.54J9q2Sh078115@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250518220245.24489-1-gert@...1296...>
References: <20250518220245.24489-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Make --dh none behaviour
 default if not specified
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

This patch doesn't actually change very much, except no longer requiring
an explicit "--dh none" for deployments that do not need DH params
(like, everything recent).  So this is mostly documentation and a very
small code change ("none" maps to "dh_file = NULL", and not setting
anything defaults to "dh_file = NULL", just the check "something MUST
be set!!!" is removed).

Your patch has been applied to the master branch.

commit 57bdefbabd8d48fa93216c2049663fa3cacc50d3
Author: Arne Schwabe
Date:   Mon May 19 00:02:39 2025 +0200

     Make --dh none behaviour default if not specified

     Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250518220245.24489-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31695.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


