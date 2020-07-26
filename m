Date: Sun, 26 Jul 2020 15:40:18 +0200 (CEST)
Message-Id: <202007261340.06QDeI0c097796@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200725235023.22441-1-arne@...1227...>
References: <20200725235023.22441-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Include utun device number in
 utun error messages
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

Acked-by: Gert Doering <gert@...1296...>

I've left out the stray uncrustify fixes - not that I disagree with
them, but they should go to their own patch.  Sorry for not cleaning
that up while merging the corresponding patch.

Code change looks good.  Not tested anything (only test compiled on MacOS).

I wonder if we could just skip print the error message for this
particular call (connect()) if the return is EBUSY?  Or maybe
"skip if utunnumber < 10 && EBUSY"?

Your patch has been applied to the master branch.

commit 1d86fae8740a6d025d550fdcb4aa13c755fc2e48
Author: Arne Schwabe
Date:   Sun Jul 26 01:50:23 2020 +0200

     Include utun device number in utun error messages

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200725235023.22441-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20590.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


