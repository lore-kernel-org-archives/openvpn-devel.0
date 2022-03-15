Date: Tue, 15 Mar 2022 18:12:28 +0100 (CET)
Message-Id: <202203151712.22FHCSk5012475@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220313193154.9350-3-openvpn@...2080...>
References: <20220313193154.9350-3-openvpn@...2080...>
Subject: [Openvpn-devel] [PATCH applied] Re: plug-ins: Disallow multiple
 deferred authentication plug-ins
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

This is the same patch that Antonio tested when it was still only
discussed on the security@ list (except for the "two spaces" comment 
fix).  Also, fixed a "do" -> "does" in plugin-options.rst.

As discussed before, I still think that "aborting the server process"
is excessive and we should just return OPENVPN_PLUGIN_FUNC_ERROR in
this case (with a proper log message), but we'll have to agree to
disagree on this one.  I have a patch to bring proper functionality
instead... :-)

I have not tested this particular scenario (Antonio has), just made
sure nothing else got broken.

I have not updated Changes.rst in the context of this patch - will
do that when preparing 2.5.6 release.

Your patch has been applied to the master and release/2.5 branch.

commit 282ddbac54f8d4923844f69983b38dd2b813a00a (master)
commit af3e382649d96ae77cc5e42be8270f355e5cfec5 (release/2.5)
Author: David Sommerseth
Date:   Sun Mar 13 20:31:53 2022 +0100

     plug-ins: Disallow multiple deferred authentication plug-ins

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20220313193154.9350-3-openvpn@...2080...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23931.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


