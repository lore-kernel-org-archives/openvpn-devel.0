From: Mathias Sundman <mathias@...209...>
Subject: Re: [Openvpn-devel] Passing private key passphrase to openvpn
In-Reply-To: <Pine.LNX.4.60.0407132213180.21236@...210...>
Message-ID: <Pine.LNX.4.60.0407132309590.21236@...210...>
References: <Pine.LNX.4.60.0407132213180.21236@...210...>
MIME-Version: 1.0
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
Date: Tue Jul 13 14:24:06 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

On Tue, 13 Jul 2004, Mathias Sundman wrote:

> I'd like to implement a way to hand over the private key passphrase to 
> openvpn, to be able to add this feature to my GUI.
>
> We have discussed that this could/should be done via the management interface 
> that we've discussed alot. However, I'd like to add the passphrase feature 
> now so I wonder which is the best way to do this.
>
> 1. Add a cmd-line option to pass it. (Considered insecure by some).
>
> 2. Use an environment variable. Portable? Secure?
>
> 3. Start the work on this mgmnt interface and add the passphrase passing 
> feature as the first cmd.
>
> (1) is easiest to implement and good enough for my use, on single user 
> windows machines, but perhaps not good enough for multi-user unix systems. On 
> the other hand, no one is forcing anyone to use this cmd-line option, so we 
> might start with adding this feature, and then add a way to pass the 
> passphrase over the management interface when we have that ready.

I just realized that (1) won't be good enough even for me :-) I can't 
figure out a way for how the GUI should know in advance of starting 
openvpn wether it has to quiry to user for a passphrase or not. This would 
require adding an option to the config-file that enables this, or some 
other way of configuring the gui which connections that require a 
passphrase.

I want to avoid having the gui parsing the config-file for options or 
having it's own config file because I'd like it to be possible to use 
exactly the same config-file with or without the gui.

So, I suppose my only option left is to begin the work on the management 
interface. Have you had time starting the work on this, James?

If not, where do I begin?

In what function should I create the socket?

Where do we put the main functionallity for reading and writing to the 
socket?

-- 
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
NILINGS AB                        X    NO HTML/RTF in e-mail
Tel: +46-(0)8-666 32 28          / \   NO Word docs in e-mail

