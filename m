From: "James Yonan" <jim@...41...>
Message-ID: <twig.1086623143.49482@...41...>
In-Reply-To: <20040607110822.GI7429@...235...>
References: <twig.1086485727.92671@...41...>, <twig.1086485727.92671@...41...>
Subject: [Openvpn-devel] Re: [Openvpn-users] OpenVPN 2.0-beta3 released
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
Date: Mon Jun  7 08:46:05 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Rainer Sokoll <R.Sokoll@...234...>, James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Rainer Sokoll <R.Sokoll@...234...> said:

> On Sun, Jun 06, 2004 at 01:35:27AM -0000, James Yonan wrote:
> 
> > * New feature: --status.  Outputs a SIGUSR2-like
> >   status summary to a given file, updated once
> >   per n seconds.  The status file is comma delimited
> >   for easy machine parsing.
> 
> With me, the file has setuid, setgid and sticky bits set. Is that
> intended?

No, that looks like a bug -- I will fix in beta4.

James


