From: Jon Nelson <jnelson-openvpn@...135...>
Subject: Re: [Openvpn-devel] Working with 2.6
In-Reply-To: <twig.1069195404.87396@...41...>
Message-ID: <Pine.LNX.4.58.0311181813490.26160@...136...>
References: <Pine.LNX.4.58.0311180916570.17332@...136...>
 <200311181004.25751.matt@...137...>, <200311181004.25751.matt@...137...>
 <twig.1069195404.87396@...41...>
Mime-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Nov 18 16:18:02 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: openvpn-devel@lists.sourceforge.net

On Tue, 18 Nov 2003, James Yonan wrote:

> I'm not running 2.6 yet, but if someone gives me ssh access, I will
> fix.

No offence, but you're not about to get access to my network. ;-)

> What precisely needs to be done?

Honestly, I don't know.  All I did was edit the devfs configuration for
'misc' devices, restarted devfsd, and it worked.

> Is it just a matter of trying an alternate device node name, or is
> there more involved in porting to 2.6?

Again, not sure.  BTW, beta14 shows nothing different over beta12, which
is to say it runs just fine (with the aforementioned devfs config
changes).

Also note that since devfsd is now deprecated, I do *not* know what
interface (if any) replaces it.  I'm dipping my toe into this 2.6 water
just as many others are.

--
Democracy is two wolves and a sheep voting on what to have for dinner.
Liberty is two wolves attempting to have a sheep for dinner and
finding a well-informed, well-armed sheep.

Jon Nelson <jnelson-openvpn@...135...>

