Date: Wed, 4 Mar 2026 15:24:10 +0100 (CET)
Message-Id: <202603041424.624EOApP061043@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260304110455.15859-1-gert@...1296...>
References: <20260304110455.15859-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: buffer: Add checked_snprintf
 function and use it in the code
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for this undertaking :-) - I admit that I was not too happy to
have "the snprintf() wrapper come back", but on really looking into the
patch, I like it a lot.  All the redundant code in the snprintf() calls
where we actually check the result gets much simpler this way - and
also integer-correct without casts all over the place.

Given that this changes lots of places (= future conflicts), brings no 
actual functional difference, *and* makes the code easier to read and
understand I took the liberty to apply it to 2.7 as well.  Both branches
have seen a full t_client/t_server test run "just to be sure".

Your patch has been applied to the master and release/2.7 branch.

commit 1ec71fe0c0cd3f593036197abdc9486ce3665c38 (master)
commit c0e792112a7dfeff26039a03c0799b89cb86e071 (release/2.7)
Author: Frank Lichtenheld
Date:   Wed Mar 4 12:04:49 2026 +0100

     buffer: Add checked_snprintf function and use it in the code

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1489
     Message-Id: <20260304110455.15859-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35872.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


