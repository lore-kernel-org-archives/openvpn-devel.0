Date: Thu, 21 Apr 2022 09:30:45 +0200 (CEST)
Message-Id: <202204210730.23L7UjnG046348@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220420121322.42732-3-openvpn@...2080...>
References: <20220420121322.42732-3-openvpn@...2080...>
Subject: [Openvpn-devel] [PATCH applied] Re: dev-tools: Avoid uncrustify
 mangling MAC_FMT macro
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

Acked-by: Gert Doering <gert@...1296...>

As pointed out, I do not like this particular macro and the _STRINGIFY()
stuff, and it seems uncrustify agrees with me :-) - but until we can 
find a volunteer to make that code nicer on the eyes, this will at least
avoid uncrustify breaking it.

As this is just C level comments, nothing needed to be tested.

Your patch has been applied to the master branch.

commit 9febbcbbcf3b1a786a1e77145d30a43eb7996dc4
Author: David Sommerseth
Date:   Wed Apr 20 14:13:22 2022 +0200

     dev-tools: Avoid uncrustify mangling MAC_FMT macro

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220420121322.42732-3-openvpn@...2080...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24121.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


