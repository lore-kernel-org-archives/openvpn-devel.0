From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Re: 2.0-beta15 on WinXP: CreateFile failed on
 TAP device
In-Reply-To: <Pine.LNX.4.61.0411030849250.24422@...210...>
Message-ID: <Pine.LNX.4.58.0411031209060.17216@...41...>
References: <Pine.LNX.4.61.0411022157360.23349@...210...>
 <Pine.LNX.4.61.0411030849250.24422@...210...>
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
Date: Wed Nov  3 11:18:12 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Mathias Sundman <mathias@...209...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 3 Nov 2004, Mathias Sundman wrote:

> On Tue, 2 Nov 2004, Mathias Sundman wrote:
> 
> > James,
> >
> > I think we made a little misstake with the "auto-find free TAP device" 
> > feature.
> >
> > In OpenVPN GUI >= beta20 I close the connections and restart them after a 
> > suspend. If multiple connections were running this means that they will all 
> > be re-started at the exact same time after the suspend.
> >
> > I suppose the same thing happends when you start the service wrapper.
> >
> > Anyway, I had two connections running, and after a suspend, one of the 
> > connections started fine, but the other one failed with the following 
> > message:
> >
> > CreateFile failed on TAP device: 
> > \\.\Global\{75E5A03B-F1A9-422E-8DBA-EFF4B55C1B07}.tap:
> > General failure (ERROR_GEN_FAILURE) (errno=31)
> >
> > which is the same interface as the first connection used.
> >
> > I havn't checked the code yet, but I suspect that you changed the code to 
> > search for a free adapter when openvpn is started, but not actually open it 
> > until later.
> >
> > Both processes seemed to find the same interface free, but later one of them 
> > of cource failed to open it.
> 
> Forget it!!
> 
> My mistake. I'm testing far to many things at the same time now :-) I had 
> simply specified a dev-node in one of the configs because I had todo some 
> testing with OpenVPN 2.0-beta11 earlier and forgot to change it back.
> 
> I should of cource have checked my configs carefuly before posting... 
> Sorry.

Aha!

Of course it still looks like we need IFCONFIG_AFTER_TUN_OPEN on Windows, 
because otherwise guess_tuntap_dev() will be called causing the double 
open and possible race.

James


