Date: Mon, 1 Aug 2022 17:10:26 +0200 (CEST)
Message-Id: <202208011510.271FAQjZ051726@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220727221830.31861-1-selva.nair@...277...>
References: <20220727221830.31861-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: xkey_provider: fix building
 with --disable-management
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

Thanks for v2, and "too many #ifdef" indeed.  Uncrustify complained that
one of the #endif wants a comment, but with the new commit hooks this 
is easily fixed.  (Maybe we want to have a deep look into "do we really
want to keep ENABLE_MANAGEMENT?" one day... how much extra code size
does that bring to the binaries?  It's not *that* much code, is it?)

I have fed the code to buildbot, and it pacified all these modern
instances (fedora-36 etc.) ;-)

Your patch has been applied to the master branch.

commit fc75ab33401718fab3a79b19698eefb70a617a83
Author: Selva Nair
Date:   Wed Jul 27 18:18:30 2022 -0400

     xkey_provider: fix building with --disable-management

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20220727221830.31861-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24749.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


