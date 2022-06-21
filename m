Date: Tue, 21 Jun 2022 14:17:15 +0200 (CEST)
Message-Id: <202206211217.25LCHFrj076622@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220617041326.2744668-1-i.ponetaev@...2676...>
References: <20220617041326.2744668-1-i.ponetaev@...2676...>
Subject: [Openvpn-devel] [PATCH applied] Re: fix compilation issues with
 small and w/o debug
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
To: Ilya Ponetayev <i.ponetaev@...2676...>
Cc: openvpn-devel@lists.sourceforge.net

I discussed the use of "%zu" and Windows/MinGW builds with Selva, who
said this will work (it will create warnings, thus no -Werror builds,
but since release builds are MSVC, this should be acceptable).

Uncrustify said I have to add a newline before one of the #endif lines,
so I did.

Generally speaking: we're adding #ifdef again - maybe we should see how
much of a difference this creates if we *remove* "--disable-debug" and
all the ENABLE_DEBUG conditionals.  Resulting binary size, and runtime.

Your patch has been applied to the master branch.

commit 8c815699ba616151e6bc5074cd150f3ebf053d4a
Author: Ilya Ponetayev
Date:   Fri Jun 17 07:13:26 2022 +0300

     fix compilation issues with small and w/o debug

     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20220617041326.2744668-1-i.ponetaev@...2676...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24476.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


