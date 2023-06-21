Date: Wed, 21 Jun 2023 13:43:42 +0200 (CEST)
Message-Id: <202306211143.35LBhg9C059985@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230619132934.76085-2-frank@...2641...>
References: <20230619132934.76085-2-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: dist: add more missing files
 only used in the MSVC build
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

There is not much meat to the patch, except "bundle a few extra files",
so this is what I tested.  Diffing "make dist" created tarballs
with and without this patch confirms "it adds vcpkg.json + git-version.py".

Your patch has been applied to the master and release/2.6 branch.

commit 6801260dba38ae99f8726c2840ddf6bed57ee1d0 (master)
commit af60fdc7d57462ed2509cb5247dc6e394451fa8d (release/2.6)
Author: Frank Lichtenheld
Date:   Mon Jun 19 15:29:31 2023 +0200

     dist: add more missing files only used in the MSVC build

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230619132934.76085-2-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26748.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


