Date: Fri, 14 May 2021 14:16:05 +0200 (CEST)
Message-Id: <202105141216.14ECG5kp092631@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210512131511.1309914-4-arne@...1227...>
References: <20210512131511.1309914-4-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Inline do_init_auth_token_key
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

It's really the same code moved "inline", with the "if()" condition
turned around (from early-return to if(condition) { ... }).

As discussed on IRC, I have massaged the commit message a bit :-)

Your patch has been applied to the master branch.

I've toyed with the idea of moving to 2.5 ("because it is so trivial,
and keeps the code similar") but it's neither a bugfix nor a compat
thing or a requirement, so our rules are fairly clear.  Maybe if a 
relevant bugfix hits close to this.

commit 6cf4fa5a4a686fa99ccdc8b1df48616853bc6be6
Author: Arne Schwabe
Date:   Wed May 12 15:15:05 2021 +0200

     Inline do_init_auth_token_key

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210512131511.1309914-4-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22341.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


