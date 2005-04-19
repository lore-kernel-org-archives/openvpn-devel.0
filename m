From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] OpenVPN 2.0 released
In-Reply-To: <20050419173728.GA2126@...30...>
Message-ID: <Pine.LNX.4.58.0504191224250.14131@...41...>
References: <Pine.LNX.4.58.0504172223570.14131@...41...>
 <20050419173728.GA2126@...30...>
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
Date: Tue Apr 19 11:34:22 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Alberto Gonzalez Iniesta <agi@...64...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, 19 Apr 2005, Alberto Gonzalez Iniesta wrote:

> On Sun, Apr 17, 2005 at 10:35:36PM -0600, James Yonan wrote:
> > I'm happy to announce that OpenVPN 2.0 has been released!
> 
> Congratulations James!  (and all those who helped)
> 
> > I'm going to sit back now, relax, maybe try to get my server slashdotted, 
> > and I'll try not to think too much about OpenVPN 3.0 until the middle of 
> > the week :)
> 
> Well, since we're close to the middle of the week, I'd like to ask you a
> couple of things... :)
> 
> - There're some bugs reports I couldn't reproduce:
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=278933
> and
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=296834
> 
> And the second issue I don't know how to handle is this:
> - Start openvpn multiple times for a certain configuration.
> - After the first one is started, the rest will 'claim' to fail
>   (due to port being in use), but they will leave a process running
>   (one each).
> - Even killing the first (successful) instance, the rest of the
>   processes will remain aroundi (doing nothing, I guess.

I can't reproduce this.

Start one OpenVPN process:

  ai:~ # openvpn --dev tap --port 9999 --daemon
  ai:~ # ps ax | grep openvpn
  23057 ?        Ss     0:00 openvpn --dev tap --port 9999 --daemon

Start another on same port:

  ai:~ # openvpn --dev tap --port 9999 --daemon
  ai:~ # ps ax | grep openvpn
  23057 ?        Ss     0:00 openvpn --dev tap --port 9999 --daemon

ps still shows one process:

  ai:~ # ps ax | grep openvpn
  23057 ?        Ss     0:00 openvpn --dev tap --port 9999 --daemon

Syslog shows:

Apr 19 12:16:05 ai openvpn[23054]: OpenVPN 2.0 i586-suse-linux [SSL] [LZO] [EPOLL] built on Apr 17 2005
Apr 19 12:16:05 ai openvpn[23054]: ******* WARNING *******: all encryption and authentication features disabled -- all data will be tunnelled as cleartext
Apr 19 12:16:05 ai openvpn[23054]: TUN/TAP device tap0 opened
Apr 19 12:16:05 ai openvpn[23057]: UDPv4 link local (bound): [undef]:9999
Apr 19 12:16:05 ai openvpn[23057]: UDPv4 link remote: [undef]
Apr 19 12:16:29 ai openvpn[23072]: OpenVPN 2.0 i586-suse-linux [SSL] [LZO] [EPOLL] built on Apr 17 2005
Apr 19 12:16:29 ai openvpn[23072]: ******* WARNING *******: all encryption and authentication features disabled -- all data will be tunnelled as cleartext
Apr 19 12:16:29 ai openvpn[23072]: TCP/UDP: Socket bind failed on local address [undef]:9999: Address already in use
Apr 19 12:16:29 ai openvpn[23072]: Exiting

James


