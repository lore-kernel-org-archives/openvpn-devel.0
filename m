Date: Wed, 11 Oct 2017 19:02:54 +0200 (CEST)
Message-Id: <201710111702.v9BH2s8b010398@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20171010231130.6832-2-simon@...2293...>
References: <20171010231130.6832-2-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: Mixing wide and regular strings
 in concatenations is not allowed in MSVC.
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
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.4 branch.

commit d6e0917922793315b06aba395ed0666e17c5b44c (master)
commit 6e9da5a55673fe01ae7b780f0c438c81773109d5 (release/2.4)
Author: Simon Rozman
Date:   Wed Oct 11 01:11:19 2017 +0200

     Mixing wide and regular strings in concatenations is not allowed in MSVC.

     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20171010231130.6832-2-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15579.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


