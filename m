From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] OpenVPN 2.0 released
In-Reply-To: <20050420081401.GB2181@...30...>
Message-ID: <Pine.LNX.4.58.0504201118110.14131@...41...>
References: <Pine.LNX.4.58.0504172223570.14131@...41...>
 <20050419173728.GA2126@...30...> <Pine.LNX.4.58.0504191224250.14131@...41...>
 <20050420081401.GB2181@...30...>
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
Date: Wed Apr 20 10:25:44 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Alberto Gonzalez Iniesta <agi@...64...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 20 Apr 2005, Alberto Gonzalez Iniesta wrote:

> On Tue, Apr 19, 2005 at 12:32:20PM -0600, James Yonan wrote:
> > 
> > On Tue, 19 Apr 2005, Alberto Gonzalez Iniesta wrote:
> > > 
> > > And the second issue I don't know how to handle is this:
> > > - Start openvpn multiple times for a certain configuration.
> > > - After the first one is started, the rest will 'claim' to fail
> > >   (due to port being in use), but they will leave a process running
> > >   (one each).
> > > - Even killing the first (successful) instance, the rest of the
> > >   processes will remain aroundi (doing nothing, I guess.
> > 
> > I can't reproduce this.
> 
> Sorry, James, my report was a little bogus. This was happening with one
> of my configs. I have found the option that triggers this behavior:
> 
> openvpn --dev tap --port 9999 --daemon --plugin /usr/lib/openvpn/openvpn-auth-pam.so su

Right, that makes more sense.  The openvpn-auth-pam plugin forks off a 
separate process, and this process is probably not exiting correctly 
when the main process exits with a fatal error.  I'll add to bug list.

James

