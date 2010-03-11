Date: Thu, 11 Mar 2010 10:00:51 -0600
From: "Karl O. Pinc" <kop@...1206...>
References: <4B9515FF.6000704@...41...>
	<20100308174321.GA25238@...1296...> <4B966A98.4000206@...41...>
	<jwvsk87dlhk.fsf-monnier+inbox@...1269...>
	<4B9907DF.7030609@...1114...>
In-Reply-To: <4B9907DF.7030609@...1114...> (from
	openvpn.list@...1114... on Thu Mar 11 09:10:23 2010)
Message-Id: <1268323251.15862.5@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Supporting "route-gateway dhcp" on non-Windows
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, James Yonan <jim@...41...>

On 03/11/2010 09:10:23 AM, David Sommerseth wrote:

> I agree to your points, from a theoretical point of view.  But from a
> practical point of view, I'm not sure how possible it is to find a
> more
> generic solution which can be used on all *nix based setups.  AFAIK,
> ifplugd is very Linux oriented, and depends on features found in that
> kernel.  What about *BSD, Solaris or other Unix based OSes?

OpenBSD has ifstated.  I'd be surprised if the others didn't have
something similar.




Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


