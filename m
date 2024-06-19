Date: Wed, 19 Jun 2024 15:37:24 +0200 (CEST)
Message-Id: <202406191337.45JDbOKi074113@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240619103004.56460-1-gert@...1296...>
References: <20240619103004.56460-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Properly handle null bytes and
 invalid characters in control messages
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

I have tested this with lots of well-behaved peers - namely, client against
2.3/2.4/2.5 servers, and (master) server against 2.2-master clients.  All
works :-) (I did not test with a malicious endpoint).

Also, it has unit tests ;-)

Your patch has been applied to the master, release/2.6 and release/2.5 branch.

The 2.6 pullup pulls in "other unit tests" that have been master-only 
so far.  Which is a bit of an annoyance, but having the UTs is good,
they *pass* on 2.6, and it's easier on me than trying to only bring in
this new test.

On the 2.5 pullup I have left out the unit tests, and had to amend the
code lightly to remove the EXIT and AUTH_PENDING message handling.

release/2.4 is considered end of maintenance.

commit 414f428fa29694090ec4c46b10a8aba419c85659 (master)
commit 90e7a858e5594d9a019ad2b4ac6154124986291a (release/2.6)
commit d4921ba22f5ae4537d808986743a228617c86328 (release/2.5)
Author: Arne Schwabe
Date:   Mon May 27 15:02:41 2024 +0200

     Properly handle null bytes and invalid characters in control messages

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20240619103004.56460-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28791.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


