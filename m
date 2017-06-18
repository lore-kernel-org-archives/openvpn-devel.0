Date: Sun, 18 Jun 2017 13:43:44 +0200
Message-Id: <201706181143.v5IBhil2004540@...1729...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170612134330.20971-9-logout@...260...>
References: <20170612134330.20971-9-logout@...260...>
Subject: [Openvpn-devel] [PATCH applied] Re: OpenSSL: force meth->name as
 non-const when we free() it
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
To: Emmanuel Deloget <logout@...260...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.4 branch.

I have changed the UTF8 characters in the quoted warning message to
standard ISO characters, though (copy-pasting the warning that clang
throws on FreeBSD).  And fixed the dangling comment close.

commit 3fd07c31fe8878dc75e760d151d291379c0f8743
commit 57eaf994379e054203ce42338b4495588ae28c44
Author: Emmanuel Deloget
Date:   Mon Jun 12 15:43:30 2017 +0200

     OpenSSL: force meth->name as non-const when we free() it

     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <20170612134330.20971-9-logout@...260...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14798.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


