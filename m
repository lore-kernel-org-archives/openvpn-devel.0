Date: Fri, 16 Jan 2015 12:02:10 -0700 (MST)
From: "Dan Moulding" <dan.moulding@...2012...>
MIME-Version: 1.0
Message-ID: <1421434930.394813972@...2013...>
Subject: [Openvpn-devel] Windows TAP driver profiling
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hello all,

I have been extensively testing OpenVPN recently, for potential deployment =
with some other systems I have been developing. One thing I have noticed du=
ring this testing is that performance of Windows clients connected to a Lin=
ux server is significantly slower than the performance of Linux clients wit=
h identical configurations.

I'm suspecting that it's either the Windows network stack itself (seems a l=
ittle doubtful) or the Windows implementation of the TAP driver that is cau=
sing the poor performance. I'm hoping I can profile the TAP driver code to =
see if I can confirm the latter (and maybe contribute some optimizations if=
 it all works out).

Has anyone here ever tried profiling the Windows TAP driver code before? An=
y pointers or suggestions from someone who is familiar with the TAP driver =
would be really appreciated.

Thanks,

Dan Moulding
Software Engineer
RackWare, Inc.



