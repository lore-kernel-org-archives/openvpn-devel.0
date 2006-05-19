From: Charles Duffy <cduffy@...294...>
Message-ID: <e4kl7n$6fg$1@...165...>
References: <op.s9rf5qftioehzu@...596...> <e4ij3s$rlq$1@...165...> <op.s9sekxenioehzu@...603...>
Mime-Version: 1.0
In-Reply-To: <op.s9sekxenioehzu@...603...>
Subject: [Openvpn-devel] Re: Configuration flexibility enhancement suggestion.
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
Date: Fri May 19 07:39:01 2006
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Tony wrote:
> On Thu, 18 May 2006 23:49:16 +0400, Charles Duffy <cduffy@...294...> 
> wrote:
> 
>> Why not just have separate config files for each possible 
>> configuration, rather than stuffing several configurations in one file?
> I did not know if it is possible on the client.

Well, there's nothing about OpenVPN itself that makes it possible, and 
plenty about what folks can do with shell scripts or small, 
easy-to-write snippets of 3rd-party wrapper code that makes it possible.

Since OpenVPN tends to rely quite a bit on shelling out to hooks to add 
new functionality, having OpenVPN itself be started by a wrapper that 
rotates configurations isn't a very big leap.


Now, if your clients are on Windows and don't have something like Cygwin 
installed (and if the Windows Scripting Host isn't flexible enough for 
this kind of thing, which it may or may not be), writing that wrapper 
may be a little bit trickier than it would be otherwise... but it still 
should be a fairly straightforward exercise.


Another option -- if clients are using the OpenVPN GUI -- is just to 
have the different .conf files be named after the different locations 
they may be at, and let them manually select the one to start from the menu.


