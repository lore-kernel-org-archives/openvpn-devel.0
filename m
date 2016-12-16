From: David Sommerseth <davids@...515...>
Date: Fri, 16 Dec 2016 12:09:12 +0100
Message-Id: <1481886552-27529-1-git-send-email-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH applied] Don't reopen tun if cipher
	changes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net, Steffan Karger <steffan@...1856...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

ACK.  Tested it with some additional debug instrumentation, and
it seems to work as intended.

Your patch has been applied to the master branch.

commit ec4dff3bbdcc9fedf7844701dc5aa2679d503667
Author: Steffan Karger <steffan@...1856...>
Date:   Thu Dec 15 22:46:06 2016 +0100

     Don't reopen tun if cipher changes

     Trac: #761
     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <1481838366-32335-1-git-send-email-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13579.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYU8rcAAoJEIbPlEyWcf3yS/YQAI9TARrs0yi6w/fYCvY3S/MW
Wzh4shl/L4XJe1fv2zT3uqgrfSJn81ZvRw8VFukzB8iCq/EawHb0h0kYifPGUkj8
SFGZiTKhmX2Qkp1YzWUKBOD6pRcNET3BG6q/U+ToGXoVdmflSThjYHG6Y6geAxgW
YB1exqSq6bqXEddO6O7Ttf0tSe4l7oOol8jlFqLoQ6Sbo4mojJ+r8KKql24b3XYo
/Tn12WiT+tmpDYpuTqDFfLin089uyhu6IApwFrouUnhqW1wllPr58ciPgFVEpCQl
0G0HGHmhoItyOZUv6ipL7AyzuSSsuCWDxKZFs+LzC0pYHXTYU4Cj9Ea60vfuERTb
0dEQbuTXVj6lBN0LeP4RI96urI+Vst4VHdO4eo4FLWp28vYs0XzHtqQmGd3sNnQ/
AKcxAYa76kVfEEz7Fo8O55Ef5EyCUKyTC9k6kB6Ztqn6iMd1fKyoe5IlL4QbQXw7
HBulcpNXBROlVDYG3pa+5b4AZE4Jczu7jTykdG0WtmcX0Iz7GOqTVkUrg8g+lrHB
OkFkVqNMGbGMOgqbG3HfdgkKr6mRg+hMoW77SOF9+EMYn0dlbnfJUR32iDzvDOqF
RqRBrHznzoDn8OtFFVib8lpzrD6AyJu9bp8Pxqep3wxxeMtNjHQyycNk0MksCNxF
58jSp6nfGol9d0hzEW65
=HQos
-----END PGP SIGNATURE-----

