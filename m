Message-ID: <9e0cf0bf0810261339i1abdd932q6e02b0dddc9293bb@...278...>
Date: Sun, 26 Oct 2008 22:39:32 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <9e0cf0bf0810200926m5ec4de48l1677893b50178cdc@...278...>
MIME-Version: 1.0
References: <9e0cf0bf0810200840p7e5b3743p940be6e27bea9ca9@...278...>
	<750B64C66078B34D918257A1AC004DB2054510@...1132...>
	<9e0cf0bf0810200851o2a8c2df5t652424be88649457@...278...>
	<750B64C66078B34D918257A1AC004DB2054511@...1132...>
	<9e0cf0bf0810200926m5ec4de48l1677893b50178cdc@...278...>
Subject: Re: [Openvpn-devel] [WINDOWS] Request for test win64
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: "Jason R. Coombs" <jaraco@...1130...>
Cc: openvpn devel <openvpn-devel@lists.sourceforge.net>

Hello,

Can you please test [1]?

Thanks!
Alon

[1] http://alon.barlev.googlepages.com/openvpn-win64.tar.bz2

On 10/20/08, Alon Bar-Lev <alon.barlev@...277...> wrote:
> Thank you!
>  So we have an issue OpenSSL.
>
>
>  On 10/20/08, Jason R. Coombs <jaraco@...1130...> wrote:
>  > Below is the crash event when I tried to run openvpn --help; I cleared the PATH environment variable to remove any links to other openssl libraries... then ran .\openvpn --help.  It seems odd that the event is reporting libeay32.dll as version 6.0.6001.1800 -- when I look at the details of the local dll, it shows 0.9.9.0.  And the timestamp 0x4791adec corresponds to 2008-01-19 07:59:40.
>  >
>  >  Is that any help?
>  >
>  >  Log Name:      Application
>  >  Source:        Application Error
>  >  Date:          20-Oct-2008 11:56:38
>  >  Event ID:      1000
>  >  Task Category: (100)
>  >  Level:         Error
>  >  Keywords:      Classic
>  >  User:          N/A
>  >  Computer:      drake.jaraco.com
>  >  Description:
>  >  Faulting application openvpn.exe, version 0.0.0.0, time stamp 0x48fc8c5d, faulting module LIBEAY32.dll! , version 6.0.6001.18000, time stamp 0x4791adec, exception code 0xc0000139, fault offset 0x00000000000b1188, process id 0x1458, application start time 0x01c932cc6fa3b754.
>  >  Event Xml:
>  >  <Event xmlns="http://schemas.microsoft.com/win/2004/08/events/event">
>  >   <System>
>  >     <Provider Name="Application Error" />
>  >     <EventID Qualifiers="0">1000</EventID>
>  >     <Level>2</Level>
>  >     <Task>100</Task>
>  >     <Keywords>0x80000000000000</Keywords>
>  >     <TimeCreated SystemTime="2008-10-20T15:56:38.000Z" />
>  >     <EventRecordID>45520</EventRecordID>
>  >     <Channel>Application</Channel>
>  >     <Computer>drake.jaraco.com</Computer>
>  >     <Security />
>  >   </System>
>  >   <EventData>
>  >     <Data>openvpn.exe</Data>
>  >     <Data>0.0.0.0</Data>
>  >     <Data>48fc8c5d</Data>
>  >     <Data>LIBEAY32.dll! </Data>
>  >     <Data>6.0.6001.18000</Data>
>  >     <Data>4791adec</Data>
>  >     <Data>c0000139</Data>
>  >     <Data>00000000000b1188</Data>
>  >     <Data>1458</Data>
>  >     <Data>01c932cc6fa3b754</Data>
>  >   </EventData>
>  >  </Event>
>  >
>  >
>  >  > -----Original Message-----
>  >  > From: Alon Bar-Lev [mailto:alon.barlev@...277...]
>  >
>  > > Sent: Monday, 20 October, 2008 11:52
>  >  > To: Jason R. Coombs
>  >  > Cc: openvpn devel
>  >  > Subject: Re: [Openvpn-devel] [WINDOWS] Request for test win64
>  >  >
>  >  > Current distribution is 32bit (except for the driver), which can run
>  >  > also on 64bit.
>  >  > The attached files are 64bit.
>  >  > Can you please at least just try to run openvpn.exe --help and see if
>  >  > it runs?
>  >  >
>  >  > On 10/20/08, Jason R. Coombs <jaraco@...1130...> wrote:
>  >  > > Is that AMD64 or IA64?
>  >  > >
>  >  > >  I'm guessing it's AMD64.  If I understand correctly, the currently-
>  >  > released
>  >  > >  build is for 32-bit and AMD 64-bit systems.  How is this build
>  >  > different?
>  >  > >  Does it build the client executables and GUI as native 64-bit apps?
>  >  > >
>  >  > >  Sorry to ask so many questions, but I want to make sure I'm setting
>  >  > up the
>  >  > >  environment correctly to perform a reasonable test.
>  >  > >
>  >  > >  Jason
>  >  > >
>  >  > >
>  >  > >  > -----Original Message-----
>  >  > >  > From: Alon Bar-Lev [mailto:alon.barlev@...277...]
>  >  > >  > Sent: Monday, 20 October, 2008 11:41
>  >  > >  > To: openvpn devel
>  >  > >  > Subject: [Openvpn-devel] [WINDOWS] Request for test win64
>  >  > >  >
>  >  > >  > Hello,
>  >  > >  >
>  >  > >  > Just installed experimental win64 mingw, I don't have 64bit
>  >  > machine
>  >  > >  > and not Windows...
>  >  > >  > So if someone can test if [1] actually works...
>  >  > >  >
>  >  > >  > Thanks!
>  >  > >  > Alon.
>  >  > >  >
>  >  > >  > [1] http://alon.barlev.googlepages.com/openvpn-win64.tar.bz2
>  >  > >  >
>  >  > >
>  >  > > > -------------------------------------------------------------------
>  >  > ----
>  >  > >  > --
>  >  > >  > This SF.Net email is sponsored by the Moblin Your Move Developer's
>  >  > >  > challenge
>  >  > >  > Build the coolest Linux based applications with Moblin SDK & win
>  >  > great
>  >  > >  > prizes
>  >  > >  > Grand prize is a trip for two to an Open Source event anywhere in
>  >  > the
>  >  > >  > world
>  >  > >  > http://moblin-contest.org/redirect.php?banner_id=100&url=/
>  >  > >  > _______________________________________________
>  >  > >  > Openvpn-devel mailing list
>  >  > >  > Openvpn-devel@lists.sourceforge.net
>  >  > >  > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>  >  > >
>  >  > > ---------------------------------------------------------------------
>  >  > ----
>  >  > >  This SF.Net email is sponsored by the Moblin Your Move Developer's
>  >  > challenge
>  >  > >  Build the coolest Linux based applications with Moblin SDK & win
>  >  > great prizes
>  >  > >  Grand prize is a trip for two to an Open Source event anywhere in
>  >  > the world
>  >  > >  http://moblin-contest.org/redirect.php?banner_id=100&url=/
>  >  > > _______________________________________________
>  >  > >  Openvpn-devel mailing list
>  >  > >  Openvpn-devel@lists.sourceforge.net
>  >  > >  https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>  >  > >
>  >  > >
>  >  > >
>  >
>
> > -------------------------------------------------------------------------
>
> >  This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
>  >  Build the coolest Linux based applications with Moblin SDK & win great prizes
>  >  Grand prize is a trip for two to an Open Source event anywhere in the world
>  >  http://moblin-contest.org/redirect.php?banner_id=100&url=/
>  > _______________________________________________
>  >  Openvpn-devel mailing list
>  >  Openvpn-devel@lists.sourceforge.net
>  >  https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>  >
>  >
>  >
>

