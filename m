Date: Tue, 22 Dec 2020 18:42:00 +0100
From: Michael Kress <lists@...1660...>
Message-ID: <20201222184200.41fa720e@...1661...>
In-Reply-To: <20201220105430.GP976@...1296...>
References: <20201220105430.GP976@...1296...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] wanted: mechanism to send text messages to
 client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,
Am Sun, 20 Dec 2020 11:54:30 +0100
schrieb Gert Doering <gert@...1296...>:
> I find myself looking for a mechanism by which I could send
> informational messages ("your cert expires in two weeks, go refresh!"
> - "your openvpn client needs an upgrade") from the openvpn server to
> incoming clients.
 
I'm quite late to the party, but something similar like this I asked a
few days ago (06.12.2020):
https://sourceforge.net/p/openvpn/mailman/message/37170200/

I proposed a generic way to send whatever you like over the
control channel. A plugin could be triggerd by hooks which react on
this generic push command. The plugins for all different OS and UIs
could trigger messages in new windows or network managers.

Your wish is to send a message, mine was to send a certificate. A
generic push command could achive both, as long the plugin is
installed.

echo could be a possibility, but fiddling with log files must also be
implemented (by a plugin?)

Servus
  Michael

> Of course this should work with all connecting clients, that is, "text
> clients", windows GUI, Tunnelblick, iOS Connect, Android.
> 
> As far as I am aware, there is no such mechanism today.
> 
> Do we want to make one?
> 
> 
> From the server / openvpn core side, it could be something totally
> trivial:
> 
>   push "info-msg hey there!"
> 
> ... and the client would then either print this on the console 
> (if !management) or dump it to management, where the GUI/Tunnelblick
> could pick it up and create a popup window.
> 
> What do you think?
> 
> gert


