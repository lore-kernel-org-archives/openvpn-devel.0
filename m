Date: Sun, 14 Feb 2021 17:31:35 +0100 (CET)
Message-Id: <202102141631.11EGVZmm027271@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210125125628.30364-7-arne@...1227...>
References: <20210125125628.30364-7-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add S_EXITCODE flag for
 openvpn_run_script to report exit code
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

Your patch has been applied to the master branch.

Again, out of sequence, as this does not depend on 03/11 or 05/11.

Lightly tested and stared at the code a bit.  Added a line break before
a "{"...

commit 04876274b5059f4c27b1f481fd92ff5e8ab15f1c
Author: Arne Schwabe
Date:   Mon Jan 25 13:56:23 2021 +0100

     Add S_EXITCODE flag for openvpn_run_script to report exit code

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20210125125628.30364-7-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21487.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


