Date: Tue, 2 Aug 2022 14:02:39 +0200 (CEST)
Message-Id: <202208021202.272C2dmm071125@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220728034508.15180-2-selva.nair@...277...>
References: <20220728034508.15180-2-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Allow a few levels of recursion
 in virtual_output_callback()
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

I cannot test this (beyond "compile", but that is trivial) but the
description in 

 https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24738.html

makes sense, so allowing "a limited amount" of recursion plus actually
logging when this is hit should make management more robust against 
overlapping timing issues aka "race conditions".

Your patch has been applied to the master branch.

commit 4dfd592ff1ee18aa4859264c8a341dfa1a291988
Author: Selva Nair
Date:   Wed Jul 27 23:45:08 2022 -0400

     Allow a few levels of recursion in virtual_output_callback()

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220728034508.15180-2-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24751.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


