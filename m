From: Mathias Sundman <mathias@...209...>
Subject: Re: [Openvpn-devel] OpenVPN get stuck in getpass()
In-Reply-To: <Pine.LNX.4.60.0407230944060.20730@...210...>
Message-ID: <Pine.LNX.4.60.0407231101400.20730@...210...>
References: <Pine.LNX.4.60.0407230944060.20730@...210...>
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
Date: Fri Jul 23 02:11:06 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

On Fri, 23 Jul 2004, Mathias Sundman wrote:

> OpenVPN (2.0-beta7) does not exit when the exit_event is signaled if a 
> passphrase protected key is used, and openvpn in waiting for the password 
> from the console.
>
> This is a problem now that I pass the passphrase from my gui as a cmd-line 
> option. I want to support non passphrase protected keys to, therefor if the 
> user justs hits enter at my passphrase dialog, I do not use the --passphrase 
> option.
>
> The problem arises if the key IS protected, but the user just hits enter at 
> the passphrase prompt (by mistake perhaps), as then openvpn is launched as 
> normal without knowing about the passphrase, and will therefor ask for the 
> passphrase from the console.
>
> And there it's stuck :-) Even if I signal the exit_event the openvpn process 
> don't exit, so I have to kill the process manually to be able to restart the 
> connection...
>
> Any suggestions how to solve this?
>
> Is it possible to have openvpn exit when the exit_event is signaled even if 
> it is in getpass(), or do I have to come up with a way to tell openvpn not to 
> ask for the passphrase from the console at all?

Found the problem/solution :)

I though this was working the other day, and it was. The problem was that 
when I tested today, I launched the GUI from a cmd prompt. When the GUI 
then launched openvpn.exe it passed on the handle for stdin, and as the 
gui was started from a cmd prompt, stdin was available and therefor 
openvpn asked for the passphrase from the console.

Normally the GUI is started from the desktop, and then no stdin is 
available, so openvpn has no stdin and fails on getpass() (as I want!).

So, the solution was simply to never pass any stdin handle to openvpn.exe 
regardless of how the GUI was started...

-- 
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
NILINGS AB                        X    NO HTML/RTF in e-mail
Tel: +46-(0)8-666 32 28          / \   NO Word docs in e-mail

