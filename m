Date: Wed, 15 Jul 2020 13:25:55 +0200 (CEST)
Message-Id: <202007151125.06FBPt7r066657@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200711093655.23686-4-arne@...1227...>
References: <20200711093655.23686-4-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: client-connect: Move
 multi_client_connect_setenv into early_setup
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
To: Fabian Knittel <fabian.knittel@...1547...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Your patch has been applied to the master branch.

It has been stared-at, and tested on the server side test rig.

We've had quite a bit of discussion about this on IRC, and the conclusion is
"multiple calls to these functions might be needed in some situations"
(like, when a ccd/ file sets up a virtual address and a plugin or script
wants to act on the assigned IP address, by means of $ENV{ifconfig_pool_local}
etc.) - we might want to make it more clever ("if nothing changes, do not
free/reallocate stuff all the time"), or at least join them all in one place
with a clear comment

13:10 <@cron2> moving this to multi_client_connect_early_setup() seems wrong
13:10 <@cron2> we should move it to the very end, after all "bring in new 
               config" bits have been concluded
13:11 <@plaisthos> this might want to have a connect script act on the assigned ip
13:11 <@plaisthos> like dynamic routing etc
13:11 <@plaisthos> and if you move it to the end then you loose the environment 
                   variable with the assigned IP
13:12 <@cron2> in that case, you actually need to really call it after every 
               single "could alter config" call
13:12 <@cron2> and before the first
13:12 <@plaisthos> technically you don't need it before the first
13:12 <@plaisthos> because the first is ccd
13:12 <@plaisthos> that does not evaluate env
13:12 <@cron2> true
13:13 <@plaisthos> but for consistency and the later refactoring it is better 
                   to do it anyway I guess
13:14 <@cron2> okay.  I think 04/ can go in, then, but after the change to 
               "just walk the table of handlers" I'd move all calls to both 
               multi_select_virtual_addr() and multi_client_connect_setenv() 
               into this loop - so we know "it's evalued after each handler, 
               because further handles might need the environment" - and then 
               we can kick it from early_setup() again
13:14 <@cron2> the stuff is all reentrant, so 04/ is not the most elegant, but 
               it is not doing harm


commit 380a142a6b397e615ef809a94c5e6be7fcddad06
Author: Fabian Knittel
Date:   Sat Jul 11 11:36:45 2020 +0200

     client-connect: Move multi_client_connect_setenv into early_setup

     Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
     Signed-off-by: Arne Schwabe <arne@...1227...>
     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200711093655.23686-4-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20288.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


