Date: Wed, 02 Sep 2009 20:50:11 -0500
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <1C795E2FCD154E46979DDDD5374B5ABE024D96F6@...1261...>
	(from jcullison@...1260... on Wed Sep  2 18:29:26 2009)
Message-Id: <1251942611.20315.2@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Losing connectivity when OpenVPN cannot
 establish tunnel under Windows
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
To: John Cullison <jcullison@...1260...>
Cc: openvpn-devel@lists.sourceforge.net

On 09/02/2009 06:29:26 PM, John Cullison wrote:

 I noticed today, however, that I had lost Internet
> connectivity once more upon attempting to create a tunnel - only this
> time (or perhaps, I was looking more closely this time?) it was when=20
> I
> was attempting to create a tunnel to a router that was not online.
> Ipconfig /renew restores the network, and sure enough, attempting to
> establish that tunnel again, when nothing is on the other side, is
> causing my networking to die the second time I attempt to establish
> the
> tunnel.  Windows seems to be forgetting about its default gateway or
> something, as I can't go anywhere outside the local subnet.

I'm sure it would be helpful to know whether it's a default
gateway problem "or something".  If you can't get the routing
tables out of Windows (about which I treasure my ignorance :-)
you could try using ping with and without domain names/dns resolution
to find out.

If it's a dns problem, and depending on what "go(ing) anywhere"
on "the local subnet" means in Windows, it could be a dns
problem.  Then see http://support.microsoft.com/kb/311218
referenced from the FAQ=20
http://openvpn.net/index.php/open-source/faq.html
(Note that this is really a dhcp Windows problem
that typically causes dns problems.)

Note that the dns problem was what your message reminded
me of.  I've not looked closely at your openvpn log
and am not familiar enough to be able to tell offhand
if it indicates any sort of problem or not.

You also might try the openvpn users list as this
could just be (as above) some sort of MS Windows bug exposed
by your particular configuration, which would be good
to post so people have a better idea of what your
doing.

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


