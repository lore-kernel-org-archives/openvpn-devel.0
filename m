Message-ID: <52D1EC03.8080100@...1114...>
Date: Sun, 12 Jan 2014 02:12:35 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1389455615-11543-1-git-send-email-gabriel.corona@...1861...>
	<20140111195928.GO226@...1296...>
In-Reply-To: <20140111195928.GO226@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Add management command to reopen log
 file.
Reply-To: "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Gabriel Corona <gabriel.corona@...1861...>
Cc: openvpn-devel@lists.sourceforge.net

On 11/01/14 20:59, Gert Doering wrote:
> Hi,
>
> On Sat, Jan 11, 2014 at 04:53:35PM +0100, Gabriel Corona wrote:
>> Useful for better logrotate integration without going the syslog path.
>> Triggered by the "reopen-log" management command.
>
> NAK, the way it is written.  It is introducing  *18* additional #ifdefs,
> and we have already way too many of them, causing testing troubles to
> no end.
>
> Dubious on the feature itself - why not use syslog if you need log file
> rotation (= "neither an ACK nor a NAK")?

I agree with Gert here.

In regards to the feature, I can't really say I see any good use case.  Well, 
I do see the usefulness of such a feature, but I would rather say that's a bad 
setup than a lacking feature.

So I'm just thinking aloud here now.  For servers where this matters, you 
normally already have syslog available.  And syslog and logrotate (or similar 
approaches) already covers this.  The only place I see this being useful is 
where you don't have syslog available.  But in those places, you normally 
don't these requirements for log rotation (like embedded devices, with little 
memory and/or storage).  Many of these places you even don't have a persistent 
storage for log files.  And considering many Linux based embedded devices now 
also seems to move over to systemd as well, you already have the journal 
included, which can cover many of the syslog+logrotate requirements.  (In fact 
systemd can even grab program output sent to stdout and stderr and put that 
into the journal).

I'm not saying NAK to the feature, but an ACK won't come from me before I see 
some convincing use cases.


-- 

kind regards,

David Sommerseth

