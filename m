From: Mathias Sundman <mathias@...209...>
In-Reply-To: <40EA61C7.9070406@...83...>
Message-ID: <Pine.LNX.4.60.0407061042300.372@...210...>
References: <40E18559.8020407@...244...> <40E744F9.5000700@...83...>
 <Pine.LNX.4.60.0407052042310.29911@...210...> <200407051513.29794.jim@...41...>
 <40EA61C7.9070406@...83...>
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
Date: Tue Jul  6 01:49:07 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: Jan Kiszka <jan.kiszka@...83...>
Cc: James Yonan <jim@...41...>, openvpn-devel@lists.sourceforge.net

On Tue, 6 Jul 2004, Jan Kiszka wrote:

> James Yonan wrote:
>
>> ...
>>> If it's not a windows specific problem, then I suppost it's best to add
>>> the functionallity in the openvpn binary so we get the portability.
>> 
>> 
>> I don't think the openvpn binary needs to know about this.  But the 
>> service wrapper probably needs a second mode of operation, where instead 
>> of getting its config files by scanning a directory, it listens on a local 
>> socket for a command from the GUI to start an openvpn.exe instance.
>> 
>
> Then don't forget that we will need a similar wrapper for unix as well...

Why do we need a wrapper in unix? Can't the openvpn binary be run as a 
normal user in unix?

If we need root-privs, what's wrong with installing openvpn as suid root 
and have it drop its privs after start-up?

We still need the management interface in openvpn though for all platforms 
so we can check the status of the connection from a gui, but that's 
another issue.

-- 
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
NILINGS AB                        X    NO HTML/RTF in e-mail
Tel: +46-(0)8-666 32 28          / \   NO Word docs in e-mail

