From: Juan Rodriguez Hervella <jrh@...176...>
Subject: Re: [Openvpn-devel] route option only adds route for first IP resolved for a hostname (with many)
References: <20040310160714.GA1152@...30...>
In-Reply-To: <20040310160714.GA1152@...30...>
MIME-Version: 1.0
Message-Id: <200403101805.21043.jrh@...176...>
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
Date: Wed Mar 10 09:28:04 2004
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net
Cc: Alberto Gonzalez Iniesta <agi@...5...>

On Wednesday 10 March 2004 17:07, Alberto Gonzalez Iniesta wrote:
> Hi James et all,
>
> I have just got this bug report [1]. The problem is: When a hostname is
> given to the 'route' option, only a route to the first IP address for that
> hostname is added.
>
> route(8) works the same way, and I don't know if this is really a bug,
> or The Way is Meant to Be (tm).... Any thoughts?
>
>
>
> [1] http://bugs.debian.org/237251

Hi Alberto!

After reading the bug track, it seems to me that he/she is right,
and the --route command should add all the addresses returned by
the query. It's not a hard thing to implement, imho.

Seeyou!
-- 
******
JFRH
******

