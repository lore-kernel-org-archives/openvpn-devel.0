Date: Wed, 27 Nov 2019 20:59:40 +0100 (CET)
Message-Id: <201911271959.xARJxevS072682@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191110201718.31032-1-a@...2181...>
References: <20191110201718.31032-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: travis: fix CFLAGS assignment
 error and add -Werror only when compiling on Linux for Linux
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

Your patch has been applied to the master branch.

I have not done any sort of test, except "now pushing to master, which
will make travis either explode or happy" :-) - as the patch does not
touch anything but travis config, it's fairly save for the rest.

thanks,

commit e0fbb584b8c4acba15feed7e30a778dde6389677
Author: Antonio Quartulli
Date:   Sun Nov 10 21:17:18 2019 +0100

     travis: fix CFLAGS assignment error and add -Werror only when compiling on Linux for Linux

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20191110201718.31032-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19109.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


