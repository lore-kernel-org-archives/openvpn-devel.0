Message-ID: <40E2DAEB.9060705@...83...>
From: Jan Kiszka <jan.kiszka@...83...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Patch] revoke scripts were broken
References: <40E18559.8020407@...244...> <Pine.LNX.4.60.0406301609260.6264@...210...>
In-Reply-To: <Pine.LNX.4.60.0406301609260.6264@...210...>
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
Date: Wed Jun 30 08:25:05 2004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Mathias Sundman <mathias@...209...>
Cc: openvpn-devel@lists.sourceforge.net

Mathias Sundman wrote:

> On Tue, 29 Jun 2004, Jan Kiszka wrote:
> 
>> PS: Has anyone ever thought about some small GUI (taskbar icon with 
>> some dialogs) for Windows, KDE, etc. to make the handling of multiple 
>> configurations and the status display easier in a roadwarrior 
>> scenario? Just a thought, I'm not saying I have the time for doing it 
>> - unfortunately.
>>
>> [If you reply, please add a CC, I'm not on the list]
> 
> 
> I just started working on such an application last night. I'm kinda new 
> to C programming in Windows so I ran into a little annoying problem 
> right away though!
> 
> I don't want to bother this list with basic C programming issues though, 
> but if someone is used to classic C programming and message handeling in 
> windows, please contact me offlist if you got a spare minute. A pointer 
> to a good mailing-list for discussion about classic C programming in 
> windows would be appreciated too.
> 

While considering a similar interface for some other project, I once 
took a closer look at wxWindows (http://www.wxwindows.org). Before you 
start hacking your own message handling routines in C or switching over 
to the Windows-only MFC library, this project may be worth some thoughts 
because

A) it capsulates most of the annoying GUI work, and
B) it opens to possiblity to port your work later to Linux as well!

I think not only Windows users would appreciate a simple management 
interface for OpenVPN clients very much...

The only problem so far: You have to consider writing your program 
object-oriented, i.e. in C++. Did you ever worked with some OO languages 
(Java e.g.)?

I would furthermore suggest to discuss the required interface between 
the GUI and the OpenVPN daemon on this list. Starting and stopping would 
be possibly by just running the main binary, but I think a more 
sophisticated status and diagnosis interface requires some other 
mechanism (e.g. a local socket). Such an interface could furthermore 
prevent that the actual user who switches some configuration or just 
checks the status must own superuser privileges to start/stop a OpenVPN 
service and - even worse - read the secret key files.

Comments are welcome!

Jan

