Date: Mon, 20 Jul 2020 09:08:49 +0200 (CEST)
Message-Id: <202007200708.06K78nqr090189@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200719173436.16431-3-arne@...1227...>
References: <20200719173436.16431-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: client-connect: Use inotify for
 the deferred client-connect status file
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

Stared-at-code, tortured with the test framework

master...
Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2d 2e 3 4 5 5a 5v1 5v2 5v3 5w1 5w2 5w3 5w4 5y 5z 6 7 7x 8 8a 9 2f 4b.
Test sets failed: none.

and verified by "looking at logfile in realtime" that it will now, 
indeed, proceed without delay as soon as the async/deferred 
client-connect-script has written the final result to the control 
file:

2020-07-20 08:55:09 us=443291 ... PUSH: Received control message: 'PUSH_REQUEST'
2020-07-20 08:55:14 us=490368 ... PUSH: Received control message: 'PUSH_REQUEST'
2020-07-20 08:55:16 us=407542 OPTIONS IMPORT: reading client specific options ...

(without async-push, it will wait for the next PUSH_REQUEST at 
08:55:19 - so, 3s faster)

In the case of FAIL or DISABLE, the AUTH_FAILED reply will not be 
sent immediately, but this is not necessary or beneficial - so, fine.  
Just documenting my findings.

Your patch has been applied to the master branch.

commit 290bb26990133a895eac68215a7ded7e993ef167
Author: Arne Schwabe
Date:   Sun Jul 19 19:34:34 2020 +0200

     client-connect: Use inotify for the deferred client-connect status file

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200719173436.16431-3-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20481.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


