References: <4489a66e-428f-493d-6dc9-1dde62c2c731@...2080...>
	<CAKuzo_jXCPDbsn24i4LcsqovVXGNaQuc-PtwwucnVDvwpMQgYg@...278...>
	<09fc522c-b33f-1c9b-9def-854ae3c07c62@...2080...>
	<CAKuzo_iC+gmgck4uY69k37tSMe-HAzn0uXJu7LwqxuMXP-Byxg@...278...>
	<da790cbb-c93d-cd00-0f78-96cf868115f9@...2080...>
	<CAKuzo_jD7_qZEC+GpqVTxD1QXo5GdxjF5rm9KiupqM61z8=WQw@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <9ee4d928-5907-c2c4-f0fc-4d4e842b9545@...2080...>
Date: Fri, 12 Aug 2016 21:45:27 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jD7_qZEC+GpqVTxD1QXo5GdxjF5rm9KiupqM61z8=WQw@...278...>
Subject: Re: [Openvpn-devel] autoconf/automake warnings
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/08/16 21:40, Selva Nair wrote:
> 
> When that happens we add a version check to define subdir_objects
> = "subdir-objects" and add that as we do for serial-objects. Its a
> bit premature to do that until next version of automake is out.

Aha! That makes perfect sense.  Thanks a lot!

Btw ... really good to have someone active here who have deeper
understanding how these bits works!


- -- 
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAleuJ1cACgkQDC186MBRfrpVGwCfc37jMJ0tATmaUe+yVr3a7l1B
mLgAmwbjtMxtSJj2oMD/MyPWVPQC7DDy
=0wHM
-----END PGP SIGNATURE-----

