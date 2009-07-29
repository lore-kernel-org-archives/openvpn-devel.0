Date: Tue, 28 Jul 2009 20:49:59 -0500
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <3453b4110907281422u4284faen6cd632e62f11cdf7@...278...>
	(from sebastien.raveau@...1231... on Tue Jul 28 16:22:09 2009)
Message-Id: <1248832199.19514.1@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc19 released
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
To: Sebastien Raveau <sebastien.raveau@...1231...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, openvpn-devel@lists.sourceforge.net

On 07/28/2009 04:22:09 PM, Sebastien Raveau wrote:


> If I understand you correctly, that is, if you are suggesting that
> OpenVPN should automatically apply a SELinux context if setcon() is
> available... I'll have to disagree with you. Not that I reject the
> idea of enforcing security measures by default, but because when you
> google for "selinux howto", half of the first-page results are on how
> to *disable* SELinux. Apparently not everybody likes it, and they=20
> have
> a right to, so I believe we should not force it upon them :-)

SELinux is a great idea, in theory.  In practice I find the
cost/benefit such that I wind up turning it off.  I'd love
to have it available and working in "stock" situations,
and have the (easy to do) option of turning it off if
desired.   If nothing else it gets in the way of development/
deployment.  After something's working then it's possible to go back
and figure out which permissions need enabling.

Because of the complication it would also be highly
desirable, except for a possible "off/monitor mode/on"
switch, if it would integrate with the rest of SELinux
so there's not yet more configuration.  I assume that
this is the natural approach to take, but figured I'd
mention it anyway.


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


