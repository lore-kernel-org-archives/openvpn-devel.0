Date: Mon, 29 Jun 2020 13:31:21 +0200 (CEST)
Message-Id: <202006291131.05TBVLK3081826@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1593427748-29801-2-git-send-email-max@...1047...>
References: <1593427748-29801-2-git-send-email-max@...1047...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add --bind-dev option.
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
To: Maximilian Wilhelm <max@...2564...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Your patch has been applied to the master branch.

I have stared at the code (looks reasonable) and run t_client tests on
Linux and FreeBSD (pass, no major surprise).

I have not actually tested the functionality, because I do not have a test 
rig with VRF (or multiple ethernet links) around.  From what I found so far,
what SO_BINDTODEVICE does is "ensure that packets sent via that socket go
out via the specified interface, and only that interface" and "packets
coming in have been received on that interface".   Besides "a network
interface" you can also specify the name of a "VRF device" (which seems
to be a Linux abstraction to group together "Interfaces and Routes" 
under one umbrella).

So you can use this for VRFs ("--bind-dev outer-vrf") or to select one
particular interface (*and* routes) inside "global" or "VRF".

I have tested the latter ("--bind-to lo") which makes connection setup
*fail* - obviously.  Trying to bind to nonexistant devices gives a proper
error message in v2 now

   2020-06-29 13:27:03 WARN: setsockopt SO_BINDTODEVICE=MyTunnelIsLongerThanYours failed: No such device (errno=19)


Googling for SO_BINDTODEVICE shows lots of confusion on how this is used
and what it does, but I consider the kernel documentation to be authoritative
(Documentation/networking/vrf.txt) and that says "what you do is correct":

   Applications
   ------------
   Applications that are to work within a VRF need to bind their socket to the
   VRF device:

       setsockopt(sd, SOL_SOCKET, SO_BINDTODEVICE, dev, strlen(dev)+1);

(note the "strlen(dev)+1" part, and "not a struct ifreq")


Your patch has been applied to the master branch.

commit 19d3c602e7a3881cf7c2244b7c40b9958c0b7ebc
Author: Maximilian Wilhelm
Date:   Mon Jun 29 12:49:07 2020 +0200

     Add --bind-dev option.

     Signed-off-by: Maximilian Wilhelm <max@...2564...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1593427748-29801-2-git-send-email-max@...1047...>
     URL: https://www.mail-archive.com/search?l=mid&q=1593427748-29801-2-git-send-email-max@...1047...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


