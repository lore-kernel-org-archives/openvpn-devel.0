Date: Sat, 17 May 2025 11:18:26 +0200 (CEST)
Message-Id: <202505170918.54H9IQLf078626@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250517083833.28728-1-gert@...1296...>
References: <20250517083833.28728-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dns: support running up/down
 command with privsep
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

So, at last...

I have tested this on Linux and FreeBSD 13, integrated into the t_client
framework ("make sure that resolv.conf / resolvectl status look the same
after the end of the test as when it started").  On Linux this is easy
because "close(tunfd)" will destroy the tun interface and all routes,
while on FreeBSD OpenVPN needs privileges to clean up - so "--user nobody"
doesn't work very well over there (plugin-down-root helps).

I did try a few nasty things, like "killing the privileged helper while
the unprivileged openvpn is running" - of course it will not clean up
DNS, then, but it also does not clean up anything else - seems there
is a bit of looping ("in the error handler, clean up dns, error again,
so give up") - this might be a candidate for a followup patch...

^C2025-05-17 11:12:51 event_wait : Interrupted system call (fd=-1,code=4)
2025-05-17 11:12:51 could not receive dns updown status: Broken pipe (errno=32)
2025-05-17 11:12:51 Exiting due to fatal error
2025-05-17 11:12:51 could not receive dns updown status: Broken pipe (errno=32)
2025-05-17 11:12:51 Exiting due to fatal error


Also, if you kill -STOP the background process ("something with the pipe
is awry") the unprivileged process will get stuck, as there is no timeout
guarding the pipe handling.  Not sure how we do this with other background
processes, need to have a closer look...


(but besides this, just don't kill or otherwise mess with random processes)

Your patch has been applied to the master branch.

commit 1dfe8729f6c65812bb2ee8a511c968d48d531840
Author: Heiko Hund
Date:   Sat May 17 10:38:27 2025 +0200

     dns: support running up/down command with privsep

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250517083833.28728-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31668.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


