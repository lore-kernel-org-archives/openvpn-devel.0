Date: Thu, 23 Jan 2025 18:19:41 +0100 (CET)
Message-Id: <202501231719.50NHJf8r084037@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250123155111.23371-1-gert@...1296...>
References: <20250123155111.23371-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: allow user to specify 'local'
 multiple times in config files
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

This is a patch that isn't actually *doing* anything so far, because
it's just bringing infrastructure.  So I stared quite hard at the code,
and subjected it to the usual client/server tests (to ensure it does
not accidentially break anything).  With this patch, doing multiple
'--local' will actually produce multiple bound sockets...

udp        0      0 0.0.0.0:21104           0.0.0.0:*                          
udp6       0      0 :::21106                :::*                               
udp6       0      0 :::31194                :::*                               

("local 0.0.0.0 21104" + "local :: 21106" + "local * 21106" on FreeBSD)

but it will not add all of these to the event handler, so it's not
working correctly - the first bound socket does work, the rest not
(just as a word of warning).

Testing for real begin with one of the next patches that actually
introduces "add all to the event loop".

Your patch has been applied to the master branch.

commit 8466c2ca3faf0dc143262ea2a76bfe3e2aff9f51
Author: Antonio Quartulli
Date:   Thu Jan 23 16:51:11 2025 +0100

     allow user to specify 'local' multiple times in config files

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250123155111.23371-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30544.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


