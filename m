From: Mathias Sundman <mathias@...209...>
Subject: Re: [Openvpn-devel] Re: Interface with GUI agent
In-Reply-To: <200407090123.51480.vda@...216...>
Message-ID: <Pine.LNX.4.60.0407092256040.8983@...210...>
References: <40E18559.8020407@...244...>
 <200407082328.32017.vda@...216...>
 <Pine.LNX.4.60.0407082318240.6520@...210...>
 <200407090123.51480.vda@...216...>
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
Date: Fri Jul  9 14:14:04 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: Denis Vlasenko <vda@...216...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, 9 Jul 2004, Denis Vlasenko wrote:

> On Friday 09 July 2004 00:35, Mathias Sundman wrote:
>>> What I am trying to say? I am very happy that you guys are actively
>>> working on openvpn. Really.
>>>
>>> Just please do not OVERdesign it.
>>>
>>> Maybe it's better to try to port daemontools to Windows
>>> and run openvpn daemon(s) under it.
>>
>> I agree that we must watch out so we don't overdesign it. It's easily
>> done. However, one thing to keep in mind is that we're not talking about
>> adding complexity to the openvpn binary (except for an interface to get
>> status information), and we're not talking about removing current
>> functionallity.
>
> IMHO daemontools for windows, if ported, can handle quite a variety
> of different setups, including one needed by openvpn. Then you can
> install it as part of openvpn install.

If the only issue we had to solve here was how a normal user should be 
able to spawn openvpn processes, I agree we should use already existing 
software to solve this.

However, this issue has grown abit larger than that. Our gui client needs 
to:

* Scan a directory for configuration files.
* A way to spawn processes (preferable portable)
* Maintain a table over on which port it can reach the openvpn
   process management interface.
* Monitor that all openvpn processes are still alive
* Connect to all the openvpn processes and get status info

There is no fancy hardcoded things we are talking about, so it could all 
reside in the gui client, however I liked the idea of moving this 
functionallity into a portable service manager.

I need to code this regardless if we put it in the gui agent itself, or in 
this service manager, so I think it makes more sence to put the effort 
into a deamon from which other gui clients can benefit on all platforms, 
instead of into my not-so-portable gui.


-- 
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
NILINGS AB                        X    NO HTML/RTF in e-mail
Tel: +46-(0)8-666 32 28          / \   NO Word docs in e-mail

