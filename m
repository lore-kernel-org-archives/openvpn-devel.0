Date: Wed, 1 Apr 2020 12:44:06 +0200 (CEST)
Message-Id: <202004011044.031Ai67i086731@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200309131728.380-11-simon@...2293...>
References: <20200309131728.380-11-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnmsica: Merge
 FindTUNTAPAdapters into FindSystemInfo
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

Your patch has been applied to the master branch.

(I've read the discussion, and agree with Lev that a followup patch
might be a good thing - "either void or return value being not ignored")

Tested on a mingw compile.

commit c6f8d1a7a3dcb3c8608126ebb34b9087c6c9fb1e
Author: Simon Rozman
Date:   Mon Mar 9 14:17:27 2020 +0100

     openvpnmsica: Merge FindTUNTAPAdapters into FindSystemInfo

     Signed-off-by: Simon Rozman <simon@...2293...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20200309131728.380-11-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19531.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


