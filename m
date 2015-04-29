Message-ID: <55413AFE.4080906@...68...>
Date: Wed, 29 Apr 2015 22:11:42 +0200
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <1427784294-22175-1-git-send-email-samuli@...515...>	
	<551A4A9B.6010508@...68...> <1430309264.1291.59.camel@...1866...>
In-Reply-To: <1430309264.1291.59.camel@...1866...>
Subject: Re: [Openvpn-devel] [PATCH] Remove useless dash escapes from the
 man-page
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: David Woodhouse <dwmw2@...1866...>
Cc: openvpn-devel@lists.sourceforge.net

Am 29.04.2015 um 14:07 schrieb David Woodhouse:
> On Tue, 2015-03-31 at 09:19 +0200, Matthias Andree wrote:
>> I am concerned this will cause misformattings and inability to search
>> for options with leading dashes on some systems - I don't recall
>> versions, but I do know that some systems used some sort of Unicode
>> (soft?) hyphen for a simple non-escaped MINUS character (ASCII 0x2B).
> 
> cf. https://bugzilla.redhat.com/show_bug.cgi?id=1173619
> 
> I'm not sure there *is* a right answer. Groff will interpret a bare '-
> ' as a hyphen, and may render it in output as U+2010 HYPHEN. It will
> interpret an escaped '\-' as a minus sign, and may render it in output
> as U+2212 MINUS SIGN.
> 
> I'm not aware of any way to actually *tell* groff that we want the
> output to be a U+002D HYPHEN-MINUS. Either way, we rely on undefined
> behaviour of the output drivers which may vary from system to system.
> 
> Basically, I think groff is just broken. There is a thread at 
> http://lists.gnu.org/archive/html/groff/2015-01/threads.html which
> I've just discovered, but I'm not sure I can see a conclusion there
> that I understand.


That would mean we either go into autoconf territory to test for groff
run-time behaviour, or we use a particular unique sequence and do our
own post-processing.


