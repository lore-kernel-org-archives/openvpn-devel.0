Date: Wed, 23 Oct 2024 10:49:18 +0200 (CEST)
Message-Id: <202410230849.49N8nI98022315@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241023080853.3710-1-gert@...1296...>
References: <20241023080853.3710-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: event/multi: add event_arg
 object to make event handling more generic
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

I've lightly tested this on the server testbed (it has TCP listeners,
and extensive t_client tests - everyhing is fine), and also stared a
bit at the code (which seems reasonable, and Frank has more extensibly
reviewed it already).

There's some questions I do not understand (like, why not store the ev_arg
in the event structure? why pass the ev_arg to socket_set_listen_persistent()
when it is passed the socket itself already?) but I guess there's good
reasons for it...

Your patch has been applied to the master branch.

commit cd8e25a6e9a0fc3687cf8b9df460885db2aee566 (master)
Author: Antonio Quartulli
Date:   Wed Oct 23 10:08:52 2024 +0200

     event/multi: add event_arg object to make event handling more generic

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20241023080853.3710-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29602.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


