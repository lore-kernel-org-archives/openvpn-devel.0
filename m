From: Davide Brini <dave_br@...1278...>
Date: Sat, 5 Jun 2010 23:36:37 +0100
References: <20100604224938.GA19956@...1375...>
	<201006052252.56680.dave_br@...1278...>
	<55BD8DBD-8E0F-45BD-96CB-EF3DD520726D@...1348...>
In-Reply-To: <55BD8DBD-8E0F-45BD-96CB-EF3DD520726D@...1348...>
MIME-Version: 1.0
Message-Id: <201006052336.37559.dave_br@...1278...>
Subject: Re: [Openvpn-devel] PATCH: remove bashisms from easy-rsa
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: Toby Thain <toby@...1348...>
Cc: openvpn-devel@lists.sourceforge.net

On Saturday 05 June 2010, Toby Thain wrote:

> > <rant>
> > I'm not sure why Solaris has been insisting for ages now in shipping
> > default tools that are either old, with less features or downright broken.
> > It's not just about sh; other popular tools like awk are also pretty much
> > unusable by default under Solaris; one needs to use the POSIX-compliant
> > versions that are under /usr/xpg4/bin/.
> > </rant>
> 
> Most of the common GNU utilities (including gcc) are in the standard
> Solaris install, either via /usr/sfw/ or by using g prefix (e.g. gawk,
> gmake).

Possibly, but it still means that either scripts using standard names and 
expecting standard functionality have to be changed, or the system has to be 
changed to have the standard-named utilites point to the GNU versions.

-- 
D.

