Message-ID: <9e0cf0bf0805100051md5fcd4au6f032a85c6a87cbe@...278...>
Date: Sat, 10 May 2008 10:51:13 +0300
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <0f4501c8b271$3b877200$0202fea9@...1094...>
MIME-Version: 1.0
References: <0f4501c8b271$3b877200$0202fea9@...1094...>
Subject: Re: [Openvpn-devel] SIGHUP SIGUSR1 new logfile
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
To: Bonno Bloksma <b.bloksma@...1093...>
Cc: openvpn-devel@lists.sourceforge.net

SIGUSR1 is used for other stuff in openvpn.

Why don't you use syslog, catch the openvpn related messages and place
them in separate file? It is much simpler and can be managed in
greater flexibility.

Alon.

On 5/10/08, Bonno Bloksma <b.bloksma@...1093...> wrote:
>
>
> Hi,
>
>
>
> I wanted to implement a weekly logfile rotation for the openvpn logfile and
> noticed that it did not work, openvpn kept writing to the old logfile.
>
> If I did a manual mv openvpn.log openvpn.1 openvpn would still write to the
> same file, now called openvpn.1, and not start a new openvpn.log. Only after
> restarting openvpn dit it start a new openvpn.log file.
> What is the correct way to keep openvpn up and running but have it start
> using the new logfile?
>
> The logrotate program has a workaround by using the copytruncate option but
> that is more of a stopgap sollution for dumb programs, of which I'm sure
> openvpn is not one.
> The logrotate program can send a SIGHUP, SIGUSR1, etc after the rotation to
> tell the program the logfile has been rotated.
>
> The openvpn script in the init.d/ folder has options like reload and reopen
> which correspondent to SIGHUP, SIGUSR1 and might do what I want but.... so
> far it seems not. After both reload and reopen the old logfile is still
> being used.
> Besides that....
>
> Testing with 2.0.9-1 on a Redhat 9 machine I found out that trying to do a
> reload would produce several errors, one about opening the key file, and I
> would loose the vpn connection.
> Sat May 10 08:58:44 2008 us=750706 TCP/UDP: Closing socket
> Sat May 10 08:58:44 2008 us=750822 /sbin/ip route del 172.16.1.64/26
> RTNETLINK answers: Operation not permitted
> Sat May 10 08:58:44 2008 us=755306 ERROR: Linux route delete command failed:
> shell command exited with error status: 2
> [.....]
> Sat May 10 08:58:44 2008 us=865438 OpenVPN 2.0.9 i386-redhat-linux-gnu [SSL]
> [LZO] [EPOLL] built on Feb  2 2007
> Sat May 10 08:58:44 2008 us=865545 Restart pause, 2 second(s)
> Sat May 10 08:58:46 2008 us=866570 IMPORTANT: OpenVPN's default port number
> is now 1194, based on an official port number assignment by IANA.  OpenVPN
> 2.0-beta16 and earlier used 5000 as the default port.
> Sat May 10 08:58:46 2008 us=867202 Cannot load private key file
> bonnothuis.key: error:0200100D:system library:fopen:Permission denied:
> error:20074002:BIO routines:FILE_CTRL:system lib: error:140B0002:S
> SL routines:SSL_CTX_use_PrivateKey_file:system lib
> Sat May 10 08:58:46 2008 us=867316 Error: private key password verification
> failed
> Sat May 10 08:58:46 2008 us=867342 Exiting
> Is this a known error, maybe connected to the nobody options, or should I do
> some testing with the new 2.1 version?
>
>
> Is the issue with the logfile rotation dealt with in the 2.1 release? If
> not, will it be in a next rc? Do I need to help testing some things?
> I am NOT a C programmer, at least not anymore. My programming skills are old
> and were in several other languages like Pascal, Forth, etc. :-)
>
> p.s. In my production environment I will be using Openvpn mainly on Debian
> etch, so for that I would still be using the 2.0.9 release for a while. But
> at home I'd like to use the newer version to see if openvpn 2.1 does work as
> it should.
>
> Groetjes,
> Bonno Bloksma
>
> -------------------------------------------------------------------------
>  This SF.net email is sponsored by the 2008 JavaOne(SM) Conference
>  Don't miss this year's exciting event. There's still time to save $100.
>  Use priority code J8TL2D2.
> http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
> _______________________________________________
>  Openvpn-devel mailing list
>  Openvpn-devel@lists.sourceforge.net
>  https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

