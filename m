From: James Yonan <jim@...41...>
Subject: Re: Interface with GUI agent, was: Re: [Openvpn-devel] [Patch] revoke scripts were broken
References: <40E18559.8020407@...244...> <200406301202.59262.jim@...41...> <Pine.LNX.4.60.0406301916540.6703@...210...>
In-Reply-To: <Pine.LNX.4.60.0406301916540.6703@...210...>
MIME-Version: 1.0
Message-Id: <200406301725.43961.jim@...41...>
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
Date: Wed Jun 30 14:26:04 2004
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net
Cc: Mathias Sundman <mathias@...209...>, Jan Kiszka <jan.kiszka@...83...>

> James, do you put any preferance in what language/environment a gui for
> OpenVPN is developed in, if you would distribute it together with the main
> application in the future?

These are my current thoughts on this:

* Preferably, the language development tools and environment are open source, 
so there's no impediment to anyone building from source.

* The total size of included libraries should be reasonable, so it doesn't 
excessively push up the size of the Windows self-installing exe.

Having said that, I'm certainly going to be pragmatic here -- if someone puts 
together a great GUI agent that requires Visual C++ to build, I'm not going 
to belabor the point.

On the other hand if it's written in Visual Basic and increases the Windows 
package size by 10 MB then I'm going to have to think twice about actually 
bundling it.  But if it's up to standard, I'd still link to it from the 
website in a heartbeat.

James

