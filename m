From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Looking for Media Status patch
In-Reply-To: <loom.20050418T200325-934@...171...>
Message-ID: <Pine.LNX.4.58.0504250157260.14285@...41...>
References: <loom.20050418T200325-934@...171...>
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
Date: Mon Apr 25 01:01:55 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Charles Appel <cng@...375...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, 18 Apr 2005, Charles Appel wrote:

> Hello:
> 
> Between 1-5-beta1 and 1-5-beta2 the changelog indicates
> Christof Meerwals's Media Status patch was implemented.
> I'm wondering if anyone has this patch they could post
> or send me.  I've done a diff between the two CVS tags
> but there seems to have been many changes to tapdrvr.c
> so it's difficult to determine what changes were made
> specifically for the Media Status patch.

You can disable the media status functionality by going to the TAP-Win32 
driver advanced properties and setting Media Status to Always Connected.

James

