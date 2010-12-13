Date: Mon, 13 Dec 2010 10:29:56 -0600
From: "Karl O. Pinc" <kop@...1206...>
References: <AANLkTi=NP1rL9m4PM1G0B4nZ853cig2Eh5ETFiUP6fod@...278...>
	<1292241376-18056-1-git-send-email-davids@...1347...>
In-Reply-To: <1292241376-18056-1-git-send-email-davids@...1347...> (from
	davids@...1347... on Mon Dec 13 05:56:16 2010)
Message-Id: <1292257796.32094.1@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Open log files as text files on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

On 12/13/2010 05:56:16 AM, David Sommerseth wrote:
> By giving the "t" flag to _fdopen() on Windows, the file will be
> opened in a "translate mode", where it will take care of converting
> \n to \r\n, and also look for the CTRL-Z mark when opening the log
> file in append mode.

It should be possible to have a consistent log format
across hydrogenous hosts so that, need be, the logs can all
be processed in the same fashion.  (Think swatch,
etc.)  Which raises the following
questions in my devoid-of-MS-isms mind:

How does this affect network logging; syslog et-al?

Shouldn't there be a flag that turns this on (or off)?




Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


