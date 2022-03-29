Date: Tue, 29 Mar 2022 15:42:46 +0200 (CEST)
Message-Id: <202203291342.22TDgkhR052694@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220323143452.1100446-1-heiko@...2662...>
References: <20220323143452.1100446-1-heiko@...2662...>
Subject: [Openvpn-devel] [PATCH applied] Re: add support for --dns option
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks for being patient with an old man and rewriting the &name_ok
thing :-) - I like the current code much better.

For the original patch, I am relying on the ACK from Frank.  I have
tested the setenv bit (which is new) by feeding openvpn a few --dns
options on the command line and then looking at the env passed to
--up - and things matched what the documentation says it should be.

To see "--dns server 5 address 1.2.3.4" show up as
"dns_server_2_address4=1.2.3.4" was a bit as a surprise first, but
it makes sense when re-reading the documentation - servers will
be sorted by preference, and then the output is just "1, 2, 3, ..." 
in contiguous numbering.  Also, things are nicely output in the
"print options" part of openvpn (show_dns_options()).


** NOTE: as discussed on IRC, uncrustify did have a few whitespace things 
** to complain about, so I fixed those on-the-fly.  No code change.

Your patch has been applied to the master branch.

commit b3e0d95dcfd0de2a5fe6545fed8f46e0dd35784d
Author: Heiko Hund
Date:   Wed Mar 23 15:34:52 2022 +0100

     add support for --dns option

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220323143452.1100446-1-heiko@...2662...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23997.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


