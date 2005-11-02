Message-ID: <4368F730.20402@...277...>
From: Alon Bar-Lev <alon.barlev@...277...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] pkcs11-protected-authentication not working in
 2.1beta4 ?
References: <43662220.3000807@...486...> <43665747.5000502@...277...> <436739A2.7020702@...486...> <4367A449.8000105@...277...> <4368D5B8.9040204@...486...>
In-Reply-To: <4368D5B8.9040204@...486...>
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
Date: Wed Nov  2 09:33:50 2005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Albert Siersema <appie@...486...>
Cc: openvpn-devel@lists.sourceforge.net

Albert Siersema wrote:
>>Strange... I don't understand what is the difference between the
>>--show-pkcs11-* and the --askpass...
>>Just to make sure... --show-pkcs11-slots prompt for PIN???
> 
> Yes it pops up the PIN dialog window (GUI) from the safesign middleware so
> to speak.
> askpass shows a prompt on stdout and reads from stdin.

Can you please check that beta6 does not popup GUI? (During 
normal operation).
It is very strange, I don't understand why the provider need 
authentication for show slots...
Please remember that askpass option should no longer be 
specified.

>>But it does!
>>Use the management interface.
>>Put the following in your configuration file:

> Yes, just what I thought :) After browsing through the beta4 source and
> manual pages 'n all I saw this one as well. It has potential but for it to
> be useful to a mere user (i.e. less computer literate people) a kind of GUI
> wrapper has to be written. I was thinking about this along the lines of
> combining it with something like:

I think that the service can always be started and put "on 
hold", then using the management you can control when it 
connects. It makes the GUI much simpler... And it does not 
need special permission, like start/stop service...

>>I will write a simple perl script that does it for you soon...
> 
> If I come up with a non-perl but GUI-y like solution i'll post it to the
> list as well.
> 

It would be great...
Do you know the openvpn GUI? (http://openvpn.se/)
It does not work with the management interface yet... So you 
can start from something...

Best Regards,
Alon Bar-Lev.

