From: Mathias Sundman <mathias@...209...>
Subject: Re: Interface with GUI agent, was: Re: [Openvpn-devel] [Patch] revoke
 scripts were broken
In-Reply-To: <200406301202.59262.jim@...41...>
Message-ID: <Pine.LNX.4.60.0406301916540.6703@...210...>
References: <40E18559.8020407@...244...>
 <Pine.LNX.4.60.0406301609260.6264@...210...> <40E2DAEB.9060705@...83...>
 <200406301202.59262.jim@...41...>
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
Date: Wed Jun 30 11:04:02 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Jan Kiszka <jan.kiszka@...83...>

On Wed, 30 Jun 2004, Jan Kiszka wrote:

>>> PS: Has anyone ever thought about some small GUI (taskbar icon with 
>>> some dialogs) for Windows, KDE, etc. to make the handling of multiple 
>>> configurations and the status display easier in a roadwarrior 
>>> scenario?
>>
>> I just started working on such an application last night. I'm kinda new 
>> to C programming in Windows so I ran into a little annoying problem 
>> right away though!
>
> While considering a similar interface for some other project, I once 
> took a closer look at wxWindows (http://www.wxwindows.org). Before you 
> start hacking your own message handling routines in C or switching over 
> to the Windows-only MFC library, this project may be worth some thoughts 
> because
>
> A) it capsulates most of the annoying GUI work, and
> B) it opens to possiblity to port your work later to Linux as well!
>
> I think not only Windows users would appreciate a simple management 
> interface for OpenVPN clients very much...
>
> The only problem so far: You have to consider writing your program
> object-oriented, i.e. in C++. Did you ever worked with some OO languages
> (Java e.g.)?

No, I'm not used to OO languages, unfortunally. The reasons why I started 
to write this in C was:

1) I only know how to code in C, VisualBasic and Assembler. Assembler is 
out of the question, and I'm tired of VBs dependency for a bunch of DLLs. 
I like beeing able to compile just one compact exe file and not need to 
create an installation package just to get the application working on 
another machine.

2) The egoistic one! I've though of learning to develop windows gui 
applications in C for a long time, but never really got to it. Now I saw 
an opportunity to write something useful and learn something I've wanted 
to learn at the same time.

3) OpenVPN is written in traditional C, so if I for any reason would like 
to integrate the gui into the openvpn binary, that would be very easy if 
the gui itself was written in C.

4) I like traditional C, and dislike object oriented languages! Don't ask 
me why, it's just my personal taste, and I can fully understand that other 
prefer OO languages...

I do agree with you though that makeing it portable would have been 
prefered, but just like you, I don't got that much spare time, so I'm not 
sure that I want to spend it learning yet another development environment.

James, do you put any preferance in what language/environment a gui for 
OpenVPN is developed in, if you would distribute it together with the main 
application in the future?


On Wed, 30 Jun 2004, James Yonan wrote:

>> I would furthermore suggest to discuss the required interface between
>> the GUI and the OpenVPN daemon on this list. Starting and stopping would
>> be possibly by just running the main binary, but I think a more
>> sophisticated status and diagnosis interface requires some other
>> mechanism (e.g. a local socket). Such an interface could furthermore
>> prevent that the actual user who switches some configuration or just
>> checks the status must own superuser privileges to start/stop a OpenVPN
>> service and - even worse - read the secret key files.
>
> Yes, I would like to see some kind of interface for control of OpenVPN from
> external programs.
>
> The mechanism of the interface would be a socket on *nix or a named pipe on
> Windows.
>
> The interface would primarily be for interaction with a GUI agent and would
> allow for:
>
> * Stop/Restart control
> * Get status (like SIGUSR2)
> * Provide authentication info

That's great news. That was one of my concerns the other night, how to 
communicate with OpenVPN to check the status.

-- 
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
NILINGS AB                        X    NO HTML/RTF in e-mail
Tel: +46-(0)8-666 32 28          / \   NO Word docs in e-mail

