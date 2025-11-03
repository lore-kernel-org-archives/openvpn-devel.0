Date: Mon, 3 Nov 2025 16:21:31 +0100 (CET)
Message-Id: <202511031521.5A3FLVlW006358@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251103150002.23187-1-gert@...1296...>
References: <20251103150002.23187-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: Disallow stdin as
 config unless user is authorized
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks.  I have not tested this beyond "stare at code", but this is
easy enough (and I have verified the counterpart in openvpn/options.c,
which does a streq() with "stdin", so it needs to be an exact match,
not a substring or anything else).

Your patch has been applied to the master and release/2.6 branch (bugfix).

commit a3d8c40260930ab82ca5d9d71796a7763e74a03d (master)
commit a7f5f570bfe30b86b5c7088450f96b77c86dca18 (release/2.6)
Author: Selva Nair
Date:   Mon Nov 3 15:59:56 2025 +0100

     openvpnserv: Disallow stdin as config unless user is authorized

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1343
     Message-Id: <20251103150002.23187-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34156.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


