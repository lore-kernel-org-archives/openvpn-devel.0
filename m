From: Mathias Sundman <mathias@...209...>
Subject: Re: [Openvpn-devel] Re: Interface with GUI agent
In-Reply-To: <200407081043.25501.jim@...41...>
Message-ID: <Pine.LNX.4.60.0407082214170.6520@...210...>
References: <40E18559.8020407@...244...> <200407072255.54148.jim@...41...>
 <Pine.LNX.4.60.0407080941160.5287@...210...> <200407081043.25501.jim@...41...>
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
Date: Thu Jul  8 13:35:05 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Jan Kiszka <jan.kiszka@...83...>

On Thu, 8 Jul 2004, James Yonan wrote:

>> 1. On Windows, if the the service wrapper has started some openvpn
>> processes before our gui agent is started, how should find out about
>> those processes?
>
> I think that the goal here is to work towards putting all of the complexity
> into the portable service manager, so the GUI applet will only open a single
> local TCP connection to the service manager, and the service manager will
> deal with communicating with the individual OpenVPN processes.

I agree.

> All of this of course represents a lot of development effort, so I think it
> makes a lot of sense to "evolve" towards these goals in small incremental
> steps.

Agree here to.

One more thing to consider... Should we consider a system running this 
service manager an open system where all locally logged on users is 
allowed to fully manage openvpn connections, which includes:

* Start/Stop openvpn processes
* Create new openvpn configs
* delete openvpn configs

(Hereby not said that creating/deleting configs should be done via the 
service manager. I just want to discuss whether a normal user should be 
able to do this or not)

or, do we need to restrict this somehow. Two ways to restict this:

1. On filesystem level we could have the service manger only read config 
files from a prespecified directory, and can then disallow normal users 
access to that directory by normal FS restrictions. This would allow us 
to control which users is allowed to add/delete/modify config-files, but 
not stop them from starting/stopping preconfigured connections.

2. Use authentication on the socket to the service manager. This would 
allow us to fully control which user is allowed to do what, but it would 
add alot of complexity so I think it should be avoided, if really don't 
need this.


Comments?

-- 
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
NILINGS AB                        X    NO HTML/RTF in e-mail
Tel: +46-(0)8-666 32 28          / \   NO Word docs in e-mail

