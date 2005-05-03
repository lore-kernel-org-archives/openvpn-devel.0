From: Claas Hilbrecht <claas+maillinglists.openvpn@...232...>
Message-ID: <ABB58BFE38C9118DC240FBF0@[192.168.1.22]>
In-Reply-To: <Pine.LNX.4.58.0505021249570.16548@...41...>
References: <Pine.LNX.4.58.0504301622050.25603@...41...>
 <CFAB61A740D152638EA62E71@[192.168.1.22]>
 <Pine.LNX.4.58.0505021249570.16548@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Re: [Openvpn-users] OpenVPN 2.0.1-rc1 released
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue May  3 04:48:12 2005
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

--Am Montag, 2. Mai 2005 13:20 -0600 James Yonan <jim@...41...> schrieb:

> Interesting idea for when the client is local to the OpenVPN daemon.  I'm
> thinking this would be a 2.1 thing.

I've done this because the webgui (with mini_httpd) runs on a very stripped 
down busybox system. The whole system is based on fli4l and targeted for 
novice users. Each question you asked to configure an item is a question to 
ask for trouble :) So, running the console on a port the OS choose is a 
good idea I thought.

> * Does your code survive a SIGUSR1 when root has been dropped or chroot

All my OpenVPN processes run chroot/nobody and a SIGUSR1 seems to not 
change the management port. Indeed I've looked at the code and it seems to 
me the management interface is initialized once at startup. The webgui 
never sees an interrupted sessions if a user sends a "signal SIGUSR1" via 
the management interface. But I've just tested it, there seems to be no 
problem.

> root-drop/chroot.  I think you are probably okay here because the place
> where you are writing the port number I believe is only called on
> initialization.

It seems you're right.

> * Some stray text in the can't open error message: "Open error on pid
> file".

Feel free to provide a better message. I'm glad that you're able to 
understand me at least :)

-- 
 Claas Hilbrecht
 http://www.jucs-kramkiste.de


