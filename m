Message-ID: <1088881994.40e7054a0e5e6@...238...>
From: Brandon Knitter <knitterb@...237...>
Subject: Re: Interface with GUI agent, was: Re: [Openvpn-devel] [Patch] revoke scripts were broken
References: <40E18559.8020407@...244...> <200406301202.59262.jim@...41...> <Pine.LNX.4.60.0406301916540.6703@...210...> <200406301725.43961.jim@...41...>
In-Reply-To: <200406301725.43961.jim@...41...>
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
Date: Sat Jul  3 12:14:05 2004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: James Yonan <jim@...41...>, Mathias Sundman <mathias@...209...>, Jan Kiszka <jan.kiszka@...83...>

Hey there.  James and I had a prior discussion about the systray app offline,
but I thought I'd just poke my head in here.  I'm not a strong Windows
application programmer, but I've been doing a lot of C# these days.

With that in mind, I was gonna whip together a quickie little systray app in C#
which could control the openvpn server.  I know that C# adds the rather large
.NET framework runtime installation, so my app could be considered a prototype
if you would like!

Where do I start?  Are the namedpipe hooks into the OpenVPN service built?  I'm
not too familiar with named pipes on Windows (done a bit on *nix), but I'm sure
it can't be too hard.  I guess what I'd need to know are the command to send to
the named pipe, and also what I can get from the named pipe in regards to status
and such.

Any suggestions?

-- 
-bk


Quoting James Yonan <jim@...41...>:

> > James, do you put any preferance in what language/environment a gui for
> > OpenVPN is developed in, if you would distribute it together with the main
> > application in the future?
> 
> These are my current thoughts on this:
> 
> * Preferably, the language development tools and environment are open source,
> 
> so there's no impediment to anyone building from source.
> 
> * The total size of included libraries should be reasonable, so it doesn't 
> excessively push up the size of the Windows self-installing exe.
> 
> Having said that, I'm certainly going to be pragmatic here -- if someone puts
> 
> together a great GUI agent that requires Visual C++ to build, I'm not going 
> to belabor the point.
> 
> On the other hand if it's written in Visual Basic and increases the Windows 
> package size by 10 MB then I'm going to have to think twice about actually 
> bundling it.  But if it's up to standard, I'd still link to it from the 
> website in a heartbeat.
> 
> James
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by Black Hat Briefings & Training.
> Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
> digital self defense, top technical experts, no vendor pitches, 
> unmatched networking opportunities. Visit www.blackhat.com
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 
> 



