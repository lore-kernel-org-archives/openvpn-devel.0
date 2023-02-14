Date: Tue, 14 Feb 2023 15:00:33 +0100 (CET)
Message-Id: <202302141400.31EE0XkI023101@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230128223421.2207802-3-selva.nair@...277...>
References: <20230128223421.2207802-3-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: cyryptapi.c: log the selected
 certificate's name
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

Acked-by: Gert Doering <gert@...1296...>

I think this is a useful addition.  Code looks good according to the
documentation for CertGetNameStringW() and WideCharToMultiByte().

Tested on a MinGW compile (yes, compiles :-) ).  Not actually tested on
a life windows system, as my "have p12 certs imported, reference them
from .ovpn" project is still pending.

The 3 new gc_free() are a bit ugly, but unavoidable without either 
having "gc_free() in the middle of the function" (which we don't do) or
restructure more & add "ret = 1 ; goto end" code...  so it is what it is.

Your patch has been applied to the master and release/2.6 branch.

commit ddffcea2922905ec13e0e39239d106e0edbea5de (master)
commit 0ccfce24b470d924d4184c8a3de08a50154c5e4c (release/2.6)
Author: Selva Nair
Date:   Sat Jan 28 17:34:19 2023 -0500

     cyryptapi.c: log the selected certificate's name

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230128223421.2207802-3-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26093.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


