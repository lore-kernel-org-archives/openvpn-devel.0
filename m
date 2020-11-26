Date: Thu, 26 Nov 2020 12:49:43 +0100 (CET)
Message-Id: <202011261149.0AQBnhXs072955@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201023120259.29783-4-arne@...1227...>
References: <20201023120259.29783-4-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Clean up
 tls_authentication_status and document it
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

This is not for the faint of heard... so I've excercised this
on the server side test framework (which has various "fail auth"
tests).

The changes in push.c and ssl.c are self-explanatory, though I
wonder why you didn't go for an "early exit if (!multi)" in
tls_authentication_status() to avoid the extra condition.

The change to ssl_verify.c is somewhat harder to grok - but after
staring at the table for a while, the combinations and priority
of evaluation becomes clear ("if either is ACF_FAILED, the result
is ACF_FAILED.  Then, if either is UNDEFINED, ...") - and the new
code reflects that, with WAY less magic, and more comments.  Yay.

Your patch has been applied to the master branch.

commit f9d3fbf9bc87ae6c05fc592712f610491a77d78b
Author: Arne Schwabe
Date:   Fri Oct 23 14:02:56 2020 +0200

     Clean up tls_authentication_status and document it

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20201023120259.29783-4-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21224.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


