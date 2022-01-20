Date: Thu, 20 Jan 2022 17:33:43 +0100 (CET)
Message-Id: <202201201633.20KGXhrM004561@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211214165928.30676-13-selva.nair@...277...>
References: <20211214165928.30676-13-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Increase ERR_BUF_SIZE when
 management interface support is enabled
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

I seem to have seen a similar patch in Arne's series, and we didn't
like it there much either :-) - so yeah, smarter fix, eventually.

That said, this is "only" wasting another 2048 byte as the buffer is
already at 8k if PKCS11 is enabled, and it's not static but gc_malloc().

Pretty weird to use *ERR*_BUF_SIZE in manage.c and plugin.c, though :-)
(and maybe the plugin_vlog() code could be changed to be smarter about
the way it builds the msg_fmt string based on plugin name + format string)

Anyway, client tested with 1.1.1, just for good measure.

Your patch has been applied to the master branch.

commit eeb019acee57ef5b9485569ec4d3279a822c4eb0
Author: Selva Nair
Date:   Tue Dec 14 11:59:22 2021 -0500

     Increase ERR_BUF_SIZE when management interface support is enabled

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20211214165928.30676-13-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23440.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


