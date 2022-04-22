Date: Fri, 22 Apr 2022 18:09:19 +0200 (CEST)
Message-Id: <202204221609.23MG9JLc093390@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220422134038.3801239-3-arne@...1227...>
References: <20220422134038.3801239-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove dead PID_TEST code
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

Trivial enough, and indeed, this sort of test code is better suited
in the cmocka unit tests nowadays than compiling a special openvpn
binary...  have not tested it, just verified that only stuff between
#ifdef PID_TEST ... #endif gets ripped out.

Your patch has been applied to the master branch.

commit e21425a7ae7728e16634fd0e8cfba90b48a5309e
Author: Arne Schwabe
Date:   Fri Apr 22 15:40:31 2022 +0200

     Remove dead PID_TEST code

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220422134038.3801239-3-arne@...1227...>
     URL: https://www.mail-archive.com/search?l=mid&q=20220422134038.3801239-3-arne@...1227...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


