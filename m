From: Mathias Sundman <mathias@...209...>
In-Reply-To: <1088881994.40e7054a0e5e6@...238...>
Message-ID: <Pine.LNX.4.60.0407032113540.17721@...210...>
References: <40E18559.8020407@...244...> <200406301202.59262.jim@...41...>
 <Pine.LNX.4.60.0406301916540.6703@...210...> <200406301725.43961.jim@...41...>
 <1088881994.40e7054a0e5e6@...238...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Re: Interface with GUI agent
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
Date: Sat Jul  3 12:26:03 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Brandon Knitter <knitterb@...237...>

On Sat, 3 Jul 2004, Brandon Knitter wrote:

> Hey there.  James and I had a prior discussion about the systray app offline,
> but I thought I'd just poke my head in here.  I'm not a strong Windows
> application programmer, but I've been doing a lot of C# these days.
>
> With that in mind, I was gonna whip together a quickie little systray app in C#
> which could control the openvpn server.  I know that C# adds the rather large
> .NET framework runtime installation, so my app could be considered a prototype
> if you would like!
>
> Where do I start?  Are the namedpipe hooks into the OpenVPN service built?  I'm
> not too familiar with named pipes on Windows (done a bit on *nix), but I'm sure
> it can't be too hard.  I guess what I'd need to know are the command to send to
> the named pipe, and also what I can get from the named pipe in regards to status
> and such.
>
> Any suggestions?

Hi Brandon!

Have you looked at the systray application I wrote and released on the 
users-list last night?

If not, have a look at http://www.nilings.se/openvpn

I'm working hard on next version right now and will probably release it 
tomorrow. This version will support controlling multiple tunnels 
simultaneously from the the menu, and monitor if the process ends before 
it is manually disconnected.

My version is written in pure Win32 C code, but if you want to rewrite it 
using C# you are ofcource welcome...

Best Regards Mathias
-- 
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
NILINGS AB                        X    NO HTML/RTF in e-mail
Tel: +46-(0)8-666 32 28          / \   NO Word docs in e-mail

