From: Mathias Sundman <mathias@...209...>
In-Reply-To: <200407051513.29794.jim@...41...>
Message-ID: <Pine.LNX.4.60.0407052112240.29911@...210...>
References: <40E18559.8020407@...244...> <40E744F9.5000700@...83...>
 <Pine.LNX.4.60.0407052042310.29911@...210...> <200407051513.29794.jim@...41...>
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
Date: Mon Jul  5 12:19:00 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, 5 Jul 2004, James Yonan wrote:

> On Monday 05 July 2004 14:49, Mathias Sundman wrote:
>> On Sun, 4 Jul 2004, Jan Kiszka wrote:
>>> I would like to have some mechanism to fork an openvpn instance and let
>>> the new process use a specific configuration file. This would allow to
>>> start only certain VPN tunnels depending on what the user selects in the
>>> GUI.
>>
>> I've been giving this some more thought... and I agree we definitly need
>> something like this.
>>
>> If it's a windows specific problem, then maybe this functionally should be
>> in the service wrapper. If we add a simple interface to the service
>> wrapper our gui client could tell the service wrapper to start new openvpn
>> processes when we want.
>
> Yes, this is probably a better idea.
>
>> If it's not a windows specific problem, then I suppost it's best to add
>> the functionallity in the openvpn binary so we get the portability.
>
> I don't think the openvpn binary needs to know about this.  But the service
> wrapper probably needs a second mode of operation, where instead of getting
> its config files by scanning a directory, it listens on a local socket for a
> command from the GUI to start an openvpn.exe instance.

Do you have time to do this in the near future? Otherwise, I think I could 
do it. I'm pretty familiar with the service wrapper code now that I've 
copied most of it to my gui :-) So now I just need to put it back in the 
service wrapper!

-- 
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
NILINGS AB                        X    NO HTML/RTF in e-mail
Tel: +46-(0)8-666 32 28          / \   NO Word docs in e-mail

