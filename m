From: Rainer Sokoll <R.Sokoll@...234...>
Message-ID: <20040607110822.GI7429@...235...>
References: <twig.1086485727.92671@...41...>
Mime-Version: 1.0
In-Reply-To: <twig.1086485727.92671@...41...>
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
Date: Mon Jun  7 08:30:09 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

On Sun, Jun 06, 2004 at 01:35:27AM -0000, James Yonan wrote:

> * New feature: --status.  Outputs a SIGUSR2-like
>   status summary to a given file, updated once
>   per n seconds.  The status file is comma delimited
>   for easy machine parsing.

With me, the file has setuid, setgid and sticky bits set. Is that
intended?

Rainer
-- 
To me, women are like elephants: I like to look at them,
but I wouldn't want to own one.
                                           (W.C. Fields)

